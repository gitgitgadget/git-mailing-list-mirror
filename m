Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7743B0583
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556921; cv=none; b=fgpL0FFVLJmbHw+wY5+jrYJmGPymJhwWbUAOleTIS0GpjQFyGxYgS331aWObT2UQm3ZU7ija70RK5/6k1LVHDUDYAQR5PXSLZFzGjDtB4c/jogzzfFXbilc9AWJb02LciTdWaPNuGSv7N0IKxzZ/bqUbNUT0ItnQq6sileBFJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556921; c=relaxed/simple;
	bh=B2MG9rEt/cIR40JFqu4yq1Pg4xN7s7ulxfV+y6vFoOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5KDRPS0UTEaYIqy6nU0VrYTAw/hfwgE7etCKXcb8EcGSRiCYNslYbTFg8AyIukPjyU4sE9FoUk8HIBoFjcqYqvI1fY9ixBZSo9LnNwMf4/diBIL7a2iWquAUmd5E/3DjrkAaEWDvePS6/++aLVNPtk5h5SZAfd2ywZHV0b+EbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=khrG1Yop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xFl3bBQA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="khrG1Yop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xFl3bBQA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B0008EC01B0;
	Fri,  4 Sep 2026 17:21:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 17:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788556918; x=1788643318; bh=NEtmjQTMsu
	doTkROk3HYJj6gEZRSOtNTG0fN59WaYNM=; b=khrG1YophcfyNSIwtQniPWUF+s
	2Yk4Y2+YqXREkbc4wcGySU+PkjK1PqNAp02Ib+sBd7zkhGbMGBV68HhNdPToZkpA
	i03C1BCNrxwkD9n0yAambRXXbcyDWm2TLBJX/5f2D+ElKZb5OVQajignPw4mkD0g
	5Xue/btk6KKpzbwtR3IH6JQnfSeypAikAr7zBoBhTIcmt7yCtwlRZfS4D2IOLvI6
	LgrtQ48s8ylLUPiYKEr0pEUO8AvyXJ+iir3fzl17RWy6+X+azaZ81ways2Y/u2Ak
	+3w6buQBcGsSbULOO5Ing3Sl0NJTBg59kWTJcpGueDu58urP8hoNXLVWKDTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788556918; x=1788643318; bh=NEtmjQTMsudoTkROk3HYJj6gEZRSOtNTG0f
	N59WaYNM=; b=xFl3bBQAOTs6TgvgnAUAWnAHfr+gTKrl6yRN77woBYefMEzJ7xR
	GVKfZlU9Q0ggRNwmDd5l9xUR33KkvUGfqRMtBBGfZSWodJAazAGY4BIEuAeTJN9x
	nSU72sf8eyuVTGTL2FtpgOvVjD237ra9B6iKuy4JVX38kK27E4FJHk9IywRd2HH9
	oyKe+qNwhwUzA6EKHs01Q/YH1RrWZXcgB+q4oJnQ8OhYp+ZWPXruImgCgVKiPGb1
	+eRFiHYS2oMiYlkz/2cK34Y9GSAE9m3M2V1QmkcrQzus8Q83r5TCpquGdOgYV6QS
	3YReF+75idaC29w7PYiAksKSvz0W2REHOrg==
X-ME-Sender: <xms:dTabarWxwc0IFc9ilCFCaVe3vy9SymK1kXYZKZ3kuMaKH7J-GpZDWg>
    <xme:dTabanYcsrHoWOkI9T9nlJjdkvFT1_igJae7UXM4whZ2FnLMoIeW9-SivqtGkolDp
    xsm0tjIcLPRssb1S1nsKBbrZOxYFXoVdk-H60wx9aFXm-uk17FshIk>
