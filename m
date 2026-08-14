Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA1377ECF
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736141; cv=none; b=NQwnn2ZhXszez+zOmMmdOQCuFmuabJH+Ne7rkYGOHr5kHd6e+6QyiCvf7xyOmWJI+lKAvBNVeLTOn/iF3uJJPO0LAzX4GwZw1aO4b+g53tQA/+8IOnIrkl2FBzdGwM/MvrOMVsoi5iQiOswysiM+wF4WT0xEUqM7jj05TMs8xMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736141; c=relaxed/simple;
	bh=sXQrAa7YoRjw+gw2bWEGgh3KD2rk9bvaAbJ5oNv/tLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sl25OIvBn9vKlEEF1IcUEbc9PIEh2vJ9/UYBh5nJMnmSMU1H/x+46a48/UnkBV1H5ET1BHXsFqhPuvONxD6OPFfxwl9o2stjr/EFwmHWRADnuoC9PJjpDubb0z2L0C2xzngcStJQbp/0iDvu2+oVf4oS14UX+i29h7B3WJ08UMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ik7iG/KH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/stzlUi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ik7iG/KH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/stzlUi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BCA4EC00FB;
	Fri, 14 Aug 2026 15:35:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 14 Aug 2026 15:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786736139;
	 x=1786822539; bh=OgfWCUIiOr9HHpKE7KkVoJubc1pG8s1LDfiEH1Taonk=; b=
	Ik7iG/KHnEh6OKYWJXZeueMpSVjVGj979MK5DsgIhLVHUHXidyH3+fGNj3zdu8qZ
	EQzfsny8SYH/2LRPiUmxFFcuY6XhosCsYCS17K9g93W1N4hpSacZLozoAxVoZVZe
	GIk5G+LqjFnGLxYNp2aaks0+vdxZqWLt4Vo+wacoMHrRbr1LU3/QJLlmRxJEbGuN
	KeQ/8QweX02YUAjE9NIDg3KSbcoMGIwxfcmQCo+tlCL00Y5xxp2Sio2Ybwjs4nvT
	BITfcc9P8xo7DTju+TLgzBFIzSzNAvIFqkvgrubqEZY/qiU1pJTZ9yYrNVeleuOc
	Jc2gogEL2oZvXGDsULrc0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786736139; x=
	1786822539; bh=OgfWCUIiOr9HHpKE7KkVoJubc1pG8s1LDfiEH1Taonk=; b=K
	/stzlUiT3/eUI/pX53arIun6Tu7AFL0CoMvZrUlUf7LXv/po6U4UB6eXEVJIkdQu
	CSTCFk1cw0eYURPb+5d9XTHFCFYUvxYTMLG6X3AWe6aE3ERbSXQLnjVF79+nGR5U
	eaeTGeUTzJ4FoTeGZsz4N0g1DmYrB/NZHa/ZuxqR5ZiR8be0XMeJp+Igssa1d24q
	AHt+QNu594MTk/OlCfTy+dp3p6iF+I/oz9ogZc+rAZ1YyIqXm5PjwfXpl7oFQ7/3
	zVg2LyX83LUKLamwXyjwiO+DkM0mvMUuqvzdoUX2CpCyeMZ6UMZihgVD31M2IIsx
	qv+Q96V+OjD1+fwAoCTEg==
X-ME-Sender: <xms:Cm5_alrixt--ngpDlhNQwXIXB0tr3bsiB_Hu5qr8u3-ko3TrJ6fSNQ>
    <xme:Cm5_ams3bDxLlkt6xMriNIgCDfdjUnhTGotYvXh0LyAgr1dK3QoiE5NO8wIW72BlS
    sGDuB63yLpe3YEFtCEWlkx2zpUAbtk_4GDJ9la-rYlbFOUuMQca>
X-ME-Received: <xmr:Cm5_aoZ4DmiukLSuv0yQmzvOYmbLYbMerMmoqcbOQzlbkyZ25wlN0NoBwS1sVcoofHDFtRzQDaB0YjutD_eodD3NqSX6A2P5oA>
X-ME-Proxy-Cause: dmFkZTFRzvnWlf1big+5BuKqZAEjz/kWOAIsu19NUn0zJBK8nI/AOefzq42xWMmjUMOLrr
    zktHleuxXW9/XovrzKkBB222/lDlEf3lPzxwY9Y0TWp37yfvuZVWty/U30bOsZkJZoAUgg
    LrDJF4sQK//VK2cGXHM+W1Z5Gjq1FjFl48eKReU5X52YK4jGdX844DCDWm2L6+V8juiSSn
    wSCNrJztZG/dtQ84tTkRLGX+tHvpu1JHtc1AsL7p6lp2XV+FCzOOEhqGuXJ87v/Q3VYCIo
    QRDaHMJUp3TolCeSUjGNJuIia0tYMbeN6haW57UmaNNjqu+/ky81A7Wo7nm20YSOD0BPAZ
    1193NGuRuLrF3RIWCNO6lRD+Gxm8S5NPulOTWMoPA46mLQwSFA9ySLI4k3GGT9iu0pHXQ7
    4WKkAV/MD/pjH2T+ooNZiDZpHREQATLHCUk+CTRkFhl3AwQOuGb1Op6mQqBwNeHsOfbTyu
    hjUObHomXnJH7t0ePTlchnJsc8UCq7lDmVYldIH7eUaRa3r1qG4PHs0uePc3G0/tBuKLvz
    T30tDHmXDVvsCO4d3Rjf7exGXyaPFjS+s6cGAXwn5eVkGrEBCYoqCdrQmbfwwmiw4/rLWe
    PoToDXj1KzLH3qI/J3cSWKhJGnI9/Y4lOTGaNO4Eoge198GAZN8G8D3WvqNw
