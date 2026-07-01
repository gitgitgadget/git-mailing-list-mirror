Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27A28DB54
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888927; cv=none; b=ONAG89Efb4lKOCTY6oPWCUAbk8oLG07pEeRDjC93TYNvs8LW2QW8yVc2NKk0t79s0OO9Gibl/H/ZH2XRSCwV84fpnnw26SZAr4NolUtKuqquWSQUtYpZHb5TNk6nG2IEQ77jpE9N0abg61Is/zAAJw2nbscfH/s8em589CHo1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888927; c=relaxed/simple;
	bh=2yMBCSWMNWvEA+VvTIhZkKJsQZwLIGS3c0mfbIU/ZZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX4mF9yiWZCZSAJyA46Z/U9IIbA4hnG+irCC+kemZQDJ6fe/jAkSuD0w0sBAvnrfLtkmp/5RaICSLE39DH3v3xro41DuTHRQKvKuSdoBILm/lcfcXECMqN0OOSnfP1lpWDZoBelX9OHmJFuwJf2C5+iRD0m8MHK9qL1cTtXIrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kc82DZ0/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTajcE9i; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kc82DZ0/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTajcE9i"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EF4F1400168;
	Wed,  1 Jul 2026 02:55:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 02:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782888925;
	 x=1782975325; bh=fjRN4ttoErj/i4ldD4/RBPSM3E0aIlCPnRiK5ELLbws=; b=
	kc82DZ0/Iu+lnyWkZtjg1uUfj+eqcc19+GpKIStJydBChiXIJW7D3jv5nRa8iyS6
	A10eSeCQKwOs1mwgs6OJhbHWAIxlcNH4ryMzRGE0SdkHeU0+ZvUSAp5h7Z2Wcpr+
	RmUZVoFdufNV2tor3uVhY8I9eSFITU2wuALuFGAwqTDviGrj1bUYg7S3t1F6aJg8
	MQBvL+yO4tNGxJASUqN62Xv+GlF3/OK7Hsn61yF3MKZ9rYCkux2wrJx698pTKbL5
	V7U5wQpXJcNeJ9RR2GoiEqafpQgIRYlHXcm9KlFQ7ZWMhzOIEjW/RNZ4LHpLKbgr
	YlXEmwzlnlAE3mnyF7vueg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782888925; x=
	1782975325; bh=fjRN4ttoErj/i4ldD4/RBPSM3E0aIlCPnRiK5ELLbws=; b=V
	TajcE9iQKxTGCGWK/Ud8SHv0IEpsx725zWgG3ohdjEJ2WuuWzOgOlmuXrilueqyt
	4QCxxmAJ4Nx9B676nABli0lPCYNKAb1uwUQ7YDuY5Q+W+QWoOzfGbwUaN9+7bFMW
	wUSE+IPKcq/jC3YYBaqseK5x5nIYhjqLDLpSiGVb6ulOBVU6Y+rXJsCqrD9GwPmS
	7f3omyyUImMD0nvdoGGh1JHQU7Bs7zaecYgQQEETcNpth4dQr++QnZO0axZk3mK8
	SG5pUqWB4DtAmtfk+RXY9scc445g15OqZwOU8XV9yRr86kMK32K72ILcjTqD2XQD
	EqvemYePUF44jYUb2Rn+g==
X-ME-Sender: <xms:3blEatsy8NIzZpknHFXDvWhn33wyLZlOO8mldQEzqA82XUziO2OB8w>
    <xme:3blEanLXifjBoh_MrPG-A1FQjAKa4lrgPkRP8CKedir_i0CaLY1Rpe-XjZbRw8hEK
    7saXkJYq4lE8EFvZM3dmzy06ETNwUXuNhNtZDKHT5NrtHFKxub-Ag>
X-ME-Received: <xmr:3blEau_7DWucrnPkLAY-3z9i2h9t7_LDZgQoYXzhdKUY691EdW9LsMjnzZPVU2wek4kVdjb7g_7CoVKb6yzm6LaUIqVpQcC8mP2ps_h5FEE>
X-ME-Proxy-Cause: dmFkZTGD4KJh4YYAz9/f0MH6W7NEy3tAi+fwqDAjv+zInilXON8ipyV4bSr1W5h/bvBxd7
    Ao7NHgw32GczCHDuY3su314/1S9UBvqhjsIC3JMiYgGE3MErPW/KotlogramOFZUzRNgtd
    Wo+pvuk1W5I2gQZjB5kwCjqoe4D4qnuP+plvyX8kW0sjllRPitv14F2VwedaDyKrxU/lv3
    dEpIHXbaTMQwqVj0n5tqfSXftj3DweoFQk+RGttEzOoEY3x5zsd1NDu/7i5G/z+u6WhyAc
    1DKk45bbq+GGMHBqMhS47lnasMKe472Dip0x+K5DPxHG2IPE/MG/tRBKGx4r7O1kwWcEWB
    Z44tgxOYMWecinzp2FrsblcTHI9xy3wy0odsOYukpCmsDx6C8nK0w1JwGZ8P4sE97cOjf5
    NLyEFT9JHyETQ7Ez5mFu05OOtpEKInMb/cxCJPjJIjCi6hcCxEmfBWn2UqVxwTTUM2kKeL
    9UKQQIcWmOxb0VpvuwUvV5GaZEWCuc8Ii9h897K27snjcZcRrKN8KwGB6jl5YLquUFqslD
    c2fDziTYhQ7k0bR2+FKUSf0IoVgvKLj5aJn4Bfn7oO/92aFjH792gpLscKs4nCbiLAbJCw
    SS0Oc9LSJoL1LutGlLZHvY2WkUpDJikJDIcnpQwfNztrhGQK9uNl9JtVf3sA
