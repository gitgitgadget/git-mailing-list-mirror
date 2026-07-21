Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B15265606
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663790; cv=none; b=paYMW4omsWCNpS1soaMaUyyVDySFzPXj2jsFC8CjlEvczOxVR44oM/c+NZuc/DMNom4p0dxNzu19fQeKCEGwra3PMbc81zsh1RHoSdhSXSsUI5Ic6pn4iHr37Ps7pVY5d6LanyxRANdB5AvFDSEBApHw6SZ07HMS4FNCZtFnsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663790; c=relaxed/simple;
	bh=NEKibsEunhahhV/rtX/HiG+tF5tD3FhfkYRl2xW9vlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGVimx4Niaq3ygxbhHT9Pm5X4trzIT18xncxBJrAlGC7n3brwd++SbLOK05JeusYsLix3mxweSwtcts2A+NzoeXEJ4tqHa4tURDOQgenWRmvVwf2mPlB5t/WWB7Ar6KTl6H7HUgCrYnDCtI7jgMmSZDw6rqCzwLPczKQ4irG6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mcXvO0Z+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mcfYoIGq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcXvO0Z+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mcfYoIGq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E0DC1D0004A;
	Tue, 21 Jul 2026 15:56:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 21 Jul 2026 15:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784663787; x=1784750187; bh=vqXN24kSWl
	Ee0dCCpjMD6c4VY+rRfwOrwFNcR68L5jI=; b=mcXvO0Z+MJpwodNamRCyUc86Xy
	hU9y45jg5TS/XppuzSaKZhoGK3veR3Z5omn+WS7V6q1oDEQWvlajz2/yVKGtcvEC
	iHFEUk7rH5HALO3Qp3bNVbgH0vnlCD9FDo/5R8FeMBO4nBlzSWRfeimEVbkdDLfx
	DCW1Wt2USKRJ74rPoodlClTpGhZaT8MN7K6qJyEmmrqRtPslvXqicnkmuYF0/YzZ
	KHR0amNlrxdaz87mvneeWUbUT7serdUaXNl/SCz0DpYiD33Z7eFUBKUora0TJ+Sd
	RpFq3BPsErFYfcatzRop8g0zkSKFZONv0L5Mnk4vhyugnJND6Qyh+5NWL3Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784663787; x=1784750187; bh=vqXN24kSWlEe0dCCpjMD6c4VY+rRfwOrwFN
	cR68L5jI=; b=mcfYoIGq5dInK8gtiGR3jauAsD5pkg3J5DhgsdzZBAFh3N95RS0
	qYZX/U3bogOItGn1jv5lbBG8wI7s/s/bDF+b2me4DIaZAOIzP3cl6FO9iooyXAB8
	Ao89gqu/sbyPY411NM7bhXdPXjFY4onu3qMmrU1Pr9PtjgAxdGPhhdTniDW3XTyq
	fyOMfd2eLfxN5ncEO03owm22cHh38JFo66JkoiM9ZwixbyK0PX10Dfy72KsZONO2
	fkaiT26pS+upZqZdh8F/0o61Lrg/JuWar+mz8jLnJRZUYxjrYRo6esajA5R+LfSm
	VyXkTFgbh9dL8uenPJXhbfu5v+9PA6QdTbQ==
X-ME-Sender: <xms:6s5fakIwfwph5tzandsCV-jcEN2aYzXsFIACruvmEhWEnr206vCPBQ>
    <xme:6s5famu4DqlGYrBZ-VC9Mz1VaHHAlyT_oF1keCOYaOzkqlcxxlIuuc5JZds2xkOeV
    F4BZbYyRs9T1Y38rYbuHVj8DezMRQjPJDttoBVjXohL1vecUrBzxw>
X-ME-Received: <xmr:6s5faoV8tojW1CmU6nJ1Rqb1NhuztadNlSSiNiRp9Z2onfrRNae2U3WH2m3nsSPzFG8_Puu7xg44iijIhkILF0LWQQFEwpcMdw>
X-ME-Proxy-Cause: dmFkZTFvEBdedv8g4FqLXTX6MmzUcOrgpiR2e2I9OAZoU2iRX5eH0/7Bm88nwAh4JOzq48
    plvuIzyQNIuUigawh/hjj18EK5REzK1GQ7VZ3dsXCJ+DCLyB8aY+rYd4fTXECWfML+Sslo
    aVDYD32luHKKWh8VhEUGO1N3k8H6OsYnqd+f1cCL7WtQ59Am/KRhePZhHVnaao4vCOwH9f
    5HXwtRDsEhNqdW0l5SKT9S1sTFcaIu3PAeFmGcYYYBh5CziKGqEjvqHPuLYPumMpckjmEt
    2NhPsgHQ5SBXo4yulDfu9OtzDwr8HNRKwz0haMkwX24wu7zgzUwLciEXMIY/NAuBvrFHDJ
    1yXcGPywv7c4G4m/xlgrBFSgfN+ei7G0MapFY4YkBvcwK4prrwgO+OA0ghyzCtR+BsDgQN
    5+BKOsLZh7JnN8WIe9rectm+5rLtaU/Nsco53PD4QbeJGdY2LBxUkaQa2IQ5/Oxvv00yOq
    IHNArodlids8mVTWrlVSMo18LOFy91UvRI7/R25rMj1Yqi27q6nzO2dynl2e3rc+T42qib
    WXhcltg+cz26WNAeTJdCfpAJSmVQa8i7/I4ZRPOMHuuwAY1iUBHEkP/wK7OKdYW3eEwHJk
    PKjQBD5KyehQdxPFDDkjEu5OqkVwKlOp90PjEEDli15AqY/dArIuUGAtx1jg
