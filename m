Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DC3CE4BE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976200; cv=none; b=ilzZbu/sNwl8FFowwSsBVc1bc+AMkrFWQttvwRcYrTV3wo6oYJ+qFHuTO4ibRzZJJa1OSsY8w3miCQ82AlfGbW5Z1OQOFJwDA0zlJv3ToHbjkoILGq/OXkSmc3iTXLGR6eKlTUWz0jzAiwJcloDYomlhxOIIlkpRlm+Z09SzzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976200; c=relaxed/simple;
	bh=g19TgEogklkU1UezN/RdwmLk03B+5ZZWzIf5fRsngQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Go6tGo3V9rbGr8qeSXfcPr3dW/L+tBSVnp3M8rWdpfpunSL/NMjg1AdFthD6A5YkjDNmjVDQDVwPkHM+CKCfcIvZzY2lf9jXusM1lbFUWcAjDVcQVeXcSlWRBytfsJXX8D+NOOE+iHUSephUeT4GopqxOtfaNVqyFqU19eTTVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LffPzXm7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hxdy+wgg; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LffPzXm7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hxdy+wgg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C650E7A017C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:23:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 17:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790976197; x=1791062597; bh=vgil8JLWfK
	m2kGCsOcQk3xfj5cRTNsF5uNwTtXoCNVI=; b=LffPzXm7Bm2WbCMmdKj9p1yYq3
	n3x3MTyYoSsZJLbFtIrUtBPvoWMKD7YtO0RrlE8JpHG9TYNgB1nDZNXZjYrf5jGd
	K9dfO/sB3zXHafj2QVhWhF59zBA8GmAfarCSaT+b1a0pQbeVHYYd4GmfXF27qf/u
	C8LpWLv8dJXZJIy85nqDY79rk6qFCvAI5O9Uh0NqHrxJktkqg1ucyQuOVWF4GBIn
	n8igC00SRLPzqPKrWSVWjQ1kSdd8t8KW/2O/4/k+5nCBJhV7eqcpJKDJFr8DIg9F
	vklmFVScYEkFvFZBVzQEOQJ3wheWkjPJUzqF0aXiYjHVr3yYnr1Rwm/Wy2Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790976197; x=1791062597; bh=vgil8JLWfKm2kGCsOcQk3xfj5cRTNsF5uNw
	TtXoCNVI=; b=Hxdy+wggl1QeSxUIhb/Xy+dGbIh3jaSkxdM7mJVLmeKkAoACtRV
	6knFGl2NMTtnPXVk8GSCb4TkMHsR7IyFCHT4wf1zgADlNr67FhHTPl2Po66huJN8
	X/Ft6dQ1W3ZgdNvHFb1HIVZ2EUOWeqAJ5rc8H4sM5/4M9CGmUkH8eJljqKLGNzyH
	Ip+12d9Kd8tGIRk8UTJT4Zkp0jepPhscai1c1fPWAk5x83y5pxGyFGLRRfHP4Px0
	h3jxsqqK2/CD1qwPVM4cMgKI1omwoIGubeC+rvaiu7ILZtEUEfXlS+l0uduOplAA
	wWMhXrkwkatDm+a0+CccgdwTREp4mxux9cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790976197; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fJUsSVSBrjemgbeFl7ubwfmvArDF9nRKGhLVjiTtNMk1z8j
	T2E1aZlg4ooUCVdE9qbJiSXSM88IypLbwHBBOM7vwW2EiCKd4IYFYUZ6L7bRZZh2
	5p9Uqi6OW09hjY2BNsFiSsCGche06hMWTZjIfnPrrZyQpFDg1IvNbr7xskCkp4Ff
	CWorAlaRnlk93fUmpl4vUUNdpA7mxmyky8S3YCyeS9gZmHClyzZMgHR5OgEjq5TF
	IbM/NOOxAiukrGFV+T2bQlbRIg18iPcvvgZ0FEDD9dbtiCk1uel47ncyasWErpC+
	tizAgKwm46dpfrl5CtwILienB3DJ2Mv4UBAzvYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:533KjmUPJavrUs978+hPIaX5JbvrSi4W1b1E7lVcMpo=:g19TgEogklkU1UezN/RdwmLk03B+5ZZWzIf5fRsngQM=;
