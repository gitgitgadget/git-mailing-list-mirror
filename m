Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DAC1FFC6B
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338207; cv=none; b=uhbk+rG6cdycd/iNs8CWvcmIfbtPeYcbOicnUSUtlq0eTNh/qmLWuYIawXUzM5NeG5XD8927T6aslRSe2/PbkVqS88A3om7YJXEijYAzG5d2w0ssUBrhC2e8gsHSW/1iq21AA1991DLyafqPSrR32nCXT8H2DbG/m5OIVAzUQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338207; c=relaxed/simple;
	bh=igU6r1/bGSK6ss+W8VTFhF5MoVf4O7RKnvm6y8Yrf2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb53BTbCyOtGt5AXpv8g3+HFZmsDWApmbNZFDQQb9+wVt1YKQa3Dy52LHZXzzKv9HcgmrZwMdEFxm2wQYnSVSggMfAFSIgVOngQiwSy08OLWHmraoMVl+YM5P3ApZ9HMxJ1GCZYYF4if1VRUAz6RwvyF7/SHKWNWDfDVVEC/hcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XEvw4dqM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bn5SUC3s; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XEvw4dqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bn5SUC3s"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2243254010F;
	Mon, 16 Dec 2024 03:36:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Dec 2024 03:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734338204; x=1734424604; bh=HmNt9mNlDl
	ajBa/uCo0v+iEHOLWvu4mHUP/8ScWCCUU=; b=XEvw4dqM6HoNgfmXPx8O0iLfJ+
	9RkLG6kEmdUtLLLhKfigCKaRZ3TxiQYSqByrSwEUN97qtUqsq7qQY8EJokwN+Kb/
	+B2AAzIs7j8TN60nOKIiJ6atyEKxgbOwYadbOdFWkQvuO7ow5eJ3XPiZh0KKld1E
	TfkG7qpUBIxIuyHMgP7kWsTumZQTj0yGO+7oK4VfGCxDQAZe2Lm54smlLkrEamgx
	YsGXYRkN5itKnk6pOW89zdMFocnq6z4ENEE43lxoq2ln3N2Ly16LkWJR5Tz4v91w
	axm5HA2eKpx5lboXkjLGVm/p68M+NdJbc/V44RarinR0TwJ7SJHit+slpkFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734338204; x=1734424604; bh=HmNt9mNlDlajBa/uCo0v+iEHOLWvu4mHUP/
	8ScWCCUU=; b=Bn5SUC3sJuXdQ3cZ7K/vMExyYz6NF7o3mErASnOhaQmXw+DXr2V
	xOWvHZTuLDW1IcqVXcNrtJfAcaoRiLfQyyKgR/OpuSA/oxQNZECDuK1AjF7BmoW2
	ArUWvrTsV7BuWaCTRRqDU1F52pWxeqiMBFJhhg5JuCPUaD+/7s/NIuZTiHCFfB4i
	0TEVlaEoZSOwAJfOlR6Y+8C9ndB5uGFKRTVSdnZajwT5v20XggkKgEZ+xPGbji9u
	WI1m1flOKM17l61yj7anHGBfAyEF+HJj4DvH2hT01v9MIXHwxPXIgtNgrUMMhVVr
	1jGdjZ9npqypZ3Xo59NgR+FN0LXFLJvuVdw==
X-ME-Sender: <xms:nOZfZ0IFhz_NJ1c5-opNnwity7EtZPU4fVOYgXCJgT-rWl2FGHoPng>
    <xme:nOZfZ0KlBLiiyLzX-RRpRwinRdZhgoEehFcsDjmBufo5V_Y-TP1epZA-Bm2xmdwAp
    kyCUyQkdjcVta6Y-A>
X-ME-Received: <xmr:nOZfZ0sBrBI1xMt3OCwjwGjRvVH3nLZhRroldidsxOemv21euCUQFfJmgSmyZcqZcr9-AKxLJGtauS13MkDROQbo8G6A9zk9iuLx70UAQ2LEBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopeiihhhihihouhdrjhigsegrlhhisggrsggrqdhinhgtrdgt
    ohhmpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nOZfZxZbbfxguhh7QpByTcX-Zvz4auDpx15JuL-2-NFLSne_HIz8RA>
    <xmx:nOZfZ7ZQ8QIMa7hLng7Gp5S3--Hf1N5vUCIpiSziroRdo4NiF5Snfw>
    <xmx:nOZfZ9B98cvV8bC-kXiI1771yfLeUQxWJREiZQe_cCDbrISvUdh1zA>
    <xmx:nOZfZxYDOZuq6NOwaKen70t28FI_265CQmiNhS3kmrU1OHRYJLUk1w>
    <xmx:nOZfZ6WeY9wrNsHwdYAHD-z6_KpqDIC_MxW5cUQzbLxNmAxVKtHDrrBE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 03:36:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ca22c9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 08:35:01 +0000 (UTC)
Date: Mon, 16 Dec 2024 09:36:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 8/8] send-pack: gracefully close the connection for
 atomic push
Message-ID: <Z1_mjOdrUwb-XeDs@pks.im>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
 <9f49278ef108f08d512ee13128ed8277e12c002d.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f49278ef108f08d512ee13128ed8277e12c002d.1733830410.git.zhiyou.jx@alibaba-inc.com>

On Tue, Dec 10, 2024 at 07:36:28PM +0800, Jiang Xin wrote:
> diff --git a/send-pack.c b/send-pack.c
> index f1556dd53c..439b249c79 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -631,6 +631,7 @@ int send_pack(struct send_pack_args *args,
>  				error("atomic push failed for ref %s. status: %d",
>  				      ref->name, ref->status);
>  				ret = ERROR_SEND_PACK_BAD_REF_STATUS;
> +				packet_flush(out);
>  				goto out;
>  			}
>  			/* else fallthrough */

Nice and easy fix.

Patrick
