Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3921A459
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594430; cv=none; b=UlTNezp0BU2BQ0PJY9WUA6QJdoFED+73rzmNNhX9TndKhvA4N5bqMOCqd+0Zw/v0SPLRvMn0rjmU3qMf71/WMMMptq4l7elWttuixrFnQiu32pl8Kv6ervrb8vUiIAo/HujzKr6WE1LsNnvHpyHSjR9f3MK/oBbG3fFaTvOUFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594430; c=relaxed/simple;
	bh=TL+D4Rvy8YXZOYjZdR0yRRT6i3ieRjsrxiDFsl2ruso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OonDsUPlRZXf1RvdmrW0vIDR8aH6ZxLCd8xjKLujxt2fE0tEMp6mvIr9f1v890vZse9O7tFgiIPu6DLHE2SToyoPtwPthJEJYE5dnCy5Nxd+PBaGuRIF0X6g1TGE6Ete1yPBuPLaENs7OWLI8w6hKM2GG9gM1BampfB2ibXT7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MFxCtcA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jm+hqPqJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MFxCtcA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jm+hqPqJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 659331140265;
	Fri, 25 Apr 2025 11:20:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 11:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745594427; x=1745680827; bh=TL+D4Rvy8Y
	XZOYjZdR0yRRT6i3ieRjsrxiDFsl2ruso=; b=MFxCtcA23Sd5fDex1Jq3GY/mDR
	9YhHqz7Ck1Kyf/s2/CUZvTbZaXOdyB7XD1Yiykd40lbHV6YDIeMURRS3XNu3PHLS
	q2ytDC3ZWGLM8NpedN7RvFj1fqc44RUz16BOi1lAYqBwAnZQlp/XzfjZ+Ta0IzQs
	DbdUZP7E/tASCe8S1ackeLFCIxTwF5K2U7xAhV1ReENHED4ZBHF/9BsJ7TG5Uf6B
	xB3p9/KiknL73x1XjLlazEU7xdDfHUtaPR/ynddO/uRsgWJMUEdE12jcjc+zgyYk
	7z6S/HpKqLftO2zdxw94g7pcDRQRjLmmH+KrjTiKhIVHvm6ABYwqy/vf7yqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745594427; x=1745680827; bh=TL+D4Rvy8YXZOYjZdR0yRRT6i3ieRjsrxiD
	Fsl2ruso=; b=Jm+hqPqJDPROApwedJ/trAWWpZtC3EwkCUa0+IViiH52aPo1yCu
	9vN5YwVnuMLhQORK9a0vw6HvpJ6x0s1TQVMFJWBhzf19f+ZpBcv6bWFLjWNjNUuG
	laX+fCCWtjekZV4j5rF+ndz59lQ6XPnFzg8FawygtK+5zcah59PPcobNCGgA9KfX
	sIog7a4iYC6HfjLnRTEqes3J8GYir8Bo6XEiVmjsqVvhpWP3bt+eCLj4pNGfFJ9v
	Zw5FbTAeQhR0NZd9a7VWEET/CHeQJGNDy/0Vms3QFQ4b9ZY8d6gfGaQNK7inxOBC
	nL9JZXgTLbXgf2CYpMm+ip11ySFwpZmJiBA==
X-ME-Sender: <xms:O6gLaIVeTtPSWI4xL930WMAkk4CUyHW3YEnD0pGLzySEBSlTxr9g3g>
    <xme:O6gLaMnY2yFrBi_gkjwntWYj0p18yDRRPzdkUnwCKAMGOs0ehQnD2obUG0PI7vjcC
    M4YbDFnXnyL7WpIrg>
X-ME-Received: <xmr:O6gLaMY7DA6sL4Cb4fAwEKdF0pw20a9Tfa7zSV9Mdc7wa3WPkMxNnkhxbsJjkbHf13F8NMQiWMYOwGNE-Th73HilsfciM9qCWLsW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dutdekjedukeehgfetkefhudegleduteeljeefkeefffffgffhvdetieelheefleenucff
    ohhmrghinhepvggtlhhiphhsvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O6gLaHXDVAzDLhTrQnYM9lTmxGEMk-xRL8oUu5_2Cne1_eQlE35Tpw>
    <xmx:O6gLaCkb0klhmLUx_id-tHgZ5m9_vIadiMbBhv1WjQRIO0NeGIGVYA>
    <xmx:O6gLaMcCj0vi_Aba_XNupYnbcT0px0_0qF_vN7D1Q1hLM9NDxhUOiQ>
    <xmx:O6gLaEGKdDyjCYFtXxKcU6Oi43xAOEi0uPYP0FLnB3q-c_GivovvsQ>
    <xmx:O6gLaMS5Oc_TuNAt_gtHtiyVSJJ_QLyl0P9nicB6w9Sqb6xCIkZcKEs_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 11:20:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: repo.eclipse.org outage breaking all our linux CI jobs
In-Reply-To: <aAui8hrhm1qAxGcU@ArchLinux> (shejialuo@gmail.com's message of
	"Fri, 25 Apr 2025 22:57:54 +0800")
References: <xmqqfrhxtdg9.fsf@gitster.g> <aAui8hrhm1qAxGcU@ArchLinux>
Date: Fri, 25 Apr 2025 08:20:25 -0700
Message-ID: <xmqqikmsuv2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> I want to know whether we should use the "cache" mechanism of CI for
> these third-party softwares? I somehow feel strange that we would
> download these softwares in every CI.

It also feels wasteful to me that the CI jobs need to do a full
install-dependencies.sh over and over, instead of running it once
(per platform type), dumping the state, and let all the other jobs
on the same platform type to restart from that state ;-).
