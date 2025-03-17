Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3B81F7916
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247295; cv=none; b=L5/u6pv2vjYF6Daxp8CgfRVXlhUcoUsoA7RgG1Q5kRyfauUxc0Co6ZtGtOg8uviD759nQUSULsh5PGpAiU7PN2Q8eQ8HoFPfnqv+4523x0PbbCN6Ew9h0tVnYgCzqmqSZkg/+EwtRWKXNWHIhdUUKvinpUNwkG/Lj/6qT5D9IbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247295; c=relaxed/simple;
	bh=Jpyc5j0dV+89QhHFXEBofDTrkpIxSAR+Vjd8Qe50Ao0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHs/+6W0tSKU5W2bCyUeSw0Hgw4sEI9B/uxSsqXQ0kV5jWgFPCaclKOHpNjeLWn6KBecZ1aG5cBDy1JkJ0Cxpxu6xXGgOdnXVI47UFAMVnu31dja6gyLpiE/chDuulK0q/penlIKFiVxvKZfTu/5O5/PaGLlse4qrO42II10VYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ipfUC0ss; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWcpAXqt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ipfUC0ss";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWcpAXqt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19930114020C;
	Mon, 17 Mar 2025 17:34:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 17 Mar 2025 17:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742247292;
	 x=1742333692; bh=6HgZFm/I7oc2orey02tk9Oc6pCSyA+Q30YsMoxrYywc=; b=
	ipfUC0ssXRbNSkPpCshzI0R5/ClGZSpUT/t7+7BGfJ5o4UKUGWhzBuK6UyVMrKus
	QQXSjfcC2BN67NvTcPCRIAHS13yZxuZpQregqMZSUamIVrp4LzvTo9aLuI/Rgfgx
	Mjw5I8mE1sIEdEEcndkfYJncs0wrFk4duVoGe/61J/kgGHbYqd42KHCY1fDZY+4k
	LLidfWz4NhuEhC+OI5dc15mXUgLUwF1adYCA1pLEHCKCYLWW1RrAN79IqlvkynlK
	dANeOGm7K2WparmbFqM1TgaqwrvH7UiiAlLoMRraKIpEjuOoRfAEzoAzeNfgjtzc
	SCdxsmGar6+So9uo11KjSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742247292; x=
	1742333692; bh=6HgZFm/I7oc2orey02tk9Oc6pCSyA+Q30YsMoxrYywc=; b=O
	WcpAXqtCf4+7T4cR28Nsm/tzVa/pE6CX5ZIcu8or5+UG5XAxrjaPO77dCZ/kT0sZ
	5oO4YbRzD3yvHvjir+Fv3UnHwVPTWh59flkloRkDtbpjMpiB5ferbOvS5exzw3qg
	XUJIZN90F9bRpa20vipKV6Wz2EF1juALsxkX7syo7lPP1ijVpue2U236UrTdntrI
	TKmRUNgZoo0MvrHXf6KaG8TlG3oc48M/XhBVKTKQ05aYFYoPrulNkGGCFmsRirXc
	yEPUKeKSkNTxmkbKb8g9dB2tJ41lMfQkk2Fdh3/590qW3a+IU2w6LrvIXiF1OVEg
	vnKP7AKbXLydXszuF9V1w==
X-ME-Sender: <xms:e5XYZ10pCC0hYWNfPJ0yM4TC5MjOl1a24A986a-0uvLAtxfXDYLhng>
    <xme:e5XYZ8FGVZGQoE0jgePhGNJpcK9fZnRimWmVAsOmTRRvf5LxcR1578Wgvz_y-LEq9
    917htGPKQp_fZSjaw>
X-ME-Received: <xmr:e5XYZ17eLA4d-uJBsrihE-Y5xK80WiezJJ3t3-cvqRJ5FYmHO_jQ4n4h4g0vkvA1yKk-ySjlhuzsDSG16ALQI6Yi8TCP_-4AxqFaLa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e5XYZy2ObiBRaAtqSOAUfHTr68Qa7FEpmI0vFH294l_V3XdqHZ7lHw>
    <xmx:e5XYZ4G7jnYxYBnZ9fLmlIQ2PAFEcIoiF3fdmMF7YxzNRXnl3zR01Q>
    <xmx:e5XYZz9YDvHwyBCyjy4j8qwn0KE_t33iCis-GD2czQHPPS9eTGtd7A>
    <xmx:e5XYZ1m-FfUuuTwj67G2D3GnT2od9QABFM9mYNudLy-KHaR0eTcVyw>
    <xmx:fJXYZ0hf1TdguItoQmzLlaD6XZnmeDvASgds2x5uQJ_tib86RWVhnGGl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 17:34:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 2/2] doc: apply new format to git-branch man page
In-Reply-To: <b2e7867006e1800eb6dc52902006998afd5800cc.1742056310.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sat,
 15 Mar 2025
	16:31:50 +0000")
References: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
	<b2e7867006e1800eb6dc52902006998afd5800cc.1742056310.git.gitgitgadget@gmail.com>
Date: Mon, 17 Mar 2025 14:34:50 -0700
Message-ID: <xmqqjz8n8hol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
> - Switch the synopsis to a synopsis block which automatically
>   formats placeholders in italics and keywords in monospace
> - Use _<placeholder>_ instead of <placeholder> in the description
> - Use `backticks` for keywords and more complex option
> descriptions. The new rendering engine applies synopsis rules to
> these spans.

And the one effective reformatting in this patch that is not covered
by the list is that the possible values for some variables, that
were mentioned in the description prose, are now made into
enumerated list.

Nicely done.
