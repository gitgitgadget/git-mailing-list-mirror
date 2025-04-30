Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0F43AB7
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971891; cv=none; b=nGL72+WFLU63AqbAknEf27XbUI5ad+Ty8n6owF6yqJR4XdQO7UrWV4yH5j7x6wtYJO9kOwtTDWWjAPEy47mb2UDPcq7kDd2+M0HVhuPolWnk5GkLI3LGLk93LnYr0Hr6htskhuDsphWdfcw1Sp+Tkh3XTnRjigy+iZ6rXxaHdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971891; c=relaxed/simple;
	bh=Zsika3g/Zy3xIx00hNxgtdqSpL5h6d5MwDR0Di1hJY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4CHydZTU5X/3Gl913s5TpTNl31hmIlk+svBzG55zGHi5PvRzb/6qfQL7I57EMFbHKRxUVCSxyQ/pb0etm9+harVSOkIXwI+QjgyiDy/roTdgd6lTYwQ9/zVvCJnymk/exva+MOZpVFJNSZP/EE8E5Gf8hx7CAPdXYn71EfzEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kl8DKhsc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeKOcAJD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kl8DKhsc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeKOcAJD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96DD62540170;
	Tue, 29 Apr 2025 20:11:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 29 Apr 2025 20:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745971887; x=1746058287; bh=J7NBe0jTWX
	LKSA9x5Bl6001sYdSI+7y4o3jGxiP616o=; b=Kl8DKhscOQV/qRITuwKA28VdUs
	77bEkHyxspLfrQxa1yxbpCSZrG1qPDLJpZMxAo/6loTnPM+VBunxNk5u8F8bWCjc
	s/rJwbMBFV7hm1Bj1T0PoOALUpXiBbm8N7v6cvaFT9yna/WFE1+X4ZEFP3rR/EM8
	67zMJidOqGq3pLR5jdZRI8fOxcwuNVKj8RIgFjHmfGn837Hhzw4X3SQZf2qpGWeE
	9vNGM902vebN8fa0gQMlaT1o7uaRdFMFkKZ2yj1/DuE6igGa4RQ3Xwdh9VS3DVxW
	wEzt6B+5w/DVlRdGeQffGruTEvrdS5iQdiWpY8H5bp4TW9Lo+hRORwKOYx7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745971887; x=1746058287; bh=J7NBe0jTWXLKSA9x5Bl6001sYdSI+7y4o3j
	GxiP616o=; b=ZeKOcAJD/FRTHZvh21YJq9RkE09y+rg28OE5X/HuWsyqu65zpik
	TD0y32ttNRLsIXL11b7N84pxL/nb1PM/CdiKWsg9nezJ6dx7VSurYzS+346TCmdK
	djW7acYWWXpBYp85gL1EWrhwlAmb8QEsE0XNKBtNXLrp+lnIy4a2rXppjA4PIl/h
	xdCmdINxB8n+ck8YVA+88PIxUPelA4KVqUWDTnwwUAwaNO9n64jvA0bEBk9amCXA
	JacvRwepo2cEM2OSJqa8cKbtrGy71zskyOvA8z2a9F+ntyGMKjkA/87hdUutCHsd
	56Uj5J4aJHOStVX9zc6UxGNKEO8GHhoe6/A==
X-ME-Sender: <xms:r2oRaGuLgo-LlcxkONSRNFhd_UeJapaf4YyNdr8fEq5viaGAR_hORw>
    <xme:r2oRaLeacfyWtVmSNnJL1Wjrw9GTzyI55OdPmazqxWIa6YD6SbDtvo1-THUlvUTRG
    _VOqsQA7CEJvjqOVQ>
X-ME-Received: <xmr:r2oRaByic9ezmB6JRfFSCqJaq6uPLT8sYpwcEmWLlm09YmIJanoNZOdm2EplzT4O5GyVmbuTVg0EUwzPbRqGdQKNBQ7xH-OWLI4l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgroheskhhlvg
    hrkhhsrdgsihiipdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:r2oRaBOalJ70x8dDV5fRd2paIsbuVoaEGtiEFdKtcvIE07u8_ZnXog>
    <xmx:r2oRaG9wesdY-pXVDUDrXgGqSQ9tCTggcEFDWE7dunFHKHiIha8W8g>
    <xmx:r2oRaJU1YFnN8e6QqwIBSJ4capItKaYWJVWYtR4W9B2kwy8E0OcNvg>
    <xmx:r2oRaPc_FIwg9QUeoh0FThRuZkcQgxoRbhNRfjeF11keHXCapu1lIg>
    <xmx:r2oRaNJTM4ifEyC8YUv7dOlRCU3NFviPvZbTfK2xTX8Ulgw8NUt2z0eb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 20:11:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tao Klerks <tao@klerks.biz>
Cc: Patrick Steinhardt <ps@pks.im>,  Tao Klerks via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] replace-refs: fix support of qualified replace ref paths
In-Reply-To: <CAPMMpohgEXVPHKCQtvc-zLC35qtY+qJ9WgQO_quOgUG01eyTOw@mail.gmail.com>
	(Tao Klerks's message of "Tue, 29 Apr 2025 21:35:52 +0200")
References: <pull.1903.git.1745651452869.gitgitgadget@gmail.com>
	<aBCt8YrqJ7IM0ld6@pks.im> <xmqqh6266c1c.fsf@gitster.g>
	<CAPMMpohgEXVPHKCQtvc-zLC35qtY+qJ9WgQO_quOgUG01eyTOw@mail.gmail.com>
Date: Tue, 29 Apr 2025 17:11:25 -0700
Message-ID: <xmqqselq33v6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tao Klerks <tao@klerks.biz> writes:

> This is already accounted for with a hard error: If you end up with
> duplicate replace ref targets, many operations fail with a clear
> error. Clean up your replace refs and you're off to the races again.

OK.  As long as that safety is there, I offhand see no more reason
to forbid it.  As you said, it can lead to a useful use case.
