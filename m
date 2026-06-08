Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F230F531
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911052; cv=none; b=Znc30DOTnMJYUAwnsTEvM1NJWlCa9CM5cNTnSIGFLVQsq4QVrM1VgTT2oPl2FOgdgXLpagnKBwOU+rhgj+fKPosLAnC9UUCFd+mt4ACohYdubDzvdYAMPCgDRYM+i90moqP/WZdoFfq3P+n9P292n78Oz7HbdEJ/ez10BssHxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911052; c=relaxed/simple;
	bh=XPJZFNBxPP8dZXBm4nbwBJZb4TIegGSK6h7iJR7ENAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlkOuib0LooiAnGgA3R2dbDRULKj34srdfuF9Lt1toy0xtVWxeTwFD5R8/MrfwR5Wfcy9UZzQqw2vOZxhGEcEz4RfbDDaajjTTrhAiIvf6P8mnsxSIanW8sC9FSvw0nUvHNtCwu3yfXLNzvm18l/W2zJBvcdxBQP0KyjWhk5SVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r5tgKONO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkoEnq6/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r5tgKONO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkoEnq6/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C6741D0007F;
	Mon,  8 Jun 2026 05:30:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 05:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780911049; x=1780997449; bh=4Z8pJh8tm7
	p2G/EGdMR/eH1K4hwlg/DCtVLWNeoupYM=; b=r5tgKONORPdbSQZmafmZGGul1E
	MXRGr0q8Q/RiUL1IRgwfrxDIYR2a0K4Og00Mzj3ZpzL1x0CVygyz+8p+vZg0Aigc
	jXY0Yy7Z/4Eemay4aFrsju7WJiR8wpq6tyrH/W5sXQ0a1CSP4oWOO2xTGUYyzOAE
	a3dJDBS3ZM9fOwFFXXZ/bCn9nHj4uKvw2p2p9+Ov1/nVw/Q+VFXpIid+Uf4EFK2z
	OYy04R5Vl6XFLVEEbdjo8z7oRkmUOQIHO69QuYkCPaDhqTko7cLaI48AnQzvJ0L6
	bRR7qsG/3amcAw5c/1JNhwhrWLvarh8u83UrbqPS460nK2pyeZmnlrWVgbZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780911049; x=1780997449; bh=4Z8pJh8tm7p2G/EGdMR/eH1K4hwlg/DCtVL
	WNeoupYM=; b=IkoEnq6/PYmKzClUE7XL3jy9+XAq4nzCCU266bGIaxecqDOlPua
	sFlwWy/h2xwNbLZCOcYQ02DyN3l0vKN+4RCAgO0sTzl8o8FYOGZG737tpcPuDk7k
	fLXmdg30YxTBN1kve6vpPvkns32/ptYuhkQhLXzWEIMfTqBr8mJ4HK9hxDyG/E9u
	H93408tem37TAAjmbiUO0f6tMARsMvA5gAJQN3lnZp/7eFz8m7zE2DyblzDSqMZj
	vDOzouHSNoIgXDnTIl0nMLHoDbAklm69sujphp6d/hSTQTiPW8quwawKzkBIaJ9j
	Ag/MAVxfr+QI6smZgk22jjusXwb8rqrSzBA==
X-ME-Sender: <xms:yYsmamRZqVzlJ8izbD3GmABP9d78C854YVjLyzt43UYbiFjovvvZXA>
    <xme:yYsmajPfbGwmpPkN0ZGFqtsO0wQBI_ZUbvC9jO0WSRuOnKefbkMBE5tqs_qtDmCgl
    WO2SSUJk-EQzAqhjtxdcA6UY2qv7tpEXuPdDSmAAAUmtt4mTsxauvg>
