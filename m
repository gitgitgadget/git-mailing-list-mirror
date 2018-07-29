Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654F61F597
	for <e@80x24.org>; Sun, 29 Jul 2018 06:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeG2Hxr (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 03:53:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40381 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeG2Hxr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 03:53:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so7737631ljc.7
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 23:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jR72BLsMaehyLRZtzxOyoNnnS2MN+sCFFCs/RQ7L2xg=;
        b=VCWb+jPr3gm8DkW+XiKPD2YHdlPLx69Ph9pBCZAWe7+/xcswy7PBuv8iQGkk1BTpc0
         BQlFYR1V7Wu86EuOPaNrEfaPIs/oc7qRsoDERrLOmIyefUxXmC4a/qBSsjwth5ox4V3Z
         xnwo1k1JMZe5vKc8sMEP70jdph6Qzh2hQYTMdWED07Fo482igUi8Qq08hTRlinxwkST5
         61LIpZ/WBcpnXjysxay+rZSkNvsMvjP9Fzyp2O2lhU0UOBykGnsqfiozpW2lFoRGT7fp
         VvnBQCaV1WOiflCgaIfhvIngfgh0HQJnMvvf5yUyeGMjv9EPabRoS7nYrnMdZ3TnbfTf
         qxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jR72BLsMaehyLRZtzxOyoNnnS2MN+sCFFCs/RQ7L2xg=;
        b=bi7zzPG+X6AVVH1e+YujlvUzacs54HO612Kcmb2ufnc4/L3bi+OsSy4I2gAaIfRnYz
         FqO32wbb8Oo7dF2sW/E+2LNKNE5JsBXkSM6BdsjJZE39aU5UmPUErJFIEvFMnygY55/M
         pXQdPaasBbYvUHzXDAmdXmPVVCXY2d4kYZ5p48vYpJ9Z96Uqf8iNBp1718CdmaCauxEv
         f6WuHaL8sshPshmOiNtUxjMYoA/O/YMMc0EiCgKraCnjGVqrod+mKjKKGJaifX4qgji1
         WKanDQfv9m8Cl5pjhLCrP6ICOgJ6nmSqlTlZStKjZUHUzWbnkV2ZtChCDk7iOiPg35YA
         ytzA==
X-Gm-Message-State: AOUpUlGwlv8W2Y3hEEkR8eU1NjzqoD92gY1Tiy43d22+dZz+mKT2ipR3
        PFkEeNv8KH/GXeF96BgzpHI=
X-Google-Smtp-Source: AAOMgpc8qwibAnAB3BpUmw3R3fFgMJhgrqAg0p3cq1sdmzmLa+N+X6Cwcta/f/snigRPo0julhANMw==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr8918275ljc.29.1532845467885;
        Sat, 28 Jul 2018 23:24:27 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u4-v6sm1089821lfc.51.2018.07.28.23.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 23:24:26 -0700 (PDT)
Date:   Sun, 29 Jul 2018 08:24:24 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180729062424.GA22870@duynguyen.home>
References: <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
 <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
 <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
 <20180726163049.GA15572@duynguyen.home>
 <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
 <20180727154241.GA21288@duynguyen.home>
 <xmqqpnz8ob2x.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CeF53pA8jfVcY+50-Y_HLm0KkzWvDcTgGV0692hsTHZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CeF53pA8jfVcY+50-Y_HLm0KkzWvDcTgGV0692hsTHZA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 07:52:33PM +0200, Duy Nguyen wrote:
> Just FYI I'm still trying to reduce execution time further and this
> change happens to half traverse_trees() time (which is a huge deal)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f0be9f298d..a2e63ad5bf 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -201,7 +201,7 @@ static int do_add_entry(struct
> unpack_trees_options *o, struct cache_entry *ce,
> 
>         ce->ce_flags = (ce->ce_flags & ~clear) | set;
>         return add_index_entry(&o->result, ce,
> -                              ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> +                              ADD_CACHE_JUST_APPEND |
> ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
>  }
> 
>  static struct cache_entry *dup_entry(const struct cache_entry *ce)
> 
> It's probably not the right thing to do of course. But perhaps we
> could do something in that direction (e.g. validate everything at the
> end of traverse_by_cache_tree...)

It's just too much computation that could be reduced. The following
patch gives more or less the same performance gain as adding
ADD_CACHE_JUST_APPEND (traverse_trees() time cut down by half).

Of these, the walking cache-tree inside add_index_entry_with_check()
is most expensive and we probably could just walk the cache-tree in
traverse_by_cache_tree() loop and do the invalidation there instead.

-- 8< --
diff --git a/cache.h b/cache.h
index 8b447652a7..e6f7ee4b64 100644
--- a/cache.h
+++ b/cache.h
@@ -673,6 +673,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
+#define ADD_CACHE_SKIP_VERIFY_PATH 64	/* Do not verify path */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 
diff --git a/read-cache.c b/read-cache.c
index e865254bea..b0b5df5de7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1170,6 +1170,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
+	int skip_verify_path = option & ADD_CACHE_SKIP_VERIFY_PATH;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
@@ -1210,7 +1211,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	if (!ok_to_add)
 		return -1;
-	if (!verify_path(ce->name, ce->ce_mode))
+	if (!skip_verify_path && !verify_path(ce->name, ce->ce_mode))
 		return error("Invalid path '%s'", ce->name);
 
 	if (!skip_df_check &&
diff --git a/unpack-trees.c b/unpack-trees.c
index f2a2db6ab8..ff6a0f2bd3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -201,6 +201,7 @@ static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 
 	ce->ce_flags = (ce->ce_flags & ~clear) | set;
 	return add_index_entry(&o->result, ce,
+			       o->extra_add_index_flags |
 			       ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 }
 
@@ -678,6 +679,25 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 	const char *first_name = o->src_index->cache[pos]->name;
 	int dirlen = (strrchr(first_name, '/') - first_name)+1;
 
+	/*
+	 * Try to keep add_index_entry() as fast as possible since
+	 * we're going to do a lot of them.
+	 *
+	 * Skipping verify_path() should totally be safe because these
+	 * paths are from the source index, which must have been
+	 * verified.
+	 *
+	 * Skipping D/F and cache-tree validation checks is trickier
+	 * because it assumes what n-merge code would do when all
+	 * trees and the index are the same. We probably could just
+	 * optimize those code instead (e.g. we don't invalidate that
+	 * many cache-tree, but the searching for them is very
+	 * expensive).
+	 */
+	o->extra_add_index_flags = ADD_CACHE_SKIP_DFCHECK;
+	o->extra_add_index_flags |= ADD_CACHE_KEEP_CACHE_TREE;
+	o->extra_add_index_flags |= ADD_CACHE_SKIP_VERIFY_PATH;
+
 	/*
 	 * Do what unpack_callback() and unpack_nondirectories() normally
 	 * do. But we do it in one function call (for even nested trees)
@@ -721,6 +741,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 
 		mark_ce_used(src[0], o);
 	}
+	o->extra_add_index_flags = 0;
 	free(tree_ce);
 	trace_printf("Quick traverse over %d entries from %s to %s\n",
 		     nr_entries,
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..94e1b14078 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -80,6 +80,7 @@ struct unpack_trees_options {
 	struct index_state result;
 
 	struct exclude_list *el; /* for internal use */
+	unsigned int extra_add_index_flags;
 };
 
 extern int unpack_trees(unsigned n, struct tree_desc *t,
-- 8< --
