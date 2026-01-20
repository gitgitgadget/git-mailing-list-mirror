Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD012EB87F
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923752; cv=none; b=IL3cRalLbrmwSBARhNLo+XxOCss/m1OuWXC+a3vgchUsB+FWe0B3D8ZF+bU+cEnoHubCnYBxmC2d9G5n2EgRge12giuIzI/G1M7XxXYlS+vbHci7VBxBwwVoT5L6YpEQtKLKg0o475VVEHHqVd89zPjTXHe+DZpFTPZFyD0X4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923752; c=relaxed/simple;
	bh=vmzC7BRqluZwJPdxKzbTz0+3pDQeP5a0yapCg1Fezow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfyDBkQURyw/hUTdGtf9LeaH7CHiwTdsfMFK3+5bWpBwvdnnFB7VYx6TonHmKPvCHbcohk4HCvGvS20z/liI7JMHIDiIFRzdVUSbng+WzQMqkM+yX4VOYe3VV/SpYoX6CSupYs87yu7dZUHtxWBoGDmy8ugsW1E5nIF5iQgQb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sQOyOnQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAZVzbvP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sQOyOnQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAZVzbvP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34B4B7A004F;
	Tue, 20 Jan 2026 10:42:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 10:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768923748; x=1769010148; bh=AvB+tk8wRY
	Xozuywp/adrwtkkhF1TwiPw2Po4dAdNzA=; b=sQOyOnQ43c44IDqcWgOIhwmvGw
	og2O6UWLtn8ZboUR4447ybjQH+neffgVGEC3IDJVLaR5pp7ZtpuKtuDUNwsGs16u
	Jw+j0Fq9/gpqQ3ScBJXYueeHnF4C/RI9oGQaanG+ir6BQrNMNdo26ifv+gSTL/t2
	OB+7qkX80sLGE+jemL1axBJqXR7+b36EOpl97I8WLTK5xTPPLYpvTbZ1uEhVbH0/
	qitBbQuAVoIhS52M/3QbGqxt9gumZ/SvaUiBg4uRIJanViGOCFHOWS8S5//4ZPnN
	GJnzTMPnd+8xlkL3CZEoYBx/nKvqlQ9LOKeY+Im9ZIwKSiGTH+OKK/o0C+Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768923748; x=1769010148; bh=AvB+tk8wRYXozuywp/adrwtkkhF1TwiPw2P
	o4dAdNzA=; b=YAZVzbvPF7w1SSDEMI0nypqed6GSIT9MGj1AlO5VUB2lzModCkM
	XqtchU+VOiZZKkkg8T5eTjyKyvVC2uOLqVQu2EfoP6dbCfJ0A+pcOBYPkp65S9yE
	f7t9XW9NdtmEmpwVuIui50DRfjrpZ2bxv91c0a82EQRKR4h37r2+LnIN6+AOB/pc
	qDLJXF3EoDBsNjlHYeTnAvpDLI3xKwnnVj46xXe7vMBbdxUdNcWekzJyTPSUYDJB
	nx1ZJrRQ1E14w9ccN7pIyJdKcaPe/hxRXViOZXMXKkMLx5GOVrPR605tEa8etQhI
	XkBFHRM7o/cpzE93506kmh+KNSOj+HDMfdA==
X-ME-Sender: <xms:Y6JvabxxCEYXCI38CKRHBERkAWWFaRgIaJcjlqKFhOcHNYUCmVtcZA>
    <xme:Y6JvaeznKezQl75o7LMTlc5fLmOqmCnM4N7CYfeQeLSpoFf0-90xlsYV432ZDkVmP
    9mgIb0wCxFh-enUOflvUpKTFh6U2v2VabpKB_YRvXqR8bnJyKdFQw>
