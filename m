Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B41C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C130E613AB
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhDTBsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 21:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhDTBsA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 21:48:00 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF4BC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 18:47:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k25so36906544iob.6
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 18:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=clpBqlGeH9EC5QCvBwS3B28Mp3Wfc3EO7MGZNjpp+4s=;
        b=TogkzlpGwnJQldGIduGVoS3wf4kdKr2xhJBNPONeVFqk34tPTQ5cu4DZcAH5XEGp4R
         vsW6A04f+2Kn0115VEESsTzjku0zsrGk8o/GgXDMJ3X2ITf1JWH8xWofnPd9tFj4RziB
         tDNv9aOGuO3bemduCKfsGbMvp9qyNLDWTrvZ+A+ZzclAXA2cB0iLoS8S/SL+4bmL6HiG
         WDjIlsC2ThLEzOm5ldR/28tn6SvhNzlV8NcFvAQBxR8FxUWgc/kpoY/06HdVHnPQaeWV
         HFE+eFfn1UPJSHvOBM2C073XcIxb910Hn+9fKJ8FcfAfGZawPY2jOjQGYSqrDb+750jG
         Inbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=clpBqlGeH9EC5QCvBwS3B28Mp3Wfc3EO7MGZNjpp+4s=;
        b=cl8IwFD880gOuEK2qL+RoXTXedMD5rqk8JxLFXiuV8EoYOMn4i7274i1soe8yeVUl+
         aqQQbYI1hIvtVOsz65m0eQ7EJK1FNAJvwR0l696RF4A9ujfjbA+3cyb0T/BPNO5QvxiW
         hCERUQXm2ouiPTzawPIhW3CUeK98kCfKdQpRLf0Ry+ENeTHpbATXdGZCDCzaQu1jPN7O
         a45jnPq9Wr4/gcDtc6lw6MKk6jiqDYV92rVP9oJuDkgluGXe+RmmN6flFshFj86l0gsA
         ub+6HXI4upnM3v7dW8++YkzJmnpjPXO+nOGr1G/Tfv6BhFMTqZB5F5LojR7CvH5t+tkN
         WPiw==
X-Gm-Message-State: AOAM532+fWMUhlJ+CkxzvkuE7H78u6jIu9zYD0B5OHPlefFtFKwkUcm7
        eMEiGKbXsYPEs8tT9rX7/DBHRKpvi+RUke/2
X-Google-Smtp-Source: ABdhPJzppAb0LfegBfHLp++tYRKQVPfgnndGBOtWG37Vf7X3MOL9QhiXVGj4mbJVdd+Dofg4NmQy7A==
X-Received: by 2002:a05:6638:bcb:: with SMTP id g11mr5626942jad.144.1618883248210;
        Mon, 19 Apr 2021 18:47:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:6e34:2cc5:33ff:681d])
        by smtp.gmail.com with ESMTPSA id h8sm7791090ils.35.2021.04.19.18.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 18:47:27 -0700 (PDT)
Date:   Mon, 19 Apr 2021 21:47:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH] builtin/repack.c: set a default factor for '--geometric'
Message-ID: <1ecab817396fae6a1cbafde1ca8b3ebfd9ae4c11.1618883241.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--geometric=<n>' argument specifies that each pack must contain at
least 'n' times as many objects as the size of the next-largest pack.
The factor 'n' is customizable, but setting it to '2' is a sane default.

Instead of making the factor a required argument, make the argument
optional with a default value of '2'.

To ensure that the option is setup correctly, modify the most complex
test of t7703 to drop the explicit factor.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt | 8 ++++----
 builtin/repack.c             | 5 +++--
 t/t7703-repack-geometric.sh  | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 317d63cf0d..d948a2913d 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -165,11 +165,11 @@ depth is 4095.
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
--g=<factor>::
---geometric=<factor>::
+-g=[<factor>]::
+--geometric[=<factor>]::
 	Arrange resulting pack structure so that each successive pack
-	contains at least `<factor>` times the number of objects as the
-	next-largest pack.
+	contains at least `<factor>` (`2` if unspecified) times the
+	number of objects as the next-largest pack.
 +
 `git repack` ensures this by determining a "cut" of packfiles that need
 to be repacked into one in order to ensure a geometric progression. It
diff --git a/builtin/repack.c b/builtin/repack.c
index 2847fdfbab..f2359c9d3a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -494,8 +494,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
-		OPT_INTEGER('g', "geometric", &geometric_factor,
-			    N_("find a geometric progression with factor <N>")),
+		{ OPTION_INTEGER, 'g', "geometric", &geometric_factor, N_("n"),
+				N_("find a geometric progression with factor <n>"),
+				PARSE_OPT_OPTARG, NULL, 2 },
 		OPT_END()
 	};
 
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 5ccaa440e0..77cd5f2284 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -123,7 +123,7 @@ test_expect_success '--geometric with small- and large-pack rollup' '
 
 		find $objdir/pack -name "*.pack" | sort >before &&
 
-		git repack --geometric 2 -d &&
+		git repack --geometric -d &&
 
 		find $objdir/pack -name "*.pack" | sort >after &&
 		comm -12 before after >untouched &&
-- 
2.31.1.163.ga65ce7f831
