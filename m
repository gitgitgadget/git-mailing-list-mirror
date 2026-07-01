Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7F40910E
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901295; cv=none; b=tz6ffzvv/uK3tCvOyCFGjYZyLQvL9o5MaSTRClm9qXKht6YhAHW0L6hISCY6YKkHilGd7hzLoZbouOBawZGHDs5ioPM+LF5OBURViZcSsIyre7CiKUfny7GoTe7tZHe8G1byXaxJn90quXKh9KKfC8JNTswEYOze8ELeDwB0pYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901295; c=relaxed/simple;
	bh=fAqMmM33WmdsqmJqbcG6gG758HYHUTQV5MFg7XEHCZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaFJHFl6B68baBnOaEHsc7jPCW4qpsUPtuA6uiiDabSVnuesIlHv7k2cRob+EJ3HFj6Fw5KJhKbEmY9zmk1AbXK1fSzgIkJBtntS/7qLJCa+02YK4xOvmibrdfUWAxPuMsIGzfTdGxAon0fzXmKcJjmcB9NdkLKUoZA2mZUVsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v4zH3tUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JN1jY1Mr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v4zH3tUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JN1jY1Mr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BCFCEEC0181;
	Wed,  1 Jul 2026 06:21:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 06:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782901293; x=1782987693; bh=2l6p/3r5Aq
	I34UtY5uceYfOWw+jRq2fJLe7rugerWN4=; b=v4zH3tUGMtO9ODSCzncjeE942b
	yGwPtwA9fgiFQor6bMPjBnzYzMCLxiYoeHXE25w8wXV1KeDDaxAtj8sXY+17Ky0d
	6u6sEc5jvPooeutqhlzvE2z8w9GkgcN3bZLZigcV/p1RSZ57xcsYVKVwLI8ZzNee
	p2xPDjDo9BbIwdga6f9fr4UkXz0hATZmjAIZnrxMQHd5YNziNYM6jfAUGPEjFQI8
	u5LkfyM4sGXt7SouRYYIWgji3D4aL+Hi38sMo/s2sGQRvpBMev2AgyIXAl6l8CRM
	+nxzSpiyW9UEobDkJcFmikFjfZVuziQrzL5+FL9yimt60cx107LRmW+6AYQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782901293; x=1782987693; bh=2l6p/3r5AqI34UtY5uceYfOWw+jRq2fJLe7
	rugerWN4=; b=JN1jY1Mr2dCP+CVlaXSzPq9F448NwdJT4m27HuC5tRCTq9coYfP
	SD+PUV+IRA6BMjOX7fQpv605K9L/27id3607Rt66K7Pfo5+L+225SflkQC4PAKW+
	LumHOECyQ8Qp8Mdlr2i9cRp9PW3s6rfj/KBqsMsuPZfTcNVjMmMUMbxyEnkyNESc
	FIuUNucxm4NEirLyw/fIWeciiluo+bb5FHYaElnQ1tcOPFXO7EE9PoX9t61IkGL4
	gwBIr+hYR+g+8B2bTImOssWUAiyaUnf6j0F0sd/hTOxpeyX58JhYsYhcUdLGxVyP
	etSHKgI9HXmeN8VZko4aoUZ8Lbk2FKloFyA==
X-ME-Sender: <xms:LepEatOmzrud3uJyc7F91-XgPjRl1DYiJvjhQm6WcknuSOMZVAfkRA>
    <xme:LepEapQJUEkOPn_e15j3t4UntCfkLbhwYIOzffVXLwdGUiLfcQtMr0GxfqjhuqsUd
    DavnUJwppIKyoTbLamrVY4eIhSpTkIO8yLiIItTVUkyOhJ-DsZ-yw>
X-ME-Received: <xmr:LepEajjblLLLPBiUJBC8teKRnd8zcz8W09OSW4gZzJbOB3eNo5GvLwAZhxxvTsbuxfm-x6_Fg6AVKnV_8YbJM_V-NckJbp3zhLcRsYGj-Mw>
X-ME-Proxy-Cause: dmFkZTGwU5AlBVLANVN5GzNPsI3GWLLkbxFI2Ga5K94+WIfEcPa+YxLcAMR+SkoWyM7Yli
    N8USxr24byKnWIKcqkWDJcr7wL+G+iV55R/0zpgffVTdFKC6xaP3cpl4avU5dg6wmFjDiR
    i3/ERi0avMUPNMSZ6zximmSYPB6qresFTj7RYm007iDkH/tvK24Eu6b0X3D6EbaPCkfuL2
    /LTmWWoOwPhaZxEwzjqgwkMoAme5cp+sFWOE26WIHCV9/XVDSL7UbEYB6ROlpGz2oXRUJO
    GlqhX6usjzT764IEACOi0oXCAyogtfAMdzWCG7oiqy2xqmp07+Wo27ZXTqnZVQ2zH/UHV4
    obJ7kmozgTwTfPNc6mx91TTm5kh+f4EeB2/daJK9DoMn1JafViz+xFIPKnhWrE+eNoCPkQ
    pb98jYMjbApGyk/p1RErn7yQkb7bz8RyooGYC0BzqE3mFck+fWS+PVFKIcDgJlJdLBFX8r
    1pK/R1Uf+UdSjb7oUtv4J9ftdpOI2GwfNJXjFtoTk9ZlPjqH8EDqUQG5jmWKLg12Sge3OF
    UhLprFxv+34TPMr4wO8itnR3LzeuUPOd4EqRmyyYecAs4QCHDspWoFGLRgxHmGrxrBHeso
    G2w6Z5QkImw2ahxeOuANJSUgFvJO4vDmGL3sOgIWe6oJX963IYClU/hywM+A
