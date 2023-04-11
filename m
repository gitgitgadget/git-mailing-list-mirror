Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A355C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 13:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDKNXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKNXf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 09:23:35 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17FA1BC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:23:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f6fc7943eso39695017b3.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681219413; x=1683811413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELfe2RFyMS8767ulhMSu3K3JQ7xWL6j0DzJac2/eanM=;
        b=SdW0oJAkhOhvZxWfj0r9jJvf1/+o9qH2kn1FAYaBPsLxh7sXWtlwWvBIlPUmd3CwJ6
         eDcoCiKEOQxbR4kCLDE/nECP17ZNgguZ8Lz7dapvBq5u3Oq4bvVQCDwsJHu/aFvfpIOP
         71B/WZvBDnfWlmwZERJ1v59mN9rBzzfJNahTPKisP3jAsAKF9NolB0M1bst/Ne8Rj3xQ
         dbknKJebFi+RccM9+K5hQmCAMQs66ZIn0hyhrPCU1d2/mLc3wTPBRbeHrINxWt5S2uo2
         ibbSNyRoHaTWzb2/LPA/4CB1hHaav1vBKIrxkTBcrqXXRc89TQ+ba2qUanBVYGu67/Yb
         qnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681219413; x=1683811413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELfe2RFyMS8767ulhMSu3K3JQ7xWL6j0DzJac2/eanM=;
        b=Munwu58zTluZ6v9I7Ul7cp7An6Qa2XeGDlCE8tkXB3p/fxHeFlgBGZaVQRHS4xIG/D
         R3eapLffq609Jv65uk0iFWXE4ku72NvNCZNPkqr2zkEveoQYKUKk84N4iHEXaV0aAd49
         wsdtHDpZQ1sZq8Kcvzc5d3hRTCBJ0BdoBcIuXwcSKP34VeMCfwLkyvObFqYltQif2eUU
         ylX1QwfNG/P3po492iCzDcLWw1VXCbuo8EbFTtCtSI+qGivQajs2S5pieExQn+CBl+Qd
         5lYzfCQmEXQDQqKjINSpulaXvcmGjU7TaHz6JvqmR2+KKbCAHtmwxth5daqc+9X0yNDL
         CCfQ==
X-Gm-Message-State: AAQBX9ctNNOgNGT6OB47wGTM1b3kl0jDL9KAaFyTvnHU2NH4Hbzp6BPZ
        aDPt+PUNYmx3K4OQqL0RQugF
X-Google-Smtp-Source: AKy350bBcq50o+WlOfv0Vntft4+gP5qpME7qniAyRf0YVIjAjdMKr3KFdxjpcMvT34lu+UCQOCUCDQ==
X-Received: by 2002:a0d:d50e:0:b0:542:46f5:fb1e with SMTP id x14-20020a0dd50e000000b0054246f5fb1emr10552290ywd.44.1681219412829;
        Tue, 11 Apr 2023 06:23:32 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l200-20020a0de2d1000000b00545a0818487sm3458371ywe.23.2023.04.11.06.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:23:32 -0700 (PDT)
Message-ID: <423b5c5c-ef86-198a-16f7-c836ed78928c@github.com>
Date:   Tue, 11 Apr 2023 09:23:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/7] pack-write.c: plug a leak in stage_tmp_packfiles()
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <18be29c3988295cd58521f8cc4a729897df074c8.1681166596.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <18be29c3988295cd58521f8cc4a729897df074c8.1681166596.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2023 6:53 PM, Taylor Blau wrote:

> Instead, simply free() `rev_tmp_name` at the end of
> `stage_tmp_packfiles()`.

> @@ -568,6 +568,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
>  		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
>  	if (mtimes_tmp_name)
>  		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
> +
> +	free((char *)rev_tmp_name);

Just cut off from the context is a "if (rev_tmp_name)", so it might be
good to group this into that block, since we have the condition, anyway.


But I was also thinking about how we like to use "const" as an indicator
as "I am not responsible for free()ing this". And this comes from the
public write_rev_file() method. Based on the API prototype, we could
think that this string is held by a static strbuf (making the method
not reentrant, but that happens sometimes in our methods). But generally,
I wanted to inspect what it would take to make the API reflect the fact
that it can return a "new" string.

