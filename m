Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11855C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 02:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiGYCMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 22:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGYCMv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 22:12:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B1E0EF
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 19:12:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h132so9083976pgc.10
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 19:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h9MTm9ZZJV1sY1MJFG0fAor7hoIuGLCWQh0Y+hh0r84=;
        b=bs3RFLurCAsE6YSoNRsVBY26OmA0eWBYq6o8CMsW+SMMYNxxLjBA/vl4L5xBlA8+7T
         wIi9zildR+U6BkQ3kl+s+OoOGP3QuBf79mJOTTF15ZzFcuMRRe0mShV0WxqNQL5YF4Or
         ZsDZfGun9V/5IqcRUOYIE/yMKnKYL0LdqY2erTSKsOPvre/JLaMT4yROAomQ+ecaXcJN
         v/l3YRykMT+uoSQQGX7+XO17fh8EaJMeyxUrVwtI4WMTSoenVLeRxTuLJXMYXPXKUFsc
         dia1jKFWYl5RZfnSHzYXT9bvZ7L2ZRRk6CyYVQhbb2RIx7fDOTfOTlziKpZBgSbzLzuo
         iESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9MTm9ZZJV1sY1MJFG0fAor7hoIuGLCWQh0Y+hh0r84=;
        b=1kOHs8bawj0dgSEe8tHgI7OpA0JIJ5Sc5eHWjz4yKzI8WmRZq9F960mBsM2gDNzYY5
         cmz98abMrQOpn+pQWTo8IBgt4TlMqS9EekbmsdzHlc4oNSax491T0jjHdR8be69Et0Hs
         uwrZU19wJQga5bYVBoIKvsnopzdgb+IYlIhWcATfhDRU7BNC6YWjyXmouQPSkZK+KMpT
         tnApwl3mZBk2iWxJRFlgXo2Lx2lZQ9W4dcWGeY6a2D3Da/q+Lk7TYG+lx8LRR+29rNwM
         4igQe2H48NgAAW8yRRC8y+dLwYMIK01YPoLZpGSm0JAM8fsrVU5th8Du4V77GfBDxdyj
         uzCw==
X-Gm-Message-State: AJIora/jMhfs1UdCERqfEUgVGEkXlt+ihdxzqp7Jw8yFUko/tyRmvCII
        pjOGIk+XIEh6PXxOSqMHAQTGiGrjlMc=
X-Google-Smtp-Source: AGRyM1uOQPOHbqUKhOMUWIhNGbSbz3rSaMxTTxs2dxlbBk3/DKKYipRwAPQ/YEJhm8hrnRtRAF1H8A==
X-Received: by 2002:a63:8849:0:b0:419:a6f3:ba34 with SMTP id l70-20020a638849000000b00419a6f3ba34mr9066269pgd.368.1658715169736;
        Sun, 24 Jul 2022 19:12:49 -0700 (PDT)
Received: from jrouhaud ([49.216.28.78])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b0016be368fb30sm3443700plg.212.2022.07.24.19.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 19:12:49 -0700 (PDT)
Date:   Mon, 25 Jul 2022 10:12:43 +0800
From:   Julien Rouhaud <rjuju123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: improve title shortening heuristics
Message-ID: <20220725020534.x33hso22ab2dwyo7@jrouhaud>
References: <20220724061231.jddhqns7bqx5c2xm@jrouhaud>
 <xmqqfsiq6ksb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="l5mjcsqvjmg7kjcs"
Content-Disposition: inline
In-Reply-To: <xmqqfsiq6ksb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l5mjcsqvjmg7kjcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 24, 2022 at 06:30:44PM -0700, Junio C Hamano wrote:
> Julien Rouhaud <rjuju123@gmail.com> writes:
>
> > Otherwise, would it be acceptable to disable the whole block (the "remove
> > leading stuff of merges to make the interesting part visible") with some new
> > configuration option?
>
> I personally find that "shortening" logic way too specific to the
> kernel project hosted at kernel.org and would be inappropriate to
> use it anywhere else.
>
> 	if (length($title) > 50) {
> 		$title =~ s/^Automatic //;
> 		$title =~ s/^merge (of|with) /Merge ... /i;
> 		if (length($title) > 50) {
> 			$title =~ s/(http|rsync):\/\///;
> 		}
> 		if (length($title) > 50) {
> 			$title =~ s/(master|www|rsync)\.//;
> 		}
> 		if (length($title) > 50) {
> 			$title =~ s/kernel.org:?//;
> 		}
> 		if (length($title) > 50) {
> 			$title =~ s/\/pub\/scm//;
> 		}
> 	}
> 	$co{'title_short'} = chop_str($title, 50, 5);

That's probably true, although some parts (like the protocol) seemed general
enough to me to be worth considering for general use case, and some of the
really specific parts seems so specific that they shouldn't really matter if
used outside kernel.org.
>
> Of course, http:// and rsync:// are way outdated (https://, ssh://
> and git:// are probably reasonable).  Equally outdated is to merge
> branches from master.kernel.org, www.kernel.org, or rsync.kernel.org
> (many merges are recorded as pulling from git://git.kernel.org/ or
> https://git.kernel.org/ these days).
>
> Even worse, I somehow thought that kernel.org no longer uses gitweb
> but uses something else.  So I suspect that nobody sheds tears if we
> remove the whole block unconditionally.  In fact, it would make the
> world a better place.

Well, I'm obviously totally fine with getting rid of it.  FWIW, even the
protocol part wouldn't change anything for the instance hosted by postgres.

I'm attaching an updated v2 patch that removes all that logic and just keeps
the title_short chopped at 50 chars.

--l5mjcsqvjmg7kjcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="v2-0001-gitweb-Remove-title_short-shortening-heuristics.patch"

From ea4f31c0a2276f042322a11e258e55223863cd35 Mon Sep 17 00:00:00 2001
From: Julien Rouhaud <julien.rouhaud@free.fr>
Date: Sun, 24 Jul 2022 13:17:19 +0800
Subject: [PATCH v2] gitweb: Remove title_short shortening heuristics

Those heuristics are way outdated and too general to be useful outside of
kernel.org.  Since kernel.org doesn't use gitweb anymore and at least one
project complained about incorrect behavior, entirely remove them.

Signed-off-by: Julien Rouhaud <julien.rouhaud@free.fr>
---
 gitweb/gitweb.perl | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1835487ab2..e66eb3d9ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3560,23 +3560,6 @@ sub parse_commit_text {
 		$title =~ s/^    //;
 		if ($title ne "") {
 			$co{'title'} = chop_str($title, 80, 5);
-			# remove leading stuff of merges to make the interesting part visible
-			if (length($title) > 50) {
-				$title =~ s/^Automatic //;
-				$title =~ s/^merge (of|with) /Merge ... /i;
-				if (length($title) > 50) {
-					$title =~ s/(http|rsync):\/\///;
-				}
-				if (length($title) > 50) {
-					$title =~ s/(master|www|rsync)\.//;
-				}
-				if (length($title) > 50) {
-					$title =~ s/kernel.org:?//;
-				}
-				if (length($title) > 50) {
-					$title =~ s/\/pub\/scm//;
-				}
-			}
 			$co{'title_short'} = chop_str($title, 50, 5);
 			last;
 		}
-- 
2.37.0


--l5mjcsqvjmg7kjcs--
