Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48E47F2C3
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266411; cv=none; b=aR//otGCVbrKL4xNLNMYcHXfuVaq1UAsu67T6/2f/mWRSks+rAQHFiNXHpmiuxyiMsiIYLmVoxg475puSCaNOWO2ur4OLUjZVUfCcNeWWVVRoqfQXQfOCnUCbX3VP+4+kvjWf3wlmPtGxhxWLnQKu7h3ndMm4XtpiVkXxNSHpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266411; c=relaxed/simple;
	bh=N0o35pgtedYGicgnbMNmx+x/OSQc2ZOhFaKMhvJFA0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5Wmp8Y0UbBYits75JC8NNIw3VEs7INYeQsOACRiRJqS9oDLmdMkdudr5xZpGu90DD5hx3W67KXfx6TRBbEqrHI2EGv2zYX1uObio5CQ2A5jfeTQ2APDnvHfqd4Ovi2UqFB49AnizyUoU3SzH8HzOKnmwPtu2rMNkPjn8HAq030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FGFftCxv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P57Uqv4O; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FGFftCxv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P57Uqv4O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5FFE14000E7;
	Thu, 24 Sep 2026 12:13:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 12:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790266404; x=1790352804; bh=w3aVA9saWv
	eUfBhPKf+owaNXvEtuIoQZhHRiiJEuyrg=; b=FGFftCxvi8LBBBHVgkn9BefBrV
	LqXR8SxeJUhdFqRvMMKn4Y13kJPMcY9ZUUUl5bFD4R3AqborxW1QriI57FlAMrUD
	9HG0CELWVT9/W10BmNdZxLw6kbq+6G1s7I1kX6GAuKnPu6b15niNBPYpW9GUil4g
	mtg0d/f+iiVJ7p7Ah3DlP/UNQYkIYeyq/bBo7RuRhu8fUaGYlelyorfTKVDmy+wi
	lPrwMb2sMo8p8F+YWzTSIcoWS40MTRWQpHxLGk9467aUyf5FJn9U7gSdKmoMgmx2
	nbslBJMVUh+TfiDn6jMKdxWUSliwbr3ZP/cYzJc9PGPeWMH1Finu1+VSCPTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790266404; x=1790352804; bh=w3aVA9saWveUfBhPKf+owaNXvEtuIoQZhHR
	iiJEuyrg=; b=P57Uqv4O4bjrVO8R++WdR4PkwkcrsOgdMIPN9wdZPXB+hwrKdIO
	mgzTsYvNoVoxtB4H5eS2hwWcimPOmEnsMn7SeQcjeffJPoW4Ks2rQsgCBCWdIvjT
	aTF9FWMmdmdLz1BVkNxu1LzqlJ4cujCxmkiB5ZxuXWOMFKzuwJevYDW/Hyw7A0z5
	V+CzGouVSEP2P8PAsJeghQTTIPW4OZ44lcncmu2BjB6hxYj/ECRlrDit9cwN/Zd0
	kIYQvJ8UQfHs8dsNo+YPD33O+0PMKZXQUggT3Ii6z2oRnENUSbBUlTEKctIiiTJ2
	76AhQMq13cT2vwxpDeC5fxD+WreacW9VYLg==
X-ME-Sender: <xms:JEy1aiNJZ3oS-dxJJVEDHrDjJV_TmLokgO_iLtg8XWl8tSN-L2VGdQ>
    <xme:JEy1an9WIhOI5lExYkT5odbNGMlB_NSRMxUQnqybbjZMpt7jMKZP4_eEHYaYym0FR
    4w_js7DXlY1MOBr7sY5HHdiEWK8di7AQWc9tvOcV4nUrI49ODJDLqM>
X-ME-Received: <xmr:JEy1auT7UkwNLUKlBCY9sp7g-U0z9dRZJX-h5wL_IpYQ8k1SqLHpPnE13zP_vOX-QvqWGqWlZwpsqkQgDj1a6gBpEm_HMf0wYF68>
X-ME-Proxy-Cause: dmFkZTFjq5bxQRqxrrCH7YwlirMZocmvpGiOzQ6WzVdX/dUOWwnarJLTc2VD+0DXRzGTYc
    C9NkZNbTB7PSx3ESoAGy+uqIyA0q84m6qMYHnnj5ObhkI9h3YbAYHx6bCxYw1WX+lrjuvE
    6zCTDny8oLne80+tgGOp0iZqxCPvb8sxXv57pTu3D35jO6NNJibGUcND1GLFu9Jnb73eUd
    hyvglRyLEvVPTajwod0ZRM4SKnxjwUp3rHvMNJ7oADp397xFAYBEUjtuACVtHGg/SO9gKk
    TPu6WJUP8JgK5ZfsnuJ6DXjzEjR3zYH3azGz5NLqJl4WOqqusnln87oaz+suenWaEtnmJM
    8ceeKRudWwP9iHLladWTueA8nfv2kkq1kpb9dji5Ic07LzPrTtRIfmUZO2976vYVIBRY7S
    khW+5OcfKVyl6cHK8E1GN4Y+slawXWWMrQ91ZHp7Md09qv4RbgF6h0cs8y9eeVTKy6sQDX
    pG6iOGJuX7NULNxp1fT2LCJ5IbjU6gp9GT488ylIsrkcZqXTuLqlWxKTGQ2LbjHSyx5Sok
    JINibw5ArHhsOUliimEOWTQIbcMk+3cayuzG1tv/f/QQjgj5qtFOhRQmdYLnW6qV1HR9pc
    MoPn46MoF0RdQ3Wg0vURzi4ZyH8Xv3q+6nHKuZLaCvuMmaZpilxgibUBq1wQ
X-ME-Proxy: <xmx:JEy1ahkm9NT1p5nUSPiX_gzjG7TAeGkJnr610UHv8Ck4IZ-kB-9rkQ>
    <xmx:JEy1amTke4Ak8cLsLz3IVMrncCx6EyK6NTlbgS40oJXTdB8VmRLErQ>
    <xmx:JEy1anNkuJZQJamUGlkpgaLY_XV4SjUsSV2K7Cp28q46Zi74F692gA>
    <xmx:JEy1anUqsbJ0ruj8hz63mDyBV-kC0R9Y35lqj6byVpiuGmH7J0XIGA>
    <xmx:JEy1ahxnrnuxZ8a3dVAMuFMfE8kMw9vMuAAmJ_M3mtnEc4qcCvDgXVDj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:13:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v6 0/3] t40*: modernize
In-Reply-To: <067c83e4-7ff9-4e2f-9ca9-2592288bcc93@gmail.com> (Kaartic
	Sivaraam's message of "Thu, 24 Sep 2026 20:28:05 +0530")
References: <20260922202152.842793-1-markchucarroll@fastmail.com>
	<067c83e4-7ff9-4e2f-9ca9-2592288bcc93@gmail.com>
Date: Thu, 24 Sep 2026 09:13:23 -0700
Message-ID: <xmqqld8q4ogs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> See also, "Sending v2" section of MyFirstContribution
>
> https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

Thanks.  It also worth noting that the section referred to from the
beginning of "Sending v2" section is also valuable.

https://git-scm.com/docs/MyFirstContribution#reviewing

