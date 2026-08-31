Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F161E1A3D
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158714; cv=none; b=ORkkHNAFx7Z7CdciHAA0Kz/hIHFXYIKm5vUCAe0jZ6kEHseqm5RpU51DcT8Hgf1nwV7ADZtCTvDEq7fihhg74FHTJkPB5gcD0XEB0gwDqMF9FnXwupP6huTM2pXAzO2662pltnBYFLxVQpYp5MfPc1aA49qzDrOKZYIrAq32IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158714; c=relaxed/simple;
	bh=hHKt97otDTbJHrho65vej4XXAmNsIB80vs/YRBInk8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiB4N56iSgp7n7F+hwCQFk2r5hK8nhHSomog6mtSXlqPgVW51QRwxgHdwSiYoyduHkNNNdyVq/AuH3uO6d6ABH6TM9SK8CljDOmWVg+kje2pZg+DZQlFL/NvOeZtq1yzfFYit+F563OM/8Sf00HJRFR6R8fQjyBWC/JGjIgL758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mX5umPWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XeI1b33C; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mX5umPWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XeI1b33C"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D68EB1D0012C;
	Mon, 31 Aug 2026 02:45:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 02:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788158711; x=1788245111; bh=4L5Vc4Eece
	dC2ISBm+pivMydT4HJAcC+CaJ4v6/oG8s=; b=mX5umPWhVlu45r2EJRdlNaLmh9
	6DJCVDuaDr07ayFV73LXWID7IbjeKKx7tXZASpXUkkqMSaJpwk8xOB8qeeVGbYXi
	oak2jiETZEZxd9fSqUOFfBFokYtty8dinIAXWtrD5bXVNInYuGYJATPPwgHcXzje
	tXcmbOeFZZsTD7SoxkN0jeZjSBnbTiHLmhHI2qZFxWG/qiQa/zu9utPSMEB2YHTT
	0eDU6ge3OcllsfRbn/6kBT8WVVW45StwoVlLMQoSN7HNa0NYHDlwFYogbWGDKX8P
	ZBJ2NZL8sT6ZdF7BlRk6syRQAubjaBW3P6N+YnhQ36GrMNhiXDVH2+ODHc7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788158711; x=1788245111; bh=4L5Vc4EecedC2ISBm+pivMydT4HJAcC+CaJ
	4v6/oG8s=; b=XeI1b33CaZVT0ZFJwsIToNq0IXgFtWOTlrm1c5FnSD6ZNZqeJUr
	5c0KeG/Qg5qtqAhwsfmgmOL9ZY4PqvCtxD71aa+ImFrIoNlWzQW8HsnzLDcOhiO2
	uV3dWkpXvXK5gG3vKJxDK9XqQc+gVZVJ9fPvZscwoCs9E8/yfl6wUGUit0s/zRzW
	SEt/3TjWn8oY4eHFIzIPwifjLuYPucLRPgg/Ui9FvLzjeHjIPI1qPWa5dq1vbSHr
	Y8gDz2EEMB4OVPH3lugj5Lbmh+3/EaxmoCaZdJNrG/wVjSVkIJKUHqXjgvXN12t4
	518gpvcxf6cDgnmqHUmMgQ5sC0LkfMYvXWw==
X-ME-Sender: <xms:9yKVatM8ITN80ezBMf6ZQZFaegJlwK1t0daAg8uZyT1yGok-dF9Tzg>
    <xme:9yKVapTnPZLt2iGmSgakqwM4799B0uQKrWjs2mqgtBWd-aZPEPJSkeN4aoCS7XKR9
    4wshXPlcv2q4xooNbLAx-mUtyGlKS6dMKo-xoJZKZkrGAv510u8>
X-ME-Received: <xmr:9yKVajhhUB0rluzwvNeTrqdRu1VJtCEFHF5QYfMFBmD0ZkdPgpGqfWLuJsJw5K-t4gCrvg>
X-ME-Proxy-Cause: dmFkZTF0lhxVI2SNImni3LGLJIS6/cEZ8oB5ybC9Ftl18g3G0/2qKTKY3nY/zPwzMXmQir
    QQ88m4VMWGjNts171qx3v8yLraWhdK727nn+CZ3cJx5E/ZGOFyo47x4c5AYZAKJQ7u36tK
    pyjuwm/LTwYF1BLkvn84nf3mcD1HTh2WaMave/OKB2OcadQ9GGcLGZJAlxckzK61xXnq9j
    3b5OG8VAyxTWmOeTqWrratyPQ3zZKQX3zPjZll/4d9NPmLC56NOjxpGgMtuZ8SvEAt5UTV
    cL7rNaQX2FqkOUhC7lb3rmMgPaWzVJwgrAbNPvBkvD1gwUTrsB5hDD10ZoH9E4ONb7JFmm
    tNROS0dEGJmeDJpxRLFfj2Ow/wyRsOgB0Ml8BxrmfpAudgCVm1PEeB8LgyMPcw+e0Op+gx
    DhBIheTM1uEG/DRfjSBi9pYh0XBQqyrwUOdRU6rC/uIIJm3AhsIvpxa2AK/qvFVK5fDYup
    JzKRGgq8AU8oAtkdP2bVJYEU6+F1ob8KyKOkc5QSvZA1X5XkRKU7OHGfNurminjVua+lCv
    MIKTvTSYIHzaZyhky4982b7hx8xLkpOAmqlM5PM947esQHIO+CcN1Fbtqf4IZhHV3/PeRR
    pAcHDFxHtDTFwvlfb5bxqp20IC2SvQPDz8WWmcTytax6wwo8DDCgt0PGgo1A
