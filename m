Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B5307AE3
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067998; cv=none; b=X7YH5VhgkR1Tg2AYwgIrcHIQ3vRtbqNKYOvlKRZQggd8niUckG9Lvr2FWU2lM6MvCW1dLQtjSr4Z1NijKn/yJAuFqcrnORmahgt0fp/q7zCKZuOJn9weW+Pz/K6kyu2K0RzN6O9QcrZBPY9faidhbmitaNNZTV7TuX7xbgsm9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067998; c=relaxed/simple;
	bh=+Pbk32nGf9XwcmmjYrZ9lX769RPp1OAd2Gbi9rkJdXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JfYgaE0IhD6NZ9x0d556EOYhW+P0/6a4ZNVZdq2g0Td5Ze5BwpvwOudx+oN17JpbRthunh9+Ftc5KRyk6rdiY+YuWxa22I1351T/MuYzBn1QDd5dvINaFbRh782xFN2OSZHN5TeXGq09Zqv6+fs47G3qKXzbhmg8lsZ3LTXwT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fU19Adfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rMaLmS7h; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fU19Adfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMaLmS7h"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C369B7A01C5;
	Fri,  3 Jul 2026 04:39:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jul 2026 04:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783067996;
	 x=1783154396; bh=qaLJ5x/YmWeDae2rJmtLa0nyS9LyjX3XMe6nzpsjqQY=; b=
	fU19AdfpiyOate3ILy9pTAOPvCRrCf432v3IMyqB5hId2Rzp1E254q14/cqbea1j
	DbbTMPFp1jCNCFbJLbgTpd9UlMFlGqXnqKsYDKrLHVQM42g3IMYA5ybyNHmdEQmV
	QuwNrejdwn8ElRERXAL3RDkOKqmLu/cO84/khSkI1KOUF2AgJxBCPixHTnt2zYTC
	IQQK/EI7e5/9xDF3SvskUX896KtU/tcMLEDGLZhIVTVnmFqy1M2TmOd3jwVczCup
	0YyLvjwBYgNZXybb4n7YI5NWitWSerFiq827ogbJPqdP7QJTJ+AFZHdcJS+GdOvb
	tScCNbjsOrvMmT/yQkYgjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783067996; x=
	1783154396; bh=qaLJ5x/YmWeDae2rJmtLa0nyS9LyjX3XMe6nzpsjqQY=; b=r
	MaLmS7hm8HMqaQyJAZ4nmQREaDUmrSd/jYEeAyOOhi1ZGvSrHLn4J6Yv1JLGcUi8
	3LZsL35grkxDLtoBmzDc4mVKDnDZFNQZmiB5uu2TdXU32bOjTuiBKLnxpuOPQbdL
	IFGaO76Eiq/OaoM1yWcdAt27Zu24uZxzudOk+zfcLVPTy08eym9qTUIwID6KMyP8
	DKQ2XAUAy/wM34uGwxFQSRUXFs2YF17mnGynrYQZc6JmcKC/Jdl7lG1iMqtLxaKu
	8/B7p1Uz0Gsn5AP2nAOZRiqgC9tStV3ds+M9n6Wj+QXBwdhktC5x3klw0y9ZSV1b
	aERhT4nt8qOYUK/FXNDqQ==
X-ME-Sender: <xms:XHVHakib1qo40yaRqk5EMdK3fE9emIcefm_FsNX_t90qFJ19lnd7nQ>
    <xme:XHVHakCOcYbT3-LawcdzrsQga95DF4G6ECN-aabXV6BRYkSjzp3Q9Tykm5MhAp2j1
    9tra9e9-o_ucuWUCeeAVoYDrOamAd7NCXfEuRf_d0HhdCHHk1iY>
