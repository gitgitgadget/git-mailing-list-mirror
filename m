Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DA19D093
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626269; cv=none; b=T9Ujol5Kxc8C0VhjcgCBKwk34w3jjZ/Dv4GY6BlNfSphTLDqJWdllsG0Gm3HJlvxa9WUJTg+5KxzWEAZ4SK2Lgbhtc2kc/oV8YT30bUDbDD6X1uVaE3jUuDUncA/Zqxi8COEiX1PBeBwZtWir7AR/VyyS8U6GuK/AgwaA+ISC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626269; c=relaxed/simple;
	bh=KfXDs6lFjKgBI8ap+u1mNnohoN38RAN4lGrGZewJGak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rld/LTfXL4jQwrtsF5RXXAIILf/iJhNxK1y5zFDytHAJdtl0n6zcpkIvDmYgwILMwY8qS81mc1IGf29VKXQduregG9fP+zcWdRXwIneChTIiV/pO4w/InjxIUsqVWc8FYW6xfYMkGO7tZLnAvFY3Dok1w04XgEe422dmka8eiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eEz0Tv+3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPPkYQVB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eEz0Tv+3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPPkYQVB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 54E611D00196;
	Fri, 20 Feb 2026 17:24:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 20 Feb 2026 17:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771626267; x=1771712667; bh=KfXDs6lFjK
	gBI8ap+u1mNnohoN38RAN4lGrGZewJGak=; b=eEz0Tv+35/gNl64gUG257WLPgI
	Nxcl+qp7deWJnIuUXQ4vh1prr3hfdtVc3KUz6YytizGCkWCecmZcgVRwOLDeCsxc
	NsrZFdMExN/tsqChIZV2+Z8dRETsRocUDh1D964PlN440v8jkGwsIi+/yqeZrVEi
	qa2OrPzcsRXt0yY2E186ft13ogosjUeWzQyaKRI62Hwoc3qc4YPlwt+WF9JHgqzH
	Cnn9gXmfgFXbcou7/F5ladWOzLpaA/NnHrhi9UjgDaju4/wWT4cpZ8zbvARVnDoW
	avGAwAj1dUvXkjCsYVv2YOOarf9xWZbFHasutlt+OD2RNodoVv0+R0CM+gOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771626267; x=1771712667; bh=KfXDs6lFjKgBI8ap+u1mNnohoN38RAN4lGr
	GZewJGak=; b=hPPkYQVBfNY8+bAGHgK+XwdBs1hv0z0ehK5fZ36lClA3++YzEtL
	DdSMdk4pDO8BJB4Bh3wjLUZy8kPTHBkeF1ReZufVoY3dgng3Ol/7zTLABCSiyPDj
	lRgdXh1p2l+wPyfp0dCxADy1PWnU3UYCUyyoDNul8HV9cOvcvvhw782UuIvXNprs
	9oKt/9MRfkAWdX066AC9RqXhVzaYw/G479RLQor/inLxElgOuTnQYFsjJK4mib5q
	RTxs+1Raq2DF8skcXkKeszGXsUtl4bWFp1h1S/26mzrSgcyrvXseaOti8DmDsCfA
	tXhzDWGFTpIfP9kP3KUMhlznXSId0tHt7xA==
X-ME-Sender: <xms:Gt-YaZkCpIeWbcuH1TNtNLyX4Jny44FzMY1GvWefrnKc3kKi3Hma1g>
    <xme:Gt-YaYjSpyX-41MXIt2vwKzkdR6QSaMFfjzKGMOiAatkrh32gOLN4F4zVVZ806DD-
    aQgxzrf5damh8ezTEDX242o-bOQZyPu2y1o0I64p1L14lXwLAifIg>
X-ME-Received: <xmr:Gt-YaZcuvh2rqX8ISTAZKL0yXswkUtyfX7zsp2KdDpi2td0Jyzs9_b_O1AFz6GCSGiBB1MmMKzCcDKQHWkWbyUUjeW1QmPG94Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Gt-YaQjw9lDkk3aQ_FariKM1ChJzBAqP8ASF2Z-0GRGor1a9Op9Rog>
    <xmx:Gt-YaZwyofIMWCRCnF2lOFjCPMtOuEBgINgEx_aHqq36lqLHSUkEhA>
    <xmx:Gt-YaUPTGqHqFEEwL0tFcaxrjQtOhB6xbpZSM_qn0kryYzNetTvYCg>
    <xmx:Gt-YaSWcBpyBxOkl-IlLkCjZXjbWrn-NEbzRJje5bnnFpD8jL4qx5w>
    <xmx:G9-Yadz21-WY04KwiuKI1-6KgOCqURVdyTEt3I5eFClOH090AgYj-ufQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:24:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/18] midx: incremental MIDX/bitmap layer compaction
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com> (Taylor Blau's message of
	"Wed, 14 Jan 2026 14:54:13 -0500")
References: <cover.1765053054.git.me@ttaylorr.com>
	<cover.1768420450.git.me@ttaylorr.com>
Date: Fri, 20 Feb 2026 14:24:25 -0800
Message-ID: <xmqqbjhjvysm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> [Note to the maintainer: this is based on 'master' with my
> 'tb/midx-write-corrupt-checksum-fix' merged in and should produce zero
> conflicts when applied on top.]
>
> This is a reroll of my series to implement MIDX layer compaction
> adjusted in response to reviewer feedback.

Haven't seen a lot happen since the end of last month or so.
Anything left to do here?

Thanks.
