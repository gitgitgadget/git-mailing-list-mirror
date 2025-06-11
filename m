Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD62046A6
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662964; cv=none; b=PFmRsF5hTD8TwdUG0rSYcvmQasnwwxixCutcDmJtEr/FMdxbMoWHCdvvESODC9I7owZtj6QXD3ECvDWj2C+e2fuesWtdKHm6NAWrU47xBZyyFSRCjHxbOhJjRqxRoCYGQQioTqSHZ5RGb1hZ/DItWXnP665HcfZN0bBohideHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662964; c=relaxed/simple;
	bh=VBocDONs/2AzQEsiPD8gDStpWw2+eGoYZyK8gOQwg+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cPS/IU7f+wxF/vDeZW4jEzjt7R5K96c2Dj+lF25Gg2qvCs/40AjbW6G+iey3DJReO1XQ9djySzEwN53kOk0i6XDileg3Rw+oLSJOIHDd2YDlV8u778/PshbKlIdMR+BWANv0TZaLk+WCSQtPORv8HllCtO2sU0GUFxXDBSvi954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hVOAGMoA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5ygkM6j; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hVOAGMoA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5ygkM6j"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E532D1380C2C;
	Wed, 11 Jun 2025 13:29:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 13:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749662961; x=1749749361; bh=le8thza/4H
	OU7oTPFO2L3QocO4Ftmxn/1k8ec2gETq8=; b=hVOAGMoAqd2EwyCizUwLsy7yel
	SrGPRoavSgNQcY+Bw4SWei+SF5LpW2nakhdcwjvEjSrQcvv24IOGPkRNv4JTaTrH
	iv/I/6dZHDlBdtpAzytVlzXWnGSCI3gJXF8KUGNzh7/z5ySrCByqrkEUcCgVXQsF
	rqvUNy2GFqSqbOiV+2GDsndl4ZPFiB2rHT2ytxosuHX5mx/QCNL3UmiJpvNXbPHM
	oquQ45WVthEVyYdwklzsA3mva2F3T0BZiFZalXPwusIdTg2DPhwVwXUaMqtqOKLx
	f6a6ClhWw3i9YYvZhxcw1SuVllPot3bS46v2CNtVKgJBDEYbyJUZ7nMj0vwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749662961; x=1749749361; bh=le8thza/4HOU7oTPFO2L3QocO4Ftmxn/1k8
	ec2gETq8=; b=B5ygkM6j2KAzge1NSusHWdm79nWdWGB7l73EMQ6U3j1I9THUzTA
	xyG7zcLwHr/5ci2Mlr0kUZV77SOXiO3xeLt47nq/4u0uR9je2ugOIMWlyXRi6tJ3
	VqYGTFXJZb+xC8+x+LnKHK4GDiNzkGLpJhGUohExOniJmHOHeSq1BeiA3WkWTmU0
	V1OHcSdNp7THIAl6xYmzjW64Kp9Z8zDK5/6uuNCeN+hdS4uV6sdjyd7KEhJ3T7Nb
	iW1HQBMVM5pu2IRd0piDJcty3pwxYuMxwa+Ak5xfXZAkTxB0Uo8vPnWiyUba59wE
	MTLrTboYpbNzbDBhQ1Vgut8JrmfM+GzlIIQ==
X-ME-Sender: <xms:8bxJaI9QKu4kwx0C1JTMph2lK4yskKzkhig250ydnVqaxP2_8joUWg>
    <xme:8bxJaAvjLvqUe6KX_BlbnedtykfNbaLdjpXPD3TmUVPm-zipy4Dk9bkZg8_woVu5M
    bOn008tfarCIeD_NQ>
X-ME-Received: <xmr:8bxJaODldnXIkXoHTdJ7rII5Zl3bS_Es8Ur5d59JNPgmPP0lqTi1HosEqlHJ6XiTVuL5gCLM42sKL3zQll96sI5hLKJvAOKqTDOC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8bxJaIeMikUiFqzX6hB3pKVU_rak_LJZC16DWtYVPvZ3qN3sf1OrnA>
    <xmx:8bxJaNPj9vBNPatgGp8uoSvyJQuIPGglflGHCEQ1UChTMXhseb1zsg>
    <xmx:8bxJaCkvOev6nPCxFweyWEpQvGoNfV323nrOLnzZf4chGJyEcA523A>
    <xmx:8bxJaPt7IQLaq1r2IPZAehhSIPznW6DrA5l8wHy01WgVnzG2Ig9FVg>
    <xmx:8bxJaCC8gGEJJKFMcrEayLB4Nns90kPiTjBowISvmUOws_g4sAjxf3u->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 13:29:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/1] merge/pull: extend merge.stat configuration
 variable to cover --compact-summary
In-Reply-To: <CAPig+cRgUWYGPb7o_9UgeQAuE5WN1mtC=bsOP=62rXOzjXJ5Eg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 11 Jun 2025 13:12:20 -0400")
References: <xmqq5xh6xlpm.fsf@gitster.g> <xmqqfrg6i57t.fsf@gitster.g>
	<CAPig+cRgUWYGPb7o_9UgeQAuE5WN1mtC=bsOP=62rXOzjXJ5Eg@mail.gmail.com>
Date: Wed, 11 Jun 2025 10:29:19 -0700
Message-ID: <xmqq7c1ii3v4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Do we want \EOF (with backslash)?
>
>> +       Updating FROM..TO
>> +       Fast-forward
>> +        file        | 2 +-
>> +        other (new) | 9 +++++++++
>> +        2 files changed, 10 insertions(+), 1 deletion(-)
>> +       EOF

Indeed.  There is no interpolation necessary for the contents, so it
is a very good idea to do that.  The same for the test part of
[1/1].

Thanks.
