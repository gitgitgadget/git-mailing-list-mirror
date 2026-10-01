Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3804F93DC
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876793; cv=none; b=c3hO8yISQLjigGNs9wAj4rSvn1IvXnPMYFCkSfRdMJfTN7RCi504ROGv4Alybr3khILBE2+n8rNe+qlnBDUc3YG2uF5+/3QLbFWG0A/J4UEgqhoK1UjF4z62DVewOUKx4hWFTrd5QPXL9FvqpVz97c/A7uK3PsXk2BidK6CrLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876793; c=relaxed/simple;
	bh=x5+JfsFRybScx7FwADC3k0uDPTN6u2EfLFK7110BiUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FMnUVslMSlr9zrHlTMsbX8JBdegdea68t967uET1ssecGGddQUxFos7m8sVOvGMqS8FYyWKJhF1Eqs2I6Q6rCIwUshZJQgKtVtTD4YRHeyaTjaZQU8KP7f6KReu9dvVE++VWKRsaiiLq3NB6x/vjNTmBnzKpSvItOKgzoT8Ca5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bBxtRoAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEGdUXN/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bBxtRoAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEGdUXN/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C7F65EC01D6
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:46:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 01 Oct 2026 13:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790876785; x=1790963185; bh=EENbf8lyK4
	tLbcuXN55ZDeSeq7HvqD6Fmu3cI0YIMqw=; b=bBxtRoAzuvH7jDvB20wHZVn5ht
	jXKzKSnVbW+8KKV2M65aSWvC606yR2yywsvwvqZWXH95pu+bfjilwjTVg75pJIrb
	60Bw32/GhPCrUVYH6gYE8W7uM0WYGhH5xRzzeV+02+eT7s47UEuS9R+9x+cOppZF
	Nn0tpFcDy527sJ2/PNfUTlNP9Zhs11XMNMn2SV3/a8VoDaNzZr5MND7npl2A9ntk
	Ugrq4o4raReHjS615js2PdWIGtuq+LF6Q0D18dG2zZe16nMCFQE1isWmBv1nHpOG
	DkOWjF98dEalhdvX7iwjPDPnl5frKXycbhaCx2pAK3CTVCZSG4pX5OsgzidA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790876785; x=1790963185; bh=EENbf8lyK4tLbcuXN55ZDeSeq7HvqD6Fmu3
	cI0YIMqw=; b=hEGdUXN/b00TOresbkY9HdTnJ21f9zwW8z2ITKx3Y8gDxcC2jRS
	+Cvt+9NJgj/e0sHIj9FdTnazJh5qvCIBL7LlStFA3VVdd36KU9cPMxaPHM07ZjBc
	crtvdNG6EPX6NY56vwXupPpjgPuI1GFlmne4qChgqbWDOz59SZ+w9D5y1OBXUc5z
	izfgFq92/YxbJjcUkNbPsP4h2YHjZ1rTb8XJV3F4VB/1NGM+COIOaMHdIo9MR2qh
	Q9J0THiyaWh8uifmtVYulG5mJjhfrdGF0WsYmK4pR2n6vMxVaRyj5FzdYqbO//Cd
	kZzLyACG75QoP5hNXw1h054dXYhE/9KAyeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790876785; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:bM0pTjUeuCS9trXEZMQ6kbGRIAEJq5sGK5zKqMTwIEtOjfk
	LRmPQs+lNt1PWQzNZa71auw1KJIV+fOWVpnTi0v0oWh6dPnZ8g4QGqvivt5ENMD+
	v7TwKe+LRj6Caayd0axNTrn2pZtKmormIhWdDp9bVZwd56KlGJ/O1gNB1imqfpjP
	nIhRhMh9CChD1uTCeyN83bH8y7i+ll+wq7o0BvF/Rkyqww4Qo+1AtImF0Kb65xEm
	aaQLRhNwPMISky0kExRNcjDQTKtwzel6/VGKlPxLaYjJdTdRJMmkmg8DIiHaW3MO
	xUh9EcBv77TUBJjziLsoK/JUJCQiMH5H8iXawuw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:PJX9/z4S+l5/EkZAFqXYBsbCgTe6f9OD1p7/D3D8qVE=:x5+JfsFRybScx7FwADC3k0uDPTN6u2EfLFK7110BiUE=;
X-ME-Sender: <xms:cZy-aho8b6qOHKXlvRXmwlXLSAd5elinW0SmRmxfPxgiitv23mKiUw>
    <xme:cZy-arHqJSdjF8jfvYynZyqFBVSKIiKVbm1DJmn3STdlQvdti_A1cVBjerDPSYY2G
    YdLcaHBAae_muxeR7retKhmCLM7gqJbk63vwvHwLjo72w-muV78L-aY>
