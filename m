Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6717BA1
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697532; cv=none; b=DnidxirTLdHi35oMMZlNhpXQeOVppg0CBnJ0fCyunEGGUcyYmPai2CaQ+LaZvgUJxUL2IuXKkqtG2unCqqV3VCTZ23LMaHISPQbHy+B9SEo0tWIVKbME2W8L+GKagxFfy8FHT0MnfGjA3+6RlyJRFxVoYxr6Q9XybwU0zm3rzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697532; c=relaxed/simple;
	bh=G0UPPiXBBECa4BmT2CxjXc6LQDovuXFuH1zvaxPCbtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P+BgJ0n7OfyRzR7fpFke9gn0H+/Dst2WIEbx1I5XljMgQbCIYcuIpm3CfBhYF9dbaq338xxbw3qQCCMVf/MYztkeoD5x4rNONOgzLGO+qXSOPjsKuhQjNYKIm4rEIU7leBHqFCS/XfnPw6Mg4WMqCxg9Iq0E772UuHFwqW2Phso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WO2KrDe7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JeoNdabX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WO2KrDe7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JeoNdabX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EE117A0171;
	Fri, 12 Sep 2025 13:18:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 12 Sep 2025 13:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757697529; x=1757783929; bh=9Uf4FvAM4t
	p5ilJ0LCK/itBicNvoq2H1bNIMGM1fsTg=; b=WO2KrDe7cTIH7CVFpwh2PXqDr1
	3D8lG88HH6x/S3yMRbAVZtjy7ZWadVWHrhKASGYJcUHCF/YO5iua3OFZUL+s52yc
	7wt1zrJOrn7R0a8lHU4Pr/0Yn24YqygYJl0VZCMfNVoA2GipGwTL3NYaVvgGGwKU
	40tDRkLSJ3qCahjgZSqet7dhdU+oGDMdILHWq1rMzohx6NfDZFOA+ct8d+4tULBd
	qN07v6LfKXCr1H+Lhs3zGCnjnhjgx0fd3fB6dXD3EWuFkzCL2trWjNFvUPNbs3sL
	v6qSK97MyYSBkRBjq8G60gziteTFFssH7Mjhygbrq6q0mgwVehJCQ9LPgubQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757697529; x=1757783929; bh=9Uf4FvAM4tp5ilJ0LCK/itBicNvoq2H1bNI
	MGM1fsTg=; b=JeoNdabXqZbAb0ile1PhLqH6Opymw/fNt+AfkN/1eZre7MKkJ1Z
	5bEt/j2PXjLBCBAUae3PHN//p53bUUHS8W1g77hvYu5Tc1ULSnEm4zE3jOlPSqol
	2h6+Hg83as99Ko3QOvadt/g6LDSxTnM9tgaY9q2rn2MscMSKEMvDlM1V7wrePqPU
	8e8ErX06vtajjZVYj1wMMt2Q5eLb6w8kXzmwxCGu3v+o5kdT0vZOL2KWFpjoCNZz
	SiqjOfSQHkAdjlVFQt/08E7uUcltEArtxmNIDujETP7uAKi2Xi19mob6WUzLdokf
	YC7OXsbJPHFWkN9D6eDYBltHTnUKOa4KqlQ==
X-ME-Sender: <xms:-VXEaAuBQM-c9hy2Xe91KLe2aFqG1FVHKYActshG86qwd9I-pwTjrw>
    <xme:-VXEaIDhdCDxlmZ1He4i_92KklXj1R3QDqFN3nGPJDsKRlBAOwcxcsCVnqFbYhllc
    goy0Q4q2LfX8F6Xag>
X-ME-Received: <xmr:-VXEaIURfY_fWlIJNza1WYO-mpyw2g2nTivECGd8wf88oCJLdBr7NF5mThraZZ7l615Fnid9V1zl2BvGBwIdQh4J6mbvml3DQlliCkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-VXEaGAp258atboY_3Ve-QfTgmMjYsR-5VwFemjziPQ7913f9ZNyHg>
    <xmx:-VXEaL8rk6orvSZnsywtu0CuHgKYONpVUE8xCSkyLj063p5kNW7eVw>
    <xmx:-VXEaNFN9leMLE2bWVU8jiYrwrHf-xi81vCljS86k0vxQwOhy2vawQ>
    <xmx:-VXEaJPOodM15fTSd7ZHfVegJXx28imeCUZ1xxeb3iWke5ar6NXxmw>
    <xmx:-VXEaOdBOD8GUQ7mcyXSb3W3c3UD__QygnmSjHQ1uwEvecUGf0VI73Nu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 13:18:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] bundle-uri: ignore bundles without uri
In-Reply-To: <5hm6qdyn5ifs2kr33nwuc67qa3vdgis6w26rlvicrdzznzazzt@uytayxq5r25n>
	(Justin Tobler's message of "Fri, 12 Sep 2025 12:11:23 -0500")
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
	<20250912-b4-toon-bundle-uri-no-uri-v1-1-f4525a406df8@iotcl.com>
	<5hm6qdyn5ifs2kr33nwuc67qa3vdgis6w26rlvicrdzznzazzt@uytayxq5r25n>
Date: Fri, 12 Sep 2025 10:18:47 -0700
Message-ID: <xmqqbjnfmvwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 25/09/12 06:46PM, Toon Claes wrote:
>> Bundle-URI can use the heuristic 'creationToken'. With this heuristic
>> each bundle should specify a 'creationToken' next to the 'uri'
>> attribute. But this allows misconfiguration where only a 'creationToken'
>> and no 'uri' is specified for a bundle . Because Git expects each bundle
>> to have a 'uri', this causes a segmentation fault.
>> 
>> Harden Git against bundles with missing 'uri' and skip bundles which
>> miss this attribute.
>
> Ultimately, the remote Git server is the source of truth and bundle-uri
> serves as a supplementary mechanism to retrieve objects. In cases where
> there are errors related to retrieving objects from the specified
> bundle-uri, it certainly makes sense for Git to warn/ignore these issues
> and continue on as if there was no bundle-uri.

OK.

> I'm not sure though if this should extend to client-side
> misconfiguration. We don't want to segfault, but maybe we should return
> an error indicating the misconfiguration instead of just papering over
> it? At the very least, it would probably make sense to provide some sort
> of warning that the bundle-uri was misconfigured and not used.

I tend to agree.  Instead of papering over a misconfiguration, it
would be better to let the users know, so they have a chance to
report and/or correct such a misconfiguration.
