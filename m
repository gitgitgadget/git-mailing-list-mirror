Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BC439344
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532798; cv=none; b=qXjaT2tPTySiw5myeYEr7emKH3mKMDVgen/9+QrYKsg3zYmxT/G+yqZ32XITmwoKQr7mVHOAEWMLfq5HNJIasum/1jqgYfBUrAHtbBg2a4hR+cCf1s09Z5T1I4fDqZhsUISl/aewPmKXH0YnrHfAkmPj1ZpKIKptuXVAUgDZLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532798; c=relaxed/simple;
	bh=k85iYQarb3FDiQMi/UC9Hh49ixkXNInsmAuhQ1FFykg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jb/KDP7GTBAKnOCXgh+ZIpSnEc/FQPXTOlkKXp2YfA6jqLyNdJLRoJN8CjFJr+jDKCG8ERtbN4vd4lPQ/09YZ9q44VfsgbgbnWUXT3yJfdreO1ZZNTISRAfQCq882HLX/yR0LiA5BcIKfKM3Sd4FVQ/wWSaRL0cgZ6ky0kG3raY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtakAJP3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1mDO8Pq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtakAJP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1mDO8Pq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 693E11400059;
	Wed,  8 Jul 2026 13:46:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 13:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783532796; x=1783619196; bh=8h7hRnWHQ7
	EI0m5nM9mrgxuayRqwtLJLB0EZSzwYWt0=; b=QtakAJP33cYXP5H36TVgXHDSWg
	lrGZm4FvdruBNKbRaNzREAwuYB/LlqsuVaXrXgs3zMTz0yaCMDq65UlL5JTnLgw7
	1QwGgyFOojKTL7+sTCVn2KtrE+LO82g3kCidD9F/0ZZHxIsjEGCh0VvyJAfD/s7n
	rZp4zYqyXKZ7CX37WF/teX4uJauAgO+x4zMagyMFr5TOJOMV67tTvoqnyMb3SQvH
	gH7g9KUpGvjOVy9rDRz7miJ9KYwAew0Kt3z5FevS19nMz+o/VoNjDTYYcdIxM5MH
	i10HzYf45PpXr9qJIdOvS02twmJCbchQzw0UX1/BOgoevN5wFc1nYyH0Mugw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783532796; x=1783619196; bh=8h7hRnWHQ7EI0m5nM9mrgxuayRqwtLJLB0E
	ZSzwYWt0=; b=g1mDO8PqRcfyHz1D/nQxQQ6ayLFNL7wvc/n8EeDDTR7MjaQvnLe
	n8gQrTHvTxssl7sS3RHODw4apPvjwcicerByQjRCoQDIDYmEREgNgE4w3Zzg9SQE
	6YvPvdr8KiMlLTbNQBZheK7ayggbzOPLB5qPo2usdi1Hx7AmyZVcCQDaZ8Nwpce3
	7wovTuRGlDiad2SPdrzK6BB5wusNLLv41sTN3D32Vm1Z8Dsq65rZQI/UWWsvyctb
	cNXxsOAVO+oIRe+LwToqLs6f9R9zebXng+tGlgtTn3NEnXbSEi4XsfEP5sphnVnW
	9hRDlP3HcHQDpnFeVbwZAMOMerwtVXbmGMw==
X-ME-Sender: <xms:_IxOah1eCNjYN8QR_ukwNTrN5l-hhtD3-6cULL5Z3_YSW47eJRDHwA>
    <xme:_IxOavHgCMwXtaB6Xs-y3Um1ZWuVq5AjjqGzxIKM8Ht93QyB9brIJREPxI3OX3hiZ
    6AatzCdN0TAMQ960YYYCQ02DLAHvqmSE1k1sH8jckk9zx3qkT9-VQ>
