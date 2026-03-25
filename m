Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957273E1CE5
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453817; cv=none; b=KH1Lp0nRxG1Y8l0zYNGUddIAvEF7VN82WoNNYuKtZgJYGV8lGoR4iQZw65lQgXR7OiXiIo6XKeC64wcaoWGl+umd/aN5LHM9SofezvBoZYgyE3vpQLnBTCceHYWObCzyUswtJnn5nfgwjWNhkQyK/UlP2Qjey4rShd71iATuup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453817; c=relaxed/simple;
	bh=bd14ekpdL55J526zO2yuWxF2h/iJhgIwLRNwrUxPVkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pFTK19pSfLzDccpec5DaFmJ30t4gBS1gD01jBWEOMqvQyKzWeboUU6vqeoRk+e2rQff9MUrT/yIV2p9RUUBAUY/ScFuesNYgvjbXmQzeJG1R3oCAM4NQNZq7/d3KtdYt4JfktDmnmQLuFlLpMurhWW953HZz/Q1l+ujBGLAXSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=arP+Ggrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p2iD0gGB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="arP+Ggrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p2iD0gGB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CDC73EC00EF;
	Wed, 25 Mar 2026 11:50:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 11:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774453814; x=1774540214; bh=R94CtJYmgw
	um6IwY2N4lVnWESDr0pmXJhtfFeY/LwZE=; b=arP+GgrrYkoKGgiNUosArg+GIQ
	PT9gifYVjZx3A5YkOAnhG21pAZR1LIroQ79wchY5rnjsCYIS+AElhsX9OiMktFhJ
	iLCgJAS+MJUKQcXsFV8kBsHiN5k61YfNBIqwCrMg9wU4kvVAOgbAvIGkZDRIpxq2
	P3/oS7LlYvrqonCOU4al/7OhJwHnsz7kZKmXYupRLWyh8//Up4vF8OlFuEJ30tMl
	ykeJvC8ArCu+Ztrsvpmn7jhHQnnHdzM0eNvxz2ZrW+S5AoARiElG4vMga3bxSNZW
	rKFr6QEsvr684QvMcXtUC1z7jBMV4Ouxi3YTFpKF4EGLqLSeKtCge9QwHZmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774453814; x=1774540214; bh=R94CtJYmgwum6IwY2N4lVnWESDr0pmXJhtf
	FeY/LwZE=; b=p2iD0gGBS7KvDoecumzo//CZWu6rkG1ySFRRM5wikqsHPEQpFs8
	+noYrnpAXksKVvVB1xzIFBU8W0MNZ9cdsJRJZfDk6zWTGtmLQtsst/ixSSs8mERH
	rG4jQvRj2e4qV/aSb/Dty5qw3A45qmsj76siyWNCY3+LkZtrRsMPGjgtaq5IDEnx
	8y4Wn4V0U5kcbGwprUUI8o1XUKoEDLRZNLxC6Dia1SNbBJRa+a/wGKND8uRGyBsM
	Jnyu4RrxdraqQglfFGK2uOSTdOcUQ7q/s4SDBZzBj9VBXXMpiQteM6FHC6AE32aS
	3Gm/MwQM96vamb5wx6v88PcBOsomx3I065w==
X-ME-Sender: <xms:NgTEaeiV191q5PzIyAG4zARTn-ZVLxIMz2nY1HpQgLlwcG2D1JLoCQ>
    <xme:NgTEaWc7KznXaSvOREWV0qBf-tpJ4a-qkTBfAah6AMhW4GV0erhPiruGYmGBvG1FI
    vHjmTeXN2GSODoJcg_vrDtF_JpVvaM4gVOGdgrk3aXQ8f2mWei4wg>
X-ME-Received: <xmr:NgTEaTfdOHiqg3ZRw-Aoiz5Ebl_5VVni7z1MGbm7ljGjR5PyADh9_MANXbCuy4Q26kcxafW-nRDjk6FLZHufRGctjtZLbtVe2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:NgTEaQ8edNAREtn5nRN_0D9YZrQeC0Sjtlk8jHJxu-JV8FOKUuwy9A>
    <xmx:NgTEafnBpzZPFc1cbF6vyPgzaUVoMvyeL5vlxiPoo1ZT5GnQuHGEZA>
    <xmx:NgTEaS_O0McS_kn42yvx0qeMCDCEeX1-ZuhVkOxNZRt6yEub75sXeA>
    <xmx:NgTEadkNTfAFB6VQk3BctRNt3WPclY3ZzENborId8qFrYqPrxuXGLA>
    <xmx:NgTEaeloAxhDjoyTJqObE2-7xZXme-Ee1z2LplzvbPKSGGsmuAVAARQL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 11:50:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/11] t5570: make test "set -e" clean
In-Reply-To: <acOLt7GuLTpg_QYM@pks.im> (Patrick Steinhardt's message of "Wed,
	25 Mar 2026 08:16:07 +0100")
References: <20260325062114.2067946-1-gitster@pobox.com>
	<20260325062114.2067946-11-gitster@pobox.com>
	<acOLt7GuLTpg_QYM@pks.im>
Date: Wed, 25 Mar 2026 08:50:13 -0700
Message-ID: <xmqq8qbfyklm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Mar 24, 2026 at 11:21:13PM -0700, Junio C Hamano wrote:
>> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
>> index e62569222b..6850f08c1d 100644
>> --- a/t/lib-git-daemon.sh
>> +++ b/t/lib-git-daemon.sh
>> @@ -86,13 +86,13 @@ stop_git_daemon() {
>>  	# kill git-daemon child of git
>>  	say >&3 "Stopping git daemon ..."
>>  	kill "$GIT_DAEMON_PID"
>> -	wait "$GIT_DAEMON_PID" >&3 2>&4
>> -	ret=$?
>> +	ret=0
>> +	wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
>>  	if ! test_match_signal 15 $ret
>>  	then
>>  		error "git daemon exited with status: $ret"
>>  	fi
>> -	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
>> +	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
>>  	GIT_DAEMON_PID=
>>  	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
>>  }
>
> This test actually made me pause a bit. In theory, you can use the
> function to verify that git-daemon(1) exits successfully because we do
> bubble up its exit code. So instead of silencing the error code, I
> simply added `|| :` to all callsites that don't care about it at all.
>
> But in practice, that turned out to be every callsite, so that exercise
> may not be worth it.

Yeah.  Worse, I think this is called even when I suspect that the
daemon is in the process of exiting (i.e., racy), has already exited
(i.e., kill and wait will say "huh? what are you talking about"), or
simply when we do not know what status it is in, so I think it is OK
to ignore errors from these.
