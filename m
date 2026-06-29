Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A31DE894
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762588; cv=none; b=icsh7HqnvA4UQgWIuYMVceWLQhyijyB+1TV42Pj6ALJAkDago6Q3hjAHQ0Wo5XTkfhbewKw8YAyob0zKwuxR5orAFa/lQrEUMmg6t6wETlpaM83q/Y+VGckuwWCEcXtB3Hig/qsjkhMtXn33MSNb1XWOvzVDiAHxCPTo64QJBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762588; c=relaxed/simple;
	bh=JjMxWCzz7Cba3xZkRvOQnjKn0vbu28Zf0BmIb6zHZh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZ6F0GQS2UH8UF84qcuCHn0WFsiCfxxBvh7SjqiXFxHQvVaQjaZHLPq8KU7bE4CJbD0ylkRrL/9lCU2byGPSi8S5G9FCRfhMRy33roGRph6JlQFaq5n6n2c0+43rAdVjqMZmyW5iIvXNudSsoaAh6UAUelw5NIlMwwoZPOUI1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VLGkB4BK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8KGv7f+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VLGkB4BK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8KGv7f+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CD80C1D0008B;
	Mon, 29 Jun 2026 15:49:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 15:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782762585; x=1782848985; bh=cCvW7TZrQR
	QQUJuI+o8jgbdaBSBLG1WtnKs5Y6Wh9uw=; b=VLGkB4BKcSAHVdOESQwsvulf1N
	s+0B3sC0Fu2D5A6jUOh2TPLB5h990os6770CofQo/3UqnukedWrbKXynbo6mIJKj
	DSIB38LwJhbm+XzfojAC2uRfGLZ3Yw08spmyuPavpbsaBhJSJV/botWJSo2aYBnk
	RDpDfTuhSFmIWgNDY6tHJjkIApe9hy2C4LgMhXWtJx1zpTgi7wte9PTW9P4Ry7nf
	vkB38Ilp6NGb9QrvAGi/lwBvFkVnB/3Ct2i+XAUINfwLj3FDwJTwKtK3y5+FRm3Z
	1tYlmruMQ2LMzFZK1HGVVLB7htwqXG00xkkRt1/6YqzBXpFD84nozjSoAxdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782762585; x=1782848985; bh=cCvW7TZrQRQQUJuI+o8jgbdaBSBLG1WtnKs
	5Y6Wh9uw=; b=H8KGv7f++4Oao9jCiGDyISpMw44DGTN/Vdb9/XGcxauCG1gm4CP
	pstWVIOyNK6uDj8rj+l4fr92xrWv+RmvQZe9Yxop44DXVluIKukvlBhzglEaHz0q
	19tycUNPbdaLcN/nnAuXhITDJ9vz1uVl0wO9fcoYMWOPozkZQH5rBTc9/sPHWcGb
	IkmqsDSvn2PAtnQ3WPl6HL666l/X9Pz7a3MgmUPKeT+fphKWP8cIzqMHjwSfVISQ
	S9Xq7k1ZWIBUZSS3JmzNJxLxqybwTZu7DRq/ru5jcPlGTpd+xbBFF2Tn/2q/JWxO
	XaPa999c7cS2KX7Zj5W5WjDPwz3rNBwEm5Q==
X-ME-Sender: <xms:WMxCatmNpyTyzw0y0PDi_7VpxILJ2YBv5ngMXjM45c5zgI8mWRIpJA>
    <xme:WMxCapjJg6Uy7zVP4V3b4pzB-ZKFalkn-CatPqYcYHY7kj6zswiHoi9aU_b2Vv-ay
    MBIZ8ks7zmGP1t1Cl32jxdB3ypEINxbEyTwtFZsX46DFn_g55rBCg>
X-ME-Received: <xmr:WMxCah06ENAYhtzeaEb4bLI8rmAjxN-ONW2uL61lr5NOyJ9GyEykPY6hGM8UmpVAJNrkSyaz5dRonwZ2hUQnqkcjhnGWC0vl1ShAT4A>
X-ME-Proxy-Cause: dmFkZTGObJNQNeab8+z3DuNOElpSTXaAaqvorjxewx2kGTFzG6UaSoNdGtL8JbUepXTrh7
    QEwfjnx7fGkD4Qlt4JX1ZAXXrmkOqMv9oS8YBevR3CWOqUPE90Bz8tdWwwCR1uZbb9HBl2
    7/90lHXFU9LG4brGnfzpBOvDTRNBHCjHILd91kys2JGaNm0B0LdOKCnE1cKpGwaVGB0rH9
    KYizbleG9oh2M+CaDLN0lqVNxkt88M1JeSofh5M26UuQwN7AEv9HuIb8PBTJZSfJaxyLo4
    xr2r+BFCnWdiH3rhceVfqfjvSs3/JeEAguiiU3iRDGmEI76FL+eoGGLuyUfheGEwQfIlCu
    Y2+n6SOEWjVADEDfXOv8FDp6mfWuUZOWmrPe2PxcnsFBwbgpIQe06pBaFNvoChKOFiIK7F
    I2Pndbz+e8wDuW+QcMcqwUcv3/OyU+a4+wuFVN8dVn2pwGRN0I3M0kTx6cg9JTLLP43jXm
    hJIm29+cF+ywXqeW01ToAf7vsod+pCDbmwH/Sye/unF350tytT/ju91vbwMcfBo8H3FqrO
    qvUbaLuuujvvDcYgO38FeqvVchds8GmenXIP3OlDJEd5Et5IO0qBBq8O+eTfdia1YnT9s0
    maf6cr4qJTfmPuBCmWZtYgNxY1yfykc+ZgBbOG/HxG1rXawgzHkT8kzy9liw
