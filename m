Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8114C5AE
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264770; cv=none; b=XybBRxypdWlQRt6E9vr5lgtfpg+AO29d8lTanEW0Ct3iL06C3da7UCsQY4C4rQGCRPQKU7AYw5GMSASmtx/ogLQ5lCXagTwtRHuzPwG3qsqBnCDBQI5jf1tjKCWVnguryyzXQOjaA4MYxx8mBTd0i6TQqA2NbJPBOFqf/cDGv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264770; c=relaxed/simple;
	bh=0ROBRY4oBMV00YME2rkirnuyNuQyN79XMOQEHosKFb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=arHHoyNDYuYOfc7AyxKv/xaIiV02MsPe7x9fKY2e9QxxKueqvso9XI/nuoWaiY0X2eNyhXOVmqhzIPi/oF5jKAILt/cywRdnycbFF+G9hNkvJqqmwR7LzZOCY7LSaiV32Jj2c0fZ4A24uge+aup1ZdMRKCGJCQlOXFkO2tFXVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SiTp636p; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SiTp636p"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EEC737E2D;
	Wed, 21 Aug 2024 14:26:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0ROBRY4oBMV00YME2rkirnuyNuQyN79XMOQEHo
	sKFb8=; b=SiTp636pT0rQqnsqK2555LtC7PsXW4jyZ9dYSbD2pvqrtDdXueoefB
	HDrZUeCOAxH6YaXI6FxYKTgRQ+i/nObeE+DozlG0bwSa4Wxv4i/pNJna+SBQ/RIq
	JCR3oY4ifSWg26XcTry2+Tc6shFh7rBe9Ubow3NEpxy2FinYf5YY0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 268AD37E2C;
	Wed, 21 Aug 2024 14:26:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B9EC37E2A;
	Wed, 21 Aug 2024 14:26:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] check-mailmap: accept "user@host" contacts
In-Reply-To: <mjlmmgwczact5ryprmorqztip2ynpcu5gpbulfabnoul2ubnr6@pfaxe7j4xo3h>
	(Josh Steadmon's message of "Wed, 21 Aug 2024 10:50:14 -0700")
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
	<20240819-jk-send-email-mailmap-support-v2-1-d212c3f9e505@gmail.com>
	<mjlmmgwczact5ryprmorqztip2ynpcu5gpbulfabnoul2ubnr6@pfaxe7j4xo3h>
Date: Wed, 21 Aug 2024 11:26:06 -0700
Message-ID: <xmqqjzg9ybpd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D5368CAE-5FEA-11EF-8777-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

>>  test_expect_success 'check-mailmap bogus contact' '
>> -	test_must_fail git check-mailmap bogus
>> +	cat >expect <<-EOF &&
>> +	<bogus>
>> +	EOF
>> +	git check-mailmap bogus >actual &&
>> +	test_cmp expect actual
>>  '
>
> I think I'd just remove this test case altogether, IIUC it' doesn't
> provide any additional value vs. the "check-mailmap simple address: no
> mapping" test below.

Sorry, but I do not follow.  The other one is <bogus@company.xx>
that looks more globally routable address than a local-only <bogus>
mailbox.  Isn't it worth ensuring that we will keep treating them
the same way?

Having said that ...

>> -For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the command-line
>> -or standard input (when using `--stdin`), look up the person's canonical name
>> -and email address (see "Mapping Authors" below). If found, print them;
>> -otherwise print the input as-is.
>> +For each ``Name $$<user@host>$$'', ``$$<user@host>$$'', or ``$$user@host$$''
>> +from the command-line or standard input (when using `--stdin`), look up the
>> +person's canonical name and email address (see "Mapping Authors" below). If
>> +found, print them; otherwise print the input as-is.

... it seems that <user> without <@host> is a supported format.
Should we update the document, too? 

If the @host-less name is meant to trigger a random unspecified
behaviour, whatever the code happens to do, that is perfectly fine,
but then we probably should not be etching it in the stone by
writing a test for it.  So because of a  reason that is completely
different from yours, I'd support removal of the "bogus" test, if
that is the case.

Thanks.
