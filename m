Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F537273D76
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374899; cv=none; b=OHUYy3dEs18TA/AUCn8MOPId2gLzlst/CrFqfRXdcnVLmqLZ90XmIZmtDeWuyH9LI15NLsWwzn6EPREomNqUzhNhH35uuvChIMW9+yxSwmDhxL20lW1B5H4flMFm5pXfcNfo32CDXxp5WgPjB0RqSxFeU+hkeOmIOTRACkVLyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374899; c=relaxed/simple;
	bh=iz0bwvU/ry7S1EVYkKdwpraa9BdfvLgZBwC6VG5rSFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0foN/Mvr8ORVUkdAr5AFPl7I3wCzXs4NBVV9wrebUusEDgA1TR+/ffuWF7EHHEQz5+rCscfTFZxPc1GhJ+n7r2/ZuD9UdI8smVmcm5L9Kc8CWBla9uRfBVWG1tkwVdJvz9kdpVk9nUkGAwQURp6Dvfpe2GkQBp9xYdDeoGJJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v0wdcxQm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gyavt6d1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v0wdcxQm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gyavt6d1"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 55AD4EC04F7;
	Tue,  1 Jul 2025 09:01:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 09:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751374895; x=1751461295; bh=BQiExKymb1
	RiOiL7ocg091u4oiF7dCbbgSNA4R4yDo4=; b=v0wdcxQm5YywVeW7qwI1my5A33
	FV4nGu3cTEQKacD1dNhD1BMh5lqnRSWgF7hAlfpfTQEZxAwDT7hRkAC76AJVAdC4
	hIQDJz+KL9r2KD2eiVsFXajL0bjIpDeEt2FeXSmuTzurOQelpDZsfmtJ3bEMDxry
	hC9Zm3UmBK+1DiYqjYQWmMaZt+udbbf/GDJt1tiohqvfx2kxS7z1h4+BQWPfcXfb
	+Sj+FPFQ8Ss5UGgzTF7kBNQjZP+5X9Srb8Wa8TVSndCluLfLUwd9dltWCJfu83pZ
	tcpOfmkeURGjKjpuKhCr+beWrxqJI9yyDX1x3fo0Aqtndl3i/HcRYZEIOMMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751374895; x=1751461295; bh=BQiExKymb1RiOiL7ocg091u4oiF7dCbbgSN
	A4R4yDo4=; b=Gyavt6d1S/AwGp6AeVZ4HUClqV4LjQdg4vwNusLwuw4U+M1WtGj
	PpV9K9P0qsPPC+LO5cfxYdCdrVK9U40bCrOg5MkBLVoHitB4b4sxyJfO96I8aAW7
	CPoGlkiNtS8Ep5sKjRYQdRLbkFM+Q16SSMfCWVx6TpsB4pn+HmLe4XZH3yB88QEJ
	6K73v5zF+6rcj2xS1GdQAZ8Hy7wTkgE58kUcUULwnHRypN9kvGbVCrVqbvFqDO/s
	jl65RVHXY3KLltpXI4sVQcuFEZgoiI6MWqiV+8zyRxrRvQQcx2bcP9aY1F84V9K+
	K7i/u/G3exwfMNMam1ULphl9lD0XvyCr8Mw==
X-ME-Sender: <xms:L9xjaKitn1wrEVzRiFvTMXRCOVVeGWxa1K8Mz1ifznDCd4LFZ6B9ZA>
    <xme:L9xjaLD81_RDFnTSxYalwG1a6U3aoH8BuL6-S-LGFT4M4kN360bRwoB4pN6ICq4Bb
    GwYOcyQ0gg_vty4cQ>
X-ME-Received: <xmr:L9xjaCEPndYCTdKv0bAs6lbkMJ7Mnh_MJScVhXDtGskabi397l0t4GFtIaeg9vuS197malKcksjIXz5XagdafgUXTE97o6Om8FY3qLV8RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhhi
    grmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:L9xjaDSDxlHroLsH1MV35IBOjZ1KT5HkwOIDRC5zJ6EzkylIyxde8w>
    <xmx:L9xjaHxZmnOHJp8daWlNLAVvfk-ixtFMdbxYtuvs9lK-Qaj_PoKAbA>
    <xmx:L9xjaB4eVGxLt3vBaQEukPvI41ydZDjsvR2V6t2c2ChULecKKALkDw>
    <xmx:L9xjaExYJe0frHOVSmbkACp0OfZF159hIRwnvkeulKF9fJfUPH6GzQ>
    <xmx:L9xjaPhVtC6C1rIiYpMaV-AWCK5fRg-nKwgLk421ETcQMiNC_uHRscJt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 09:01:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ceaefbf7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 13:01:33 +0000 (UTC)
Date: Tue, 1 Jul 2025 15:01:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
	shyamthakkar001@gmail.com, shejialuo@gmail.com
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on
 'the_repository'
Message-ID: <aGPcKgR0G72JRSlM@pks.im>
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
 <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>

On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
>  	expire = TIME_MAX;
>  	save_commit_buffer = 0;
>  	disable_replace_refs();
> -	repo_init_revisions(the_repository, &revs, prefix);
> +	repo_init_revisions(repo, &revs, prefix);

Does this work correctly when running outside of a repository? In
general `cmd_prune()` is not executed and would instead die as it is
declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the user
asks for help we may still execute the function with a NULL pointer.

Patrick
