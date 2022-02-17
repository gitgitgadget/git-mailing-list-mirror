Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE2C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 05:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiBQFAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 00:00:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiBQFAN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 00:00:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74EB2A5237
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 20:59:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so8408144pjl.2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 20:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=napm3blr/nK94BLfAeMgenIjd5kJXZC3VB++8Wtdnow=;
        b=YYiL5AnSLyL5884OdDaysR3bKKIDbUfJod3PAgz+i1LolROWfxecDqovS8yMb8wJH5
         zAzMmefpIEXuxMPRlEwq9OC1uMhzQi7LSlE5gwZK4rJDoz1GwB+JuGNE/ruOX2G3UJGa
         AiKcye4qKuqXaT4qO308XsjaBMDX74L/VjC1N0X71sxqUO549w+kbzR1uUcJP/EDMl85
         M3s/1RuSdEC+2q+LxW2iiH/xaI/mKaMNl7ZvxcV9fshM2hHZgxFKsu+RVq/mBnzPQ5pF
         w54CuzEQH1ddXQYOGpXf1kFupy1S2el0UqSBUgjiYO9xUOeHuFCSJ1rlsGNdvwDldVXi
         zivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=napm3blr/nK94BLfAeMgenIjd5kJXZC3VB++8Wtdnow=;
        b=ONKoME+TpDtU1++SQ27id+VdKWacBTFXfYNLT//Omrkw50XxsU/dyeJJirlMGoXIuU
         ytDSjnKIkbYlja+fUSHMfR8TI0erKSvO+2wL++RYns7310unYiaBAcyikPyh/n+xBk+q
         Ymb/SbYHaK8NSTFdkeNJD06003HZm4a0oz4fCkcAz3YjDGebUo67h5Jk8KwULgZ7wUf2
         lA+85+8S6Wzf3WCydeOVyyg7I1R08PsbLyfJLFr/6DXrhAG1Lkbb7AvIY9LbuHGqXa4f
         Qo52iGeqQF0GGbcDXcZbyJelQXIuIHpAbm2+03758sH1HrYCOBK6zF8Wr2SCRTOf5ksv
         ktFQ==
X-Gm-Message-State: AOAM533c6OlIz3WjDLWqJRf3+h7XRQtjQNDe6Nh/a5sGCb+qTin5mrbm
        nEn2jYaR17rb5K1g6lniIrQ=
X-Google-Smtp-Source: ABdhPJzAUAPr9VlckmQy6ASPlUilfJrYURfHXs3kMXkvCRkABhG7lSwOzj98W/gKz54t4RkGD4p6zA==
X-Received: by 2002:a17:90b:33cb:b0:1b9:fa5a:1d7d with SMTP id lk11-20020a17090b33cb00b001b9fa5a1d7dmr5478586pjb.103.1645073999197;
        Wed, 16 Feb 2022 20:59:59 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id z1sm45691218pfh.137.2022.02.16.20.59.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 20:59:58 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: RE: [PATCH v3 03/12] object-file API: add a format_object_header() function
Date:   Thu, 17 Feb 2022 12:59:43 +0800
Message-Id: <20220217045943.30223-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <patch-v3-03.12-92fd020d199-20220204T234435Z-avarab@gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

On Sat, Feb 5, 2022 Ævar Arnfjörð Bjarmason wrote:

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 2b2e28bad79..123df7d9a53 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -937,8 +937,8 @@ static int store_object(
>  	git_hash_ctx c;
>  	git_zstream s;
>  
> -	hdrlen = xsnprintf((char *)hdr, sizeof(hdr), "%s %lu",
> -			   type_name(type), (unsigned long)dat->len) + 1;
> +	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
> +				      dat->len);

Type casting can be avoid if we use "void *" as the first parameter of
"format_object_header", and do type casting inside the helper function.

> diff --git a/object-file.c b/object-file.c
> index eeb6814780a..3fcd46cf9ed 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1049,6 +1049,23 @@ void *xmmap(void *start, size_t length,
>  	return ret;
>  }
>  
> +static int format_object_header_literally(char *str, size_t size,
> +					  const char *type, size_t objsize)
> +{
> +	return xsnprintf(str, size, "%s %"PRIuMAX, type, (uintmax_t)objsize) + 1;
> +}
> +
> +int format_object_header(char *str, size_t size, enum object_type type,
> +			 size_t objsize)
> +{
> +	const char *name = type_name(type);
> +
> +	if (!name)
> +		BUG("could not get a type name for 'enum object_type' value %d", type);
> +

The return value of `type_name(type)` has not been checked for the original
implement, how about write a online inline-function in a header file like this:

	static inline int format_object_header(void *str, size_t size,
					       const char *type_name,
					       size_t objsize)
	{
		return xsnprintf((char *)str, size, "%s %"PRIuMAX, type_name,
				 (uintmax_t)objsize) + 1;
	}
 
> +	return format_object_header_literally(str, size, name, objsize);
> +}


