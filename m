Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB82AEF5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784336; cv=none; b=u2reQDRDbr+pNfg3yMeBoW1DCpyXprwBN/DtwpG1ybmSFSm0b5ZHu6XoVPr5qDSX9xvlAWyIC9pt1J+aOCsNvlU5+AN8owiA7f0Q27c9ZpyFH6B0Qoom6oPUyYzAjoqNuoAKew7FlTPJ14z/lWKkT8Bxi+lYupaMNLtOcZw6REs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784336; c=relaxed/simple;
	bh=PJ2I8j5dqSanxlraPlHGChPXuPNnF9RDERw4OA5FkFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mRKog/Jukayy6c+qHBD6GAGtRL0jlAS259B62aaGgUsfX4M8ao3is/W9MG/tZP3SS82p7yvSnOtxx2XQdkG+YKGhEga4zBvGjB5O3bTcHLumvHtF0K4cNqkyS9haczajCqNidzoa91I8goL/rL8NqBOF/lkucNGb1cnCBrjSW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gtuxd/qx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktSExygj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gtuxd/qx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktSExygj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4E0D7A00BF;
	Thu, 17 Jul 2025 16:32:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 16:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752784332; x=1752870732; bh=m6vC6O4Wen
	+xQcIE7EVqWJs+Po+YO8y2/9zbd6hFgGE=; b=gtuxd/qx34vvhXSDBELH8LGoKd
	qhkYhIWx4oAsx2E/7rDUfhnu7YyxHYffKhtMUW72S1kTKmq8lbVUaOnKd08wm6KO
	VgsZ4VDcLPlSF46G/NSk7IKI+QVsknzKs/24R+hpelSm7/FSQD7yY1DpUQEi674T
	dEp9jd6z2rZ/L0ZmkQme4RxFsTanEgtOODGDWRediAfyoo0/1Wl3KMxYZIzAMOd7
	7aLEk1sCfH44Vl/oUMkTWSTnHJDv169AARItbeXN01rheFbL2YvP3PpdfJvgubzx
	5xFbuPFWoLVLC7dBVb6vl9LNPlI5ybqZCkB48bCVy9gTXgeGIMbAZ7nU8pwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752784332; x=1752870732; bh=m6vC6O4Wen+xQcIE7EVqWJs+Po+YO8y2/9z
	bd6hFgGE=; b=ktSExygjCF0wro1qjRwnGUaFoOOMvdB4Bx6geb7Vm2d6Rni8nSp
	rnUd7oJ515aB9sdIH5tBlld8Cj+iNwr5aFOey0RxZTqhrUOHewop3OE16idaY5Pm
	wCNPrdD2IlRPhQDZhTt0JNvZE8XfXIWg42dOIa3ayPESNQ/UAEAVL4oaBxPq4NMy
	accm2xneK/KNvYtbHvHIe5jeeUcRXge8rn6QvjkuZipYlS8/A86w7MYODt6TtDcs
	z/ET5Qc5GM7NxMIhQ/MPp9kloSNSWc7tRYzBv2fauMiwKJ6UyKpKQuNww2V8gwaQ
	Cg++OAwGSiVizVweNubVDBZUmAnW+gfc9iQ==
X-ME-Sender: <xms:zF15aHpGn1XaGYbPODo26uOENhZDURd5dClg_ESuQ83-NTIgzXVJ1Q>
    <xme:zF15aPN53j2ZRDj8BNmtcCbo_7400gYogrKY6hDJblFC4-Mj-SddFw_Fdje-rgB9p
    bZgg1iGXB_2ZH-yaA>
X-ME-Received: <xmr:zF15aKqs_e2Mmfsn9txv-dJTWjN8-2UJl3j-Zl_YThRUqVBMTX95eLXnljcjoITQ8a-g2wqu4tlRcDWU-d03daER5I1-LKEwAtQXDGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zF15aMcUkB6mReZYsjwusbMsos8rJDL8Q_-MkOOIiw1aR-ejJ3mR0Q>
    <xmx:zF15aIQCxYGv2ZN2NBfaSbluTRc4yuNAeP_I2b9kL1dsTYnCe1yVYg>
    <xmx:zF15aNYFr37k-ZDsXakZ2oFuWfaLFaNIrNISbr_i7TjRexgLWw82rg>
    <xmx:zF15aDe7dLPwXqwQazsboATJeKp0gTiFIp00uA1vAS30PmF6qM-z6A>
    <xmx:zF15aOtDCfVyzVmrLJbVZu1isuyDSw7fCqhb3rnxvjvmQ_sWbngnBjMO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 16:32:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  schwab@linux-m68k.org,
  phillip.wood123@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 2/5] ref-cache: remove unused function
 'find_ref_entry()'
In-Reply-To: <CAOLa=ZRqLgdnUz4Eeof0qdD_RkBYOKOT4oOoXEb0P386KQ0g8w@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 17 Jul 2025 12:31:07 -0700")
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
	<20250715-306-git-for-each-ref-pagination-v5-2-852d5a2f56e1@gmail.com>
	<xmqqtt3a7u08.fsf@gitster.g>
	<CAOLa=ZRqLgdnUz4Eeof0qdD_RkBYOKOT4oOoXEb0P386KQ0g8w@mail.gmail.com>
Date: Thu, 17 Jul 2025 13:32:10 -0700
Message-ID: <xmqqldom5zjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> The 'find_ref_entry' function is no longer used, so remove it.
>>
>> If my spelunking is correct, ba1c052f (ref_store: implement
>> `refs_peel_ref()` generically, 2017-09-25) is the commit that
>> removed the last caller of it.  Which may be worth noting here.
>>
>
> Indeed, I could also verify this by running
>
> $ git log -S find_ref_entry --oneline
> 2c90b85801 ref-cache: remove unused function 'find_ref_entry()'
> ba1c052fa6 ref_store: implement `refs_peel_ref()` generically
> 9939b33d6a packed-backend: rip out some now-unused code
> ....
>
> And looking at `ba1c052fa6`. I should've done this before. But thanks
> for the digging!
>
> I plan to address a few comments on this version, but I also see that
> you've merged it to master. Should I raise followups for noteworthy
> changes or a new version?

You mean it is now in 'next'?  Yes, please give incremental patches.
Finding some more gotchas even after v5 is a sign that they are
tricky enough that deserve separate explanation from the main part
of the series.  And I think the msan one Kyle and Peff found is also
tricky enough that evaded reviewers' eyes.

Thanks.

