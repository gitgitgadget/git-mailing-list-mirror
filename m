Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039015304AD
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169710; cv=none; b=PWkm4ah1fzlAK8j4o+honH0QIZrHiBbD3kv6KhiARE6qMI93bnWFINrpp64jBXpJRsGnfaYcirSMXO17oWLwTBfqJPI89z0dWV5aklCu1n6CpJ2PoEVAwDjqXjK+AHQ5l6ljlMptI+S1U2lMbS0vgg5kXpTRBtIOblwhmDJOd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169710; c=relaxed/simple;
	bh=gUniX/Ir11qi8mBTdNrnqTeA8p+cb4GNEntgISPEzyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mlB05HNGE4wguJJ6YRUWuAjr2rb9Ag4gO/4EqrbRLTgm0UcuJfZcM3nS9rYcHDzgMnwkWPXcUOt/2BFsOujsUjKlmL5feIvuViKCb+6z6nWR5p9fKcpLlc18yhVEGPjs64R8vUlhMPEZkPIonKL8f+LzJvd7q49x0SiFXasOLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TYtg7rF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iQY3b5X0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TYtg7rF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iQY3b5X0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 285B814000FC
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 12:55:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 16 Oct 2026 12:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792169707; x=1792256107; bh=xzlfnZ2qXA
	p7wvCw5oFauBJFKEsK00cfIJ59jsxTG8k=; b=TYtg7rF1sDQqUyZHbjz8UJuPRe
	evJc2RLwEC5E/ItVdx5DRgUSfIv2RKw7UYfHqtr861TMpjaVwE0eVDToRqhDyPYQ
	+lx/Bnk7+ZJwrIF+o1EOFWeVSs/cLOgVbYTmFKi+XecVthSt0Qj49OabqdjHpyGN
	dM4dpdGOY56a7TG6KVE5X7jmTErBG9KMjYcUp2pomNGECogzx/DFP3ENrGk6QEyR
	jsaHmEqkQ4iIiYA1Mun0HOlrBhYESFB7fQIWhU+LwIubtbPnJr9YnK8p/SxEutmS
	65gGVqKMuMoMz+6o+dGSDgBT8ojFm/SKDv3ZQFUdTw8sstnFLvg+3v6cpHPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792169707; x=1792256107; bh=xzlfnZ2qXAp7wvCw5oFauBJFKEsK00cfIJ5
	9jsxTG8k=; b=iQY3b5X0yT3Jw+uwLoOhozRw/IC9TNvxp+86WuOoG31lgaRd7Hn
	J0DVRm0FtCSTEgXmD0rgZAT7FTp/8phCcNSfq/KiXP2nL1sibyGIhYWp9yZcwLUQ
	o/iXbQ89rn7+yaOcs9rmMl8h+V1DlGi7DWRa5CxfveSXsv5U25uc49Jj2I2UFvtN
	mH2CywbFr57mDoEASFUpHucbuuJNlEB9Y0yjbrdlbS9r4TGd3AdoOe/XYBjMj+4k
	DZgCfeDvGW3Kli6V7CsFY+RYh4yH6I2frO8m9sIe0rr2tEnn1hAJDxba8D4Zxls0
	ZHYopzt2kR2oeGOAq9uF+N1wj4PNWNANxWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792169707; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YbjeL15g2PJlw4k75Brta6C2JdDe4tcx6Qmt9ou6aiRsIMj
	dzBFhOROw7YmSdx732AuK99X7lX1aUA7zfe7AUQhi0hTDI8LvS5ZvAPJXAYN2GKm
	KwXDjrYD2fbxfO8pczE5khxrJJCZOWiX3g1l1RwEBSfbeSGh9KwqXkjxFnyq5oco
	Uq604I3N+xch9dYF2OE35njq/wdHi99e/CXA9cviUlRLqjmLw3XkmfDd5uxMktQ7
	6WDZFY6KruBSodoAUrJ1vF8MgCgb2GoPB5HvgfMet+QqfSjQuXhwyRSkBCsZfiK4
	lqIJv8zJrn7rvGMZWbk6Rafo4fCU/JRT48knX1g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ryuHpgsqiYyv1LD65lqOJku7gTME1YnqMlaJpKbx964=:gUniX/Ir11qi8mBTdNrnqTeA8p+cb4GNEntgISPEzyA=;
X-ME-Sender: <xms:61bSamX2n2iiIUFl6Ub_N6R9vM5HX2Zi8lnx8WbKXkVQhWaaHFppVw>
    <xme:61bSapeNwxk5DaC0fUAZV7JeB5EbwjD3pSEpTiChQkmYYFzl6vxbyL9PYowgJRvaB
    tjsBkrQJfjBfh2zG-y1BOyhuvUQgh93x1v0z6VJchfqjIXEKHej5Eb3>