X-ME-Received: <xmr:dTabageCfZExLkbn07Y4jb3XrtRCrEiHSn2fYnEy6_HoernHu9N1o3SEv1gzsALamVWvN0qYqIDknXyuS-VpTDuZuG-SrHoRtQ>
X-ME-Proxy-Cause: dmFkZTEWt/eK1YcYU6g5T0Di1kZGIB9GiBRZpIEQ+lQgDc3mG1CCcAyKcekdiywobWrVSm
    ud+jGB4WY8iM2/4S39JWTFBp2lcE6Zu/gB7MYwKg40fZZ3PItrES4tqyX6lpUV17V210mA
    67NlS2qyLKx8/hYqFIxjvQMe7Ktwmq95stlsbIln9dI/IDR8dCdYoDOkB/TgKiRgRYpbIs
    X89YzUB+vD37HyTkzEnrKtjRTb3LkG4JETuYSnvCb+FPgYDbVldcEkkED5AprcV09W3/mh
    RgA96LpigGAsJnye/vCKzKuC/a5UYOzrXxwGDBcwpqgXFjprJIrkJ55qWqrDrXBAZcqacb
    z3zRKrs8AK7YpFiJOzKWZJkDVmsW3X5/Jt2AywtoCeXPxOX6cyxOH2V9cByszWpetQI3GS
    8sfjfHrSr9DXTPCiqKvamyw8ve8sCxRD9cMUqxw4+kc2mGifkjaJXNzE/JbisI6D8UqRMk
    7Dw9nAbsafBjXkPEv34x3jGznmpZjASShSuz8nWHVU5zycmPmz87cgtEL2tr9/siNFh6q1
    pbrKtGH6SGsEei8s6gsK2fNcBWggBg+8zhr/VbqbHjlNd5sMWQEM65g6U6DPzvyg5w6Sg+
    NhScETL6fq6hpXHgaacBuBzwIUZDplbSvAwLs4znqMwtpHg56kg9HcWySqSA
X-ME-Proxy: <xmx:dTabap0CkRlcNamg7pKjPVBZ39gohs4Vw19ran_s5r69f7EloJNBuw>
    <xmx:dTabavIlPEiWxR49GvSVRLUQntpv423LDABGTxhQQ24d7nPX6EoLHg>
    <xmx:dTabagFSWDbWwgq0G6cQkdQAk_ZSciPZwskXaOYjzJdOFah-a7W2kw>
    <xmx:dTabajXuHGmkRy-XHfWeYW4t1HCv-ADN7erhAK6HZ80_Z4bGuju7Aw>
    <xmx:djabalMtDbjZdIBoNe_h6ZRbkeCt68r-Jd2fbN0K9GAD6rtOaKd_2Gcz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:21:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v2 3/3] sequencer: keep auto maintenance out of the
 commands a sequence spawns
In-Reply-To: <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
	(Thomas Bachem via GitGitGadget's message of "Fri, 04 Sep 2026
	15:51:26 +0000")
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
	<9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 14:21:55 -0700
Message-ID: <xmqqwlt03e6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * The GIT_CONFIG_PARAMETERS value that keeps auto maintenance out
> +	 * of the commands we spawn, built on first use.
> +	 */
> +	struct strbuf config_parameters;

Does this have to be a "struct strbuf", not "const char *"?  The
latter makes it clear that it will never change its value once you
built it in disable_auto_maintenance().

> +static void disable_auto_maintenance(struct replay_opts *opts,
> +				     struct child_process *cmd)
> +{
> +	struct strbuf *params = &opts->ctx->config_parameters;
> +
> +	if (!params->len) {
> +		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
> +
> +		if (old && *old)
> +			strbuf_addstr(params, old);
> +		git_config_append_parameter(params, "maintenance.auto", "false");
> +		git_config_append_parameter(params, "gc.auto", "0");
> +	}
> +	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, params->buf);
> +}

This would then become something like

	if (!opts->ctx->config_parameters) {
		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
		struct strbuf params = STRBUF_INIT;

                if (old && *old)
			strbuf_addstr(&params, old);
		git_config_append_parameter(&params, "maintenance.auto", "0");
		git_config_append_parameter(&params, "gc.auto", "0");
		opts->ctx->config_parameters = strbuf_detach(&params, NULL);
	}
	strbuf_pushf(..., opts->ctx->config_parameters);

