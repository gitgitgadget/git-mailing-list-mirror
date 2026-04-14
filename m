Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F031F993
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199242; cv=none; b=OT5cphv2VuVubViu5evp2VPJa3lEBlkmAK8GUoSBmps96Y677a8s6RHN0bu+g9VTUQi8FP2SREV6xPBTVlknC4w2QmVYaHgubb4bXIvLYoqdb85Vf9Yjly7ECvWU7kvxjV0qvsBSUtzQFIOS+f5XM8hFHkOEiXwZhkydU1QRS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199242; c=relaxed/simple;
	bh=9kT7wRi8X5AiTRkOZtCNWV0B8c4kEkPkTfJqj6uAtg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a5NMsTtHwfuked2tNYSDrIyyon94R0lV58c7IK1+2toF09o6bAkSlKnoQ/xSovpfuF3U3BWrSqsxgwtQ25ZoQPqJABPSkrlbXCqFzUGseB9IHAwQcnaaYh2vZ9lJM/htyYqpDrPn3Xpg1pYWrP2jiJSoI5crPE58flVbg1y49II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FejxoEqD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKhy5tAb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FejxoEqD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKhy5tAb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 21B08EC013B;
	Tue, 14 Apr 2026 16:40:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 14 Apr 2026 16:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776199240;
	 x=1776285640; bh=m0XoXfKHUmBiNNQA+b2kSu2NKYFZtYD1Y+sBoNPyrfI=; b=
	FejxoEqDC8cfZLoV2S/vLq+QobadeO5+N7rNzs0180O80tl2chU6rJ7zXUf8M5sH
	C8W9N3Ykj45fUY5rQTVzuUYaM9639zBpJ7KqX7ljq8pgKjIjuC+ZVDnQq3Cq8yz8
	5t/q+wo942zPIrLOWLP9SEHPcExQDVBTKFpoZE0VF+UAY2xxQqnWJUM5ScE0Ob9A
	bgcxuIsJtimzMMDql+YstYU0tcZvctjZeInX3dvrwStG9YGaNlNaFijHAJBIxOOv
	lkny1kJebPlzkAjs/Bg0HvazA9cEdFqmQjtEuGVp9o0lzn6dh4LPCevhY1xl07Ld
	68SdT5YYuWs/lnMY3YkNuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776199240; x=
	1776285640; bh=m0XoXfKHUmBiNNQA+b2kSu2NKYFZtYD1Y+sBoNPyrfI=; b=e
	Khy5tAbQOZhFynPn5ZtIpxPUVM2aqOjJW8LoBbciE+rt9WNZcq2eHSIWuivwAzrF
	3YVxJQw1tPdzuNUcDi0sP0gYczpd68y6QwWGojWFHJt1KRwYtmWLl3dMxdhpcNtA
	MG/D4k8eu2KILbsTXM9uzO2Lsq6oV2jhxLmdwpFfnYltBgovAbN+2NiXV2j7IByF
	OKqTFGbEhgHmiaH9+V7Lqy2uBpEdWwdSVaAdyE6DcqL13cAFLu2iwsPQFseuYmn3
	ZGJ7E6U6T+P4GE8ewqVJOvietKlUZCGO916nSKkbqmLp55pNP6ZK3vf/hYMiG3Ds
	GMhan9mUwCKoXeQRu9rmg==
X-ME-Sender: <xms:R6beaS_tC3dC_Q6trIwm-s3Asmj93tYPTXoaWubSEv-NhNX_cHbFkQ>
    <xme:R6beaU87Ts_0VbQglr7PWOjuGvd-1yBeK6TPfy7vPMVZR9sKHLZw1Sy3dMkF5aihN
    n03cu37FQ7_sfROAvlEL2CLvfJxpmn6sK2mHxXvjnUoeiqWQfz9zw>
X-ME-Received: <xmr:R6beaaQWsKegUiM7DuHLngVbdlznyDkEr9rQrEtV5uViw1HWs0tEJ6rHRlG1lThFdlae9YFyFNUKkXo-5DKqnoRsZTDoqpuo6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvdduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprhgtphht
    thhopehgihhthhhusgesphgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R6beaQdqMEC7a57vESrT3VLQJsgYTXXByjDBadsftPlUGysZ-LYHNA>
    <xmx:R6beaWBDCOwjneVnWfSgstOOccztHPMYvGprZQIW9bP6uEXdlyjrhg>
    <xmx:R6beaalP2preGkhg67rQUleezBxgVbeWK8o5spaMXPBAu2-JkfgZyg>
    <xmx:R6beaZccLIRQuhBVAna63-9QcwwXBfCGSCoxLIgNz5ApNoTv4S0tSw>
    <xmx:SKbeaePngmvrrpSgHqQvZ8MGK9TuiCBqgbSjzW5nby8EG3p85dl-IkhK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 16:40:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v14 12/13] fsmonitor: add tests for Linux
In-Reply-To: <ad6hovxCkwMTG11U@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Tue,
	14 Apr 2026 22:20:50 +0200")
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<f85983ca93761bf6cec115d680af8c7d2938505d.1775710775.git.gitgitgadget@gmail.com>
	<ad6hovxCkwMTG11U@szeder.dev>
Date: Tue, 14 Apr 2026 13:40:38 -0700
Message-ID: <xmqq5x5t9sxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>  stop_daemon_delete_repo () {
>>  	r=$1 &&
>> -	test_might_fail git -C $r fsmonitor--daemon stop &&
>> +	test_might_fail maybe_timeout 30 \
>> +		git -C $r fsmonitor--daemon stop 2>/dev/null
>
> "test_might_fail" only allows a few select commands and functions, and
> the "maybe_timeout" helper function introduced in this patch is, of
> course, not one of them, so it returns with error and without running
> the given command.  Consequently, after this test script is finished I
> have still two fsmonitor daemon processes running in the background.
>
> Alas, this went unnoticed, because this patch broke the &&-chain and
> redirected "test_might_fail"'s
>
>   test_must_fail: only 'git' is allowed: maybe_timeout 30 git -C test_explicit fsmonitor--daemon stop
>
> error messages to /dev/null.  With the &&-chain restored over 40 test
> cases fail because of this.
>
>>  	rm -rf $1
>>  }

Yikes.  Would it help to apply a patch like this, then?

 t/t7527-builtin-fsmonitor.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git c/t/t7527-builtin-fsmonitor.sh w/t/t7527-builtin-fsmonitor.sh
index 774da5ac60..dfa06395f6 100755
--- c/t/t7527-builtin-fsmonitor.sh
+++ w/t/t7527-builtin-fsmonitor.sh
@@ -60,8 +60,7 @@ fi
 
 stop_daemon_delete_repo () {
 	r=$1 &&
-	test_might_fail maybe_timeout 30 \
-		git -C $r fsmonitor--daemon stop 2>/dev/null
+	maybe_timeout 30 git -C $r fsmonitor--daemon stop || : &&
 	rm -rf $1
 }
 
