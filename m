Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CBD1F461
	for <e@80x24.org>; Fri, 17 May 2019 21:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfEQVQL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 17:16:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:58519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfEQVQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 17:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558127762;
        bh=i0KsiQ08ZdZTdYp3rIcJS2czcfy1b8wBvkV8HuvxPgQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F67Oe341qjpeLTF7op343h50RyooB+SmvZTJtuTl2zJDxgrbSV066v3ez5rwnndyL
         C20ofG//8MZYCZe6vTzbyF0utB6DMl0ldGSGeAGyyYL0WdxlsQ9DWkc51fTQWuFh2N
         gGbtnf7J7X5hwPssk+X7Jx0CLbKppuprqrZIDpUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuOYx-1ghzcc3S6R-011gYA; Fri, 17
 May 2019 23:16:01 +0200
Date:   Fri, 17 May 2019 23:16:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC WIP PATCH v8 11/13] rebase: eliminate side-effects from
 can_fast_forward()
In-Reply-To: <20190508001252.15752-12-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905172301210.46@tvgsbejvaqbjf.bet>
References: <cover.1555832783.git.liu.denton@gmail.com> <20190508001252.15752-12-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2112050480-1558127771=:46"
X-Provags-ID: V03:K1:UdZpPL3eKaFW0xq8w4EWE2SryA5VnfJuf30SYzUfcc6DwTHnhld
 UA7uySNxwydD3NyLhuY2Gt7YwgApBeK6/B3rMohWdoPvEHF3gDStnvYAp7otrCLUbbW+8tk
 m6qIjM3mRVNPPM5LGhlHp9GOjZ6Hv7KWuwWhtaZc1CV+TL+75/g1uZrOZKik8z+AUVD8jCz
 napfvU4jWgSAJR0S10LpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhUYQWjsiYg=:NyP4t80FG3twQYJH98RfRZ
 C38PtZrrzKi+hG/zizJJMowkjVTsDgGlYt3XPqPykl260IkkNZozIQX3R7iTYzRL9TIvAlgtS
 urF9ctWp8ETTqAMqyzTJybVVVOZ85kHLVPj6/cmDx4OU+V90cpJ+V+wvUZJ0Sdv7VoBXWKeD/
 mEMt2tIyw+qf+8sYampMfhibdIxBcfZJr9Jzn9Xx9dTe+J2FtyzitFNd874/5Fl0UaWtV0LqL
 uBZUU1Mrkha9ciAFjU00InzmhkGvdR45IrwV1X4cpF0KW2Co2AoUGxoNYRNiAp7RKmy5MX5Qx
 MiNPoFfLhew+bv52ykhzB+i2gXRTtnIViHC+o+Vqoh8UcdMTFz3A/q+jnyg2Mnf1a/VLnZcKo
 nlKge69vdZGjy1kIb+ere30aYFRrx/qdGXl/sfDl0PrrwheHKKz80a8MxdmYX2QtMmLJLp/L1
 nUnOisarx4sJrhLW18+TXn5m20vYHDcoRiq67q13orb/CXF4GNk3KFZZARJA0i61RQnfjVaT3
 zXvA59do4iAnc8xWF5pOlmDdWrEkAHYOl7PJ1h8PDrbq2lmArbnQq4ClqNAs2YgwQiXwM6zDu
 LhfQ0/0EPkJ80xcVBplrEiwya6sGVXtYWfJjbndGWxRm8+6BwSDkGL7/DOG0+syeRonFYeCOy
 OOziijaO/0cDcL/uLGrNpdtaGCgmq/FJVUalu33Oza+UjvSNqMFiEKnagipTXVDLPAV10qNym
 m92oUsrqfkJhTQUEZAlZkZ04uZysx5PKsiXXrAn+RbUdsSfYA5ldo8pR6oABxY40ec3kHubhQ
 aZ6T6t68LVOoQwDAF4rixaD3wkGymucz3aHBp9YCJV3XvJsbdNukiSYQt+v//QM+yyvScn3r2
 DztRqqCSr8yvT3wkkTQsvkp3/QhtbZ6AsJmAquGyCH6WBbyFP0hIS+KisdQjHVkw78HIchNgo
 TPKYnXzLLLLiylRHe/zvaZSszstVPvWGP0e9G1EQCvLzfYQfrEetX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2112050480-1558127771=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 8 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The can_fast_forward() function is potentially much more expensive
