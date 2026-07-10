Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E735C190
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653667; cv=none; b=rZ15jgVpm0BG8jzFc35GBZ6SdB0d2urdUPv5jEH82HivirqjWGxeZ7g68Eagp5QEBy5PfNs/FK2imsuulIcoXl65Ul4k0vrl8a3m9O7AFglFGJuOQGCnVKHT6HFNlGH7kVh4elpe4/xCGaNWXKxDk8WMc6u9I4fYLsznKcuYtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653667; c=relaxed/simple;
	bh=UKRmo/3p2ADovyvz4sFrVeCbLN9BdO/PjTPb+MvMd2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoDYST8LpD7Fpb9XWeSvSHINujksu+pTzV7Oc9ANPJY79fquK3eFFOz4iSnJEpBOTRrS0pVn8auTjo9mQ1A5MoKz1z+ylbhat1idnIIeBvZ2J8ARrdGUGtmyBVajLm4N6/A7J1YolerEhS3NHDwexrxqk5QnwBuvo3nrOx4H7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vzsYfLe9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8THtvp0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vzsYfLe9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8THtvp0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B10F91D0000D;
	Thu,  9 Jul 2026 23:21:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jul 2026 23:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783653664; x=1783740064; bh=de9+mx47P6
	oziqu6zkj+iZpkCLOHVPjacKW1ramJDPw=; b=vzsYfLe9dPRt/GZJ+AugpnFc3u
	hRjVcr1OnawQv7WWLnsW4MnkLBam/S/IFkDgq39BvaWOk6Omh7ryYEVyDD8x+9cM
	6ydM69ZScIQIIXz7JyWCquWBJPmB9XVImpXE2vE1V0Ul7nixUlG1D4+4/r2NFcPK
	ZN4lfeo/DPHwGSDNQK592CQ/LBUZ34sIiDyemc+/+QLJ4GDmLPO2aDR9qbLa1lAo
	UfVsZdZuK9hLqPGtoSk+UWt9uCzKQOh+DORuQZnLbB6XmyS6NfX2DC7zSCUyBHu+
	T43YIIOHeO3EssqPbM/dgOYTvkqCtHSlwpNhyVwcFRpmWATHTiEEm2HZbtDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783653664; x=1783740064; bh=de9+mx47P6oziqu6zkj+iZpkCLOHVPjacKW
	1ramJDPw=; b=P8THtvp08wHkMr3U5gnIhpHbJCWOGRv9SGavG6Ip+6n7dY/7zn9
	qfmh9rMQBszsXNfiUkpLYtGQaRTMxT0WrrpsbWySk29a3ZiICGF45h5DVQUOwXn3
	51TLcqoXPcJM3a3Kegh2umsSWGEVWnBvb1krKOhPK6G9mm79RefsvpmsGL2+vlZz
	4L3LowVrNW6YLnjkTj/VMv43z22WNt1D8/UkoGzTS+TyEee7gPXiI65j+HCKj59w
	oVsQSDO05w6DN2U2oV3i4vQBgFG5ZTfI0/S7KBaIU+nsld2VZT19VlbhCFx1KhAh
	1R1HmyE6a1/nAJQ5Kzb/1xZENsfDdX6E/DQ==
X-ME-Sender: <xms:IGVQanic-tUgndQ9sjbS6JcUpjfgYSFCYF_fqn54j_3qYBOINtEh1A>
    <xme:IGVQarAvF_b9ItHRaSkHJ5e09HHtJxv7tBXeckJoMwIyDvgsMXqvJFzyFE4k-nOxq
    hUne80X4QXjCeSSGyH8A-rwfxCnELBnFa4DaeKwto5bOZ0g71zD>
X-ME-Received: <xmr:IGVQasF74aCwaOKj5wBbxJvxydW909-hzp_3K-OLFHvPsK9P8A8ojK6s9a8ZZv56fNnp2ywaXU7UbihSnew_kolFo_YRuBI7SoIh-J0>
X-ME-Proxy-Cause: dmFkZTFZFoog+pdO07OLdl9we1Uq2I4DZjSBADHA8bYgbosVo3AAYtku+LXTn2h5LUYkdf
    URIbWDf9u/kjTJs1SPnvITx0Mt9VCFiNVzROBuwxTg9zax0d5NFpHDCkTI2kRycvJQMDrf
    3JSauyH8nuvPUATCn01AIg+bPr7Bk62deWJWrO5TkKhDOJ2NIZP4moa3YQwXIYyxTrZs1W
    kzATX9/VkbG5aZ+1r/JQlt48z15zKZq95UZkL7qQFDSKZxx9CQs8HUZFEitLis/1h1rh59
    zxs6j2E5rJmS/Jet04DzhF3WTFWG6tx2G9zwI/d+pC8H4jteTz9KptP6F7k2p6tcvSEFmk
    DVa5w2Orpx10xMvS4TmNEKB0IvLalfg7WEoKtRkJPnl5HnpubT+RGHOPozqewjWFwsYsR2
    eiozpd441BNb1RCkSFEfl1P0ja3untWXILihKEK3vFmDXIzB/jglidzEripW5CTh+6St9t
    wqEpfKsqKcATFmO8kyhY0tvxt0SSytGvKhPOAY7dDSKC9jqB2Hd8zX5qCSFyNvofn0By2T
    siFIvsO2+1nOz4Dja+8owfyPM7Nm/mJgnAKDjrdiecq6Zlmx/Ltkdztt+euuf0IUYlVatl
    rArDIU2zQ2jewrEggoX2xPFJQlUpcYztA+F4QTkYVKEtfMdCTqC88mKUxmeQ
X-ME-Proxy: <xmx:IGVQajIlPWKeoeO55RFmFy57ApAxuApsJfkkq6NoXCn7HRYISUF8gw>
    <xmx:IGVQagn4zBbD-RDXUTNXhUUUB1BpJb4gY21bRbQMKWh5giG7rayumA>
    <xmx:IGVQarT__6CmWInj9yvGUd75H40_wrhoRPzsLKM6Xu89-Alas0pOhQ>
    <xmx:IGVQaiKrluZavV-phJLsIXiiIopHv0RGZsSYpPrU37hkqCHAh3bccA>
    <xmx:IGVQahfY4XpqNWhSLY-Ww1pOmieN8l07-FPo523LczHu7ItjA6tNmuA9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:21:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/11] remote: guard `remote_tracking()` against NULL
 remote
In-Reply-To: <dcaefc598779123cea19807877e074acb3e1575a.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:30 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<dcaefc598779123cea19807877e074acb3e1575a.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:21:02 -0700
Message-ID: <xmqqh5m7h6n5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> However, it requires quite involved reasoning to reach that conclusion,
> and is therefore fragile. Just return -1 ("no tracking ref") when there
> is no remote to work with.

In a case like this, where the function is designed not to be called
with NULL remote, I would prefer to have an explicit BUG() rather
than sweeping the problem under the rug.  That would make sure your
investigation and involved reasoning done here remain relevant if
the BUG() triggers due to careless changes to the caller in the
future.

Thanks.

> Pointed out by Coverity.
>
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  remote.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index 00723b385e..34d0367f11 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2681,6 +2681,8 @@ static int remote_tracking(struct remote *remote, const char *refname,
>  {
>  	char *dst;
>  
> +	if (!remote)
> +		return -1; /* no remote to look up tracking ref */
>  	dst = apply_refspecs(&remote->fetch, refname);
>  	if (!dst)
>  		return -1; /* no tracking ref for refname at remote */
