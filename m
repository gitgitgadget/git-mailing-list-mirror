Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA812253B0
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782630021; cv=none; b=n0dScay+Dwo8ad+Ag3x8lByOoI9/0HSoMsIjxPRF8dT8vA2k4LnM316ib+XKs/MLXMkBcVDmQP4xBJ9yUsH7ghynx2Y2f+2P8gsPXPqe7OwFybxOvk+1UP1gkzLT0MpSmo3z7BAOLykX2IKJMEgCGoIeFfzlveYrCvelM6cPtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782630021; c=relaxed/simple;
	bh=cNnMpWu/jXrsVjcaB7rv7PZnT4XXA75kpSK+jxAByXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vrr+Ue5ZZE+A3nt9IA0YGAITWl1N8tpJGlzPIqWw//ya4XhuYQXK06V2Ki5OUKbJQcTyC55gY1UDqTsQwzJdBPAoaUouE994HAZsajVv+KNX76pYLI8QfC7U8WqZqvdFKfRf6gwOiVLhiIBl6EiBkmx4aa69AbVZg/RniW/ApP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f1PCccwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DxnMD6m2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1PCccwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DxnMD6m2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD2AB7A009F;
	Sun, 28 Jun 2026 03:00:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 28 Jun 2026 03:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782630018; x=1782716418; bh=5Yzipo41px
	zZohYHNtqdD3mc1GsZq7Z99NOTxBY+32c=; b=f1PCccwyJdYIXcn/OSes6g9b5b
	hdXU1YYQ8FBz11V4HmMl30WIgavBP3d8YHBsxpXmdlVA3l54+0XOPgepyGzht22J
	BzV3x6esCJ3GbODBTUnCZa+3uoL7jWizUQEh3yA30C1vG4eh2Ujgg9/DMuiaIqne
	UTwEwXXy4vetmDCLbyIztd8eRAg+bkUx5mXDlNKBCC/Ch4l4kXFrwU5NKocT85Mo
	gog4LLyB3uCjxYecO7VpyZcgH4FLta0rpiaYW9EeDOyCseBpbm22+Vp4bRc43XYx
	CVSU2enpZ9si2bKP929eVr+wfPsKGeLBmmj7Sj+ZFajC+Ok0dVFndb7jJ32Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782630018; x=1782716418; bh=5Yzipo41pxzZohYHNtqdD3mc1GsZq7Z99NO
	TxBY+32c=; b=DxnMD6m2gp6A6RMeAo5Zft9BR3vdGvrGdubKCPu7yI4IIuTf+YC
	BUzJX8mlroJF/0fB+PcC1ZlkT4pPPJWo7UybmkBbk7YaKPv+l3pveeNjoZnaGmgh
	aFZWACSAooe82SQcUPEFpDW48x6cHATunjFxXW3sSrn7M/G6iku/CLc7XYlOlhRy
	GJHs0dtxcXkZX8yDUV8Q8hpOyJcovlS/oFzyyhq/goDGqf3Gl5t/G/6lXAw2nd/7
	hF18GG5yVp+5FiraWQRtrvJqALUNF32LYnpPegS+KMvfzDgSiyvR+sO6pt0I1I1K
	PbEkxsrFf74uhTlfhXI5nOeL4O7wVSSY4EA==
X-ME-Sender: <xms:gsZAanTC-Kpn3dgztYnrSqpuF9Dngyt5WhESP6KVTvh9FDw-P1YvpQ>
    <xme:gsZAavzDvYiztIQuknkf1fCdBp-y__4PA1xTQQKBpd9j6M1K6a3HH21SXgwe_ndqg
    l9uFfGEqTIiyET3lmhXMB3rD4eKgRs41gaQ9VpOlGczio_9M1dNGA>
