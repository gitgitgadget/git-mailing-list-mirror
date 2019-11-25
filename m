Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1B4C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435302082F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fxE4etDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfKYPUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:20:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:39877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbfKYPUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 10:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574695241;
        bh=w+n3SYWgVUcBAnGBtEbYRjxwo+u2a1KLYoHyBZbE6v8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fxE4etDLseu8lvt3ThCWo4mS+RUI3rh9ut770HWXETwoZe2yLFXv411V0KumRMntr
         Ek/aOFu5aXJ/OTynJldg7QGe99HvPH3f19hlgtmWQxT6uQgwa8BvC0a31WfxhkGnwA
         Z3JMSbAARqlIunqsaGbUEscR6aDqTq881zsJ1dj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1i6mNa2c0d-00mMxz; Mon, 25
 Nov 2019 16:20:41 +0100
Date:   Mon, 25 Nov 2019 16:20:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/8] built-in add -i: allow filtering the modified files
 list
In-Reply-To: <xmqqeey18xha.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911251558200.31080@tvgsbejvaqbjf.bet>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com> <1844c4d55e21c40cbdbfdd73c82b4a1a074ff184.1573821382.git.gitgitgadget@gmail.com> <xmqqeey18xha.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jUUNsgHwwOdZNsJbBDGuclShUPm8mHbXOaUGF3Uq0nnGBv7MCsP
 Ayl1d8xJjXW2UQb9lx8O5PRpQljjDrJie5zKm9JdbSPUnxBMYhWNLG6nsUY2Taz3NNdlNhj
 H9sy6ndQ/KfE8w+62ep4g/2lXUBlgmyFzO4ba/a7X9A4KayYO4MFfIadsz0gplC3d3jc1bt
 ChOSU3rSLnpz+B/sKPruQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kQBN7Q9OcjA=:nqae2Loxmyzde2woNHxwS5
 GX9UCQ01t1kn4xB6/KijzK893MA7SRAa/TobiEE0JnF9D8tge2863Ab69wEVF8wjAFuELKAd1
 t4JRzbTwGM55xgH64soNNkbYwyA8r37MnVFEH7Yw41anLDoq8YhxHQL9vh/mlUBzKB3Xjzgo1
 ZQaSrDMN0m0+DcVhICJR6KT2keP5ohrCTYWNxuINTbAh4NmEJ9y8+6K/Fcu/XvSzqBbb/RPGp
 5hXM3Y3Aax/HDfxiP5NvhcqObMdicEbu1dmaCLTTqZQ4Xu3P4loBiqcD3PqP7PJA3lfAjkG6J
 RbNPet/qGgWw7k0Gz6mxrzDNITmNLHN0r8kwdvkv2Fcj09RUwK29s316TDw1aHDnFdyCokBqH
 thXKJWmub+2PBHC9hNpN7bo0PcJvUWsQsQ0wkEIf+JGuBNaKdoqjvxCqGRkxKBwcT6fUXzPeN
 3RbRJY6l3cPfOt3KihU2zBw6uMDZdK2NrZ1sBWiG2NHOuBWGYlRbyb2gY2yGhQMAx4ex9YPoS
 Rf8RVXhRisc50FypUAXJ80M/3XU76gxzwE1oZFcQD5hDqSnme6Y98QHjLyQN0Z7NLRlvPOzrN
 15wfiurDYZndjoHIa1ZO9/M9UyCtjImDPHWOytlf0Ti4tvmryywU/OAq2ce9MnE6bj6y2VF+y
 A5859DZXEpZmdHE3u7zKoOb9q/6DYkcCqJT7Y4xeb7LnEr4wk8xakFCO9hv4KhE+1k7meeiDQ
 kBH88ZvJCUYg+IDQ3HUZb05ebnCIvlUwKAo7CRSJfP5BfyXKEvQ19hdc6XAqYsVvHrhIFGOEh
 g62LuSVjRBIpfdykhU8F+Uw+dVSf9AWX55hUlbdJqrqA8HqDmm+u7mHklqrAmwcT5uqicAbdb
 SYD6QxJhnqDQSh5RBhVHAKuWTVxUg97ZxAyD+dWFpz2L3wg4mOioqOXQTdM4EZf0PNYbzyaNu
 DnpszAM8MN7a2ktyRJfS+eZrACkYb8YSd9Zz90QJ7LIBe12wHkZkFdCxEeF8eFiW/XQ/Q/NJu
 e4gzK5viXBv43vvDa8IYqzPrvarplEyRAbZ/6k75DtHwfU7M1MVRG+XjFR4G3XEHduIyM5bA2
 tHVTGVjBI6BYd8ZC08/qjfBlSx8PTj2xurkJo5Bhr3q8YFD/HGttIgVbYnZf6tljDV0LIcHPe
 RcpVU/kAOinrOpMjpb7unYHa0KnOsYp85rDA6u0B5bpluP9eVbYSza/iwV2WjP6j5GKlQGZyO
 SaSRwdT46Kr4kxBN2+BsCfJ5o5nUbflCgcqyENVY3BslKKZ8hEBjRLJIexgA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +enum modified_files_filter {
> > +	NO_FILTER =3D 0,
> > +	WORKTREE_ONLY =3D 1,
> > +	INDEX_ONLY =3D 2,
> > +};
> > +
> > +static int get_modified_files(struct repository *r,
> > +			      enum modified_files_filter filter,
> > +			      struct string_list *files,
> >  			      const struct pathspec *ps)
> >  {
> >  	struct object_id head_oid;
> >  	int is_initial =3D !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
> >  					     &head_oid, NULL);
> >  	struct collection_status s =3D { FROM_WORKTREE };
>
> Will have a comment on this later.

