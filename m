Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64548488F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392683; cv=none; b=ihn1Js4KKJeEmxB26jJxkK/b9hdtsyyBR3reMS8jOCMSULgQ7ztThhSodji2jZQlNDak/aLj2LQoFc9Fb1OwfbXIYnHqPmEvOvoQWSHMKc80dqWwU90WDMczS3WDEOP53HrDJW/1MvacRzpdBGEp/UcMRdPX7ffcwsROIVxgJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392683; c=relaxed/simple;
	bh=XvzSEV6XHKZAtWkWF9pv42bPbiFEP9UbjAM+MW3PDc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9ic3rJn7LbHo3uSYu+wzTxxRMXjxe/P2TCHHAOGlr0ExN/KvsV/Fo+E+N5GZTYShFcZVW0MMI4Q9XzsLsrXwgAO/ZpoGmBdabLu68rgqEUnCuC7CuopgA5MfwRXxbHN8GAV7k3jC53mpPjOAPWhzy8oe+Zm16Wa4YgTrE90xxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZdYv9DbU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpTmYHCS; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZdYv9DbU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpTmYHCS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B75841D000B2
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:51:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 02:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792392680; x=1792479080; bh=tfaywb0oXZ
	CzbMoVh9x27gu4HuSlf1q+MuE6M+eN5po=; b=ZdYv9DbUeEfaQfr0BCecE5I+kH
	z0xusw5t3UpAn5ksiwXlXjxw8vf97+m2uvh7KQwArBwINa82yT1jYoVRM62MZ99p
	CYgQJzsq0PdD6oahe1hHVp6uDv2WjMaIZMhOks/Mq5OIoz+zZRLRUbEgaNZxdB/m
	z3LauWnCma9l05fb9OMh16WEgrwRUg69JhZ3TerMpGpHyL6QeZvRNQIk+q058hHB
	ubn0gXifM16Eo34mQFe/FFMlZUz77BLYnKhamMBfg7Ry/pZl9imjlAx7g5UpRm4X
	ajQO1cpShWFT+22deFwu78Dv38RdgucLmpGn9iBDn6+HCN5VNA4/GJi+2jxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792392680; x=1792479080; bh=tfaywb0oXZCzbMoVh9x27gu4HuSlf1q+MuE
	6M+eN5po=; b=rpTmYHCSJzlXHPDVLGDJYgQdc0T8QJzGRWckZe13HulKsV3mdr0
	srku/VSf2tye7oaEnzym2sIQAPJR00ZWGfoSZPNRBqIsSO8fLW0nZPEoTL6ycPeW
	IpEF0nlhSSp5D5GO0cNiMQJdmHoa7ggC3yVYdqqaWmKfbMZOPVMjKEU+Z9k6AVDk
	obfxoV8VzL/TO1BZ47dqocU/gyaVd7T+Gl4S54YNVjp1S7qiurMsUkpys6gh1wnM
	kUKLr0AB20dyY58D272+CGX6ivKx8MGcoFXrGhix1ebbQ//NbN0Y4+BkZqoDT/W3
	LONKI2SHnuK7ceq1pji3gpkafje5qKlufVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792392680; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gQ091SuqRHhJzpSnwYVDKnwQSWa30sDaZWIy10mBiPGRJIY
	L/U6ziDv94WPHQ3futIOcaylsU3iAEQSsTh5whRym1KgETdOgEdV0suUQDVHYsJq
	Gnjl3laS35AYGiRvAqtTwgPlWV7X6FExtlpGcGR3d6X3fcEK3YEgW8Nub7cm+EjE
	JOkRT87SZrhrMoQwOmonqmEV5xOlcmzGqP6bEf8CZ85xybTOv8XBI2yC4njvKINX
	KGubbTw24XAMUb3PzkyQ1FPKM1u1Vl28JJs9eHrtyTj6J+HV/QAdCulpVxs/G7jx
	3D/ytouum1T5A1Y5CiiNyK+L9CmivXXAhz0avCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EvFFsAwJidu2yk0vHeaHgBZ3SNO759LizUZeOgL0p+4=:XvzSEV6XHKZAtWkWF9pv42bPbiFEP9UbjAM+MW3PDc0=;
X-ME-Sender: <xms:6L3Varxg6pimN8Mn9aiwFg6uGg2tmzzMMm1Yg8oFa10-LJnkgY5Pvg>
    <xme:6L3VapS3l7wJGBX6cpMHnOEX46l3DOtxmsyejniY6OzvWj3AYAuCaitUdoCZXBp-c
    95f_sfGAxvT6tH7O1VF_ekkjcDmI4Sdp9Xq89rwyq_gTmJmU4EuFA>
