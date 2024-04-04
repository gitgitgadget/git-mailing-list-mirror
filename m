Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CE131BDD
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255379; cv=none; b=nTKFRyOGTA2r8/zdu8VfuZZhDF8wucdOl6Lp9zERJu/FLQGhfHZJnWbCB9W7n/dSoguzyEU5vC+fJ7mmQJLt8sIGnNnoNKmaaEfAj8bqKrr5u4rEwR+/bCuQlZcsWs9BBfVqGRVU8S8kAnKt4OMnnnu8p6EA/fzaqFRl+iS6n6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255379; c=relaxed/simple;
	bh=5kKEnAgChSPZB3BZaLXfiZdESoVwQUokNtYm1Tq8Tqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5Q88jJIaXKiru5F6tdamGXDXokrX7TyZFPoZt3whGhuGKzS+HKtul5rC9elNAuS7M4K4CVs7RyR0NE8Q27fVQmiCyOBGK22Mc9eOinvYajBf09geqQ1J8rMlPrk65s1Suq7n896zaaG+etwZ/kdCxbR6i+sy6tm6G17QIz2Sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwsdkyGO; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwsdkyGO"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a4a14c52fcso766826eaf.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255377; x=1712860177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8xhok4rPCn6kzxHNysjpAtUfvQPgqdIBac6Omi3nn8=;
        b=VwsdkyGObNvRwQG54JuAyQjHu070Nr17YN2/3SzmRWl3OvZLMVO0IDx7UFdDzdP91l
         UW2A4jFYN8kl9zw55YOjL9Aj27BD8/xpeyZyr1YTEOqIdOwaDq8eYLoIS+O5AAwJcqmU
         nA5QXJAxvBAouoM/GYQBo2mB3CE3ezKABzSqFzR2eFQ8bwVuGu40B6dN8+ByHbcemr9e
         NiBcEghfnXZMxe3vyt6cfL0QnTbpMkNXg9QQdORohYnUnQ/XhvffYkxaWQVUulnmAR8P
         IZFXOC3aPGKDK5+tqRS0Y0EHm8OWegtkNqq6m+VIh7E0+8Xvl1pp2fww3Sjv/ETslSwM
         2iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255377; x=1712860177;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8xhok4rPCn6kzxHNysjpAtUfvQPgqdIBac6Omi3nn8=;
        b=uw5WfhPyqrw1bQndmuByPwD2J/++PbwSdX7dU9HXcLoVpNtE9BUYW8fRonzXBnQ4pW
         OqRBatK0W5VeTL99DoCB4MdkjtAxAmluahGfpeTFK5wgnDrrJc1pKG9J3hJE9GUIUWSu
         ghfwHVPx8YQbATnE8cI5BbGxLA/rdOg+0IllFEZggs1NAEEJSDXzuEqvVR97sK3Hc04b
         wSf2oBZAE8VrA6FdVH8x98sB/j+y6f/lVrtOs72eyTVTHAEIGLCd/Zy9hMf5NVS/VBuu
         4xJINb5jgH+rxxIFV3l937exJw7pFDP/iGLxkpVW7NS5X1H4ozUiYLUq2soXSLb0RXDV
         4UGw==
X-Forwarded-Encrypted: i=1; AJvYcCVaAph5TYVG9eLGa2dtcakwTLeLU7lwsQsIK1C4AZfy4cwCd9+vq4A0IefQSUB46/heJE0nJPdpLK5kOyoMR+gDECrY
X-Gm-Message-State: AOJu0Yyv1Fc0nt9GsTS/wi5oUh5ylO7zeVwEh6blU3cK1pi1SP7cOTXx
	MubLKxtcvBkZSsgZdIjRUCCHVKKwFQe9jSWYAynw5uJ/pnBlzLLG
X-Google-Smtp-Source: AGHT+IHyL21AE0sLcZVX5A4P7ruUN6W7VllDN1vfRXPFbDoDOMWridZEkQQyoaFB/a2PAgy5gXLNIQ==
X-Received: by 2002:a05:6820:1986:b0:5a5:639a:2fa7 with SMTP id bp6-20020a056820198600b005a5639a2fa7mr3544087oob.1.1712255377256;
        Thu, 04 Apr 2024 11:29:37 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bv5-20020a0568201b0500b005a4799f5428sm3734608oob.21.2024.04.04.11.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:29:36 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:28:39 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
Message-ID: <u47s7kwjrbcdseqb72nuplhs3tuaac5bl5dk6qqu7z3ptma5gn@qlrggnkip3yu>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <xmqq5xwy6z1b.fsf@gitster.g>
 <Zg2uS5JXjQZsVZhJ@framework>
 <Zg472uByuW6domfh@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg472uByuW6domfh@tanuki>

On 24/04/04 07:34AM, Patrick Steinhardt wrote:
> On Wed, Apr 03, 2024 at 09:30:19PM +0200, Patrick Steinhardt wrote:
> > On Wed, Apr 03, 2024 at 12:12:32PM -0700, Junio C Hamano wrote:
> > > "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > 
> > > > This is the second version my patch series that refactors the reftable
> > > > compaction strategy to instead follow a geometric sequence. Changes compared
> > > > to v1:
> > > >
> > > >  * Added GIT_TEST_REFTABLE_NO_AUTOCOMPACTION environment variable to disable
> > > >    reftable compaction when testing.
> > > >  * Refactored worktree tests in t0610-reftable-basics.sh to properly assert
> > > >    git-pack-refs(1) works as expected.
> > > >  * Added test to validate that alternating table sizes are compacted.
> > > >  * Added benchmark to compare compaction strategies.
> > > >  * Moved change that made compaction segment end inclusive to its own
> > > >    commit.
> > > >  * Added additional explanation in commits and comments and fixed typos.
> > > 
> > > Has anybody took a look at recent failures with this series present
> > > in 'seen' [*1*] and without [*2*] in osx-reftable jobs for t0610?
> > > 
> > > *1* https://github.com/git/git/actions/runs/8543205866/job/23406512990
> > > *2* https://github.com/git/git/actions/runs/8543840764/job/23408543876
> > 
> > I noticed that both `seen` and `next` started to fail in the GitLab
> > mirror today. Unless somebody else beats me to it I'll investigate
> > tomorrow what causes these.
> 
> Things work on GitLab CI again, all pipelines are green there now. Which
> probably also is because you have evicted this series from "seen". On
> GitHub most of the failures I see are still related to the regression in
> libcurl.
> 
> But your first link definitely is specific to the changes in this patch
> series and comes from a bad interaction with "ps/pack-refs-auto". That
> series added a few tests where the exact number of tables that exist is
> now different.
> 
> Justin wanted to make that series a dependency anyway, so I assume that
> he'll then address those issues.

Yes, I've made this series depend on "ps/pack-refs-auto" and have
updated the conflicting tests in the next version :)

-Justin