Yes, you're right, this initialization does not make sense. I changed it
to `{ 0 }` because I still want the struct to be zero'ed out.

> > +	int i;
> >
> >  	if (discard_index(r->index) < 0 ||
> >  	    repo_read_index_preload(r, ps, 0) < 0)
> > @@ -411,10 +424,16 @@ static int get_modified_files(struct repository =
*r, struct string_list *files,
> >  	s.files =3D files;
> >  	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
> >
> > -	for (s.phase =3D FROM_WORKTREE; s.phase <=3D FROM_INDEX; s.phase++) =
{
> > +	for (i =3D 0; i < 2; i++) {
> >  		struct rev_info rev;
> >  		struct setup_revision_opt opt =3D { 0 };
> >
> > +		if (filter =3D=3D INDEX_ONLY)
> > +			s.phase =3D i ? FROM_WORKTREE : FROM_INDEX;
> > +		else
> > +			s.phase =3D i ? FROM_INDEX : FROM_WORKTREE;
> > +		s.skip_unseen =3D filter && i;
>
> ;-)
>
> Looks somewhat crazy but it works---when the caller wants to do
> 'index-only' for example we are not interested in paths that did not
> appear in the INDEX side of the diff, so we run FROM_INDEX diff first
> and then the let next one (i.e. FROM_WORKTREE diff) be skipped for
> paths that are not in the result of the first one.  To me personally,
> I would find the tertially expession written like this
>
> 	s.phase =3D (i =3D=3D 0) ? FROM_INDEX : FROM_WORKTREE;
>
> much easier to follow, as it matches the order which ones are done
> first.

Sure, that reverses the order, but it makes it more intuitive because `i
=3D=3D 0` happens first. Changed.

> Also I notice two things.
>
>  - It used to make 100% sense to call this field .phase because we
>    always processed the first phase and then on to the second phase,
>    where the first one was called WORKTREE and the second one was
>    called INDEX.  In the new world order after this step, the name
>    .phase no longer makes any sense.  Sometimes we run diff-files in
>    phase 0 and diff-index in phase 1, but some other times we run
>    diff-index in phase 0 and diff-files in phase 0.  The variable
>    that has the closest meaning to the 'phase' is the newly
>    introduced 'i'.

I renamed it to `mode` in this commit. While I usually frown on renaming
fields in the same commit as introducing changes in behavior, I think in
this case it's kind of okay because it does not add many lines.

>  - The initialization of the local "struct collection_status s" at
>    the beginning of the function still uses .phase =3D FROM_WORKTREE
>    which might be somewhat misleading.  We cannot remove the whole
>    initialization, as the original used to nul initialize the other
>    fields in this structure and I suspect the code still relies on
>    it, but the initialization of .phase in particular no longer has
>    any effect; it always is assigned inside the loop before the
>    field gets used.
>
>
> >  		opt.def =3D is_initial ?
> >  			empty_tree_oid_hex() : oid_to_hex(&head_oid);
>
> By the way, this is not a new issue introduced by this patch, but I
> notice copy_pathspec() is used twice on the same rev.prune_data in
> this functino.  Who is responsible for releasing the resource held
> in this struct?

Good point. I assumed that the diff machinery would take care of this, but
it does not. So I introduced another patch to fix up what is already in
`next`.

Ciao,
Dscho
