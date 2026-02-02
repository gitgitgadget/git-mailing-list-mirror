Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E934DCCA
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072112; cv=none; b=VY02PbENKhS8RfRHgFR2np1A5wlin4K86y5dR3/JvXEj3i+mDBDQ22aR3Sd2KDNosdEdWIEKu1D7Zgn7abGMxjeWvAIGMStkeyDtmHdsENNcGsS+2zB6a7dyJHxL4j2aT72Y6CZqQtfbBTkLL9yolRDqT3k3RKTRJatumsigklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072112; c=relaxed/simple;
	bh=Uw74/wNmlwMRGoX+PxgwR+Wz0jbM3X7uclquocBckCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fU77MyFvoKCwp0sFuEDiJ1Pt2nv2pQcM4VvMTWqKY6H7oMrJxCiZBuZLQZRYI/sKCXrfZ/bohWL1rFUFS0D3xnoQdhPJRirXMB9xgtg7+gOzvyJQt1j3sEHCoZ1nkDo8fScsnQ03AxBVJ8WV/pP+Sdsc0tkziZ9+U2XsdQ3KtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OMH1krQw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vvbFNL8c; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OMH1krQw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vvbFNL8c"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DB0B7A0053;
	Mon,  2 Feb 2026 17:41:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 17:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770072110; x=1770158510; bh=P+OhtObsBU
	DdV2aFZlb7PxmhZoMv9gDRj7YAcSLi7gE=; b=OMH1krQwMJMGMky21gJ884zKj6
	lH0to67uSF7k6TZ8T9Zz8Br2rM+liCPbBbTFotYt3brejlpJQaD+ygJBcaisgj6+
	qNp2m6IVTJXbuvryDgjlyf/cjWHOA93bq8fyn6rQBU3ZmpcMOg2C6OHZjOv3MVnl
	KaXixbqgNoePHDhNdiZLCJTnfcIb+3M6czPKaVbGkdDmdxIc3ohXymV5is4l189M
	hf47DYtCsd8JcdtONyhGxBM5Sg4MV3K/4CMjNxCTkwsSRGIqhjw85Z5wgOoFUlt/
	qLxDFRf3ENpbxSCfAq7WeT1cA8PloUtHOpV+Tl83toUjk2rbO3YZkURkEpHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770072110; x=1770158510; bh=P+OhtObsBUDdV2aFZlb7PxmhZoMv9gDRj7Y
	AcSLi7gE=; b=vvbFNL8c8m7fGcoC4zUqKnak2c4R1wdlhutGkBkq6ahxaoOn3Qs
	d4hFKnpmlM+jzq2KwmZQZQW2MjIk6Aalq6XvcXk7gu6L5U0usudcV4NWknzOFJ+l
	9nP045kKNsX1XGmEBoG2ee+pnPvJl6TilR22JyaqFwIGXLaGNcVzqMOMDr01heA0
	P2158lQwkg5fW0LMtRTW2Vsn932rxJDiaT8kyeMqDFsMq3p4fIMz9VnARds2rlF4
	KLjJK82awVjq8Jy6v9nEy3qVt6HV1GcQVR4+T7Lkg3MMpFVi9/fWuaz6Npz489n8
	+saGuiPth/ufYpaPETX7QtMlTvHoE3vOxVw==
X-ME-Sender: <xms:LiiBafectwcOzgWTLGLWsnJhhfztw1CQ-INIeA6O_Y4By_U55BBPyw>
    <xme:LiiBacN_FonICsO9fnf86VbcOAuL84ADU7ur_dRs131tax7u-iVUGCF0RTE6o-jtN
    8fpcqeICafy8CkqlcaHJTlB8IYbrySaxh08PsagpYBNaabRX17MUg>
X-ME-Received: <xmr:LiiBadilC-Xq7LNOJUaoaqRxuC5hozsBZdDcoOs4jtp2oZZjkg_N79w0Bv3GLHe61FmUFuwVskwpSsdlVSEkVznnLngPlsz50A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:LiiBaf26NQnkT9SBepRs12sQ57H59d-Yib0K9GIjCtHil3xdfmtcTg>
    <xmx:LiiBaXghXaaQcbVEgi2PvT0CWbUhr5vZkaiZrR60YNB_Iqw2KQD4ow>
    <xmx:LiiBafdd77qFREH6l4OFAPWlpu-Q7HcEelp5L46iQaEtxIWZAIXV6g>
    <xmx:LiiBaan_9f8V5f6ZZa-jZGWGwvWwDwD2yNLYbben4CwLpC6lRwNy2A>
    <xmx:LiiBaRCKr6d8TuloFGu4AUZ21efEnihY428ecqKc0foi6MAY8IjShscE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 17:41:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with
 local repository instances
In-Reply-To: <20260202190155.79896-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 3 Feb 2026 00:27:14 +0530")
References: <CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
	<20260202190155.79896-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Mon, 02 Feb 2026 14:41:48 -0800
Message-ID: <xmqq8qdawyxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> > diff --git a/wt-status.c b/wt-status.c
>> > index e12adb26b9..9f4d8fda7f 100644
>> > --- a/wt-status.c
>> > +++ b/wt-status.c
>> > @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
>> >	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
>> >	s->use_color = GIT_COLOR_UNKNOWN;
>> >	s->relative_paths = 1;
>> > -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
>> > +	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
>> >					"HEAD", 0, NULL, NULL);
>> 
>> Wouldn't it make more sense to use the function argument 'r' here?
>
> In wt_status_prepare(), s->repo is initialized to r at the top of
> the function, so both refer to the same repository instance. However,
> using r directly is more explicit and avoids indirect use.
> will change this in V2.

Would we benefit from further clean-up, either before or after this
change, to lose the "struct repository *r" parameter, if we know
that we can depend on s->repo being the repository we are collecting
the status information in the wt_status structure for?
