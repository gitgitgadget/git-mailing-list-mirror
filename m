Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326D4C74
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720113; cv=none; b=Lhg36G/RaJWuDfYLVVz4Kv9ASIcn0SNGUEhAW/4q9JX1I7iKksEpwFow6AB2rPJWCs+Lqo8QF7xybPm71qRgKEOooiCNB20hnnS0e7CpgrwhYtI8Cr7kMWrJJcwdvttUYvhJub5beXvX+LTb02R3nudfhMU/k0LomkubJ1qGbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720113; c=relaxed/simple;
	bh=4Wr4NsuMojV+NB59L1f2aEaAqv92CKlAb3xqQl0K0Kg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBakFYXkJonU+cOnaiWURQVGe/awuY7Z34ZXo4EOAyopvucp6kKUfQSm8w7ky+8EjyFqxdhfb4ltrW1c2EJcWg+C5l97xhMsTW4khZjryee0lKXZELLvZKgtVbSvcxqXL7IqQ85NLoxB8O4W16Trecv4m2lPYKIRUDuXnqmpmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YdNMyxEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ior4ov4F; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YdNMyxEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ior4ov4F"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15B6E11401B4;
	Mon, 23 Jun 2025 19:08:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 23 Jun 2025 19:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750720111; x=1750806511; bh=L1gsV8triD
	jPHKxj4kgwpdzfOEmCyppzXpDbj6cGR9U=; b=YdNMyxEhriVPtRWSSoRBOZJiK9
	jE3jt2J5till86JmNa6fVnfbg0sa2Nfvh4tUQyuryj8bd6MFwwiqsJrOeLDSnm9p
	0TduDcv96+leM9/SUqqkLntlEHWYukV7k1LPZOJqW01qlLXOxmaligCQG5ZIl3Mx
	zhz8mzbRSx+APdrqLv0ugteliY3DnT4kI7aUG3RGhHqG5d1DcvbGbwXVXCwc5S9B
	5meBXPhHrVB2dswoFUf76f4qKwXJ6RXLOO84ZZkDLfgCKkMoHOEV+AdHUXbPDOIy
	bsc4l1pez5b27aJPZnDRtzv+CYp/luhErM3QJijSQAQG/Q+utwnIYZzj/LCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750720111; x=1750806511; bh=L1gsV8triDjPHKxj4kgwpdzfOEmCyppzXpD
	bj6cGR9U=; b=ior4ov4FV8N/pCdcPOR1467KSeBGEsjRYssbv2yRaOVIAvfA7mo
	b4eKEWRF/TKWhm8fXAEPYeGEZ/KB6wDTmpeOKyjTgPBba2ezJ0TVmQ/YXHNcCS29
	xKHD0UXSK3zqznXmdw5p27aDoTJa9uK340rOehSivPGDDchR0h882Ve9F35CPlz8
	/XOR8EHZvo0VO1E/gCXr9Kr1B4v85n+2Vi36C9VBGxu3/1NA0jeo1AxW4EW4h5+F
	fwfcf0umBpExdMQU99lnbgGPxCALL56TdAfioTr9jkFRo8yeW69pALDOUX1jv7E3
	rUlxi92g/AYkG3uexlXdvQ8kKP6MvIQSLzA==
X-ME-Sender: <xms:bt5ZaK2UkAM1UbpPObFXF87aFFq9D32o0xQChbgmXua-Uja_sX4eMA>
    <xme:bt5ZaNHXlMdDU30rOp20D4rw6wjQpixhnABARzANuDocNkuAWVLuu6PWSoxvo2KEG
    0u65E_q1ugnNMPNAA>
X-ME-Received: <xmr:bt5ZaC4CUt6p0BuBoPs7vl0hm3kEtwU1V4gnQzF2WOLl8uDfa8Tr5-eHBj3DZccBckuu5QvCJTmh-860GdVq1vrUi_lTltmi78oglTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddukeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bt5ZaL2tK4I8s9J1ibulw_iGuuQjMcvplyQT7mBv77TJ-XA75wEi5g>
    <xmx:bt5ZaNGLMPe99WyqVw38PFOuid89QzSo_dv20nD0yzVjFgNaaYcOEQ>
    <xmx:bt5ZaE_q24Cigb51lNuUycwMToJjzi9jidxrShriQrt6dEGYnXx_ag>
    <xmx:bt5ZaClPl2frHA9Qr100R-WjPXHbFYh1DAnz5DOq_INJHIBKgidJZw>
    <xmx:b95ZaCJJL_a5GH85kusK4Wi2djx_5PNUTnOcEGigLNbV85Yd2LnF4oGc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 19:08:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v6 5/9] pack-objects: perform name-hash traversal for
 unpacked objects
In-Reply-To: <6b0149a32d300268d4ad870c7cb6597a95e0410b.1750717921.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 23 Jun 2025 18:32:21 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1750717921.git.me@ttaylorr.com>
	<6b0149a32d300268d4ad870c7cb6597a95e0410b.1750717921.git.me@ttaylorr.com>
Date: Mon, 23 Jun 2025 16:08:29 -0700
Message-ID: <xmqqikkm3vki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Now that the 'rev_info' struct is declared outside of
> `read_packs_list_from_stdin()`, we can pass it to
> `add_objects_in_unpacked_packs()` and add any loose objects as tips to
> the above-mentioned traversal, in theory producing slightly tighter
> packs as a result.

So the idea is to pretend any and all loose commits as if they are
at the tip of branches?  By doing so, we ensure each of the tree and
blob objects contained in them has a reasonable path-from-the-root?

> @@ -4325,6 +4326,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
>  	} else {
>  		add_object_entry(oid, type, "", 0);
>  	}
> +
> +	if (revs && type == OBJ_COMMIT)
> +		add_pending_oid(revs, NULL, oid, 0);
> +
>  	return 0;
>  }

OK.