X-ME-Received: <xmr:Y6JvabzxZi-Ij3V8OEGqLfZtFXdpKQ8ejhWdzP4aRL4MPyjo57qfYQ5e8nRa7AcrTjO4a5Sj_8ThtCGefpE5CXSGtSozb8Y42Sy8fAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y6JvaQaSacJXs8CQXLrQIlXrSMCAwEkGAtvvewN59jUIbwbIVcFuOQ>
    <xmx:Y6JvaUXqqHXFEfTfLQrz81V9rLIsdD7w61TfrsztSNKPxioSpuEW6w>
    <xmx:Y6JvaWgFO_9TG7D8pnNS9i7d9BsWJBK_63Z3OeheKCuHCNpwqPl3YA>
    <xmx:Y6Jvaav-TdZruVubm-hcMP4rNzNSDDM9LZ8XBLu5QsRosdhwxJvPpg>
    <xmx:ZKJvadJmtGWCg-z9JTuccCgdW6XY_LT25CZ_ypYfk6NTyaH-V6B8YQha>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:42:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
In-Reply-To: <79c29032-dc32-4030-95ad-dfbd50d9b6ab@gmail.com> (Phillip Wood's
	message of "Tue, 20 Jan 2026 10:34:39 +0000")
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
	<b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com>
	<xmqqa4yc5brq.fsf@gitster.g>
	<79c29032-dc32-4030-95ad-dfbd50d9b6ab@gmail.com>
Date: Tue, 20 Jan 2026 07:42:25 -0800
Message-ID: <xmqq1pjk2sv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> The patch looks good to me, it is very convenient that we can put the 
> test in the library files rather than each test file. Should we drop 
> these tests from the ASan job as well?

That's probably a good idea.

I also was wondering if we want a blanket NO_FOO_TESTS that we can
use instead listing all.  That FOO should not be SCM, though, as the
reason why we exclude the tests is not because they are test about
foreign SCM.  We exclude them as low value because testing them
exercises little code of ours that we may make mistakes these checks
are trying to uncover and that we can fix when they do.
NO_FOREIGN_CODE_TESTS?  I dunno.

Thanks.

> Thanks
>
> Phillip
>
>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   ci/lib.sh       | 2 ++
>>   t/lib-cvs.sh    | 6 ++++++
>>   t/lib-git-p4.sh | 5 +++++
>>   3 files changed, 13 insertions(+)
>> 
>> diff --git a/ci/lib.sh b/ci/lib.sh
>> index a165c7f268..3ecbf147db 100755
>> --- a/ci/lib.sh
>> +++ b/ci/lib.sh
>> @@ -356,7 +356,9 @@ linux-musl-meson)
>>   	;;
>>   linux-leaks|linux-reftable-leaks)
>>   	export SANITIZE=leak
>> +	export NO_CVS_TESTS=LetsSaveSomeTime
>>   	export NO_SVN_TESTS=LetsSaveSomeTime
>> +	export NO_P4_TESTS=LetsSaveSomeTime
>>   	;;
>>   linux-asan-ubsan)
>>   	export SANITIZE=address,undefined
>> diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
>> index 57b9b2db9b..c8b4404888 100644
>> --- a/t/lib-cvs.sh
>> +++ b/t/lib-cvs.sh
>> @@ -2,6 +2,12 @@
>>   
>>   . ./test-lib.sh
>>   
>> +if test -n "$NO_CVS_TESTS"
>> +then
>> +	skip_all='skipping git cvs tests, NO_CVS_TESTS defined'
>> +	test_done
>> +fi
>> +
>>   unset CVS_SERVER
>>   
>>   if ! type cvs >/dev/null 2>&1
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> index 2a5b8738ea..d22e9c684a 100644
>> --- a/t/lib-git-p4.sh
>> +++ b/t/lib-git-p4.sh
>> @@ -16,6 +16,11 @@ P4D_TIMEOUT=300
>>   
>>   . ./test-lib.sh
>>   
>> +if test -n "$NO_P4_TESTS"
>> +then
>> +	skip_all='skipping git p4 tests, NO_P4_TESTS defined'
>> +	test_done
>> +fi
>>   if ! test_have_prereq PYTHON
>>   then
>>   	skip_all='skipping git p4 tests; python not available'
