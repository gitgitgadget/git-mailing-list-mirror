Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886D1547E4
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351610; cv=none; b=LU53+2MX6Hj+qX8kvk0XjkkW1oc4v66IUY7lVfvOiqp/yRnlYZf8LZlOwgICTX1PHRY4uSytFpIB30pIlJOS/R+hREzoyLWNanQmTrne+6mDQLcyVL+HMVzjOAt52hFYH4bVCVUEo9T8KgH5sQIqQNpuZKLmadZd5j7W6WSmzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351610; c=relaxed/simple;
	bh=MD33iqCL42a7S2fkQ6fDrT77sco5ra9dAGMx3dFaaYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ye8y9rWOBFfDPWL+yupSCm8XN4EAft2Fz2EH5ErVVW+q5yBRQt8AAJxS49OzX9U5OWTSMzS1tOTatULWOrkGa00XrBeaJIsGTzDpj8ziWznnoSBL0fW5I4kWC5k3PeEfnZ5XnBYfVteCc4j/60UoM8uYZvjXQdpy/YvX8wHhZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GzHLmi5U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBskYdZY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GzHLmi5U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBskYdZY"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F81F11400EE;
	Fri, 31 Jan 2025 14:26:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jan 2025 14:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738351607; x=1738438007; bh=DVSr8WX3Al
	c4CsaKWmyz8Iy7YGA+FYDX7kYjRqCP7No=; b=GzHLmi5UdtU6c24BLGYcRiYOE5
	EULj9ebQjEOcZVpi2+5e0z+N4XG0cX552ZC0hlqiPoUjjuDHqrRZmrYz+8PGaFW6
	LW/xCHNK48I5Are2DFLGMBsPOwCkAFuQ4/g+GfO11vHQDilZqn5Ms8orqP5s7JNr
	ZoulGceL+N3a28P8EEficSkYFbOFzC5KMom3pb6Hu7vc5zuGDSro21t7BeAWrsoF
	wkRA/ImsiMb85O5QX88ybHzq95mUFykSftDhRTxvJaCUkRBrsIcgiuh8hrSXzVuN
	q2UV543n5SbHItpJgBIU//Bw6mfNtHXbO+7GOzDCW9xxtoTUH//TBw77QGTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738351607; x=1738438007; bh=DVSr8WX3Alc4CsaKWmyz8Iy7YGA+FYDX7kY
	jRqCP7No=; b=aBskYdZYV5+Wjf7gehmmy99JdjLxnp8xe/A/IFLABpOwAYRB79v
	vkvwB0jAJZyUrGx7GgQ0x/hfkqOVFWkdtuAfpj8ClclE1LIZaOmszUXnyA0sELPf
	YDkqWGZjYKGmSasJMYzXsoMVdoN0P8sxDUInC0i7XHlLPplTCbVnqrczx4eSFkRY
	pkS4/abIrY9KbynunHdUDcnRP5cbToX2q3peC2TALWb+uM+LfhoEu1wXyDtbh/C4
	x8vQGwb0P2AcZY3ab+sbz+ZjkHNtSfyNCT+2ktJ74ry1ORJXBg1/Ss011Uqcv8YH
	DYRegL19ULHY63/Xguh+cvkJJ4SZHDrAPZQ==
X-ME-Sender: <xms:9iOdZw73M9xrtDKoRfIkqGc8sZXj_utdHVPmJhw8c4hp0xWa5M52gA>
    <xme:9iOdZx7h9J4Qwz40jmkLDoEi3LD6HdTWWoGDyFlC65ITRgQYpmBGAemgfnJtMEq9Z
    Z5r40lMjpyZmPpnlw>
