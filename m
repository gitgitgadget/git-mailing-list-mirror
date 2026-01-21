Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC647ECC9
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999690; cv=none; b=b4jlPAhw9V2WFZIIq1kxzEqjpJ9Xt/jRAlymEPStoRaQ8rImGaSeju3uOTERFWM5KCsq2iwm/bxpdtu0dzCRUXidHOlkOUSioYV0IGpK9hyWZdanNyYwZleICzj4PujH9LeT91dgW0U6mNnK69SMJy5pR+BgDoQtwchkygnbP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999690; c=relaxed/simple;
	bh=sddZlecZzgCaJfcoDnRnb4kgbtaNyMSLB1rTc82KoWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkJ1MoOoyk/EAIb+iVR895ETmeEsfpPw0+2ebH1e1CRfd0u8YAgYHFmZw1qv3BI59JLa+LBaRkpqNrhPSbZ1g2PfthzajWAToEvovDsFv2Hq9iGXUztN0RIgQlb/sGnGZyYJykYg9FweNCbnfJiuzw+/b5Lvk2zXrAnSCiGt2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL8BFFQ7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL8BFFQ7"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so3890447a12.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768999686; x=1769604486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udB+rclw8I/EyaP1J/zVpJqdrl0T9DqbFRbybyNe+Jg=;
        b=XL8BFFQ7u5MN5sZoS2ONHXOYLdKPvdL7c/MvBxsjHLJhMvl6fk34/YqAojK/cGa4Ku
         JQG9ZLa0bWOVX5xd/gj4unFW7jqw1Qj8IhMlftl+dyISenD2CvHx94inSWJLhpOKwXVF
         ehfqdV98t3Yh8zQf9IYCBXxA4iNyvKhedfEUijDee0C2TAnseMLiJ53kN4cfltMdbISn
         ybMiIxp5FAW0iGhPB8l3utR6UNDkKCBynSB/5iWfTIwEE5uF2kzfQos7oDCrIbSMenvA
         fIRVWMFrxXmnqRHvcHqOCT0YesN+nMbFatPmzidYVpecAC4UEsSnVNUqyn7pgZe3q8cz
         qDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999686; x=1769604486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udB+rclw8I/EyaP1J/zVpJqdrl0T9DqbFRbybyNe+Jg=;
        b=AWak5Q0mhfcJhLc2kDvml3c41GHDknWupncSNVK1p6Edmut9bQd414Z29RRA4WqYs8
         rrWKMD1XiVy+HJhoYyPomd0mPQ3FIVzL9L8QDsVL9STiN18dFhHC5zxZSgJRYBbilxtf
         /EwN13imIDDpNnHiXPtF5kbUq4QGVuaGUvqTULlFRdrs4eG40EfdHH5Ze6J4XMkpUIiy
         ENwwiDn++9y9aa3uuIs7WIxcVnz3JgP4AOuoYYlNNN83kYYJ0Fh9XP7c0vavideBwNlN
         rIbU8ocENERWeEGprtEGPPf/btyBbSlXzVZigODnSdWxQ349Ac+pyvnVEt0NE2xqv2O8
         vq7w==
X-Gm-Message-State: AOJu0YwCjfLKYTf6IZcUGyDtfK9SaFDls5RQkYCpCa4ysobxE5RKCq+L
	WdZV7j+HugV/l+VlbPdKDrowiJLnNBu+a9cDk7HjgTMVdRi1yhbUYpjwE4Qsow==
X-Gm-Gg: AZuq6aLCFGGyZlKleClmnH8YiMB7TRroPcM1JSyS7eu0dYGfX/WEgJb+UX17UptLeuZ
	ZWk78mIRTIJUel0KEpxTkhw0Jo7c8qn8qrJ4+gooiq0MDhyJfHpEC/tCwQ4GPDUpbXerdw/swXA
	yr3qjAUUQVZeokl0Mlywi7Y3mWy5umHL/KpB6pV/vCsRWwu1PAv7v7PF7F96J0RIDA1HxUpchD0
	WkApsvPLQA3MvGPEb26xkEsiEWdYRTgs0fHXgGtt+5ilVnGA6uxY9EIft1MrytIT+D8W9fcy/aG
	VrqriE9bvQJm4jJeWCQ31PwsAKAuCrZcqf2ljKqtXiKbe9M8sVMoVMmYUKUgiEFKJ1dKqdbdcch
	3oEILOSwrjDn7K+uNx2GhSflwVOCkEu86XrFk76g8L3aBV/iG8RhetyhGAaX1dSsZjk+NdPxM5x
	xnnSeSmMp1L+M+25rTIOlzHKauIvDWn2zO8fvtn8tMRBt6AQ==
X-Received: by 2002:a05:6a21:3288:b0:38b:d9b5:5de2 with SMTP id adf61e73a8af0-38e00d5cc7cmr16994558637.50.1768999686431;
        Wed, 21 Jan 2026 04:48:06 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:4ac5:7f6c:c462:4847])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353032f43c7sm873234a91.8.2026.01.21.04.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:48:05 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH 3/3] show-index: remove global state variables
Date: Wed, 21 Jan 2026 18:17:20 +0530
Message-ID: <20260121124754.848110-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gmail.com>
References: <7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 20/01/2026 14:05, Shreyansh Paliwal wrote:
> > As Git is in the process of removing global state,
> > this function still relies on the global variables,
> > the_repository and the_hash_algo.
> > 
> > Remove the associated macro and the UNUSED attribute from
> > the repo parameter, and replace all uses of the_repository and
> > the_hash_algo with repo and repo->hash_algo, respectively.
> 
> I don't think that is a good idea because repo will be NULL outside of a 
> repository. For a lot of commands that does not matter because they 
> require a repository to run but judging from the first patch in this 
> series this command is supposed to be able to run outside a repository.
> 
> I'm increasingly of the opinion that adding a repository argument to the 
> builtin commands was a mistake as they all just use a single repository 
> so using "the_repository" seems perfectly reasonable. It leads to 
> problems like the segfault in this patch and takes attention away from 
> the much more useful task of moving our library code away from using 

That makes a lot of sense, especially for the commands
which are meant to run outside the repo as well.
In hindsight, the NULL repo issue and the segfault risk
should have been obvious to me, particularly given that I started
by creating the hash detection for no-repo cases :)

Anyways I will drop this patch in the next version.

> "the_repository". If you're interested in contributing to that effort 
> then there are a number of instances of "the_repository" in wt-status.c 
> that can be trivially replaced by the repository instance in "struct 
> wt_status" or the repository passed to the function. I'm not sure how 
> easy it is to remove them all - you might need to change the code to 
> pass a repository instance down the call chain in a few cases but there 
> are certainly quite a few that can be easily and usefully cleaned up.

Yes sure, I will take a look and see where I can contribute in wt-status.c,
towards reducing global-state usage.

Best,
Shreyansh
