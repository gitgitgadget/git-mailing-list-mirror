Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD72F1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbcIIN3v (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 09:29:51 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33003 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbcIIN3t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 09:29:49 -0400
Received: by mail-oi0-f44.google.com with SMTP id y2so141492197oie.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=7OUSj4roR9Zxfqsg78KjDabHcNJNoNeIqOsItPdmP40=;
        b=U8cS8Q7iYH3l9iKRJ6aulLznbZ9jtSl/capHaKVoBBVKhybgr6llI9jAxnyOALdaPg
         5B/M2/5VP6jCu9KZb8HcM6x6LhnRx0pWXUljPLMoAYLkTRqZwSW+oRAGhrQR4WxTNsGX
         78OHmlQKVEPlGRmJodpBCT2Wrxj3Gg9kfQt2VjcxnKQc+u7dum6xhnpXFHdA/Zq+3ZE5
         2XMSMoHr5+q+FhYyHJcTsf6uR9ypyVFPhaf3tmB3g8OC/I6ujMVS44+gOhPSkP7eN/cm
         KPUmf5Zs82gn9k+r+wjNnQyCnKpnI/0X4thTyS/DetZKp5ieZJcYXIiTX17XK+eg+nMS
         ZDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=7OUSj4roR9Zxfqsg78KjDabHcNJNoNeIqOsItPdmP40=;
        b=c5zg94sDxS+Us0AThpWTatg3TMxgRdaI/B4SRLENuBBfAPgxhCJjlfCnnXdsaY+2Mc
         4gctO8bnTS/LRqB/QhPW39pMZuTREWvuh2aGo0zDzSRHDPzbRD1jv3Z0H296RlQWqt4g
         Ob08nMHIMSRAZVuraqTDJs3iAWsYPdjZS2URRUc8U23AbpPeNeuQBzfS5ULT6HKKO0Gs
         hJ30v7qNNKwo0WdEX2HzwhxkTUuTJqOgnqNGeL620XG5pJzAxnePqbgC/gBvWVAwl4C5
         oCnHAK/Aanz5rC6HlFKSZNWSqCcfd5328YkPPNUFrvq2f8yOlkIUmLIPGr9aQUwaKzDl
         QoSA==
X-Gm-Message-State: AE9vXwOljFj8oYyrd/7oAZIB3RJpSvLUBRR4WM4UOBCslaD3DWLXU/CQ4b/c7Nc5FoBJZQ==
X-Received: by 10.202.77.206 with SMTP id a197mr5465459oib.178.1473427788109;
        Fri, 09 Sep 2016 06:29:48 -0700 (PDT)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id b133sm1371726iti.21.2016.09.09.06.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Sep 2016 06:29:47 -0700 (PDT)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <pclouds@gmail.com>, <peartben@gmail.com>,
        "'Ben Peart'" <benpeart@microsoft.com>
References: <20160908204431.14612-1-benpeart@microsoft.com> <xmqqh99qf5o7.fsf@gitster.mtv.corp.google.com> <20160908213738.zgwgfy3nybkam3hk@sigill.intra.peff.net>
In-Reply-To: <20160908213738.zgwgfy3nybkam3hk@sigill.intra.peff.net>
Subject: RE: [PATCH] checkout: eliminate unnecessary merge for trivial checkout
Date:   Fri, 9 Sep 2016 09:29:45 -0400
Message-ID: <002501d20a9e$3c7de5c0$b579b140$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG+K9JOoUyszGeD3Yq7D9s9RK55AQFbwa6AAaxBwBSggKEVgA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Jeff King [mailto:peff@peff.net]
> Sent: Thursday, September 8, 2016 5:38 PM
> To: Junio C Hamano <gitster@pobox.com>
> Cc: Ben Peart <peartben@gmail.com>; git@vger.kernel.org;
> pclouds@gmail.com; =3Dpeartben@gmail.com; Ben Peart
> <benpeart@microsoft.com>
> Subject: Re: [PATCH] checkout: eliminate unnecessary merge for trivial
> checkout
>=20
> On Thu, Sep 08, 2016 at 02:22:16PM -0700, Junio C Hamano wrote:
>=20
> > > +	/*
> > > +	 * Optimize the performance of checkout when the current and
> > > +	 * new branch have the same OID and avoid the trivial merge.
> > > +	 * For example, a "git checkout -b foo" just needs to create
> > > +	 * the new ref and report the stats.
> > > +	 */
> > > +	if (!old.commit || !new->commit
> > > +		|| oidcmp(&old.commit->object.oid, &new->commit-
> >object.oid)
> > > +		|| !opts->new_branch || opts->new_branch_force || opts-
> >new_orphan_branch
> > > +		|| opts->patch_mode || opts->merge || opts->force || opts-
> >force_detach
> > > +		|| opts->writeout_stage || !opts->overwrite_ignore
> > > +		|| opts->ignore_skipworktree || opts-
> >ignore_other_worktrees
> > > +		|| opts->new_branch_log || opts->branch_exists || opts-
> >prefix
> > > +		|| opts->source_tree) {
> >
> > ... this is a maintenance nightmare in that any new option we will =
add
> > later will need to consider what this "optimization" is trying
> > (not) to skip.  The first two lines (i.e. we need a real checkout if
> > we cannot positively say that old and new commits are the same
> > object) are clear, but no explanation was given for all the other
> > random conditions this if condition checks.  What if opts->something
> > was not listed (or "listed" for that matter) in the list above--it =
is
> > totally unclear if it was missed by mistake (or "added by
> > mistake") or deliberately excluded (or "deliberately added").
> >
> > For example, why is opts->prefix there?  If
> >
> > 	git checkout -b new-branch HEAD
> >
> > should be able to omit the two-way merge, shouldn't
> >
> > 	cd t && git checkout -b new-branch HEAD
> >
> > also be able to?

Because this induces a behavior change (the optimized path will no=20
longer do a "soft reset" and regenerate the index for example) I was
attempting to make it as restrictive as possible but still enable the
fast path in the most common case.  If everyone is OK with the behavior
change, I can make the optimization more inclusive by removing those
tests that are not absolutely required (like opts->prefix).

To help ensure the optimization is updated when new checkout options are
added I could add a comment into the checkout_opts structure and/or put
a pseudo version check into the code so if the size of the structure
changes, the fast path fails.  That feels a little hacky and I haven't
seen that in other areas so I'd rather stick with splitting it out into
a helper function and add comments.

>=20
> I was just writing another reply, but I think our complaints may have
> dovetailed.
>=20
> My issue is that the condition above is an unreadable mass.  It would =
be
> really nice to pull it out into a helper function, and then all of the =
items could
> be split out and commented independently, like:
>=20
>   static int needs_working_tree_merge(const struct checkout_opts =
*opts,
>                                       const struct branch_info *old,
> 				      const struct branch_info *new)
>   {
> 	/*
> 	 * We must do the merge if we are actually moving to a new
> 	 * commit.
> 	 */
> 	if (!old->commit || !new->commit ||
> 	    oidcmp(&old.commit->object.oid, &new->commit->object.oid))
> 		return 1;
>=20
> 	/* Option "foo" is not compatible because of... */
> 	if (opts->foo)
> 		return 1;
>=20
> 	... etc ...
>   }

That is a great suggestion.  Splitting this out into a helper function=20
with comments will definitely make this more readable/maintainable and=20
provide more information on why each test is there.  I'll do that and
reroll the patch.

>=20
> That still leaves your "what if opts->something is not listed" =
question open,
> but at least it makes it easier to comment on it in the code.
>=20
> -Peff
>=20
> PS I didn't think hard on whether the conditions above make _sense_. =
My
>    first goal would be to get more communication about them =
individually,
>    and then we can evaluate them.


