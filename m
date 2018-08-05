Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CDBB1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 08:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeHELBO (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 07:01:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40343 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHELBO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 07:01:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so8181305ljc.7
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtUpSf7xUtGqy3WHIC5xUkAAzbuWLeEGg191hRCZ/vA=;
        b=Z/m2EQNsOp7f3Fq54NnP28qXzkuExqSEroJTdHKzjR+wLTwau1fkn9YsZz1lOzDKRC
         nF12+XGwvAC4BsVWhWFOQmWqjrSKXI5U/WEHfcZi0Vh9EwojshjEcqAHXAEw6teBbDhb
         sRO/pcC/M+dW6P9zgCIFIF+z5a+B4x4gow9u4h1en7dIEfAtZYltr5n2rFulsJe2hVZq
         L71Ni/e0O0AtTj+43iUFZwjydmo5xdOr3jxyW5WSmx9N1h7+UuNkwwyZzW17x/mwzwIl
         KvLfCQL9iWscp2s18iAAtJJydV5dQInOKZAuUQL/wGQ3Bo9WRVRnReFOstWk00TywWml
         wnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtUpSf7xUtGqy3WHIC5xUkAAzbuWLeEGg191hRCZ/vA=;
        b=oQ5dcJKrsE9e34F3Qaox+kLZoL+IEgBD3nrdvZxZbPLxTdpsJCZHz/F2yWbXW8jQw0
         0gEp/nr+HfzxwR7Jkm2KRLIbq6/hYdsBR3D/Swwa7Asv29BYF4kBn8zMHddA0ZD0Mp1p
         jk5schIi/SSQbIun7B/6kKxHiqpoyOK9NYvaLaxu4VFll3kP1qV5lvqgNZFzLFD2n2K/
         xfGQu5Yn5Aj/tPrwLYavMxIa3pXzmkArsJOqnaaViY3ga35XaOElbk00iWKYsfYKppyc
         Cg3JaJX2uj4vx6LoM+laIh+Dd9CaalKjPmDu0rqEhg0sJxyGIPlrYz1/gOyYzRPI+x6n
         K1Sw==
X-Gm-Message-State: AOUpUlG3ly6+/bOdKIMC5Vps/+CAgSJGUcnU/bHHHfTuk+lytpqdVZa2
        XNOTBIavRnSaGDAA7AlEWT8=
X-Google-Smtp-Source: AAOMgpdlDoiT2qbNH1UmJhsRuVgzRvDOBjVm8QtHokuh9CXbtaRZXRRNJx7TzZlp//hmBII714kEzQ==
X-Received: by 2002:a2e:2e02:: with SMTP id u2-v6mr10229478lju.77.1533459441644;
        Sun, 05 Aug 2018 01:57:21 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 2-v6sm1575319lfv.39.2018.08.05.01.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 01:57:20 -0700 (PDT)
Date:   Sun, 5 Aug 2018 10:57:18 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
Message-ID: <20180805085718.GA27625@duynguyen.home>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180731163909.19004-1-benpeart@microsoft.com>
 <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>
 <3900401c-4d7b-233c-2098-9771a06ec0dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3900401c-4d7b-233c-2098-9771a06ec0dd@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 02:02:00PM -0400, Ben Peart wrote:
> > And if all go according to plan, there will be no changes made in the
> > index (by either 2-way merge or sparse checkout stuff) we should be
> > able to just skip writing down the index, if we haven't done that
> > already.
> > 
> 
> That would be great as writing the index is 8.4% of the time spent.

And that is of course not good. Avoiding writing index at all is nice
and all but we should not take that much time writing it (what about
other commands?)

I have another idea to reduce index size, which means cheaper trailer
hash calculation, but this may also be a direction you could look
into.

I notice that we have a lot of duplicate data in the index. For
example, most files would have the same ctime and even mtime (at least
the seconds part). group id, device id and file mode should also be
the same in normal case. I guess on Windows, inode is always the same
as well. So why store (and hash) them repeatedly?

This patch writes "index version 5" that only writes those fields out
if they are different from the previous entry (we already do this for
path name in v4).

On webkit repo (275k files), writing time can be reduced from 0.314s
(v2) to 0.206s (v5). File size of all versions:

 9.8M Aug  5 10:27 .git/index.gz
  38M Aug  5 09:54 .git/index-v2
  22M Aug  5 10:26 .git/index-v4
  15M Aug  5 10:34 .git/index-v5

As you can see there's still room to compress, but I don't think we
want to go full deflate mode because compression time goes up.

Another option I think you could consider is not storing full hash. As
long as the shortened hash is still unique, we can expand to full hash
at read time. Of course you can't go too short (I'm thinking half the
current hash size is reasonable trade off) and need to take into
account how much time will be lost for looking up and expanding these
short hashes at read time.

-- 8< --
diff --git a/cache.h b/cache.h
index e6f7ee4b64..1d6bc7d122 100644
--- a/cache.h
+++ b/cache.h
@@ -129,7 +129,7 @@ struct cache_header {
 };
 
 #define INDEX_FORMAT_LB 2