X-ME-Received: <xmr:XHVHahEfEVVac25naBF36F2Pvi2bnqIFAw025h91D-AVnxz2XsYF0lldrPmKdbf9jLGVvGlkbiHqbB1BVfVNI4Fpuzq5zuiYo7wZJ-o>
X-ME-Proxy-Cause: dmFkZTGyJzVEuxITMiQSlW/rNhfN5XhNvMFooSQcjrNSRGsxZ6+luTT09MrBdEoEGyWc5N
    E9cnTtgpq/fyduZ9miaFHBmH635BxRH9sKjcO0mahCkboEd90kj8py1r3fTEaMLNfIFTp5
    zACT1cTxrbMRE6ucKM38ejLFDdOq5Z5iZRWHQl4ORnHLF1JeJnBr7dPITRjoRYgrHEfanO
    ErjY6DnvTvlYy0BwU4q2YEfSqpNGJKsv5+l/IMXsxcryESMaH8XjqrT1UlVhP1Io02fm9j
    nfrW1ea0j+81KTw0qAlJdAO28g2JHqyPFKqDw+p+tB3rAC4AqcUdjppaOZX7X2IUYGotSy
    VbBJ7V/hfVUY0/cYWeKdeCgYl2Es6+JITPE2KCDWqe+NktZpAWqj4qid1A8PHlTUjrOh+t
    psC8LcG6RVdTB9oPHvh4kCYNo0mD+CfYK23o+a9d3e7vKxtnwEntRJgwbJKecyEWepQMQA
    WfutRX73R+nNAKS7sbVyC5rM3hAfCCGlfyM6tsWKD1si6Nt8/j/VPcnDwV40R0ZIz8h1Gd
    aHeKZDPgWS9Hcm6+l3vLVB7C/LuKgV/lSorZ3DCImQBMEKfa2nwBqOlOSyniPCUx/yKppX
    BXeLURq2Sgoe03sRsKBCZLVmQPi/InOPGrcuRmQ1S2RNoyvq6g39fH5WjPNg
X-ME-Proxy: <xmx:XHVHakKO_9ShYdqjMF4nYN7s4ZHpeNi3smDhr5wXJzAngef9gXQS2A>
    <xmx:XHVHatkTuFjeRDyURlwVW3D13AA5_5OJHj_MGzDd3KDpbUebBpuxzg>
    <xmx:XHVHakS31_D_l4QL-1qj8yU2UWmWhHnDO8QU4sRD7-L6e25aYS46qw>
    <xmx:XHVHanIzG82uwYnzNK45oMRcXM1Qg1pna0WgNatD_kYqq9HEVlcESQ>
    <xmx:XHVHakFk5Jcfzlm31Tf5KEy7qAuYHsuL0fG48I30OK00mGSFR_GXitO0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:39:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] precompose_utf8: use a flex array for d_name
In-Reply-To: <20260703050800.GA29216@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Fri, 3 Jul 2026 07:08:00 +0200")
References: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
	<20260703050800.GA29216@tb-raspi4>
Date: Fri, 03 Jul 2026 01:39:54 -0700
Message-ID: <xmqq8q7sjwkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> Nice, thanks for the patch.  One minor nit/question: Do we need a
> test_have_prereq PERL in t/t3910 ?

Good question.

>> +test_expect_success "status with long non-ASCII filename" '
>> +	test_when_finished "rm -rf long-utf8-status" &&
>> +	git init long-utf8-status &&
>> +	(
>> +		cd long-utf8-status &&
>> +		test "$(git config --bool core.precomposeunicode)" = true &&
>> +		long_utf8_name=$(
>> +			perl -e "print q(a) x 249, qq(\342\200\224) x 3, q(.md)"
>> +		) &&
>> +		test "$(printf "%s" "$long_utf8_name" | wc -c | tr -d " ")" = 261 &&
>> +		printf "content\n" >"$long_utf8_name" &&

I would say that if we are going to use this construct as-is, then
we do need the prereq.

But as far as I can see, this is mostly to create a very long
filename, which does not require perl at all, with 9 bytes of binary
which could be easily done with printf with the ame backslash
notation.

So, if we can fix the test, that would be preferrable.

Thanks.

>> +		git status --porcelain=v1 >actual
>> +	)
>> +'
>> +
>>  test_expect_failure 'handle existing decomposed filenames' '
>>  	echo content >"verbatim.$Adiarnfd" &&
>>  	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
>> 