X-ME-Received: <xmr:yYsmahPjZCzqXNLeGAgjYac_lPuR9lL-yrR2d50qcQwGbigI_VM-SWma1wMrxNzkoFtoHvUwH72BVCW3Inuu6CDmCaO777t-WMjYDBsmuA>
X-ME-Proxy-Cause: dmFkZTExxN63Rg98H8tCWH1pTT0zhMgr+xFXlOVCENOmIy70A8sme81HElmYt/kZmfB+bo
    HpqA8L8pFQ4zm1saOGTPS7FrGssGP10QgNueDfXkh2vCpMjG6E2ao/vVH+BtCbxSPha5o9
    +qA4H3HxlCwPipAIH9B1SpgrmmmkuNZQvjxnOTJq+v9eckl8NXb06Kf8puUI4h3GeVFOC1
    SBcYZk7dFEVWLV1rUQpfB+tI4fzmrdZkteAkmCTl96t4ZUNxvfSdeO7mjiZLbiqnd+bLpx
    gW4pExhkNXqh7VNOCCOlmY9QrVqt24YYdIo6FH4QFXrPGG6WFBui/lwMfanH8gDG/wM1nl
    nojm7igfOh/jUAuCB2OwndpBRK3DJcZQEtSRJ+jCJ3iDIkCHfkq1bMEQgQBqknuf0buk30
    ae8VskH/G9K8dAflfEgbVnGqbaIreB/0NjUXTjxe6pOxbPam3av8LvcJeTxgwa2d2QMMud
    ome8pCL7pq07OQbUn7rCu0Vz+ILC1Z21n3e51VHBt0Ny2OT5wwyaNHg5LMMlaAj/EgqZZu
    yBm4smTGfNqPTKb+U0lmc7hBoqKdoIsRo2CrvTdyX62udOQfaVvYDIC8VRXchkTwsINEjF
    VVHU/rD7rlqqTqjWU2mXo7PM6Y0yIzpJBW+NDw1x35Nebf4SR7xUatVSQ5QA
X-ME-Proxy: <xmx:yYsmartERkPBr0Cz22DwbdX2eXAgrJGAuY0dy9CSsvpGPY7CIIoUDg>
    <xmx:yYsmajXBcLfMzehFPK2fB2NgDvSZIJxXyJGuvyXWE6NM00sEWWMc4w>
    <xmx:yYsmartiBYaqTTz5Oc9hIdrtezg0N9UqvU6CoCzFYkWlPfviW4JBSw>
    <xmx:yYsmanUVNoOj5GEwuFRLdLvPlhyf2UQeTuJ2-AOrhtSAf2gJ3V2cQA>
    <xmx:yYsmaqoyHNq4W1yyjaGIBSscqK0QHzXS1pvqdhANT83qzXpowp8Ik6x8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 05:30:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8550d341 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 09:30:47 +0000 (UTC)
Date: Mon, 8 Jun 2026 11:30:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged
 message
Message-ID: <aiaLxNwGPko5HS2G@pks.im>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>

On Sun, Jun 07, 2026 at 10:07:20PM +0200, Pablo Sabater wrote:
> When using `git history reword` if the new message is the same as the
> original it continues anyway creating a new commit with the same
> message and updates its descendants, modifying the history after this
> 'reworded' commit even though there was no actual change.
> 
> `git commit --amend` and `git rebase -i` + reword share this behavior,
> however `git history reword` is different:
> 1. Works in-memory without touching the index or the worktree [1], so
>    there are no side effects like staged files that could justify
>    rewriting the history when the commit message is the same.
> 2. `git history` by default updates all the branches [2] that contain the
>    original commit making it more costly than `git rebase -i` that only
>    updates the current branch.
> 
> Add a check if the original commit message is the same as the new one
> and abort if so.
> 
> [1]: https://lore.kernel.org/git/20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im/
> [2]: https://git-scm.com/docs/git-history#_description

Nit: I feel like both of the links don't really add much value.

> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  builtin/history.c         | 10 ++++++++++
>  t/t3451-history-reword.sh | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/builtin/history.c b/builtin/history.c
> index 0fc06fb204..51a22a9a1c 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -135,6 +135,13 @@ static int commit_tree_ext(struct repository *repo,
>  					  original_body, action, &commit_message);
>  		if (ret < 0)
>  			goto out;
> +
> +		if (!strcmp(original_body, commit_message.buf)) {
> +			fprintf(stderr, _("Message unchanged,"
> +					  " aborting reword.\n"));
> +			ret = 1;
> +			goto out;
> +		}
>  	} else {
>  		strbuf_addstr(&commit_message, original_body);
>  	}

We also execute this logic via "git history fixup --reedit-message", and
here it wouldn't make sense to abort the commit in case the message is
unchanged.

Patrick
