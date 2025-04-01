Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0991E5B7E
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500840; cv=none; b=bidBhBNiEN93Wih7ydscx0Os417uh26lY/k8EahAmu8NK9cadAeG1bp7MBOTGZWLF3E+E810A1DOgfFHo4b97WD+mde0ZFUd1tYidIrCjwSXfei2SGVoJiQVar41/f7J/s85arubJ9+j7yRSqweTDA9LZ+1Gu3q/AKlNpKqkDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500840; c=relaxed/simple;
	bh=1VCvZ6rRxdT0gFpprDyvWrft0yethVzz4QFQh2Y03CE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sh964XcGdKc/U76NgxX1paT8KJL3426uyfDxzzB9YpPHstGxdJLA+nPHEgFZK78GAFIwIM2ezpyS85CD/Ct4/9WOrOj6hQFHHFr5PE548Ky1tSfYRA7RkVa11X2ERQGWg68Mwd4PmFPX8dzYQxkEA87JFwVxCMGPHr5X7VX7wFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bbMVt8lO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=enxxfeCb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bbMVt8lO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enxxfeCb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B7EEF11400A1;
	Tue,  1 Apr 2025 05:47:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 01 Apr 2025 05:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743500836; x=1743587236; bh=1VCvZ6rRxd
	T0gFpprDyvWrft0yethVzz4QFQh2Y03CE=; b=bbMVt8lO0hnI0L2jwSQPCh45oj
	N7s9IMNSgc/ukxF/YfNv7iwFLJabpvWNpkEwFkbZjlAgUBKYMuTnsrFGDFDMJePS
	Z6j7foXPPa/+Pt8sUdfcpIaKIX/QMlf7rcfyRSOq+pWJatXnlkff5xlwGKgXT2lB
	ezdoiGYJRU4DCvtWjIRRYRKQ4NC+zVcQ9So3g+z04PekDJqoaSPsA1zaZjKg30wP
	uSqBcSf1K2Q+TF0BUdg9gTYPy4j6gqqiHxGEXAsk55lN+86Q9Rx14ZAGjyiTANjv
	1KP99j0x01TEq3b9ND5H5AJQXhYvRfarnBuK8OmJseXXISA1blVu1rLLpPUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743500836; x=1743587236; bh=1VCvZ6rRxdT0gFpprDyvWrft0yethVzz4QF
	Qh2Y03CE=; b=enxxfeCbCM05/+4QnaijtXhNIu7Vs1qnOeLI2Mu69ErBD8LyJuI
	0siCyAUZ6bItxyUjDTZy2P0zY48sRP1SJoMf7fbaifLGVXtpw13izIcXfbPb3OFq
	wlN8jdyRkC1y/eiT0LXRm7NoafQNNi87yDRHwnxp5RU6YbT09ZwYx50MF5Fr5x/G
	MoZ+ku9emLNC4F0f8g1/Gq2WWstabr/D+V/j/n2Quz1s7nT7VjGtfmmYiZ6JYiJ8
	qRbqdfWqKRJtk+WdoCteZHqJ18R2OU8JhsPvre1sWubpwiSponCu9NFW8wEk2zY8
	Pw5Si4OCv174eJLXtbvGZJEToPFJdjnSA9Q==
X-ME-Sender: <xms:JLbrZ_1HqQ7W46AJIcSh8KPvenSqKGHr8mX6HMN3Ikj_1GoITXeyTw>
    <xme:JLbrZ-EQ818V4_vwfnXg5U3eh9429c6J3Jz39b9dSpD1yJcxgeTQXH1gJSyjA2xD-
    6z942F_8SbpclpI1Q>
X-ME-Received: <xmr:JLbrZ_6tdOBihcc_sB7GPWUMNPPn9U-yvX5wFRMvKB8XsaOTvj9lBc3Yad2LElJTIeb2Xv_aHtDcQlM36LAyZLiUuaCC4cj0WsloOIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:JLbrZ021C1XywYbdg4xuw3Kk5FyE0ae4LA36qOU0elUyE_wMxuPn8Q>
    <xmx:JLbrZyEkH-DNGJCR-3I222PaaNYzu8mMcrUFgm976KGnQ0UM8JEOCg>
    <xmx:JLbrZ1-kCtVIUrDrr9-QLVS4XYVYtwTQ1Ud1a0gWHW5srQFvtozpaQ>
    <xmx:JLbrZ_nnZqFpvUHPzFFy9c4TkO5GJmMbRYkUcynGVMtnzXguqZps0w>
    <xmx:JLbrZ_O0-0S834YxyKXSh11eMteQQMNslvrrWPV9eruSclz_pqEn2N_f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 05:47:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com
Subject: Re: [PATCH 1/2] help: include SHA implementation in version info
In-Reply-To: <Z-pCG9d7Rf9SMuXJ@pks.im> (Patrick Steinhardt's message of "Mon,
	31 Mar 2025 09:19:55 +0200")
References: <20250328170121.157563-1-jltobler@gmail.com>
	<20250328170121.157563-2-jltobler@gmail.com>
	<xmqq8qoodq5u.fsf@gitster.g> <Z-pCG9d7Rf9SMuXJ@pks.im>
Date: Tue, 01 Apr 2025 02:47:14 -0700
Message-ID: <xmqq1pucb4d9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Another option: we could ask the implementations themselves to define a
> symbol `SHA1_BACKEND` and use it here. This would automatically ensure
> that any implementation must define the symbol as we'd otherwise get a
> compile error. We could also conditionally define `SHA1_UNSAFE_BACKEND`
> depending on whether or not we have it.

Much simpler and less error prone.
