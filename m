Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0CE4CDDFB
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607061; cv=none; b=eYqvVfem6qYGJMTJ54CAtUqYKhl7+rrSnhn5EkM5/ap/XL+/U0cCxy9KZe4Pdg5yWtP8/zzH+X57U35PDxhP7Iy1PG7Z0LXoiTXf27pohkLCllg5Si90k/UF0ccf/hKbCcwZM9Kbb2o1q4mtM7j7dV60fAcSwrCF9xeazM0/9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607061; c=relaxed/simple;
	bh=bGY3gdsGTUE7OwGfIeNK8qw17bjTKCfIRiEIZuHVnKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjptey2tgdrHU3smsGaK5T5NGNVdINHgIyZUnNq8evI+77h2ohz2ZDkpbWOit+Fn8YpBx+MeBdyLAHUl+fALNvCr0JKz5Clbq9dFW6JZP4pOGg1p5TbAU9stILD5JuMTwAMJfb8Fe1Ti0sA0NfnVZsmUf7x7R9cYdJl5ErESMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bCRRBlRH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uJVLzqDq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCRRBlRH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJVLzqDq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79B6514000FC;
	Mon, 28 Sep 2026 10:50:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 10:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790607059; x=1790693459; bh=uUWfEzvx9B
	dOwC9H5H4FmurZJJq/k4/d3VozJx4hKuU=; b=bCRRBlRHjI9EzsTIIx2QK+6ATY
	XPSKIFeNVI0s4EdDGJZD4mz5IrWOBbJiJOiHASRO8sCCjh/1RcUTxnwwNY5NddBw
	ImCLQRZNOapdConof+iBFfn5FfqcMxY9RGb0eHmrKFcwnyByzkLK8YF5lw0Ux/4v
	TiNBg8jWMLnCzmRrIXFR2ZxZMQI7VmxYnpDDaKuHAzUUfr3NfwEB/X3CPOynzouq
	kdwyVvfb7kqENReNPftMku8AsfyBj1A3kMFhjM34/pKQY/hVAoCStjiWC5cgEFPZ
	PoE4lEpzPTNTfl6NYvqjk6ilvOSRZcg0rv7Bf9txmfUbTO5KNb2zI4su58Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790607059; x=1790693459; bh=uUWfEzvx9BdOwC9H5H4FmurZJJq/k4/d3Vo
	zJx4hKuU=; b=uJVLzqDqTWrJYd1jeUM1xTQaf34gl3Y1YlYO9LA3YT0AHkVW24q
	BZCKt4CSHtf1EOXIyRDyCIXa4aJwhAftOmv0GlXY8TFbq5/V/18/i2MFWacoVLj7
	4bBg4DLAKoMqG5vG/xjc7TREyGPibZUY/1dqH0fxcMih1UvC5g7OH5OkefH0zYlh
	3PaEQXbK7Q12FoT5EzZm0NisKzp4/xRYqBlr9aU2dzFW4awaJagsFc29DR9GwVR1
	Zv5dx8p1iuZEFD3s21m2Hk2LrBCsGlHeYQWNUBenX5qRquDTgNAJflGi1wqd2lBF
	Krd8y2k3xWnADjIgMiQKk08SfPkvsKveLJg==
X-ME-Sender: <xms:0366anOU4aCq7X0WTRuR4jcx9BfN3i1tBSXQ6veXclxUlBN3EwRJvA>
    <xme:0366alrI4LbLO1SfSAIc4W4ZUQpBW1MqptOBuUu_CqvKDex7MjUJO9bqaZG-L37Sd
    hmGNQVNyUcLCZuY5rqlsiWebnrJOwrmjlZhauC4iDrAUwd511DAjZU>
