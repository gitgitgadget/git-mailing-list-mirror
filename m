Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1EB15574E
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740858337; cv=none; b=ScSd8fZvUKecuczdfHtlSjMhWGpqxY3DqfPhU9rslR69DOmC2Ekrml7wDX236RVYoiCReMuP2ER9nWfBVJCZUtKU/zDEbSYP+iCOfHc6OgxD5yuPePEqjvhbqX5NF1bWjGvBtlFOdcs2Mw21KcjnwjFcII+ntWVmlCtAhze1enI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740858337; c=relaxed/simple;
	bh=I7pzi+TTyYKJ2KIVvfWE2y8/pVR81U5YBiahdyylgdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FqmvbH1oD2s+3irmvIFvP4RwzbHCU+ZbFZ7gtIerthfnmxUjQDizGBpKsx9+G/K4M81ubAaW+n3zNtC5yPe50zkFrm2KNz4gaO9hj2veXUR6fI+ptMmUFezJMF3NxgGSSjXVy++yHFDC9hK5yhiAMAqNpvVJbR0I8OiEdXe5ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ajLKa9RO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SviyV8I2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ajLKa9RO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SviyV8I2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D4C8114015E;
	Sat,  1 Mar 2025 14:45:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 01 Mar 2025 14:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740858334; x=1740944734; bh=AI8E7+0dua
	Qm9Z0npUoaN1viCEp61/pf7XgAIN/Q+Uo=; b=ajLKa9ROkjQk7dNulWsZ3JZzrj
	0XZyDpVYloLYPzAjSeDOHbcGJj9dPS7yzKwOBFwzLv8axFgvqEFzQ74J6HZzK2nJ
	kk9uU1/bVXrDIW+BEPneSNF/K9UCy4JBszIXKr8SfXPe/3Vqi86/xa9HTMTF3BGU
	o+O+V+GmXzTpauZbVyGcOD/Mc1zISSmws7VTvuXAAzGHoOGaw1V5s+rdhREGRTcA
	vhTiMJhM2m065zGffqecc5tqETi6sV6E6V1pNQJopyUaNyw7RYHGd0sJ6dhlDDfM
	nuhKT5mDoeIe8WDCAXfkvOhyPrtUQX+8oFbuKVD/5dMKk8eP4u9SjxEMbXUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740858334; x=1740944734; bh=AI8E7+0duaQm9Z0npUoaN1viCEp61/pf7Xg
	AIN/Q+Uo=; b=SviyV8I2GTHngEt4XAdiyyVu9R4tgrXocGpXDPBulC9zcf3sgBN
	N9dLdd+mpoYhKGUgxkgFBVQhrV1L6hDPzju977/UFtVeDwB6RPp+3F03l8/tZHRh
	MlCRQya+I4fVNFv6HN9fbTDQwnLuw7jtWVP6vqTXM6SWAmSKdfK8Hckgo+ZN+KB2
	aOV62cjmMZvqCeXefDeDMj/bCbIu5Y7x9R3sYN5nK5V0z3wc1zY7Uz/ZWwA9pfAl
	uKotd/HOWv/fpTf3tqlBE5iKHr69HmcW7jYs8MuhxsVq1niefWqhCJeV7edjfyel
	q2oiSORM3xzN4hnDqhgWjJ63uq8RFDtdROg==
X-ME-Sender: <xms:3WPDZ16KwWWGtHFgPNOIa3absz64m9bHdemhCIxj9M7hlEAJuWAAxw>
    <xme:3WPDZy56VpDhar56Z4R9eCgHIpYD8G8H80rax3dPbgUIGcLz0fHriSJMFCG0sp-0E
    KKTub-Z2mzq2PaqBA>
X-ME-Received: <xmr:3WPDZ8exX6SHtEwKr_nNm3-kq0di6mBnSO5mb_W3tyql456RNEa4V4sV6juq4GlkxYfYK5lsGRdhzJ1xLtJalECyN523xwoqSCaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3WPDZ-LnzrB1SJMUa511Va-1LY3jjhZzthCNyuUZr6vNs_FAwVP9Rg>
    <xmx:3WPDZ5KLCSlX67D9XK97ldiRKjV1CzYRR3PfXBKjxft3QiBwAeTPCg>
    <xmx:3WPDZ3w19NO_Az74u1jfrTkO9zTPSab5SoIqtoVB3SwjKl3JiGJRIw>
    <xmx:3WPDZ1K_9e8-C-KXZGHMB15KLGKete-NJGpIzynPcqU_2tFLysdvEQ>
    <xmx:3mPDZyXF1XF83BmD_o99xxOtMnBDR83x9bjhkFRDZw0Y69HfDPA2dGZh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 14:45:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  shejialuo@gmail.com,
  johncai86@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be
 NULL
In-Reply-To: <CAPSxiM-fzKUtvvf-DB2=VaGznr9utyb6zaKU5onxpy49KPChUA@mail.gmail.com>
	(Usman Akinyemi's message of "Sat, 1 Mar 2025 05:26:55 +0530")
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
	<4e21312d-0d9a-404a-a2e0-0e2fcc681ad6@gmail.com>
	<xmqqbjum2ayc.fsf@gitster.g>
	<CAPSxiM-fzKUtvvf-DB2=VaGznr9utyb6zaKU5onxpy49KPChUA@mail.gmail.com>
Date: Sat, 01 Mar 2025 11:45:31 -0800
Message-ID: <xmqq7c58zg9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Also, about the testing, I was thinking of using the clar framework or the
> test-tool, do you have any in mind ?

Neither of them seems a good fit for the task to me.  

Once you rewrite one of the built-in commands using this and run
"git $cmd -h" under "nongit" helper, wouldn't that be a good enough
test to future-proof the codepath?
