Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820853FE27
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826406; cv=none; b=rNg+9GX6AFDXzuUa0mqdfjkOTSHqvl8zjjIcKH43ChPC8ZwyiRKYmXpWCDHGgWD9iZLcCyTlsDohZZEbbir96XQXReVprcwt+INnp29OKYmFUlvKtIPlEFcQl8oCSHJdPkrsFkokJyaQh5Inv7npu7duDiN8XsY4dl9CZgZv0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826406; c=relaxed/simple;
	bh=qpUq2R22s5l7JfwP+pW562vOytVMoUrGS9qglwLRvGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pU6HuVg0N3PUt6jGaAjdb7wQUtFFZovHBfY/PUaw6VNZd8UwE9M15EDR49+lVVy5j8+eGprNup5qq0ExXXo3tR6aH29M/7xgkOnzV54kVZyHWXANJQi8UMkYB9JCck1jIW4ob8Fcyf/OxQeOtZNbHS55EGkzzxru9cuCvmHjLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x3PxT6T6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x3PxT6T6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 157EB1E2AE5;
	Thu,  1 Feb 2024 17:26:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qpUq2R22s5l7JfwP+pW562vOytVMoUrGS9qglw
	LRvGI=; b=x3PxT6T6gjJtdq5mBrnFhU/UkSEgDrDQj3mlK/RBXgdrVacoRY8PJr
	iPuURfBt2LAn2ahTNE1SbPbbYhalmmIWLydotkA5F1eIMwtfdHwT38jblOmJFGYv
	+GAS1crHb9vdCiBIXNxSn6zex0lBmVDm4U+TwdsGqsTSrTPTQGPAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E11C1E2AE4;
	Thu,  1 Feb 2024 17:26:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A2161E2AE3;
	Thu,  1 Feb 2024 17:26:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/4] test-tool run-command testsuite: support unit
 tests
In-Reply-To: <ZbwV9iGsTWZ3ddfn@google.com> (Josh Steadmon's message of "Thu, 1
	Feb 2024 14:06:46 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
	<xmqqv87sx3y2.fsf@gitster.g> <ZbwV9iGsTWZ3ddfn@google.com>
Date: Thu, 01 Feb 2024 14:26:41 -0800
Message-ID: <xmqqle83x1lq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F9A81EEC-C150-11EE-B25D-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2024.01.16 15:18, Junio C Hamano wrote:
>> Josh Steadmon <steadmon@google.com> writes:
>> > With these changes, you can now use test-tool to run the unit tests:
>> > $ make
>> > $ cd t/unit-tests/bin
>> > $ ../../helper/test-tool run-command testsuite --no-run-in-shell \
>> >     --no-require-shell-test-pattern
>> 
>> This makes me wonder why we want to do the readdir() loop ourselves.
>> Instead of saying --no-require-shell-test-pattern there, wouldn't it
>> be simpler to say "*" right there, and have testsuite() run the test
>> programs named from the command line?
>
> It's speculation on my part, but I wonder if it has something to do with
> the number of shell tests? Google tells me that on Windows, the maximum
> command line length is 8191 characters. Which is actually a fair bit
> smaller than expanding the shell test list:
>
> $ echo t????-*.sh | wc -c
> 25714

OK.