X-ME-Proxy: <xmx:WMxCaiIsKDalby0A8Ru7ghCr2Z2jukfpXDo46dExwWfFMpMDNERK2g>
    <xmx:WMxCahyy88UwVHWzC5K1ndE0QCnPhKrTaI2UV6dhejWiaB2dcEVbdw>
    <xmx:WMxCagX5AEMoKRc1rJOizI3Iy_5xED0Lcz3Lv41yVzvP2__ditjgXw>
    <xmx:WMxCahhDTeGIR1KB_TPbnnND_mvfSgZHf48vSqeOgWrP3gxy0T_WJw>
    <xmx:WcxCaqSf7kLGwW_rhTxL25VYt-K47gILpGhWjx2bo0h8vOixVkd4EmVb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 15:49:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Pablo Sabater <pabloosabaterr@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v7 11/11] builtin/history: implement "drop" subcommand
In-Reply-To: <20260629-b4-pks-history-drop-v7-11-6e9392a957d8@pks.im> (Patrick
	Steinhardt's message of "Mon, 29 Jun 2026 09:34:37 +0200")
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
	<20260629-b4-pks-history-drop-v7-11-6e9392a957d8@pks.im>
Date: Mon, 29 Jun 2026 12:49:42 -0700
Message-ID: <xmqqv7b1unxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static int find_head_tree_change(struct repository *repo,
> +				 const struct replay_result *result,
> +				 struct commit **old_head,
> +				 struct commit **new_head,
> +				 bool *changed)
> +{
> +	const struct replay_ref_update *head_update = NULL;
> +	struct commit *old_head_commit, *new_head_commit;
> +	struct tree *old_head_tree, *new_head_tree;
> +	const char *head_target;
> +	int head_flags;
> +
> +	*changed = false;
> +
> +	head_target = refs_resolve_ref_unsafe(get_main_ref_store(repo),
> +					      "HEAD", RESOLVE_REF_NO_RECURSE,
> +					      NULL, &head_flags);
> +	if (!head_target)
> +		return error(_("cannot look up HEAD"));

Here head_target would be something like "refs/heads/master", or
whatever the "HEAD" happens to point at.

> +	if (!(head_flags & REF_ISSYMREF))
> +		head_target = "HEAD";

But if it is not a symref, then it is a detached HEAD.  We manually
set it to "HEAD" again.  We know head_target was not NULL, so what
did we receive in it from refs_resolve_ref_unsafe() call, before we
overwrite it here?

> +	for (size_t i = 0; i < result->updates_nr; i++) {
> +		if (!strcmp(result->updates[i].refname, head_target)) {
> +			head_update = &result->updates[i];
> +			break;
> +		}
> +	}

We see if we are going to update the currently checked out branch.

The .updates[] array was earlier populated by the caller that called
compute_pending_ref_updates() before it called us.

> +	if (!head_update)
> +		return 0;

And we return if not.  That is a simple and happy case.  Otherwise
we'd tell the caller about the updated commit and tree (strictly
speaking that would be redundant, but since we have it already, it
is better to give them to the caller instead of forcing the caller
to unwrap the commit).

> +static int cmd_history_drop(int argc,
> +			    const char **argv,
> +			    const char *prefix,
> +			    struct repository *repo)
> +{
> +...
> +	struct option options[] = {
> +		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
> +			       N_("control which refs should be updated"),
> +			       PARSE_OPT_NONEG, parse_ref_action),
> ...
> +		OPT_END(),
> +	};
> ...
> +	ret = compute_pending_ref_updates(&revs, action, original, rewritten,
> +					  empty, &result);

Here we call the function.  When action is "--update-refs=head",
doesn't this code in compute_pending_ref_updates() ... 

		if (action == REF_ACTION_HEAD &&
		    decoration->type != DECORATION_REF_HEAD)
			continue;

... skip any reference name (loaded by load_ref_decorations() lazily
by calling get_name_decoration()) that is not "HEAD", which would
mean we end up not finding any hits in the find_head_tree_change()
function call we make later ...

> +	if (ret) {
> +		ret = error(_("failed replaying descendants"));
> +		goto out;
> +	}
> + ...
> +	if (!is_bare_repository()) {
> +		ret = find_head_tree_change(repo, &result, &old_head,
> +					    &new_head, &head_moves);

... here?
