Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3FC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F2A20866
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEKSSGeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfKYO0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:26:55 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40074 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfKYO0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:26:55 -0500
Received: by mail-ot1-f43.google.com with SMTP id m15so12719785otq.7
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1o33RBCJ+JYHyXPWUoeV0kI07kEloxCdFz2rD91T19c=;
        b=OEKSSGeWOris7nWz9GayqNDdxIGh4rsV+SolVJXPA4tq+2xsv+O8YVOpjkSKqt4MHN
         wUc0mVRHLN1SBC8mfqCeE7JVn5rrGP2PmizPEehqU0p0YlNpyRWF86Smz7GPE3iBp/jU
         MP1Hwdnm2eB9p2OBrxr+3KQC2k6mFcfZFPxIlOHInbYvC3cd+XwqzTcEvY+kz9tReNJo
         5jn6BRDFQPyVHIxks2H5Zmg2SfBnigDV8VKbrziPbmRa+UuaoIfgLJk+XrD7dGlmtYDs
         mdBPm2736u+29TDo2AwhBlRNl0FIbvhWbeb4/gx6zFYBMPkjaifRlz1VaPrpAU56TwPn
         b5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1o33RBCJ+JYHyXPWUoeV0kI07kEloxCdFz2rD91T19c=;
        b=rQXDSv5c5UU95Cc4BpwoWhxTYO+6VOmsjX4W8SVeqjty+cCUAW0YjixxcWTGNLho39
         pMwOZEtZRtjeyVqiquFa3KGZwONDmffoBuub+fvGrMeymQ/ac2CFntYm+p8dYg0JP6cR
         KebPMOzOAb3oXzpvr9GvzLPrkLO6IcxSws5jq8SpmnjVcNa8G6J9f+TkhO41mAE8v3v1
         /BNDcpW8YSg80diGzt6VrBzvB82f9zfn+R5+9QQHO3wsUIqbDZYEY9rp+HHv6hM7Ta3t
         OCPzBFxEGfBvET9faZwhbJHZ4tzAZAwI1LqpCcjhCZfNforbLdT1oAZ6h2AzvELu5OUv
         m+rw==
X-Gm-Message-State: APjAAAU2OBOtKSKfmWeUdI2YyrnRJTaK0U3W93dDxFeYES19Uzr3vBKN
        f8/PNjWqOL0JWh/IbozWrSa6H1tu5nJ5/cBOc0o=
X-Google-Smtp-Source: APXvYqzu8NW62kHmp34wd79yEaARxRybASw4v5oNpDBF9iMAtt/nIlMcc+7QF7jKV5X7lLPyp1IjH26CdVvfAMqOsGo=
X-Received: by 2002:a9d:7384:: with SMTP id j4mr10436611otk.94.1574692013337;
 Mon, 25 Nov 2019 06:26:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxWhYEMWCPgPp7qX9S_i0-CtS6OBj2TdCVXsyromnwVawQ@mail.gmail.com>
 <5ddbd7b7.1c69fb81.dbdb8.eb94.GMR@mx.google.com> <CAHMHMxW2TN9OVeEZ0rKWEsyLo3kkuQOcYxMzd0Ybn0Bit1mk=g@mail.gmail.com>
 <20191125140550.GA23860@danh.dev>
In-Reply-To: <20191125140550.GA23860@danh.dev>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Mon, 25 Nov 2019 16:26:17 +0200
Message-ID: <CAHMHMxU45nWXGAmiSsSPGhuAA6euhqGVvKwCqY7_rKvhKC6MFA@mail.gmail.com>
Subject: Re: rebase comment char (was: Delivery Status Notification (Failure))
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Danh,

Apologies for the confusion. I had tried the issue a couple of times
with my main repository, before reporting the error.
At first I thought it was a problem with my repository - but it turns
out it probably was a misconfiguration issue on my part.

You can ignore this report.

=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82

On Mon, 25 Nov 2019 at 16:06, Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2019-11-25 15:36:13+0200, =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =
=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 <stdedos@gmail.com> wrote:
> > If I do
> > git config core.commentChar %
> >
> > then, during a rebase operation, squash/fixup comments do not honor
> > the core.commentChar setting
>
> Can you give an example?
> I couldn't reproduce with both git 2.24.0 and the current development ver=
sion.
>
> --
> Danh
