Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092423C4F3
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077962; cv=none; b=oO04fySnnvXOi/chgO5U5nwHUX2+YzmSd/GMe8y1+8u1XU3Osp/WKrIrVBoFD82RcRadPHxK1phgLAif7Ye5QDIBZ+hqRT0gYJd96YkfrgxMF7JEFDCO/CRYgextaMZsR/hhkRy+OScE6smxmCcxXrw1Clapg8CjEOQRcHcte3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077962; c=relaxed/simple;
	bh=kv6HqmFu8J3i6bQ5CPPburroTUvO9Ic3lFoqvU5sJD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ic10nL8KCPHuxMvxG9oMq7AKneJWUfYTLr/Q6zPZChQ9l8WtS1p+egMMsuD4zOySaaX5YuHNj5KYtiz7T7ybBt1+43TZOoGePhiih7Eb4hPx0Z8iyid9Nw8zaY/ijIjBSyBwmFzN1sgaOfG0CF1L3bdvtqtL02i/tMKPlN6gWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CzQhR41H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMcH3Uuo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CzQhR41H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMcH3Uuo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6B5E14001F6;
	Sun, 21 Jun 2026 17:39:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 21 Jun 2026 17:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782077960; x=1782164360; bh=vxy2+0bp/o
	S+Db2PSDdbIhFEgRd/Y5Pg+5KCzoYG5xI=; b=CzQhR41HRaetZyjGPkHqKXkQmi
	S7dwU9u/RJI99NRLlStxyCHnBX8dguSLJDMsRp+WPgkZVio3eM0sutLRCanCCta1
	RZKvbkOaFu+EgkFE6LbnITmf+/Ig9cvzNPuUxI0qgVYJXdkG72yok/L1b4KiXqYP
	FnR4B4CLJR4fto8JIak2VvjcGvwOVATtBDAijyS0FnrIU/TghvTMsL6lYg+ipyMB
	5OPiJA0Yk+A5G1+W9OOCRJXBzaVL8crzk4det4AqqkfZ5b5GvygjYWMmDb8sflFh
	dTsOJe2qlzKs3mTs/VLjRDGJCfQMeonvIlzftLdvcUnGdfVuT0ehiVT6Xekw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782077960; x=1782164360; bh=vxy2+0bp/oS+Db2PSDdbIhFEgRd/Y5Pg+5K
	CzoYG5xI=; b=iMcH3Uuo1XOUBOAm5uDCNzUhPwmFs3NX58ILsgTk36s8r06ddQ3
	6cuMWxRELJtWBV3VJf8dCZEP1Q+ieL48r8j4NPmVZu2rA2OreaULMMZEFDIHoaiy
	7t7X3sr8BTsy05FvoSRxmSZPgiDmxNP4u16rAL2to4HTuu1HaxWufV5iINHLF/l5
	gy6FRwMOsiexfTg0FoDTY4LlnD060XZSD9yfxE5VfoOSc0ofcYFfeNX4akH4I2NG
	e7wzq2C/tM+zV31e6E9XzBbHueueFaIR8tJ5u1d8jo20ijkqVzhfJqdVlUTNg4La
	eEInSW1c6NfMGpJ3dAfTK/SBJVhAqm4ij6A==
X-ME-Sender: <xms:CFo4ajO0PU9VFa-Dqw0EWWwJjpizP77RKfG5gOc8BvicybOCjnbz_g>
    <xme:CFo4ak9MXumTT7M8XKQVPnkUBWk-5R83jPNa1Z3D3Ji_knXwQDebXjgJCfVsL5kxW
    igCHgAiqlxqAuumpIHVwLKvDHjswL7OE7_AAuCt_dWd3-ho3v9Zug>