X-ME-Received: <xmr:6L3Vai8YQWTzMewteUYf14i3Jl1AkSCjp3Nk7hPDE3DR9aflRaHjTA>
X-ME-Proxy-Cause: dmFkZTFr3wY7B7zxgppDnPUqtWYFnduig5Eh+pf6m4I0NTf87D+n4Sg1aOrSD/ym3R3726
    0qi59pabu4kuu9ZwubFTTRvqeubRcKpuMPx+Q5AZ1YqAHchNbkYbCVOv6+W22pwg2WGn1F
    NiDYa2me7r59rkEZgizhwnk0WhqO6E06UGdYTC2Umh6CgEWkiAmFqGowc/OzknsV25maKX
    FV3ZeZQ2x+nm66w4OejSTQesVrr/5jbo6NMXO0hM7kfzn2MISt9V3FnpauInrTaQqKEP8t
    6K2bJ7/qpsE7/7Bli8DbCbiVVK+UJg0PI+6xupfMuK1yYi6K0MhkyJj7nvXP7e6sW/2na5
    bTzMHv82zfAsAJCfczwvBoxJgGUYMNSguAX77Yu2A2Cu/Y4mzn2jOpxssFPzjUpdZ8mRtJ
    71e6zoLMEZqW2aNnnl/1bGWgsDU55SJ42JCf2c4kWncHlFOD3aT82eMt22VkBYMKa8IRjR
    /fdObI3vGF660vlHmO6y/teTokLuTnsRj334Nki86FJ+zcPM9jI60RHiTcV3gJRWkJgmIJ
    b09WxZK0DlSUUAj6cEQxjTIDnixvHtfpU05IOJTrPkY32heCCem5u/dNmuvJlNP7frj+Qh
    JVEHzuJuzKJp1PuoTmOXHrW2bh7ftAD4/6BieuYYdi24mXuBFqwpewXVe9ew
X-ME-Proxy: <xmx:6L3VagrPn2B_3brTzQMad3PiJsXHieYrnsC3daHlVdDbSvwdVzfkNA>
    <xmx:6L3VavmgDCvXOTMfi2WpJ2Esba6zEurY9i6UarC1kc_z-58LcctvWg>
    <xmx:6L3VanIrJJ5be3tX1YU630_ST0_P3KUSSBievbmpf-5emtt1-fyAwA>
    <xmx:6L3VakyeG5nirDkni_XqeMx5SpMRdR6eHwhuuLO8myecAn81qaJQGg>
    <xmx:6L3VangHyCeemxQ62zhHhhhytrl7FF-VQ15A7lctAyL5dSa1QZI11mRO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:51:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cee83913 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:51:18 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:51:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Olof Fairbrook <olof.fairbrook@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bundle: do not free uninitialized memory on bad arguments
Message-ID: <atW95CyeiQCGtIMX@pks.im>
References: <20261018142130.2701449-1-olof.fairbrook@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018142130.2701449-1-olof.fairbrook@gmail.com>

On Sun, Oct 18, 2026 at 04:21:29PM +0200, Olof Fairbrook wrote:
> "git bundle create" gives up with an error when setup_revisions()
> leaves an argument it does not understand, as in
> 
>   $ git bundle create private.bundle main --no-such-option
>   error: unrecognized argument: --no-such-option
> 
> Since 11ee9a75e7 (bundle: plug leaks in `create_bundle()`,
> 2024-06-11), that error jumps to the cleanup at the end of
> create_bundle(), which clears "revs_copy.pending".  But "revs_copy"
> is only filled from "revs" further down, so the cleanup reads
> uninitialized stack memory and may free a garbage pointer.  valgrind
> reports "Conditional jump or move depends on uninitialised value(s)"
> in object_array_clear() and in free(); whether the command crashes
> depends on what happens to be on the stack.

Nit: that last sentence is a bit on the verbose side, as it doesn't
really give any more useful information. I'd just drop it.

> diff --git a/bundle.c b/bundle.c
> index f55a521b2a..aad5f251ca 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -492,7 +492,7 @@ int create_bundle(struct repository *r, const char *path,
>  	int bundle_fd = -1;
>  	int bundle_to_stdout;
>  	int ref_count = 0;
> -	struct rev_info revs, revs_copy;
> +	struct rev_info revs, revs_copy = { 0 };
>  	int min_version = 2;
>  	struct bundle_prerequisites_info bpi;
>  	int ret;

Right. And for those wondering: we also release `revs` and `lock` on
exit, but we always call `setup_revisions(&revs)` before any `goto out`
and `lock` is initialized with `LOCK_INIT`. So both of those are fine.

> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index d709bea753..c39db5a955 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -127,6 +127,13 @@ test_expect_success 'failed bundle creation does not leave cruft' '
>  	test_path_is_missing fail.bundle.lock
>  '
>  
> +test_expect_success 'an unknown argument after the revisions is an error' '
> +	test_must_fail git bundle create unknown.bundle main --no-such-option \
> +		2>err &&

Wrapping only for the redirect is a bit funny, but oh, well.

> +	test_grep "unrecognized argument: --no-such-option" err &&
> +	test_path_is_missing unknown.bundle
> +'
> +
>  test_expect_success 'fetch SHA-1 from bundle' '
>  	test_create_repo foo &&
>  	test_commit -C foo x &&

I think overall this looks good enough already, and the nits I have
raised do not really need to be addressed.

Thanks!

Patrick
