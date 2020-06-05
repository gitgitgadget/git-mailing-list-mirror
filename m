Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F0C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE231207D8
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7KSt8cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgFEXXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgFEXXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 19:23:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA327C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 16:23:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u16so6771411lfl.8
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wx6ds5c/A/4jzULpnJGBZWj9+xvG32MKkcpuVWdlSXM=;
        b=H7KSt8cn11IdHWgnLzaYZP8O07FhpoLAxK4WZZwyKWKXK7kudohj9fuWWJcRVcIrLE
         CmAyL1p/rZrHVoGHBYjTRCYdS2swa4OAuG1tu16JYcaEJ9iXns2nuU4gLsgcJgO5/APW
         xIy2uKg66eeCUGlLObIwMYNRWDHIZMWuqhtHsvw9+tqeb4aa5GHJFuO0OkE+jH/j1Bcr
         FfIp1uNEXSG+wiP/Civubaxhj8p7fu61YoNyQVcWBsqb3FnmZksOc6yhpsBPAIP48hQJ
         9HcM5A+G0D47/ynFVq7UQi0XPwlgiKI9kt8J6NWr+TxfOdXijN3h69PQk+fL+SqOku6f
         0tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=wx6ds5c/A/4jzULpnJGBZWj9+xvG32MKkcpuVWdlSXM=;
        b=fE2IkV4Uy7/oHv0lnKXnVzQg1uf1UJSqz15qS/1fNm505YD15SdozdN+58WsmhH+pv
         0zp/7YSuqlgGVm3pNFGTRMVcLGWjujJ88t1wjtQtuPXJc4N6r1DFnKEuQqWxiJKBRRQr
         KB7LVo4lBLE0TZDyGJ5JkdNdV/zT5RtikycUBFg5me7bx8yDi91ZmboL8in9q6EeLW2L
         UUywoVJctLWdRuQkLzM+RIwVUarehwr96vWt4mHWhIdjx+jtohdiOcW1bUnkWljxxVfU
         DG61pH9i6QMeDlM1Nl8mNAOLejQSRdxI6OV96ruUDgkZ2Fjof3q/G5dCjLEMr1hMLqjc
         XO5w==
X-Gm-Message-State: AOAM532o18BXKD0yQrnhrP46yDgSRRd97bDPDHuIX0k/pQRLermkqY3J
        vc5v0D4WBqiFm9Hz4XOla0ifykJiIMc=
X-Google-Smtp-Source: ABdhPJyece+DxLj9KBfPbB9lFqsE+uL3lHpuUd4cknxVn3tn1zmnooBETZkFi6+DV9KIZSzboK4JUw==
X-Received: by 2002:ac2:5314:: with SMTP id c20mr6511390lfh.75.1591399407398;
        Fri, 05 Jun 2020 16:23:27 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id x23sm1490942lfe.32.2020.06.05.16.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:23:26 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC Patch 1/3] commit: introduce helpers for generation slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200604072759.19142-2-abhishekkumar8222@gmail.com>
Date:   Sat, 06 Jun 2020 01:23:25 +0200
In-Reply-To: <20200604072759.19142-2-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Thu, 4 Jun 2020 12:57:57 +0530")
Message-ID: <857dwlw102.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> The struct member generation refers to "generation number" (or more

Again, a minor thing: 'generation'.

> broadly, a reachablity index value) used by commit-graph to reduce time
> taken to walk commits. However, generation is not useful in other
> contexts and bloats the struct.
>
> Let's move it to a commit-slab and shrink the struct by four bytes.

It looks like the description is from earlier version of the commit,
before it was split -- because this commit does not remove 'generation'
member from the 'struct commit', actually.

This commit is about creating helper functions.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 27 +++++++++++++++++++++++++++
>  commit-graph.h |  5 +++++
>  commit.h       |  3 ---
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index e3420ddcbf..63f419048d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -87,6 +87,33 @@ static int commit_pos_cmp(const void *va, const void *=
vb)
>  	       commit_pos_at(&commit_pos, b);
>  }
>=20=20
> +define_commit_slab(generation_slab, uint32_t);
> +static struct generation_slab generation_slab =3D COMMIT_SLAB_INIT(1, ge=
neration_slab);

All right, we need this for the following helper functions to work.

We might want to encapsulate all commit-graph data together, in a single
struct (e.g. as 'struct commit_graph_data' instead of uint32_t here).

On the other hand other data is stored on slab often as separate
scalar data (contains_cache, commit_seen, indegree_slab,
author_date_slab, commit_base, commit_pos), but not always; sometimes it
is a struct (bloom_filter_slab, buffer_slab, commit_rev_name), sometimes
it is an array (commit_depth, ref_bitmap, commit_weight), and sometimes
it is an array/list of structs or pointer to struct (commit_names,
commit_name_slab, saved_parents, blame_suspects, commit_todo_item).

> +
> +uint32_t generation(const struct commit *c)
> +{
> +	uint32_t *gen =3D generation_slab_peek(&generation_slab, c);
> +
> +	return gen ? *gen : GENERATION_NUMBER_INFINITY;
> +}

All right, this is a synthetic getter using the fact that commits
outside the commit-graph should get GENERATION_NUMBER_INFINITY (because
[effective] commit-graph is closed under reachability, is full DAG).

Should we have something like that for 'graph_pos' and
COMMIT_NOT_FROM_GRAPH?

> +
> +static void set_generation(const struct commit *c, const uint32_t genera=
tion)
> +{
> +	unsigned int i =3D generation_slab.slab_count;
> +	uint32_t *gen =3D generation_slab_at(&generation_slab, c);
> +
> +	/*
> +	 * commit-slab initializes with zero, overwrite this with
> +	 * GENERATION_NUMBER_INFINITY
> +	 */
> +	for (; i < generation_slab.slab_count; ++i) {
> +		memset(generation_slab.slab[i], GENERATION_NUMBER_INFINITY,
> +		       generation_slab.slab_size * sizeof(uint32_t));
> +	}
> +
> +	*gen =3D generation;
> +}

All right. I wonder if putting 'generation' and 'graph_pos' on the slab
together, gathered in 'struct commit_graph_data' would make this helper
more complex...

> +
>  static int commit_gen_cmp(const void *va, const void *vb)
>  {
>  	const struct commit *a =3D *(const struct commit **)va;
> diff --git a/commit-graph.h b/commit-graph.h
> index 4212766a4f..653bd041ad 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -8,6 +8,10 @@
>  #include "object-store.h"
>  #include "oidset.h"
>=20=20
> +#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> +#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> +#define GENERATION_NUMBER_ZERO 0
> +
>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_=
LOAD"
>  #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANG=
ED_PATHS"
> @@ -137,4 +141,5 @@ void free_commit_graph(struct commit_graph *);
>   */
>  void disable_commit_graph(struct repository *r);
>=20=20
> +uint32_t generation(const struct commit *c);
>  #endif
> diff --git a/commit.h b/commit.h
> index 1b2dea5d85..cc610400d5 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -11,9 +11,6 @@
>  #include "commit-slab.h"
>=20=20
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> -#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> -#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> -#define GENERATION_NUMBER_ZERO 0
>=20=20
>  struct commit_list {
>  	struct commit *item;

Why this change?

Best,
--=20
Jakub Nar=C4=99bski