But there are two issues:

 1. The actual logic is inside write_rev_file_order(), so that API
    needs to change, too.

 2. The "new" string is created only if the rev_name parameter is
    NULL, which is somewhat understandable but still requires
    inside knowledge about the implementation to make that choice.

 3. If we inspect the callers to these methods, only one caller
    passes a non-null name: builtin/index-pack.c. The rest pass NULL,
    including write_midx_reverse_index() (which then leaks the name).

The below diff includes my attempt to change the API to return a
non-const string that must be freed by the callers.

Thanks,
-Stolee

--- >8 ---

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b17e79cd40f..6d2fa52f9c4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1725,7 +1725,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
 	const char *curr_index;
-	const char *curr_rev_index = NULL;
+	char *curr_rev_index = NULL;
 	const char *index_name = NULL, *pack_name = NULL, *rev_index_name = NULL;
 	const char *keep_msg = NULL;
 	const char *promisor_msg = NULL;
@@ -1956,8 +1956,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		free((void *) curr_pack);
 	if (!index_name)
 		free((void *) curr_index);
-	if (!rev_index_name)
-		free((void *) curr_rev_index);
+	free(curr_rev_index);
 
 	/*
 	 * Let the caller know this pack is not self contained
diff --git a/midx.c b/midx.c
index 9af3e5de889..85154bedd73 100644
--- a/midx.c
+++ b/midx.c
@@ -945,7 +945,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 				     struct write_midx_context *ctx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	const char *tmp_file;
+	char *tmp_file;
 
 	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
 
@@ -958,6 +958,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 		die(_("cannot store reverse index file"));
 
 	strbuf_release(&buf);
+	free(tmp_file);
 
 	trace2_region_leave("midx", "write_midx_reverse_index", the_repository);
 }
diff --git a/pack-write.c b/pack-write.c
index f1714054951..73850c061d9 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -207,15 +207,15 @@ static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-const char *write_rev_file(const char *rev_name,
-			   struct pack_idx_entry **objects,
-			   uint32_t nr_objects,
-			   const unsigned char *hash,
-			   unsigned flags)
+char *write_rev_file(const char *rev_name,
+		     struct pack_idx_entry **objects,
+		     uint32_t nr_objects,
+		     const unsigned char *hash,
+		     unsigned flags)
 {
 	uint32_t *pack_order;
 	uint32_t i;
-	const char *ret;
+	char *ret;
 
 	if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
 		return NULL;
@@ -233,12 +233,13 @@ const char *write_rev_file(const char *rev_name,
 	return ret;
 }
 
-const char *write_rev_file_order(const char *rev_name,
-				 uint32_t *pack_order,
-				 uint32_t nr_objects,
-				 const unsigned char *hash,
-				 unsigned flags)
+char *write_rev_file_order(const char *rev_name,
+			   uint32_t *pack_order,
+			   uint32_t nr_objects,
+			   const unsigned char *hash,
+			   unsigned flags)
 {
+	char *ret_name;
 	struct hashfile *f;
 	int fd;
 
@@ -249,10 +250,11 @@ const char *write_rev_file_order(const char *rev_name,
 		if (!rev_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
 			fd = odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
-			rev_name = strbuf_detach(&tmp_file, NULL);
+			rev_name = ret_name = strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(rev_name);
 			fd = xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+			ret_name = xstrdup(rev_name);
 		}
 		f = hashfd(fd, rev_name);
 	} else if (flags & WRITE_REV_VERIFY) {
@@ -264,6 +266,7 @@ const char *write_rev_file_order(const char *rev_name,
 			} else
 				die_errno(_("could not stat: %s"), rev_name);
 		}
+		ret_name = xstrdup(rev_name);
 		f = hashfd_check(rev_name);
 	} else
 		return NULL;
@@ -280,7 +283,7 @@ const char *write_rev_file_order(const char *rev_name,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
 			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
 
-	return rev_name;
+	return ret_name;
 }
 
 static void write_mtimes_header(struct hashfile *f)
@@ -543,7 +546,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 unsigned char hash[],
 			 char **idx_tmp_name)
 {
-	const char *rev_tmp_name = NULL;
+	char *rev_tmp_name = NULL;
 	const char *mtimes_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
@@ -564,8 +567,10 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 	}
 
 	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
-	if (rev_tmp_name)
+	if (rev_tmp_name) {
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
+		free(rev_tmp_name);
+	}
 	if (mtimes_tmp_name)
 		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
 }
diff --git a/pack.h b/pack.h
index 3ab9e3f60c0..02bbdfb19cc 100644
--- a/pack.h
+++ b/pack.h
@@ -96,8 +96,8 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
-const char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
-const char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