X-ME-Received: <xmr:9iOdZ_cljTOm7yX8bjeGq1ltwr7Ntl3O6cHC7TmVz00R9Z3hmWPxucacdiG-XeZfJUyhSyis6HAQZZRc8GCCCQzfVgD4Dm7f-xHX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeliedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdr
    shgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehlrdhsrdhrseifvggsrd
    guvgdprhgtphhtthhopeholhhgrgdrphhilhhiphgvnhgtohesshhhohhpihhfhidrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9iOdZ1KAzDkD5mB86J0CYWwhNFTuljIgg8t8mVnpEAsqVcMub4hlzg>
    <xmx:9iOdZ0ITOPvLrAuiJo0La0czBxYeJCQrEzbPTIM6K4D29p4ZiHXGvg>
    <xmx:9iOdZ2wb7NVqW6OGprrPGh-3Jfip0pjwkuxsl9Y1YCPjkYEAv5WLHw>
    <xmx:9iOdZ4JGWJhPbkETEeb7ZZESF7vi8QudzW0hijKBntZqwqF3k2vl3g>
    <xmx:9yOdZz96vTzmZfQYUsvZpVWOpKhIYGYWJH5B6xIX9nEXYEd5jR9a-XwR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 14:26:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Olga
 Pilipenco <olga.pilipenco@shopify.com>
Subject: Re: [PATCH v3] worktree: detect from secondary worktree if main
 worktree is bare
In-Reply-To: <xmqqcyg294ft.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	31 Jan 2025 11:19:34 -0800")
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
	<pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com>
	<xmqqcyg294ft.fsf@gitster.g>
Date: Fri, 31 Jan 2025 11:26:45 -0800
Message-ID: <xmqq8qqq943u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +/*
>> +* When in a secondary worktree, and when extensions.worktreeConfig
>> +* is true, only $commondir/config and $commondir/worktrees/<id>/
>> +* config.worktree are consulted, hence any core.bare=true setting in
>> +* $commondir/config.worktree gets overlooked. Thus, check it manually
>> +* to determine if the repository is bare.
>> +*/
>> +static int is_main_worktree_bare(struct repository *repo)
>> +{
>> +	int bare = 0;
>> +	struct config_set cs = {0};
>> +	char *worktree_config = xstrfmt("%s/config.worktree", repo_get_common_dir(repo));
>> +
>> +	git_configset_init(&cs);
>> +	git_configset_add_file(&cs, worktree_config);
>> +	git_configset_get_bool(&cs, "core.bare", &bare);
>> +
>> +	git_configset_clear(&cs);
>> +	free(worktree_config);
>> +	return bare;
>> +}
>
> That is nicely described.
>
>>  /**
>>   * get the main worktree
>>   */
>> @@ -79,16 +101,11 @@ static struct worktree *get_main_worktree(int skip_reading_head)
>>  	CALLOC_ARRAY(worktree, 1);
>>  	worktree->repo = the_repository;
>>  	worktree->path = strbuf_detach(&worktree_path, NULL);
>> -	/*
>> -	 * NEEDSWORK: If this function is called from a secondary worktree and
>> -	 * config.worktree is present, is_bare_repository_cfg will reflect the
>> -	 * contents of config.worktree, not the contents of the main worktree.
>> -	 * This means that worktree->is_bare may be set to 0 even if the main
>> -	 * worktree is configured to be bare.
>> -	 */
>> -	worktree->is_bare = (is_bare_repository_cfg == 1) ||
>> -		is_bare_repository();
>>  	worktree->is_current = is_current_worktree(worktree);
>> +	worktree->is_bare = (is_bare_repository_cfg == 1) ||
>> +		is_bare_repository() ||
>> +		(!worktree->is_current && is_main_worktree_bare(the_repository));
>
> Is "this worktree does not have is_current bit set" equivalent to
> "this worktree is the main one, so is_main_worktree_bare() needs to
> be consulted"?  That linkage between "the is_current bit unset" and
> "is the main worktree" is not obvious to me.

Does the thinking behind it go like this?

    We grabbed the "main" worktree object and stored it in worktree;
    it is either our current worktree (in which case is_current is
    true), or it is not (in which case, is_current is false).  We
    know that the old logic failed when asking the "is it bare"
    question from a secondary worktree.  !worktree->is_current tells
    us that we _are_ asking the question from a secondary worktree,
    so we need to make the extra call to check config.worktree file
    as well in that case.

Perhaps the logic is clear to those who diagnosed the problem, wrote
the patch, and reviewed it, in which case there is no reason to
reroll.  Perhaps it was just me to whom it was not obvious that
the purpose of "is_current" check was not about "are we looking at
the main worktree" but was about "if we are not in the main worktree,
we need this extra check".

Thanks.
