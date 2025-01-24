Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECC156991
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705250; cv=none; b=NWAA3l2/UZCabpGEOGDjiacSOKXhs0J9Fh2BmPZRBWoyWsKQHGYJpT1OzAp6eByS9A8FSJDtcyQGGZ+ld6ZRcUHc06nw9NOcrlaKr2EZZv06V/cnFJCpEz8J80GM+nJjsYmjoJgTu4aM1AeSeBoPXxPK+JgPwSG8r7Nrqw19DCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705250; c=relaxed/simple;
	bh=4p8qHEZEc/RD94UIR+xZz1rkrvugwpxJWwPJarEOlWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkqcSG3PMWR9ov62QAXQFG7tG+H5cbPHgfy1/jMW6LfFhfSDES3/6sIhyQR+qtMEg71qDmEL0pvRMCy9AXKPhtbOPInAirf8CHwWD0LMzcAr13xWADSaoBo+ZD/LqV7ltp5du6cq0LMMfGKAs+BTU0ca/6YgCncoSNjYMCCDjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cJK3hfVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQMpIZcg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJK3hfVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQMpIZcg"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E87C62540192;
	Fri, 24 Jan 2025 02:54:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 24 Jan 2025 02:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737705247; x=1737791647; bh=IIytqX6dYJ
	K60xSKe6uD0rxQaP+jpapPDgnMNxAmPyM=; b=cJK3hfVKTDf40P5Z0DxmET6xuy
	WR/teCXKskIBYrBpcqQvhsFfBB4P4bguzf1IlDGGxIj81efQNspDgaIXrOGOYqvW
	3bhk8lspFqA/xwQfyF+HhxBQDVoAa5B3b/C/Fp1cQEcly3Udea8aDI8zCt0mWbiU
	eHMjjpqOfxj3tswRGuRyoQ5Uoge5dyO1VGplLu3HXlGpOkKaDeuF4F1G0LVYDDj8
	rpCyuBgSzqUTJF0XZUE7aYQsoQm0npI3ZJND4exjMFtXi81FoT0n9KtsFxxbqWM8
	SVZAUbaa0mD3IEeI+7hzr4vKAEb7Gsk2R5qb/FdX+9/yDfph9w6lNQuaJyPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737705247; x=1737791647; bh=IIytqX6dYJK60xSKe6uD0rxQaP+jpapPDgn
	MNxAmPyM=; b=BQMpIZcgARmqH1yzZA2K8n2QUnhcWPlkaZT8cfB/D+1fbG5ikcU
	TUsK/2FDT93iQQasHepq+3JusZjbehcS7z5uW4OhbKSXC+UaU+gLCojpAKZzz9D2
	+NkFetaz/vqNG+YUzcaRR4r9RcCEMAFFXHYO8ywnCLLhCU8nD6lFo8Iimn0HQ0HU
	qCVSMKv7uaSrtsux8bOpU1T41FEJEMUMZdL0jHgn5eAZvClOpzg1OMJOTaHKi5KP
	Hajm+FH8R8+kLL3FQr6f8UplAyWgWZW6hKsHzSsKp6GPSSLT0LcX9XSuYxE7fcxl
	U/wHPsQ/9sdlUsaRh6aFZT/CXh8T8KyhU6w==
X-ME-Sender: <xms:H0eTZ5GnRQ39hs4Q5gh9JLdDa6sdqcApAyZjf5g9H5QWE5Pwr9bhCA>
    <xme:H0eTZ-W61rqhR_6Wb1bAP7GASfu1QpJI08mf89J5Md2pmVo4LuxWfk3zI00U0wYlf
    wyfd4r9p3jmE7gADQ>
X-ME-Received: <xmr:H0eTZ7Kp01GcS1GhBdlWyNDsR_7bXSJa2BJM4GR5T0gpG12uXljK04BDrAv3kzc-Pzus05nQuv7P12G2XwG3Wh4c58jDESbsy5TXqhPUgo4lTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdr
    vgguuh
X-ME-Proxy: <xmx:H0eTZ_GYkBKAgF_cF6YHXAxYjggulfMHRXRkGZzUGEYd0GJB7UpuWQ>
    <xmx:H0eTZ_VoaQmhVd4jzN3rFxKSbCy8Q3JiKswaFtWiM3LNiH_gPevZFQ>
    <xmx:H0eTZ6Nq8G7G8g4ofEcRe6QKDMedKpZ1uXf6Ss0AR9wYIw6sorY3uQ>
    <xmx:H0eTZ-1qDVfDuNRR1LtI9zxJ7Z7YqTbo731OXkis8Ks67mXZ6kTM0w>
    <xmx:H0eTZ1eHQDBxmlRZSbi0urFAplQrlUly_3l3ws1aQ0sLLyijsQ7iTjSR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 02:54:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6a2c6ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 07:54:05 +0000 (UTC)
Date: Fri, 24 Jan 2025 08:54:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/10] files-backend: add object check for regular ref
Message-ID: <Z5NHHEw1-5Qe7agN@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN1T3lJoj82ckl@ArchLinux>
 <Z4kQP5PBlgjXYNhs@pks.im>
 <Z4pdwiBvDlyC9TZW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pdwiBvDlyC9TZW@ArchLinux>

On Fri, Jan 17, 2025 at 09:40:18PM +0800, shejialuo wrote:
> On Thu, Jan 16, 2025 at 02:57:25PM +0100, Patrick Steinhardt wrote:
> > On Sun, Jan 05, 2025 at 09:49:09PM +0800, shejialuo wrote:
> > > Although we use "parse_loose_ref_content" to check whether the object id
> > > is correct, we never parse it into the "struct object" structure thus we
> > > ignore checking whether there is a real object existing in the repo and
> > > whether the object type is correct.
> > > 
> > > Use "parse_object" to parse the oid for the regular ref content. If the
> > > object does not exist, report the error to the user by reusing the fsck
> > > message "BAD_REF_CONTENT".
> > > 
> > > Then, we need to check the type of the object. Just like "git-fsck(1)",
> > > we only report "not a commit" error when the ref is a branch. Last,
> > > update the test to exercise the code.
> > 
> > I wonder whether it wouldn't make more sense to put this into a generic
> > part of `git refs verify`. This isn't a check for whether the format of
> > the files backend is correct, but rather a check whether the refdb is
> > sane. As such, it also applies do the reftable backend.
> > 
> > So should we maybe extend `git refs verify` so that it also knows to
> > perform generic checks that apply independent of the backend in use?
> > 
> 
> I somehow understand your meaning here and I think what your meaning
> here is that we could use internal ref method to parse the oid after we
> check the format of the ref files. Thus, we could totally make these two
> different kinds of checks separately.
> 
> However, if we have already parsed the raw ref files, we could reuse the
> parsed hex and then use "parse_object" to get the object id to check.
> This is the main reason why I add this check now.
> 
> And I agree with your thinking here. Actually, we may put this into
> object check part. Because in "git-fsck(1)", we parse the refdb to know
> whether an object is dangling or not.
> 
> I will postpone these checks in the later patches. Really thanks here
> for this wonderful suggestion.

Yeah. I'm thinking ahead a bit in this context and want to avoid that we
eventually have to reimplement the same set of checks for every single
ref backend that we have. So separating the backend-generic bits from
the non-generic ones is what I'm after.

Patrick
