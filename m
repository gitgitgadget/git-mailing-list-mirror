Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6E42668C
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876293; cv=none; b=E57HX26ZFd+U2wGn+xrx5HuLmFgYojYPAKKU/AhLtU87TTk9GotoWG7xfz3XnoM52cmhA09iT4WU6g50R18s+wl2tjf7OT7gf4rJNaSPcUtv/zhe+LM0h3XtTjxgAQS+7sn6iP2fzoTVSf9Kz7TnjiP+7AGhc+e+PLmpdV+Vsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876293; c=relaxed/simple;
	bh=9BNPzXF/ekkB/2V5Ztxlc8l4xP5aXk5CrZxceSaF0wE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cltObfqUSGJsuf0cEOO72UREObCfrhCJsD3WS0KmAwNIEDxTxarUrHrkA9JvsECxiAEp75XEgUVmKiF+mtnS3QEEQjEQmnqJ7J9UDjJ+seXuPh3NcIg84drcSwPRFB+kBbSXml+5WoeagaMR167FBXq55eXpuzhnVv9A2dXGfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=APQgoC4i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pB98iHK4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="APQgoC4i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pB98iHK4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 68CC5EC018A
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:38:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 13:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790876290; x=1790962690; bh=wWdbQt3Rwo
	gRKYJTB64V03CMolFMdXEBuo4cLINrWcA=; b=APQgoC4iwKTnZPppezYblcB8k/
	tPrSOu/KBpAoBx9sU0Cd7WbvEY62D2NFCsZq3F5/fcHlIeDuSI5aI+c4h45z53XC
	pgHCbw/apWmPFVriFAIQbhdSXBx+cvts8GADopf9MPkGTu3Av8hccqI3o2nobvml
	YeA/7j3dOoKFE6IK0ZVehAduI3NRcTu0SRZr5Xd+UKL+A/FfEk5mIOKbZ7pqyLv1
	glZ7lk7d3l2mb45hcmADRJc0NJTDml2Tu3ubTy1zibKbUPch5UKWYFrU+p8jpyXl
	M/Y4rYH6HgDz9feHp/CkGUH3c+L6A6SYooxL1mKI8OSHuNvviL1Gt7p4RQeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790876290; x=1790962690; bh=wWdbQt3RwogRKYJTB64V03CMolFMdXEBuo4
	cLINrWcA=; b=pB98iHK4/hV3tGbsmn4jVmW2i/VWD2GL8W9SMG94Y9BQpDOCdrY
	ymZWLPMkk2XJ0OerShytTY1xldVNc2Sg8kT1Lsco4Krwu6hpfSKbLNiZOQzpdgl2
	ikKlRuDOTjMMU59aCJ10Ii+G0YPZBuE+U/gBPhEiHhEyJMvMR/I3BQpXZmCDVyh1
	Y0LhHxFDIlP3YYCxWtEv01Voc7SnJ2tU8NcyyXY8R4OhFZ4xywcFrd0/Pvee1u//
	BA31nmwVbzd2G/2bOIWdm2fTjl4Byh+yACchhgmvsIwx8gcBBLVjLKw/zxRZKPm/
	QBlzKwh2IMF1cFYceX+IYppJ0sClwFrejfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790876290; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:NkFfSBX9w19vFDR7FuBsT2895zq1+isOAvtQs0qayEAC8qT
	VJioVYq/MWc5WLaXFeADsxzMi5Wl1On9MVPTDzYVO0cYZgbDkYv4FtAGUnebg0W8
	9y9kLr/+nBXUAswFhL+iDCxkTKHdxcQ3lcHwSktr3Z8+4Lz85G+2y+zwnmbQ0+Xg
	m/RcXelZ78MjFItc77vUOU2UoX71WOHxAO3sqGqmeIRplZzZjUmcofghB8tQ9DaD
	OK1FnxttLhn0Sz4rXNR3gdo6/GBUSDQbPBMiXAJCT9eXK0fVIqpGWEF7o1oxGAJN
	kkBSPArU7AyqOpImNGiS2EYJn96GJxBeMRiGibQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QJUZb4blh2XNjj4bT+E5Evq/+fj7y4KsE/cBA3GL3OA=:9BNPzXF/ekkB/2V5Ztxlc8l4xP5aXk5CrZxceSaF0wE=;
X-ME-Sender: <xms:gpq-at9Bc2N64MlyLdaw9QncsOHP-7oHVbxxrx1CPPvZNBK7Cg6Kkg>
    <xme:gpq-apJdp7K9caAJWv7ek_jjF9c9VQD0JjnCYGfPBHbxgnqAZbfI5jy_XhAw_ItZO
    IV-0lspK3Lv1U8u9IC7EA9Z6tXn4Odsawak6_NLjHwpQGh4-Hawsw>
