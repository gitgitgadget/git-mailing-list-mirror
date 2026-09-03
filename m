Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E041DDE8
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429834; cv=none; b=JimoXblMBh6D7Myu0QuQjlc60uaHrlGob6/oXi43fNW6Zfe7of0q3K434pjLLKlGaC8+13+H8HHnjxhcHo3iGrlR+m4rTtEgfmxLrZgPCe/G9Lxv1vwSj8leYbMTIE5gOcDEZei5dNleJSyhy683+sH8X+AK0btSJ+8GFiLDq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429834; c=relaxed/simple;
	bh=/FxkfogtHz6myqRx7R41uu3XePi8kVCnK7mwKQD6kRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5M91l6905nHd4NFMV3VTwORGSZ2FFb6+Lu0EJvtOH8jAYEKqKYqeQpxnujmk6YRzpwra9/58ONwSugfCDaXCdsWGNQ0hjgF0OygNpcp47sQUn6btnBBhJYEXvp5P2LF5Gnx2HSPFkfOmknDQGVnVPfK8IUjP+/VK+IHcHwsWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g636sQz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYb8zfhS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g636sQz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYb8zfhS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D8551D00160;
	Thu,  3 Sep 2026 06:03:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 06:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788429825; x=1788516225; bh=/2H5nmnSeH
	qVAO6GsVjsA3AiONJe6HW6mD5I1+Ou5yM=; b=g636sQz4s548F2dulHxs8+Lj79
	lzGXMRLcDWvK6pLPD8y9zk0aQFsyBiQP29F9tp2QobK6wklkvU2dZe2Xn0BsqyPs
	dwK6AqiJpAtCASnDCgRSI2guVHsIacGvZ9XjZK1UwmYhOaxk9CVdfLvCYpaGhys6
	wszMXNlCNqRP42Ru9/dM2/zAO93hHhH7Y5QOy//mESDtV887Q4Dxvjw5t/ewb/rH
	imAcqFDg106qxly3BF9Nlm2XL8mIj4yb1ei76TK/4MDoUiy7aUQPquE/kuuqcU8N
	HMEKafMQg1ZObIf9ZPCqx0CLqtmzytPJolIKeDb6G1wQcvFNlnPihdNEtnGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788429825; x=1788516225; bh=/2H5nmnSeHqVAO6GsVjsA3AiONJe6HW6mD5
	I1+Ou5yM=; b=WYb8zfhS7pf16iiwfgGlyORnE4Sc2VwDRzu4YC9IVQwuxNNCrYF
	NsNJikdzCY1nvS6vK0q6iCyuVz27iqij6l3qIpXuzwREdd9ibOtgZACviA6IC0Ws
	ECMMAZz2Ps30Qa99mzPE6SslD5whc3FZDLuCUDt3i1Rao/ctnMnugV7zZ3YkiM2a
	+t+XVrLKimMuQiGdsuF504PedBtqkVLaQJXgdiUeyrp1FATMgUtSVpYVEQXZxL2A
	76QPdoTeT/oCTNeoCb6+wwp44WJ/V8zQW7KNlPE/seXh7T+jjLFvbK/30da7kI/W
	mlYoehFQ0BBCqtaWbaXpklCtgiL9o+n+9Xg==
X-ME-Sender: <xms:AEaZakIE2iPncAGcSB6efVv-wOInJDW0-bs945ar5zHMBLfhFEAr-g>
    <xme:AEaZateLbDDJRmVoMEAs7LAWJ3y86azGquKAaNNNio1xR_4K2KQCJbfYPu_nk6iI3
    orH1aSAvX_S5WwKT2-x3q4Kfn6P7cftQaakgoUpg1CaxokHWwMM5Q>
X-ME-Received: <xmr:AEaZar-DhOZNnZAYCphsRhkM2GLyVt9vVTuzVWWsEEsu7vUl8NKQFQ>
X-ME-Proxy-Cause: dmFkZTFi60GcvFnvry02xxBuL3KSmu6IyNJ+R11mHwXXtZe3Dx5+qQ3b4yu0oo+M9D/WpL
    rkrAyZ0ntpQnhJ9Wd79oRFUhv+XXFxqplKcOtWndV/Ao+jMrZPDjIHBY2dnlLA3+leVAy/
    +/uH/qE/euLtDCElye+28Wkmvzf9p6lwHYNA2VMLm+CgMhyHbGiJjuzRTBRVOuoPaGZf2z
    63ML1nfZCzf4lwssapzBEcBs8apgU6gJlgXy9gmSe3TKX01Lov+tReOZ02Dwf+VkwyJc4W
    WmfHscBOr+RW9UsQRJvBzSIFgTVgBd/OjUAr46J6ptMVV6+VHxcDFOCgBgCCU/b08ISGaT
    AaE2KQNcHMEX7xhqKugau/lHXZmFjYPj66dumKznCJgNU8kEnyCN2nfGp7HnHQpGg2bRWW
    /wh0MpXBKjV/qGfJ5nj8v/VGK35KrVLKdHIcBxeAhaL+R+l8Heyq3DzeJrAhEtBkEQADD3
    +6gb0+EvvtJmdwaOXhlK50EjEXxDa7ZsBdwdtdMVfbU7iiCezQrHzodIv1lrRw+NqELq/M
    ocruL1jdR3Tdm+lOg4K1dnge1yvrI8HA48pbKecT+h4D0ElGyGRgP0WFQAO+wrih0VdBMa
    7GtYZgISkzICnG8TxHegviGOBwsRvoJkTbx+y0Jji8mq/lHjGQ1XqsVkOIgQ
X-ME-Proxy: <xmx:AEaZairRDdp4MCfZC--xaKFN9k_vgvMLSf7PrC3ySf1I4zh9I33qBw>
    <xmx:AEaZaoBBjo7Yayh6mTN8GJfCdYa5cXVd-xYtYVFXYmgSeJSjcN2ECg>
    <xmx:AEaZasznOOKs1twd6sazwepgrMBhWbLnnTMlhfKF_bb7sknFzi44XA>
    <xmx:AEaZat3Vz_ViEJslYYuxNNM2lxjZu5J8O8voAmtxSVQt6JmAYgsHOQ>
    <xmx:AUaZauYaQclZGxOrBCudd3R-bcFY5LhuRjnmCuIDtnfHvNKulhnxAAPm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 06:03:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 057dfd8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 10:03:45 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:03:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 2/4] receive-pack: drop static variables to track
 report status version
Message-ID: <aplF9d5ajwO9AnG9@pks.im>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
 <20260903-758-introduce-hook-v6-2-6283b1fb9b1c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-758-introduce-hook-v6-2-6283b1fb9b1c@gmail.com>

On Thu, Sep 03, 2026 at 11:27:59AM +0200, Karthik Nayak wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 86933d8d7e..a9a3d21c24 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2716,10 +2722,12 @@ int cmd_receive_pack(int argc,
>  				 &push_options);
>  		delete_tempfile(&pack_lockfile);
>  		sigchain_push(SIGPIPE, SIG_IGN);
> -		if (report_status_v2)
> +		if (version == REPORT_STATUS_V2)
>  			report_v2(commands, unpack_status);
> -		else if (report_status)
> +		else if (version == REPORT_STATUS_V0)
>  			report(commands, unpack_status);
> +		else
> +			BUG("unknown report status version");

Nit: I typically prefer switches when we want to handle enums, even
though they are more verbose. Please feel free to ignore though, this is
highly subjective and it's not worth a reroll.

Patrick
