Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE092580E1
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460468; cv=none; b=f/zIBqdDfEo1cCnXPnCMGlmifWjAMyVgiArV2X+HMqJOZykVYbiqUFGp/Wo8zu9FgmgqNrFj1fBdRNCgtRqDtsKehB8//WPNryjWIa8gurGtLS5UC7PhoS2ZOcMXK8OYObUw8SKhoE4jzRtMLISdHO7bWWt/DapYnt4Lf84OaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460468; c=relaxed/simple;
	bh=XPegPlRvC6F3uf3xJJ5vmoNZRJP0Ht1yXPM/I0k4Dtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMW+IWLqiKQiC4KHFxRJwXVzwF1odiNpT+8byhJD8WXm3Iw7WFI6CnFGpp8l0I4VCmCfJ/k8gyUdqzIz7mkVGRaU/6FuOellDVhOjoUKH65WFqfybPSjbHcgq/6DTZHYtHcWHul4RhUs5PrFo50/XNRIkJtPDo/y9PhGYJ2y9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I+VXW+zt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPcHSwKj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I+VXW+zt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPcHSwKj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 962D32540270;
	Mon,  5 May 2025 11:54:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 11:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746460465; x=1746546865; bh=Z1llhCCWir
	jEk64MSo7WS4fSXEMiqyqSL6Kczd41T7I=; b=I+VXW+ztRMG6fvVh86bsJXA0Rr
	Yb9Fh07yNtvZTvDh4AfMZ+/Ln7o8GmCVLsYkCfOZ7yxcQQce/nNrtuKjOts+qVjx
	oLPjFEJEtAJLXvxCcmViYXtqytCEgtQQJ2i4EZEocJcEx8TPuEVcjJQzkjjVra90
	znkt5Ztg+mpafe3BakoHpXsyMAvELGI9bE1AywYv2YvySdnMQE4KiDFvU+xq1KKf
	OaoEqqV0xCmOC50czkPWbi5pIYQiU98gwt+BtpMIvOTd7yNcojQc3EDElnSdcINx
	Gq3SZAcEjPex99kRUt4tYGBAD+B6oeOOn2KE26l5mUiqljmkkcbq6YX7FHIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746460465; x=1746546865; bh=Z1llhCCWirjEk64MSo7WS4fSXEMiqyqSL6K
	czd41T7I=; b=rPcHSwKjrbVVhF853Z7L5Ta73OHYnkTt1lCQMMToP2Y5+td3bxu
	ro+eEsrSrs5ZXIkU8DvI3FvtVCn/UpA2XbrQg7781Mja++elMGsRC2B9Akp4oZ/S
	r1th9/Yoe7M1+1WuxQgEFsLpvt/StoCMlSaWspXBeS062rET+bngpKgOcaXHQ3IQ
	zW9OTIU9NBHlD/xc4MDNOuiGVZQkI+tFjPxOa/etI30YrFbThq6SwN/CgbUTqsPj
	vLF2VFvSOT782za9QckY17lCbpu6wiojyuffKHYTdb02BuIXb5uCg7gYe+VgHwGb
	tg/a+zRCE8ps8XAaPIQjmj1ghcwTtvkiAMg==
X-ME-Sender: <xms:MN8YaLqDLwDVAm9r0OgHxCTEiPcstuas0QkN7dBSwaqMNZWwfc9_1g>
    <xme:MN8YaFpOAsg0V7HQNdUTt8W0Row4kwhAYxd8KQc_A0j17kad4GigOTgI3f8F1u0HC
    o_TdLShRHWkLbFvdA>
X-ME-Received: <xmr:MN8YaIOQuHnDD8o-4y635_lE2ChhRHRDaVhVolntuhwrkUoCvxuqmYkoR5g11pPvo383B3sKNeSyUWIdXaGIeXHLbuu5QZr1D7yp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:MN8YaO6lEr2N1J7fxJNkxNFUK3TvZgWJI0EoY0fbqWPBf3K-LG5Pvw>
    <xmx:MN8YaK4-sNldVuqCyXO-8X45sF5M8dmOrCThcaJsX8_Hjnoh5ejodA>
    <xmx:MN8YaGigqTUeMSvkbmUkbAG2My12hU8WWp3AwQzEJ0cqzkDakCZ19g>
    <xmx:MN8YaM5N1MGYmVBhKLhJtBZyrGTgjKO_P9KDgLpgjpIkKWkZTsWNZA>
    <xmx:Md8YaLx1wlEZV6vm1UYUZcbKglxXPEJ8gCdi_2RuzBubCFMd-UsbyyDH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 11:54:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Johannes Schindelin
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] ci(win+Meson): build in Release mode
In-Reply-To: <aBiIPe7EVTBxENUp@pks.im> (Patrick Steinhardt's message of "Mon,
	5 May 2025 11:43:25 +0200")
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
	<pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com>
	<aBhVWMabOFYRUjvD@pks.im>
	<5e2fdccc-2c52-805f-ff9c-b9e0e72614ac@gmx.de>
	<aBiIPe7EVTBxENUp@pks.im>
Date: Mon, 05 May 2025 08:54:23 -0700
Message-ID: <xmqqmsbroxxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I am afraid that getting rid of asserts in Git's codebase won't ever be
>> able to address the challenge that Git -- despite much reluctance --
>> relies on a couple of external dependencies that might at any point in
>> time cause `assert()` to be called, e.g. due to unexpected changes in the
>> CI runner images.
>
> Good point indeed, I haven't considered this.

Thanks both for a discussion.  Let's replace and queue this, and
fast track it down to 'maint'.

Here is a range-diff for my tentative rebasing the patch on 'maint';
I'll make sure merging it up to 'master' would match exactly the
result of applying the original patch directly to 'master' before
queuing.

Thanks!


1:  f3ae94b175 ! 1:  184abdcf05 ci(win+Meson): build in Release mode
    @@ Commit message
         patch is still needed.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
    +    [jc: rebased on 'maint' to enable fast-tracking the change down]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## .github/workflows/main.yml ##
    @@ .github/workflows/main.yml: jobs:
            run: pip install meson ninja
          - name: Setup
            shell: pwsh
    --      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
    -+      run: meson setup build --vsenv -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
    +-      run: meson setup build -Dperl=disabled -Dcredential_helpers=wincred
    ++      run: meson setup build -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
          - name: Compile
            shell: pwsh
            run: meson compile -C build


