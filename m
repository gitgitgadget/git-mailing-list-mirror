Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22030FF36
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073604; cv=pass; b=XOsNll3+11okAgXYyUHUbnPKXOYaKdbKqgHDrJ0izWicwhGoxwmUVgwHMhAmFZfNG0jEoQeDgdX9PUIStb0hB5UidkU2/4eHpTkj53gqpijgTwYq8H1XRfGVFBUbr1OtILjQz+tzdMUmLKlgGhoeng0yOYXkUTfvLjdVGHqofuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073604; c=relaxed/simple;
	bh=2GplLyG0tF0+pRmbE9dKrS1Yut0ANuc7YJUFKZXP5xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZXusG758A/NZfZtTinItAct+iSuMqkYcWUs6RogUiJhPfhvkYcS0BqahuyXOPvS/9J2KjprlfCkVOu8W0vDOfXXYWTt1SQTSyAijZAFxpePhgUTfFrwgOEjxD8/Mu4VeovZm/M9UFXPYQYYfmZcy6LE4qiHPfRTGF7cv+P7jFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Onv1z9uX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Onv1z9uX"
ARC-Seal: i=1; a=rsa-sha256; t=1769073587; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NdHG2CXS/2wqifRCCWauTZf1c2wAoFPE3Qm8YGh2Xn3RexaZp6LsP2wFlFTTRx+efL12kjWh8nIdmVeLeHymLRKh4VLH/WODnjhgwrCWtqcEJMMBvehSbjtuzpS3jXIbtHSc9pEPHXj4m5FaV2Nti8WekcbFcMWrmEo8PV1rCR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769073587; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=okK6duGvPigPkFV83RY6AYMDp8OvrHiGuIx3bwEt8AY=; 
	b=KE7cEfGAk+gSEhoyIZxyu5oKYYmQV26GSwiutQF2EJ7LmYDN2/Oxe78YwrgtB/oSnBTXga3WnZCscy2S9oUx8P2vH/2W6Gwb8gWODZnnRtiuFFQTGaFW/scZDRqu3sW+8GAhsNahebyiL6/HF9HqKRWOew68hpeN+aiAVC8Dizg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769073587;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=okK6duGvPigPkFV83RY6AYMDp8OvrHiGuIx3bwEt8AY=;
	b=Onv1z9uXjgqIp56SfgzIGH+5NukeoMGZ0CE0gdTFSeSWZwdWVgyEJN5HrxFL18DC
	55XuintCbyP83Y26+IpxwkGGFUXYRVqy3YxWadkWo/Js2mkFVkt2XcB/VwGG/hYdGnx
	LTKUbtRFT0BG9Wn0bzw/UjIN/LaxUzyp1qoPcwRc=
Received: by mx.zohomail.com with SMTPS id 1769073585834411.43214206556127;
	Thu, 22 Jan 2026 01:19:45 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 01/12] t1800: add hook output stream tests
In-Reply-To: <xmqqjyxar4q4.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-2-adrian.ratiu@collabora.com>
 <xmqqjyxar4q4.fsf@gitster.g>
Date: Thu, 22 Jan 2026 11:19:40 +0200
Message-ID: <87ikcuqa1f.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 21 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Lack of test coverage in this area led to some regressions while
>> converting the remaining hooks to the newer hook.[ch] API.
>>
>> Add some tests to verify hooks write to the expected output streams.
>>
>> Suggested-by: Patrick Steinhardt <ps@pks.im>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  t/t1800-hook.sh | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 127 insertions(+)
>>
>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> index 4feaf0d7be..0e4f93fb31 100755
>> --- a/t/t1800-hook.sh
>> +++ b/t/t1800-hook.sh
>> @@ -184,4 +184,131 @@ test_expect_success 'stdin to hooks' '
>>  	test_cmp expect actual
>>  '
>>  
>> +check_stdout_separate_from_stderr () {
>> +	for hook in "$@"
>> +	do
>> +		test_grep ! "Hook $hook stdout" stderr.actual &&
>> +		test_grep ! "Hook $hook stderr" stdout.actual &&
>> +		test_grep "Hook $hook stderr" stderr.actual &&
>> +		test_grep "Hook $hook stdout" stdout.actual || return 1
>> +	done
>> +}
>> +
>> +check_stdout_merged_to_stderr () {
>> +	test_grep ! "Hook .* stdout" stdout.actual &&
>> +	test_grep ! "Hook .* stderr" stdout.actual &&
>> +	for hook in "$@"
>> +	do
>> +		test_grep "Hook $hook stdout" stderr.actual &&
>> +		test_grep "Hook $hook stderr" stderr.actual || return 1
>> +	done
>> +}
>
> Asymmetry between the above two was a bit surprising, but the string
> "the word 'hook' followed by something ending with 'stdout' or
> 'stderr'" is specific enough that the way the check makes sure
> everything goes to stderr is probably fine.

It should be possible to make them symmetrical. Will do in v8.

>> +test_expect_success 'client pre-push hook expects separate stdout and stderr' '
>> +	test_when_finished "rm -f stdout.actual stderr.actual" &&
>> +	git init --bare remote &&
>> +	git remote add origin remote &&
>> +	test_commit A &&
>> +
>> +	hook=pre-push &&
>> +	test_hook $hook <<-EOF &&
>> +	echo >&1 Hook $hook stdout
>> +	echo >&2 Hook $hook stderr
>> +	EOF
>> +
>> +	git push origin HEAD:main >stdout.actual 2>stderr.actual &&
>> +	check_stdout_separate_from_stderr pre-push
>> +'
>> +
>> +test_expect_success 'client hooks expect stdout redirected to stderr' '
>> +	test_when_finished "rm -f stdout.actual stderr.actual" &&
>> +	for hook in pre-commit post-commit post-checkout pre-merge-commit \
>> +		prepare-commit-msg commit-msg post-merge post-rewrite reference-transaction \
>> +		applypatch-msg pre-applypatch post-applypatch pre-rebase post-index-change
>
> Slightly overlong lines above...
>
>> +	do
>> +		test_hook $hook <<-EOF || return 1
>> +		echo >&1 Hook $hook stdout
>> +		echo >&2 Hook $hook stderr
>> +		EOF
>> +	done &&
>> +
>> +	git checkout -B main &&
>> +	git checkout -b branch-a &&
>> +	test_commit commit-on-branch-a &&
>> +
>> +	# Trigger pre-commit, prepare-commit-msg, commit-msg, post-commit, reference-transaction
>
> ... and this one ...
>
>
>> +	git commit --allow-empty -m "Test" >stdout.actual 2>stderr.actual &&
>> +	check_stdout_merged_to_stderr pre-commit prepare-commit-msg commit-msg post-commit reference-transaction &&
>
> ... and this one.  I'll stop counting.
>
> You commit, and then checkout, and then merge, and then
> amend/rewrite, etc., all of which look quite sensible.  
>
> These separate steps not being in individual test_expect_success and
> instead in a single one chained together with &&- makes me suspect
> that it would be inconvenient to tell which step is failing and to
> debug when things start to break, though.

Yes, I'll break these into smaller tests in v8 to avoid having this big
test which can fail for a number of reasons. Thanks!