X-ME-Received: <xmr:cZy-arn7qcmFzQgeamte97LvzFNQgq5XI4-OtumSJmbUmpqDBTw_3ulNyrQWjmX90A8l8IQ2P1hwmM3miTXs1DFJHl8LOHeivyws>
X-ME-Proxy-Cause: dmFkZTFWe/awTcRXSwn3fw9X69ae+l/5rKEn7k6mefIj9xdfpzsX3wePindE5CdbIxLYmM
    ZrGnFpL2T8+kBjZ6dXnfonOFHPTeB+JljtBtMzCLx0Ov+r3UXib3OzVRPKbL4bP73MMA/Q
    P6BowY4IYJlElWtBE9y1NXaUIDnff7T0mZ0bw6XaxFsSqHlII6D8BbyMBR5YujcW+koSZj
    O3L8NszQ9b2nmxWN66+H4PgJo72AQfx6Jvzz3YcjEUawSybapuR8hYLaJbawoS7MaM/FlV
    xwNUwyAOoLPe6U6QOzSnpR1a9hVefJsFJu5/N50vDxADa0K2U+EEKfrAlPzd44x21w28X3
    Fh0CQssACk6wGWQXvZgA/xKjagFZMojKEKlyvMRkjHRJsCScnHS/Xrb24XVGciLdLLNixV
    BG9PN6mkigBxacXEChqQKXHj1FtvzmmlwX9/7KInLytpUQbRXRVR5vE+6rFTCO6XHnF4XG
    Eel6M+O9a9b7x24GAZ+yhYFAN3ZC1bXiekjH2BoNnulDZvmOKdWChz92d12GM9xNFF4Auf
    LQW2Yb58Aq69OMBh2jFzceamvH8/jUE0ediH0NmOVdm8dk/M+J9E5sUlUrq2w9H9OX048f
    yYsN0Xo0p+MRilVxcaGf3G2HE90Tj/WqUbecVM0q4JNwiwQbNnNjt3cI2wsQ
X-ME-Proxy: <xmx:cZy-amnn3voZsVY7ZEucCM5d5Z2aMix6DL7PArb8VP_KkNdSxqmhug>
    <xmx:cZy-aktZ_uGACNT43XhvACe5IuOsDUHW5jpyBzYWabu4owpo1HgaCw>
    <xmx:cZy-ahnoOiMH_7jjgijAJ7Puy8RoNfDSx7Zg5Z_i1ApZGh-sUYCA4A>
    <xmx:cZy-antSev-ascNXHEX0YjtS2NHZpVxO8rKrdRVTBrkVf90hQmOlxA>
    <xmx:cZy-ajOFiUSiaCLkq7XpQpiL1Eq3EoILM59p3T33gYHjGmtw5RxOQQ8J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:46:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse-options: allow grouping subcommands
In-Reply-To: <20261001-b4-pks-parse-options-subcommand-groups-v1-2-01eb2f4a4c32@pks.im>
	(Patrick Steinhardt's message of "Thu, 01 Oct 2026 12:13:29 +0200")
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
	<20261001-b4-pks-parse-options-subcommand-groups-v1-2-01eb2f4a4c32@pks.im>
Date: Thu, 01 Oct 2026 10:46:24 -0700
Message-ID: <xmqqcxtt5n67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -1432,35 +1432,39 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
>  		}
>  
>  		pos = usage_indent(outfile);
> -		if (opts->short_name) {
> -			if (opts->flags & PARSE_OPT_NODASH)
> -				pos += fprintf(outfile, "%c", opts->short_name);
> -			else
> -				pos += fprintf(outfile, "-%c", opts->short_name);
> -		}
> -		if (opts->long_name && opts->short_name)
> -			pos += fprintf(outfile, ", ");
> -		if (opts->long_name) {
> -			const char *long_name = opts->long_name;
> -			if ((opts->flags & PARSE_OPT_NONEG) ||
> -			    skip_prefix(long_name, "no-", &positive_name))
> -				pos += fprintf(outfile, "--%s", long_name);
> -			else
> -				pos += fprintf(outfile, "--[no-]%s", long_name);
> -		}

It may have made it easier to follow if a preliminary step pushed
the above to a helper function.  It would have also prevented the
nesting becoming too deep as we see below.

> +		if (opts->type == OPTION_SUBCOMMAND) {
> +			pos += fprintf(outfile, "%s", opts->long_name);
> +		} else {
> +			if (opts->short_name) {
> +				if (opts->flags & PARSE_OPT_NODASH)
> +					pos += fprintf(outfile, "%c", opts->short_name);
> +				else
> +					pos += fprintf(outfile, "-%c", opts->short_name);
> +			}
> +			if (opts->long_name && opts->short_name)
> +				pos += fprintf(outfile, ", ");
> +			if (opts->long_name) {
> +				const char *long_name = opts->long_name;
> +				if ((opts->flags & PARSE_OPT_NONEG) ||
> +				    skip_prefix(long_name, "no-", &positive_name))
> +					pos += fprintf(outfile, "--%s", long_name);
> +				else

> diff --git a/parse-options.h b/parse-options.h
> index d7f896a933..5249404b46 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -401,6 +401,13 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
>  	.subcommand_fn = (fn), \
>  }
>  #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
> +#define OPT_SUBCOMMAND_H(l, v, fn, h) { \
> +	.type = OPTION_SUBCOMMAND, \
> +	.long_name = (l), \
> +	.value = (v), \
> +	.help = (h), \
> +	.subcommand_fn = (fn), \
> +}

As presented, _F does not allow you to give it a help, and _H does
not allow you to give it a flag word.  I would have preferred to see
OPT_SUBCOMMAND_F to be extended to also take the help text, as we
only have two existing users in *.c code, rather than adding _H
variant that is incomplete and keeping _F incomplete.