> than is_interactive() since it e.g. might need to call
> is_linear_history().
>
> So reversing the two looks like an obvious improvement, but doing so
> reveals a previously hidden caveat: We need the can_fast_forward()
> function to populate data used later, namely the "merge_bases"
> variable. This has been the case since it was added in
> 9a48a615b4 ("builtin rebase: try to fast forward when possible",
> 2018-09-04).
>
> So let's refactor it into two functions. Now we'll always call
> populate_merge_bases(), and then only call can_fast_forward() if
> is_interactive() is false, making this both faster in pathological
> cases, and more importantly easier to follow.

True.

We might want to mention, though, what exactly that this "pathological
case" is: rebasing commits onto an unrelated history.

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index ae6b9b42b8..cb5d7fcb53 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -878,24 +878,30 @@ static int is_linear_history(struct commit *from, =
struct commit *to)
>  	return 1;
>  }
>
> -static int can_fast_forward(struct commit *onto, struct commit *upstrea=
m,
> +static void populate_merge_bases(struct commit *head, struct commit *on=
to,
> +				 struct commit_list *merge_bases,
> +				 struct object_id *merge_base)
> +{
> +	merge_bases =3D get_merge_bases(onto, head);

Hmm. This overrides whatever was passed in via the parameter. Did you mean
to make the parameter of type `struct commit_list **`, i.e. a *pointer to
a pointer*?

> +	if (!merge_bases || merge_bases->next) {
> +		oidcpy(merge_base, &null_oid);
> +		return;
> +	}
> +	oidcpy(merge_base, &merge_bases->item->object.oid);
> +}
> +
> +static int can_fast_forward(struct commit *head,
> +			    struct commit *onto, struct commit *upstream,
>  			    struct commit *restrict_revision,
> -			    struct object_id *head_oid, struct object_id *merge_base)
> +			    struct object_id *head_oid,
> +			    struct commit_list *merge_bases,
> +			    struct object_id *merge_base)
>  {
> -	struct commit *head =3D lookup_commit(the_repository, head_oid);
> -	struct commit_list *merge_bases =3D NULL;
>  	int res =3D 0;
>
>  	if (!head)
>  		goto done;
>
> -	merge_bases =3D get_merge_bases(onto, head);
> -	if (!merge_bases || merge_bases->next) {
> -		oidcpy(merge_base, &null_oid);
> -		goto done;
> -	}
> -
> -	oidcpy(merge_base, &merge_bases->item->object.oid);

Do we even use `merge_bases` after this anymore? I guess not. So we should
get rid of this function parameter at this point.

>  	if (!oideq(merge_base, &onto->object.oid))

Uh oh. With this patch, `merge_base` can be `NULL` at this point, namely
when trying to rebase commits onto an unrelated history.

>  		goto done;
>
> @@ -1154,6 +1160,8 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  		OPT_END(),
>  	};
>  	int i;
> +	struct commit *head_commit;
> +	struct commit_list *merge_bases =3D NULL;
>
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_rebase_usage,
> @@ -1703,9 +1711,14 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  	 * with new commits recreated by replaying their changes. This
>  	 * optimization must not be done if this is an interactive rebase.
>  	 */
> -	if (can_fast_forward(options.onto, options.upstream, options.restrict_=
revision,
> -		    &options.orig_head, &merge_base) &&
> -	    !is_interactive(&options)) {
> +	head_commit =3D lookup_commit(the_repository, &options.orig_head);

Hmm. I do not see this line (or any equivalent code) removed in this
patch. Is it possible that we do not need to (re-?)initialize
`head_commit` at this point?

I guess I should read the entire patch series because that `head_commit`
isn't there in the worktree I am looking at (oh, if only I had an easy way
to review code, but I have to review static patches instead, not even in a
proper IDE... ;-)). Will try to find time to do that next week.

Ciao,
Dscho

> +	if (head_commit)
> +		populate_merge_bases(head_commit, options.onto, merge_bases,
> +				     &merge_base);
> +	if (!is_interactive(&options) &&
> +	    can_fast_forward(head_commit, options.onto, options.upstream,
> +			     options.restrict_revision, &options.orig_head,
> +			     merge_bases, &merge_base)) {
>  		int flag;
>
>  		if (!(options.flags & REBASE_FORCE)) {
> --
> 2.21.0.1020.gf2820cf01a
>
>

--8323328-2112050480-1558127771=:46--