X-ME-Received: <xmr:_IxOam5a9qMFZuZw0BaHCw1kjg-cdoGyY6phvIS4mv7tSsSn0-gLMgL6D6INL8DriCr_sEtIQE9-K2D9yNRHMiHFy1P_Q-zq54nvWsU>
X-ME-Proxy-Cause: dmFkZTEFN8nWnntVRA1dTCmvtFGoI+CIamsD2aV4UNeoal9qZtAj6I+s9ONrMvjxW5WJbq
    VW43SvxF8ieejH6ogt3jrmUFtg4pY5NprbhGmpFEDJyNWDMVWATozhuPtDSRnZTrVX8egd
    D1/2M7/ZbLp6o7MBv5CSzTq48BGoGHttOcPJmQGtetSvhPfEys5rk0hyCvGxUnlqa/gDZ1
    l+ZMf37xjoB1ukWX+9xKCFjIBF01oWqURxCo7Fr/9Jc8YWaz4/0rYAtP8LchR5PyXDude5
    C4YCttjAGJiUQ+616EDvpDf2EA7mebevgsjm3AAZwodHin+JYY+Kl6t3eF/UnknpE5CVfL
    h7ylmpiaTjREPRoaBNRITEuFpoIjh9T24XpjZZSSdoP09evjwjuhDXhfmmKnslTqTuRImH
    x+ChAGuhpXoa0lCOGTlq7IGzd8DpJ+O81UcHvnUvFuYlCA8XUPdxWJvh9DsjKqTAgpEWup
    C5Bpd5tlndxxZxjWaOSTtTF7eVz/CbvyXvequrNT29Imaf8Wh/2Lxkn448DksVciOfyN0x
    hVyCVfxTRNwEaBHIgerczxz9zP+ZdSnhnsdoP/Mg75a47cipXk7x2NGPRaT6AXcEcuCZNf
    UTJH0gBmuZUo6VYT1v0x6OvmejdPgSm0OIL3uaXFIiGqWOilB+zKCcYEpEuQ
X-ME-Proxy: <xmx:_IxOattiq7__N0a0L4FEucRolhXgBlWZakW5GypRqKrYelHLFILRfg>
    <xmx:_IxOav4O70993Y3TLSNkJ0s97LSr3kks8S9q09EiJLhejVCqV_DkeA>
    <xmx:_IxOagXk_zQtsjhzHQQULYvxqyGVFOBhPLUdRJSDaplkCsDhc8bSBw>
    <xmx:_IxOap-nV4qzAlJnqw8Eydv-ZQvJ8Gdr8zZ7nNmGIAzzgdmzYvwTtw>
    <xmx:_IxOalmcOBYNSl32RVEqSVotNu_jGA_HkuisfK4sG0f5ojP2VZlExTWh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 13:46:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Kris Point <KrisPointCSGO@outlook.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] merge --abort: don't delete autostash before reset
 succeeds
In-Reply-To: <0b7e6d74-0287-4be5-a19f-ed8c5fbc9217@gmail.com> (Phillip Wood's
	message of "Wed, 8 Jul 2026 14:35:32 +0100")
References: <SI1PPF1BAF45F0FA46A6EED57B732BB04D7ABFF2@SI1PPF1BAF45F0F.apcprd02.prod.outlook.com>
	<0b7e6d74-0287-4be5-a19f-ed8c5fbc9217@gmail.com>
Date: Wed, 08 Jul 2026 10:46:34 -0700
Message-ID: <xmqq8q7lv0g5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm afraid I don't think this is the right solution. We only want to 
> save the stash if there are conflicts when we apply it - that is why 
> MERGE_AUTOSTASH is deleted before we do the reset - we want to prevent 
> remove_branch_state() from saving it. If the stash applies cleanly then 
> we should not save it. If the reset fails then we should keep 
> MERGE_AUTOSTASH along with the other merge state files rather than 
> saving the stash (which is actually what happens after this patch 
> because cmd_reset() dies before it calls remove_branch_state()).

Thanks for pointing it out that reset calls remove_branch_state(),
which in turn calls remove_merge_branch_state(), which in turn calls
save_autostash_ref().  We end up (when cmd_reset() is successful)
applying the autostash (which is good) but also saving a new stash.

> I think the solution is probably to stop calling 
> builtin/reset.c:cmd_reset() and instead ...

Great.  In general, it is a bad pattern we should find and fix for
cmd_A() to call cmd_B() in its implementation as a subroutine.  To
clean any such instance is a great thing to do.

> ...
> So we only delete MERGE_AUTOSTASH after a successful reset and we only 
> save the stash if it applies with conflicts. That's all a bit more 
> involved than the patch here - please do give me a shout if you want 
> some more information.
>
> Thanks
>
> Phillip

Thanks.