X-ME-Proxy: <xmx:3blEaoxe7vnGD11lu4GcRezcitEJoTAQRji1Om_7MRueBd7tNiYA7A>
    <xmx:3blEaj5lWpiYljUM7sevUVsgGJD4599n1rqs5ZGaPPQz32O16sNdbQ>
    <xmx:3blEan_KA71jjc0a99AoSKueH4LPTmm2NsSHiCzHeZwQJHwm_YWEUQ>
    <xmx:3blEagoQLEV7N8FAgtJ3c7lLdBEGQ_yqa3vrWVSc7C9dtlPOCmYiAQ>
    <xmx:3blEaurRfUugzSnm5jCzrrFAXdDbMd5h1WuT-niF9bkApfn9zGyL88km>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 02:55:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5dde90e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 06:55:22 +0000 (UTC)
Date: Wed, 1 Jul 2026 08:55:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <akS51xJSP4tkP_pS@pks.im>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
 <aj9wcFEb6oCRnfn2@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj9wcFEb6oCRnfn2@szeder.dev>

On Sat, Jun 27, 2026 at 08:40:48AM +0200, SZEDER Gábor wrote:
> On Mon, Jun 22, 2026 at 12:38:22PM +0200, Patrick Steinhardt wrote:
> > The Git project is not exactly the easiest project to get started in:
> > it's written in C and POSIX shell, with bits of Perl, Rust and other
> > languages sprinkled into it. On top of that, the project has grown
> > somewhat organically over time, making the codebase hard to navigate.
> > 
> > These are problems that we're aware of, and there have been and still
> > are efforts to clean up some of the technical debt that is natural to
> > exist an a project that is more than 20 years old. Furthermore, we
> > provide resources to newcomers that help them out like our coding
> > guidelines, code of conduct or "MyFirstContribution.adoc".
> > 
> > But there is a rather practical problem: finding your way around in our
> > project's tree is not easy. Doing a directory listing in the top-level
> > directory will present you with more than 550 files, which makes it
> > extremely hard for a newcomer to figure out what files they are even
> > supposed to look at. This makes the onboarding experience somewhat
> > harder than it really needs to be. This isn't only a problem for
> > newcomers though, as I myself struggle to find the files I am looking
> > for because of the sheer number of files.
> > 
> > Besides the problem of discoverability it also creates a problem of
> > structure. It is not obvious at all which files are part of "libgit.a"
> > and which files are only linked into our final executables. So while we
> > have this split in our build systems, that split is not evident at all
> > in our tree.
> > 
> > Introduce a new "lib/" directory and move all of our sources for
> > "libgit.a" into it to fix these issues. It makes the split we have
> > evident and reduces the number of files in our top-level tree from 550
> > files to ~80 files.
> > 
> > This is still a lot of files, but it's significantly easier to navigate
> > already. Furthermore, we can further iterate after this step and think
> > about introducing a better structure for remaining files, as well.
> 
> Please also discuss the drawbacks of this proposal, and try to argue
> convincingly that the benefits outweigh the drawbacks.

This is overall a subjective change, so there is no "right" or "wrong".
The reason why I think the pain is ultimately worth it is that it's a
one-time cost for a permanent improvement in discoverability. And that
improvement is especially helpful for newcomers, who already have a hard
time navigating the code base.

> I, for one, see myself being rather annoyed by regular 'git log
> lib/foo.c' stopping at the rename barrier, and by the limitations of
> '--follow'.

Right. As mentioned in a parallel subthread, I think this is a
deficiency in Git itself which we are in the best position to fix. If it
is proving to be painful, then it might even help to subject ourselves
to the same pain that other projects that do larger renames experience.
So it might motivate us to improve this area.

In any case, I'll amend these thoughts to the commit message, thanks!

Patrick
