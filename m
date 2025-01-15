Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFC4D599
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958262; cv=none; b=XrzW1OfhlD1E/t3516wdze/Mjj6CWRzeRHV3p6O6Z9Qmuzj7NiI0HBxyV8TrLWGvtXFwPI/1SE4cAbYK302ccG6+jql/O43OzwDrAssvxCz/zGQ9BoYYktG46TMB5XW4KvmyZWZ7C8s1mH8dy0RgYZ39XQuUBaniB0l2XpvXplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958262; c=relaxed/simple;
	bh=MzfByMw7rOmcBfjKVtHW8anczDYnorgElAoDcdzfFhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHGTxIcKM6yMXblLxgq2SCxC0ht1CE94j9Qc4cA/MC687owPv+sLWO1I3R87QUkRerE/faEqYWctvDWSztCn2SA8B1avwBYTJqFbqaWfi3zmj7nevIdYK0vT819fSKISP6ZYKm/3HC6jNw4tJiLRG1aLs4UOFu7IE/gw5G1sgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pW9WrRhh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o/1wT97o; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pW9WrRhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/1wT97o"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BBB4325401A1;
	Wed, 15 Jan 2025 11:24:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 11:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736958259; x=1737044659; bh=rOzzPbThCM
	F/GRl7nxRsfaLMr9O9ZMU9uSv6ogJluhA=; b=pW9WrRhh4iuPg6FWDSEc83t9qX
	6axM+k59pLUHZLBz08SLLNtaoiNBkcXgmDKPpZAWr5g0ppoA0gP2IAMl+q9tSG+G
	AClBLXldGJ16m2zWvOkeS8O/AM+8Xc1BHZ96MueY0x+jWp1dP/CxuufSO+BTmulG
	xuv0Kja/mfHTiWaB7gI2S0ZNJhWTYMhyu7PwnP4W1G6us0WMRiWFFMbYIvdb0q3+
	0tv1SQXyveVIoOcnZswzF/+197jf5L9oLP3pP96e2BdnrhCNLUTDuS9EwMuFUsDj
	2A/RKm5hvqK/aAAVCYf/RIbpjteLpO6fHT/AZTZSXS7BGZPYmGGtXMgO3org==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736958259; x=1737044659; bh=rOzzPbThCMF/GRl7nxRsfaLMr9O9ZMU9uSv
	6ogJluhA=; b=o/1wT97o3RFvhXwnN56JEyFhHN4wVnHPe8HK7u+nvqLAZzNMowe
	C51Qq9lAb+k18Svv5WBBFX5zNiA6yNwHjLgapw+ioQ5xVP/YzMSYxaO+yuFDAsUm
	wqtYakSbEgb2th4ADso0OHPbtQK6aWayDS7TbgFM1JkyroZuxwE05iMXYJ0Tzcue
	8cV+YY2t3O+sDPaK0NA13aOcd4IXqqbrM3twLiPNMiZ5J1oXhdTSVE2YBvzJkejI
	Hxa160sAVsBefUmmLSjeRP29+nFaGm3JnubnU+vZhSqK/KAEokKbKpFLnFuKjjwA
	844PwP8OAVXsshr1xq6eQ8yoyoIz3JUhSbw==
X-ME-Sender: <xms:M-GHZymSJwFqFjhDGD_wpFiwwGq1pXPVRTh3Em8iwmGF30XbSb8TGg>
    <xme:M-GHZ50t7J6oROh93MRHVBin_-KW2Pfy9h42DCRkLb0BLPw1gvAr-PPREdUg1APRW
    i1RQJg6z1bfhAeoZA>
X-ME-Received: <xmr:M-GHZwrSpgWb1aA4KEz1yFsJkxLRz7iQvLagnm_eqC66YYlaM6U9Z0DBACIRU12WkVE_JNynLBzxWWk20qZ2WD7LfQaZaLc3COeW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgthhifrggssehlih
    hnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:M-GHZ2nW19o6ava0AiRTV82R-XLnVNuHKs7aksZwwSLwcjtt9FVrIQ>
    <xmx:M-GHZw1lmAsxEmpvto9b_eMK9m6MHJj1cLQneyTsNSbqCt3zBFKmKw>
    <xmx:M-GHZ9tQj8nfvHCy9tOT_-0HP3585uRChb4ic1uK0y4gtnb-7g8PwA>
    <xmx:M-GHZ8XAK3t3w0H99XLdfdZPR-eK3b0tlqlefwXme19jboHk9R9smg>
    <xmx:M-GHZ0_LFBrPj6lgnpIlg6HoLPGg0Q9th8yyiXMinW3llkPSJNRQNvJ2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 11:24:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] sideband: mask control characters
In-Reply-To: <87sepk14yk.fsf@igel.home> (Andreas Schwab's message of "Wed, 15
	Jan 2025 16:17:55 +0100")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<f7fb7a38333cf6527345e3dbefaeb2cd8ade6429.1736878772.git.gitgitgadget@gmail.com>
	<87sepk14yk.fsf@igel.home>
Date: Wed, 15 Jan 2025 08:24:17 -0800
Message-ID: <xmqqo708yrim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jan 14 2025, Johannes Schindelin via GitGitGadget wrote:
>
>> diff --git a/sideband.c b/sideband.c
>> index 02805573fab..c0b1cb044a3 100644
>> --- a/sideband.c
>> +++ b/sideband.c
>> @@ -65,6 +65,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
>>  		list_config_item(list, prefix, keywords[i].keyword);
>>  }
>>  
>> +static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
>> +{
>> +	strbuf_grow(dest, n);
>> +	for (; n && *src; src++, n--) {
>> +		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
>
> The argument of iscntrl needs to be converted to unsigned char.

If this were system-provided one, you are absolutely correct.

But I think this comes from 

sane-ctype.h:15:#undef iscntrl
sane-ctype.h:40:#define iscntrl(x) (sane_istest(x,GIT_CNTRL))

and sane_istest() does the casting to uchar for us, so this may be
OK (even if it may be a bit misleading).

