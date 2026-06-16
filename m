Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A43A8732
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781651943; cv=none; b=o/igZ5XUcxo7UFBARIJMXRURilOxcuR1tszIfYqmYoctS6/SWhfZFAsBy/5VpJdh9jh3liiZXDdddztv//wNWHZLf7Z8qHUCsbttH0QIWkqZyeur5797tbnNEnw4DIldkn9Sh3iJycYqjuE/W2UUAfhlOt2lUk2sVfy1/CBSQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781651943; c=relaxed/simple;
	bh=d9p7/xqiEeo4605+ozxSJew6KdffPEnEiv1caQush9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6TiPWEUr0a8kQTwBccptD0IsR6mS5rBGfZgq5SRFVP3nASuMWqKDyR4rZa2usPn9B6c3r2Gt05XLSoIoBPLJeR5/SA22DmvjkThlWyWbWv5aFxQoF+HBwfriGc+6ZZjR/F4DNGjWYlrDpfFauSnTstwrhsYxSwsUl9UQgZDtR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eM1SgsS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bKrWtAQv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eM1SgsS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKrWtAQv"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 890ED1400183;
	Tue, 16 Jun 2026 19:19:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 16 Jun 2026 19:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781651941; x=1781738341; bh=G9Jk3f3t5Q
	MhSvvablbBlFPiQGtlWZk5hghbtPyTK5w=; b=eM1SgsS94q+SlL15Jfg7idGs+X
	cWs3uCUwSXc3jEQu/Wq/Saa82MUjCQ8gRAOVxmBP/35zCOoI4kTDsoiare1Kg7Ah
	WSnMl01ZfJzJrAjJmUZ9i05X+vufeLYCrTiUy/JmodH372C2Bx2GHa94vrMWAJx5
	311F73i7QnkvbvGVBzdD6zwYn21zFSy44aHc5onNWIAMpYCdB61+UAS2LYSn6BXD
	8fHCP013LW2Zf4MhC6+PsMOurCY473VmZ4i3qcAFuUz5UXNYA+Jy4nlzsuA5FU+H
	WJc3BCD8CikxbPL6QJWiFkGZUOav3y7qpwYGzBzrZ9LkviAINPFoLNvznttg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781651941; x=1781738341; bh=G9Jk3f3t5QMhSvvablbBlFPiQGtlWZk5hgh
	btPyTK5w=; b=bKrWtAQvQu0h8hGcEM1yGpmyW1JX94GJ94Kj6uT0w7jpEg/yeoz
	x9gmTFQ4fywXBM0SOL8VUEefN8gJ1Wy4VoDKzdsNnMzU/q8KUbtsKUT1rXZNvzzs
	BxXvF6bY0hMncGKecxfVB0f0Tw7EO1yTx7wd48hr6R3BMLo41vC6fDhWekkStv+q
	/uRjRx52BD2AvSTbHyVQMEk+/P7tqesFrqmTo9F0hBOzXhqVuXw69J66FhvjkyI+
	9yUjedk4UtknLx8DV0B3knY5SgpwR+QtzsistRDKBWKOT689GtrvxchQRfUI0Hx2
	lcNpa702xLTQRKBkbltk9W1jlJBVRsEhILQ==
X-ME-Sender: <xms:5dkxavkoAeqCBO1W5dgYc3-IjNkUVzGX7hAnHXUxTko5Y1DOVMzM9A>
    <xme:5dkxapsOB3xcuRmgeAek1r60U6M7THYOTyftU7htTn3kEeveLa-dJQVCqs552Uv1p
    z16APx_QnvxKcZNC5L3UINr2g5m0B7QzuOi2Kpt0SiVS_lNagpf>
X-ME-Received: <xmr:5dkxat8MF6qGCa1CG_W8JIEgimFgZ6CVCeQ1uaNRPy-xiZRQgG8Jj4lYK_h3uWFSGoDSWd7msUeC94AXNZ0JppBCVtByaop-ttlX>
X-ME-Proxy-Cause: dmFkZTFyTKwAnso1oYKKwvp0OAvZM/3Onz3NF0AhXyk0DRAL4J3OwmbRHkRp/NKRmaJ3Sf
    vRjqbgznr9cnsuF7bbzdwjdwBKAk/jkXuyubi3JX+PlJyGb8Wn61LYrpzKEWRZSGQGXTHK
    4WirmPRxvoAFWxUJwfsw4Dgkwx79wQDp6ORKBrcGMIiNVl3wsaP3V0F5+pmT0JQOOcIeZr
    cqhKeM2eS5sBj9V4riJVmA74SF8MwyTzaEXYNDzmrf5KelsPwhANrsOYfEPOZnEl8eVBGN
    txxLtyg9ODbJU89dxveM3fGlZiR77chxy/RFVDOEzlkEK4QB6p/fthY1Cfs63iXLOZ4WXl
    AZRoUNCz00rgrWFgJfNnSZ/Y+1ZEupj0KaiWYNxsUZFjCLSGYht5/7XjN7rtq7me87mnDq
    eATQni6A7Nqz2sVaPytQ+RXPfGHKIxOfhReNvndXJ6xoqfA/P8L9cy6x2wcWU2Gtqy9YYJ
    jYxoWmdImbJkJUjKPE6SAABYZuKQZtvikK7bRSnCmYXSr4uZ3ZlCEbZIX7B6xtxqaoviTT
    MAXE9MJwTTns32NyZHkOewB1Mg6RPmIGWKv84VFCXGwLwn9vb1HVudmwzJAG9g6SqXgygK
    /xgvUQJTH6Ln92/Ggk7y8GbHS0fRqxMz4tPFWwOGZuv4g4g2M9Xbby9xEwGQ
