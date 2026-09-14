Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FDA483817
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399823; cv=none; b=NzBKFMTeP490BBoYaf5ou6pZCFa0OVXTF5LwEn4dk1a8H5jwZDIOBBQp+HntnAFjjQZE96fe5g3f+ZsyCspupkTpLTFMXjVEG7nnjLFg4ZrotBCQe0s8f1/9IJygMq+RB+b7eyaWFt2hzrIrsTFypj8raQdjaGsTNd6k7lzF4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399823; c=relaxed/simple;
	bh=SKzkjZj3sYuHlxtQ7WjkFmhApPYaVA+iPiOt4WyJj3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgfgUufP9uv2H6TNlZ7cSQOnEAhpxqTsvws3Br6QPuoaHSTfaJiENFYmcvi/s9ZRmv0poXLCTKTf7dZn9pckdkuGb5SBG7bXn9v+aeSONivpO+eg/jYMS5rt+CeRgpNR0NELhU5tNEA/eTjZbyXJa9Hk7ZTB8fKKlnF0TdXiiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UcSUxtU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnO5HQRy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UcSUxtU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnO5HQRy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D754B7A0133;
	Mon, 14 Sep 2026 11:30:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 14 Sep 2026 11:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789399820; x=1789486220; bh=J5c4w8DCCg
	x1tVE/4CQ0kgyqDzE+N03iFoI8hJNUkBE=; b=UcSUxtU186YiGh5LKTPA9HSql8
	PW8OSaB4EwTwWFarSMxBGIhkVl0uq6haCZp5SU0OGPtZFF6YvQMFZCztqIaPGCHE
	uInGumfoZveYsyn4CuLr4nj3vmEZJGyp4Zo811y10DwFk66x4rsgwz0tnK1w9E7t
	cN8nH43by/bu2qDu4J3zbkkcXl6fVU4lNCLDREsHCOUhRkeFP6LxoUm4RAJD0M7b
	zD3eINs4kmUWbx8jsieQ8CVsKLoddqwo7OkIlq/AoA/VqQ9Ah+kHLMsx09SjGkuj
	ROAruuA48q5AjU9QX+D/vk/XgwBkhhflid0JAOoPC98rCi/qXLLga8xtg6Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789399820; x=1789486220; bh=J5c4w8DCCgx1tVE/4CQ0kgyqDzE+N03iFoI
	8hJNUkBE=; b=EnO5HQRy2fwTVDhrYL5k8J23SShe9b/yMYze9VW7qjXKo9ReYu+
	PxyaH4mh1RTzGHTEOJnBCdqReI9AoeQD830sJ+aYWCQdxvZohFfkwA9ewJTNeePS
	yNpvyETXgYnphuZc85eWlLRp4DhEcv1jjFg8yHb1AmEyOlO1y5Iv5ikRy6DWZk7F
	8DQvdHWNPnW2KpVYMpaxOGWv/K1+EXF4o6XMgzcLa7iTi35y2dro366CbKa8TwHx
	kDR9Yoa7rZoYppNittKQ15lA8VJxF/c/5hvOZnQTXxllAN2J19vxR06qoFj2BoiI
	XgF/HGZra5Dt+qZqXXnvt6gkXGPwlubsmmw==
X-ME-Sender: <xms:DBOoajMDWhxZtCBkoLnUfSB1h1mUhBd3CLrww9bQJqllXEn6UWv_CQ>
    <xme:DBOoak_vZYEPPKJZgvp-WEMXitHgh0XDPbPh3_Nbm5VcXC6I6wYEc8Os1EWLg-w03
    VEEmuS7zgPkipdYyoYTDUUrbUa8WmtyoYTNMp5afQxAHCs-OgFwKM4>