X-ME-Sender: <xms:xCDAalF6Qc6P1oS1uewAhBFcz362-hDFsAWD2CppVUummrWlWmVyiA>
    <xme:xCDAasneP6VLyW64_QArbQsB4BIUW9RslJTa9_9EtmZt-v_oiieYDEb1Sz6HRii7c
    KByZtbZUXD_n4oDFGxuhGrRm6-bBJSPmobhp2WjhSxwy9pnasT_NCOq>
X-ME-Received: <xmr:xCDAapZN6lizYJmsgVD7jSgdZrAy4KjBXoM0k2zBlpfTMt6EgjVgqxqpKLPgrFq-Mb9LxHebltcJ61ogxKnxkUna-bP6h-qERUpX>
X-ME-Proxy-Cause: dmFkZTFZv4Sq+c5uDrD3DoYIIF4Ibn39QEuB8NoxOcKUAu8trDSjTcKwrxYIWt3fMl5kSK
    Walmk/WFoiiGn9+r7che5zSXkt8+mr2/W/NLJkRPE5Igntafrs2PIrtbAeOqtggxksrifo
    nEbb9cSYU/6a3yzNt5GbCWbFcO/e2K2OgSKq/eFl3eZpRkELIAJCAqSAvo6WwMLPVLtQqZ
    +q6/Pyq5brx1to2RUSeG8emSChtHgrp2zQtXRKLGL3QggClmhfOyM41JfR0gqdtmSMiew4
    F4/72lDfXwQwlDDfgWhdEcbNW9HQNJ2gPHJMn5PWwKg9Rj8gg6NkM0KI/ksrDGkhgQvDbP
    DnvRdZ+fA4WCvF1NJ9EB6uMcvbP3XaGrnRF5bh4d9M5lQb/0l9VsuHjA2FdtQIW0KzmZdD
    ioeg3sEIDoYjrXqE3JCfQWLFb+AXBklJXJNopxhs0dZp2NezBbxDPK0Jc7snCawOWu9oH0
    upHzMxn3lyND0JEGXLi0Ks6aSHMS36kJ1TYp38INagGFMbtIkcy0XW45lZebML6Knk5ae2
    uWX2Ue9VOY/LnfqfCR4Rh55gfhNK1BOddSlQgK7BfiCaDfl0Wc8G2J9jRbcW1hsS0WrCE7
    zl1I/u9ieJoiFzDoq7uTpMXkjWzoB8bW4M1fEGMdxxrP5r44abZeqLgGGdfQ
X-ME-Proxy: <xmx:xCDAahE7b4Z7KvlzRtGGec0f9wxBphskjMTcMkUKedLzjCNJAr5YeQ>
    <xmx:xCDAaqJAzqUTJqUU8VzUcaq4T1uJ08RrCAWrTsDzjH-PJL2K0LJXfw>
    <xmx:xCDAasNwiEr0Wj4wB6Z1tMMUZ_lRU6z9zDkYK6WVpkcl3AfD_6-kiw>
    <xmx:xCDAaqmQBdNylT066kXY-reOsUhOwAjby63QxPf-tKZiQ-uJASJGHA>
    <xmx:xSDAaqwn8iSxsI9t6V1byqhdImr17VqEzaQzW0QmHUFvXtfy1eeEVaKP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 17:23:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Monette <pmonette@google.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  ps@pks.im,  toon@iotcl.com,
    Souma <git@5ouma.me>
Subject: Re: [PATCH 2/2] replay: add the -S option
In-Reply-To: <20260925205348.1210154-3-pmonette@google.com> (Patrick Monette's
	message of "Fri, 25 Sep 2026 16:53:48 -0400")
References: <20260925205348.1210154-1-pmonette@google.com>
	<20260925205348.1210154-3-pmonette@google.com>