-#define INDEX_FORMAT_UB 4
+#define INDEX_FORMAT_UB 5
 
 /*
  * The "cache_time" is just the low 32 bits of the
diff --git a/read-cache.c b/read-cache.c
index b0b5df5de7..9bb095d6b2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2002,7 +2002,7 @@ static int ce_write_flush(git_hash_ctx *context, int fd)
 	return 0;
 }
 
-static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
+static int ce_write(git_hash_ctx *context, int fd, const void *data, unsigned int len)
 {
 	while (len) {
 		unsigned int buffered = write_buffer_len;
@@ -2024,6 +2024,18 @@ static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
 	return 0;
 }
 
+static int ce_write_u32(git_hash_ctx *context, int fd, uint32_t data)
+{
+	data = htonl(data);
+	return ce_write(context, fd, &data, sizeof(data));
+}
+
+static int ce_write_u16(git_hash_ctx *context, int fd, uint16_t data)
+{
+	data = htons(data);
+	return ce_write(context, fd, &data, sizeof(data));
+}
+
 static int write_index_ext_header(git_hash_ctx *context, int fd,
 				  unsigned int ext, unsigned int sz)
 {
@@ -2133,8 +2145,46 @@ static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
+#define ONDISK_MASK (CE_STAGEMASK | CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
+
+static int ce_write_entry_v5(git_hash_ctx *c, int fd,
+			     const struct cache_entry *ce,
+			     const struct cache_entry *pce)
+{
+	uint8_t mask = 0;
+	const struct stat_data *st1 = &ce->ce_stat_data;
+	const struct stat_data *st2 = &pce->ce_stat_data;
+	//int ret = 0;
+
+	mask |= (st1->sd_ctime.sec != st2->sd_ctime.sec) << 0;
+	mask |= (st1->sd_mtime.sec != st2->sd_mtime.sec) << 1;
+	mask |= (st1->sd_dev != st2->sd_dev) << 2;
+	mask |= (st1->sd_ino != st2->sd_ino) << 3;
+	mask |= (ce->ce_mode != pce->ce_mode) << 4;
+	mask |= (st1->sd_uid != st2->sd_uid) << 5;
+	mask |= (st1->sd_gid != st2->sd_gid) << 6;
+	mask |= ((ce->ce_flags & ONDISK_MASK) != (pce->ce_flags & ONDISK_MASK)) << 7;
+
+	ce_write(c, fd, &mask, 1);
+	ce_write(c, fd, ce->oid.hash, GIT_SHA1_RAWSZ);
+	ce_write_u32(c, fd, st1->sd_ctime.nsec);
+	ce_write_u32(c, fd, st1->sd_mtime.nsec);
+	ce_write_u32(c, fd, st1->sd_size);
+	if (mask & (1 << 0)) ce_write_u32(c, fd, st1->sd_ctime.sec);
+	if (mask & (1 << 1)) ce_write_u32(c, fd, st1->sd_mtime.sec);
+	if (mask & (1 << 2)) ce_write_u32(c, fd, st1->sd_dev);
+	if (mask & (1 << 3)) ce_write_u32(c, fd, st1->sd_ino);
+	if (mask & (1 << 4)) ce_write_u16(c, fd, ce->ce_mode);
+	if (mask & (1 << 5)) ce_write_u32(c, fd, st1->sd_uid);
+	if (mask & (1 << 6)) ce_write_u32(c, fd, st1->sd_gid);
+	if (mask & (1 << 7)) ce_write_u32(c, fd, ce->ce_flags & ONDISK_MASK);
+	return 0;
+}
+
 static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
-			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
+			  const struct cache_entry *pce,
+			  struct strbuf *previous_name,
+			  struct ondisk_cache_entry *ondisk)
 {
 	int size;
 	int result;
@@ -2173,8 +2223,12 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 		to_remove = previous_name->len - common;
 		prefix_size = encode_varint(to_remove, to_remove_vi);
 
-		copy_cache_entry_to_ondisk(ondisk, ce);
-		result = ce_write(c, fd, ondisk, size);
+		if (!pce) {
+			copy_cache_entry_to_ondisk(ondisk, ce);
+			result = ce_write(c, fd, ondisk, size);
+		} else {
+			result = ce_write_entry_v5(c, fd, ce, pce);
+		}
 		if (!result)
 			result = ce_write(c, fd, to_remove_vi, prefix_size);
 		if (!result)
@@ -2313,7 +2367,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
+	previous_name = (hdr_version >= 4) ? &previous_name_buf : NULL;
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
@@ -2334,7 +2388,10 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 			drop_cache_tree = 1;
 		}
-		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
+		if (ce_write_entry(&c, newfd, ce,
+				   hdr_version >= 5 && i > 0 ? cache[i - 1] : NULL,
+				   previous_name,
+				   (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
 
 		if (err)
-- 8< --
--
Duy
