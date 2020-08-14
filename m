Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD6BC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 08:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE32207DA
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 08:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JJsYeyiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgHNIVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:21:32 -0400
Received: from mout.web.de ([217.72.192.78]:34729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHNIVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 04:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597393286;
        bh=Al2MjlMyk9kNEek0sI9ZHG8i3/kI5c2rOi57v3bTgyI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JJsYeyiD7cn6JKoEi/l7CLhI1WRs5/GA1r39sg18SahB4gDgF+B6L2720POtGsJiZ
         PrCUn6tXuM4rTr006Oj5ZkasTp9TJvH0IGl89caXxU3BmclKmPqwSwrY1sjEBZ9ubQ
         PYAA20VFQWNSkK7FbttVYneEQtUp3OjS9pIC+DKw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2jWI-1kph6Y0sw8-013Fhj; Fri, 14
 Aug 2020 10:21:26 +0200
Subject: Re: [PATCH v2 1/3] mem-pool: add convenience functions for xstrdup
 and xstrndup
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
 <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
 <6d679c5b46541208f5fa714174555ff0dc756b9a.1597384820.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e7ef099b-5d96-ff67-5d4e-b6fa306adb38@web.de>
Date:   Fri, 14 Aug 2020 10:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6d679c5b46541208f5fa714174555ff0dc756b9a.1597384820.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AwVLdRwarzX0jObYN7VTmtXbV/q73UianMt0eezOXWCNFwnHvkL
 qJuOJxyYuhtOYN6MHwMby3p/7OXfw96+VAmGbF1lhPDmG3bspM4t99fzEDA4s6qxlrG3VXJ
 jZDwdA+tVywd2hpsFOhN991Kne41Zn0+OCXIe34+PISARbeqzcXrJ5M2eB7HoIaCndWoo07
 RftCupJiozxzcABdPWzkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A2JPJ9YvSSs=:tPZsWDOAoS169+9lKIXiMi
 7C8LMzDhc6Rc8dUxsMsJl0UNqUdtElWdmWxSNE9Cfz5R1CgG2QYF4vwZvRl3EbpBEASiK9uyt
 yCKNjgCnUYLCoLCHxayg2TkIbQelX831CLgxFelyRB3+8QNLnYS7n3Tdl6WgAWFtucwxYJcYG
 vGEloir3IJITjBk3SonyxZQydci/To2jLqE+bRWfyb3NfrzIBsqc50ALQvhUzQqzc/QpQC1g9
 Vu1cviLKSV4vC9UGnQWffeSqVNgRI8OkhOKaQt2o3M48qc6ltRMqw25TRisOX1jymRMEc1B8U
 5Wm3nSNNZN9uKraRucBPxwt7s6ovK1IFRTMcqScw3KcodEmP0LjuvZID3Qg+EN6x7s8YhnVNr
 xMiTfUZ2lOJ7f3UJS17RVtuPoraU9WL25d36jXRIl466KBFdWw0xjFNJKAvZ7MOpStMJjROlG
 GlnroCqPEWWFxVy+uA0hT9ts8E2YcgaNrmkAxlvXFSCG1311BET9DHXcqg9IHuHyQ7I6BZZh6
 afqC4Wn3jrCoED0nlSrnHLqQ+se+r6qwLNwhcprA3xofhxPQ3YEyNrL0B44qYJA1mzfVQDM7V
 EH473yxoD3tMEYucSo5REeo3m4tePiF+5NohxtxhwtENAEEfqMvImlEUj6CgFux3IPVGXYBMm
 smH0ZWiNkLAS2mKlBqNjkBGNT0rq4Pj/HBHfedtwUrWKV/+AcrvSwis+vWd5uO5U8rtg/oJC/
 0rf3poTmxklx5Gl3FNkRpqgEC8r6Xs85UUGiQmwyvYhUfO8Z5OFaypwW9OAK7xBSsAtX0zw4f
 G6yJgR3hTqdTxx/i7XOudntb5cov21voM1/KPS7RYZvvjwv1/8bXzheTg/ZimZ7dkBjkXinnP
 IMwjb0FmCaZRoYdxIMUjD52QSJyC7/PBXSv2GT65ljRoJgzJ40bStZxqeQKNExshU0t6ggSKR
 tm6SlcQ1yLvO91gEej6SJqs6JlNPLx3LBlu7kGCIPIi0ZOX4a/gT/DTD3IO0jEoxglCSzgd7K
 35gVrX+V28qg0ak1oLLiwtMGX6PCTTAeWNqRNL76WqfDt14sHmIOdyCadqf996h3xqLAuGxNj
 95WoNm8/zfsViCptLTIysTJEMhbgo2gl3/g7NbrMcXyBcgw8hgV3T9byadnIXrRflQocQ4UjU
 qe9Qqb2b2xI/mZaY/CbZnNfKYJ9O9YsPfx9/6Uosa0eAdarX0wt8pbGIdJc5bApJAm/EewYH9
 EHFaQC+n1l/n5bkUy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.08.20 um 08:00 schrieb Elijah Newren via GitGitGadget:
> From: Elijah Newren <newren@gmail.com>
>
> fast-import had a special mem_pool_xstrdup() convenience function that I
> want to be able to use from the new merge algorithm I am writing.  Move
> it from fast-import to mem-pool, and also add a mem_pool_xstrndup()
> while at it that I also want to use.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  fast-import.c | 12 ++----------
>  mem-pool.c    | 23 +++++++++++++++++++++++
>  mem-pool.h    |  6 ++++++
>  3 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index ce47794db6..dd5b563950 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -526,14 +526,6 @@ static unsigned int hc_str(const char *s, size_t le=
n)
>  	return r;
>  }
>
> -static char *pool_strdup(const char *s)
> -{
> -	size_t len =3D strlen(s) + 1;
> -	char *r =3D mem_pool_alloc(&fi_mem_pool, len);
> -	memcpy(r, s, len);
> -	return r;
> -}

