Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62B41760
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634162; cv=none; b=K26KDji1w0cF/+fn6p0Bu1MCMGHz7NX6Vb+g3xqSKeVPTCJAxoBIJUgmjY7Ak2N2zfwulYvcDesCCVRTO0EeStwy2YKwPdtz1tCYMAgenxUPibDqVx2E+HNvXFdIyXRszQrdI4FFqb0D04LC28Q3J4XCYtF1nXcGFlD9IOsNacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634162; c=relaxed/simple;
	bh=qDGHCGENF09ZgVWV4VgWhD64l7NyLXIr177LtVpxbs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ewxqy3j7sqnKFtRQQQA8yyQ83qp6lbkoY5vfs3jWGZggbfgdAlPbttqNS5P4fn6XVFsjlRuxzboOxk3Ndhphouc/3DuR+mnOcW+RHj2J4C+6AsHFYCml2YFfY87URjyOLZ5aj5X1DgBJXrHDjNNp6+TIzIdzkdNsvAPGiNtv+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oZA0RXsr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zv6W4LOk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oZA0RXsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zv6W4LOk"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 040C0254012F;
	Thu, 19 Dec 2024 13:49:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 19 Dec 2024 13:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734634158; x=1734720558; bh=jdyVeLY5PP
	iVWEMPdSLFRQw8VEvtFoUgnat8NwZ5t04=; b=oZA0RXsrAkv7caOFk2qyCi5AsA
	OxTtSebmTanQ0RDXk6bPH9KgjjPRYvW8o62BNV2r55pN207aIwqXtXjcT8i0Uy7b
	XW+9xwBu/x4jTl1C+o0ZfESd+KP+oKl9LNq6IzcDvRDG0SD4fbVupIxP+W9zHVkM
	pxkmggA2sgSZmJ1FobNYC3wEThMcpNFdbw8Ms3wigzGuZut+MEhiXT/sWb/3uF6f
	nZspbNJwrfIAXztEH2bj0h/m31MW4Zkfm4K8h0htPBroMl6JUTl5arFgo/gPzgyP
	LgjdUfeqqLQHHA4zo5e/CLx12U/En3GxFYkk8vv8eTOeHAwKZgnRg6mMg4kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734634158; x=1734720558; bh=jdyVeLY5PPiVWEMPdSLFRQw8VEvtFoUgnat
	8NwZ5t04=; b=zv6W4LOknCuIZgCR3amua9UDoAEYiglEiDuxQOSY1NIXcRE/fBl
	3hoebQwUbzXlaOpiPTtTpUrpaDoynzxONR+8I/yB9R18d0+xQS3rzEBHa3hmqWep
	BgpoWOrQEprvKpT6No2mE335fsWa2HdiiRUx7ijX5mLTxRDh6XDDeGCnAj4xTI03
	wSMJ+AjSVaQDHRGZCbAEV99QBIXsnww6seYlYDNw4AQZY/86Vm0xibC1zqZXRQ5F
	MRtUjDPgS2vdZJBFHYtGo0Go2oZOhuy+D6H0lNneaw3qzKn7KzXT+ZvyBgKezKdM
	EfO9FHJboB1LW4LyUC++deDye+VfUaYWgUQ==
X-ME-Sender: <xms:rmpkZ0Sl0Kvv27UmgywICZiyQfuMZ8zPNE9jwbeCAqOXmxh2lstzhQ>
    <xme:rmpkZxyS9zah6hBs9CKEoD22aoV1rtNZtJ94_oXZ5kmEVT2NmF5HtKQH_aJncs7bX
    bQA_xBG_J__xWTatQ>
X-ME-Received: <xmr:rmpkZx223sXR_NjxB2BCs4JJ3lbuqDx8BSHlB6hnWxcb8vajZ81yDA4C_oZkoEGqFOc4oqImqk-7NJLd8-7DFCw5zf9_8QLTbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rmpkZ4AEEaVEa-bwqGjzHIFcY3zbGuSaHX-3ATPOuC539KSP00iQQw>
    <xmx:rmpkZ9iujfQUPw39QE-FkhIVcJWB9bnlXCwTyiNj0textTrT-92jHA>
    <xmx:rmpkZ0oecGsMM-oU492NlOfh5_Upgte87gFdUumEQQ2Wq3qKkGhxlg>
    <xmx:rmpkZwjzyAQuaqOu8GyBhCAq1_M9MF7azD6tHXi4bT2XGHepOrF7ew>
    <xmx:rmpkZ7ZNgWFAiPLI1KNyKs7I8YFdVxAmsch8-wA9W49L3iMHHZADTYll>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 13:49:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Dec 2024 16:53:36 +0100")
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
	<20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
Date: Thu, 19 Dec 2024 10:49:17 -0800
Message-ID: <xmqq8qsbik42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> worked somewhat by chance, only: ...
>
> But that subtle mechanism broke with 4838deab65 (Makefile: refactor
> GIT-VERSION-GEN to be reusable, 2024-12-06) and subsequent commits

With such a nice analysis, it does not look like it was "by chance"
working, though ;-)  And ...

> because the version information is not propagated via the Makefile
> variable anymore, but instead via the files that `GIT-VERSION-GEN`
> started to write. And as the script never knew about the `GIT_VERSION`
> environment variable in the first place it uses one of the values listed
> above instead of the overridden value.
>
> Fix this issue by making `GIT-VERSION-GEN` handle the case where
> `GIT_VERSION` has been set via the environment.

... the "fix" sounds very much the logical and only correct
solution.

Thanks, queued.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  GIT-VERSION-GEN | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index de0e63bdfbac263884e2ea328cc2ef11ace7a238..787c6cfd04f0a43d0c1c8a6690185d26ccf2fc2f 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -29,7 +29,10 @@ export GIT_CEILING_DIRECTORIES
>  
>  # First see if there is a version file (included in release tarballs),
>  # then try git-describe, then default.
> -if test -f "$SOURCE_DIR"/version
> +if test -n "$GIT_VERSION"
> +then
> +    VN="$GIT_VERSION"
> +elif test -f "$SOURCE_DIR"/version
>  then
>  	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
>  elif {
