Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01431C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 08:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiGRIgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiGRIgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 04:36:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D381928C
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:36:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso12022433pjb.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBERGd9QTGycZD9k1UY1oIvNdlJ4d0oBFETyyadVZxw=;
        b=n6N7Y9r3T/zaAxdd7EFfSUNQAr+DXFt71leefzhPjbX1MnzlMpVEytxNlZpy70MG0i
         ZuJpY+n+nEGXoU0H0Vpj79ToLMkByJhxC+brClucVrfvBrApoBvBzDWdfubf64eVC+q7
         dKENfVICUxFeGnZrjLgjpGFSLiOBGDb2Lawxl+Im6hCmyIm6A6mU16kHpJZhCu5WFhjd
         yezPGeHnRefJ+LqiUPDR2x+01e7UeyktNqmtAm+IQbGowRUPCwG2vJlvmrfUX54kXzrU
         ce/fAnfoq/gqm8csqDRDx+AOsx6XF/8B3Dr25RsTzsgoc7ix3slrayv/TWALtffOzcBe
         jUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBERGd9QTGycZD9k1UY1oIvNdlJ4d0oBFETyyadVZxw=;
        b=4gNsZcCL2Rx5E7F5l7nYK/O8RF7DVtxAaIQnh6kyfFZlNkPNemlR9lT7PzXRhwrXZP
         zbfIWEuoVt5+mhQPkmSF+BRfEb2RJNfBmVZtWKU4rP623jy5CHlYvoIT4YS0f88VtUWm
         RAIzU1OVWE6/BcBraj73oobgVdKvYJ/BsDT5PaXXX/8mdafsmO0z9Dg8rS3jLyirppi3
         vyvRIg+ztVbVikle03EWKdBfE3XAhCHtO3PNecaDwQjrdAenVua1qjpZ4Ia49m8DmvMQ
         A1SWeiLhVjeXDYJEGlqjAs52VWHrtTXHjEAKoEdHlVw8QIgOKAHRDtWKa4aA5cSkdr7J
         wp7w==
X-Gm-Message-State: AJIora9+bYSG+kNYaX94GZHLDLOwc+A3BUomZzmlvXAEXh4xSRk2plPC
        mXGb4f/kmKvot6iR4XgO3CQ=
X-Google-Smtp-Source: AGRyM1tsrRP71pgzmm6Q/aXNdxu1k4Nc2sSN5d0RqraVO/JKNj0S7bo77PqDOGgrexhc73zevn3+NQ==
X-Received: by 2002:a17:903:22c8:b0:16c:4068:cd with SMTP id y8-20020a17090322c800b0016c406800cdmr27301212plg.59.1658133367919;
        Mon, 18 Jul 2022 01:36:07 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.101])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090a394500b001f1694dafb1sm5076975pjf.44.2022.07.18.01.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 01:36:07 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 0/7] trace2: dump scope when print "interesting" config
Date:   Mon, 18 Jul 2022 16:36:00 +0800
Message-Id: <20220718083600.11803-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <220711.867d4j7kuj.gmgdl@evledraar.gmail.com>
References: <220711.867d4j7kuj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I left some minor comments, another thing I'd just like to note, but it
> largely pre-dates this series, so we can leave it for now is that I
> found our mismatching reporting of the *.bitmap and/or *.pack kind of odd.

Ok.

> I.e. this bit (a diff on top):
>
> 	diff --git a/pack-bitmap.c b/pack-bitmap.c
> 	index 7e69093d5a8..8a8be5f6cad 100644
> 	--- a/pack-bitmap.c
> 	+++ b/pack-bitmap.c
> 	@@ -381,23 +381,25 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>
> 	 	bitmap_name = pack_bitmap_filename(packfile);
> 	 	fd = git_open(bitmap_name);
> 	+	free(bitmap_name);
>
> 	 	if (fd < 0) {
> 	 		if (errno != ENOENT)
> 	-			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
> 	-		free(bitmap_name);
> 	+			warning_errno("cannot open bitmap for pack '%s'",
> 	+				      packfile->pack_name);
> 	 		return -1;
> 	 	}
> 	-	free(bitmap_name);
>
> 	 	if (fstat(fd, &st)) {
> 	 		close(fd);
> 	-		return error_errno(_("cannot fstat bitmap file"));
> 	+		return error_errno(_("cannot fstat() bitmap file for pack '%s'"),
> 	+				   packfile->pack_name);
> 	 	}
>
> 	 	if (bitmap_git->pack || bitmap_git->midx) {
> 	 		/* ignore extra bitmap file; we can only handle one */
> 	 		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
> 	+		/* ^^ because here we refer to the pack file, not the bitmap file */
> 	 		close(fd);
> 	 		return -1;
> 	 	}
>
> As tha shows we sometimes talk about the path for the pack when
> something is wrong with the bitmap, but other times the *.bitmap
> associated with the pack.

I think the reason is, the single-pack-bitmap filename based on the pack
filename as "pack-$hash.bitmap" format and the multi-pack-bitmap filename based
on the multi-pack-index as "multi-pack-index-$hash.bitmap" format. So, if want
to open single-pack-bitmap, the corresponding  packfile is needed. if want to
open multi-pack-bitmap, the multi-pack-index file is needed, then initialize
fields in "bitmap_index" like mmap, etc.

That'"s probably where these two methods and inputs come from and make the
"path" different:

  static int open_pack_bitmap_1(struct bitmap_index *bitmap_git,
                                struct packed_git *packfile)
  static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
                                struct multi_pack_index *midx)

By the way, I think maybe the "multi-pack-index" filename maybe could change
to "multi-pack-index-$hash.idx", it could map the current multi-pack-bitmap
filename "multi-pack-index-$sha.bitmap", and ".idx" could be consistent with
single-pack-index file. Maybe it's better I think, but it also should consider
the backend compatibility.

> Also a pre-existing issue: Why are we getting as far as opening a
> *.bitmap file, if we then find that we have "bitmap_git->pack ||
> bitmap_git->midx" already, and then ignore it? Maybe I've missed
> something...
>
> All of the same oddness applies to open_midx_bitmap_1, except with "path
> to the midx" in place of "*.pack" above.

I'm not quite sure but in the code I think it's purposed to get the "fd" first
by "open..()", then get the bitmap file size by "fstat()", finally "mmap" the
bitmap file for some struct data initialization work.

Thanks.
