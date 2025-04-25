Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D119DF48
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554781; cv=none; b=sJbcyWl2SmULDzw8cz/7RL7FLtMiuEuUpcnYogIiPfhuhaUmyV+zdS+QodEv9VXZ4lu7PNx42H+G8Cjy96Jx7M7MaP4t62b4RwTdMXAYMyQzexYcrvzaMzcG7ZMGaBBn+vJCBALQDuAIjyCOvhMphdTwdvpj9sISiO0I8brU3vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554781; c=relaxed/simple;
	bh=QHMIUaw9LWb8Sc7xOEMhKYH+YnCwayWMoWP073llDsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVIKzpNAuncLJGCkCaJDV5Ln7nYJMfLWy7a0mbrnVxHshUkrOKasvxYZMx8DzgmidH6GF53LYBgpj3U4OnYvoaelvnfb4z7ckNv/KxwwuNMnBvX18cAtO8CBx+LLLmCYxE6ezPwz3qAgozm1wouPbo7dz3YxBzNoCcxcSpuNpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DbUeR3d/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c6BhVgC5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DbUeR3d/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c6BhVgC5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C5A7114017C;
	Fri, 25 Apr 2025 00:19:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 25 Apr 2025 00:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745554777; x=1745641177; bh=L4b7XS46Iw
	byhMA1DOyc1bBZZP5R7ZONafsFuUKrAGw=; b=DbUeR3d/o8/Plsc1Ht9HlmrZmi
	3yzsKYnU7gM5gjPtgrhvCGSZBBKq7hpnCqRfhsv80rrFQbXUB6NG3JgwRYcCrdSQ
	cYwwZLwfoWEDLWdCZhc7JX/1+XgirTd4tTCM8YSJeiHX5sM8ERuvHyrO46pclraO
	JNPlsLEQNUu9XD9dSe0/rYvLiH9QlxucDGztYjpEEWlh9t9cb98q+YMAB0Yc64jf
	BrwOsTvpAB71SvWun0k88fpyThGkRgaN7TW80ITPD9iFsHzgYss8RBUxWBIydfF6
	6bJ4Re/eAoET5lh81Qyal+yJMpC8ejCVhTbV7lO8F3xddKyxieNvt+MwIXIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745554777; x=1745641177; bh=L4b7XS46IwbyhMA1DOyc1bBZZP5R7ZONafs
	FuUKrAGw=; b=c6BhVgC5HRK48Nt99cAHUpufdk818Yj+8AmAmSd8kclvQraFQLA
	qkJYudZ3q4YLo/mUE2+eV8JiYahEiQep8kl+oNyobtZsMdbNNNkZwd2XcMszvMxj
	6mbkQAuttIsO2xmNnmF3zmVqh/bz5367c4LaYgw3bv5rn1WIjWsdfeBWj8FBCqC7
	hdSQWeDnB3/+LWqTXiPLmNU5W4R/CJIz9qKB1auiTA7AK1rG/EDBEjIW4eISY1ws
	oOrTI+fly4ssQEKb8Ibl3WmP81PhxwKtLze9xkUNDpZ+GKO0kmAtiMlmV0XmvwYo
	/Rd86S6NXn/s0AMWDHVzR3WzMHgFn71zbLQ==
X-ME-Sender: <xms:WQ0LaDlbLPP6ZR7683dgSnODsEE2SIVo3Jyc4wVeGiHMkMfbhNejCg>
    <xme:WQ0LaG0pWjLxe-a1BCFdgkQXdWTYeKOhnX5-o_M6REJg_sIf3Oq8dT4pm6ctyfKNd
    8WT6o11uj5K0R1rXQ>
X-ME-Received: <xmr:WQ0LaJrpdx8W2iGTFU36Btaq7dPJ9-vpTtZQ6i2-hbYw9NozAYrLRWlS1MUMK2_ic0so4TNqgzdWLhT-yZEzJ2Pj00O840rORPFX8JGL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:WQ0LaLk-ykxjP4aX05SedGcig-qdGT69H-_GLQ4FPOY0OHk_uhPn8w>
    <xmx:WQ0LaB2vRuPyKQwsb5PqguKiZdVc60pZ6yXGsXUzhmVlR0TimpY60g>
    <xmx:WQ0LaKs5D1ypV8_JDU6xo8EJJ_V2l9tkDeRSviHdFQ_5h-EoPo3gQw>
    <xmx:WQ0LaFXBjMaYRosbMqBKqcP9EHoxBdvI41nHrLdBPpCd0nohsqe46w>
    <xmx:WQ0LaPmFNPruFlnTZSvFYb7CIKm7-L3bcbjsEfXNjAFU06TTmNXcBTIY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 00:19:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9194361a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 04:19:34 +0000 (UTC)
Date: Fri, 25 Apr 2025 06:19:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: skip unavailable external software
Message-ID: <aAsNUYUKJZbrMCf2@pks.im>
References: <xmqqfrhxtdg9.fsf@gitster.g>
 <xmqqmsc5rw94.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsc5rw94.fsf@gitster.g>

On Thu, Apr 24, 2025 at 04:10:47PM -0700, Junio C Hamano wrote:
> The ci/install-dependencies.sh script used in a very early phase of
> our CI jobs downloads Perforce, Git-LFS, and JGit, used for running
> the test scripts.  The test framework is prepared to properly skip
> the tests that depend on these external software, but the CI script
> is unnecessarily strict (due to its use of "set -e" in ci/lib.sh)
> and fails the entire CI run before even starting to test the rest of
> the system.
> 
> Notice a failure to download to any of these external software, but
> keep going.  We need to be careful about cleaning after a failed
> wget, as a later part of the script that does:
> 
>         if type jgit >/dev/null 2>&1
>         then
>                 echo "$(tput setaf 6)JGit Version$(tput sgr0)"
>                 jgit version
>         else
>                 echo >&2 "WARNING: JGit wasn't installed, see above for clues why"
>         fi
> 
> will (surprise!) succeed running "type jgit", and then fail with
> "jgit version", taking the whole thing down due to "set -e".

Yeah, I think this is a sensible direction to go. It is unfortunate that
this may lead to silent breakage of these dependencies unless somebody
explicitly looks for those warnings. But that feels like the lesser evil
compared to failing the whole pipeline.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ci/install-dependencies.sh | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 0df74610d0..e51304c3b0 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -66,16 +66,29 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>  		mkdir --parents "$CUSTOM_PATH"
>  
>  		wget --quiet --directory-prefix="$CUSTOM_PATH" \
> -			"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> -		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> -
> -		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> +			"$P4WHENCE/bin.linux26x86_64/p4d" \
> +			"$P4WHENCE/bin.linux26x86_64/p4" &&
> +		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
> +			rm -f "$CUSTOM_PATH/p4"
> +			rm -f "$CUSTOM_PATH/p4d"
> +			echo >&2 "P4 download (optional) failed"
> +		}

I think it would be preferable to only handle failure of wget as chmod
shouldn't ever fail if wget was successful. The same is true for the
other downloads -- let's be as strict as possible but allow failure of
those actions that depend on the network.

Patrick
