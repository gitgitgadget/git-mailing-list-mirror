Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498144CF4A
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028810; cv=none; b=AaR5+sKdhgbqPyGnyLmJmYxiVVNd8EbYpFhX0IMUp5+KG/zVpCCxv0v6TPbvgNIhxFTx5G63igRd+0J3eb7KZyDIAtTUCQ6XCvZlQU5rxunoA3qjI+ON7znFoVbZrTLy9SzQzb4uAtqXmSDEERDkDY1zvGgH5iH0+n3n+sk1FWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028810; c=relaxed/simple;
	bh=aFZJJEovzJNUouDYbEKLyssaR4LcrF38MzParwx8z4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHbw0D0F85LS+zsnEDqtHEN1QRiUJubBzoooTRX+bJweCV8V0zujrVGMD075QU366r7if0Ts8Khz0+JuFgPePN7qMFZhCluNxfhynuIO5NzdfU0InpbX13Bvvw1CeIxNHFp8zXv19Z4MHDX3heTwKQRV1gprVixF2hDtnt/IxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=trnHLGwo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bl3C35LI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="trnHLGwo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bl3C35LI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 233067A00A5;
	Thu,  6 Aug 2026 11:06:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 11:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786028806;
	 x=1786115206; bh=VUlymaROiTitYb5pJFeG0TKGJIO2CvVBPTPiial2lY0=; b=
	trnHLGwo7LGFwE5tDL7UygjBcfIfC4JwYvZ5G3vsWxfTBeTGpvb669DuYEUYFg0x
	ukNvpuYVu+cH3y5OiWiX7ci11tpEDYcBMwrAIs0yhS8Fq4AkbNpnARfFHaddFlJy
	M9OxFb7cifsiWyfvyWW5/bZ6y4cPrsyg6SvxM9KMF9Wnqf/hBqXQjtOCraLPAW8P
	oquiEApaL4ePZPLWEYjr7ts1InrL2CM5W90sOGOXor4DhssDe0PM18jLvTWBxdkO
	QREExQp8o4ZD1Z6/t6jD6mCAd4Z1MISLT4b+CWB9ZwJUwyNNQxQ9tZv+ggqr+U1Z
	K5scN8zA/4TjqfRun1qFmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786028806; x=
	1786115206; bh=VUlymaROiTitYb5pJFeG0TKGJIO2CvVBPTPiial2lY0=; b=b
	l3C35LI9MFI8JAj5JK5zBS4ow3MloN84P9a1uWYE4QQj4tCXxDBE1M2Rgngcr3oc
	XeGtifWxOQwTSsttczWdvpNJgUHb4vJbBw5M7hXrzIJhTwSjPaiEnMUoTu8Mmbhy
	Eg3lCJK04wK6hTShbPhrsVKhKAzXOQjCfhpOgzk0VfUe28ITfDSaWL5xdsbFHy9G
	UKyrMQMK3T/lEToYhmChTO0E/frh5qCSlJl86nrNGj76p8qzzbjGSS+8HW+PXrIm
	alzMAg5i51uJgyZyo57gLB7cGbhnCRchxvyTF9XqgpstUI41mwS/lpmsDt8XX1Ri
	SOWYtV+VvrfNdV0FENnyg==
X-ME-Sender: <xms:BqN0ajBzwnFuYu6bWBFRSfQKFBXh0LTCjKTNgUH4xBfRaTcw6ue14g>
    <xme:BqN0asELPCb4sSY1pmQ28ZW7VsIdnpmUWWJkJlazWIdlw072YH8LZnPMVae2pi1Fr
    tzdyFERO4gHf44nlQRlJFk7HeKyHvv5QRaW5nD_DoYd52pCrAp->
