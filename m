Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444A13FF5
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385879; cv=none; b=OLXRqs30ubY2mRvMdHhZiRL6VtskMmb4cR0ua2C2Xx/+LEBG8JOYfatdz9LKCG9Mpa/rPLJQdx3Kk251a/WCCK7BkxUbzxfZZdaxlXWaf7CGmaAPs5qf3KeNvdiTqK4E4o0JDvwSETVAdd2QDkTJGJsQcHFeOVpqt3I3RhARHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385879; c=relaxed/simple;
	bh=PMFRkKCWTYR8r+siyOCHU0w0kY/RgUoo6raqSs/fDYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hn9eoV49zh2+McaxDqGJ290JWAJSG1UwQXVYrvAAhlfTNL1+V8ai0HAlmEke6WRjAdjQltOojDMWpQowFusJXGBdcUERV6A3B0vHOVhnnm0X1rqkaPfmYqGYaSKVphkZtMgQTy4wj5bd3N4EN47H14sxoQrOSTACyKw62eGkJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+aHV/D8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+aHV/D8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D8851E7316;
	Mon, 25 Mar 2024 12:57:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PMFRkKCWTYR8
	r+siyOCHU0w0kY/RgUoo6raqSs/fDYQ=; b=L+aHV/D8PRHqztsK9BQV/AZq1n/r
	lxK5aL8IxIFkkmbwtRmxdAjMlaRAuz+vaTAZGm+VU5GtbOLNoJTmrchoOT07J84N
	UMDZZ0Xu83ia3ugiF3wFH+S2wRzq6HDuotOrdfPVGHWPe5OKD8G3JbCveiWLzBaT
	qX4xTLij82gtWcA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83BF01E7315;
	Mon, 25 Mar 2024 12:57:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E02A91E7314;
	Mon, 25 Mar 2024 12:57:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  ZheNing Hu <adlternative@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 0/2] Allow disabling advice shown after merge conflicts
In-Reply-To: <e040c631-42d9-4501-a7b8-046f8dac6309@gmail.com> (Phillip Wood's
	message of "Mon, 25 Mar 2024 10:48:12 +0000")
References: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
	<pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
	<e040c631-42d9-4501-a7b8-046f8dac6309@gmail.com>
Date: Mon, 25 Mar 2024 09:57:55 -0700
Message-ID: <xmqqle66mep8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D4307F00-EAC8-11EE-99D6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Philippe
>
> On 16/03/2024 21:16, Philippe Blain via GitGitGadget wrote:
>> Changes since v2:
>>   * expanded the commit messages to explain why the tests for 'git
>> rebase' do
>>     not need to be adjusted
>>   * adjusted the wording of the new 'advice.mergeConflict' in the doc,=
 as
>>     suggested by Kristoffer for uniformity with his series which is al=
ready
>>     merged to 'master' (b09a8839a4 (Merge branch
>>     'kh/branch-ref-syntax-advice', 2024-03-15)).
>>   * checked all new output manually and consequently adjusted the code=
 in 1/2
>>     to avoid a lonely 'hint: ' line.
>>   * adjusted the addition in advice.h in 1/2 to put the new enum
>>     alphabetically, as noticed by Rub=C3=A9n.
>>   * added misssing newlines in 2/2 as noticed by Phillip and tweaked b=
y
>>     Junio.
>>   * rebased on master (2953d95d40 (The eighth batch, 2024-03-15)), to =
avoid
>>     conflicts in 'Documentation/config/advice.txt' due to Kristoffer's=
 merged >     series
>> [...] Note that the code path where 'git rebase --apply' stops
>> because of
>> conflicts is not covered by the tests but I tested it manually using t=
his
>> diff:
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index 47534f1062..34eac2e6f4 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -374,7 +374,7 @@ test_pull_autostash_fail ()
>>       echo conflicting >>seq.txt &&
>>       test_tick &&
>>       git commit -m "Create conflict" seq.txt &&
>> -	test_must_fail git pull --rebase . seq 2>err >out &&
>> +	test_must_fail git -c rebase.backend=3Dapply pull --rebase . seq 2>e=
rr >out &&
>>       test_grep "Resolve all conflicts manually" err
>>   '
>
> Thanks for being so thorough, this version looks good to me

Yup, these look good.  Let's mark the topic for 'next'.

Thanks, both.
