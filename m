Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207627877F
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204085; cv=none; b=Gr6Wga/daW6y+wGUnCuj0+by/LDME1EI+CsaAaWlX6sXCJN14EB98uKMpOW85TCNyr/spfAg+IgysxF2cYxxYqnukxW+exHAs/oGAbQkih77ki5XSXTvqp4x/EfYzXP07iV+c8ssYGqwU+ZB4ezFCpsWbuPGyr5r2yGLBdE5N0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204085; c=relaxed/simple;
	bh=xWH9Bw0tWx1kBBsE06ePSl/5qZmGPl1W5HgfcwXxuTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2vb4jOyo1VaPwYv6rHzmQC2noi7fnt0Gx8Bcu4jlhBFmNs+MPTP6K3+geHekROeiM7z0mLoWoaDJRLQxekkQnOdbRoOyUDKV8SFuwPjJE8RIPJz8MmO0irOld1ogWxgLe+aCPaEsiHepVIZIL+lI4ne7z1YDBOyCDoQgj9LT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WaEzTGTa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpzzPXpz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WaEzTGTa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpzzPXpz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 791951400377;
	Tue, 22 Jul 2025 13:08:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 13:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753204082; x=1753290482; bh=8jjI2oSfrM
	HN+kyCTgoDaPu8ih1si3wIR4Z97daOGoQ=; b=WaEzTGTaHJIe5Dc2ynrCr+CL/w
	UIKFqMRLGujmqOOHF3w980i/I0LbSgO2FbSGH1QjnS662QeGFSj/SjACll5D1KMP
	+Ccd+xnpL7DKjYVehfn7L4Gj2w+veWKYOkIZT5zu5iVlfUV351Twgp1uWJM+ObVN
	oAmFEo9Vut28jpEiJmAs4EBSP+tIpCeFpi79kZLKJuN85ezzUPXO5vv/pSl6x+0C
	xB0IGGbncznNSHoHQuMqQssU/XDm9n2tu3s9Ifh/v5h34Uni/ghiC97lJXKeGqrq
	FlzmI4KkrXj+SPN0lMPM+gkpy2i6AaS9D/l5PKZx1Ces3G2BwJKv+E7pQOeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753204082; x=1753290482; bh=8jjI2oSfrMHN+kyCTgoDaPu8ih1si3wIR4Z
	97daOGoQ=; b=BpzzPXpzmUxZxry8h5Bo8ui6y7Plzj38Qfydg0Wt9Bil4slJakn
	xRiuUUO2DlnFI8BfRzWqAUsTCcq92XQM9TygVpXO2CXUkoN66tplXVT8X1lDEofP
	7VdEKgwO+2AJX+nZKGrCpUecUKh67Uki8E6WehfVCFYX9n3E/5mMaXnALPBtS7am
	5kuH2yoLipn/2NBzwzTmsYeFX9mntBMaBTQfZ0yAtC4OmYs9SkburIWntccFeRAb
	/ge/QwgetO1w/P5gBIRo40vo0QsHzL5xsnk/meA6LNnIiJrieInabcPgj46L+Xgr
	vqSsPqvSuT9kyO5FR07AjBJierjbxIUCVcA==
X-ME-Sender: <xms:ccV_aD1o85Y3M0KayfCUasep0xC0INdPNbR6FpmGU__7lYAzXwxZLQ>
    <xme:ccV_aMo9cGEKoQXCf16hb5y-18EMh6MgHlszsvP0p4OIVDcQNXc3ojM60mefYWxkK
    Tc4dtLpuOAE11VFxg>
X-ME-Received: <xmr:ccV_aAfZpU-2BmeuoYdx3YxWqQ5pHZaTz_2tlOtT8r5sHovD3zIQfYdFRhwRZDcWMhZX-lKJ2Mu40u5CY9lBSPLmcfFb1XfLcLJ-xxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohephhgrnhihrg
    hnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:ccV_aLrnTrzPT8qDkJeD2kH0sXaiR19h9U4QulqwbNJ2uWbJ2zoNjw>
    <xmx:csV_aBEU2EsVhkrVis_HGTM9m-upyObikaWwPX4TgJLpmDQGzwYy1A>
    <xmx:csV_aLvknjKHiPrnbmFNou2vvepMvypjBor5fakx7PTQJhBuEaNdkg>
    <xmx:csV_aDVMuHDGBJvhM9vrnuHTH5lKbNqU326uQS1twGSKQsdXGRfvKA>
    <xmx:csV_aNDhK1OR6W_SLmPAVO_CdENkvnN6TGttkaywFN7ENELin1WZoh5C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 13:08:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org
Subject: Re: [PATCH] blame: only parse detailed commit info if needed
In-Reply-To: <aH-dGhHm2xuY4yT3@pks.im> (Patrick Steinhardt's message of "Tue,
	22 Jul 2025 16:15:54 +0200")
References: <20250722114220.87570-1-hanyang.tony@bytedance.com>
	<aH-dGhHm2xuY4yT3@pks.im>
Date: Tue, 22 Jul 2025 10:08:00 -0700
Message-ID: <xmqq5xfktaq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 22, 2025 at 07:42:20PM +0800, Han Young wrote:
>> In commit cee7f245d (git-pickaxe: blame rewritten., 2006-10-19),
>> The function get_commit_info can terminate commit parsing early if only
>> the author information is needed. This ability is not used by callers
>> who do not require detailed commit information. Stop requesting detailed
>> commit information for these callers.
>
> Okay. I think there's two important pieces of information missing here:
>
>   - What does this buy us? I guess the answer is performance, but it
>     would be sure to quantify in which scenarios and how much of a
>     speedup this buys us.
>
>   - Any reasoning why those two callers don't need the information.
>     Reviewers can try to piece it together manually, but it would be
>     nice to hold their hand and lead them through the change.

Good questions to ask.  

If the answer to the first question is "well, not really?", then
another thing to consider would be if we want to remove that
short-cut as conditionally grabbing only just some pieces of
information without getting others is not helping.

Thanks.