X-ME-Received: <xmr:DBOoanTsJToQVs0haBoluxJ_41zWXXfAO1UvHL1LDQjKm7ePS4agsT5Jq47J0vW1pfPM3BvK8kElGydW7kbBIqaCpOUmA3LqGRTP>
X-ME-Proxy-Cause: dmFkZTFqhlUmncHLsIOQNSVriuCGaGX+9/2BAFXyYJosYYlzZ3zJjiSLdi/Ibp5A/pGDQh
    GwTmA1PMAHc9nartG4pD99SXqEX4sQ9WJPAbPOLOpyhLmvcfrma0KBKD5jgg+WNmXa3m1e
    1FYS70N5QDOqCxM5NSGSxYsLK8geUZDP2OpGrNa/goqU5VKEjKoR7b9Foa2UYrqhGEDFy2
    QtcL9AEk/fdKcZb3GIafsqTK4NCyAe9otdn/QgsmouYHJyEut5QXctzY/76U6QAAvUe/+i
    EpJwBEhjDpwDUw3QZfqhjZ+HBTragVV/PM+cF3IMe4Z13Zo+Jbvo5aYrKufsNdx8ZMYkSx
    8LKluIcEv00Gw9GV0byEeXouCSqY5HjovQdF38X+dcCvWj3RNkX2MH3A2+X1sYq4NaQ/Hx
    c+SoyPJuW5fujqTux/SHtr+V/VleRmvfeQsihF7rru+ePDuARJUWUCu0GNfUZxQpL0Q6b1
    zFGpnY5qECt0xQqd8baBLTsf16D0le6HA7832SsVUyE4wfAEs/h94TFYvcQRyyPlNT93Vm
    tgzkfGMnkgBKbUyvGqI/1qQawwfOJbmAE1x9+A85DLlqwp/ftZhTLYLfRKvoRbCyzvkL6j
    93ELsUuDkLbug+fLCfczgyg33c7cZR4U03BD4lqKMobfcjK2iCV3FjxMffbw
X-ME-Proxy: <xmx:DBOoamnzpUAY5reYtW6LjCAsu5IPSsKfEbcVqm1IZB3dBZ6rwMPTug>
    <xmx:DBOoanQvZr-et3gnA_A58Us6KzCcED-nOFQbOEn8A3GRHFTMCLiVow>
    <xmx:DBOoakO6qvIq5sGCQFEfINd1_eY6AQvJ8bJu5TBQut0SNPFZc0SRlA>
    <xmx:DBOoagWUuA1luDYe6m_avfo7J-11tSdvFobFHWSP-7CXUhV5hKKUzA>
    <xmx:DBOoaoPWrZN8hxs5JCdXw7MTXsgbC9tYb1imWrxd5axL8_2xe-Wha1EI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 11:30:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] doc/pack-refs: convert synopsis and options to
 new style
In-Reply-To: <20260914124630.154107-2-tmz@pobox.com> (Todd Zullinger's message
	of "Mon, 14 Sep 2026 08:46:27 -0400")
References: <20260912191509.844954-1-tmz@pobox.com>
	<20260914124630.154107-2-tmz@pobox.com>
Date: Mon, 14 Sep 2026 08:30:18 -0700
Message-ID: <xmqqcxuf7svp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Replace [verse] with [synopsis] in the SYNOPSIS block and remove
> single-quote formatting from the command name.
>
> Backtick-quote all option terms in the OPTIONS section and convert
> the standalone placeholder _<branch>_ in prose.
>
> Update the included pack-refs-options.adoc to backtick-quote all
> configuration key terms.

Micronit.  I think you backtick-quoted `--all`, `--no-prune`, and
friends, that are not configuration keyu terms but command line
options.

> diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
> index 0b11282941..2263648b39 100644
> --- a/Documentation/pack-refs-options.adoc
> +++ b/Documentation/pack-refs-options.adoc
> @@ -1,4 +1,4 @@
> ---all::
> +`--all`::
>  
>  The command by default packs all tags and refs that are already
>  packed, and leaves other refs
> @@ -8,12 +8,12 @@ This option causes all refs to be packed as well, with the exception
>  of hidden refs, broken refs, and symbolic refs. Useful for a repository
>  with many branches of historical interests.
>  
> ---no-prune::
> +`--no-prune`::
>  
>  The command usually removes loose refs under `$GIT_DIR/refs`
>  hierarchy after packing them.  This option tells it not to.
>  
> ---auto::
> +`--auto`::
>  
>  Pack refs as needed depending on the current state of the ref database. The
>  behavior depends on the ref format used by the repository and may change in the
> @@ -29,7 +29,7 @@ future.
>  	  maintains the property that N is at least twice as big as N+1. Only
>  	  tables that violate this property are compacted.
>  
> ---include <pattern>::
> +`--include <pattern>`::
>  
>  Pack refs based on a `glob(7)` pattern. Repetitions of this option
>  accumulate inclusion patterns. If a ref is both included in `--include` and
> @@ -38,7 +38,7 @@ tags from being included by default. Symbolic refs and broken refs will never
>  be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
>  and reset the list of patterns.
>  
> ---exclude <pattern>::
> +`--exclude <pattern>`::
>  
>  Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
>  accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
