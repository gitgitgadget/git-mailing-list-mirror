Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A521158DC1
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614291; cv=none; b=QQUxBHpBXIseW1J9PT08xm6omYY6ID++QHstkb+xOY6OxnEFkz97FO1QOQRtdKdfnbUxmyFq6sDUI+aNh3tpJHkiPoMM7EhO/wMvNtMOW92bGCxcQTFaAlyVQMrE45JMrrr5Ibmze34nHoAnj3DPW2ED9yghiR6EsuAQm1g0M1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614291; c=relaxed/simple;
	bh=K8UJOB7muaiR8lLrzapH5y7Pn6H6mWjEOR+MaqHeJJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuRlXX2ShF4pEXLnSKrrOloY2e2BxV8IsOltnKMtDzlHtFGhpIbfLgs1Pko2qRc71pFy+mvBpy4rjAh7LgsjmcaYtbRoUyfkBsjacQ90V/QIFETY/DVXPNdQ+P/hEaPlLYF7Rsl/gpluqzBOT9mVXNAR2RACq+HBaTC4oqfMNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HKwrCeId; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+8bc0IG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HKwrCeId";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+8bc0IG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92C6E1140343;
	Fri,  6 Sep 2024 05:18:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Sep 2024 05:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725614288; x=1725700688; bh=SK0TCABLjb
	kvzQ+z+nmVaETZhgNIvjD4eFYQqO0UqVo=; b=HKwrCeIdcye/JhKk15HJ4LIk5P
	cIKwm6QSCr4SMmYG5M2vQ11Aa8CWREnj6nkMhlXMc0ep8RDHwnrulO07SCqmAGdO
	85aJ9MVXWIDPDMXe7tsHfNhxWojkw2RP2FJvvkkN7Fp4EkSioN/wMeJCqKnBG4++
	K2rTWkVwITgpJravAjkPReIg5bTwCFrrK2s+2cazgngxFWlTTn/Q/RqHKm4ZnnIf
	80SA4iDzEvZtN4Gd3T5xrZaoVC60uXZFtXA/EIZ6ROWJq+pbQinhJq6PmlWAnYSQ
	Rh7IlgrsKJALz8XMkyO9uJxiWV6jJFwF2ftVkBG28010xushr49TPbPt5ijQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725614288; x=1725700688; bh=SK0TCABLjbkvzQ+z+nmVaETZhgNI
	vjD4eFYQqO0UqVo=; b=k+8bc0IGB76EITFJO8qqMAbn8E/Waa9Sq1QpxwGU/css
	Cc0yAz6voLa+LWj3Cw9OQ/xvYw7ImqussR7pdACkdDTIpLxx2gzysB7wK0wvFpLN
	Nwyc6LRMi3PM6GpFhor1E50MCcx6PM5AfHdCelHJ3qG6laZjObx6Ybr92aGo0DK9
	EzOmouq3UawEpzPS/q2XajL1uwcKSdTyxWM2VZE6N4/ZMR6nU9SMYVCRxUkSy6ae
	j0IJ1S9ZdNlV7ohq1wy/9koklUpQa3Rwdog3h98sKOL/53tveGFbDI+tZYZldiH0
	qPY9KiMbZNcMSb14/m5iXUdcnx+6OItfMSzIhnZo8Q==
X-ME-Sender: <xms:0MjaZilDBbSkJQdmW_be7SpucbFyWWaQeFULrOJjtl-SBri9Nuj67g>
    <xme:0MjaZp2KViAEqqPwfVDVyblXbhIPwQLivTTreKVmnLOODzML-dQneVqqSxAzllhuI
    GddHIku4MBaUgG4Tg>
X-ME-Received: <xmr:0MjaZgprfmv9kx5tleDStvpDrfPxmn3yyX2ReZBZpJrpenKJ-4xh-EvckFpLLSwfl2mqdh4kr9AuaIeFrP5Koex4CaW1_vktod8MzKnPNGY_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfedvkeevge
    etjefhhedtgeelfedthfekueehhedtudehieeiieeiuddtueevgfenucffohhmrghinhep
    phhkshdrihhmpdhrvggrugihrdhsjhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0MjaZmn7GfeecMrxQ_cecKv95j75i_6UOHhv_Iv64mp_9-QciukF2Q>
    <xmx:0MjaZg0mAJ2G7bLnjMJHfLJcPg9jPZk5Fl3cIo4KRj03mKdgRWbSjQ>
    <xmx:0MjaZtt9ItZ9IX0Xv6WDuHCrpXI_VmC2YYY2nS6YIFyCrikcbedQGw>
    <xmx:0MjaZsXpQ4ylsT0ubwOPFymCowVCEniO1FuO4DdhoMLEEp7y6AwbFg>
    <xmx:0MjaZuAHU6R5dWixltv4fv4oFrWjCIezA5E3SWksCyFlbUxVW9Z-hYPC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 05:18:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66bf85c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 09:17:52 +0000 (UTC)
Date: Fri, 6 Sep 2024 11:18:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #01; Thu, 5)
Message-ID: <ZtrIxtNJcE15BY-Z@pks.im>
References: <xmqq5xr9zow7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xr9zow7.fsf@gitster.g>

On Thu, Sep 05, 2024 at 04:01:12PM -0700, Junio C Hamano wrote:
> * ps/leakfixes-part-6 (2024-09-05) 22 commits
>  - builtin/repack: fix leaking keep-pack list
>  - merge-ort: fix two leaks when handling directory rename modifications
>  - match-trees: fix leaking prefixes in `shift_tree()`
>  - builtin/fmt-merge-msg: fix leaking buffers
>  - builtin/grep: fix leaking object context
>  - builtin/pack-objects: plug leaking list of keep-packs
>  - builtin/repack: fix leaking line buffer when packing promisors
>  - negotiator/skipping: fix leaking commit entries
>  - shallow: fix leaking members of `struct shallow_info`
>  - shallow: free grafts when unregistering them
>  - object: clear grafts when clearing parsed object pool
>  - gpg-interface: fix misdesigned signing key interfaces
>  - send-pack: fix leaking push cert nonce
>  - remote: fix leak in reachability check of a remote-tracking ref
>  - remote: fix leaking tracking refs
>  - builtin/submodule--helper: fix leaking refs on push-check
>  - submodule: fix leaking fetch task data
>  - upload-pack: fix leaking child process data on reachability checks
>  - builtin/push: fix leaking refspec query result
>  - send-pack: fix leaking common object IDs
>  - fetch-pack: fix memory leaks on fetch negotiation
>  - t/test-lib: allow skipping leak checks for passing tests
> 
>  More leakfixes.
> 
>  Will merge to 'next'?
>  source: <cover.1725530720.git.ps@pks.im>

There were multiple ACKs on the first version, and the second version
only addressed some feedback for trivial things. So I think this one
should be ready.

> * sj/ref-contents-check (2024-09-03) 4 commits
>  - ref: add symlink ref content check for files backend
>  - ref: add symref content check for files backend
>  - ref: add regular ref content check for files backend
>  - ref: initialize "fsck_ref_report" with zero
> 
>  "git fsck" learned to issue warnings on "curiously formatted" ref
>  contents that have always been taken valid but something Git
>  wouldn't have written itself (e.g., missing terminating end-of-line
>  after the full object name).
> 
>  Ready?
>  source: <Ztb-mgl50cwGVO8A@ArchLinux>

I'll do another review soonish, either today or on Monday.

Patrick
