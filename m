Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4231350FD
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531755; cv=none; b=Ow1HwxPWyR2vUmR5k3BRmVai7Vu8WAHMPpoYVM/VtxO3KAGRbuSbegc8oIiGebxVes+HiQigyrG77M8qUtr2+12y1OYhvTqdiAgo4khuJsNz8H7I0n7rTcCYq7cetyb9kwwFba5kE6KDVkQHyC2N+hWruxBrhPsdCCMzkF/Op34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531755; c=relaxed/simple;
	bh=N0hDOCofigLJzF6B4pLQ8NycZwnxFzR/vebIIg6jk3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3A5HrtULH29iwi7ztQ+j+yetPNGpcjYoF8TW5eJcK2CFhVvk+3yP1NfZmRt7z5JAWS7gpaKQMsQcIAxXCuXZJuspYSyAu6tXOFZesKoWEk1Rbb26Ktw1d/02alinl2vc6rTg/AHDp9HyAk1Z+0C5QbBdx7en0SY6YMvbxzruXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=RLbFa5N/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7Z4c7yf; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="RLbFa5N/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7Z4c7yf"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 057BD1800122;
	Tue,  4 Jun 2024 16:09:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 16:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717531752;
	 x=1717618152; bh=KmvIvVcnNIHNc/Wqo+u/b5Cicvn4Gyn/CZF96inf0N8=; b=
	RLbFa5N/d1RCDft8GMArJQy+8HcZOIMs9uGjSkCSzEbw58Z4M57FcqZvpA5gMWuc
	JRWDwrLyNZ9Rd9LZCFR6ZI9eWCy39tzAEAHqUfZjX/fJv9bsTn8Y/ouXh1kS74xM
	cojL7Vrd0HQS5aTByNho/dF4qSfLltwnLFal57wqo/7oAujb90KbnGVj7jVRVUFo
	hrEXmhhH7OjoGxyVW5GY8Ij535lrKejgOhME+8SYKJRvglj1QDY2dcU2UOGPy9QR
	i3FEZEZ8eRkV1Mrsi/hia+US47q/pxd6mxuifgx738gUgtXH6D5DEDS5TvgFXcb2
	+jzMHkx4WP6rhAipHtussw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717531752; x=
	1717618152; bh=KmvIvVcnNIHNc/Wqo+u/b5Cicvn4Gyn/CZF96inf0N8=; b=h
	7Z4c7yfgHd7cclUsUPT/wD+Q4u2e8Mz+77yREIJWcMypXsF7lRJyw3s0FZIxAtvp
	DxKw+Ts5QUmdT21vbb6owG2gf+pfRmUcTqR3Z7K3E1QOkTqG880WC34EmjSl3wfy
	isk9p2ncjpIZioBa2PzIPItd8jJ1ySzuSA4jVT6OIJxYVaLS5xfJVY5f7NG+Qu8j
	9p56mn7S35+qx1n7wYJ4t8o9oVKUWwdx7Y0HzJE9QsS4lUPJqY25phpZrn1/Ai6l
	zQxFO/Sf612PKrmNNL9L5C5aGU7IejgHFEmRlM1/OuQAigIr3+lyGHYWvzdQT5Uk
	MmgUfEvxd6618r836jdGA==
X-ME-Sender: <xms:aHRfZj4zTuHA0RFeFjh3ulE7D5doMcjvBWLddlmAyW-cNOsqAWLItA>
    <xme:aHRfZo6hc3lBMpd7hVEwni8GzJ3pe47etHhgpIsDJk5UJ4evXnWliXyH88uvo2GDn
    -6CLuZVWOI>
X-ME-Received: <xmr:aHRfZqe1qaNBEbExD6EJNSdOfvGsLLZ8X6xNGNVGP74Sss6eEe6RgXrUXEd7BvSklcNXtvB65Us4SzD5Uoi3Z-Lq4qQx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgse
    htjeertddtfeejnecuhfhrohhmpefhrhgvugcunfhonhhguceofhhrvggupghlohhnghes
    fhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhephefhffeuteekvefgkeefge
    etteffvedtvefhfefgjeevlefhleeivefhhfegjeetnecuffhomhgrihhnpehpvghffhdq
    rghtqdhpvghffhdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehfrhgvuggplhhonhhgsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:aHRfZkLOTbUftkqJFbdu81u_dzThjmDcxXR5rKuf-Nw5zpOCI2ZyBw>
    <xmx:aHRfZnLii7ZIPje7F1xBk6HXdAEL8jG4Sx-SAWv3DHIcrDWWapE1mA>
    <xmx:aHRfZtxyAIUZP3r0bWLM4UTudD3DYiCXbqocoJx1m6ssLBpMAZ8rfA>
    <xmx:aHRfZjIh0CUm6HDO_td88AfcHw4fyiZGLJ-bEyoWLp1KYgiw35SsQg>
    <xmx:aHRfZkHknVM-ECPtDVrQPZlNq06Oo9rLXBDNUC_Ph_QHvETlz1B3RdK4>
Feedback-ID: i08fc41ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 16:09:11 -0400 (EDT)
Message-ID: <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
Date: Tue, 4 Jun 2024 13:09:10 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: git fetch --prune fails with "fatal: bad object"
Content-Language: en-US
To: "Jeff King peff-at-peff.net |git bugs/Example Allow|"
 <y8yky0v9l5xb0yt@sneakemail.com>, Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g> <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
From: Fred Long <fred_long@fastmail.fm>
In-Reply-To: <20240604104437.GD1781455@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2024 3:44 AM, Jeff King peff-at-peff.net |git bugs/Example Allow| 
wrote:
> In the case of a refs/remotes entry where you happen to know that you
> could re-clone from the other side, it is relatively low stakes. But I
> think keeping a human brain in the loop between corruption and deletion
> is a good thing. Corruption should not be happening so often that it's a
> major pain point.
In my case it's not corruption. It's people creating branches, deleting 
them, and then removing the commits. (Maybe our git server has an option 
to automatically prune commits that are not reachable from a branch or 
tag, I don't know.) But this happens very frequently at my work.