X-ME-Proxy: <xmx:5dkxajP_leaQxyLP86KDQzyxI82g_E5jv8SAmRC2NXWC7lXRymcCpg>
    <xmx:5dkxarE3P6OsYbmfTOVvJCs8NO4gfbUg4P3FFnZ8Gq3SpYnEWJRVCg>
    <xmx:5dkxahQWHCdkr42TntIXd_zdnJnqgTnEXnpOUN07qwW1TdPYV4b9jg>
    <xmx:5dkxaoumdOtOZU_w1atX9BxHf6W-6XBq21OwWtZY3Pnvvf3YA8WtWw>
    <xmx:5dkxapV0_uH-qrAFQy_QCWAK32zvo4zC5x-O4aivvmCOgEqJXXQN4L-K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 19:19:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org,  Bence Ferdinandy <bence@ferdinandy.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v2 0/7] Introduce fetch.followRemoteHEAD config variable
In-Reply-To: <20260616222606.1003521-1-m@lfurio.us> (Matt Hunter's message of
	"Tue, 16 Jun 2026 18:25:14 -0400")
References: <20260612055947.1499497-1-m@lfurio.us>
	<20260616222606.1003521-1-m@lfurio.us>
Date: Tue, 16 Jun 2026 16:18:59 -0700
Message-ID: <xmqqh5n213bw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matt Hunter <m@lfurio.us> writes:

> Changes in v2:
>   - Don't die() if the value of fetch.followRemoteHEAD is unrecognized.
>   - Use case-sensitive matching for fetch.followRemoteHEAD values.
>   - Avoid the phrase "configuration option".
>   - Minor documentation wording changes.
>   - Link to v1: https://patch.msgid.link/20260612055947.1499497-1-m@lfurio.us

>     @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
>      +	if (!strcmp(k, "fetch.followremotehead")) {
>      +		if (!v)
>      +			return config_error_nonbool(k);
>     -+		else if (!strcasecmp(v, "never"))
>     ++		else if (!strcmp(v, "never"))
>      +			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
>     -+		else if (!strcasecmp(v, "create"))
>     ++		else if (!strcmp(v, "create"))
>      +			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
>     -+		else if (!strcasecmp(v, "warn"))
>     ++		else if (!strcmp(v, "warn"))
>      +			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
>     -+		else if (!strcasecmp(v, "always"))
>     ++		else if (!strcmp(v, "always"))
>      +			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
>     -+		else
>     -+			die(_("invalid value for '%s': '%s'"),
>     -+				"fetch.followRemoteHEAD", v);
>      +	}

Not dying on an unrecognised value is certainly better than dying,
but shouldn't we at least clear fetch_config->follow_remote_head
to some "unspecified" or "default" value?  What does the existing
parser routine for remote.*.followremotehead do?

Ideally,

 (1) If the "fetch" operation ends up with not needing to consult
     the value of fetch.followRemoteHEAD at all (e.g., it is a
     one-shot fetch that updates no remote-tracking hierarchy, or it
     has a more specific per-remote setting that this variable is
     meant to serve as a mere fallback), any bogus or unknown value
     will not get any warning.

 (2) If fetch.followRemoteHEAD ends up being _used_, and if it has
     an unknown value, we should at least warn "we do not understand
     what you wrote, 'awlays', and we ignore it", or die "we do not
     understand 'reset', perhaps it is from a future version of Git?".

I do not think customization based on git_config() callback like the
above can easily implement such an ideal semantics.

And I suspect that the existing per-remote configuration that this
variable is meant to serve as a fallback definition would not work
in such an ideal way (i.e., even if we are doing one-shot fetch that
does not touch any remote-tracking hierarchies, "git fetch" may warn
if the value is not understood, and when we do need the value, the
code would only warn and does not die), so in that sense this new
code is not making things _worse_, even though it may be spreading
the same badness more widely X-<.

Thanks.
