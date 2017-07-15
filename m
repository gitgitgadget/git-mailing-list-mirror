Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E752082F
	for <e@80x24.org>; Sat, 15 Jul 2017 17:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdGORTW (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 13:19:22 -0400
Received: from mout.web.de ([217.72.192.78]:64565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdGORTV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 13:19:21 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbrUu-1dy61J2mjE-00jM2C; Sat, 15
 Jul 2017 19:18:53 +0200
Subject: Re: [PATCH 30/33] tree-diff: convert diff_tree_paths to struct
 object_id
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-31-bmwill@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <28328b72-40c0-f6bb-09dc-574ca33ce622@web.de>
Date:   Sat, 15 Jul 2017 19:18:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170530173109.54904-31-bmwill@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ma7jKbzv3uczSpURF2Opx4/C6SPAxjENAY2CzIL8NhRWdDKOyeq
 0CXj4ZBYCY3mGAlodOIxniaPWddJRh0ASVsaj20mTTRZoHOYaH2/Y0DG9sUhVqziaI3iKDQ
 OrIh6MgNvYuGCqjxuYVqFdhUZq5Bf2tngYnnwNGKQbYQM9eaSnp6f94QD+smRh62WHKpVig
 VFzoJpWk44Gxz/HqMcltA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mrQWI7GFOjw=:1dNOtP4jrEzKE89/k2Av4N
 AbcKMuvzozdXlv58a2NB3NNoWHp6JqrrO9CRWD0xtIobViLpQKi149VW4NF82wAq5893W+ZaY
 P1iAdgmG7veuKzttHKiE3p+9P+1rgwF+UZHq9TMWGK/MtzD68e8n5NLIfatZpzwM8kja2dzfc
 lrNkEcAJVWUBXD0SQAfUixciNfd7KnS18jnja7U/480+PUBMbJGCdk3ygeRTkzS9HQvz25r7K
 IKgj5Jyp3iAXkuy8iKYe9G6ZcsxXCaEPUDRKR3jdvd96u/xvgtzA2jhE5DVxIeR/e8jqjkQE8
 lNUDFeEEJEFBCFyQQHuxxtTo3QXi7pCQ/76lfZoyYR3J1dx3SUc3L/Q1akFd0udrHbu99qe1r
 uPRcbeY2bcbmqudaKO+bvuvEG/tJibOHEsrTzMY5ocRIeb69cMGSwdAE+2GhKwxACdo0um2lm
 bHYHmHqTKChHTH6oosEnWfCRsPvadUni6jSNtVNjztn83vnktWUSGw6o4m6TmffPOofujsYQv
 CSw/b6sUM1tBr0UQrOphZW2wj2QWC0kQuyQl7C29BVeGVuyUNw/SKzd/9YEbO0kbBSUGU7VgM
 0G3iZaCa1HKWqQ7S0jRu0tz/QpFQSUkxjwzY1kF+5yTiTX8aoOqQdmEsmsvFXE+ViaTbHN2Xu
 ntlNsfO/2k/o363jpd8OJoB9AasOkZZtPqXXHZL44QLhZLr84WHzWU1haPczka0j8f5skJX37
 yI3IPMOee0WtyNlttgzu/pLiaidFE5kYvg+LnJ3bKabtJXOJlBGdsw3d5QGeKEXpP734gwAlS
 AUN5LrL+71/fZVIrqyqNfBqkpGG9AvKFHyDlnhXgDQvfiLfLBE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.05.2017 um 19:31 schrieb Brandon Williams:
> @@ -273,21 +274,20 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
>   	}
>   
>   	if (recurse) {
> -		const unsigned char **parents_sha1;
> +		const struct object_id **parents_oid;
>   
> -		FAST_ARRAY_ALLOC(parents_sha1, nparent);
> +		FAST_ARRAY_ALLOC(parents_oid, nparent);
>   		for (i = 0; i < nparent; ++i) {
>   			/* same rule as in emitthis */
>   			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
>   
> -			parents_sha1[i] = tpi_valid ? tp[i].entry.oid->hash
> -						    : NULL;
> +			parents_oid[i] = tpi_valid ? tp[i].entry.oid : NULL;
>   		}

So elements of parents_oid can be NULL...

>   
>   		strbuf_add(base, path, pathlen);
>   		strbuf_addch(base, '/');
> -		p = ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
> -		FAST_ARRAY_FREE(parents_sha1, nparent);
> +		p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);

... and we pass that array to ll_diff_tree_paths()...

> +		FAST_ARRAY_FREE(parents_oid, nparent);
>   	}
>   
>   	strbuf_setlen(base, old_baselen);
> @@ -312,7 +312,7 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
>   
>   
>   /*
> - * generate paths for combined diff D(sha1,parents_sha1[])
> + * generate paths for combined diff D(sha1,parents_oid[])
>    *
>    * Resulting paths are appended to combine_diff_path linked list, and also, are
>    * emitted on the go via opt->pathchange() callback, so it is possible to
> @@ -404,8 +404,8 @@ static inline void update_tp_entries(struct tree_desc *tp, int nparent)
>   }
>   
>   static struct combine_diff_path *ll_diff_tree_paths(
> -	struct combine_diff_path *p, const unsigned char *sha1,
> -	const unsigned char **parents_sha1, int nparent,
> +	struct combine_diff_path *p, const struct object_id *oid,
> +	const struct object_id **parents_oid, int nparent,
>   	struct strbuf *base, struct diff_options *opt)
>   {
>   	struct tree_desc t, *tp;
> @@ -422,8 +422,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
>   	 *   diff_tree_oid(parent, commit) )
>   	 */
>   	for (i = 0; i < nparent; ++i)
> -		tptree[i] = fill_tree_descriptor(&tp[i], parents_sha1[i]);
> -	ttree = fill_tree_descriptor(&t, sha1);
> +		tptree[i] = fill_tree_descriptor(&tp[i], parents_oid[i]->hash);

... and here we are in that function, dereferencing a pointer that may
be NULL.

> +	ttree = fill_tree_descriptor(&t, oid->hash);

oid here can also be NULL, but I think that's not as easy to see.

-- >8 --
Subject: [PATCH] tree-diff: don't access hash of NULL object_id pointer

The object_id pointers can be NULL for invalid entries.  Don't try to
dereference them and pass NULL along to fill_tree_descriptor() instead,
which handles them just fine.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
fill_tree_descriptor() can easily be converted to object_id, by the
way, which would get us rid of the extra check introduced here, but
this patch is meant as a minimal fix.

 tree-diff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index bd6d65a409..2357f72899 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -421,8 +421,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	 *   diff_tree_oid(parent, commit) )
 	 */
 	for (i = 0; i < nparent; ++i)
-		tptree[i] = fill_tree_descriptor(&tp[i], parents_oid[i]->hash);
-	ttree = fill_tree_descriptor(&t, oid->hash);
+		tptree[i] = fill_tree_descriptor(&tp[i],
+				parents_oid[i] ? parents_oid[i]->hash : NULL);
+	ttree = fill_tree_descriptor(&t, oid ? oid->hash : NULL);
 
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
-- 
2.13.3
