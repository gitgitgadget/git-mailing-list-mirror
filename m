Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF786FA3742
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiJXUe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiJXUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:34:02 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E618B2FD
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:44:56 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id o65so8486460iof.4
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YrgxEGKeBuj3GypGtTRliNnBQ2QnIM7SpuB885mI8k=;
        b=6TnORhzy+q84xbCre8I1c5tdWGITYwWwNhMEhcBdiTKmn7JKKpsp+B/5fA804TYAmS
         foczeFuW54UAeHxXjMgNdu1BGDFiI2FLC4CC/F0R8hlrWa9T9b/u+ocQ89t7Nhrrvwt5
         P7KHTNKenGCk+CZnoXWPGgY57aG2mbLoh3vx9duInVl80lV39z7TB0zCFbapSv6Hwrnc
         UQy7gXxe90fF3MAawVlpoyn7BcbLGd+LIJ1L5u0tkFelePoSTfWYoImdz3+6x3MoBNSM
         jDGj96Fa7zjFd/1SlShwCZ2XwrNKVkPVk2P44e87avtYKmRmLmezMmGm0vx4t4zQQFPN
         8oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YrgxEGKeBuj3GypGtTRliNnBQ2QnIM7SpuB885mI8k=;
        b=LVKLigVG2LasgdPalg8RgV59duDqXuD+bQGRL1ioouA/fZLgMUbwdTWHRfVt/4MmMt
         4WgWdNUhZQ5MdvQSwuOe+eiBjngid4iQcF2MquPXjnNHL4obn5VKpT1xo/GbyXP13mF3
         /FAkG/DuvdR/ZBnLX+7flEgUngIRvvluTHBSqNJmCPSRkxNnpMUv4wVppGCNkw2sGIHw
         GNIS6ZDQpbBnRsEVOcEIspf+NRjg/PqDxlA53InqWK9MGeTxly6apcmODUBtq+2s1xqy
         ZzULI4O3M+d38vEz6z7u8Ls10oqwtfn/ynRzGLyCk0Zb0rkvrXw+snxd3/Kf4v3TYB60
         Diew==
X-Gm-Message-State: ACrzQf0hey45hmUlOsBAeho1NaeIZ81eRtKYMEtSG0gYe0P6+ScZLuSd
        kXzU57KAGEYqNYw0VRpwwfH+l/beVO3MvxVp
X-Google-Smtp-Source: AMsMyM5pFLrRjMWnih8r0mv7yJsIocPXC32u5z9Wc/8C5gGjOJbqn+zroePXL9tz0mRly9O0X1zPaA==
X-Received: by 2002:a05:6602:134f:b0:6a4:cd04:7842 with SMTP id i15-20020a056602134f00b006a4cd047842mr21605445iov.172.1666636990963;
        Mon, 24 Oct 2022 11:43:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 2-20020a056e0220c200b002ffa449535asm216572ilq.74.2022.10.24.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:43:10 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:43:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 3/4] builtin/repack.c: write cruft packs to arbitrary
 locations
Message-ID: <c0f4ec92a057fdab905447bb917ff09e9bcaaab3.1666636974.git.me@ttaylorr.com>
References: <cover.1666636974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666636974.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the following commit, a new write_cruft_pack() caller will be added
which wants to write a cruft pack to an arbitrary location. Prepare for
this by adding a parameter which controls the destination of the cruft
pack.

For now, provide "packtmp" so that this commit does not change any
behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1184e8c257..a5386ac893 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -662,6 +662,7 @@ static int write_midx_included_packs(struct string_list *include,
 }
 
 static int write_cruft_pack(const struct pack_objects_args *args,
+			    const char *destination,
 			    const char *pack_prefix,
 			    const char *cruft_expiration,
 			    struct string_list *names,
@@ -673,8 +674,10 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	struct string_list_item *item;
 	FILE *in, *out;
 	int ret;
+	const char *scratch;
+	int local = skip_prefix(destination, packdir, &scratch);
 
-	prepare_pack_objects(&cmd, args, packtmp);
+	prepare_pack_objects(&cmd, args, destination);
 
 	strvec_push(&cmd.args, "--cruft");
 	if (cruft_expiration)
@@ -714,7 +717,12 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only "
 			      "from pack-objects."));
-		string_list_append(names, line.buf);
+                /*
+		 * avoid putting packs written outside of the repository in the
+		 * list of names
+		 */
+		if (local)
+			string_list_append(names, line.buf);
 	}
 	fclose(out);
 
@@ -986,7 +994,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
 
-		ret = write_cruft_pack(&cruft_po_args, pack_prefix,
+		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
 				       cruft_expiration, &names,
 				       &existing_nonkept_packs,
 				       &existing_kept_packs);
-- 
2.38.0.16.g393fd4c6db