X-ME-Received: <xmr:0366agGFcdlCa8Nj9chvo_6hgWNouTGJAN5FKi_dLkBY7Efadx_swOsPEk8FkL-kiKFEayfhhwOYYcv7iKayv8EeUZCVHu0K3Qk6>
X-ME-Proxy-Cause: dmFkZTG4Epeg1Q4wpx1bpeS/npMe3Js+cFCFt9aOICC5LkAMIfM77alEcshiD3NOiOGbNQ
    CJtEzgdtjdt4SZaMMFJ7N/5LP/I1JDquqFzB6mKFpPEzc2ScuGX1aGZ0TSvptmT9Ee7f2E
    aJe0dBdDBJcJik+IlS9HPad3QdEoOwvlq4WHerx4O5v2sZInawGRIwB4c1sjZYjAT67EtK
    6CC3Lx/Mx4e96GmPi1aLmC+QGqTPWmtKMrl7oW526VZr3Z+aqDdSeSCcbzOZAC9l7xzb0Z
    keHtLMLceeIED+rDOBROb6g88+e1LuBZnBMJmrq+DhmJo1hOIefIoDnqzBv+1XdmB1gHbU
    BhBuV6jkqIbEapDDqRoWPsBnVCXxYNTU1qlwHfff29F+r/NCYio7UGlFX9aD5uCKVAQVub
    FGJKG+Y7i1/TqR5rT8TbbcF3xxJHyFfXbCAeHjD5KqW2iMmjUrM4Liv+HlA0v1E5ogQHeR
    SwH0R84BsuzTfF9uoXt4beV4JCouTq5Q/SzYUHs/RLVBHCJ7ggiihc7fSvilz57Kk9tcmg
    sP2yA3xiABfnY51DX1DceHWjczgtAESbQJN+Hq/GIFIt4vPRsc4A6vs0Pbr7IViMrtDpJN
    ipbJonXlKfFhgAOMai3kCGT+CzJdMCEnjWrC1u9Hew1VtP5bBv0wGSQOsBMw
X-ME-Proxy: <xmx:0366air3rfED-Lru4SrIYaor4V8bNaoMpu-2Gh0_joVajaY4XTJFxw>
    <xmx:0366ahbIT-Bse7K7bq3_ZkB1PuRPuDYMn02w2ZEsj7PSsA0nQ5TiBw>
    <xmx:0366ajUUNEdvbXopEX6-n2XJn-UM83G-MFMEU_xr-ComqTAmlB6wgQ>
    <xmx:0366ai-vOMA5R-LU2_dOn_X5q22A-CNWXKi8186AQqOvAwcTyXEwDA>
    <xmx:0366aoITxTnIkVzMOnBd4tTKK_1PeA-p84QVElNc1mxcIozfYhxqIWJq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 10:50:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org,
  peff@peff.net,  r.norouzi@proton.me
Subject: Re: [PATCH v3] reflog: fix default expiry periods
In-Reply-To: <aroQ_zZvUXKKK7--@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Sep 2026 09:02:23 +0200")
References: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
	<20260924175843.8383-2-pushkarkumarsingh1970@gmail.com>
	<aroQ_zZvUXKKK7--@pks.im>
Date: Mon, 28 Sep 2026 07:50:57 -0700
Message-ID: <xmqqy0clo2em.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 24, 2026 at 05:58:44PM +0000, Pushkar Singh wrote:
>> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
>> index 8f78cf4b01..93b5b49e1d 100755
>> --- a/t/t1410-reflog.sh
>> +++ b/t/t1410-reflog.sh
>> @@ -153,6 +153,72 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
>>  	test_grep ! "error: [Oo]bject .* not a commit" err
>>  '
>>  
>> +test_expect_success 'reflog expire keeps reachable entries for 90 days' '
>> +	test_when_finished "rm -rf reachable-keep" &&
>> +	git init reachable-keep &&
>> +	(
>> +		cd reachable-keep &&
>> +		timestamp=$(test-tool date timestamp "60.days.ago") &&
>
> Nit: I would've preferred to make this 89 days...

Dates calculated as 89 days ago from the beginning of today, from
the end of today, and from this very minute can differ by almost 24
hours.  Because we are not interested in testing what semantics
approxidate() implements in test-tool date timestamp, but are
testing what expiry period reflog expire implements between 30 and
90 days, using numbers that are not too close to the edge spares us
from having to worry about boundary cases we do not care about.

So I wouldn't have preferred using 89 days there.

> Other than that I'm happy with this patch, thanks!
>
> Patrick

Thanks.
