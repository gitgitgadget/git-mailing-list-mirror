Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B881F406
	for <e@80x24.org>; Fri, 11 May 2018 13:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeEKNeZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 09:34:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43525 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKNeY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 09:34:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id n18-v6so1512073lfh.10
        for <git@vger.kernel.org>; Fri, 11 May 2018 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=npdpfj8rpGvnQU7WNYlt4LgxzyMMiJbqo/9msvHv85U=;
        b=WXITT2bKDQmU2VIcJxpl5woLWzIH0QunTbABd9UBr0svgsYdJkIEjAg+i7wJtyHt5S
         DT3i3/3L2/KT4AHfichQD12tNojS3m77mrfage+tmFCXXlvuTVWuHPwfAlXf6Sstv9hf
         CeuH9vWeIRCfKjHxCw8MXyeAbl+Is0qIpLTgoVRzwTIUImtXviPF4Bp5lYghYk5YGiYM
         770QLxVFttxXXEQXI9Q09796l7VO7sb+cepyutGiX9scc0L22k5qwLjJ5tuSqbCO1mhP
         umVb+k55qbW2fVLWmNcF5zdOtqaCAIDqOtKZEIB1c4ENxEKE8CMmEl7Y0hWNJ4PWYgzg
         4+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=npdpfj8rpGvnQU7WNYlt4LgxzyMMiJbqo/9msvHv85U=;
        b=mYMns+SBZRO8WrVplY13f1RGhJO0dqPlDuSOKVJWkRko8eHD6WhLnYYH7w9cY3FiY1
         0W/SgBGtB6rsjQuRcsiQ71EDvcvOSAEQGRuxdZsSm9rpNLIAXH6Im8rjN9TMMsl8y548
         7plQpfFphjOA04t2fouyFZ+kBnypSS/klISJ6z6/7zRiYEn7kXoVzwNWLFPeESz6mq8z
         07EVdCeXfmcCVlGFetsY3UI60XM43WmBcT8BfgHvYZNFrfn1bpEWegu2CSFBerwcBkLL
         wNNLSMi5/psOhIdAekwSwXTPrLDLiTyMTDgzATuck1jqjsmnrDn8Djj2oxCxjAmfn7HW
         qMlw==
X-Gm-Message-State: ALKqPwfmse7k8AUGAxszPrq1whofUdb4zrmGQDPtP2LKY+PDTNYrmKM6
        miXQw+qQTB+VkzdQs7XspcQ=
X-Google-Smtp-Source: AB8JxZr5LcRqOfWKFBDhDGAigeyQ160xfnhjpndCQK0bbA1bBvjvkkOndvUJm3hGFTpRCS+79cRcdw==
X-Received: by 2002:a2e:80c1:: with SMTP id r1-v6mr4363812ljg.85.1526045662746;
        Fri, 11 May 2018 06:34:22 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o38-v6sm662596lfi.51.2018.05.11.06.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 06:34:21 -0700 (PDT)
Date:   Fri, 11 May 2018 15:34:19 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
Message-ID: <20180511133419.GA2170@duynguyen.home>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
 <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
 <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
 <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
 <20180511085634.GC22086@sigill.intra.peff.net>
 <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 03:11:46PM +0200, Duy Nguyen wrote:
> Back to fast-export, can we just allocate a new int on heap and point
> it there? Allocating small pieces becomes quite cheap and fast with
> mem-pool.h and we can avoid this storing integer in pointer business.

Something like this seems to work, but we use 4-ish more bytes per
object, or 100MB overhead on a repo with 25M objects. I think it's a
reasonable trade off.

-- 8< --
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 530df12f05..de593035b1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
+#include "mem-pool.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
@@ -38,6 +39,7 @@ static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct refspec *refspecs;
 static int refspecs_nr;
 static int anonymize;
+static struct mem_pool int_pool = MEM_POOL_INIT(2 * 1024 * 1024);
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -156,20 +158,22 @@ static void anonymize_path(struct strbuf *out, const char *path,
 	}
 }
 
-/* Since intptr_t is C99, we do not use it here */
-static inline uint32_t *mark_to_ptr(uint32_t mark)
+static inline uint32_t ptr_to_mark(void *mark)
 {
-	return ((uint32_t *)NULL) + mark;
-}
-
-static inline uint32_t ptr_to_mark(void * mark)
-{
-	return (uint32_t *)mark - (uint32_t *)NULL;
+	if (!mark)
+		BUG("not marked!");
+	return *(uint32_t *)mark;
 }
 
 static inline void mark_object(struct object *object, uint32_t mark)
 {
-	add_decoration(&idnums, object, mark_to_ptr(mark));
+	uint32_t *ptr = lookup_decoration(&idnums, object);
+
+	if (!ptr)
+		ptr = mem_pool_alloc(&int_pool, sizeof(uint32_t));
+
+	*ptr = mark;
+	add_decoration(&idnums, object, ptr);
 }
 
 static inline void mark_next_object(struct object *object)
diff --git a/fast-import.c b/fast-import.c
index 34edf3fb8f..ce5ce2081f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -300,8 +300,7 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static struct mem_pool fi_mem_pool =  {NULL, 2*1024*1024 -
-				       sizeof(struct mp_block), 0 };
+static struct mem_pool fi_mem_pool = MEM_POOL_INIT(2*1024*1024);
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
diff --git a/mem-pool.h b/mem-pool.h
index 829ad58ecf..bccbd3f224 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -21,6 +21,8 @@ struct mem_pool {
 	size_t pool_alloc;
 };
 
+#define MEM_POOL_INIT(block_size) { NULL, (block_size) - sizeof(struct mp_block), 0 }
+
 /*
  * Alloc memory from the mem_pool.
  */
-- 8< --
