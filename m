Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12971FBCB9
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572026; cv=none; b=EFylyVB76GxOWHWzGomTkNfh5JcCNCYOh/icEnWuHTJ8UYS/iEvbvpFlvwzO7ZZ2cSD8zNl6hySB7dJ4dexm0dT/ZKGQCShvWq7fJcTx04jsG3nIDqdxUBQM0JiC6Nd0sGNl9/NC+z6ktgeIpRBmmddWEVABSPTQrrJLrM4LZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572026; c=relaxed/simple;
	bh=embNaKAoLrOBUOyeOMdy2jC5yp7mCyZ5D/3YhcSZrNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLAxDpcZ9fVBvsFTmafaRsdrsBfpZ1CbkX9GxTgogp/HInw34sXswBQsCjvoPqRQwJrIB6eQYw1jpYog1xbaxFgt3pMzZ1RHZQzke1zKZAv6ZSx6m+U7By9FmiqgKv5Yhw3deMprXosJ/o4ajGgIz6DkN9akihvfwZtAEr2TBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SQ6ss/50; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=01uhaebf; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SQ6ss/50";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="01uhaebf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B7A9C1380851;
	Mon,  3 Feb 2025 03:40:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Feb 2025 03:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572022; x=1738658422; bh=embNaKAoLr
	OBUOyeOMdy2jC5yp7mCyZ5D/3YhcSZrNM=; b=SQ6ss/50dbxXl329H9oyzOJKbT
	zYYNsvbS/TTH9dTts7wB9c/L35lXxOY2f60FyMQupe89DFbj71YvBb6jeKQ0CLoI
	VN0JKSkaZbM6bG12rPCken0j+nbP1yGtZ1oAbnIsroSBXTZCGnnIyMb4qkEsqSrs
	7sgWbTgbYPH9FFibDRLta5X1R17rvrAlajhcP1K0uqDtlUGi/MFPRJPcic4f/M3h
	n/1ioPZGwdT72R+mKJ1FWNje0R7sXaE+VvoTCwpgnY0nHHejRCaMR3r43D/l4OV7
	gAGpdd/p7x6WQ09xrEYcAwgNlXgn2xmMvbtl5GhVWRUnFIkzUmjlO9Uy7GpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572022; x=1738658422; bh=embNaKAoLrOBUOyeOMdy2jC5yp7mCyZ5D/3
	YhcSZrNM=; b=01uhaebfWMKcJS9RFknTZF9ZwdSVkUja5FDjWAEZsFoVnu4GjeE
	ViWJYjWYn657VM8RySiDMSFK4wcu3wja+694LInL/18pg0467grf89+9+4HrawHJ
	JZavBGrNTAeojFB1z3LqVT6TRebITRPeylfebVT25nORW+pGLtVFifKEW9hWKZaN
	pyafhzOyHoryK+csVO3qHscgGTyQSsVdRsL3RTGUCI0uH2hGvIGsYQMEMZiqh/cC
	5g/YHQhidatPecQIl+1P7U7fpo0eCIJIV4CEkkctXLzXCh9KGhyKLeZGMN6MFRsh
	jNDu7YQIIKkxzpapOXwI1w1zjo15+MrBoKg==
X-ME-Sender: <xms:9oCgZ8uY2ti1FJ9R6J8ToKc0pwpL78EQAX_a6yiqwEJafMHLJHsjyQ>
    <xme:9oCgZ5eMc-fYt422syEQn5KQAikM1tklV9eOamAdhpuItzaEhhqan7ugjZK7WOF3X
    NTtLVi43fp5mNVYBw>
X-ME-Received: <xmr:9oCgZ3zeFuHOkzuqDpCf8Wb2G96xcxYtAxUNuet0SOYjuqEE6_l92l5KVZvSwQBRBK99Riqo31NyyK93Q6ki3kK6bCr4UFIovfnS6h6mm2upxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:9oCgZ_OO00maziAaylZTtyzxXzgsMcSatI0oB-fkTUv3FMj-7uuFCA>
    <xmx:9oCgZ8_zyT_hlYJ2apBKmdZtz9ljfAjHyoFlBnUZx3873fhj3UGDZA>
    <xmx:9oCgZ3Vlw18RkYo8LSRsdtHCOHaZ2PNg1_dRv0t_xPFPWVgwiboIEw>
    <xmx:9oCgZ1fi0sPB76KYJa9231noZBuJHIRr8lVdzo_U9q_EzwkSc2t00g>
    <xmx:9oCgZ7k9Y2wQ7pO6E1jnkWjye5WK8xpaZfUrSAP1e3r7laIWt_lh5jLi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ead5598d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:19 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] packed-backend: check whether the "packed-refs"
 is regular
Message-ID: <Z6CA7ZIBuY_YBV1Y@pks.im>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r6-52eBgT4TUYG@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r6-52eBgT4TUYG@ArchLinux>

On Thu, Jan 30, 2025 at 12:07:23PM +0800, shejialuo wrote:
> Although "git-fsck(1)" and "packed-backend.c" will check some
> consistency and correctness of "packed-refs" file, they never check the
> filetype of the "packed-refs". The user should always use "git
> packed-refs" command to create the raw regular "packed-refs" file, so we

It's `git pack-refs`, not `git packed-refs`.

Otherwise I'm not going to comment on the rest of the commit, as Junio
has already sufficiently discussed it with you, and I very much agree
with his assessment that we don't need to discuss whether or not to use
`open_nofollow()` in this depth.

Patrick
