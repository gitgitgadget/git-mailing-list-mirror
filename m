Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E53314AE
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854500; cv=none; b=ZRcVQ/Wloc6kuBHJ1CbrsMtAIzzq9gF4uZ7FNQ2oLsTEIfMk1LfatYOExzZ46qj3arZqI8NP2zppV0JRJ5c0hUXBDBGofOweo/4OsOATQmkfWTwfLFQzXGNvU+s5Kr8pu3BG3UCWYx5jNmciGsbjmAgWtiYx43fKBoeHKedALFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854500; c=relaxed/simple;
	bh=NtgzNanv15Vmn+WGnwN3P1YaiLIdFxCvQaAQSV0yfV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHlInlJ2P9LT46F27f88fwEzYsH2uzhrQQh0m9BZb+rjdhQuW+hkPuoD/BNb9Zs++VcOLSwUyNAAOolr8ClHlFfTAABQu2ZYwWKpqEsA75p2mdwr2oo9SPE8GPk7R57h5lDWhEge+j4hQ5PdeaH9TkF2+ITbD25HQmhQtoNPFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WXB1/1Uo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IG94yxJR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WXB1/1Uo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IG94yxJR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C2971D00023;
	Wed, 22 Apr 2026 06:41:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 06:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776854497; x=1776940897; bh=fAhMdlmila
	fGybkX4kVunMRVowYdQfl7XArAyQeacpQ=; b=WXB1/1UofU9ud5mI1gIrTee0ql
	cO9fVGJJMtO3BhcwASxZA5G0gNbByZYYfW7jxM1ZwqXSlIpdsopUvzfzDdAEhRgA
	pyCLBh38TQT8uk1Emd6qNRcnY3nCVPD4mAymb+MBG7jhmVUhE6wpObG7/UELR9ZG
	LL9qUP5xOuwBFzQaU8VHi/EZvp4/9opPkS0jN4po+d+SgcuF3DLnXAcgx4NOAlSG
	IDn/CksU4C+H9U8Yva+MEZypuFvkctcEFYPh1o84jSdBZxdpEUEckBZMCVHpIGui
	/rYFhOkyuKxW3ruMKdYgrtrwAmixgTngupVkx1CB/OAxLbW+wKuZRuo62tdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776854497; x=1776940897; bh=fAhMdlmilafGybkX4kVunMRVowYdQfl7XAr
	AyQeacpQ=; b=IG94yxJRyJfvJK/bZcLQex5Rnib+CyXzWkqC86MY/JyLk7XMDK3
	vuANA3u1fQNMUu8xtL3/O3IImLdukAfQcDcRkck+WIRNnQjxHcohbRpAfMs3IUPR
	5gRIDdU9ADP0Dkbzq7XTRi6OsnpmmOUJM14AGAANwTjxQ7CLs0JOyhYhG4PDjPAI
	CccRptNOzw2ysPe/hqQ1MmoBRbei2x4TeF9AXxhDeLtZ7fFLDUpE0RgX+uXdmg9H
	y0f3KL82L/przAbocOZBbXWmbWQ0HdXrftQOM7g2yVxG7bDEDpJj1a3YAYq72wEB
	1IctudXqbpnduUDqTqwPe9q+X/fB7Hnd3UQ==
X-ME-Sender: <xms:4aXoafgMKCHy2rDaOZVgdPC1BdUssxw4dI5bayQdE33bF0Ko79qI0Q>
    <xme:4aXoaTAWg4HVX717XyHnKa98Zwtk5Rpnmudc61GoNKmLy_Lx6Z3VxK6-riKHY5mXo
    xsYpbRADL-r7fvffWIbdmCWab027nCVKnDgg2FT8fXuDIRRcVgcIg>
X-ME-Received: <xmr:4aXoaUGg6WzGv8Wnw_dovFO5q5ZIHcoyoNrIhkmfFMenY7OAkSpLZ_0NM78NYMrJ7_KMtqbFAqRbDiaHjn-3f9gYUeFyeMG1cmzp0dYPa7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgr
    mhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4aXoabKvfzi4RhmsHvBVfykn67nf06_SCXx4m_sNgnlVKCAMjeixOw>
    <xmx:4aXoaYnwkMfrCSFnZK3xWmwhBJ-ZYQ5HswYHDlTNQeXkv7_F5m_bQw>
    <xmx:4aXoaTTOswt6QbrE94GU0NFOdg-Xqd6f4PMf2--mNsU1WtEQMb-tXQ>
    <xmx:4aXoaaKXrD7F35DEE5M6dHEd4WosrcyKITZwzsp5-S0iqOJgUn6Qrg>
    <xmx:4aXoaXG6uGSkjdRr2qFLdt-2CCOpVigZAxcleHFrUEqdKc7sDvgULpXa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 06:41:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5aa49fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 10:41:34 +0000 (UTC)
Date: Wed, 22 Apr 2026 12:41:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] refs/files: skip lock files during consistency checks
Message-ID: <aeil2Q_Mh_fKCwGa@pks.im>
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
 <20260422-refs-fsck-skip-lock-files-v2-1-9607571ae59a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-refs-fsck-skip-lock-files-v2-1-9607571ae59a@gmail.com>

On Wed, Apr 22, 2026 at 11:49:58AM +0200, Karthik Nayak wrote:
> Consistency checks in the files reference backend involve two steps:
> 
> 1. Iterate over all entries within the 'refs/' directory and call
> `files_fsck_ref()` on each.
> 2. Iterate over all root refs via `for_each_root_ref()` and call
> `files_fsck_ref()` on each.
> 
> `files_fsck_ref()` then runs all fsck checks defined in
> `fsck_refs_fn[]`. Step 2 goes through the refs API and only sees valid
> refs, but step 1 iterates the directory directly and will also encounter

Nit, obviously not worth a reroll: maybe do s/will/may/?

> intermediate '*.lock' files.
> 
> Currently, `files_fsck_refs_name()`, one of the functions in
> `fsck_refs_fn[]`, filters out lock files itself. The other function,
> `files_fsck_refs_content()`, has no such check and would parse the lock
> file. Any new function added to `fsck_refs_fn[]` would have the same
> problem.
> 
> Move the filter up into `files_fsck_refs_dir()`, where the directory
> iteration happens. Since step 2 cannot produce lock files, this is the
> only site where the filter is needed, and individual checks no longer
> have to re-implement it.

Makes sense.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index b3b0c25f84..1504a1e2f3 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>  			strbuf_addf(&refname, "worktrees/%s/", wt->id);
>  		strbuf_addf(&refname, "refs/%s", iter->relative_path);
>  
> +		filename = basename((char *) iter->path.buf);

Not a new issue, but this cast made me wonder. As it turns out,
basename(3p) is documented as "may modify the string pointed to by
path". I assume that this can happen if the path itself ends with a
slash for example, as in that case the basename should of course not
include the slash itself. So maybe it modifies the caller-provided path
directly in that case?

In any case, it shouldn't be much of an issue as we only use this on
discovered path names, and those cannot contain contain a trailing
slash.

Patrick
