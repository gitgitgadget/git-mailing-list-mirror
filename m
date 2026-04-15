Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1B22CBE6
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241024; cv=none; b=jpJotCKhyl0eXXp0SNcidTp5cgcKCaUI02z/oiFu5BR/F2CVkYPWEgdpCFtxxfdG4OHvh8B6afCIbi+pRxhIS7SnEVzVnzfjBRfrCLB3K9prvQuzJTTc9pTA8lRoEXvYKB74xR9lnyCFIAfFBIY5V1eZcVz8W8tm30DBVZYrFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241024; c=relaxed/simple;
	bh=+6f9AYxM5JDaf/nLzeKg6fYoAxq+7RVrjOhj15Jy+G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUjAVhht8o/QqnYFWODeYVBagmkXhTLCGDVM2MKcrcZ0uIjliSgyDpmxfMUEAa7bH6K3aYuTzqH82ZBDkUxoPpg2KzC8l8XPWliikfgRRzAVDULvJmPzlBKDN962DmhnC4PV3JzieGapxXEwmpTAlfKMA2WzWzyMpYf+glaVA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSMAKhvU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSMAKhvU"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e7b8e3f38so24062621fa.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241021; x=1776845821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crscsUcDLJHHEiqNNi9O8aGPYFkcpH4uNV0U23Lz2kQ=;
        b=jSMAKhvUHOf4LArbmi8xN/0dpBa+foXZcKJjW559pBd2WZry80feLEJVPId/ahZcAR
         VzT7r3NV/3wtw4qNDjC8uNq0xXWB3KT42iMvspNk0P/9bZG6IFBgPwXolPGcEnvkSwED
         AEUURUMtEDw8Ki0WukXepFTb46r+SuMPHOPQ5g9OL3Jb2iwo8zbd105W8pqWN+cnQh7W
         JX0lbo+oxZAlfBYO15gjXuxPCTdq7yVKv48s/xp0ZKOehjYriBdGRr62ybRczmYAtIsj
         T/u0Hnt7Qcll2k7Zd3ErWbRU0j33u9g3l/9iSadVEumtxidi7EFzXv5lKc5wEWM9KxIp
         32XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241021; x=1776845821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crscsUcDLJHHEiqNNi9O8aGPYFkcpH4uNV0U23Lz2kQ=;
        b=ULMaADTIshsocbTubxzfr4DFgHbwUZnyRRxi9wHDM9S71sjdQA85q5aL4DPpwk9MnY
         Jcz3k3b/szNtnWp8dhdHeq3I2uB4AlPKrB/w0NgIooqQsZmpk5azs0vF0l42E9ZTPnMI
         spdnBH+ZrPFLnyccrcL7lu7zEyJnEra0IOLbXlVALSw/JGBSX+Rfuw7wmOF+brv3dTri
         nBIHcwp7nr5OcZq9iOFvITLycVdp/u1yXi13iKK+6RqLOiU5t07ZQ8u7plveXvj8cqsV
         iEWCnBvL05ZX0GQn6GDDOXJjyPQrmR3Zhm6oTDeXLv/dnEbzJAE80Wi+szxJ74hnmIqx
         X9Ww==
X-Forwarded-Encrypted: i=1; AFNElJ8XSX0i6AwgxX1WbVRcgu6VKGv8tL5L01CyM+O2dbmVEd5DFFNMclsqCcft/Iwm81hL++I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiaGUEF1Ml+MZlt65ZIaxvFaAdWurcjHFskY991XhPmPHDc62g
	moC2PAKXHOUAa+dMc1sw/fgQdibOTJnSGRHJsYlIeRBUDOnR70E+WeyJ
X-Gm-Gg: AeBDietUf5rlXA2PBVjHzNyoSfsoXQDsMFn3uvFhzWkJOduXmmh17a/35ySvTFpbQaJ
	cuTbYPMO0Mny3fLrmcND4eVtsUR+Y4fJznfdEW5mV/coUam1zHn95Ais98jRXnO9N8gyrJRQZCd
	liJ5Z1ip28nTM/J+Fk54EHUA6znvs6wvJexZMwv5dDSw7lt6IipVEiVaR/baggKLggMpdxUHKzP
	9DoG41BKEzHDdPBwRyxDIaYRz06y1BhTeuUpJpiTozDD6YRPBPE3aWn/c2hTZvp2U/URNg0Yruz
	IbFk/UYBioC0FGAYQg6ybzQrs7yoS9Inb15RrEn0J+JKxtJNrSOqk9A8SXpi2TgBWu47ghLvwFz
	oRHTFwtBjoYxawJaW4hhRkmtnY1Tm9VbmbTI7QY8aHIdqZDVTn2BTyPblxIcM97mRfG7vaSzQ4D
	TzGZrx5NbkfGUwWIpIkqh1i6ClqO60ThIw1+95s0png5676Yocc1Z1+84sAHZJ3T5psLEJicHv5
	G64kH2ybudMxpAjdKPKfXqV/hPtZbUP
X-Received: by 2002:a05:6512:32c1:b0:5a3:feed:31cc with SMTP id 2adb3069b0e04-5a3feed320emr3270763e87.24.1776241021222;
        Wed, 15 Apr 2026 01:17:01 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a2fa62csm281601e87.59.2026.04.15.01.17.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 01:17:00 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Wed, 15 Apr 2026 10:16:59 +0200
Message-ID: <20260415081659.86783-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
References: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +	if (old_branch_info.name)
> > +		stash_label_base = old_branch_info.name;
> > +	else if (old_branch_info.commit) {
> > +		strbuf_add_unique_abbrev(&old_commit_shortname,
> > +					 &old_branch_info.commit->object.oid,
> > +					 DEFAULT_ABBREV);
> > +		stash_label_base = old_commit_shortname.buf;
> > +	}
> > +
> >   	if (do_merge) {
> >   		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> > +		if (ret && opts->merge) {
> 
> As we saw above merge_working_tree() can return non-zero for a variety 
> of reasons. We only want to try stashing if the call to unpack_trees() 
> failed. Even then if you look at the list of errors in unpack-trees.h 
> you'll see that only a few of them relate to problems that can be solved 
> by stashing. The old code just tried merging whenever unpack_trees() 
> failed so it probably not so bad to do the same here but we should not 
> be stashing if merge_working_tree() returns before calling unpack_trees().

What you are saying makes a lot of sense.

I gave this a shot now, trying to return an error code that only attempts
the stashing when it has a chance of improving the outcome. Not at all sure
if it's correct though!

> > +						   autostash_msg.buf);
> > +			created_autostash = 1;
> > +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> > +		}
> >   		if (ret) {
> 
> I'm confused by this - if we stash then don't we expect the call to 
> unpack_trees() in merge_working_tree() to succeed and therefore return 
> 0? If opts->merge is false then we should not be trying to apply the 
> stash when merge_working_tree() fails.

I'm attempting to fix this by making call to apply_autostash_ref
conditional on whether or not the autostash was actually created. Makes
sense?


Harald
