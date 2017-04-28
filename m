Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3F6207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 22:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997423AbdD1W4Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 18:56:25 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35721 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425924AbdD1W4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 18:56:24 -0400
Received: by mail-pg0-f54.google.com with SMTP id o3so15939920pgn.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J0nC6qpluFD/q8ds3ZxMenj0Xwd/iJI33qJSX6Jtags=;
        b=mzrPW1Z4Xogn9N8ecimtAAcJzPU7rTy5+Vixc5lNDE3ESqJGw0PlRCAj/I+Hc5v6OK
         u4rnp5jwJkIh+aglwh+GYF8gmSKPLFAEOrrdm2M2ajg9QkY9JYeDxU4F3m6N8wr2MZXF
         I6WSpvB4rEJ4picqQ38puR8MD00QjHxTobTWcw9brCOwjbmpPbR9byuX0Vo+af0BYIMQ
         CPQpqUiKthl7t9OCLi9aidWJvLBu5JI8IVySMI10Hp8I44AYUA+Jh4N03LZBJn/EXf4a
         YPLsmGWwTDMz5q8a0JeMn5YslhM41bLCLzM7uk9Cb5dpKPJSwCWOAMpTwgQd204rfzsV
         wMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J0nC6qpluFD/q8ds3ZxMenj0Xwd/iJI33qJSX6Jtags=;
        b=ToR2+wm/dXzj95Tp8ltahBiEmd+5oHW0kWHBjtcjZtwaiTCM5o+wYq+23f8WaPYXZF
         h8kAq1xh2tSzks5PLhw7hDmiiHajaEYiEz61/WrDR9+UuI3sq1nRsX28HWwNQmx7gYKy
         qRHx+WiGD8dQ4Fui1KEmaVOCXJgxHbXEYpFZQqdHlslikgTjr5qYRIinEUEoA8uUw9jI
         1kI3izZKV7lR4/lOAt+9gAzmvtF1FrX99Fo8ub6MWJWY511r3JcgpqWPrw4YYYORsdk/
         PGfpj4Ka5xqEUP/d8XC/AhIEOcADnBt9jAo0rpYN+WxXiFhflvKwcYCP6lpuvcsC9H5w
         7FMw==
X-Gm-Message-State: AN3rC/44agZMhlRcsf1WDErGIZ0b+zlF8Tl5EZtIhd2vjm9qQtoQS71Y
        SeYLguK6KXccCYcURlhlEBYGh2q4LOpTOHY=
X-Received: by 10.84.237.8 with SMTP id s8mr18223909plk.163.1493420183399;
 Fri, 28 Apr 2017 15:56:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.176.161 with HTTP; Fri, 28 Apr 2017 15:56:02 -0700 (PDT)
From:   Chris Johnson <chrisjohnson0@gmail.com>
Date:   Fri, 28 Apr 2017 18:56:02 -0400
Message-ID: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
Subject: Bug Report: .gitignore behavior is not matching in git clean and git status
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am a mailing list noob so I=E2=80=99m sorry if this is the wrong format o=
r
the wrong please.

Here=E2=80=99s the setup for the bug (I will call it a bug but I half expec=
t
somebody to tell me I=E2=80=99m an idiot):

git init
echo "/A/B/" > .gitignore
git add .gitignore && git commit -m 'Add ignore'
mkdir -p A/B
touch A/B/C
git status
git clean -dn

(my client may have screwed up the quotes, please bear with me)

Now, this may just be a case of me misunderstanding the behavior of
.gitignore, and that=E2=80=99s fine, but to me, git clean -dn should roughl=
y
reflect the same behavior as git status as far as ignored files go. As
it is, git status does NOT report A/B/C as an untracked file, but git
clean will remove the entire A dir. It seems to me that one or the
other=E2=80=99s behavior ought to be tweaked. Which one is correct I am not
sure.

This happens on 2.5.1 as well as 2.9.2

Chris