Date: Fri, 02 Oct 2026 14:23:14 -0700
Message-ID: <xmqqse2nvltp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Monette <pmonette@google.com> writes:

> `git replay` currently doesn't support signing. In fact, there is a
> FIXME to address this.
>
> Add the -S option and its related options --gpg-sign and --no-gpg-sign.
>
> Signed-off-by: Patrick Monette <pmonette@google.com>
> ---
>  Documentation/git-replay.adoc |  10 +++-
>  builtin/replay.c              |  12 +++-
>  replay.c                      |  12 ++--
>  replay.h                      |   6 ++
>  t/meson.build                 |   1 +
>  t/t3651-replay-gpg-sign.sh    | 107 ++++++++++++++++++++++++++++++++++
>  6 files changed, 141 insertions(+), 7 deletions(-)
>  create mode 100755 t/t3651-replay-gpg-sign.sh

The main part of the patch, which is the change to replay.[ch], has
striking similarity to another topic from mid July [*].

  https://lore.kernel.org/git/20260717145142.39478-2-git@5ouma.me/

That topic has its latest reroll posted recently and it still looks
very similar.

  https://lore.kernel.org/git/20261002132718.3830-2-git@5ouma.me/

Instead of making duplicated effort, given that this community is
limited by reviewer bandwidth more than it is in need of new
patches, it would be very much appreciated if you can give a review
to the other topic to help another developer and move it forward.

There would be things your topic wanted to do that is different from
what they wanted to achieve.  Theirs is about "git history", and
this topic is about "git replay".  So after their topic stabilized,
you can salvage the remainder of your topic and rebase them on top
of their patch.

Thanks.


[Footnote]

 * It shows us that there are only certain ways to implement a
   thing, and it is hard to be "original" these days ;-)


> diff --git a/replay.c b/replay.c
> index ad87863565..9a84e297b1 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -85,13 +85,13 @@ static struct commit *create_commit(struct repository *repo,
>  				    struct tree *tree,
>  				    struct commit *based_on,
>  				    struct commit *parent,
> -				    enum replay_mode mode)
> +				    enum replay_mode mode,
> +				    const char *sign_commit)
>  {
>  	struct object_id ret;
>  	struct object *obj = NULL;
>  	struct commit_list *parents = NULL;
>  	char *author = NULL;
> -	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
>  	struct commit_extra_header *extra = NULL;
>  	struct strbuf msg = STRBUF_INIT;
>  	const char *out_enc = get_commit_output_encoding();
> @@ -288,7 +288,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  					  struct merge_options *merge_opt,
>  					  struct merge_result *result,
>  					  enum replay_mode mode,
> -					  enum replay_empty_commit_action empty)
> +					  enum replay_empty_commit_action empty,
> +					  const char *sign_commit)
>  {
>  	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>  	struct commit *new_commit;
> @@ -363,7 +364,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  	}
>  
>  	new_commit = create_commit(repo, result->tree, pickme, replayed_base,
> -				   mode);
> +				   mode, sign_commit);
>  	if (!new_commit)
>  		result->clean = -1;
>  	return new_commit;
> @@ -486,7 +487,8 @@ int replay_revisions(struct rev_info *revs,
>  
>  			last_commit = pick_regular_commit(revs->repo, commit, base,
>  							  &merge_opt, &result,
> -							  mode, opts->empty);
> +							  mode, opts->empty,
> +							  opts->sign_commit);
>  		}
>  
>  		if (!last_commit)
> diff --git a/replay.h b/replay.h
> index 2c71afbfde..7e93ab9565 100644
> --- a/replay.h
> +++ b/replay.h
> @@ -67,6 +67,12 @@ struct replay_revisions_options {
>  	 * Whether to linearize the commits (i.e. drop merge commits).
>  	 */
>  	int linearize;
> +
> +	/*
> +	 * If non-NULL, GPG-sign the new commits. An empty string signs with
> +	 * the default key (the committer identity); otherwise, the key ID.
> +	 */
> +	const char *sign_commit;
>  };
>  
>  /* This struct is used as an out-parameter by `replay_revisions()`. */