X-ME-Received: <xmr:BqN0aiM8KvWL993lt9jAz-WF0RVZ2U2DgdW8fFVCSw6evqg3rEANpyafTW6nsXYW2k0oDInrTjg_xC19YrU5pq0Q-i2sITJbKg>
X-ME-Proxy-Cause: dmFkZTGBAKAUE/1ic9hwDI9wGnCg1BVuuH7FMmCnYzAFFfLSM0Zbvc3hT3+Deq4J3ZftQ1
    e/ooL9q6UqPAz2uk2qZIDtESxk6MYq/BN+uorvGsspcw0tW0rwYmxJbu1wwctlR7ncf60F
    Zb3EzAIdSs+ZMT+k/LxjrM2aGF/AueG1puseEWx84+qVMjckfWfnQMQT0tYMrnMJyTYxc5
    Dq0iv+D2gY3eV/b+JBLFp4fFHj0SaIhNrAT/WNRcoiYjQv53aAY3juQpoxMDHGoGeoDxRi
    TMViM0hbNozyksBe1JKn0ulQGnzmcDQbwQim6fcMJDnBRhQIjirdSQNxr0Qozu0XTo12bE
    WKuambJTRRpvlSjOzMg1IN3Ay+Ly1DKPzg3O0rCxq1AVEcJgrX3FbrXlSrVc7X5fklIAuu
    8XXxq/t4lX/sPRRw0S/FlNhX+KCYV/2R4clY5eaMHk6jTjtq+JZMuBZ4sYFoPf8nRqJkAp
    9myFFPQ++PH+h2Ucbg3FKWvkzH3dE36sBnsvHt1P6LC6S0WK/MXzGt4DdaUuGDJPJzpbik
    sa8CAV52QnrKp1IMbSSwN8iU6PRBGxBvkcRftsdJCyZqsRVhP7siy2p12w7MO/C7duXpFS
    6jlUU7BhghNAFhNUFzX5EUtMJIUxwHUW2vhnnlP7863kYqMI11L603fbiLPw
X-ME-Proxy: <xmx:BqN0al7C0yy230bNRBK5_mycELOLqAfnQcG5Z3S7igbi0aJBKmhw5g>
    <xmx:BqN0athl8ooljSRKZ8LLMprC0TDipC7cQ33VKMfyhKk2O_nckkAnTQ>
    <xmx:BqN0aicjdzUcbwOevEDwmq9dgywIwkdu3VlyV9Q0EGhNuMz0UDY2xw>
    <xmx:BqN0atz9SdAgVuKpjMozo63QPa_mL2ihLzPH0FdU1iGshaY0Mb38_w>
    <xmx:BqN0aouKogaU_sBHekbdb2lMvG_ggo2An6Rrrtjo28QJ1hkjKwXO7l_i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 11:06:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Britton Leo Kerin <britton.kerin@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Patrick Steinhardt
 <ps@pks.im>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 3/3] completion: 'git diff' completes untracked paths
 as a last resort
In-Reply-To: <CALnO6CA8sjivVfz45OEDWnvw516z9Nd9SnC+zfJ=FK=Y6Q7MJg@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 6 Aug 2026 07:30:36 -0400")
References: <xmqqcxw010me.fsf@gitster.g>
	<20260805194250.3316220-1-gitster@pobox.com>
	<20260805194250.3316220-4-gitster@pobox.com>
	<CALnO6CA8sjivVfz45OEDWnvw516z9Nd9SnC+zfJ=FK=Y6Q7MJg@mail.gmail.com>
Date: Thu, 06 Aug 2026 08:06:45 -0700
Message-ID: <xmqqecgbmgoq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>>  test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
>>         test_when_finished "rm -rf repo-for-diff" &&
>>         git init repo-for-diff &&
>> @@ -2744,11 +2754,21 @@ test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo
>>         test_when_finished "rm -rf repo-for-diff" &&
>>         git init repo-for-diff &&
>>         echo content >repo-for-diff/otherfile &&
>> +       echo untracked >repo-for-diff/untracked &&
>>         git -C repo-for-diff add otherfile &&
>>         git -C repo-for-diff commit -m otherfile &&
>> -       test_completion "git -C repo-for-diff diff -- o" <<-\EOF
>> +       test_completion "git -C repo-for-diff diff o" <<-\EOF &&
>> +       otherfile
>> +       EOF
>
> Here, with more context (which I won't paste, because GMail…), it
> looks like this test is redundant with the test just before?

You're right.   As these prefix strings ('f', 'o', or 'u') tested
do not begin any valid refs, the result should be the same with or
without '--', and I wanted to test both in a single test block, but
I botched the conversion.

Will fix in v4, which hopefully will be test-only updates.

Thanks.
