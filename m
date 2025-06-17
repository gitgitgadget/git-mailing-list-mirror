Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC272ED153
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177844; cv=none; b=VcTSmIKTH4hBxIEx2lNJLjpL0iybNoozB5i8FqMkp8EvxuN548MibqIlPG4cLNFxYzuYLzs2VofpkTC/0oSNtmRltowBRtD7iVZ893+JM7O7gfXrDG52waN5/5QC/3XysUjsQHzstUheENeUVI+UTy5olujZCKnHSBswV66qmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177844; c=relaxed/simple;
	bh=OT1yHDrk+r3esRJInsX5ugRdTC4JhRzXvOIRpIe8gPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jZ3KK56blIixAAVQwn2srugK7d8H4u36fmx1/peqztDx/oJmquxC5yP41QG4eD2ntOaHhKWGH1eUZ+pAARP9Yu98cNG3c1vtuNQLQSfLIIVBIbvzR2cmbBnPbld+6Ev8QtZt/4RiZYnleWKeonTb6HvyD0bcMKGQCvW04zTrmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=16+qSMPP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faHhmIiK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="16+qSMPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faHhmIiK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 913BC25400F5;
	Tue, 17 Jun 2025 12:30:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 17 Jun 2025 12:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750177841; x=1750264241; bh=dgrL+y3nWw
	hU16wFG7jCYawKf3d/jyfifW4cnCmI7gk=; b=16+qSMPPgOc/Yr7SJk7KYUYViO
	GWe/BDrHEnj7rgdY/EMVRiA5HaTxscZGXEaFK60yyspsE1ee8fshLmivnHiM9NMh
	YiTqPsWqkvjrrDcdmEKCUpkg+eOoYZk+RWSqKJweCOxgLeaVT4BfmKKRdJTnuKFZ
	ZXUneJ+Pu7W7UXG/vq4uYo2bHBJPTmJVdPmcMEmRhkW0M4+EA9QDwtH9oe1tXhHH
	MP+FCvleT5+IimIwxtnFoApG6my/cO+B40g9GrhLuxD5TrrvylvxEn0vRnbm2npD
	0P9mm+UAg1lPemFCUPWHKkreXycj0xEPfDWxtxzKmPN0OFj+owTO8QX1FyBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750177841; x=1750264241; bh=dgrL+y3nWwhU16wFG7jCYawKf3d/jyfifW4
	cnCmI7gk=; b=faHhmIiKIYLusnGSmGgMkyGc3Y+7Gzp90japqOBMsUGBJ2eS9xs
	KWqUMqv6KhHLqlAzp2DC1S7O4r8TbQo6P2XVQf2W0b+ZI4HIHhwwqCg3TEMCFn7V
	JnR2B4/W0EbYnDlA4GNS7l78ZeysjvugYK3+p2pp+ftF12SGBRc017gOJOJ2vG1J
	ChuRV2dySsX2VNN29APEUfS+EfLMJD2W8zgT7tt6QMIiRfcyB5SU8Oh0YVewnMzU
	tHU75DbwG+p6CKbGdZvxYMCXnlTuTTgPjUxvi+/Kf4r7Jm2mOSeejuqfHwF9AZzW
	vplHWq9E960OwSoVMiBEWGBsf6xabPP71kA==
X-ME-Sender: <xms:MZhRaBWNKPds2-uy52aPMsNdLvNoB5CreXNJC1H0urh7SlTkK65OXg>
    <xme:MZhRaBkMVzgibddTAG4lfenYYP5TcqCNTqvzZp_gvZcWNQKp4soULMBbBEXTZiiD_
    Y3pj8DHGn0vkKVR2Q>
X-ME-Received: <xmr:MZhRaNb0Wv4h9ClSOphU5Wp3yPLduGrVUpWxcv9iLrP8xxkagfbHfrlnY2BSyZxsfN-JprCUZzICOScJveKT7IYYrlPtE73jq7pE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvg
    hkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MZhRaEXv3ZKPx2SwCDBEVvP1B_qPEVXW7K0TElU-_LwJQD6XwPs26A>
    <xmx:MZhRaLmiVpODl0AkpgvGcjVOuZFhFsWruP74sUVDS2hpl21BXviUxQ>
    <xmx:MZhRaBcbiIMfp2T5SYyJ6aSZrAHaHTWfxbIlpLXBdqtXzORC-ZpLBA>
    <xmx:MZhRaFHEG6cSRb4mceLX00ASE7EYDc2VvgzSXCtOxMtY1WMJoVVUOA>
    <xmx:MZhRaE1EmWc1g6p3iRZBNQrcKBqi_RLcWS2wLemkcCEQMVsnkHAqdV6s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 12:30:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH v4 3/3] environment: remove the global variable
 'sparse_expect_files_outside_of_patterns'
In-Reply-To: <a9e1e23685c476b106b3bdb0d37b4ac5dd98ee3a.1750157825.git.ayu.chandekar@gmail.com>
	(Ayush Chandekar's message of "Tue, 17 Jun 2025 17:36:36 +0530")
References: <cover.1750157825.git.ayu.chandekar@gmail.com>
	<a9e1e23685c476b106b3bdb0d37b4ac5dd98ee3a.1750157825.git.ayu.chandekar@gmail.com>
Date: Tue, 17 Jun 2025 09:30:39 -0700
Message-ID: <xmqqldpquy8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> diff --git a/sparse-index.c b/sparse-index.c
> index 444da8a753..5d87fc65c0 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> @@ -668,6 +667,9 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
>  
>  void clear_skip_worktree_from_present_files(struct index_state *istate)
>  {
> +	int sparse_expect_files_outside_of_patterns = 0;
> +	repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideofpatterns", 

There is a trailing whitespace here.

> +		&sparse_expect_files_outside_of_patterns);

