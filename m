Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68982E540C
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765318716; cv=none; b=kqL99EeliFgpEAunC7ewMV85E+dbCzC8UFQLtzvXXEfWE7vfEozwyCUS1oHkDaosVEvO8V4Lp5KRUbJf4aVvNz63aX5Pov5b/gAFVdNIZbxzxWMRhNBy2qB9jR1+VruiAnXBCy1AWaJgzHxQWLSNdHFsBw8hyvcT+/JuOsew1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765318716; c=relaxed/simple;
	bh=zQXdWHd2Fd+sRVTjcjWuXcpTe/nlwn7dROq7tlDScX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpqyANQh6xQRfei7v6cMLB9Ur+cEQ/WMa0l+rolmTuysNhTxWsS/42r2/MT5fOnVFgVYM1xHmI7/y5tWHXpt2h4uMhSv2b7rBgqOQWLUR7Bwfvu1jmBSe8JV3KKL/YnrIxzt6VdYBWgc9N42vob8eUN/twGkHG2iGdmoMoEH6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YyTg+PEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xh4YDh+Y; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YyTg+PEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xh4YDh+Y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E95017A0177;
	Tue,  9 Dec 2025 17:18:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 09 Dec 2025 17:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765318711; x=1765405111; bh=Kpxy1aQb54
	lVEgIkjTtKCM0osTPH6+WXR8a7tkrNqrk=; b=YyTg+PEUe3EtOYsvTRkUArBzA7
	4VlpbdStvPphTULZ6cCdMin4iZ3Od8pzQse0wkEqtIcDfrAWf8WQ2n3mh9M/3ckW
	XS2jZ4VDBCuDl2dEa7h4nCMuw1UfhG6mC+6E74RKGPnOsPdToIyNjwEgtM+FmVZa
	mGhou3yplrVv29sqj4DtrI/mg1XGplTAwo6wCHWy4/Q/c9CitgRxmoyNU3TlM+Sx
	+mK6qt44csnn/S8KFR7eWi60CR+J6U/60O7z7qd6a72glqP+ldoQZPYRMNO0aHxl
	1a3bZvnbekh/nok0+sx3Q0o2xSB/zT+QGae+cOysNGtQyG7e6fUN2+I+njtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765318711; x=1765405111; bh=Kpxy1aQb54lVEgIkjTtKCM0osTPH6+WXR8a
	7tkrNqrk=; b=Xh4YDh+YXmJnbk6U7pdPjB0wKsdYUfmgmyjH2SFM4xxR6uN+H8V
	FVMqcb3cy6zvsoLxk+iwKwHC4ZkYqLdoyLUZ/KQWb0mDOqb6rBRr4fr3M04mcjeN
	Zg3JCowfNMIaY+UeRoy8YQKVjbLeDd6qbxTCgaFWKEKFWB88AhAnnl3e+TUijeKV
	y4gOKy3QKLNJFADc2Oh4mLHCEtfc6tX2anJrsuLy0eD/apwVPX1sFV0gcPGWCkXF
	Llu6nnkzkZYWq8NvmHsZS/kiXrAsxvbHRwx0oyzt5TjNf/rtuJqDao64XpdqGeQQ
	kjraei4+KnHGg0IRI2ioMXbOjwRf3L9A7Mg==
X-ME-Sender: <xms:N6A4af2Faf_y4msNV-BAl2EejL0JQ4KHgGiDz8A_N8wtzWwxGdTzmQ>
    <xme:N6A4aZntnRxJdEbMXs2qJt3JGstNXaDtXFdV39L4LUhHfaJYLRhPr4-z5R4WShRWR
    2ReeHy9iG8kL3CFLlsecuuG3WQQz9xgDQZYuxNetq4sdmrJ-T893w>
X-ME-Received: <xmr:N6A4aWXKYk_WZEYjWxQJ56npzDO1ayWEVAdfWd3Mpgzbt4RpFst52yS5mM55XPcg1b9IgLpbNQGGw4BoLinilMgUpZqHKy-neA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshgrmhesshgrmhgsohhsthhotghkrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:N6A4afunGO9V_XuF4kNnW8j8td9lBH-U_rNISOaYmlMwZZnWbPIGbg>
    <xmx:N6A4aZZhy33mpzUgRBjalY5BKF9KT2Y5dZDoI7lehs95fL95hsQ24Q>
    <xmx:N6A4aeWYxqkSC2kWoRy4vKFy-V8NLx68YJvnfAnS_cA-ce7zpwALMQ>
    <xmx:N6A4aeQYejfhVGK7DqRg6k4HpCBeyOo46ZjxTFhpCgh3b_nOEYMnTA>
    <xmx:N6A4aSAtRx9MZ4OfWIA72MKOCT4arlVXNbhJOfupB77LYWlp_VFVb99C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 17:18:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam Bostock <sam@sambostock.ca>
Subject: Re: [PATCH] doc: fix `update-ref` `symref-create` formatting
In-Reply-To: <aTfOXDi4Ku0nGVnF@pks.im> (Patrick Steinhardt's message of "Tue,
	9 Dec 2025 08:23:08 +0100")
References: <pull.2123.git.git.1765261419802.gitgitgadget@gmail.com>
	<aTfOXDi4Ku0nGVnF@pks.im>
Date: Wed, 10 Dec 2025 07:18:29 +0900
Message-ID: <xmqqbjk7jo3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Dec 09, 2025 at 06:23:39AM +0000, Sam Bostock via GitGitGadget wrote:
>> From: Sam Bostock <sam@sambostock.ca>
>> 
>> `symref-create` should be followed `::`, not `:`. The lack of second
>> colon (`:`) causes it to appear as regular text (`<p>`) instead of as a
>> description list term (`<dt>`) in the HTML documentation.
>> 
>> Signed-off-by: Sam Bostock <sam@sambostock.ca>
>> ---
>>     doc: fix update-ref symref-create formatting
>> 
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2123%2Fsambostock%2Fpatch-1-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2123/sambostock/patch-1-v1
>> Pull-Request: https://github.com/git/git/pull/2123
>> 
>>  Documentation/git-update-ref.adoc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
>> index 9310ce9768..37a5019a8b 100644
>> --- a/Documentation/git-update-ref.adoc
>> +++ b/Documentation/git-update-ref.adoc
>> @@ -119,7 +119,7 @@ verify::
>>  	Verify <ref> against <old-oid> but do not change it.  If
>>  	<old-oid> is zero or missing, the ref must not exist.
>>  
>> -symref-create:
>> +symref-create::
>>  	Create symbolic ref <ref> with <new-target> after verifying that
>>  	it does not exist.
>
> This is an obvious fix indeed. Thanks, this looks good to me!
>
> Patrick

Thanks, both.  Queued.
