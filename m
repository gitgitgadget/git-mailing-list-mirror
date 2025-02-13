Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7019EC4
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425560; cv=none; b=giCi96rOnNyrzYQpZcGTJpPreWRxoM42VFBs4xJviYj4KQZio3UJlfm1NVwYLpiCQIrhZugPIzmrelGJRV55aWJx4Z6kxwoTpaChOLA9l9UbptHgKSFZJ45+HJG2pk69iTbSWHxYSHOzmT62+xMLPPEcjcjuHXjiSjofNA6lMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425560; c=relaxed/simple;
	bh=iMNEVB64MDLcxj8cIXpfaK9bUfVgmFKbDu1HW8WTwGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShSvJo77Gapjp+WSuVpyBXb1N8u+FPNk8aCJyfd0MkDFl+JQv+XhgmCbmceUdp3NtZQBMhba/9JfIcpbIRQ7/qvqW37NRMIvTib0QQ8F6LYguH/gP+hCVw1Ndw7po5zcOLAls0gm3b3L+vkxbF0EBACayzTaPs/Wnizsd4TgF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FBtsDlBf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SUfCAd1f; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FBtsDlBf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUfCAd1f"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 97E991380A7C;
	Thu, 13 Feb 2025 00:45:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 13 Feb 2025 00:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739425556; x=1739511956; bh=h1JQ9CLVfg
	JuHy0v67aEmvaj3E13CT9IpNVpuIySPJM=; b=FBtsDlBf/jrbqKAlGDkDjeLgRI
	yOmHIuEUI1h3qmCHkii8obpByVs+p357Qj3DgAhDP+VdeJk8IIOzApBmCGcxpIW5
	Jle+1Z6za+SdmEHsAnjA4NLkOTIAgwK4iC6QYwgO4+IIWi8V848KDkRVxRrR0WYa
	/Bg4WD7+12w7OV3AEH7lV9jwKXi2sUL4vb0AsBYIipi56MfcC3xfqPY87mxwLcXa
	A7XWVQM7K0ObTe1jl2easbmcj8u3yHVwnecg+/yFfgK2janPrBh/zijIhIEd2T2n
	B7hfm1H4NQ39OgncsVvdK9JWZWe+rXyP+iS5tB1Wf1a255eydWJ+zvePWCVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739425556; x=1739511956; bh=h1JQ9CLVfgJuHy0v67aEmvaj3E13CT9IpNV
	puIySPJM=; b=SUfCAd1f4oQCWc14fraHfxmwuzz6CEcnq7jZ9TQBcmxyzDnnKFa
	3sR45gGgAaypzamhKsVsyJZ8hRBzf3d2rVpZxZTSLnhHULR9ckbin7iQ4nJK8BNQ
	vudjuNWPx8VQlCgWeIk+OZZFFHIdW7W2l07HrfQWL1ih7SkCFX6q3m0jvSbs7fCD
	uafPAnH2M2yDYyUe5/29hSY0XcqbdUmk5IRVCA5m4PPLk9ShOfC0wLUIZH8C50pI
	XO7Ft/ApGPcC2/uS9nRUvmY4JvxG187Nt/kk4dhtx9SmPTsc4x44vyr+W79FxnO2
	6EJ15pxtFO8xggChLn31zW1SCOl/jA5Y6WA==
X-ME-Sender: <xms:FIetZ1puclPsmD9J_RiHYsChEwzCXFMjXp6F4QZ2nyesktfyKCJkog>
    <xme:FIetZ3r0y2UKlpl23FrJ7Xca37iIl4kGUzP_a9ycb6lkv6XWWCXS4dJ06fKr0IVzo
    9LsalopX0_27HOFEg>
X-ME-Received: <xmr:FIetZyMMVbn_5FvUG_mvpAbSNYYYOCUn8s9zbh7e1_wVs7G14fTz5L56R5swwd9XjnU-7m48O0fFJWPov9wJZ3Y8Fncc0jgH71zKbCXbi3zxQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:FIetZw4JRSFbvYWne-Ve-jm-tYKxr0HLjGfAEfx5hyfH74rQbVNDtg>
    <xmx:FIetZ04zs-lGo6YJ_A_wdW9xkEzQQ-LWdteJjBLlJLevHn15liBEvg>
    <xmx:FIetZ4iIM_Jx5khTfVEqXkTiHhIytQK3X6ru43g1Q7BNGtSsE3Gnhg>
    <xmx:FIetZ27jmKyv0ytIqCwN7CYIvh2U4wnZoAV3srLlctLGExjzOpz4lg>
    <xmx:FIetZyl3wVO8uF5Ou4bJVpCoMxwtplID8ridObPO9OzpFW4yDs7wYuWG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 00:45:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c120696b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 05:45:52 +0000 (UTC)
Date: Thu, 13 Feb 2025 06:45:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/3] diff: return diff_filepair from diff queue helpers
Message-ID: <Z62HDg0j2qkXy0u4@pks.im>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-2-jltobler@gmail.com>
 <Z6xomFk_Sb18UMFo@pks.im>
 <3vqcdil4qdam2pcb3mjruuda2kgph3arzhwswnlugtqykmc6zm@7jiwkyqty5lj>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3vqcdil4qdam2pcb3mjruuda2kgph3arzhwswnlugtqykmc6zm@7jiwkyqty5lj>

On Wed, Feb 12, 2025 at 11:24:55AM -0600, Justin Tobler wrote:
> On 25/02/12 10:23AM, Patrick Steinhardt wrote:
> > On Tue, Feb 11, 2025 at 10:18:23PM -0600, Justin Tobler wrote:
> > > The `diff_addremove()` and `diff_change()` functions setup and queue
> > > diffs, but do not return the `diff_filepair` added to the queue. In a
> > > subsequent commit, modifications to `diff_filepair` need to take place
> > > in certain cases after being queued.
> > > 
> > > Split out the queuing operations into `diff_filepair_addremove()` and
> > > `diff_filepair_change()` which also return a handle to the queued
> > > `diff_filepair`.
> > 
> > One of the things that puzzled me a bit is that we keep the old-style
> > functions, where the only difference is the return value. Wouldn't it
> > make more sense to instead adapt these existing functions to reduce the
> > amount of duplication?
> 
> This is what I considered doing initially. I noticed though that both
> `diff_addremove()` and `diff_change()` are stored as callbacks in
> `diff_options` as types `add_remove_fn_t` and `change_fn_t`. The diff
> options configured for pruning use `file_add_remove()` and
> `file_change()` instead. Returning `diff_filepair` doesn't seems to make
> much sense in the context of `file_add_remove()` and `file_change()` as
> no filepairs ever get queued, so I opted to factor out the logic into
> separate functions instead of adapting the function signatures for all.
> 
> This may not be the best option, so I can also change it if that is
> best.

Okay. This is context that should probably be part of the commit
message, as it is quite an important detail to understand the
implementation.

Patrick
