Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E49C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96179208D5
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RavdCIZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgFRUaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:52 -0400
Received: from mout.web.de ([212.227.17.12]:33573 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgFRUav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592512246;
        bh=1TbkLs96cwZ2YyGpViOtMbkA7udJuLItISfiOb+06RU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RavdCIZ9y2cK1pdxpnGeLp6F7Fvm+jCrEnjHae9hdB9sFvtz6wMtSXP8Qm5mgbg2T
         C8m7GFFr55CQdIsCk/X+B9UwZD1EsdPkmS4fAxg16Db582NzZ/Z7++kpQReoatJnuP
         wHf+FZC9Bwtu3sN/I/nRSQeYXWizp5l8rZFaWmdU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZeVM-1j2nve2cXc-00lTL9; Thu, 18
 Jun 2020 22:30:46 +0200
Subject: Re: [PATCH 2/8] commit-graph: unify the signatures of all
 write_graph_chunk_*() functions
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <65eb15221c8d3b631d6d7105d0e901433bc7f23b.1592252093.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1e0c501e-3d2d-55b2-431a-f6760a184a80@web.de>
Date:   Thu, 18 Jun 2020 22:30:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <65eb15221c8d3b631d6d7105d0e901433bc7f23b.1592252093.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TsTe8Wi6UVnjJqO0mVkqlbNboz61EQ28IdJEyYnIxhrjCKrSUwD
 ixQkaqsrWGKjDaaRZtUxMc13G7iMtM3LNYb0igpZ65Sv2fJlkdMSiCsQZemWLXzG4TOZHqI
 3u+uF1onROivG7N6IBeYVMi5hhPjTWszGjQD/6ml7VzVi7eBATJBogRX2yxCyqEieE47RR8
 aI1nf4gAX4myI50mFk/AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9xAQgyo/GG4=:FEWNz61qaJxYAMCl7fb4Ll
 WJYkOBw/ZDNarrUBoD0l8Ysiy+YWzgssHxmqZ9mW5ZtrtjaCym56Jc2D1xqQ+XcirBwowe03T
 QvlX4ylGleQzDjO+jGAC5SghIKO4OIihy70Ehc4ftM9ogl2MbqTPhbITjRZWDg6yh/zzPfpib
 GXrGkwE0gWB/aoJ2eh6uVOmAvzVKsVNL3KNl2lvncWeIyflp7xeCzV6E2VAOmoDslYH1KowJd
 DJTDehRLENIy5KcWD/SjM5gwzF1cESqS6gh25pZyK3SWJtJcrb+9DIO3is8PajBqmpqU57IEX
 RNZqGp54q5kVVzLGAlRSNboI/IvfP92Yu5NRTS2Tj8P297DQl1olIHZOJzdrn5zNvHPwTINqT
 Sz5JIyXHqL+JLXblS+Bf1RkHI9t+uK2LGSym5gz6n6AT5gp6JQL7gl78osI/lmBOw7eS/D7QB
 Pq+9XdZcDGgThe3WWGDvrK4chPcTBwl4+IjfLTV3d6tFdwZIxRAq4/RriB7gvANzj9I0kJDz5
 C8Ucm24L6Xij8SxpqRCVbRJJHudVmYAfsN4K8pGOIt7pBDz8MxCwqfiZss0Wytc/s28WJUWX2
 upYmPKfq6/Slicm+GKuJY1VPlOoJkyatyngzgc4Xd2Re8k/j65JkcS5X13V0kOQu1Zf12LqYu
 qlEXHPR3tZmns1w7HNtE7slMgkxRVlCTCHYWjonVD8YG3vamIHY3DKWAjQVa0ITmW9YwTdtnc
 lXfWVi4j7CCGiD33o1KeINnERTIMQp4xfP6yB7i+lPQb5nwXxNv97mFTw+Z3KLyxec8IgpNuX
 022d/+hcxzV1kn0BnKDvSEjlh//qrlKMsXFbqNGZmKEqSxfHDZuCEYAp81rQz/2xoJqwSufMQ
 fJOGrvmsO37NgC3l2DriLZptQ/i0fAAn8VcwIZ8ZvoGJJTSlvbeWrRm7pswzAmgh1aNHMxRJr
 9g0au30btAEzgZ008zuEHMXk2EEHoeuuhU2wMNvy0cb83Kv0slN0sbCItK6ZSrxZ1oSkXWW3R
 WJ7mfIi8CPdDNAP2JxGufnmbwQS0pmbplFqdHnf/ofvGoz6Xy3nGb3yi0jTeNYnkR4acjlPMm
 oskO+LMyXgZyPb7/qVIZdugB33JOjcr2VDjnzBygmttE/LT+1BiuALIqtUnG6Cuu3jz5NeGa9
 BOu1Ay/yel62wBm/mFa/Bo+wOFhnGtf/U+0EyrpqWdP1k4hppskjU4nz0fbrNjKTCYyLM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.20 um 22:14 schrieb SZEDER G=C3=A1bor via GitGitGadget:
> -static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
> -				   struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_oids(struct hashfile *f,
> +				  struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	int count;
>  	for (count =3D 0; count < ctx->commits.nr; count++, list++) {
>  		display_progress(ctx->progress, ++ctx->progress_cnt);
> -		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
> +		hashwrite(f, (*list)->object.oid.hash, (int)the_hash_algo->rawsz);

Before the cast was forcing an int into an int (huh?), now it forces a
size_t into an int, but hashwrite() expects an unsigned int.  Do we
really need that cast?

>  	}
> +
> +	return 0;
>  }
>
>  static const unsigned char *commit_to_sha1(size_t index, void *table)
> @@ -926,8 +930,8 @@ static const unsigned char *commit_to_sha1(size_t in=
dex, void *table)
>  	return commits[index]->object.oid.hash;
>  }
>
> -static void write_graph_chunk_data(struct hashfile *f, int hash_len,
> -				   struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_data(struct hashfile *f,
> +				  struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> @@ -944,7 +948,7 @@ static void write_graph_chunk_data(struct hashfile *=
f, int hash_len,
>  			die(_("unable to parse commit %s"),
>  				oid_to_hex(&(*list)->object.oid));
>  		tree =3D get_commit_tree_oid(*list);
> -		hashwrite(f, tree->hash, hash_len);
> +		hashwrite(f, tree->hash, the_hash_algo->rawsz);

... and here's the answer: No, we don't need to cast.

Ren=C3=A9
