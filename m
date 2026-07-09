Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F2306498
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615091; cv=none; b=KziqTMCxGtpCAU2twfRYuwrpqMGx/9bWYecjv/m3eUZiw1Mfjdr0flLRKYd/wI97DTiUc71rTHQCmT3E+6AGuMX0F/0MJikiAWa3goYRQrxPl2fINMDsVjrVUDIpHHZfJd+US96Q3j8XkHdDtEZIbSy0t/Yof2NOOopn2wXOj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615091; c=relaxed/simple;
	bh=85JAadqUp/jSXO2G39FC8cmQIrCXymCgFVjG0eEqqSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awM92KfPwjcTY9YJQwfm6Z8z3GmgCCffUCRVNq5W+0DZIxL23Yd90AFTDVaqd/h5XxowZj0Q7fBytvAzIn3GnmF7gZ9j3W0wLxf7cHeLmuYAkpNK5EFNGAcHIZopvDLx8T4KLDW3D/IoPIsJv07yce0fHufqdUlULZ67poR2KXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C/NhOtZZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CTrvTJEt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/NhOtZZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CTrvTJEt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F7EB14000E0;
	Thu,  9 Jul 2026 12:38:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 12:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783615088; x=1783701488; bh=rWXPciMl8J
	fdFK8e20lfN47psZtBvDU8bSxmstxLf+Y=; b=C/NhOtZZY47OjqG9XiIiZ16NSp
	aTjBaKsc3ne+o/BouP+bH02VcfI2ezkbtVPKhGV4+CHd2HebXmaEk0MYYABqaWcD
	RqWSuNBh/d/RsvyB9tEu88bB4Hb4IbWjFLzI7ew+Ys6anYzoQbpvvsI/n1ERTGfi
	XVlsneAYzmKNNsf0r7058s+LWdgk0joVPHScXWNHwDb00JbyOZJ7L8+XXv/JUbjc
	1YEE0wJR6BInOq+N5I0XhJLdK4e1ND3/37KlhZ4agLk90CkmlDiE+ySv69UBqr2X
	Ww1yjaZGT2EYYKewb4PEASsqAYO09JRJeMrafB29xUMMF3499iqi6jLWZQ4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783615088; x=1783701488; bh=rWXPciMl8JfdFK8e20lfN47psZtBvDU8bSx
	mstxLf+Y=; b=CTrvTJEtEFd3vZBa+e3YBwIqwGBTP/UaFU3t7qaBJk7ZI3elxhC
	CZ/cIV5dDVcIK95rQ05WQhqTNC41OJJibhYw3vqorSQiv1miy2xu737IDFJ9T0bq
	iLq9wRAMaZOtAdtQUK9u6ETv69N8uLv0LgdGuaGYODfRZJgB56tLXwjuRgdkggHN
	IglZzzpWyGL7nHbJP9mGxzAC678mnGngDu5EYZry8U3sH5IxG247MQyUg/fnnfud
	P7ubzRdQaS2JXTi+S2WMqIfpI0bf+MgRwerH3+jLNpYG0JdWwkpUhvmSYaIkqBrZ
	p/Q4DIe4khnYO6bAfUsS8+9Ofm0xJ8NbZng==
X-ME-Sender: <xms:cM5PamzEyOi-wCentd-fdZbU-fV8PrX6hjNit2EfWRnZBM7r931Bhw>
    <xme:cM5PapuhVutvkF8tfMVxz1Qz3J_A_MK9IaDxBIMhNzDl1BkHj2JYXh-H0lnCALXpz
    PzzAechJ5e7Q55O0op1GLR8rhBiXooULIRrhBMtL1odVKgJzg4yBA>
X-ME-Received: <xmr:cM5PalsZdqKvGO4Tv9jPj74giGSrSnlQMwfMqSbRpmRmQyD5uu2rpkfqB034RpbqAlhGFzrMxFFShsk25hoF9syzBKdjisxQQIhWeJE>
X-ME-Proxy-Cause: dmFkZTF2fVfMzPShSHl1672bUTNvkOQ3zWLfWdJWTlnuq5JHCC4eSfGup1snppjWAxkevz
    bieGwBNGuxDl7+g9ukTCykS/aRtYe7sqTIr9JfgF76KSd2jE/fkkxA2jMQDafhkPvsxSq3
    n4CCdkj71JVUcLrE5i7HHpZKllgGmLWMZI8GCfZbWrmt620PNnv5UGOB8iFZPlXsZzhiCl
    TqqWEDSNW8+A8rje4+1FkZE9GJnd5klklvxI/UTZ5PV3H5jSpt+5TJhGIgiRxemKFbP6Ua
    SzPR4avRmlBG0rGhi2I6BcltULz3/T/zacLqKoYgAoyspsUPFgSCWfHuzXAjNfh3XMLLFk
    OSJ0YAiHGcS062wD8lRVeciB7k3fzFHGtgLFhOsnyCP67d67v8rqOt8tfN4KDrLe5J4D3D
    mjoAF2KKHkpgcRrUhSHbuboU9E75Ttc8vSKNlCq084XD4GY8coe274AwdLLWsdxm5+RGfZ
    mqf6V6P+cMYZmobqXNs+hd0BVjT2uenhYY9uWUfva7J+HKzRBhQ8uAOdIMLSHnFecF24k4
    T2MzS7G5bBJBbQMatxeb59O71XdNUf5Kqzkabii3Zpt3gUJeGh0DohbdKajNjAN0pFpPKF
    w0s3dnNr6GV4CDyY4XAcyZ04qoHqjesJQuzo2Nt24cj9ADgYRvjoqzNSirLA
