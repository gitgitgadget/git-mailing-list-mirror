Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7361CFBC
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738215843; cv=none; b=Ne/+E+rVQxWPY5ZKuZCJ3WazAnB6FiZgo8wwArm79phBfD+t6QBcZOTe4ommlXqqdrYPn3u69WHzVMUHRDwO0Sp8AH36Ei1GFoP0xlz1YnEp685q/K/wTnJPTetabnXG7TIji6w//lAUNPuOBWpYnZ5oVYbUKG8ac7XVU44NBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738215843; c=relaxed/simple;
	bh=TAPnEV7miwOPvptK8ImnL3NV59p4C0jSwoK0wS66R2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP8TJbH23FeeqhsJTxanQ5Nu/yNLUF7O6DyBj8w9NKG3yQQLoQHGI4Wo/Syk0T9te0pSZlkdy4sg2RpUOwKxM9F8radH46Ytal/aqI5qUXLG90R5yZQjp2irzFTDcWRbback0iv8t+LHhjZWcDHEB8sOp+CcQaU9/9vv41g6MFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qbbpwci+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9Df+rMn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qbbpwci+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9Df+rMn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4103C13801AC;
	Thu, 30 Jan 2025 00:43:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 00:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738215839; x=1738302239; bh=rh9OLIlbFB
	3xnixegDt1SNO2dEOsxGTZo1+afTWy0ZY=; b=qbbpwci+K/GLC3Orq3b7FL9pKR
	6NK4E3CcRJ9ITFw+CipoOiVW1Mj29q66b8ZBzjy/uUcqTx1I5xkry08L98rQ+s4R
	+30xcAMfyKZFLbo8S0VP6ca9D5xsJAocnr5KiN5BlDNC5h+uynzxqbI3uNgrF4QZ
	zguZI7XJk8hoL6l24lp66QWorZnVT6yozfzahngI0evZpxjXBggNwQyjUfuoBUNT
	jHhSDQ0ZQgn/xAFq6rXHXT0BJoZfaWbsTU1fF21DCqcccrx5SigkNNOUIOn9iP/g
	PHQWzzwP+PucOrb+/89qbR5FYVexf+Lbytqtg2BE6ox4lVPpoPBZJk3ZJGAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738215839; x=1738302239; bh=rh9OLIlbFB3xnixegDt1SNO2dEOsxGTZo1+
	afTWy0ZY=; b=J9Df+rMnvQFprX+UbYPRFtdrVxVez9NpOhM3pAk/KAGKSMy+MAV
	XI1bFa9m+XzPzW0BsN+8nmm3Ufo+c+H3A6+2t1pMflOSmod2QuN+jU9c+Zr4WFhy
	0Zfg7+/22rERWWKprFSx91+xQa7pYcCEe2VE/jFjAXIbI8whz5kdlbyqOsNtlEiv
	1ZsPAO5aMppH7Jzg93H4IHjOhE8WsiTslfxCnXI3aqfHqREpDwXwidKGSA+LYoel
	bKnzRmJrhDimUHnWd3pU1kmNmoDYug6dTPsAi6HNul1FIhd0tapjpRBhZGgOc3l/
	wTXTKX/qB2VPiopXdz9v1fEiHL/5w8DfINA==
X-ME-Sender: <xms:nxGbZ7u_8TOknvIrvEMpMZMij1WKwjokM4wIMTlNZiflRJyTBqSIfw>
    <xme:nxGbZ8fAioKK1i9P1yRVciwN2dlG2HmDsbOpqpcl1rrQHlQzJHEw_YgpEmNyu218J
    QDnfhy6Q11R9L0z4A>
X-ME-Received: <xmr:nxGbZ-w2G389UMTCGmext_egsZ8Yke1I7myachL-Jc7uBVWoJoihkeXt68Vcf5jsIMAhUTNWD_2OHlON5UZWDNHVUroExAc61ehewYgztTP5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:nxGbZ6PWYSA8Hsly9pEns6TV4EJnQ26ilAsGvNvx2K9WfMaik1lRpA>
    <xmx:nxGbZ7-ZBiWE05zWx_L447lYj4JFZBaSc5TeQ-6QkKbQ9HMARcmWiA>
    <xmx:nxGbZ6Ws65CIxQ-xsA0wExZg7cRL5XXEaSwlTDJtUiTHxQOZAkRTIg>
    <xmx:nxGbZ8dRLiL5Q9fk-6KRhtHzYIgWSWVtnx3tNCF4DohYX1soL7x2RA>
    <xmx:nxGbZ9J_vXWYC5rcSKgszi2nTqLU_nbAZkvLStYYkf_Jn2nIif-wTqg_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 00:43:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a5e579b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 05:43:55 +0000 (UTC)
Date: Thu, 30 Jan 2025 06:43:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
Message-ID: <Z5sRlmvvARd3CPXL@pks.im>
References: <xmqqlduulbgn.fsf@gitster.g>
 <Z5nfcAUZPNdDSI0l@pks.im>
 <xmqqr04lk98n.fsf@gitster.g>
 <xmqq1pwli9sg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pwli9sg.fsf@gitster.g>

On Wed, Jan 29, 2025 at 01:34:39PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> On Tue, Jan 28, 2025 at 04:18:00PM -0800, Junio C Hamano wrote:
> >>> * ps/ci-misc-updates (2025-01-10) 10 commits
> >>> ...
> >>> 
> >>>  CI updates (containerization, dropping stale ones, etc.).
> >>> 
> >>>  Will merge to 'master'.
> >>>  source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
> >>
> >> I'm a bit confused about the state of this topic. You say it will be
> >> merged to 'master', but as far as I can see it's not even part of 'next'
> >> yet.
> >
> > I am utterly confused---I'll figure out what happened here.
> 
> This turns out to be a simple typo where I meant to say "next" and
> typed "master".  I was worried about something worse, like
> accicentally removing one entry that was ready to be merged to
> 'master' that happened to be listed immediately after this one.

Makes sense, thanks for digging!

Patrick
