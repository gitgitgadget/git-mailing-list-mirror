Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064A16C689
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003768; cv=none; b=hVM9eiOOZdtB9TB1qmDHZ5XiNSAcGmYwuPi8gNB9/1eF0WO5EKSkn3hiYLG+PN7fEuwaNXlSrRRAWFWkjfhoLsVH2vsvEgZZhjcmqni/WVRKXSUtM11uwRFfmDcnA1AsnW4nV1Shd8DotO8NF6IKSrfph8ulEn9BdljFgZNuQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003768; c=relaxed/simple;
	bh=7l/PjK7gOHziV2PEoJ5jcgj3mJyIYoLM0XTAst04rfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciKsbcmv9QM+dbj7kZ88pAq/RNHcSoX7TQglghXRIlvKnYuJoIGVs4C853Fz0lcNL6YaQiELwf6iGK8wuQUrbJX3b8OGEflGcwjSDr7FMctR6Qtkdfyj1P+SImH9FrFGL/IzKssKgiYqHvtKxdONv4YzTPEgMaFUFyr603d0lFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DA7RVTn/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b545SxaK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DA7RVTn/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b545SxaK"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 997D511401A9;
	Fri, 30 Aug 2024 03:42:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 Aug 2024 03:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725003765; x=1725090165; bh=muqQw9Z0Fl
	/ODqA0P5GKVxCC1xY/YE9PiJ6ao+SMEi8=; b=DA7RVTn/xj2+bjQ4iubftDzjtp
	71zB7S6CIgzDK9P994O70qEns6Yn4+s6PNL3t7GWI2zKnFGZOdHKubkRjDgfOuoI
	R4Deh/EDruFp6bAm7+VSCcTx6bOxINQwdWIpnRsPa55CdooqIqUZElA1UbJ8ro4u
	947r7T45fljkG1xSQiwwc+SQ0GiqTA3kLQOq3ElVmdSak251SvwY4mlg6+jayX8w
	/N+Pak4/dcDU9+Itp4gnMfeAcjM5O7lMkrCI+uIJTE3J+RbdKQOxivZvcX4CEWhq
	Lap8Jx+jywbEYuUpuExaQOPVc3dXwe3vuq9nKC1AP/j8EK0sn1vuRb6/2KWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725003765; x=1725090165; bh=muqQw9Z0Fl/ODqA0P5GKVxCC1xY/
	YE9PiJ6ao+SMEi8=; b=b545SxaKuhW7yIkGWTaLuuvvgNs/XA9Bzcjo4v00bFjk
	R7M3ZL84eIWUQgi5pU6oDInJ/7xF5rgZo2B77HQ051uFRJ1VpOapxkJ/HHTkfrjR
	6n6eD/MuJYI+Nd3mxFw+gMAMcSAcGWC047Nq5On12htEQ+BvIRNfG81qhoNq/+4b
	VY0PohPTyNtMoKR8s8Ds9Dk8x5wclKQBhxZpSKrlv/bl7dH/A53+gwd+Xq8oNWxb
	4575vqnksDrLU8tpAj2Sqo5jIkw6RxxO7NAOWaKFt2NRTol5iZxLpB3ysnAHFdqm
	9DdZkJelFj9d90hEcxQ6ktSylmNhbVFp5y4qpFoNSQ==
X-ME-Sender: <xms:9XfRZjUM_xOthy3pt1Anrfj_r6gclBAhMzYcVk8Lma3R0y-0VvFvJQ>
    <xme:9XfRZrnsYSfwVtnoEsEP9Mvsjz6HfzPJLjQMoTMWlMC0GbWbmleVv2E4nkLm5LRYe
    Iw-DUwMurb0UP1ISA>
X-ME-Received: <xmr:9XfRZvZYTF89mADguU3FbgOxHC6NUvL3aGDpEaokrMoQjzr_aJ0VZEqKdXTTLygaMzACQgR6VL1vbOPhEDt93AIbX2Ck7DOycNogPc32Pe-s7TA_kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefhedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9XfRZuVQGsc8ldhnm8BqpYubpkg0K3ehg6Rr30zYVzNE3jj210sciQ>
    <xmx:9XfRZtnzQdA7d_-r9YOVNa9Wje1B8S3rBd1vn9FVqhHTbrx9eIrIIA>
    <xmx:9XfRZrdlHGiT3zq7vK9MydSVFYZq-zsNlOdlnl5NlfE-rFaw_xKRMg>
    <xmx:9XfRZnFKy8DweFHJGQObzrI3J5D_Tq2FWr2gpNpQITvXxpYm4p415A>
    <xmx:9XfRZjgr8VD0XOA4GxWNvfl-tXZ4fEPlg56UnYJq6DCfotqtg9o48i-c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 03:42:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d307210a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 07:42:32 +0000 (UTC)
Date: Fri, 30 Aug 2024 09:42:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 01/21] environment: make `get_git_dir()` accept a
 repository
Message-ID: <ZtF36wGgltwiBmYC@tanuki>
References: <cover.1724923648.git.ps@pks.im>
 <0fe3e3e1cccf2eae7d81ccecf431da623b39fa79.1724923648.git.ps@pks.im>
 <3fvisdomxvcepnfbx2aruzyhqj2ntfjaapk7escwhylxxuq7r4@inhrmm26blg2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fvisdomxvcepnfbx2aruzyhqj2ntfjaapk7escwhylxxuq7r4@inhrmm26blg2>

On Thu, Aug 29, 2024 at 03:15:36PM -0500, Justin Tobler wrote:
> On 24/08/29 11:38AM, Patrick Steinhardt wrote:
> [snip]
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -407,7 +407,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
> >  
> >  		discard_index(the_repository->index);
> >  		read_index_from(the_repository->index, get_lock_file_path(&index_lock),
> > -				get_git_dir());
> > +				repo_get_git_dir(the_repository));
> 
> Now that the `repo_get_git_dir()` function has been moved to
> "repository.h" should we also directly include this header in the c
> file? Or is the implicit reference sufficent? From our coding guidelines
> is seems we preferred to be direct.
> 
> It looks like there are several other hunks missing direct references to
> "repository.h" too.

Yeah, you're right. Let me go through all the commits and double
check whether includes need to change. Oh, well... sounds like fun
*sigh*

Patrick
