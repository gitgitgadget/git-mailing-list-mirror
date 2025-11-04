Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4D33890C
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281636; cv=none; b=J7Li6SxxGaOeYm3OWTrLs2PiVSk3BnXWnohZqdks0OI2sM2A3y+7YwB+AM9yAWLQp1ZB7bP92PW7kZY8/GERxN7dTxIiykNXUb+WnfZyq4hfiKZukv1We0yOcutRdjYUP3wxZlW7wJLmK8BXOvTZvTEnkv6sF4M4j1Nkfzzg+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281636; c=relaxed/simple;
	bh=dr/nG6+BdWEfw0DsqxfkAHqNXbwXgSz31HJ0luJSnl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlpvtCzM47sLDiLG3acdFE7VB5ERs/VWBnjJds275lk9TCgABCa719YvFlrFCok1bMJo8BW1RLEveLZkwkkpK+pwQq0K2fEcIjISy+o6uMyXRlkQXqfMDbrKJYdBK+kXPsp8cflCXHhCPOj86ymCnG/qFWQbqAVyvwma5xOk848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JcaJIENk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rHihxkpS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JcaJIENk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rHihxkpS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83E1414001DD;
	Tue,  4 Nov 2025 13:40:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 13:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762281633;
	 x=1762368033; bh=hJglg/OSbkWgKd2X1VPqVZQLWBQhZKouZ5SfG7dH0cM=; b=
	JcaJIENkwbg7vPWUiUkOnnEF4lT5B7dUVfj61qzf9EGBey/vbvcS+D8UJqsdAz1q
	EZRF+caNumeGImNMDzhcMF5ZbjiKVOysPscimzH7rPUDkKj3M91aRneEWr08R7XA
	x17GpKxADxt6J2DcN1QrF8OhP+ZEKYCslLebCPwBelSvzb/EJC9QsTtUJaHXqe0J
	SzeEJmXySpK1oEEjd5cfr1BxoCPVtmOgkm3+EeljycVurTJJ6Gm2EOYbvjABqu6O
	svQNBKV/aSHh4O9HlYwnAlX8gmRFVURyc0M+uPAm7fhbwrY50DKKU7sSsRHKAhwf
	A3wxmJ7kY0lP8Xo3hDAsGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762281633; x=
	1762368033; bh=hJglg/OSbkWgKd2X1VPqVZQLWBQhZKouZ5SfG7dH0cM=; b=r
	HihxkpSQ/s3ZlNaALseUMTXmfQIJBgi9LTOdJWdMRzHhnN0DAS6vnVPMe7Z+Si8Z
	BWfOPxnkUVufeUySkpzvKypOsJimPNCXZMudC9dIFgMAdoa7ZwaRWJQJQkjPkddw
	7ZnYRN1LlRu5Gk9cfzz18SHy+Sp55vHbZUN6tzU+8fqO9IpxyCEsnFA7v3mqKaMN
	U7XFeROSCCPq8XyEtN3Ov5ZAIxYdT0Ac4rGd4EkGHCgcpqm9hiMYJ4xLcZMyYrbJ
	wJCsMoN6LzwwF/F24XC1Vzr2PCY97goi/V5bwIvW++dN1a3WEREIqIEtBLKbHAhn
	KyehKzWdltA3FoKdYTWJw==
X-ME-Sender: <xms:oUgKaSi1eBBtASRMe6_3IfZAxSY_z3jCkYxTnBfVfz-zvGMQsqMJRQ>
    <xme:oUgKaUg8qKxlKPt6B9sIOnbCY9cBBGmfQPrYQPMTqM-haP4b_2C_8t55x4gxZa7Hq
    PR5EJ22EloaVBTWev0N4a7mKL9YBNPrOJwlv84XYCNGpr7A81o5tg>
X-ME-Received: <xmr:oUgKaaIXQOGHIVJQQJFLCw_6jAcYK6C213u7UeOlKMa6LxpjzWEg1T1af0iPvYW4iDEBcSvGTzsUwk6ThQ4Fk-GQFfaYJLTiV9He>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehqjhgvshhsrgeiiedvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehush
    hmrghnrghkihhnhigvmhhisehgmhgrihhlrdgtohhmrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oUgKabH12cbBE4dx2z3uvJxNK_BeqIBtM_M7OzGXWmI7DYa50PgFaQ>
    <xmx:oUgKaWTq79BHfNq2tKP5krAxuphIy82FTA4roOLezzE2izIdBQFH5Q>
    <xmx:oUgKafflXUYZ5CAEj1sDlYIbf1NY3o-Ks5DWO-3m_2izXnjsbJmUNw>
    <xmx:oUgKadouDs0S7iL999V1hKKXaPN-8WyEsNRNFzbfkbvQOfUxe7JkLQ>
    <xmx:oUgKaXGSIOMJcAhieYlibiy-qdOO9PglrAR2dsxhyrrAYOCfCxEUA8_N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 13:40:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Queen Ediri Jessa <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi@gmail.com.com
Subject: Re: [PATCH v3] doc: clarify server behavior for invalid 'want'
 lines in HTTP protocol
In-Reply-To: <20251104155127.1079-1-qjessa662@gmail.com> (Queen Ediri Jessa's
	message of "Tue, 4 Nov 2025 16:51:27 +0100")
References: <20251104155127.1079-1-qjessa662@gmail.com>
Date: Tue, 04 Nov 2025 10:40:31 -0800
Message-ID: <xmqqjz05prog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Queen Ediri Jessa <qjessa662@gmail.com> writes:

> Update the documentation to clearly describe how the server responds when a
> client sends an invalid or malformed `want` line during the HTTP protocol
> exchange. This improves understanding of Git’s behavior when handling
> incorrect object requests and helps developers detect and handle such
> protocol issues accurately.
>
> Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
>
> ---
>
> Changes since v1:
> - Rephrased the explanation to be more concise and aligned with reviewer
>   feedback.
> - Clarified that the server includes the offending object name in its error
>   message.
> - Adjusted tone to describe the expected behavior rather than prescribing
>   implementation-specific messages.
> - Improved readability and technical consistency of the section.
>
>  Documentation/gitprotocol-http.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Perfect.  Hopefully your future contributions we won't have to worry
about these procedural issues.

> diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
> index d024010414..f3f48d3f35 100644
> --- a/Documentation/gitprotocol-http.adoc
> +++ b/Documentation/gitprotocol-http.adoc
> @@ -443,7 +443,10 @@ If no "want" objects are received, send an error:
>  TODO: Define error if no "want" lines are requested.
>  
>  If any "want" object is not reachable, send an error:
> -TODO: Define error if an invalid "want" is requested.
> +When a Git server receives an invalid or malformed `want` line, it
> +responds with an error message that includes the offending object name.
> +This clarifies the expected behavior for Git implementations and helps
> +clients detect protocol issues accurately during fetch operations.
>  
>  Create an empty list, `s_common`.

I am not sure what "This clarifies the expected behavior of Git
implementations" here, though.  Who exactly are "implementations"
that the clarification is given, and what are they expected to do in
response?  What does it really mean to detect "accurately" in this
case?  For a client that received this error, they know what they
sent as "want", and they are told that the other side does not like
that object name, but then what would they do after that?  The last
two lines invite more questions than it answers.  Perhaps we are
better off without them?  I dunno.

Thanks.

