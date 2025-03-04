Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0025D523
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111597; cv=none; b=dRw/s5LShvOFYj/f5AYhO84KdTth4l2isCYm7gsh4FM5hjrYTU0WKjA9AkAabOaozFqyRPbskNzHaN1GLe8z3Z5Sf4ScdZDx8oEayK2z2g9yNqm4mEh+hmUN6oLdRxv0J6ZC+TbfxUBhg+lKwskM/+t1GuaaKD+kpEh1FHOQT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111597; c=relaxed/simple;
	bh=6ly4/FuzCnWYTP+OJizH8nOZjUQQocYbUncOOwv6LKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzdcRt/wykhmDwOpi7r1ud8RZ2UnXIc7ahDcBtk254GnhSvsAUEHwfVQ72EXtoi6NoSf6KjoV3JbbSHNguH+4195naZseH40kpAqZYwN7MGX8cNRE3FygNCcpj2cJ3Qx/bInQYQzQVPJ8M9BMwN4DbzOqBzIySERu5EAvSfD7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JYQAy+zU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0Bn3NUP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JYQAy+zU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0Bn3NUP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27E1A11400EE;
	Tue,  4 Mar 2025 13:06:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 04 Mar 2025 13:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741111595; x=1741197995; bh=qapRRWZKeN
	agOKMLPW+1/57nPu7vWMXL1tyRcCGSnDw=; b=JYQAy+zUKBX0VolYuIYaNkDP1j
	4DsWhLBKbMr6FpYXaanMbGL8VoTtrUZCyqRE5p+QYDS6vB1mwVfcijYbKp7l7MDE
	quOFEMDa6YQYgLhhs6Miqs6V6PZUHOCCu2Z2pL/N4u/Wt0R7ZCPnaIvp7VEmQhRr
	2dSJbnY5ExL5HVL5o9pV2UquVX4CusnFl7dTVbFPH3et4rReZrRo+6rqDaKsfOVh
	lNakDjPctIi2B6kgzKdO9NtzO97er4wJGzuNJ30LCSV4MfkRADbylzrizZOBx7g4
	1/ytvAFVS2SYYiJWuNAoA8ACaUOm32JnHCGVDEW7hhEmXiBbnWg4AP5Dl9OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741111595; x=1741197995; bh=qapRRWZKeNagOKMLPW+1/57nPu7vWMXL1ty
	RcCGSnDw=; b=L0Bn3NUPgKss4tOjsoOkyIbqN1x9VEg50YUgEIB7AJ0Hg9Vag6d
	vt4xzVGCtK6GKHeO/eu2wMqVw3rbod5HcysdBRfkWrS5Gi5jIFkG5eqb1at0zdmV
	cozyaaWstixCPOiBKCfsfPmD+lwvFRZfS+ol6MmCxMJGBqQQSZ4gRsiUKaK1xBHw
	xeIJLSrEs8w2EKC3ZpooNkuERDlUTLzW65wNXpypBq6U032c0h1wKUHpSi7DtJf+
	lswwDSJGTaF6V+SIxE1Ex/vb/2WsiQBe+5yfJcLzGFSw89gW5sKLw6jZf1J3SoMI
	y5cjiX4iLmP+rLm2i1qz4Y4gTzKOa9IyTNQ==
X-ME-Sender: <xms:KkHHZ27TrK8pNYgueVCVSKxeNSGNCAsQb6tcSh5p9Fs22TjTTbBgbw>
    <xme:KkHHZ_716Kf6c8xc1ZHMwqf5DbebAyco39h-Gg1SjndIk8bFBP9-ODLasTkUNBe-3
    E_9v8EVYS7MPBjo-g>
X-ME-Received: <xmr:KkHHZ1dJu8xPTIhqzfvw3TvSSZkmPz_eij59Ljx81RQiER5P9Dq2flRRV_2AeWZK-2uIn5tsZCfLh6zqJQ93T8FhksFi_mFXr0j6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhimhgrhh
    gvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:KkHHZzLQucIcQCW4GY-OzHVzkAd5AYDO96XafemzGG6AXWsM0oVydA>
    <xmx:K0HHZ6JVhmBMZnUzCqURlo84sqC_XqxP5FEo7vGAXPXrpzICp2FYyg>
    <xmx:K0HHZ0yeYLjPeo0Z5E9mdme8hipxRvTeJkvnw5UIK9FBRwUJLzsuWg>
    <xmx:K0HHZ-I_CZjEIURFk0pKYggkEEnoVZN8TZpjalFTDrfCyNqpztu1UA>
    <xmx:K0HHZ20BasGB76JoIo9Y50wX5exRRCz5eX0OAWHny6h4pxJhnrn6GgRn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 13:06:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] t1403: verify that path exists and is a file
In-Reply-To: <xmqqv7sopt7o.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	04 Mar 2025 10:05:15 -0800")
References: <20250304091556.22478-1-danimahendra0904@gmail.com>
	<20250304094153.28959-1-danimahendra0904@gmail.com>
	<20250304094153.28959-2-danimahendra0904@gmail.com>
	<xmqqv7sopt7o.fsf@gitster.g>
Date: Tue, 04 Mar 2025 10:06:33 -0800
Message-ID: <xmqqo6ygpt5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Mahendra Dani <danimahendra0904@gmail.com> writes:
>
>> test -e does not provide a nice error message when
>> we hit test failures, so use test_path_exists() instead
>> and verify that if the path exists then it is a file using test_path_is_file().
>>
>> Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
>> ---
>>  t/t1403-show-ref.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
>> index 9d698b3cc3..4afde01a29 100755
>> --- a/t/t1403-show-ref.sh
>> +++ b/t/t1403-show-ref.sh
>> @@ -196,7 +196,8 @@ test_expect_success 'show-ref --verify with dangling ref' '
>>  
>>  	remove_object() {
>>  		file=$(sha1_file "$*") &&
>> -		test -e "$file" &&
>> +		test_path_exists "$file" &&
>> +		test_path_is_file "$file" &&
>>  		rm -f "$file"
>>  	} &&
>
> Makes sense.  Will queue.

No, no, no.  test_is_file alone is sufficient---if the thing does
not exist, it would not be a file anyway ;-)

