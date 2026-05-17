Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C41A6813
	for <git@vger.kernel.org>; Sun, 17 May 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061274; cv=none; b=N/oWxqcGzMiAhl2YXpnozjsy2/bpkSwwGT2B5fvHDvcwVasZ/fN5DX3hcB4GTzbspjX4figdj5v5lAkUxjy8arynrbJW7KEGMsFhig7v6L0aW32LNgkce4rKNYeVC28bolM+O5qBiy7vkEtUi7JYSMT9Xv+09BpPTMFYIBs6Yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061274; c=relaxed/simple;
	bh=o6BEJoE0w0U7ihKGNC5pLG2DsHglzcDkf9KjyQrFvoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZaDVbSQJj7rE+duB0olAmv9zBm37yJ5+nxcvybrZ5i/2XwxoNpJf2QaiIeQlVWKsZHNis74cNR1fXlhpV6wJOB5rYpJRuVquYiKiwmc1gc9ZfrcivUGbfBPpPEveKkYSk36n4yAj7WN1brEkc3DKl16TLpCiBgTJ47fOUcOinB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c3mfc4Rq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KYahiTb2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c3mfc4Rq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYahiTb2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AFB91400033;
	Sun, 17 May 2026 19:41:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 17 May 2026 19:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779061272; x=1779147672; bh=lTp/EEcazK
	Lx0yaj9NTIEBDUXVxWZmtStxlbAaXa1RM=; b=c3mfc4RqPqbOA2fPiZ02vslZcp
	SGdNRO8ODZsR7IycPJ4E/dQSFjqZSHFZPYIRxnNA6QU/06IFqimziV8P5oYCDEt7
	7M7iJyWTiID30ywDY4WX1usr+2nsHiXIEGrygSTQUM1agN5IwM4bjKiSzOTiqV/o
	Vsm7nQ58vBomfw6sCmSEaby8wZrfw6jXWjEZjt31kDIHwjP2dKrlo0Oqrf1/Gj5d
	OKqLdEVX8JdkyUzapmLBH6/UQdWZZoAXVSfvMJ23xeeqdhjRwiQUr0MA/az7nefD
	vSNh75gDqhpT1pri0ZFUCIiqQqVPcZhDnlpEmjZ3Uxw5Rgz58Hzj0p5YpSSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779061272; x=1779147672; bh=lTp/EEcazKLx0yaj9NTIEBDUXVxWZmtStxl
	bAaXa1RM=; b=KYahiTb2eo2ajbv3Rq2ZvNAIvzZQQ0ZBf90IqWzwgUPVAv+MUCE
	zfm/Rqd6MPynQFJilNyB4yysz1mJPpM2h4bfKiBZPlujHLKrFDbwb/IvjThiiDl6
	BeFXjMa580ufPYfZmqwGID2XP7Nc4auifPu/wj4abMgwv7hBhzioANKotFaLl7n8
	bySRV4qfRIO3Phisq0EJhJImBMl8NWr2tI2IIS9/C1ycYMQOKmWaijuNPYOsqKBh
	dPV06bZlNgMeiWOUPjHZsJFK2kw4Vi/5JDqxLa90SHcLo8+n/oWzWvPAOoNf3ipB
	/J6XoCxvkVFMWzWCBa/Kd/ODesqW2gD/0BA==
X-ME-Sender: <xms:F1IKajrFZTu_7WrwdcoxeOT7rrdD7RiCMC_0SL_2rlhK0DxodjXwqA>
    <xme:F1IKahVXcM7tYlttY39Cnl1E3VkTkoZsgP9Dbg1qY10Hry79Ck-c15IKdAIjyTQaw
    gsnADAGEiqHG2O9KSGABkMnOKqvexvYiQUQKWk-Vo0TrEdhpbVLRw>
X-ME-Received: <xmr:F1IKaqBMMZrUk8riNbZeRpz3HmljKPdGqp1gnOz7BgrVfBE0a9fiu42u6eMH0mWP7rXcYODjey0vRgZqa_u7BYmFK49cgSZq3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:GFIKat3PQjkUGmPZvhsm9c7rRSDX6ID53MRjDrS9DGc8C8KGW_MF_Q>
    <xmx:GFIKak3eZBRcfMl2VnKFbVM-3vJX4J8taD8x1NZXGto3crTSH0PD9A>
    <xmx:GFIKaqDz15LY5pFZSTiSd9e8ERUtjGegyaD8j6OSxSEC9a6968cPgg>
    <xmx:GFIKar7xXPAl_9X7Lz6rABZl_EsnS_cTOzbb649nTaGsk062fHRZhg>
    <xmx:GFIKat1qnCTPG_Sd64zWUe3DkjRowQiydTn7WP0ErlanU4IXLImyOIeL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 19:41:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
In-Reply-To: <4d9604e2-036b-485e-aa93-53c35d539bed@malon.dev> (Tian Yuchen's
	message of "Mon, 18 May 2026 00:18:36 +0800")
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
	<20260420-pks-setup-wo-the-repository-v1-2-f4a81c4988e8@pks.im>
	<4d9604e2-036b-485e-aa93-53c35d539bed@malon.dev>
Date: Mon, 18 May 2026 08:41:10 +0900
Message-ID: <xmqqa4txd2p5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> On 4/20/26 16:22, Patrick Steinhardt wrote:
>
> I've noticed something that does not entirely convince me:
>
>> @@ -477,11 +476,13 @@ int is_inside_git_dir(void)
>>  	return inside_git_dir;
>>  }
>>  
>> -int is_inside_work_tree(void)
>> +int is_inside_work_tree(struct repository *repo)
>>  {
>> -	if (inside_work_tree < 0)
>> -		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
>> -	return inside_work_tree;
>> +	static struct strbuf buf = STRBUF_INIT;
>> +	const char *worktree = repo_get_work_tree(repo);
>> +	if (!worktree)
>> +		return 0;
>> +	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
>>  }
>> 
>
> Is it correct to statically allocate memory for the cache here? Could 
> this lead
> to memory overwriting issues in a multi-threaded environment?

I do not offhand know if other code paths that are called from this
function are thread-safe, but yeah, this use of file-scope static is
not a safe thing to do.