X-ME-Received: <xmr:gsZAah3oGlmhP1mZdKDqlHVAUpUegoCSnPZ_hcneEQqskYOzsoAtPKB-ZBVp5LGVU-ud9R_H7WqyUGYZfZNFmdvLkAibxSSvTF8JYIM>
X-ME-Proxy-Cause: dmFkZTFp7GXeTTPL0+x+5ICzKQsoIUueuyiHx7wjSr/2oqS51hqiQdyvb7whSDo+3jYAtr
    7xCHzMHQsse62I3kwBwlQNhX0S4nmI3G65IQ7GEr+CiaKtIRsLoQNz7sNoOOzhJlMuu72p
    v1m5WhzaIy6BnNM8An/EkqakNapykh6p+fR3Ju4xjmFoUkbQtdMAMHkj1i0FuGJqzgBFKW
    BHLFK0QGAQNv5lysChANWKOOuPeXSCkNJcFMyyVSrh8fNsyrpQIpJ0jnXKmWLCUo0PR5TF
    DoDMtX5p/iXXI6F2XdqrdkKtGUtqKrYBhu66m++SQHQOWdtHhukNfO0ain1WxBP8se31oO
    5SJ2/xTyN/uRIggNepCOE9oF+QsLgoaYRC+b0djjSVy6jYcWOj3dW8XKaGuyT/keTBVHzK
    Uoo7Md/TwpYUFZnIFOWmkSwHvJ03pJHLsOHf4u6hapnTPRW3GaH5Xc5f9h07xKLOjVp0EY
    74XMCy0sukb/O2yMML/V4HjW2zs8P6W+L+0BeJP2UVxdcUub7ma/uFb3EDpP0My3Jg90FA
    LAA/H79gESkK/FZwLKUhQzcMR+xbevlLq6Bo7mH/rVz39iElRfjGRMw4tytVi46u9njI28
    uUDc+NqVbnbEd2OCNMVhOXBw0IucLkNRiiAgIbbdukystwzufbnkg19Z4Lng
X-ME-Proxy: <xmx:gsZAal7w2hZD1m3RbaPAxQcqaZwieLBKpcpZuhZgDQGell3mrh1-7Q>
    <xmx:gsZAasUBFjdhpdzYWIconyanuhyJbIChTo6IL01yZrCMtfSlQE3y4A>
    <xmx:gsZAasAMKAB1rqiO1cSBt-Bfa5fqbrCJqxeHW0pBZ3sDuXz38RELjg>
    <xmx:gsZAaj4BbdWjMDaUSLjuDLr7O_cRNjqxNk4TvllHS2O4evcqlp3Amw>
    <xmx:gsZAapV0Kfc5p2l_WdwXGWQ4tHszDgNWRwPEG3zT92BhbcSzDQAmDPEG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 03:00:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 1/2] branch: suggest <remote>/<branch> on upstream slip
In-Reply-To: <9883c28482be4ad43f0f999c2e6be9f9dd9fb13b.1782583345.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 27 Jun 2026
	18:02:24 +0000")
References: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<pull.2331.v3.git.git.1782583345.gitgitgadget@gmail.com>
	<9883c28482be4ad43f0f999c2e6be9f9dd9fb13b.1782583345.git.gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 00:00:16 -0700
Message-ID: <xmqqfr272lq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1572a4f9ef..dede60d27b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -706,6 +706,29 @@ static int edit_branch_description(const char *branch_name)
>  	return 0;
>  }
>  
> +static void die_if_upstream_looks_like_remote(const char *new_upstream, const char *branch_name)
> +{
> +	struct strbuf remote_ref = STRBUF_INIT;
> +	int code;
> +
> +	if (strchr(new_upstream, '/') ||
> +	    !remote_is_configured(remote_get(new_upstream), 0))
> +		return;
> +
> +	strbuf_addf(&remote_ref, "refs/remotes/%s/%s", new_upstream, branch_name);
> +	if (!refs_ref_exists(get_main_ref_store(the_repository), remote_ref.buf)) {
> +		strbuf_release(&remote_ref);
> +		return;
> +	}
> +
> +	code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
> +	advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
> +			  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
> +			  new_upstream, branch_name);
> +	strbuf_release(&remote_ref);
> +	exit(code);
> +}
> +
>  int cmd_branch(int argc,
>  	       const char **argv,
>  	       const char *prefix,
> @@ -957,6 +980,15 @@ int cmd_branch(int argc,
>  		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
>  			if (!argc || branch_checked_out(branch->refname))
>  				die(_("no commit on branch '%s' yet"), branch->name);
> +			/*
> +			 * Check the advice up front to avoid the ref
> +			 * lookups when the hint is off. The helper still
> +			 * calls advise_if_enabled() so the hint carries the
> +			 * standard "disable this message" instructions.
> +			 */
> +			if (argc == 1 &&
> +			    advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
> +				die_if_upstream_looks_like_remote(new_upstream, argv[0]);
>  			die(_("branch '%s' does not exist"), branch->name);
>  		}

Hmph, something like adding a single liner in the caller, like this. ...

	code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
+	/* use _if_enabled here to show the hint on how to disable */
	advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
			  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
			  new_upstream, branch_name);
	strbuf_release(&remote_ref);
	exit(code);

... was what I meant, because the most puzzling piece is that the
function calls _if_enabled form there, when the caller is presumably
already checked _enabled() and leaves the reader wondering if there
are other callers of this function that does not check before
calling it.

But this is so tiny a thing that once the code is written, it is
probably not worth the churn to redo it.  Let's declare victory and
mark the topic ready for 'next'?
