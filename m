Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75513C47B
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220904; cv=none; b=e6E4jg5wiGlrkPzC6QfklTQjqQiW49uf9NCbWXjBzyJo8Izv5M9TxjMkCY4cI6TBGEjbN7VtWsghnJZ7/ZQEAPpwP6LAYVNMnwxbUyDMofLWKheNHO+oJx5lidaFj/+Bpc6KaL0SLqVseeVDdNCxzSVZkeJ0v2OxllPYFmyCm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220904; c=relaxed/simple;
	bh=rQNAnTpb90LOXyFKDQX96kLF/8COkzXueteJcbi01Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xi6B0AMfgUFaOcdpcpjjauRyJMgmy+zODCpe4AB/qF7gCIo0pIeIhQYmyv1WLhcDdJHX6f6W3qR/UAZscoUUBTIGCH2KYLENdKuJiqIFzX+E+MaAuv6WjEsj9U17x2emKggttZfs5/f1e5Y963lKQauGQ9l9nEG4wLIot0fp/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aZBOMHOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tv0VYKFq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aZBOMHOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tv0VYKFq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E339B140059A;
	Tue, 22 Jul 2025 17:48:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 22 Jul 2025 17:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753220900; x=1753307300; bh=KZEjfxLHaP
	hwfZYDXk3sNUnCVtOtxypbnDGv0bNs2QU=; b=aZBOMHOdKSe/dXyomQNovzbw7I
	MTBRfNNT82+aIRXq1wcL9gLWwnozXGAJ0OH8z6im9pHqIGaE4b307oZ+VdEMG75D
	dnJLi+u5YLpWjWdhpgPnv7zeSTd4+Oc7y/9s2Ys36AiovtrSZJczs71kxLyixHpR
	oIO2HtOujwuBqTvnyKX55bgpOjTLKMVX+iFm1RFmnP9FG/i/aTN4rb2MX+lunXby
	Br+wJzSwX0ZVKdHICrUP1wqsIMf+P6vJEZWUoQkRmQgnv7KEaGOiW+x552w3mPU6
	pvYx9CNRJEF4dRw0N+rxVQ2g4ZKGQI8+WJprPtGe5ZIy4iI3P713GHYbx8Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753220900; x=1753307300; bh=KZEjfxLHaPhwfZYDXk3sNUnCVtOtxypbnDG
	v0bNs2QU=; b=Tv0VYKFqMQOk6h1vA08Qk5twaWoCNzssbaYyxEd8C4J9vYfWFF6
	3OZKlixth70UollGOQJFirMbzCZ5peyac1rn4JcJMjU2ZEr6hctaqMdWsG3QXd8y
	GvISR0qI2cHDHGoj0HbmYyyC99Es5PlJn04S2NPXIyHy1T6V47FOGKfEYZQ8MqJr
	RCBsm1xn2bxUrOraF/KJxn/7RrII7VRDPWcPBuPwXaRRX0dtclhPQQMA4z1rLJvx
	oOFnhYM70ZQAln2CIxRf4FpE8bxgVri22xEVK/yJWO+jdaB5edj4C/iOOHFNN0j+
	5MJOjxwcmMwJOpku8yDO4jBmYlPB0SdunGw==
X-ME-Sender: <xms:JAeAaB98PfHE4gB94dOxbilfQOMyUpvehJ2FzqDtF0Mwlilqe_Sw7A>
    <xme:JAeAaI-7w3fHLsugZkBYgAB4lQVwFiDtgPtrDpI1dMHV52vmXfjNuNUQRsxSJ8ZHK
    cd7gOeQ5Qv6UfsVWw>
X-ME-Received: <xmr:JAeAaIfZd6sqkXFf_mjhuYthmAL7gCrkUfykUtFcnKlZyxDn8a-Ws4MwNZboBOcbm7d5kkxR0nKYjSeQbt5-QxAUmmUhXn015z5GLok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejiedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhhhiifkhgu
    vddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JAeAaBFkTLRYifLkXZOFXvCc_LhYEvc0tOayO0kuQh_ec6WMoVXCSg>
    <xmx:JAeAaGdiq26p5xL9jlI21_EW-LNNcuM990bQag9wtvmnx82piRHTxA>
    <xmx:JAeAaLF5KJDPX_axszD3SP2Lb0ZczMq_s0Zj1FK_6YVuWmmx7FPnrw>
    <xmx:JAeAaPWW6846lWsDUi0iKAnii1ZpGE4ngiefeSwcwKdgHxMENbb_XQ>
    <xmx:JAeAaNmYMclYjb7p9wNJuiksw8I01j-zPdylphnL4WT9XcmeZ-yFcyXc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 17:48:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] t/helper/test-truncate: close file descriptor
 after truncation
In-Reply-To: <20250722174102.1876197-2-lhywkd22@gmail.com> (Hoyoung Lee's
	message of "Tue, 22 Jul 2025 17:41:01 +0000")
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
	<20250722174102.1876197-2-lhywkd22@gmail.com>
Date: Tue, 22 Jul 2025 14:48:19 -0700
Message-ID: <xmqqqzy7rj6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hoyoung Lee <lhywkd22@gmail.com> writes:

> Fix a resource leak where the file descriptor was not closed after
> truncating a file in t/helper/test-truncate.c.
>
> Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
> ---
>  t/helper/test-truncate.c | 3 +++
>  1 file changed, 3 insertions(+)

While it is not wrong per-se, it is not like a function that can
potentially be called number of times returns without closing it.
Nobody other than the main() function would be calling this
function, so the only thing that is done after this function returns
to its caller is for the caller to return leading to exit from the
process at which point the leftover file descriptor would be
closed.

So I am a bit curious what triggered you to send in these changes.
Are there some automated resource leak checker, without fixes like
these whose output would be noisy with complaints about these "known
leaking, no ill effects in practice, yet gets flagged by checkers"
code to be useful, or something?

Will queue; thanks.

> diff --git a/t/helper/test-truncate.c b/t/helper/test-truncate.c
> index 3931deaec7..104bc36cc0 100644
> --- a/t/helper/test-truncate.c
> +++ b/t/helper/test-truncate.c
> @@ -21,5 +21,8 @@ int cmd__truncate(int argc, const char **argv)
>  
>  	if (ftruncate(fd, (off_t) sz) < 0)
>  		die_errno("failed to truncate file");
> +	
> +	close(fd);
> +
>  	return 0;
>  }
