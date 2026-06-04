Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D138199D8
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533194; cv=none; b=fNFhtq5dk6YfiHcM3qxFZ7ImdMoygZLTF+H+Rzu26JFWrLnNz4BceJxjUKWjtzVVQL7UGLwVtIoHx+VUI8DbPUH6l7yXw5AcHEtr+YqrYeg1G9AUj3qqMWUUeSP0F6DdUm/mhGR6DX/SUgY7n/gSGyMKM//tZDnRqSBPULRXVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533194; c=relaxed/simple;
	bh=KjO0ui/mhNuboj69CbSM4jnIru3Xj1DYN4xl/hDzkwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vo628PjltnYrYnwJWL7HHr6RTe1jLvFiprriKq3OcGoIPMK7Fob1cxw9HwK8dG2SneYeSvk4jyAfT16RZxv5terVc6XuRJTN+K+DgYlU/ghwjytc+rlTOGC+mxwq7otnaLQ5t2Nb3O/okMGYXpiRHIe36LfKQGoZTPMeN3+xkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VujjwKwl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mn08x7u8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VujjwKwl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mn08x7u8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4585614000E0;
	Wed,  3 Jun 2026 20:33:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 20:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780533192; x=1780619592; bh=Hwaz/6vQyA
	9UFpTT2Mr2jplLPJVgs0j/1NQC06YMUTw=; b=VujjwKwl+/EA7FY471r1lR3aQe
	qe2H9X0N0HAnW6cC6i4sXawaIvC4ZprprWEIvzjOxmzzyfMO14I9Svhcu0kRQ1xk
	2ce0oyjjsbRxWfNOwCdeemcfhJv3Zp4KYEfYbwNZAWnPXKupEYI9tJxUbrV4SSDx
	cRmtS+nE/wvuqGgoknpX8eHRTjhuamd6ZXypJWPfpoeOLqCN0iI0sHv88Gx0S1o3
	fl6bVQFCxM7YUZUzICHL6pX5ojrjq7ZbiiWgJdxpAUJEDZk271tD/4PrPWQAJPxb
	N+rKtcCm3UmBANEp+QnlUkwVoGl9g6ZNH/QkJ7iBYBO55gBoO5NxfN3EdLVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780533192; x=1780619592; bh=Hwaz/6vQyA9UFpTT2Mr2jplLPJVgs0j/1NQ
	C06YMUTw=; b=Mn08x7u85Q8Xu02EOlzFY7ArCd0OFmsTR17pJXN79bPHla8GPTB
	l0yQ4CDR3CLzY+y2n2gaI4TAcdpidPkjk9hUHIiR7XU1S5LT+koO7gzh9Xb8a6Mc
	9YeS6YQ92zBCKI17ckKyfbNWmPljn2N5tM1JEO0ZF6MHsYMI75dRG42V6OZLIoxY
	pyERHvbUifRbarLtMoPTZd1InDsvznwI08dflJMeXjV4uZ2jBu39yYOh2R++1l1Y
	T6XHzslpAJPV+EKk8MytR5lERHM9qkoo6m7DXL5mVvj83R/p+JWaUW0r5Wu3dm15
	XUZCTFM4EKStMkWFv0owVuNFDXBC2dabamQ==
X-ME-Sender: <xms:yMcgaqLw8FlMbkQ22o3WaT-_o266ZtZO2h0RVML4o35_KN6OG3RDpw>
    <xme:yMcgapLBTnhRY7lRVXviKkEXk-EwUUIpuNT_7WsDu-sMsvrElfMSOC3CRfoQTipLz
    diN9LPpX8AdZ13MpBCSByyPK7vRMTzTtvG4sCA50i4Jl25G4v9YiQ>
X-ME-Received: <xmr:yMcgavuk83cZGQRxDC5WBV5aAiJjdT5j2o4lF_s7eUh9wvk5683tGez41tZZn6HibWaU3qnNnfJ9pfHsKyv8Gk6-qXuN5ArUhFt0>
X-ME-Proxy-Cause: dmFkZTG2GYVr1S5+bgfDTB3bSJjiJyPMEwAj9qLTEpwhX7/MmrnrMqRjWkSPtkKdBMzyi4
    vNqRKTDbvlIjS3Patgjsi5KIVsWAymWElUqptpHary6FesLQ9/Uc4EA2EcZ5AjVxT1BWGT
    UBKMUV7CNcmRrkMtIQOA+/xvucWah2sx6XdOKvmYt1MGnd3cfjQq3ZA7M1eN2Vc58Cs+PA
    oFyG6af46s5hiW7P0GSUT6U4oMH/zjuxtYVAL0waP36J525pYABobInjdtyqx0+oilgiHJ
    GYjSMxrEXL0ptu+sTQl8yzLRrEblHIIXMFKfPfHURo4Bis6h6sexckKgb6/9d4kIniujNC
    AhJH34kwWgIo/t4ojGWpkyCJaibp+m8mFYkZZ3PE4U9eIlPwefq35rnHm1hK0e6gFU5IIG
    jKGR+pmdymS4D12bLCIjyZOKTLXKlbNFo7SoU6ExQ3csz59oJAKis68E6O8jMsZHfrKDUH
    tcEmf3xFW+LjOHw1we33vrIRYvw7nzQ7NJuGdYxxPaBUvkZ0MSy1VGiX/DFTJUUc/uQQ11
    20dysvKCCSEFP3cxFBipNsinnuB7imydmXGTckq+BnfPW6XhnsL2GE5kBCvrbqSnOQ5pz/
    /uji5tkUfgA8OUR6PcP3DCEG6ov/YdoNVsK/WoAe3BrwBelaa9t+9CW9ev5A
X-ME-Proxy: <xmx:yMcgauTOepMMxGZRfYbpQ55jkmZo3odg_qmukslBlRUM5ZareUq37Q>
    <xmx:yMcgatMknEBXXI7QLCcxq80x2lN92zXvUjnttSXIORRkl_QqGO6qWA>
    <xmx:yMcgaraNqwYW0PNrh2nRDrz7O3CcE9QOmiSpu-hIhGDg8kdvw-qIYQ>
    <xmx:yMcgavztD_im3jn8nzmWv0cRiADxjwLAQvqLtJG82nWlPoX_CO-RlQ>
    <xmx:yMcgaq4BaLi9Vjj-lFfA6bHnzsixuYfSwPgmLElSTdwHSqV-uciHWY-n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 20:33:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] Makefile: drop duplicate %.a from link recipes
In-Reply-To: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 31 May 2026 23:16:46
	+0000")
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 09:33:10 +0900
Message-ID: <xmqqik7zqh4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)

I think the reason why the pattern to use only the .o files among
the prerequisites and then use only the .a files among the same
prerequisites (both filters $^) is used here is to make sure that the
linker sees object files first before library archives, so that by
the time its left-to-right scan sees the first library archive, all
the missing symbols in the object files are known.  The above change
depends on LIBS being a strict superset of all the library archive
files ($GITLIBS in the current code, but that can be updated in the
future) listed as prerequisites for the rule, but there is nothing to
guarantee that, so it looks brittle.

Exact same comment applies to the other two rules touched by this patch.

