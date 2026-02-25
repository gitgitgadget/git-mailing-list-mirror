Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184D3E8C4C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034385; cv=none; b=rMaohyyDl/jM+iN93EVedSLyQekbxxt3UJP8xcaxPfy4arc89HfvC4SpBkBA3xDwhRR6jBvQacTnqLyGKQJ6AHOhyMrcrEP5jy8cP+OhmHzQTpuLv+bUFWv8SCp4AbcIYvYS9N/PAyOUEO3kLBaq0bmBxcXPXQKW8TX1GgMA3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034385; c=relaxed/simple;
	bh=waLOrQ8g0qIVrxia1mrJaB+i1zBoqJUxZpFNNe7+RuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P8Eo4fCwUkYOBOQxPDTlXyFBnhsu/Yeg5KAcIB9BSf0ozW+Mt25WncZOw/b2ukF30b4wDGHRdqxGt1+4ygSsNmRoYkvrIUqQYS3z3BHXU6Akt9flvsQ1LAXajVRKCj1WtkEPIF8n7Ckr8RBn6yUytlyrkfaXOtQzKTI/d36U1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pwLiVDc1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxlprJ5/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pwLiVDc1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxlprJ5/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BF4A1400144;
	Wed, 25 Feb 2026 10:46:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 25 Feb 2026 10:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772034383; x=1772120783; bh=ev9SZv37sE
	0we5fGZgwPK0EHGee/dyFxb03Lg/pqmu4=; b=pwLiVDc1GGKdlgt8v+i+egH+Hm
	Oz4EKnFUjMpHEu4WOB20tDSN5VlqhvwsfYxyV8+yd1i6MAxlsxe0HGByZXs5EQ7g
	GFzyUhDHOlpfk1LJvx4rD/VYeQhoBL+ZdMz7e0j796MLTnFWSUm54SBl+IUYbt9j
	cZbXKxAWDcTbasHbyEoQRDToJMjeMtUOWehKyb+oaDi/uwuScIR86iYTvLV9FsDY
	Kxs05MR+B/f/3Xzfe4IMrWJOicxbcy/V8Xo6d7rgHMoVtMLTUz3bIS+zZ9eSS4MI
	mhQPHMTupcLacjOJEamn2Gu5dZkSWxbUO0966dFG4cFh6P0LKrQMfCEo6l3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772034383; x=1772120783; bh=ev9SZv37sE0we5fGZgwPK0EHGee/dyFxb03
	Lg/pqmu4=; b=rxlprJ5/14E+k3cSkWRsIm4A/kCSmUA1GB6ddFIgLB2xgvHdY85
	8Nssh/jwvcYPcUEqxx336CKlguJSvAUTZLbaSRB/Lj4CXBDsiTGQiCwcwpxTgzVp
	gJANbyMvoGD9n7G6e2jn/M9zwgC5k9LF/A4u3TphtLR8PCiwY+zfGyV2ejdDh8vR
	eVq0uqtqw/Wcbi/IJrBW+hy5wuUuhU3a7K35fyja1aSwhHiPyp6uJNZzZ8x+wE3c
	7rpvI0It9yuVlM9hpAu37kvPNmvx3pBV1tjKvYbvAvtEW5D8Z+SO/WHO5Q9RpwFJ
	7Q7/KyCFEaHSU6VU/Za4KeGHMNtDw2d1fVQ==
X-ME-Sender: <xms:TxmfaVsi3blljXAf4pyur46kOHEksvlCH7G5XNUK7R_P7O2a6cJFcw>
    <xme:TxmfaRBDnZh_dcI9uJynh36dI7rV3f8KKNKmgiOUaOz5Jn3IEEBOjOuB9VvFwgP00
    G0e2w1IGZPMj5po_0aosK3jj3T1a3tsE6X6ICyLbb4T8e_neRlDloo>
X-ME-Received: <xmr:TxmfacbCE3-TzvQoyfoOPGaX0j5xNWiYc7Xvttl-fkDG9zRUH1DWHMQtiyjmMbmMHzhoq71TqK1tFv8H1A8H6Ee0rh6uZJAB_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvrghluhhs
    ohhuthhrihhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkh
    grrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddthe
    esghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TxmfacWHfCzn4Dha8BuHIrfQeuRMy-W8OfgHLJXoNH1alZ_JhTQv6A>
    <xmx:TxmfabP8HFSpTzVTWCzhNQy3oI3Wp50rb0JUDDmdI1Qh0US3dH11cA>
    <xmx:TxmfaWYgBhwkAlgBeMKgAtyylTGpdTrLBSvmnxxlUu4gK8WQBX75kw>
    <xmx:Txmfaa9rxooThI46w3PS_PXo_DYuuBiIRNgbjGasmErjya6ezCcbWw>
    <xmx:TxmfaSKy_0M_RiW6qbjCY1NRUlbado0NdP0J5FhZv9qoFLwPbzx3BfnQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 10:46:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SoutrikDas <valusoutrik@gmail.com>
Cc: ayu.chandekar@gmail.com,  git@vger.kernel.org,
  jayatheerthkulkarni2005@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  lucasseikioshiro@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to
 show all fields
In-Reply-To: <20260225153414.7461-1-valusoutrik@gmail.com> (SoutrikDas's
	message of "Wed, 25 Feb 2026 21:04:14 +0530")
References: <xmqqjyw1cziy.fsf@gitster.g>
	<20260225153414.7461-1-valusoutrik@gmail.com>
Date: Wed, 25 Feb 2026 07:46:21 -0800
Message-ID: <xmqqv7fkbzci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SoutrikDas <valusoutrik@gmail.com> writes:

>> Thanks for clarifying what I left unsaid.  Very much appreciated.
>
> Hi, after reading that part I realised how pointless my mail was,
> so sorry about that.

No, it wasn't pointless.  It merely was a bit too late.

Thanks for participating.