Note: No "x" in the name and it doesn't handle mem_pool_alloc()
returning NULL.

> -
>  static void insert_mark(struct mark_set *s, uintmax_t idnum, struct obj=
ect_entry *oe)
>  {
>  	while ((idnum >> s->shift) >=3D 1024) {
> @@ -615,7 +607,7 @@ static struct branch *new_branch(const char *name)
>  		die("Branch name doesn't conform to GIT standards: %s", name);
>
>  	b =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
> -	b->name =3D pool_strdup(name);
> +	b->name =3D mem_pool_xstrdup(&fi_mem_pool, name);
>  	b->table_next_branch =3D branch_table[hc];
>  	b->branch_tree.versions[0].mode =3D S_IFDIR;
>  	b->branch_tree.versions[1].mode =3D S_IFDIR;
> @@ -2806,7 +2798,7 @@ static void parse_new_tag(const char *arg)
>
>  	t =3D mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
>  	memset(t, 0, sizeof(struct tag));
> -	t->name =3D pool_strdup(arg);
> +	t->name =3D mem_pool_xstrdup(&fi_mem_pool, arg);
>  	if (last_tag)
>  		last_tag->next_tag =3D t;
>  	else
> diff --git a/mem-pool.c b/mem-pool.c
> index a2841a4a9a..33fda1c411 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -102,6 +102,29 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, si=
ze_t count, size_t size)
>  	return r;
>  }
>
> +char *mem_pool_xstrdup(struct mem_pool *pool, const char *str)
> +{
> +	size_t len =3D strlen(str) + 1;
> +	char *ret =3D mem_pool_alloc(pool, len);
> +
> +	if (!ret)
> +		die(_("mem_pool_xstrdup: out of memory"));

Can mem_pool_alloc() actually return NULL?  It will rather die because
it uses xmalloc(), right?  So that check is unnecessary.

And since "mem_pool_" already implies that these functions won't return
if an allocation fails, no extra "x" is needed in their name.

> +
> +	return memcpy(ret, str, len);
> +}
> +
> +char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t =
len)
> +{
> +	size_t minlen =3D strnlen(str, len);

Hmm, this would be our first caller of strnlen().  wrapper.c::xstrndup()
uses memchr() instead.  It was added in 2008, and strnlen() is in
POSIX.1-2008, so back then it made sense.  Perhaps there are still
systems out there without one?

> +	char *ret =3D mem_pool_alloc(pool, minlen+1);
> +
> +	if (!ret)
> +		die(_("mem_pool_xstrndup: out of memory"));

The same comments as on mem_pool_xstrdup() apply here.

> +
> +	ret[minlen] =3D '\0';
> +	return memcpy(ret, str, minlen);
> +}
> +
>  int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
>  {
>  	struct mp_block *p;
> diff --git a/mem-pool.h b/mem-pool.h
> index 999d3c3a52..fcaa2d462b 100644
> --- a/mem-pool.h
> +++ b/mem-pool.h
> @@ -41,6 +41,12 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t le=
n);
>   */
>  void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size)=
;
>
> +/*
> + * Allocate memory from the memory pool and copy str into it.
> + */
> +char *mem_pool_xstrdup(struct mem_pool *pool, const char *str);
> +char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t =
len);
> +
>  /*
>   * Move the memory associated with the 'src' pool to the 'dst' pool. Th=
e 'src'
>   * pool will be empty and not contain any memory. It still needs to be =
free'd
>

