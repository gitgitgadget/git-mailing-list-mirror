Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2534A35
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700075; cv=none; b=Hcta9HJriUrawse80BpI5vsTps6Ly/bTBxLA0tg5b+mztCdwb1+zzOTa6kxO4hrKp8uxwl1VlltIxDliY99Yx0lzrOGWU72UK1szsMIdFR5i206D5+CMulyv4RdUYUFaEcYr0D4AvdBjgAGYfvDLwFSPxV3ohlZc+LjkiElhBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700075; c=relaxed/simple;
	bh=pqRk8R9ommVZYIEmmo7mz1+iow/ZMZa0Pw+dF114GLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6vs8H3KCTnGW54GBQMnz7Ae+IYAUSrCc5rwrqNUCrkvJLc2MHvZgxBQGkX1uKMNQPaLf4yqVYUhktVXA8rZDzoLhoIX+pT4vbd82eCcxW+ExioIhlS5/hrb7PWChSgT7Hs1EHTpqEWLiozRfE5ebCKVv5MBNr75UyLeIhCB6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s701yNEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbObSVEA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s701yNEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbObSVEA"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B973111401CA;
	Wed, 11 Jun 2025 23:47:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Jun 2025 23:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749700071; x=1749786471; bh=uoLjf8sJLB
	RFuQoCdVYyYTfdrIZDnVx6BXspReQaJSs=; b=s701yNECqHNNjGkEBnrmhadCEk
	ZFGis5F0dCNXAjJXe1prrWdolA1UqESFrPFyYJq9d0jP3vaSN3UAeMfblK75MCN1
	BJ7eo8Bav+z2i3YT7iLKNCi/ZRi7joSke2E6wVa31ptWftTZ6LZHDoqwbkXcWd12
	ZMLeOQEJ+9ogGMLFzZ5dA3G9Qbun57XdVa6B/RlQBD8LLA5gPo+2gC/jIGy71smS
	JVkabjVmjayoVQka2QnhZIr+QZr7UkrHk3azXQKULfg/THg+j6xdakcWpsC/s18O
	pnwEAHbTDNwkUlYg35U1qS9Enp8eoYLVk67HVkVPv2Els7FLJbg5vZ/yebsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749700071; x=1749786471; bh=uoLjf8sJLBRFuQoCdVYyYTfdrIZDnVx6BXs
	pReQaJSs=; b=jbObSVEAaTSccOcfUuDliRJ00EKS4p5G5jJgdcI4r5ZQxnrUY7f
	kw+RFLJpGAUTzoTx9Mj5HzF+5Tbo1aBPxPEBhdyqwaKCkPLLkpnWK5HC6le/pQ/e
	HtSaVi+UMTA+TLYru/9TfbKb0WK8kcMCZ+PFf8rvY70wmAlTn0K8fqWjxlyiMnqy
	AFKWFBB8ex+XwEgy9iXlZwaWWRcltCN/4KppgFtyRX4iew7Yba27NSNxtiPWOtWQ
	iO9GYmSz/+G7hQ711QcEdne3NUoAJ4cT/zkEfQiPN76xYVC7CCO/4y6tP1M0A3xE
	DWSsM6ESll8z2Zx0L7QL4S+k9SeveSiLQpg==
X-ME-Sender: <xms:501KaJFywbNwE-Np6yuxRTEfN8qeWuhE2jacWkNl5o1ZxAYjI-3qxA>
    <xme:501KaOUp7vklh1rOyXm61uITbOlPxzJOWpThSmQzqSkzTb-DCQSe1NINPw5KIu_pc
    JJhEiMUUrD4LSJBeg>
X-ME-Received: <xmr:501KaLLsh5DXcU-HhMpTk7y0Fv2eRJIRW6VKVutBU1RUBnj93B-x-XIaOJUhxkFBhDIoB10HE1SKCBEFwlALO2RdXGzpClnEsZIy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddugedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgrugestghomh
    hsthihlhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:501KaPEfg30wDWvbcRhELh-bf7UynxXd-A06O2OXpcTrAKdnMI21_A>
    <xmx:501KaPXj9uuZh-9KKjkKDgq9a4OIjIHXl9MU_GKxk1jbNDJ95ygWtw>
    <xmx:501KaKPJr2WIYBzqJNi5wZlFd-I8p7U5UTnDLouJlNFRf2I-fdgUgA>
    <xmx:501KaO3d4ulJREdxIqBELziCdpwiRCFPxRewTAq2536mP6B0T6RMPg>
    <xmx:501KaNrQIiK91vmNeInMqwyxzV6n38CRBO29l4ci4hGa8FOtWGGoGN8S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 23:47:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: update settings for FreeBSD
In-Reply-To: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com> (Brad Smith's message
	of "Wed, 11 Jun 2025 23:13:33 -0400")
References: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com>
Date: Wed, 11 Jun 2025 20:47:49 -0700
Message-ID: <xmqqsek5fwnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

> FreeBSD 6.0 has memmem().

And anything older than that no longer matters?  

That may indeed be true (6.0 was from Nov 2005), but if that is the
reason why we simply lose NO_MEMMEM (instead of conditionally losing
for 6.0 and newer), that needs to be explained in the proposed log
message, together with the reason why we no longer do anything
special with version "4.x" (which could be "We ditch the support for
anything older than 6.0").

Assuming that our stance is "anything older than 6.0 no longer
matters", the patch itself looks good.

> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  config.mak.uname | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index b1c5c4d5e8..da592eeaa0 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -302,16 +302,10 @@ ifeq ($(uname_S),FreeBSD)
>          ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
>  		OLD_ICONV = YesPlease
>          endif
> -	NO_MEMMEM = YesPlease
>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
>  	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>  	USE_ST_TIMESPEC = YesPlease
> -        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
> -		PTHREAD_LIBS = -pthread
> -		NO_UINTMAX_T = YesPlease
> -		NO_STRTOUMAX = YesPlease
> -        endif
>  	PYTHON_PATH = /usr/local/bin/python
>  	PERL_PATH = /usr/local/bin/perl
>  	HAVE_PATHS_H = YesPlease
