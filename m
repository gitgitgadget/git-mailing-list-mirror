Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F12557C
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738565166; cv=none; b=juqx5iO2uf6Y6/w9jdymWL17rTVJsRmQ2/SKMuBG8bhwtYvuz7g4oT+e3xCwjPwLttmoqw9VIF0eL11zIZJVu2V5yqTBSSKwM7iC5LixB/aqDO9HQX0N/FNC1JyZi6p62y54cP7cUz5eLn14o7FhX65kYEn9EIWcdOPrqxSAJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738565166; c=relaxed/simple;
	bh=GtbiIvNdcHg2xW8GP0G5dcu7JVNlrwt2yzBD3YTBIMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpNFG4wPnnI7lyus8WY0NP8KBWd89NzwhYp3Jdgbw+w9QhwbELvGG2leOzrqDeZB+qzXcpmfgDnOHtD9Ofmx9QwX1D86Tk3QRxyg31ItaSkSau3KrVMxw+jltDsI3nh+sf2aT1rpG+5zq6CRCYKJQpRlBzknJ086TfpTaDzmWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jWqmMuid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gv+Ztkhs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jWqmMuid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gv+Ztkhs"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 52A071380710;
	Mon,  3 Feb 2025 01:46:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 01:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738565163; x=1738651563; bh=Nzr85n8wZc
	VwujY1opU3eiaeUcC4VAPycet9YOblqVo=; b=jWqmMuideIgpvLqpomJr1hVQOe
	gJcRpY6IyA446FM7M9ziLhvjDuZgqaNYpWKyAUj8F09wUR5IIKX48xDG+ZnI6gCI
	vqBD5Y1ESmfCINVNpcRqzwLF+4DbVVEl6gftNdrzmHYA30Z7dKEWUXhTgoq0v9a9
	fF6W5ULYAtHc4f5liNaNodX7t+pnEF0rJhGyJmfEb66EyB9HSmFy+ROyDoorx1g8
	CO3nNNl14VxifOLqQn+UW4NGYiS2PQMCBTgvin2Cv97ruhyZ18s20fXQXDUqN2G2
	2CS5oNtoYFsBvkNTEC7NCglOXG0/SNPBv3lxZno0oIUNbRXvqH6YJt+CRyIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738565163; x=1738651563; bh=Nzr85n8wZcVwujY1opU3eiaeUcC4VAPycet
	9YOblqVo=; b=Gv+Ztkhs7WFcNhYP7a/45u6rs/7MlpJCMv1CNMW+whFglHHIW4r
	UyLD3MKwHpxAJDubyOFakJ9zGwx0sLTpaEG77XnBKyL4eAegR9d2iNSWUykyKHR1
	uku4qbYraiJ0nvEO4W9Ab9gBNrkRylZZjAeNErMJQnKUwp+1e+zKCRnz/iOXHp3k
	DFEaEkASkNhHoA1i96UsuJggr9B/ONvHZHczFGYoAZ/0C84bqFUmXvDXB3K4DMkp
	YxTwLlnv59d1vXdQ12DegEfi7dtgh9BzvgsPxrByN86WRRov8DqyvxiX5YGttb7L
	ct5mpqCfR/ul8O8JNBWcy92+xORDo8S2h0w==
X-ME-Sender: <xms:K2agZ_XDnR5gPc669YghVexyw2PT2OgfEON8QaC8xa6KNwPTOCd4og>
    <xme:K2agZ3mpDCu5p2z4JAkf-SUR7SZSGELb324BFpJd5P5s2u7Bp9nEu2Ygbyt5vH6c9
    XVA9VWiwwsQ89uSKg>
X-ME-Received: <xmr:K2agZ7Y2k9UG32PgTuFi_bJfVHBjliDyUvvQJ8OwG6nU41Jx-Gd9LfckNCHeba42x9GaUR6zGCKrxh1Swfds7pdHqF2vg1E84JtjJ2yABp5UIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghtthhrleegsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvggvthhs
    ohhniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhurdguvghnthhonh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepshhhuhgshhgrmhdrkhgr
    nhhoughirgdutdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:K2agZ6U7gbsC0n9oQjlax_khoMDQ5ytx4pEh8FggSsqY_m9tki14iA>
    <xmx:K2agZ5ln_D-oq2iCVS9oyB7ynWs0cZHLA8RWYorU5p8fehi6-NfIYA>
    <xmx:K2agZ3cufrOuc-MU-BdVtpS0XRHdagTE7n5W8Abw5kGQWULa6WqlDg>
    <xmx:K2agZzFEykQ7QXqNIlTah44F0CjJotMySIUdiQtzAJffFCSy_cT5Og>
    <xmx:K2agZ7449aJ_k4V_U5WSA7I0PARacxQHmafW_eOSv0W-Yjj82t6j_T6e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:46:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5e68a74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:46:01 +0000 (UTC)
Date: Mon, 3 Feb 2025 07:46:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Matthew Rogers <mattr94@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 3/5] refactor(remote): rename query_refspecs functions
Message-ID: <Z6BmKO-034bqOCjS@pks.im>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250201064202.76116-4-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201064202.76116-4-meetsoni3017@gmail.com>

On Sat, Feb 01, 2025 at 12:12:00PM +0530, Meet Soni wrote:
> Rename `query_refspecs()` to `find_refspec_match` for clarity, as it
> finds a single matching refspec.
> 
> Rename `query_refspecs_multiple()` to `find_all_refspec_matches` to
> better reflect that it collects all matching refspecs instead of
> returning just the first match.
> 
> Rename `query_matches_negative_refspec()` to
> `find_negative_refspec_match` for consistency with the updated naming
> convention.

Okay. The message might've read a tiny bit easier if it was a bulleted
list of renames. E.g.:

    We're about to move a couple of functions related to handling of
    refspecs from "remote.c" into "refspec.c". In preparation for this
    move, rename them to better reflect their intent:

      - `query_refspecs()` becomes `find_refspec_match()` for clarity,
        as it finds a single matching refspec.

    ...

I was wondering a bit about why we rename the static functions, as we
wouldn't have to expose them in a subsequent step anyway. Other than
that I think we should adhere to our coding guidelines with the renamed
public functions:

    The primary data structure that a subsystem 'S' deals with is called
    `struct S`. Functions that operate on `struct S` are named
    `S_<verb>()` and should generally receive a pointer to `struct S` as
    first parameter. E.g.

So:

  - `query_refspecs()` would be renamed to `refspec_find_match()`.

  - `query_refspecs_multiple()` would be renamed to
    `refspec_find_all_matches()`.

  - `find_negative_refspec_match()` would be renamed to
    `refspec_find_negative_match()`.

Patrick
