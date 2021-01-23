Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8737DC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 05:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419C023AC2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 05:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbhAWFMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 00:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbhAWFMe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 00:12:34 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E8C0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 21:11:53 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k193so7389377qke.6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 21:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lRcN6dTeIgxeWUXPsdg2HVt4GwFzGGTl8dbixVKYG8c=;
        b=WbZSzdmWifmuSkvEwENq8s5X4BeLSMgIWrRgIujXAGuyYMI8WoYKoMFIoXxB6A4xBG
         ngls8WjGrJi7G5OKIkMwtDLWS3Fc3Cz44MaI98GJftpjtJOrr7nW4n0DoAp0LzpAqxaY
         qz/Qw+LlgX6E6HaJD2gmmhaIlg12/2M3Qu+uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=lRcN6dTeIgxeWUXPsdg2HVt4GwFzGGTl8dbixVKYG8c=;
        b=Qs4jdikUOnVOiZHJo6IslWoBZFPIF/nJhaHCzZl/y5fLEIbDL2OXUz/FLxmUKm7Hh6
         FhzUwF22eHgA8EmhZmweuTB1nuhq4y2gqARiIKp1U2MbMm7ucprMSeFWg7Xo5cvWd8+A
         raBJu1NDT5l2TwtxUsn5Y9Nar2UqFrQHLxFK1MWduW0/nWmHI21pU0zzpenEYmmWIngA
         jEw3ei7IBLKsAyMLdBi0kbdfILlX9dmNK480DEJBZ9tVU93Oyc3V1GY0cEi0Gkb2A/EX
         LadjXUOVYUtLLRppGZssBDfqEQ+Ckg22/tcUrbllc5OuhaTcu2fmdrsIr/PfM21BSfsK
         sbsQ==
X-Gm-Message-State: AOAM530OW9EOfjRB8VdXOprh+MZDQ3DeS7IDhWDitJkfWpDXhcMBNREZ
        kms7AERoP3i9ilauanL3SHhRBQ==
X-Google-Smtp-Source: ABdhPJyNRe4ub1cP1OG4c/3fF8IhT3+orJ96Kck3zkTouR0ax3pp360L9klZ9h59A6JnwcVBvdDrdA==
X-Received: by 2002:a37:4796:: with SMTP id u144mr7742165qka.235.1611378712481;
        Fri, 22 Jan 2021 21:11:52 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id b78sm7778428qkg.29.2021.01.22.21.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 21:11:51 -0800 (PST)
Date:   Sat, 23 Jan 2021 00:11:49 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: git archive setting user and group
Message-ID: <20210123051149.vkeskbuod2twq4xu@chatter.i7.local>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
 <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
 <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
 <YAt2PPM4HRcKva9a@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAt2PPM4HRcKva9a@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 01:05:00AM +0000, brian m. carlson wrote:
> > Right now, "git archive" operations are bit-for-bit identical across all
> > versions going back at least 8+ years. In fact, we've been relying on this to
> > support bundling tarball signatures with git tags themselves (via git notes).
> > E.g. you can see this in action here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tag/?h=v5.10.9
> > 
> > If you click on "(sig)", you will download a signature that can be used to
> > verify the tarball generated using "git archive".
> 
> Please do not rely on this behavior.  I want to state in the strongest
> possible terms that this is not guaranteed behavior and it may change at
> any time.  We have explicitly said so on the list multiple times.  If
> you need reproducible archives, you need to add a tool to canonicalize
> them in a suitable format and not rely on Git to never change things.

It doesn't need to be perpetually the same. This is the reason the comments
mention git version -- "to generate an archive that matches this signature,
run this command (with this git version)." I know there is no guarantee that
this won't ever change across versions, but I don't see why we can't expect
git-archive to return the same bit-for-bit output when using the same version
of git. Adding --owner and --group would potentially change that, especially
if that's something settable via git-config.

> If you are relying on this behavior right now, I urge you to change that
> at your earliest possible convenience.  I don't want to break
> kernel.org's infrastructure again, but I'm also not going to tiptoe
> around sending patches in fear of that, nor feel bad if it happens again
> for this reason.

It won't break, it will just inconvenience folks who are using this perk --
Greg KH will just have to use the same git version that we have on the server
when he generates the signatures. This has happened before.

-K