X-ME-Received: <xmr:CFo4anSFc16rc1k0eEZ0RMxXoKuKVp6t4dFuTlsDQ6Y5YLLV-KWjHCEdNvr-x2BFIIEQMAcmeAEu5cjs3gFzjtScRTCCGwRkIzfX6io>
X-ME-Proxy-Cause: dmFkZTEVPxDH0R5vJuZ65mCThN1OxS99tKl8YffOkBue9PHoMQnWaNnPJIG78iEK/2m67J
    2I7+MBD6wOnwhUpusZ7anXjV0IyYQCbGI1/3JHUVPcqAk4zHEQhiYtcQwOzDD/K9Hznshb
    25NH4aXV0QA/W4wURKxn6Ho4m5LY0c3dxxfizgdNsTmjRWLINNhfYI+QJvvEMeNrZvxsNI
    kiNLNqA10YYNF69Lb5DKgGfi7ocHlnW2BnKhZBj1JIBPGZzC86uGG+zuSctII7w+PUoGdL
    nFm/Glx2YESmIqggL3TIgmzyoCXKZCOGy4UCKKiqnRTa86t7y+tjuaL6o9XXtVWnVmO3p0
    qgJH/6NJ+Q3TXN7AEbTPQA5KPbdRAyo+YBfF6p2xOZ94JNCYX2+H99lQx16Qcqm2lM5CTJ
    zGGlk0dtEVx4R2oGOzpeYcKlsJJWv6Ja86jiKpu+Tqqiu9A3m10S7/mdDj3pE72R3tirWx
    alvg3viRLYxUzOs057tk9WVkLE3n0NUT+Ki3hWObiW4iCNlajiBWNq8SJW6srPP9BCYveX
    OQP8z/zD/MF1BHYG7LUdN7r/lJXgcfsdtzsNOL1Uxzowe2HbUtT4EN3ouANUWWKEifgUFA
    tPFXg2Zksdhhu9EsCHJ02YvZYQYhc5ObACZ4GOYTFeSsHcXqN7KIorniP48g
X-ME-Proxy: <xmx:CFo4amkYJnnloKELQfvQvIw4qXbepIyH8t4svW8pC8MWYe8qvZNgqQ>
    <xmx:CFo4anTwMwt-8NA6ijUMRDpT8klG8UORRBkvO4LomGdkwldcl-o_fw>
    <xmx:CFo4akPnqwBriOwweb4518-ThJ62svc41J7G6Q4XOxvWsL-h-15Jgw>
    <xmx:CFo4agW9po4D10_ZSbAhZ7g8hKjA4ODNjL1Z-jdiT2RdqrV0_jbBUA>
    <xmx:CFo4ajNg5h_u1701vzOwDsta4U7CJgqvAiwzAG0aur-tCumpAPxQPgA6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 17:39:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
In-Reply-To: <20260621174518.GB2206349@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 Jun 2026 13:45:18 -0400")
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
	<20260609001134.GD358144@coredump.intra.peff.net>
	<CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
	<20260611085526.GL2191159@coredump.intra.peff.net>
	<CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
	<xmqqa4sog1e9.fsf@gitster.g>
	<20260621172432.GA2206349@coredump.intra.peff.net>
	<20260621174518.GB2206349@coredump.intra.peff.net>
Date: Sun, 21 Jun 2026 14:39:18 -0700
Message-ID: <xmqqechz60ah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> BTW, I don't think diffcore actually has the information it would need
> to do so. The racy stuff is handled under the hood in ie_match_stat(),
> which returns only a set of "changed" flags. So the caller cannot tell
> the difference between the two cases:
>
>   1. We checked ce_match_stat_basic() which said "no change", and then
>      is_racy_timestamp() was false, so that was good enough.
>
>   2. is_racy_timestamp() is true, so we further did a content check,
>      found nothing, and returned the same "no change"
>
> Obviously we could pass back another flag, but that would disrupt the
> other callers. Hmm. It looks like we could pass in a flag to say "assume
> racy entries are modified". And then they come back to the diff code,
> diffcore_skip_stat_unmatch() sees they're not real diffs and suppresses
> them, but we _do_ count them as stat-dirty.

Yeah.  Because ie_match_stat() does have access to istate, we could
add a new member to istate, next to "updated_workdir" and friends,
and smudge the bit when the is_racy_timestamp() goes to the
compare-data codepath and finds that we are better off auto
refreshing.  Then "were we told to do skip-stat-unmatch and actually
found some that is worth refreshing?" code can be taught to pay
attention to that bit as well.

This is a tangent, but why do we call refresh_index_quietly() in the
central code path in cmd_diff() in the first place, I have to
wonder?  It should not matter when we are comparing two tree objects
(or two commits), at least.  It of course is not hurting, though.
