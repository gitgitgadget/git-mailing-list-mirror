Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CC42AA3
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851411; cv=none; b=UwShuhdEir6eGOcsgmQj3Od+AGg2S43nMjmftp+eHF6CrAL+JqbluXXEG2OII09moKjjUha9OUtdluzG26hYnCypH/5cpokUErWL2OKPxkeRzqAVCN2HKWJIOaszkeI+BeTyXU2locFlHAL5jDMDDsAo05mIrti067ilkDmPTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851411; c=relaxed/simple;
	bh=U0u3KceIBlBtIMoZSxaM4BHktG5q0g4Rsf7xyxvUEMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ID57sNwUnIhj2q8ciOwDt7BJNH4eL0sxhDsp9gjWC/Zf4pMO5G7fXkihhI8c9bdc5D2o7FHopbgziaA/IehHbOmms/T5LLcVpbxLZzDLP2ix0HcQtVWhbn53lm8VHb1ZbzD4nqVaLdJKEMbbbji7YdpWUIQ6ivELRse/yurTXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A4uGN6oZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ff7ee8sA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A4uGN6oZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ff7ee8sA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2012E7A0220;
	Tue,  7 Oct 2025 11:36:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Oct 2025 11:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759851407; x=1759937807; bh=vxA0m0D/uP
	ZLZ+mgIq33LkbRVg3qgNR+se2DJ0lz68s=; b=A4uGN6oZq0acVSN3EgWffVCZvY
	9xjCA2oW+qNCnNoOQAmkiIQiLfYxcj088vPyO0uPt0OHRg+lZd74jePN0w9uIWNa
	bE04MtRMRyTX3woFH2BsSspauC1pmulVAp656DUZSoDMdyo02a95xmT1uYSz1N10
	NEJZtY+GHR+NtsDE5wtyFDFfsht2OCce2SbkeY/rLLj5EMapjiPLz3esjuIj4ddc
	qbNVSYRZDeZZEESe96SknsKp85QlyMxXN58fdZWsEgV2HfwQ7C9B8ZC3Mxd9XKod
	P7cITap/8euUuxosjsrxH0ifyAtGYjBObLUocFodkl2JBdkaYC+Fcr+eUS1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759851407; x=1759937807; bh=vxA0m0D/uPZLZ+mgIq33LkbRVg3qgNR+se2
	DJ0lz68s=; b=ff7ee8sAOHtM5HB6yRgVIDYCm8Rw/vRqVru4+yOfrKISKWCLJTh
	iwwDKjJdpYTI6gclCqQcQIU136nA1IivgG6w6g6drknMt+6aTB3XWUkmBMIFjklV
	Tjt9r252dfF7r2oTUk0nPbEVmF+wfDPctV/iCe/SflEgaVAalb/QRtOBLjoQzswT
	URFwpjjQCzP04mb5wwEBB7/iMToMnhVKrAj3Y6799G241HwkA73ynzuIfyLMpEro
	TPKt4m6p1GE1A5dEPRdS+Fzwj3UqBZyxvnKgYy8gPVdqL5be8JLi+UFsrPHdIxEe
	oewp3XZt20NrTft19d/WSDJHuAfAxzQzhCA==
X-ME-Sender: <xms:jzPlaCIspBNPrZOklww4zffG5SrFP0JZ-0JtJgpEJgOuz_RtJYuf7Q>
    <xme:jzPlaF_BFsVDf3yyzPe90FPi1RKPcTdcEIIPNFzvw5Tlq9BDGLUZ42FK7nNitCLVo
    qExTBoHqmTWozmXMsI6pxcHR1zmS0EhscLTOdZtFsILeNN73Mox>
X-ME-Received: <xmr:jzPlaOHoUMrSWya-HU8lPxslXzhrjTVaPUQD3qK856uuGKiCp5q3UEZxVAUxljBGrXuOa6GmZ4dq7ceNv04g22yjJczq9lT7_Pc3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:jzPlaA6Lx9VTGI5XNYTWanSZuyyVWBa8NGKMUadiBw3GW4cCOxsqxA>
    <xmx:jzPlaHZfV-g4fOtzp5i8QpwXr9xY8ASeuKqMkqZmC_viKsY2eY5qbw>
    <xmx:jzPlaOh6vuyj0MxtR7AEPD4SDYKJhHqH8GHzg0UlUWrHAMs3ox-GPQ>
    <xmx:jzPlaJfS_zYKHTrvxUug7JfZKq32a3uAjJPjN_AHqKrsTP2z2HWxwg>
    <xmx:jzPlaLHdA957CFAV0GpC-6x29KdyQBBaFJijbP-Tccseocfh_0ThTXRw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 11:36:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <87frbv3qyr.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	07 Oct 2025 14:13:00 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<xmqqo6qkq9vm.fsf@gitster.g> <87frbv3qyr.fsf@collabora.com>
Date: Tue, 07 Oct 2025 08:36:45 -0700
Message-ID: <xmqq5xcqn2pe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Currently any existing submodule gitdir names are left untouched 
> and are used as-is (unencoded) after the extension is enabled.

And in order to make sure that a funny names and paths in existing
submodules that can be misinterpreted as encoded would be registered
with the new submodule.<name>.gitdirpath variable?

That would be a robust way to transition.  It also means that you
have a mapping from submodule name to path, and you will have to
make an effort to maintain that mapping and the reality on the
filesystem in sync.

So why not take advantage of the fact that you are making that
effort anyway?  It can simplify things quite a bit.  Imagine what
would happen if we did this:

 - You officially declare that submodule.<name>.gitdirpath is _the_
   mapping mechanism, not a mere "override".

 - When enabling the extension, you register all submodules that
   already has their gitdirs on the filesystem to the mapping
   mechanism under their "historical and natural" names.

 - When you add a new submodule, you "munge" its name to be used as
   a subdirectory name under .git/modules/.  You only specify for
   the end users the purpose and nature of this munging, perhaps
   like

   - (purpose) We give each submodule a place in .git/modules
     directory of the superproject to store its repository data, but
     the names of submodules we find in .gitmodules may not
     necessarily be friendly to the filesystem (e.g., "CON:", or
     longer than the filesystem allows for a single path component),
     or may introduce a subdirectory (e.g., slashes and
     backslashes), or two directories whose names only differ in
     case may not coexist on your filesystem.  That is why we do not
     use the name found in .gitmodules as-is.

   - (nature) This "munging" would remove problematic bytes or
     replace them with safe ones in the name, or truncate overly
     long string, or insert sequence numbers to make the result
     unique and representable on the filesystem.  Hopefully the
     result of the munging may still be recognisable as derived from
     the original name, but it is *not* designed to be reversible by
     itself.  The submodule.<name>.gitdirpath is the only and
     authoritative place to learn how <name> got munged to produce a
     path.

   without having to go into the details to avoid tempting users to
   write scripts that guess and decode bypassing the mapping.

Hmm?
