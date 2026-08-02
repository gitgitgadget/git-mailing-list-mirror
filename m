Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF719EED3
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687857; cv=none; b=PqQdmQ1ofNyVTCN400xeP41qq7+99tZEq4xnA5iu2IcsN/OwSnGhH/dZZ4Eb0hzaiay2CQNqGikKKqi28oqc40bit10dykHIgCi+V7KHNY9wQv7zWf5w4dhEGNjOCQZCI72wlpqRGonRQsetz/yuff6GL/ksJX5lFqFFENR3EAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687857; c=relaxed/simple;
	bh=aIzKCLwcYL70sFT8VORhPLYfY9wbu5KJGb1YQtQe8LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1wHWyU1QJky6OOyMGo9y5UKMGJVhO4e2GvUS7+3IyRfDzBa8M2sLyaUzHPMFinKgqBuSr1nMJfNfHg5+bz3j1FCjhy7TNNRnlv7aIBDaJJYWLun9gMImKvJRW0qtNyJIW+8JyTa2862dxJDUtmMnelyNH1GW6rSBhLlmx1+WWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HuoqidUF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3QDLf/f; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HuoqidUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3QDLf/f"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E1671D000BF;
	Sun,  2 Aug 2026 12:24:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 02 Aug 2026 12:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785687854; x=1785774254; bh=5mmHRAmnwz
	74Ax0ppVsB/J5zHkT11h/DQxRhYxFcMAw=; b=HuoqidUFoHrcNP35OfrlcmPSdp
	JND5dkDLBKkh/9cANVxcXGKaz1YcghMPf4vlXWkYXAZeHBCOad73wO/nvQ6p1wp2
	DNDnjNpGuUg08Kyq0MuifxVdZ5DRKB9GN0bElQiosc04pGxZqGPs+UxN3vXWs19Q
	q0z+vygl4P7SV+FNf+sHoGm/8RxnAFs3Pc9JXCLqBD6tOPsxU511sqInll80CAgP
	pTDPmj9+3y6Z8RweLdzbgqz5w3p94ITXzrzgR8Tot7Liz1uV09MBiq8IT5MFBaQn
	3FcpKRqF0qoz5fYrodOFspGVeSqOAda3EHwoaoWAUCbpyeFEC6O5l5yWO66w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785687854; x=1785774254; bh=5mmHRAmnwz74Ax0ppVsB/J5zHkT11h/DQxR
	hYxFcMAw=; b=S3QDLf/fHRVfbZS1Punnwjtbpvior37G8NPDyXvcgohS6MF+NuI
	/jbqYFWcL6PrZps9DEq6ROTLRrqqlMZU8Z7Rhkh9TxP/RyqP1LBOJ3mNixqlxeKs
	FyaDpDwj989WpKByDr/1LMM0EfXhovfN+22iOOhJwVOjxgbZqvLpYH3LWF1rAW6X
	kcDVZL2VLrQAfPRDTVSvbz84euRG5wxSgwFgRdce4dVCZ9xUOyFM8btDOAgVIYqW
	xkp33EJA2uSY3s68kz0PoICrW2UfWZw1kgwzWBZWQ2Z1of+CvW7+Js0Vbpz9tRFU
	SXLCq5G7KmNV5TOrmcpcQn00gQRPZFOULUw==
X-ME-Sender: <xms:Lm9vavVz07QxcMfnnyZgtovDIEvIf8Q8gyvXT8ZBmcKj-PFk_u5Irw>
    <xme:Lm9varS-g0tQAuzsCJaDvvggb-994Vs9cwMQZefqMssg7VwhdZBAxhFhjcKeXocJ2
    lu_Rxi9_0VYx-SbD3EaVLxwsU5GLxzN3rqrpameL8GBDi85qgBflg>