X-ME-Proxy: <xmx:9yKVaq_TYXFm-BM7MGoZQuvBmXpCrxNtTmm2bRjYpByuLUCiBU4F0g>
    <xmx:9yKVaiHSMiAEP4LqF7fsHMyw3O1m1MLCjZ-pbgo7yLtRYUffllF_PA>
    <xmx:9yKValkip7HoaATBOhyNpRuMxcjFd43XDkpwfcoY30x7Lw-9cMuUnw>
    <xmx:9yKVauZxVZCdjrEeGQ3YPJWS7FyUCXFxPPSeRhBxkjykTRhgQZVzlA>
    <xmx:9yKVauUKWts9OdvcD4F4SSsPZqEetdKMWr23n-2aiqeXV1HFOPeOdINT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:45:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1bf7266 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:45:16 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:45:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 3/3] hook: introduce the receive-report hook
Message-ID: <apUi8I-b69XxDAYY@pks.im>
References: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
 <20260826-758-introduce-hook-v4-3-6b14975ad957@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826-758-introduce-hook-v4-3-6b14975ad957@gmail.com>

On Wed, Aug 26, 2026 at 12:19:39PM +0200, Karthik Nayak wrote:
> diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
> index 4349487e6a..f2d52b7df2 100644
> --- a/Documentation/git-receive-pack.adoc
> +++ b/Documentation/git-receive-pack.adoc
> @@ -243,6 +243,15 @@ requests. It handles refs whose names match the patterns defined by
>  `receive.procReceiveRefs` and executes the actual ref updates. See
>  linkgit:githooks[5] for the full protocol description.
>  
> +RECEIVE-REPORT HOOK
> +-------------------
> +This hook is invoked by 'git-receive-pack' after all the ref updates
> +have been applied but before the report is sent to the client. The hook
> +receives the complete report in pkt-line format on stdin and its stdout
> +replaces the report sent to the client. Allowing the hook to rewrite

s/\. Allowing/, which allows/

> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index ed045940d1..e83ebde667 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -527,6 +527,49 @@ The exit status of the hook is ignored for any state except for the
>  status will cause the transaction to be aborted. The hook will not be
>  called with "aborted" state in that case.
>  
> +receive-report
> +~~~~~~~~~~~~~~
> +
> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
> +`git push` and updates references in its repository. It executes on
> +the repository once after all refs have been updated and after all
> +accepted ref changes are applied to the repository, but before the
> +pkt-line encoded status report is sent back to the client.
> +
> +The hook receives the complete pkt-line encoded status report on
> +standard input, see linkgit:gitprotocol-pack[5] for details on the
> +structure. The hook's standard output entirely replaces the report
> +that is sent to the client. The hook must write a valid pkt-line
> +encoded report in the same format it received. The hook's stdout is
> +fully buffered by `receive-pack` before any data is sent to the client,
> +so the hook's exit status is known before the client receives anything.
> +
> +There are two distinct ways the hook can affect the push outcome:

Aren't there three? The hook can also update the "unpack" status to
indicate failure.

> +* To reject individual ref updates while keeping `receive-pack` alive,
> +  rewrite the corresponding `ok <refname>` lines to
> +  `ng <refname> <reason>` lines in the output and exit with status 0.

s/ <reason>/[ <reason>]/

> +  The client will then mark those specific refs as rejected while
> +  treating any `ok` refs as successful. The push as a whole is
> +  considered failed if any ref is `ng`, and `git push` will exit with
> +  a non-zero status on the client side.
> +
> +* To abort the entire push unconditionally, exit with a non-zero
> +  status. In this case the hook's stdout is discarded, `receive-pack`
> +  modifies all references to be rejected with a 'receive-report hook

Yup, I think this is a lot more sensible.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 70a686c142..1358285589 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2534,9 +2569,12 @@ static void update_shallow_info(struct command *commands,
>   * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
>   * For v2 protocol, set `add_reports` to true, which will also add additional
>   * report per reference update.
> + * If `ref_error` is set, then all references will be rejected with the given
> + * error message.
>   */
>  static void generate_response(struct strbuf *buf, struct command *commands,
> -			      const char *unpack_status, bool add_reports)
> +			      const char *unpack_status, bool add_reports,
> +			      const char *ref_error)
>  {
>  	struct command *cmd;
>  
> @@ -2550,10 +2588,13 @@ static void generate_response(struct strbuf *buf, struct command *commands,
>  		if (cmd->error_string)
>  			packet_buf_write(buf, "ng %s %s\n",
>  					 cmd->ref_name, cmd->error_string);
> +		else if (ref_error)
> +			packet_buf_write(buf, "ng %s %s\n",
> +					 cmd->ref_name, ref_error);

Precedence is a bit weird here, as I would have expected the explicit
error to override the implicit per-command ones. It also raises the
question whether it's correct to retain any populated error strings in
favor of updating everything to "receive-report hook failed".

This makes me wonder whetther it would be preferable to update the
`cmd->error_string`s instead of adding this new parameter?

Thanks!

Patrick
