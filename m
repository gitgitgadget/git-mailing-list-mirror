Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE38C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 19:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F3A215A4
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 19:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLCoBSXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDXTuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXTuj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 15:50:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC1C09B048
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 12:50:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m67so11407820qke.12
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zO21FW13tiSZrN/lpuJnPGcBa9kc1CWj8UW943ZIDyA=;
        b=FLCoBSXqTglQsNKPTufAltU761rQXYnqzSfAxGz9jNlvUWkLKbz6ny0a9RcRXn5EHe
         pzDPeNJBVtCJkaamgqRXt8dwC6pIBH5IrP6UJSIN61XyjZA2XT5LWh4GSFqWVLBgtrRY
         oqyoMgyLAyBZwiLHE/RdaRNDu9QZ5xANt+tBRLtEIzTWJeSU7pkwqkimV4//SYYKuLrE
         zo2oc/Fh8LAY8EUOHRfmykrf5KYrc46xlOyd0AR/yoanivouexk7/zOEssfBCNqTIzIj
         opz0IneyG9FY3mqBOtSgwxGMU9Igx/wZCBY+DrB/gj8pE5TYtbVfTJLm438pjkPcj9Ln
         E6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zO21FW13tiSZrN/lpuJnPGcBa9kc1CWj8UW943ZIDyA=;
        b=SSr3G0GbJDYZ4KVAt0S0il/gIeHnbR6LFQUWl6dmMYAAAiUP9PFPv6QeeSDibfrvRx
         fDtniR8mrKuf9IRAa//udQQKsYj2nHDe4PmRoxeZXmBdkynKnoi47UVd+pwnARBXGPgK
         NPJgLbvBguiiVTc670RgHqt8Z6xsMKtkTqgci0Exvz1rpPcZbw212AXS+RmOL4lHNn8r
         WP2iXuqS4+Ymk4vSqJxyJCb6vrACN1wcssSk2oglyrMsKVLSqLiP8zXNjC4i6tzeTP+c
         EwmCPnAJ4hJqORleDCetm2bG9G6OB+J8h7POq7KS/1QExwT7S51lGvLnzY9VmLZAMV7k
         AEjQ==
X-Gm-Message-State: AGi0PuZRd5k2jIU9qnMEG2MCi3uTOudyEAgQFiIMPjhO8Ty0mZ318GUI
        C8dYiPPhyU/WyrFTLs/hHDeJWpw4TAHDeXeb6RmokdB0
X-Google-Smtp-Source: APiQypKiPlsLq35d+q6RfFu3zKZPFPM4yMvCsUXg0a66c9Z8qKSyXVpzUtNi/wIt9xJSKFYQ/m4YTdAEfD2BMUZKVY0=
X-Received: by 2002:a37:787:: with SMTP id 129mr10571772qkh.92.1587757838894;
 Fri, 24 Apr 2020 12:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <xmqqv9lod85m.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9lod85m.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 01:20:27 +0530
Message-ID: <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 12:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This is an attempt to build Git using CMake.
>
> What is your longer-term plan on this one?  Would the ultimate goal
> be
>
>  (1) to maintain both CMake and Makefile and keep them in sync?
>
>  (2) force all the Git developers (not users or binary packagers)
>      start using cmake and abandon Makefile, and let CMake generate
>      Makefile?
>
>  (3) something else?
>
> Given that bootstrapping CMake typically takes a working "make", by
> definition, if you drop Makefile from our shipped source tree, the
> audience you can support on minority platforms would be smaller than
> what we have.  It is not negotiable that we keep Makefile as a valid
> way to build Git, and the Makefile must be tweakable for those on a
> minority platforms when things do not go the way they want to (the
> tweakability is most needed on minority/exotic platforms).
>
> W ith either (1) or (2) above, I have a feeling that engineering
> burden to divert resources to add cmake support (with sustainable
> plan to keep "fixable/tweakable" Makefile that is in sync) alone
> would already be high enough.  It is unclear the reason why we want
> to pay all that cost---to gain what?  Other than to make those who
> like CMake feel happier, that is.
>
> I do not want to sound overly negative in my first response, but you
> might thank whoever says "no" early before you invest too much time
> on this topic, so I'll send the above before even reading these 8
> patches.
>
> Thanks for your interest in the project.
>

Hi Junio,

The goal would be to maintain a CMake build for Git keeping it in sync
with the Makefile.
The Makefile is not going to be replaced at all. The CMake script for
now only supports Linux and Windows.
It does not support BSD, Solaris and others, whereas the Makefile does
support them.

The reason for introducing CMake is primarily for compiling git on
Windows and to do out of source builds.
I think the CMake script makes it easier to build Git as it does the
necessary function and header checks and generates the
required compile definitions.

I would like to say that the proposed CMake build system is meant to
complement the currently used Makefile, not to replace it at all.

Thank You,
Sibi Siddharthan

PS: Sorry for the multiple emails:)
