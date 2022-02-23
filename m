Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F8C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiBWWZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBWWZW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:25:22 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EC03BFBA
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:24:53 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r7so614720iot.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GocTfI/4yRKjDLQ0Hk1w5SLva5buPLK40E7djixK9iA=;
        b=MzsZlS+xcO8mG/IjI0o+MdIMrfiXHUami39IHkXXI8Q3SezjwusKCNzZKKGneXoHLZ
         NaqPqhevFTs3Mvg3dkIOivH2C3HeACDcHlob+yM3cykMjaczRXByoyzztTjkFOIhj+WA
         nThvVmTlKM6Dy01Oah7kpxl1VY8R8E23lbrc6VEZqf3OUNdMa4L96+DcClDKrCjWapU5
         EAA872xttHovqs8gGuMHgQwJZk5EEHd+AnvxKPOtB/3EU/4hWA8H/Z5gbCfjE+HknE7R
         eP520yh11HczdLBBFCKVXbmvmWdR6ZEipenjpbxDTWUkG0iaYLTbQUkQ37UpQjX4mouU
         qLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GocTfI/4yRKjDLQ0Hk1w5SLva5buPLK40E7djixK9iA=;
        b=Skq/ZtgDtBbIFPtDXEwqYfl3ojtD7BLWmMTJtntnxOBVSKYim/yTbuJpojULVMSPOo
         fygIBzKuSxF1XH28MxbTSP3igNxK+y9g0Gn2mSxSmRItT1rlFKprPbHs1yaopuZ7AwvK
         crPgmxGfOu78yWQpdNPa9+zt4c4Tuf6ERtEkw6yOIJI6wAwNqR7yAnVJVPoB8ofd1CGc
         jwXAy9zpwooXZcxZcyxb41PnxLfnFcJzShNjM7j7GxtaxzO9wk/T9sP09y7l25QSXJ2D
         zJuAlInMRxnEa16b6aro5MuXWRdn7l1UTF/Hops3FPYM4xltECzRQSD+MxCOColp8W11
         sUag==
X-Gm-Message-State: AOAM530Pc5duH2Sp4OB4Pon68YV/bg8f8VRMTJdTNwK9wHLug9LhHcYm
        XhG0orEyNYmx+IU4qvs2p6iZGRWlyFhedU4m
X-Google-Smtp-Source: ABdhPJzF24r4A5LH5uKkWt2zu53p7T5VKkl1A8NHnU9Fp93FhESsJqOXEfRL49zwLZEJvufo0s+qTA==
X-Received: by 2002:a5d:9e43:0:b0:640:93b4:a7a3 with SMTP id i3-20020a5d9e43000000b0064093b4a7a3mr1082650ioi.145.1645655093352;
        Wed, 23 Feb 2022 14:24:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z3sm557987ilo.44.2022.02.23.14.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:24:52 -0800 (PST)
Date:   Wed, 23 Feb 2022 17:24:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: [PATCH 06/17] t/helper: add 'pack-mtimes' test-tool
Message-ID: <Yha0M1bKxCb1/MrJ@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <e0a7b3b310c69350d8e2c0561e0991bb7045a66d.1638224692.git.me@ttaylorr.com>
 <15f1bbc6-7ae6-0ed3-872a-51feebd1296c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15f1bbc6-7ae6-0ed3-872a-51feebd1296c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 06, 2021 at 04:16:04PM -0500, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:
> > +static int dump_mtimes(struct packed_git *p)
>
> nit: you return an int here so you can use it as an error code...
>
> > +{
> > +	uint32_t i;
> > +	if (load_pack_mtimes(p) < 0)
> > +		die("could not load pack .mtimes");
> > +
> > +	for (i = 0; i < p->num_objects; i++) {
> > +		struct object_id oid;
> > +		if (nth_packed_object_id(&oid, p, i) < 0)
> > +			die("could not load object id at position %"PRIu32, i);
> > +
> > +		printf("%s %"PRIu32"\n",
> > +		       oid_to_hex(&oid), nth_packed_mtime(p, i));
> > +	}
> > +
> > +	return 0;
>
> But always return 0 unless you die().
>
> > +	return p ? dump_mtimes(p) : 1;
>
> It makes this line concise, I suppose.
>
> Perhaps just use "return dump_mtimes(p)" and have dump_mtimes()
> return 1 if the given pack is NULL?

I think just dying in the case we have a NULL pack is fine, and it
should be OK to lump it in the same case as "could not load pack .mtimes".

But we may want to catch the case a little earlier while we still have
the pack name handy. Perhaps something like this on top:

--- 8< ---
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index b143f62520..f7b79daf4c 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -5,7 +5,7 @@
 #include "packfile.h"
 #include "pack-mtimes.h"

-static int dump_mtimes(struct packed_git *p)
+static void dump_mtimes(struct packed_git *p)
 {
 	uint32_t i;
 	if (load_pack_mtimes(p) < 0)
@@ -19,8 +19,6 @@ static int dump_mtimes(struct packed_git *p)
 		printf("%s %"PRIu32"\n",
 		       oid_to_hex(&oid), nth_packed_mtime(p, i));
 	}
-
-	return 0;
 }

 static const char *pack_mtimes_usage = "\n"
@@ -49,5 +47,10 @@ int cmd__pack_mtimes(int argc, const char **argv)

 	strbuf_release(&buf);

-	return p ? dump_mtimes(p) : 1;
+	if (!p)
+		die("could not find pack '%s'", argv[1]);
+
+	dump_mtimes(p);
+
+	return 0;
 }
--- >8 ---

Thanks,
Taylor
