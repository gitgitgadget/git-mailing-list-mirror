Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D716132A
	for <git@vger.kernel.org>; Thu, 21 May 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327069; cv=none; b=FVORTL7d5sL8WsdU8khogbe5gYnSYhxG0W6hUeuuqbCcWaNBom29UNhMtLnchWJVl8RoPXNtG97MauMRiu1GPTzQd9H3Cwrnlc61RVlfxXRC6A6L2Uk3dlNkeU2fPdQeoNuJOPLeIvqu2i3pW3s0mSDPnWDkwOT4x5aTd8RgeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327069; c=relaxed/simple;
	bh=Bl9XdMCioAtTJQ98qxxshcNhBN4lsvp95fqVjoVJY/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r40Sc4GSp/xhz0MzX3fhC7DuFpHBoXUosZkvbQYBeRqzyd/R/36WIRejasNUs5IV7VZKMhEpWCHaBvbb68PmJyekp8BEJv7QkKNB3V9E+I3gCvMVdHZPTmm5l/ZJtzsFmWR5JNhYvDrnws1d5sHCyDS2EdQY3xXpcIXGB/ZvkW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BElpKkbo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v/KZaNmx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BElpKkbo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v/KZaNmx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EEAD51D00060;
	Wed, 20 May 2026 21:30:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 20 May 2026 21:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779327055; x=1779413455; bh=laIjUdZnMp
	UcSrEW/2eF2wRXk0hwQEp9upw3d1Sid8c=; b=BElpKkboGqMBYh89ZWRaBc2rgP
	Fr51cYNX2IhXNHxCzJ4AAQ4c7sgB4YFywb+ibvPFwUrd5liBjtLMTtwOncF/urRD
	76b341IT43utzeo89OC+FcgwBby8tOgV2Tumi9bhBe/Vue27k7B0rBoBxiCArKaT
	CDzOtL1ym2vf7SAvS4Sk605PlJtjnKrzLHJSv5W5YQd6pscwLtO/Avvi0hyY48B0
	lAvXbUy4NM5PseUxvgY2sq+a+OtsJ8MUmPdzTt0tvHRMx0KaMWjRayVaQX4Xh29D
	EUE2L8BfkF38DPatjqPtrdFkFA5hTIiDWepVQm/RqmB5hKtw1Qu7QpbQZPZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779327055; x=1779413455; bh=laIjUdZnMpUcSrEW/2eF2wRXk0hwQEp9upw
	3d1Sid8c=; b=v/KZaNmxigLrWTR4Qb0fXa0BTixdIWyXU0cIrTJE8THl5OUuOES
	ZL6Aj5f3pKq55YtLupZ1Vvu0d1ox+AAThptekCNTZZogoNA5lITzXClWxZzaCmjF
	Obu/6dJBFL/RfgHpiife90TyPjTJZui5ciA9/uLBZAk+EGFLg45uAl37mCeKKV5W
	2xx1ZYnYfm6AJRtk3om0P0HMadgh+gJWqyyfvFavgTNI8uBC6BPTJ3ghG3SMADv5
	E31oKCjoLErNcYg3uMLoTUMtxwZ0AfdBHIo0Np8ye/iHe4R2mK0zz9zMaIhkL4fQ
	v0AOk19muO6HCbTySYC+aqXH1Fs/kSb3QAA==
X-ME-Sender: <xms:T2AOav9KnDskqjWCPXkEKaYaExxieDFrUMvwQnTJZdSRnThMpbWjow>
    <xme:T2AOat8MzxBiN2M6uQXQnYRDU_SGRF2UUbuXYc3Ed5S4QH8JTSkXAI5q2VwNfUmB7
    oHFkmYZ4ONPBSxfwxji3M8DErVJZ30PAoHx7PRBaRD8o0dggcmPkQ>
X-ME-Received: <xmr:T2AOavSwkFhBC3ZufKdAkJ6nn0BzoOi4ppcgvayT7mSuey0SXtGclGcWR2CML1EntNLNaZ7iYwW0ryOHwykNkRT_SgrgIlSzuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhrvghgsehhuhhrrhgvlhhlrd
    hnvghtpdhrtghpthhtohepvghrihhksegtvghrvhhinhgvugdrihhnpdhrtghpthhtohep
    ghhrvghgrdhhuhhrrhgvlhhlsegurghtrgguohhghhhqrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:T2AOahf-NfzI9X9NmViMakogcBQ1R3k2kFKNAPiHyNjUnHy6-mecZg>
    <xmx:T2AOajCuLlzgV2BSkh3d0ol273tdeLPq8WA1mfU4QzTDGkxBX1VfKw>
    <xmx:T2AOajmq7Lalnp21I3gkycie3E5d2VuXDhVhbPYFJ4pacn3d2PIHWw>
    <xmx:T2AOaucLGlL_925H6fD9VIs6CeGLN7xDvtASx50uTiT-wofV5KqUvw>
    <xmx:T2AOalNGE-SgayCMfxauS2oJP_Wk0Hm5ARuF5TzugD9jHl_7xR2SEh-2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 21:30:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Greg Hurrell
 <greg@hurrell.net>,  Erik Cervin Edin <erik@cervined.in>,  Greg Hurrell
 <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH v2] git-jump: pick a mode automatically when invoked
 without arguments
In-Reply-To: <xmqqik8h36al.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	21 May 2026 10:22:42 +0900")
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
	<pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
	<xmqqik8h36al.fsf@gitster.g>
Date: Thu, 21 May 2026 10:30:54 +0900
Message-ID: <xmqqecj535wx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +mode_auto() {
>> +	if test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true"; then
>> +		usage >&2
>> +		exit 1
>> +	fi
>
> That looks like a basic safety measure, which is good.
>
>> +	if test -n "$(git ls-files -u "$@")"; then
>> +		mode_merge "$@"
>> +	elif ! git diff --quiet "$@"; then
>> +		mode_diff "$@"
>> +	elif ! git diff --check >/dev/null 2>&1; then
>
> Shouldn't this "diff --check" be restricted by "$@" if given?

>> +		mode_ws "$@"

If there are any unstaged changes (possibly with whitespace errors),
'git diff --quiet' would exit with non-zero, so "elif ! git diff
--quiet" would be taken and we do mode_diff.  The user cannot rely
on "auto" to trigger mode_ws to check whitespace errors in the
working tree files because of this.  If there is no unstaged
changes, 'git diff --quiet' woudl exit with zero, so the control
comes to "git diff --check", but then there is nothing mode_ws to
work on in that case, right?  So it is not clear to me in what
situation this auto selection of mode_ws would help us.

>> +	else
>> +		usage >&2
>> +		exit 1
>> +	fi
>> +}