X-ME-Proxy: <xmx:6s5fahg4u1fjlEsyFiATENIdXCrnFU8sALv7qHQ-dKELLr5wL353pg>
    <xmx:6s5fagqivJYzrF9XbJ_6ZKb_K2MC_ch6w3l59kkrGIrlG6nuf9YYDA>
    <xmx:6s5fanGwv8bipKQ-C-s8RVz1ZZFRWMo314wX-CdTdyZeWr32P14PrA>
    <xmx:6s5fal6iVkc2zbxShB4ffaf8aQ0uwlUBlrF-khx26KHE1k-s_M0scA>
    <xmx:685fanOZVwZuPhS29msuzRUEvL93hVny8-7nx5KnjZJXLSkM4CHoLGNA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 15:56:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net,  ps@pks.im,
  karthik.188@gmail.com,  sandals@crustytoothpaste.net,  avarab@gmail.com
Subject: Re: [PATCH v2 1/2] http: avoid concurrent appends to partial packs
In-Reply-To: <160a9b9fd0982dadfbf6f8fbb378d1a3e9173698.1784582665.git.tnyman@openai.com>
	(Ted Nyman's message of "Mon, 20 Jul 2026 15:33:59 -0700")
References: <cover.1783982021.git.tnyman@openai.com>
	<cover.1784582665.git.tnyman@openai.com>
	<160a9b9fd0982dadfbf6f8fbb378d1a3e9173698.1784582665.git.tnyman@openai.com>
Date: Tue, 21 Jul 2026 12:56:24 -0700
Message-ID: <xmqqo6g0unfb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ted Nyman <tnyman@openai.com> writes:

> Pack requests stage downloads in a predictable partial-pack file so an
> interrupted transfer can be resumed. Both packfile URI and ordinary dumb
> HTTP requests use this staging path. Opening it in append mode lets
> concurrent fetches interleave their writes, corrupting the pack or
> causing a later fetch to request a range at EOF.
>
> Open the partial pack read-write, seek to its current end, and retain a
> per-descriptor offset for incoming data. Reopen newly created partial
> packs without O_CREAT so Windows permits concurrent unlink, and keep the
> descriptor for index-pack when another downloader removes the staging
> path. Accept HTTP 416 when a partial pack is already complete.
>
> Exercise resumed transfers, EOF ranges, and overlapping 200 and 206
> responses. Clarify the staging-key documentation and correct the stale
> --index-pack-args spelling in the documentation and error messages; the
> repeatable --index-pack-arg option is already accepted.

Hmph.  So the idea is to allow multiple processes to open the same
file and, because they all know where their respective chunks of
data fit in the final file, have them use pwrite(2) to deposit those
pieces at the exact target locations, and this prevents them from
stepping on each other's toes?

I cannot exactly explain why but it somehow makes me feel dirty.

It is also surprising that the workaround on MinGW works when
one of these multiple processes finishes writing and attempts to
finalize the temporary file while others still have open file
descriptors to the same file.

> -	The hash is used to determine the name of the temporary file and is
> -	arbitrary. The output of index-pack is printed to stdout. Requires
> -	--index-pack-args.
> +	The hash is used to determine the name of the temporary file. It need
> +	not be the pack hash, but it must uniquely identify the pack contents
> +	for resumption. The output of index-pack is printed to stdout. Requires
> +	one or more --index-pack-arg options.

OK.

> ---index-pack-args=<args>::
> -	For internal use only. The command to run on the contents of the
> -	downloaded pack. Arguments are URL-encoded separated by spaces.
> +--index-pack-arg=<arg>::
> +	For internal use only. An argument to the command run on the contents
> +	of the downloaded pack. This option can be specified multiple times.

Was the 'internal use only' thing renamed in order to prevent the
new code from accidentally working with an older caller?

    ... goes and notices that the code uses singular form throughout ...

Ah, no, this is an unrelated typo fix that remains valid even if the
rest of this patch is dropped.  Good catch.

It would be easier to review the actual changes if this cleanup were
isolated in a preliminary patch.  Are there other cleanup changes in
this series that fall into the same category?

> diff --git a/http-fetch.c b/http-fetch.c
> index f9b6ecb061..05f68f306a 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -70,7 +70,8 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
>  
>  	if (start_active_slot(preq->slot)) {
>  		run_active_slot(preq->slot);
> -		if (results.curl_result != CURLE_OK) {
> +		if (results.curl_result != CURLE_OK &&
> +		    results.http_code != 416) {

We do not seem to use symbolic constants for these '4xx' codes (or
'2xx', for that matter), so I will let that pass.  Eventually, we
may want to give symbolic constants to them to improve readability,
but doing so is certainly outside the scope of this topic.

> @@ -155,7 +156,7 @@ int cmd_main(int argc, const char **argv)
>  
>  	if (packfile) {
>  		if (!index_pack_args.nr)
> -			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
> +			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-arg");

This and ...

> @@ -164,7 +165,7 @@ int cmd_main(int argc, const char **argv)
>  	}
>  
>  	if (index_pack_args.nr)
> -		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
> +		die(_("the option '%s' requires '%s'"), "--index-pack-arg", "--packfile");
>  
>  	if (commits_on_stdin) {
>  		commits = walker_targets_stdin(&commit_id, &write_ref);

... this is the same "index-pack-arg" fix and can be moved to a
separate preliminary clean-up patch.

Thanks.

