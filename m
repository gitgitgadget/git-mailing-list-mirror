Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DA5464E
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015951; cv=none; b=odNhMJKjfswHtkxpZVIsvGGxQ1ODkodo7vf3l+fv3LNi04ocuj9CwuLlbcIDGm7Slfu/mizIqtWAXBlDDpgeJQlAMJZ+ls6lCbnZeKEWG9Ciq7pFEnxBQ+q98+WTfSmHvfdx9Q5NlTuq13LfBDhvQg2dTurH8uqzcQgGgf5Ov40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015951; c=relaxed/simple;
	bh=0pTKOaM8IIYh5CXJd+eWIXRjnRhuygt6/EcLgpQhQys=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=YBNs2cvjgPZBv+UnZdqPcxOezLQtclHJ6ALcCjModhcAIOCYFWKALXA6ikDT1R0yh/gjMxV8DGblb5vtYafAIqjq9gSPRwo+PmdRM/1y9qCXl9jxhHEb7Hf7gP2nTgoJnsaJfVpLKjLt+NftevOmQ/iw1aq3kkDtkIzkktlyjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=FoddDDcP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMpjKx1J; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="FoddDDcP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMpjKx1J"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8401E138FC6C;
	Wed,  7 Aug 2024 03:32:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 03:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723015948;
	 x=1723102348; bh=I6YA4LgNp89xc0Lrsh+b8jd9kZnt3YRN3kdAFUnc67o=; b=
	FoddDDcP014OVdsOlKQoCE9XU1tVm0+5vrxskOoawcUhOxBjzdchYkF7ElnUntMc
	J1eWk1vEHKZs+EXQMksElb8txKiQRFu+SruRnDGO9ccken3VkvPkTL8fpCDMWe5l
	NmJiwZr6HWveOgXU8mICt7Gg6tSe0GooFnBnL3bvAIL8yOzzSf76guw67GN0FUtw
	qmcKC/bCzK7ZIdOBUbxqWorYtcGYZAZONrhetmOLfdcaanfSzBxukcbO34RpqO8I
	uAP31ZdsbWO8Mr8D5P8hsi0OKSukbkpmUuCpFtp06BioQamd/JkdZe1AHMdApOwc
	YOuYeX18w7jRAEC42bu2yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723015948; x=
	1723102348; bh=I6YA4LgNp89xc0Lrsh+b8jd9kZnt3YRN3kdAFUnc67o=; b=f
	MpjKx1JeUMaodtHzrviMLKM1xuV9OxIrmSaGFqlEo3FAMo8IyPdSnQMbwMhpPtKy
	28LhyNTu8AP+23RXlbrjWFJr2V3PPbzjyyaNPiLeR5ZfI9s+kQcPksw1i6I+4IDP
	xJYWea41AqCmAdZyipM6d6sRtaBf9D2n5Q61cyUQWmA87zhHXaOx0FTHEck2HUWx
	pRNPW4u4+lbU91CSfwC8HEkhm1WbdV/WPfUqw5AizzbYny8ldNmU9sB9bYo9Ut1B
	5WawhP4pmUR9XICLH36d3lYYui1+1FU1311f5dzMA0PBVvV9UoNOu6Uf47LNAera
	n6Vs9dIHLYe9vFjWCgjig==
X-ME-Sender: <xms:DCOzZgwWwJ6N0GR2vDK7aheZwRsX-QxsFHbYFoUfpMeAjmG_tHD7EA>
    <xme:DCOzZkRHni4l8b_54SM9l482Or3Bt4njiuBiyMWlrG_N8udYKrsi9bNmtlWyVmFRZ
    A53bzBfkgDuydVSBg>
X-ME-Received: <xmr:DCOzZiXIe6-sHfNhq7qOq5fKkhAl95od7-ZKQ6tsJE_LrHkgz_iB6yaKWwwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdflrghm
    vghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrihhoqeenucggtffrrghtth
    gvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheehvdeikeettddvveegieel
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:DCOzZujhhMrGQWuXqMipb7tsAO4RUgI7JGa6dkgrMctDBfbAbTQY7w>
    <xmx:DCOzZiBkrksp5BqOHfxjF1I5zGsYz40eu7WLwZKpEJJWlJcPLCaIhA>
    <xmx:DCOzZvL9m3V-G-Gs2yWvp8BF5WxlK6YeEEHi1p7N4Qaqfird_FdlmA>
    <xmx:DCOzZpAdSKP7P7rzJSMqm1va9OJAAWg1er1G2J5ZAZNO03hX2kzOYQ>
    <xmx:DCOzZlPVFSewU522LcF-7uFIOBg71bw3_lHS6myq83vNOKzBYAS1Mj73>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 03:32:27 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 17:32:25 +1000
Message-Id: <D39I6DZWV40G.T5O4SNGH9OIX@jamesliu.io>
Subject: Re: [PATCH 09/22] builtin/rebase: fix leaking `commit.gpgsign`
 value
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <05290fc1f14cae8229c42f2d0aafe6619c069e3a.1722933642.git.ps@pks.im>
In-Reply-To: <05290fc1f14cae8229c42f2d0aafe6619c069e3a.1722933642.git.ps@pks.im>

On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> In `get_replay_opts()`, we unconditionally override the `gpg_sign` field
> that already got populated by `sequencer_init_config()` in case the user
> has "commit.gpgsign" set in their config. It is kind of dubious whether
> this is the correct thing to do or a bug. What is clear though is that
> this creates a memory leak.
>
> Let's mark this assignment with a TODO comment to figure out whether
> this needs to be fixed or not. Meanwhile though, let's plug the memory
> leak.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/rebase.c              | 8 ++++++++
>  sequencer.c                   | 1 +
>  t/t3404-rebase-interactive.sh | 1 +
>  t/t3435-rebase-gpg-sign.sh    | 1 +
>  t/t7030-verify-tag.sh         | 1 +
>  5 files changed, 12 insertions(+)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e3a8e74cfc..f65316a023 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -186,7 +186,15 @@ static struct replay_opts get_replay_opts(const stru=
ct rebase_options *opts)
>  	replay.committer_date_is_author_date =3D
>  					opts->committer_date_is_author_date;
>  	replay.ignore_date =3D opts->ignore_date;
> +
> +	/*
> +	 * TODO: Is it really intentional that we unconditionally override
> +	 * `replay.gpg_sign` even if it has already been initialized via the
> +	 * configuration?
> +	 */
> +	free(replay.gpg_sign);
>  	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
> +
>  	replay.reflog_action =3D xstrdup(opts->reflog_action);
>  	if (opts->strategy)
>  		replay.strategy =3D xstrdup_or_null(opts->strategy);
> diff --git a/sequencer.c b/sequencer.c
> index 0291920f0b..cade9b0ca8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -303,6 +303,7 @@ static int git_sequencer_config(const char *k, const =
char *v,
>  	}
> =20
>  	if (!strcmp(k, "commit.gpgsign")) {
> +		free(opts->gpg_sign);
>  		opts->gpg_sign =3D git_config_bool(k, v) ? xstrdup("") : NULL;
>  		return 0;
>  	}

It looks like this free'ing would be managed by the caller by invoking
`replay_opts_release()`, but it's not being done consistently.

For example, `do_interactive_rebase()` invokes `replay_opts_release()`,
but `run_sequencer_rebase()` does not. Would it be better to address the
leak here?