X-ME-Proxy: <xmx:Cm5_atbS4hKEsByDL18p6ArSWgzyClRBmNvea_K3xQC6G8QCqtvVHw>
    <xmx:Cm5_apmXhu0j9I9G5-xDVgE-HiPf-19iLNHcXWdYCw2AfRW_qg9i1Q>
    <xmx:Cm5_ag0ARl6-jvC0UE_VuzO2YG6yvtom7ON0FBEffmITn1yjzoLJPA>
    <xmx:Cm5_ah0EmdxmjppXAx97jiyFxhxdbFhOBhuZ5oJKFHf3W8wgWTSZYg>
    <xmx:C25_ajuUfZ816PSIWQ9XEOirA7K21pKoJJZD2I6kRnhUIreKTsWWrQBO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 15:35:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 5/5] builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0
 on trusted repo
In-Reply-To: <20260813154748.2378747-6-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 13 Aug 2026 17:47:48 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-6-christian.couder@gmail.com>
Date: Fri, 14 Aug 2026 12:35:37 -0700
Message-ID: <xmqq1pc0mr5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/Documentation/config/uploadpack.adoc b/Documentation/config/uploadpack.adoc
> index 0e1dda944a..e960879c16 100644
> --- a/Documentation/config/uploadpack.adoc
> +++ b/Documentation/config/uploadpack.adoc
> @@ -86,3 +86,45 @@ uploadpack.allowRefInWant::
>  	is intended for the benefit of load-balanced servers which may
>  	not have the same view of what OIDs their refs point to due to
>  	replication delay.
> +
> +uploadpack.lazyFetchTrusted::
> +	These config entries specify repositories that `upload-pack` is

To somebody who designed this mechanism, it may have been clear that
you are talking about multi-valued configuration variable, i.e.,

	[uploadpack]
		lazyFetchTrusted = repo1
		lazyFetchTrusted = repo2
		...
		lazyFetchTrusted = repoN
		
but the "config entries specify repositories" can be misread to mean

	[uploadpack]
		lazyFetchTrusted = repo1 repo2 ... repoN

especially combined with the use of verb "list" in "Listing a
repository here tells..." we see below.

	A multi-valued configuration variable, each of which names a
	repository that `upload-pack` is allowed to ...

or something, perhaps.  Say that upfront to make sure readers won't
waste their time wondering what the syntax is.

Also, how would one specify a repository?  A URL?  Remote nickname
used in

	[remote "nick"] url = ...

configuration?  Local directory that houses another repository?
Something else?

> +	allowed to lazily fetch missing objects for. By default,
> +	`upload-pack` refuses to lazily fetch (see the description of the
> +	`GIT_NO_LAZY_FETCH` environment variable in
> +	linkgit:git-upload-pack[1]), because doing so would run `git fetch`,
> +	which may execute arbitrary commands specified in the configuration
> +	and hooks of the served repository. Listing a repository here tells
> +	`upload-pack` that it is trusted, so lazy fetching from the promisor
> +	remotes configured in it is allowed. This is equivalent to setting
> +	`GIT_NO_LAZY_FETCH` to `0` for the matching repositories. An
> +	explicitly set `GIT_NO_LAZY_FETCH` takes precedence over this
> +	setting.

It would be interesting to set it to point at itself.  A client asks
you to serve a pack, you find some objects you yourself do not have
because you fetched lazily from the upstream, and you end up asking
you if you have that object (U+1F61B Face with Stuck-Out Tongue 😛).

> +Note that this allows lazy fetching from any promisor remote
> +configured in the served repository, not only from the promisor
> +remotes that the client accepted using the "promisor-remote" protocol
> +v2 capability (see linkgit:gitprotocol-v2[5]). The served repository
> +is trusted as a whole, including its configuration, so the promisor
> +remotes it configures are trusted too. It is the server operator's
> +responsibility to make sure that the promisor remotes of a trusted
> +repository are also trustworthy.
> ++
> +This is a multi-valued setting, i.e. you can add more than one
> +repository via `git config (--global|--system) --add`. To reset the
> +list of trusted repositories (e.g. to override any such repositories
> +specified in the system config), add a `uploadpack.lazyFetchTrusted`

a -> an before `uploadpack.lazyFetchTrusted`.

> +entry with an empty value.