X-ME-Received: <xmr:gpq-aoYLaoKCFCXGZbiRtXc3dRtuGVQNB_D1aFUwDGqdNVwxIDl74sV_kgRL80vp2IhLeV_Um8Xxa5X_5-dxt4Mw-oGMIz1eeMdm>
X-ME-Proxy-Cause: dmFkZTEYQusuGWgLD81dPXFGGsFdG6RebfrUHOQjatROBTh1qvf2Q1u3LZzuiypDcLhbHL
    TRMfZTqVsb04RfF75t+ybxppZLqIRvWe5YIkw0t9wSj7ApoYNGXeqejGxvQloSUEizMmbh
    6wxGxF7C8GoM0KZlii+Kn1/e1lolRiILcHk+uCJKWLYkawI7fOSIh/hwY3O9WzllXLdS84
    Rv9v0BVu7+MrKWMhGtDfFTHIgp+3dazQ/3BgdpJh6f3YKnk2Yh067it4jJ3Vowr0zaXUlV
    7kcowBVdiSTbYUCagigtHnZ7VuBHrOdXFCt3NohYRhDoI4skbbjbBdheT5IblfnfjbluR8
    vno3pSKxfp85lAlvj1sIkOaSYniknJtHJGyCZ6cV+lV0JKYY4LvVrQy5vlZtxVe7VNFhz1
    whRQBcPADM+cnzOIUU9qO8/XjE7gpnm1f9ZHAh8TIgUFRxZJwYrNakd3ftcYIv5sN1GCE7
    Y0vqNXSD48qfhDctXDZkKr8BMkUBDa9V5rz22q7x5ZMrnti4MpZen2VDdrvpP05EGEr/7/
    wo5qTDA//tG9vGrcGVUdSrJfL558JIpJVLILL5pq70C6MSoP5GnPaoXsERMjskCf6QuGFk
    iGavSxBmcSQGLADuqzz4+vtVBNfWWPDjDLvN/CeHJjFDFl5BQSMywKyTKgtQ
X-ME-Proxy: <xmx:gpq-arLP04ndlinlcflhIEyTc8SkntvQPMXMdloVDtzI-J4-HGw86Q>
    <xmx:gpq-amDWQjrYePa1sC2LEe8WS65BHSqoMq9iQz53bc2p2VgjMvvYlA>
    <xmx:gpq-agoIIcZ0R_FB_UpV0QkQLpDow9_TiUJDnbtjSNtwkCxProFzkA>
    <xmx:gpq-ahhyVIzwJ2tlX4mWS_UXzxBmg5apu0N6bkfvFvozDVRr0J4Xkw>
    <xmx:gpq-an8RSWbzkWQOab86-cc7U-aUwsu1NHeN08WB98_0Gf2cgIFYgjVN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:38:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] parse-options: fix completion format when first
 option is skipped
In-Reply-To: <20261001-b4-pks-parse-options-subcommand-groups-v1-1-01eb2f4a4c32@pks.im>
	(Patrick Steinhardt's message of "Thu, 01 Oct 2026 12:13:28 +0200")
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
	<20261001-b4-pks-parse-options-subcommand-groups-v1-1-01eb2f4a4c32@pks.im>
Date: Thu, 01 Oct 2026 10:38:08 -0700
Message-ID: <xmqqik3l5njz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "--git-completion-helper" option can be passed to any command or
> subcommand that uses the parse-options interface. The output it
> generates is a space-separated list of subcommands or options understood
> by the command.
>
> The format is slightly broken though in the case where the first option
> is not being printed, like for example a group or a hidden option. In
> that case, `show_gitcomp()` will of course skip that first entry. But
> when printing the next option it checks for `opts == original_opts` to
> verify whether we're printing the first option. The check will evaluate
> to false though as we have skipped it, and thus we'll print a leading
> space even though we have printed nothing else yet.
>
> Fix that bug by tracking whether we have already printed anything via a
> local variable.

Very clearly articulated.  I would have chosen 'shown' as the
variable name to so do, but 'first' may also be OK.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  parse-options.c               | 4 +++-
>  t/helper/test-parse-options.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 4519ead9dc..356eeff016 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -845,6 +845,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
>  {
>  	const struct option *original_opts = opts;
>  	int nr_noopts = 0;
> +	bool first = true;
>  
>  	for (; opts->type != OPTION_END; opts++) {
>  		const char *prefix = "--";
> @@ -882,8 +883,9 @@ static int show_gitcomp(const struct option *opts, int show_all)
>  			suffix = "=";
>  		if (starts_with(opts->long_name, "no-"))
>  			nr_noopts++;
> -		printf("%s%s%s%s", opts == original_opts ? "" : " ",
> +		printf("%s%s%s%s", first ? "" : " ",
>  		       prefix, opts->long_name, suffix);
> +		first = false;
>  	}
>  	show_negated_gitcomp(original_opts, show_all, -1);
>  	show_negated_gitcomp(original_opts, show_all, nr_noopts);
> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> index f181f0c02d..fbafd67756 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -351,6 +351,7 @@ static int parse_subcommand__cmd(int argc, const char **argv,
>  	parse_opt_subcommand_fn *fn = NULL;
>  	int opt = 0;
>  	struct option options[] = {
> +		OPT_GROUP("Subcommands"),
>  		OPT_SUBCOMMAND("subcmd-one", &fn, subcmd_one),
>  		OPT_SUBCOMMAND("subcmd-two", &fn, subcmd_two),
>  		OPT_INTEGER('o', "opt", &opt, "an integer option"),