X-ME-Received: <xmr:61bSaiuGv8WfJ9pGFE9SWb8zaTR6be_qO4GFz1c51-6k8Nk5dyjMFoIva9Kn-o4Z7_gqIAbwntb0bd57-1lsO4FeGzWhqi94gbN2>
X-ME-Proxy-Cause: dmFkZTEsonrPpcRdPqXvbbSJmUx0rFAE9rGP+zfUuGklUSOmX9nbXS57LHC+OILSfMr+rm
    j47AcaHz5Bw9mzjf9n6UUcriikHLMIwjGwECsnHmjHEJ+w2GLBOLgBO6uvJQTxosqQr+im
    +kCUt7Nx6dM8iH+gDLR8nZsZ2Wtp2SzTPfA/5l+P2oFQX2YFXrCuZXBzDZKfKKsvRMD9tl
    ZwyaarRzGK18THBu+9cxgQAkcUTC/u3x/PJrfWBWiwsqR5sxebaapv03e0mEIhMy1wpkES
    /gcgIEY73YbfIW11XYty9mScCEJhQsswLHeKGcvFx8Zj+3Ps8EaydqHG2Nn3LTIEtgNDE4
    tSryox/RZGtEVFr7+PBdgx11sPFE/QQKp/pqQf70OntC5A5q7+TR3vepBAm6juOFC3GrXo
    OjP3dqUhs9OTAHawA2qax4lNrukr4oxnBx4UfieO/2CWqIY8PkGHsdfSUXWdedF1oP3W4q
    zgcrcW7XgWvFeL/LGD9OQdMpMT7coid2mLhnWF00wfP5NKnZAVhc9rWbt+VfNLVJND7opE
    R2yw7r+wOXJsSPC14qyeZ4M/klz1uxcsvUPFaGcfFQ5Dw0tujMWMUUzVi5a1mLrPJb3pYa
    VElHnY4ZIBOn9ME6nv8rTBdGRnSFrVdu1SsDAjF9UCWTAO93alXYkwP3c3ug
X-ME-Proxy: <xmx:61bSao_sW8QN9iYIOxSb1tRcAkMi3kWbUpwIbGQtAO_N_pGeApq9hg>
    <xmx:61bSat3vlXzoFY9dR1L1tKCbS3OcpEDsvsmBXDmY_LWFy95gL5wpFQ>
    <xmx:61bSatAIEIvBWqZTBLDKbRQA5jmtNuk5fh2q3KQs4SWLIeakkhq1wg>
    <xmx:61bSapfot3NSFYRJo7jOppkuFGrB7rUq7UHakcU7UPQE-bXWKT23vA>
    <xmx:61bSamtq6TZy-_-aHgPZmNp2Pp2Tq5Maekkz4M4B0VzKajNu67UTFISx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 12:55:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
    Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] branch: let inherit track a remote-tracking start point
In-Reply-To: <pull.2450.git.git.1792134165785.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 16 Oct 2026 07:02:45
	+0000")
References: <pull.2450.git.git.1792134165785.gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 09:55:05 -0700
Message-ID: <xmqqcxt9h9g6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  `inherit`;; if the starting point has a tracking configuration, it is copied to the new
> -	branch
> +	branch. A remote-tracking starting point is tracked directly, as with `true`.

That is "A remote-tracking branch given as a starting point", not "A
remote-tracking starting point".  Don't abbreviate and drop "branch".

If a starting point is not a remote-tracking branch, shouldn't the
same thing happen, by the way?  IOW, shouldn't the updated text and
behaviour be more like

	`inherit`;; if the starting point has a tracking
	configuration, it is copied to the new branch.  Otherwise,
	the new branch is set to track the starting point itself.

I am not sure if it is the users of `inherit` want that forking a
new branch from something that they know is *not* tracking anything
suddenly starts to track the starting point (whether it is a
remote-tracking branch or something else).

Looking at the originating commit d3115660b4 (branch: add flags and
config to inherit tracking, 2021-12-20), it only talks about what
they want to do when the starting point does track something, and
forgets to say what they want when it does not track anything (the
author CC'ed in case he retains the memory of the motivation from 5
years ago), but if you ask me _now_, not doing anything, i.e., the
behaviour the old commit happened to have implemented without
explanation does sound like the right thing to do.

What we should do if this change of behaviour turns out to be
undesirable?

Perhaps `inherit` should gain a synonym `inherit-or-ignore` for
those who prefer the current behaviour, and we want two extra
behaviours, `inherit-or-fail` that complains and dies if the
specified starting point does not have anything for the new branch
to inherit, and `inherit-or-direct` that uses the fallback
definition, or something?