X-ME-Received: <xmr:Lm9valNFIbPguzRJkkS1_csOdfSXZbS5vz8yH2knt0PlyGJ1BqEnLv6yK2DvjjIkEc0M55poHEZUrhfFtfffc6d0rW-LEtkfqg>
X-ME-Proxy-Cause: dmFkZTFN1II2kP1pqAGJwkFBIKrO7IW6PmKgAN8phtLgdFwUTR8Wf0KNOaNhTDQpTAcSm6
    DZXef9UanufsBKmUTX/DylURCgz285JsqQpMdAlbBwFtZ5khOEN+0+uFqgeVFu+kl6LSV/
    yvlgYvrRqc+JnszMDBaw7xDTzInVmrp72xW0iZzGhUdCBKQabFPj9DRoF2vBcBsCIyehhu
    e45CwRUOzXpitaXS3+E7BGkzCevIdKHXY6lyASrB+BoaoLWwill/qbD/pD+wDkgnYfY2rb
    vxSEPeYLeQfMmcyVjO14Ys2/QDnC1w2BUW/4q0Q0sK4TDL8ae9mO0HZ6I76ByA0roxwJKF
    3FMUpNdpuJpl1vUgznDpK7ODdYLPRne/dlH0MtyVB/1wr7FOA/GwYffTCGMktfYT3NAC7R
    CKwaz05vFz2V0+qHRLlbl9WdTbvTI1Wpz67LsLRkgyhi+TpR0Dqzj3j2sE1J0iiz7xsfA+
    4yXsAz59VGsv7rAeAghP3nFk70Wam3ECqKI/MFsTF+TVDYhsT2tXSlEFCZ51vls6tGrMnw
    sBeEw0MW+MqKiTAJMjPLX/LunM5EnxPtOeq3Fo/fhFkZittjDlJQGFTjsuGdpTK/4ZSusr
    0KHtDAQ0DBfHhyPF62jCzaqKF9EBUlfOLiDFPQ/F4mzYwMJixlzJoPU1hdwg
X-ME-Proxy: <xmx:Lm9vahSG5O-ouY826Wu4jZZJYRh9qOLD8V_hdX3hWchIfG-bvac3JQ>
    <xmx:Lm9varjdqM01BLoDrMIGkTksJjajMA8CF4kvBMYcqX9efuI6TixgDQ>
    <xmx:Lm9vai_W6cw3Z6sgFvAdTfA6x5uWt0jHkEGZourtuyaPO0OHV2OO-g>
    <xmx:Lm9vaqHiWpm-GwElheg0BFy_Mf4BaTM5rYt0baWfx3CfmUYV2IR6Wg>
    <xmx:Lm9vaoIrO6i9lCSoYwQoli_KaN7KSsHJ30YMaH0jw72ylBMO35twos8I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 12:24:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: "Jeff King" <peff@peff.net>,  <git@vger.kernel.org>,
  <chandrapratap3519@gmail.com>,  <karthik.188@gmail.com>
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
In-Reply-To: <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com> (Pablo Sabater's message of
	"Sun, 02 Aug 2026 14:33:49 +0200")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
	<xmqq7bmaa0sw.fsf@gitster.g> <xmqqzez67yg1.fsf@gitster.g>
	<DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
	<20260801231437.GA2097059@coredump.intra.peff.net>
	<20260801232941.GA2097163@coredump.intra.peff.net>
	<xmqqpl015lfl.fsf@gitster.g> <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com>
Date: Sun, 02 Aug 2026 09:24:13 -0700
Message-ID: <xmqqcxw04hjm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> What I understood is that fetch_object_info shouldn't use object_info to
> store the results, because it doesn't call read_object_info() like other
> commands like 'info' do. Then, it should use its own data structure to
> hold the results with flags like wants_size and wants_type. Something
> like:
>
> 	struct object_info_results {
> 		enum object_type *types;
> 		size_t *sizes;
> 		unsigned *unrecognized;
> 		size_t nr;
> 		unsigned wants_size:1;
> 		unsigned wants_type:1;
> 	};

I would have expected this to be an array of struct, i.e.

	struct {
		struct oid *oid;
		enum object_type type;
		size_t size;
	} *result;
	size_t result_nr, result_alloc;

if you do not have the number of things you query upfront, or it may
be an array of fixed size (i.e. no nr/alloc, just nr).

If you'll be making the same query for many different objects, you
know if you are asking for type for all of them or for none of them,
so depending on how the caller uses it, you may not need the valid
bit.  Or type==OBJ_NONE could signal "we have no info".
	
And you'd be using the second pattern I outlined, i.e.

	for (size_t it = 0; it < result_nr; it++) {
        	/*
		 * you may selectively populate the oi to signal
		 * you do not need some values, but you get the
        	 * idea.
		 */
		struct object_info oi = {
			type_p = &result[it].type,
			size_p = &result[it].size,
			...
		};
		... ask about result[it].oid using &oi ...
	}

to populate the result[] array with values, I would imagine.