--- >8 ---
From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Date: Thu, 17 Feb 2022 11:35:27 +0800
Subject: [PATCH] fixup! object-file API: add a format_object_header() function

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/fast-import.c |  4 ++--
 builtin/index-pack.c  |  3 ++-
 bulk-checkin.c        |  4 ++--
 http-push.c           |  2 +-
 object-file.c         | 23 +++--------------------
 object-store.h        |  9 +++++++--
 6 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 123df7d9a5..f5ec40fc1b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -937,7 +937,7 @@ static int store_object(
 	git_hash_ctx c;
 	git_zstream s;
 
-	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
+	hdrlen = format_object_header(hdr, sizeof(hdr), type_name(type),
 				      dat->len);
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
@@ -1091,7 +1091,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
-	hdrlen = format_object_header((char *)out_buf, out_sz, OBJ_BLOB, len);
+	hdrlen = format_object_header(out_buf, out_sz, "blob", len);
 
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, out_buf, hdrlen);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 01574378ce..a37533333e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -449,7 +449,8 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	int hdrlen;
 
 	if (!is_delta_type(type)) {
-		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
+		hdrlen = format_object_header(hdr, sizeof(hdr), type_name(type),
+					      size);
 		the_hash_algo->init_fn(&c);
 		the_hash_algo->update_fn(&c, hdr, hdrlen);
 	} else
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 85b3ebaf97..58fb59990d 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -220,8 +220,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	if (seekback == (off_t) -1)
 		return error("cannot find the current offset");
 
-	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  type, size);
+	header_len = format_object_header(obuf, sizeof(obuf), type_name(type),
+					  size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
 
diff --git a/http-push.c b/http-push.c
index f0c044dcf7..eb2b46b2fc 100644
--- a/http-push.c
+++ b/http-push.c
@@ -363,7 +363,7 @@ static void start_put(struct transfer_request *request)
 	git_zstream stream;
 
 	unpacked = read_object_file(&request->obj->oid, &type, &len);
-	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
+	hdrlen = format_object_header(hdr, sizeof(hdr), type_name(type), len);
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/object-file.c b/object-file.c
index 3fcd46cf9e..f396e78909 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1049,23 +1049,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-static int format_object_header_literally(char *str, size_t size,
-					  const char *type, size_t objsize)
-{
-	return xsnprintf(str, size, "%s %"PRIuMAX, type, (uintmax_t)objsize) + 1;
-}
-
-int format_object_header(char *str, size_t size, enum object_type type,
-			 size_t objsize)
-{
-	const char *name = type_name(type);
-
-	if (!name)
-		BUG("could not get a type name for 'enum object_type' value %d", type);
-
-	return format_object_header_literally(str, size, name, objsize);
-}
-
 /*
  * With an in-core object data in "map", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
@@ -1094,7 +1077,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = format_object_header(hdr, sizeof(hdr), obj_type, size);
+	hdrlen = format_object_header(hdr, sizeof(hdr), type_name(obj_type), size);
 
 	/* Sha1.. */
 	r->hash_algo->init_fn(&c);
@@ -1794,7 +1777,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	git_hash_ctx c;
 
 	/* Generate the header */
-	*hdrlen = format_object_header_literally(hdr, *hdrlen, type, len);
+	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
 
 	/* Sha1.. */
 	algo->init_fn(&c);
@@ -2068,7 +2051,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	buf = read_object(the_repository, oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
-	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
+	hdrlen = format_object_header(hdr, sizeof(hdr), type_name(type), len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
diff --git a/object-store.h b/object-store.h
index 8b4413d0ce..33b5add7ab 100644
--- a/object-store.h
+++ b/object-store.h
@@ -336,8 +336,13 @@ int has_loose_object_nonlocal(const struct object_id *);
  * writes the initial "<type> <obj-len>" part of the loose object
  * header. It returns the size that snprintf() returns + 1.
  */
-int format_object_header(char *str, size_t size, enum object_type type,
-			 size_t objsize);
+static inline int format_object_header(void *str, size_t size,
+				       const char *type_name,
+				       size_t objsize)
+{
+	return xsnprintf((char *)str, size, "%s %"PRIuMAX, type_name,
+			 (uintmax_t)objsize) + 1;
+}
 
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
-- 
2.35.0.rc2

