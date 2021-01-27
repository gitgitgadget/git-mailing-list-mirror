Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86F1C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689A02074B
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhA0IJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhA0IGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:06:54 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94511C061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 23:55:26 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id h6so1280490oie.5
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 23:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEJLFkWlMW4yKSvR/Om/LMSgtc5QRFCxRTJIJCbV7xs=;
        b=u7DU/IfCvMDUAAMiJ8XX8DHsgdYAWyy2pYY/L9mhC1YHjoX+S4firqDrdwgAinGAYe
         udIR3OjQA1Jacxvb52ggLw15UoLwC2bpgw0qEHflX2nVyHy5F/jyFUqdr1xJLBExkVnJ
         dKU+AIIHwzzR20GV03LwPjYbWrCiFqfCgqWK1caFy3AmJ5Z+YMaqgaHEBcUtdDf03U3L
         ljHiGv0W7E7f83IX/0o4TjdkOULTDwDX7NABDYFgkp284gUqLAtdZoTaj4Uq/XlPzG0k
         cDOeuTqDMorHHgHaamr27yHk2/56/KBahiUl191hD9Nb5gIh8Xql0crlcCe55qN2GI2O
         kFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEJLFkWlMW4yKSvR/Om/LMSgtc5QRFCxRTJIJCbV7xs=;
        b=G0XJ8aXyFk4bWpD/2ik40Ur53Qvl0SkX4Xn2uEO4hUpDjoPgJMlRw9x+xAu2513BH/
         sT5x2XdOoT0Te7pM6TE6PA274JzDvaXC7z/KoBnInALVRWulzSsRuXxL545rXDpmXP7v
         rV8OzDeOcNWSNmYc26PXRBNDm0V35R54VVyFUIc7EYXF00TQvkhWQGH4vhv5qR8VWMMc
         oMMKhTJ0sIr0AUSIgFTwovF/d9e7yL97i7q4IhaqfD7BFZnqxRMaRFfu6y/Uyc60vmB/
         UteNfBYba4vNiWPC0xNJ0QYjhun0UBC7a7BK5Ut8DdS40nJtzRuEYsm69fJEJVIyLy1l
         oXcA==
X-Gm-Message-State: AOAM532IIrsamvZAxT4N/CtnWW7YxJbaBA0etFCcAmvQMoayPEyNOWJA
        eH+p8p5Y5PoIQ34RHz1Ez0pCIjM8ni6IU+2CDDM=
X-Google-Smtp-Source: ABdhPJzzhk1fSoXwSf/6CkI9RzKDJW0PkQlrlgNMZPbHKT1PzbzjN5RikuAQx6t+XPB8rhPBG6C4qr9wlzmGNnKTp6k=
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr2292372oic.163.1611734126013;
 Tue, 26 Jan 2021 23:55:26 -0800 (PST)
MIME-Version: 1.0
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
 <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
In-Reply-To: <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 27 Jan 2021 13:25:14 +0530
Message-ID: <CAPSFM5d79AEx478twqrLpUuhq1+mF_bvOsfyvRuQVgQO167DrA@mail.gmail.com>
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
To:     Mike McLean <stixmclean@googlemail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, j6t@kdbg.org,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 24 Dec 2020 at 04:42, Mike McLean <stixmclean@googlemail.com> wrote:
[...]
> =-=-=-=-=-=-=-=
>
> During an interactive rebase, the text file defining the operations
> has a command option for "fixup".
> This will squash the target commit into the previous commit (listed
> above it in the file), and automatically use the commit message of the
> previous commit (thus bypassing the "choose the commit message"
> dialog/file).
>
> Can we have a similar convenience-command that squashes, and retains
> the second commit's message? Purpose is the same as the fixup command
> - saving a bit of time and unnecessary typing during a common
> operation.
>

It seems that this FR is addressed by the patches as here[1], which are
under review. It adds the options to fixup command i.e fixup [-C|-c] in the
interactive rebase that gives the flexibility to select or edit the
commit message
while fixing up the commit using fixup command. So, changing `pick` command
to `fixup -C` will fixup the content and replace the previous commit
message with
the second commit message(ie. the fixup commit message).

Thanks and Regards,
Charvi

[1] https://lore.kernel.org/git/20210124170405.30583-1-charvi077@gmail.com/