X-ME-Proxy: <xmx:cM5PamMRv3m_BWZEfoEm3EyVJ7CbBq6qw7S90UbcFLxnlKe40d9Ayw>
    <xmx:cM5Par3UnsurunLZ46Tv7OTJIJenBhU7ZG9RQqJ95kwgA-_5Kq6y3w>
    <xmx:cM5PaqPjj3TsxO2wPNUnQaLFtxGRmSuias1T0L3KJnk9GYcXrEZjdg>
    <xmx:cM5Paj1o34n2NBd-Y19MPULYOBa1HUQJiRPIvrmwjQjtp-85aqeDbQ>
    <xmx:cM5Paps7CdeLsutQkgI7U3_8_ro5CWZFYzxcjMRQUFp7Tl4a7ulYT8MS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 12:38:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] t1410-reflog.sh: avoid suppressing git's exit code
 in pipelines
In-Reply-To: <20260709051229.40363-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Thu, 9 Jul 2026 10:39:35 +0530")
References: <xmqqv7aprz8a.fsf@gitster.g>
	<20260709051229.40363-1-gatlavishweshwarreddy26@gmail.com>
Date: Thu, 09 Jul 2026 09:38:06 -0700
Message-ID: <xmqqtsq8p18x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> Piping git commands directly to wc -l suppresses the exit code of
> git, hiding potential failures from the test suite. Use
> test_stdout_line_count instead, which handles exit code preservation
> internally while keeping the test logic clean and readable.
>
> Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
> ---
>
> Changes in v4:
> - Restored blank line between test_expect_success blocks that was
>   accidentally removed in v2
> - Updated commit message to accurately describe the solution

This version looks good to me.

Will queue and mark the topic for 'next'.

Thanks.

>
> Thank you for the detailed review!
>
>  t/t1410-reflog.sh | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index ce71f9a30a..5a40a62ba2 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -244,30 +244,22 @@ test_expect_success 'delete' '
>  	test_tick &&
>  	git commit -m tiger C &&
>
> -	HEAD_entry_count=$(git reflog | wc -l) &&
> -	main_entry_count=$(git reflog show main | wc -l) &&
> -
> -	test $HEAD_entry_count = 5 &&
> -	test $main_entry_count = 5 &&
> -
> +	test_stdout_line_count = 5 git reflog &&
> +	test_stdout_line_count = 5 git reflog show main &&
>
>  	git reflog delete main@{1} &&
> +	test_stdout_line_count = 4 git reflog show main &&
> +	test_stdout_line_count = 5 git reflog &&
>  	git reflog show main > output &&
> -	test_line_count = $(($main_entry_count - 1)) output &&
> -	test $HEAD_entry_count = $(git reflog | wc -l) &&
>  	! grep ox < output &&
>
> -	main_entry_count=$(wc -l < output) &&
> -
>  	git reflog delete HEAD@{1} &&
> -	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
> -	test $main_entry_count = $(git reflog show main | wc -l) &&
> -
> -	HEAD_entry_count=$(git reflog | wc -l) &&
> +	test_stdout_line_count = 4 git reflog &&
> +	test_stdout_line_count = 4 git reflog show main &&
>
>  	git reflog delete main@{07.04.2005.15:15:00.-0700} &&
> +	test_stdout_line_count = 3 git reflog show main &&
>  	git reflog show main > output &&
> -	test_line_count = $(($main_entry_count - 1)) output &&
>  	! grep dragon < output
>
>  '
> @@ -321,11 +313,11 @@ test_expect_success 'git reflog expire unknown reference' '
>  '
>
>  test_expect_success 'checkout should not delete log for packed ref' '
> -	test $(git reflog main | wc -l) = 4 &&
> +	test_stdout_line_count = 4 git reflog main &&
>  	git branch foo &&
>  	git pack-refs --all &&
>  	git checkout foo &&
> -	test $(git reflog main | wc -l) = 4
> +	test_stdout_line_count = 4 git reflog main
>  '
>
>  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
