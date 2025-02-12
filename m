Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9025C714
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382494; cv=none; b=pRlIbItwjCPBrMOMONNzUXazJP/VezQ8XDcwmlAQU+U9vTIQ3al+6D79qNiKPDg1R1jLzev4Y/4uVaKeY/YdRrRwY3d9RtAkdqlhSBbUXOKvo3LWEg7BPkkNixFCCum/rmGg3TkEImT05E9ZMFWEHiexHm2Mh0/r0GQCtSQk880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382494; c=relaxed/simple;
	bh=HopptZqdqy30SfMi/2IFXNY06e8GUhUnSTMp8pg+mU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQuEvsxP6r01uNMNk8qVVt677PA48tEaxQRpNvhU64GH80NIqNhMAGdGio2YBhV5aV+e9+iS/vdMIRjWqnSE9N1CYT90JHnsuDrIQLnM/ou86YAmZeCk4TJQEZ+QEpYUtcMjhSyPrOABo2Xc8kBQiXHV8ae8BTb0Q33SoVLcQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cY6KTyDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vzn9A0z7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cY6KTyDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vzn9A0z7"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD75C114016F;
	Wed, 12 Feb 2025 12:48:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 12 Feb 2025 12:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739382491; x=1739468891; bh=ufGgPDNpli
	W7cACaZ5D1tmvzxq7FXsiw1eYaIDlcY0o=; b=cY6KTyDM/A/gWH3DwgojsUtSiJ
	CCSzOY7FBBP2kPTTHl4sJD6y1cNzL8cKMh7geTe5sf5cwql/BlKDzInGQ8zN8Ywh
	CM0qdy6Booc57JQrq/4XHwgS2CapRAYEBuoJqMXOzzqPgkP9CkTiGhUOIIZmuHzY
	jOMv40B51zqJm7D1S709OtJgPpvdlbAC8naByie0h4LVC/D1PmVCcDbMCN+BvDuD
	TnoMQqK0n+5nOhyKUln06LgVctPkrZSZrPo/JY/71h5VxqnUUwjdQJkqffFrqqR+
	kSyJhWotBR2XGYCeB86HjEqj4fOgWBUHhRueiWw/FpxR5VeoBKnMyfC1w0zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739382491; x=1739468891; bh=ufGgPDNpliW7cACaZ5D1tmvzxq7FXsiw1eY
	aIDlcY0o=; b=vzn9A0z7ZgKqP8ZjrdpYVq745p1AhAuIJVPaW+G+H+5ToXL5mWe
	5d1tyoNOOcTDjPDno9DuYDY64zO/vdXGrVZS7244kqEj53k6eZx2s5cS/Kb1HpMc
	voMjDxDu07DSD/qmBCkQmqcFNI5GgYVJmrkVlrhpTJcrE28u2sz7oKmRtXub09oC
	WRnZsGJJdD/Xpsbi1qw3FpDQrtrj0ewctslZ/k1xYga2zSnTccsmlMjGZ4h2vT/h
	+m9CDWPlmBBNpNbdU8Q3cJfiIcBpno9NE9zMHe2HeDWPYs8Qb2vIItc2DJ+BvhyV
	PRDl1sinCl6XnWxJvmdZX3lcIsks/OFfWAw==
X-ME-Sender: <xms:296sZzRF1MzabjewplkcEwBkT4Hs7eTIY4np1ubmqrY7WA1Z6zu0rQ>
    <xme:296sZ0xLdBj86x96LjAYo-YL6elEoBAU41UeaxqQTkYJhKrPHDYDQYsnKHT6pF7b9
    pppxrCGo4p64jKjEw>
X-ME-Received: <xmr:296sZ42vmi6nggLackiWG7F4ApGrWjHu6AE9ufVXk2tSM3vMIHbTfc7ZohaYlR051HJ96zunev0LxtjuNF31imWGgSrwWaZ5Z7J3Chs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdr
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:296sZzDZdDJNZgE60huGexE0OyRwK-1VXaWvNxZyafeTde5Xo2Kcgw>
    <xmx:296sZ8hdZYumE-UrAS18iDNZKyzMygTzgfS7cXLMS0GoaqQeyF_2wg>
    <xmx:296sZ3o6sdFgYWaPVMZErglFM0SdupwlG12N1ttuMKdVPBNUTt1WMw>
    <xmx:296sZ3gTFapNsiaMB_q8LhzEYFD21rrhI9k5DCA4sFWPykwa72xnrQ>
    <xmx:296sZ3VfbTFVoauKfxbcSAFBQH0riwrDVhT3Pye9sUpCA9fKdL1V-tu4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 12:48:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 4/8] packed-backend: add "packed-refs" header
 consistency check
In-Reply-To: <Z6xwW0N7GG4NhCzZ@pks.im> (Patrick Steinhardt's message of "Wed,
	12 Feb 2025 10:56:43 +0100")
References: <Z6RPJI10-2QkwyqH@ArchLinux> <Z6RPqE64ScsjzUg7@ArchLinux>
	<Z6xwW0N7GG4NhCzZ@pks.im>
Date: Wed, 12 Feb 2025 09:48:09 -0800
Message-ID: <xmqq4j0zuk9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 06, 2025 at 01:59:04PM +0800, shejialuo wrote:
>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index 6401cecd5f..683cfe78dc 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -1749,12 +1749,76 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>> +static int packed_fsck_ref_header(struct fsck_options *o,
>> +				  const char *start, const char *eol)
>> +{
>> +	if (!starts_with(start, "# pack-refs with:")) {
>> +		struct fsck_ref_report report = { 0 };
>> +		report.path = "packed-refs.header";
>> +
>> +		return fsck_report_ref(o, &report,
>> +				       FSCK_MSG_BAD_PACKED_REF_HEADER,
>> +				       "'%.*s' does not start with '# pack-refs with:'",
>> +				       (int)(eol - start), start);
>> +	}
>> +
>> +	return 0;
>> +}
>
> Okay. We still complain about bad headers, but only if there is a line
> starting with "#" and only if the prefix doesn't match. This addresses
> Junio's comment that packfiles don't have to have a header, and that
> they may contain capabilities that we don't understand.

We'd want to also ensure that there is a single trailing whitespace
after that colon, which we have always written after "with:", no?

>> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
>> index 42c8d4ca1e..da321f16c6 100755
>> --- a/t/t0602-reffiles-fsck.sh
>> +++ b/t/t0602-reffiles-fsck.sh
>> @@ -639,4 +639,29 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
>>  	)
>>  '
>>  
>> +test_expect_success 'packed-refs header should be checked' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_commit default &&
>> +
>> +		git refs verify 2>err &&
>> +		test_must_be_empty err &&
>> +
>> +		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
>> +				  "# pack-refs with traits: peeled fully-peeled sorted " \
>> +				  "# pack-refs with a: peeled fully-peeled"
>
> Instead of verifying thrice that we complain about bad header prefixes,
> should we maybe replace two of these with instances where we check a
> packed-refs file _without_ a header and one with capabilities that we
> don't understand?

Yup.  I also notice that refs/packed-backend.c:create_snapshot()
would accept "# pack-refs with:peeled" if I am not reading it
correctly, which is an unrelated bug.

Thanks.
