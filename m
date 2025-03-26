Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EC186E40
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968489; cv=none; b=UoPxKUDeBf2TWx00Vd8LFurqY2O03ViWIznDKyF6SJyIJbbB2HTOp7PmW1tn+BD4yTFIR00GVLUQz23fkLl80Uyyoh9JfeP3aiU0FIQUTWqKwi+/cWYJNtxvrRf/Gz4/74kQJaD8rVkZdZc2OqhgfrbNk2OM6K0s7hZCE/hSwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968489; c=relaxed/simple;
	bh=iM0bKIh9VUAnngZnl1DdVb3iFig0cOsCWzlx1cLfFj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No6olSKRv53RX05ikRZf1eJ5CzhoC3eCwsXHaycj4KRrjTTN235cXbNqjlbwjaj1zIbOrS3Xk9NwDIg+DuiuEKQ/O+RpwAdhePl/T+uPqjtN0IAuSF9TETpl50grYC+VUqHDVfx9U3yOLrhSNedtZ6jOZYWZ+M2lIGBsw49OPNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFpP11z9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNk3GvPu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFpP11z9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNk3GvPu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AFA57138380F;
	Wed, 26 Mar 2025 01:54:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 26 Mar 2025 01:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742968486; x=1743054886; bh=dQgN+wvrAc
	ywbpCe0ZwSH2aZv7rThUXKYr2PYN7hXi8=; b=RFpP11z915LYbF77RA3BiL48Bu
	fMq53ZHN03Xi9XAsLCQg3MErJKZV0zs8BIiqWwpBI21xbs6vEhW7PrRPHrn6PJMR
	DKOguWpVkELH1JDWCJh8V4iruEJR/LnaZykh596tgDuMOBivGNcjvfHcyjiaQeBc
	6gvchV3tMUL2OlPcIjd3/8Z4tNgtd6+Yio9resQqy3/za4Evvoc10EVvdcqxQH3G
	uD8ATGHKFo9u4GbSBi4NTgiDZRxxmPYYnjL+JIYTfeEyYDM+vH4dPBXd3iBjV2jQ
	Gfm1onqCcuH397u5KOpVYCFfdVSABBsGr/jtfaHvIK/KI1wUZSfM9DgGKSZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742968486; x=1743054886; bh=dQgN+wvrAcywbpCe0ZwSH2aZv7rThUXKYr2
	PYN7hXi8=; b=hNk3GvPuZltpD8ZGoS7/gxaniotodg7ZfYjy6khi4pPgghi6i35
	Os2ohoP5rWx+yzeV9fnpyIwEkz4wB6aZ1jE+VYYCmGFdNym1ca22CfyGUM8jOsXL
	WnbgYrik1I2zkHkNSWs4fQ/5tiBmx0hKiX+wXIk/AMmwKA7VJtEdCxMVogMre65K
	taq2Gj2PioQcRFzatD2s4q7bY2+Y1UoP5/u4eUfbAknuPqxkBhCz6DHFdwQJ7aLZ
	jSmKV8VRw/Jqsk3ofaAdcg82eNSQLVQocSCXTXMYE+oqfVzeG7c8uWlfRyR8AtM3
	/PFLhxA/TiFefMVFTv42nNgIvSn/Eac4OCA==
X-ME-Sender: <xms:ppbjZ0F7h6ffT925CRk-dWkhQxnhNw5hG2KT66IZaoPS0wgu_MtwYQ>
    <xme:ppbjZ9X8TVM59611FBMVN2PGtvwbqJHYbPXw62ldzVvaq21ynuH2J3NJ8CCU8ayuu
    bBqgFwx-Ft3XmAKTQ>
X-ME-Received: <xmr:ppbjZ-JcGEvLHxF6bxl_x_xZZKUpMPpqn1gYt7OZAksd0b9q6nb78tDLTEl7Rw1-xVmd6EdXgUBtpWYM3d7ZLOUtm0_r657aRvaVntJop4tERg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehphhhilhhiphhorghklhgvhiesihgvvgdrvghmrghilhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:ppbjZ2EEDr7vPyMJbj1UnxeN1JkbcSUYkvvmqaK8Mul729UjIixlZA>
    <xmx:ppbjZ6XHludCLXrS4Vgu8WXUMmlfgeO8CTRxo6a7O1GLjcMi7ElHWQ>
    <xmx:ppbjZ5Pbk7W4aArVmE3jQFdM2Msfwc4WC0OPapEasaiUNEcE6_4zOw>
    <xmx:ppbjZx0hXH97ham-UE4oYNxWXiMX-H6dRd_COc3BjXUz3h8EV9-otw>
    <xmx:ppbjZ1FmtCVY7emI3Cj3urocNnnUJGMcZWxmb5Z8MjTSXiG5FcdUnx3J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 01:54:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e82c051 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 05:54:45 +0000 (UTC)
Date: Wed, 26 Mar 2025 06:54:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/10] wildmatch: explicitly mark intentional use of
 the comma operator
Message-ID: <Z-OWpEDwHtaq3r2J@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:11PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/wildmatch.c b/wildmatch.c
> index 8ea29141bd7..ce8108a6d57 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -268,7 +268,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  					p_ch = 0; /* This makes "prev_ch" get set to 0. */
>  				} else if (t_ch == p_ch)
>  					matched = 1;
> -			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
> +			} while ((void)(prev_ch = p_ch), (p_ch = *++p) != ']');
>  			if (matched == negated ||
>  			    ((flags & WM_PATHNAME) && t_ch == '/'))
>  				return WM_NOMATCH;

In this case I agree that it makes sense to not introduce curly braces
for brevity.

Patrick
