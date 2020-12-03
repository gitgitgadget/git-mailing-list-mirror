Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C539C64E7A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B3C206CB
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 12:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgLCMcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLCMcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 07:32:12 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74EC061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 04:31:32 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id y24so1560614otk.3
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t/NFMww33OB4WzwItpDbnNoFSE28tlBe+FJkDu2e67g=;
        b=BzbvvTmaK1YZKrhF5EI+a2KmubYByrrE0I7YTYwrJlNHyxGIw9T4WJicXORLohTKbV
         O4zkhUcZ3y2aSKH8+uEYhIEacWpcz96vVEiI9+xNxH93OcWE8BNn8wPs4PwDd8pSOpKE
         0ACxvhdDzCugMvN0q9iUR3oPtHpa0RYdoxaITiWaWH2MgX/G5yaeORlywWBrCCURNsqd
         r+LYMvTepAOZIL2vyC3vip8Gq1j36Wa55Dj0kSD5kL1ALrzJoIDYLA72XaS1Y931xZXA
         TdTAjBKSDCejFzgvVdUmPlYnVQ1Oi8VG7RcDI/lLhfsXDXoP5R6ObxenROXrKOeM+y62
         cysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/NFMww33OB4WzwItpDbnNoFSE28tlBe+FJkDu2e67g=;
        b=TAm6eAKswzeap2XYS5YWRFZQAg8Gkc/dSFmDCPoIEeLXUGsFDbcpCly9Ot+i7fn0O6
         NhyNRzJ6F8Nta2D9Rc2UPepAiMeshJpFJyN+9CjQ7wBO3TlOGhmpeqsnIl9uNx0Forz3
         0ojmRsgjx9o7RNckBQyNTN02eFkzzqVeUMJmB8+v95Ba+/AQSkXcIpYDpEKBW0M7mqSX
         Zxz1Y48v9wcCkrbAMK0WHuMXaCQ6D85QtxSf+bgvHHxZBC2j2PVjMsfpcLBSybJO6ewb
         I9C5T0uayQV2GDJNdI5vbjW74+cu/S9g+frQPoP+DFFNqK4DUBW696lLbOACE7N/UGse
         4aXA==
X-Gm-Message-State: AOAM532CZhrAQUhwls8YfBNwow4ysESwkiVlFkVHwfhkrQ3JasSMektr
        A0etFqGLNKmyPTW+Dcx8t6EXVGTqGaCAcgg6Ut8=
X-Google-Smtp-Source: ABdhPJyCM7o/JUiHf/XK0qGR77d41azBTZeSzVaAEwIw1LMKhZ5VK5xRNESDRxFKvnYIH+T3WqONBPkBPBP7aN1X9sU=
X-Received: by 2002:a9d:3a76:: with SMTP id j109mr1861057otc.186.1606998691962;
 Thu, 03 Dec 2020 04:31:31 -0800 (PST)
MIME-Version: 1.0
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com> <CAN0XMOKEG9HLuzf9ZRXyUs_uHTXagyCdghtP98rLVoPj_75UYQ@mail.gmail.com>
 <034d340f-ae62-2c22-3c6c-c9b14e0de662@nokia.com> <CAN0XMOLHM0mFvXcdiXJS_yD59rSTuyJpp9N9MLvcZ5LCC1-yZA@mail.gmail.com>
 <168be31c-f913-4bda-cf05-adcc07c51ec8@nokia.com>
In-Reply-To: <168be31c-f913-4bda-cf05-adcc07c51ec8@nokia.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Thu, 3 Dec 2020 13:30:56 +0100
Message-ID: <CAN0XMOLdz3bk+wehy-+0_XGLX6722jb71vvzNPXrryeeFuxd0w@mail.gmail.com>
Subject: Re: BUG in fetching non-checked out submodule
To:     =?UTF-8?Q?Peter_K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

Am Do., 3. Dez. 2020 um 10:43 Uhr schrieb Peter K=C3=A4stle
<peter.kaestle@nokia.com>:
> >
> > The test suite passes.
>
> This is what I experienced.  Thus it is important to get your case into
> the test suite.  Could you please send us a command sequence how to
> create your repository structure from scratch, so that a test case can
> be created?  - Of course, if you want, you can also create a test case
> on your own.
>

It can be reproduced with the following sequence of commands:

git init sub
cd sub
touch file
git add file
git commit -m "add file"
cd ..
git init main
cd main
git submodule add ../sub
git submodule init
git submodule update --checkout
git submodule deinit -f sub/
git fetch --recurse-submodules

Ralf
