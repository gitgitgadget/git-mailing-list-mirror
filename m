Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A951C75E2
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729543; cv=none; b=MFb106cgXAh3nAI548TDYl/3ApP4b8dqKfx7Z6qHVgd6Bj/JLt7zQz8pS928/LMDMtMdE48QQA0+m/vRAMlGIOwhL3t50hHyLVOP7SZFUX85mEG1Dze1yC3Bo2iq0E1AK2suuaNOrJ5a9nJcI84Iq6Bsr44WlNi00Raym5QqdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729543; c=relaxed/simple;
	bh=UMIk3LwFQsnqWBercPv355hwVOy+eAjWxcbEbPrt1dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4hoZoJQEi9bo7mAsyTDwbyUv3Z4gGHjQIGGYM7suyAPI8BzTyW1XermotOHZ5ww4nZj17bsoJwCY1SoOIIv9PiyzIHX0WIOMQ/JFp6ZwOMLtIFnkLM6c5Rv/j9ChQQO/o53sh3iCJO2Bt/1hWI1qt8/rLO/YMQrw3qUksjD57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDdoyxyh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7JjaK0Mg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDdoyxyh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7JjaK0Mg"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D4BE01382792;
	Fri, 28 Feb 2025 02:58:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 28 Feb 2025 02:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740729539; x=1740815939; bh=CQ9esLF+o+
	KZeH+mUMWibWORzgOe6aORaXl84/od8PQ=; b=fDdoyxyho0bnydOIlMusetfj52
	WC1iJWWtM+eCchguBtmU7CAOm89vh0CozHXZY/rfrTonMlH7fv1F0MoLJLr23WAb
	m3WfhMTZaC6LzZw0SMi8P+9OiZnHYfKTJ34aBca5bsZ5w+VweynqDc9MXwoIOcfa
	8PHGLo1whCq06nXGMavp14IZ0pYsCzkLky3F1xCzclK2LQXBtMTDsxtsZzGH9ono
	J5s0D0m4A1BgPfnzoP6tCem/oYjX4SL02PaoZeU6vPqmnbI9TplFfArL6A2xABs4
	hfEmAW1jafee3HBzVcd+15gTYTZWGVNLr5SXC7sTlKJgiYSr7zFuZeD5ClTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740729539; x=1740815939; bh=CQ9esLF+o+KZeH+mUMWibWORzgOe6aORaXl
	84/od8PQ=; b=7JjaK0Mgp7VTrtFBlQsx5RKBQtdbu9ndtTaWBXZp14p7nVfp+rn
	ILSnP77PdWYg0I33/ZMEF+EzJG556hMWTyLdifbxMOIMFo4xnoDJyzlQMN6G7wfw
	cumwQhO0hfwL37Jtdzfug5zj+zUndcx7ULL5BW/Stbsrg56ZcXs6mhdcB43sTbMH
	Zv7y2T2h6SygKMQYJHJjRPgtsPWMqgcNwBrY058N70cO5jmSvTOCZWWWixrA8DLd
	QOjnQC9fikQdE7KBQyMOz7Uofg2X4hVxiXM9QdiCJDoCEqaRwKUTbbzTQ2zCA2/P
	NH4ignUmqNbJBWEJ77ouK68uJl8Zi/Rg0lg==
X-ME-Sender: <xms:w2zBZ1LUBQQ7Tj5nQm7CD3J1C8xDS7d5ayacUKJxTL4V6BgD-q1EIg>
    <xme:w2zBZxIvyxIAWGxO2K5QKPSeFC_mdkkfeoPh9dSTlUAGj_W2Dtn41LfvNvC96DwfG
    ZLdtuPnlSVT0eF9nQ>
X-ME-Received: <xmr:w2zBZ9uOxYQoqT3lXyIPqTsagq6N4IIH29LDdg3plIL7LbIRmU-ckrnN5Q-AcngMDDGmxsqFxyuFMrlqIoVSpn_bkxbl3Q19bbXhrzVOJTNhzkKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:w2zBZ2YBPucPvRetQpe23Tie6pVvx0yqV2EHBdw_rMVnMWoEWkUV_Q>
    <xmx:w2zBZ8YA9CT3Dx8N9OhmNNunmdvWpAh859N8k-i4ghVneiOM6YSoLw>
    <xmx:w2zBZ6DUBOAdZw3ciE304lTKcbj11LNZMKpwuGElErlEPTHLWO_ItA>
    <xmx:w2zBZ6bZM-9J3wP9gMzI0pLnMIgoRMVBpBH7AuPQcarCzZLC6yF9Yw>
    <xmx:w2zBZ0Eud-GW0EGH8F92Gw0szDJzrJqgiZHe3pjDTg-HxYkDRIr3obOd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 02:58:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3fc5ae98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 07:58:56 +0000 (UTC)
Date: Fri, 28 Feb 2025 08:58:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] meson: fix sorting
Message-ID: <Z8Fsv-mcJlDbogtd@pks.im>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
 <9d1faeae8a47326fbaef9a7a670920899ab0aa81.1740671049.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1faeae8a47326fbaef9a7a670920899ab0aa81.1740671049.git.gitgitgadget@gmail.com>

On Thu, Feb 27, 2025 at 03:44:09PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 904339edbd80 (Introduce support for the Meson build system,
> 2024-12-06) the `meson.build` file was introduced, adding also a
> Windows-specific list of source files. This list was obviously meant to
> be sorted alphabetically, but there is one mistake. Let's fix that.

This looks obviously good to me, thanks!

Patrick