X-ME-Proxy: <xmx:LepEaq_FJf1UpuHeafpy_83bEOdwF76Q7fi2w8nL-lxBvz_uQ1aYdw>
    <xmx:LepEaiHcDMbQuAKxmsG5yIyarUiVVgHKBYVokLGAeoIFesGcD2kMVw>
    <xmx:LepEallkeWzcr-dGR4PilRo9Eo4NfqI-yq30vNp8FtxBp7iqtf2ubQ>
    <xmx:LepEauaLJ9snyfT4QVlnRfPgNbtbn_U6cA2kQl1e1vk7llta_j_K3g>
    <xmx:LepEaoHOOhV_z5kJfeyiuitH0LiKdD5kK_MflqJd93grgVCC37uqaqAk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 06:21:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1276944 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 10:21:30 +0000 (UTC)
Date: Wed, 1 Jul 2026 12:21:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v7 11/11] builtin/history: implement "drop" subcommand
Message-ID: <akTqJw0qlN0RGfyz@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
 <20260629-b4-pks-history-drop-v7-11-6e9392a957d8@pks.im>
 <xmqqv7b1unxl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7b1unxl.fsf@gitster.g>

On Mon, Jun 29, 2026 at 12:49:42PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +static int find_head_tree_change(struct repository *repo,
> > +				 const struct replay_result *result,
> > +				 struct commit **old_head,
> > +				 struct commit **new_head,
> > +				 bool *changed)
> > +{
> > +	const struct replay_ref_update *head_update = NULL;
> > +	struct commit *old_head_commit, *new_head_commit;
> > +	struct tree *old_head_tree, *new_head_tree;
> > +	const char *head_target;
> > +	int head_flags;
> > +
> > +	*changed = false;
> > +
> > +	head_target = refs_resolve_ref_unsafe(get_main_ref_store(repo),
> > +					      "HEAD", RESOLVE_REF_NO_RECURSE,
> > +					      NULL, &head_flags);
> > +	if (!head_target)
> > +		return error(_("cannot look up HEAD"));
> 
> Here head_target would be something like "refs/heads/master", or
> whatever the "HEAD" happens to point at.
> 
> > +	if (!(head_flags & REF_ISSYMREF))
> > +		head_target = "HEAD";
> 
> But if it is not a symref, then it is a detached HEAD.  We manually
> set it to "HEAD" again.  We know head_target was not NULL, so what
> did we receive in it from refs_resolve_ref_unsafe() call, before we
> overwrite it here?

True, this is redundant indeed, as the returned name would already be
"HEAD" in that case.

[snip]
> > +static int cmd_history_drop(int argc,
> > +			    const char **argv,
> > +			    const char *prefix,
> > +			    struct repository *repo)
> > +{
> > +...
> > +	struct option options[] = {
> > +		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
> > +			       N_("control which refs should be updated"),
> > +			       PARSE_OPT_NONEG, parse_ref_action),
> > ...
> > +		OPT_END(),
> > +	};
> > ...
> > +	ret = compute_pending_ref_updates(&revs, action, original, rewritten,
> > +					  empty, &result);
> 
> Here we call the function.  When action is "--update-refs=head",
> doesn't this code in compute_pending_ref_updates() ... 
> 
> 		if (action == REF_ACTION_HEAD &&
> 		    decoration->type != DECORATION_REF_HEAD)
> 			continue;
> 
> ... skip any reference name (loaded by load_ref_decorations() lazily
> by calling get_name_decoration()) that is not "HEAD", which would
> mean we end up not finding any hits in the find_head_tree_change()
> function call we make later ...
> 
> > +	if (ret) {
> > +		ret = error(_("failed replaying descendants"));
> > +		goto out;
> > +	}
> > + ...
> > +	if (!is_bare_repository()) {
> > +		ret = find_head_tree_change(repo, &result, &old_head,
> > +					    &new_head, &head_moves);
> 
> ... here?

No, because `replay_revisions()` populates the result with the resolved
branch name, and we're also searching for the same branch name inside
`find_head_tree_change()`.

Patrick
