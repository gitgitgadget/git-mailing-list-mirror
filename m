Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74A2BEFED
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768368087; cv=none; b=jdGboK2JcqVTqJnjGbDUNw+FhNeockyB9iQ30E2j0EKnh7h3B3uPLxOoX0p1Z0+2WmPNQFx0wqtyBeDCrrYWtzcT8qpzG3JMrk446g4099bO3RQDZiu8OujXEXhlpvu+i7CJA14ZV4C1ourTj4Drlc0RV8VowYMjhz6ixux3528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768368087; c=relaxed/simple;
	bh=q9oSCUFzvlskSLzGjZq9MdhBDKT5l6JTVeYzyzmPYdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfzEa6ERdi/TWgT5A4czzkjfT/WTiC5YDsIo0MQdj8vTjphgDWNwYpGDeTD2K0wSwyH5OXiG0mvNpBYXpHi66feHh0fvPklNugNfkEj1IRS3zgezx1ig+5vBNjuwPc2/Gfw0BWbkLcDBxP2DcQW5I/KnqrwDtsKSauhEU1x2Bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WyvUPk1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=It3kp+BF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WyvUPk1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="It3kp+BF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BC4A14000FC;
	Wed, 14 Jan 2026 00:21:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Jan 2026 00:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768368063; x=1768454463; bh=KNHiim0tZC
	AvWvM3Ea9BEoWj1tNER+XgKbro6NcS/J4=; b=WyvUPk1q9TSIHAjqsblIgiZCRT
	UKYL5WZ3QzTal02c9AuGYcpqHmGjYHn8vWya0Aj4nB5irrBpq9w8Kj5Mdp3pipgl
	YPl2LGXsY3sf8B+GWsm5L/IWXMLNG2YmEiIALOLv1jbjFZFVCz+klvkz3VcnoHRm
	/td3a21yIA/g1NnLeDKwPjXp1UJVBqkPPxpdyo2AuY10Uj5/MdZdKbh7pqZbjUxD
	39wC32fnaAYeaxjG4SDbnI7Q5Nc+0sfC+w50xSq7EU6pPJBJUAL/D+Yh3tgoZzmy
	LI+dFH/yw0Hyv7yW5AV5WSIUP3jcHCnyVxZohzXO0iY7/9NJgS/HRt89Zuzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768368063; x=1768454463; bh=KNHiim0tZCAvWvM3Ea9BEoWj1tNER+XgKbr
	o6NcS/J4=; b=It3kp+BF1LG7uvNIHKUKFIwfk7peibEhUHAej8mbkW0F7GI+jiE
	KdM//ALXKeQ1AUjpzOeXoKbgQKS8uy5je9ZQmqaFD0NB+R0LlOqTe8CKey4J3QsS
	mBAUPjd5GIW174wNn8qGgN9SOeCiUDfWVCv2dlnqnHj95lWW6jkuHZSebkLrpJcD
	FxW/sUhG9gMBZgqgw4rfwqbaziggOZsuPMS+i6jpPYNYdaQwb5XzV28AGqGFfAmX
	ieir8hXo+H2mXQCLymZVkIlA5mKRfoMQozEWfFH8FTGSrax33MQFDIpQx3xr33vb
	pI6lbqcOxysMqY1xIVsez645Kgb8Km1AJJg==
X-ME-Sender: <xms:vydnab6SnQ9wu10T2LudOpBnnWdYeWF0g0kbI9Yh-79ZyP4-_ewyQQ>
    <xme:vydnaW7OqRu4T6Gt0G-3pe0RkQy0HmHLN8whmOpA7n3R3lVAF7ncDA8ji6jDhNkQm
    tKGUySndN-EjJ4TM6ixPSph3g0KB0ezfcbTSuzasdrVoJ-1JqHw>
X-ME-Received: <xmr:vydnaQGvdDwuLFLEDo64mShpLevJ9i0u3k9A7Rgt771TzVBg_QfJCtgs8qRYm3Docef2kKclaFbt31xwAufcbbLrLkBoUkSwqDzqdZdj7M8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpefhjeeltdfhtdfhkeffvdetgfeiuedvkeelge
    fgudejueehleeitddtheeltdetteenucffohhmrghinhepphhrvghfvghrrdhpshenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vydnaXSyr-3Ft1Ul-D45hp8onji4WBfjKiZog8iV4D1PFZy986kvcQ>
    <xmx:vydnaRux2RJrWoNT-MYU-SXLQ9y-y6HlXHxRcQ4rGMQD8iFdRFkdUg>
    <xmx:vydnaeyVSuhamT7e-kJkQnNs3CZZ4JOJdsI8eXdnfwTs_lO4KkUnFQ>
    <xmx:vydnaT6QmKNJ95ITa8EQ0iB4IBcTwRiDxP4_PWYCCCJIUBlyo8QlXg>
    <xmx:vydnafTXGJofxMSYBFEhJ-49FjWsVr2Y4riXQ43JNgSTZdoKmYRW6dmD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 00:21:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03943648 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Jan 2026 05:21:01 +0000 (UTC)
Date: Wed, 14 Jan 2026 06:20:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #04)
Message-ID: <aWcnsvVdtHYPWOAB@pks.im>
References: <xmqqjyxli89m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyxli89m.fsf@gitster.g>

On Tue, Jan 13, 2026 at 12:10:13PM -0800, Junio C Hamano wrote:
> * ps/read-object-info-improvements (2026-01-12) 8 commits
>  - packfile: drop repository parameter from `packed_object_info()`
>  - packfile: skip unpacking object header for disk size requests
>  - packfile: disentangle return value of `packed_object_info()`
>  - packfile: always populate pack-specific info when reading object info
>  - packfile: extend `is_delta` field to allow for "unknown" state
>  - packfile: always declare object info to be OI_PACKED
>  - object-file: always set OI_LOOSE when reading object info
>  - Merge branch 'jc/object-read-stream-fix' into ps/read-object-info-improvements
> 
>  The object-info API has been cleaned up.
> 
>  Comments?
>  source: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>

I think this topic should be ready by now. The last iteration only added
another test that catches a bug we recently started to hit in production
systems, and the previous iterations all received reviews.

I can try to loop in another set of reviewers though if you prefer.

> * ps/packfile-store-in-odb-source (2026-01-09) 12 commits
>  - packfile: move MIDX into packfile store
>  - packfile: refactor `find_pack_entry()` to work on the packfile store
>  - packfile: inline `find_kept_pack_entry()`
>  - packfile: only prepare owning store in `packfile_store_prepare()`
>  - packfile: only prepare owning store in `packfile_store_get_packs()`
>  - packfile: move packfile store into object source
>  - packfile: refactor misleading code when unusing pack windows
>  - packfile: refactor kept-pack cache to work with packfile stores
>  - packfile: pass source to `prepare_pack()`
>  - packfile: create store via its owning source
>  - Merge branch 'ps/odb-misc-fixes' into ps/packfile-store-in-odb-source
>  - Merge branch 'ps/object-read-stream' into ps/packfile-store-in-odb-source
>  (this branch uses ps/odb-misc-fixes.)
> 
>  The packfile_store data structure is moved from object store to odb
>  source.
> 
>  Will merge to 'next'?
>  source: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>

Works for me.

I also noticed that the patch series at [1] is not in "seen" yet. Is
that intentional or merely an oversight?

Thanks!

Patrick

[1]: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
