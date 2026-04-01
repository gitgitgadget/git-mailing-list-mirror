Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF493CF666
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775082804; cv=none; b=WCtDwrjNybNXAMavhIv8GlpVnixgIl+xe8yry6U8T36+VTBA6YmSizhBAp7ucZqGRa3AfgTWdWOF+e2ulXwR/GK17yf4f03DuOcsVagySWtEOcdVvktl+4upeezqQOfgnqbJhk9nUXhxDjEGa0bHSiwSaJ2794/ICZ5f+3/luVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775082804; c=relaxed/simple;
	bh=pKxKNfoL9u098jHXGbo5EJPU/MI70OMXBPBcxxRcLpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WZx0dDVX1MAVgC5chzZbn8xOfvwINnQS8DZ0nb0fZ4Ad4uwpg9iROKZqMO4O+tsYDCzmognRppcKMwoxbwfXlS8t5+vY6+7pfc/80EI9VWou6kIh5TKz0U8bjTQzR5qwqfGomn/XxPN863QB4KqyV/E1AdKuofO/1OVuBJXX1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x7DltkN0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4IPVW7V; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x7DltkN0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4IPVW7V"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C80071D000F5;
	Wed,  1 Apr 2026 18:33:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 01 Apr 2026 18:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775082788; x=1775169188; bh=umaLfLUZnX
	PhLk1aGoWN7ECHBp49sKM2dy/3ae9pplc=; b=x7DltkN0tSpjquMSUQC/MdDxR2
	veM+uZK/+dq+lkkhcg36/W6Q1JgP30pFkJFfk3YcLXG8hGMarDUGYOL0XhlmAOGS
	AJ2VmUcJA9qjMSBwdG35WbJ1epjJ3uYer0MIn7mQQklOCzfWLUZ4vz24TzH7kMVs
	NezJO78Q11qwj4GRv/Uq2pvHja8dTVv/SzshQjnVO/Y415zb+wBQfU8kMI/OpxU1
	YQkjQHPNzJioi6AN5uEsn0Q/QNV+L0WS1WqVYb0TE4eZJPldClij540PnnZty1ij
	Yq4AJ0kVBr9TuRb/ikAtvuBQ4tjDFvrEc7+5HOEedAVqSkWuDIKc6Wewa+wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775082788; x=1775169188; bh=umaLfLUZnXPhLk1aGoWN7ECHBp49sKM2dy/
	3ae9pplc=; b=A4IPVW7VTVKaTVcb9Z2VE+UyornOEaKfpIsWZzTJ0ekPRQf3X3b
	nChmNyLRAvW/ozyrCjvqn8hyVc5Dx4e6yOkCxc1yURVARaitKnsxYPhhCKnPf0BT
	NO3ZKX9M3HcQyogWCiG+0hYcbJ/ZULEpxdLNy1yZquPQNJGXiXlIrW1Bb1AjNBni
	NiSr3Z3Grb6qsWQrgUCGiJCa/TXCZLpqpsJFB3rrm7GRRWHOT8BsGS2MszE2ZPPx
	yvb4asMFW2BnvKuKa9dr430vjDImWs0/WBpE6EodYioQth/ddesjem4fyIDg9Vb6
	M0GmGtBNkHgo2NR1mE+rhemWLzWbushNX5Q==
X-ME-Sender: <xms:JJ3NaeoFHbIHypZtQXUbfoqnGrtC6gqsGuOmXdpbJBuE5BcoEbbW8A>
    <xme:JJ3NaUG4NfsYuY3wZ1bGaTJINsE46IqZ9OUUrx_0aWCJfUNvZpIcDNS4_hekgUuWq
    JK_WrO2Qv4fW6_FZ2J_PSX8nHqQk8NvdVKaKQ6BSwAXMWxl-qeCRA>
X-ME-Received: <xmr:JJ3NaQni06flurY82DCdfTbOwv7K-CrAaP4M5dQz-vZx2CZEdRRzkKJ48u_b1uR60aG3LZ_LfOqK9akW7zYvcHtPOjZmsmcqqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggf
    efiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JJ3NaXnXYem36SWcoviVpCH3dpQizUKQYHsHsNC1cZ_UlMdt_tfWaw>
    <xmx:JJ3NaRvwLELB-IJHjFOqSkNzEquLi_BNmY26igGRxtqUVQlEELC2AA>
    <xmx:JJ3Naan-T1raeGoKmf2KgXULbEnJDHs2unxh0FPWA-iWJvPMgeEWbQ>
    <xmx:JJ3NactNehJyMq8x34ukFbRwWWs_lG0ur53tiymOID_EEoRRTQbAqQ>
    <xmx:JJ3NacNa30oM5_5JUBUJbe-fS-pFImJv4BQHTpHiU6raP_IO5W31pFVh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 18:33:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: minor typo fixes in 2.54.0 draft
In-Reply-To: <20260401211436.489478-1-tmz@pobox.com> (Todd Zullinger's message
	of "Wed, 1 Apr 2026 17:14:36 -0400")
References: <20260401211436.489478-1-tmz@pobox.com>
Date: Wed, 01 Apr 2026 15:33:07 -0700
Message-ID: <xmqqmrzmtios.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/RelNotes/2.54.0.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.

>
> diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
> index 85b15284f3..4ce30d9d5b 100644
> --- a/Documentation/RelNotes/2.54.0.adoc
> +++ b/Documentation/RelNotes/2.54.0.adoc
> @@ -122,7 +122,7 @@ Performance, Internal Implementation, Development Support etc.
>  
>   * Improve set-up time of a perf test.
>  
> - * ISO C23 redefines strchr and friends that tradiotionally took
> + * ISO C23 redefines strchr and friends that traditionally took
>     a const pointer and returned a non-const pointer derived from it to
>     preserve constness (i.e., if you ask for a substring in a const
>     string, you get a const pointer to the substring).  Update code
> @@ -221,7 +221,7 @@ Performance, Internal Implementation, Development Support etc.
>     many source files inside subdirectories unaffected, which has been
>     corrected.
>  
> - * The run_command() API lost its implicit dependencyon the singleton
> + * The run_command() API lost its implicit dependency on the singleton
>     `the_repository` instance.
>  
>   * The unit test helper function was taught to use backslash +
