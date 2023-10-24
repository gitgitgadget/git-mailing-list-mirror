Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44402D602
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="athU9Icy"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E214510C6
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 15:03:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CBFF216F4;
	Tue, 24 Oct 2023 18:03:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nmuak45zcoZQ7aJf4Q/NroH3chmnS8NcG0JhtU
	Qe9dg=; b=athU9IcyQ15p4Qj7yzdiVdujofiBmQGVzXmMY/jmxJvNs4uklLGMZd
	e1I2NSFLme8K/h4rJoM3bME/AZH57g2Azl3U4GuVmVkHSWBwYK0drPp5nLLX9m2L
	FShfGd9ozN+xa/y5C/BDl2ObbsV9Bi2WfJ6SUVg4pVP9/UbJhcN8U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8426A216F3;
	Tue, 24 Oct 2023 18:03:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 036C8216F2;
	Tue, 24 Oct 2023 18:03:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Jeff King <peff@peff.net>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move validation code below
 process_address_list
In-Reply-To: <xmqqmsw73cua.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Oct 2023 14:55:09 -0700")
References: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
	<xmqq1qe0lui2.fsf@gitster.g>
	<20231011221844.GB518221@coredump.intra.peff.net>
	<xmqqzg0oiy4s.fsf@gitster.g>
	<20231011224753.GE518221@coredump.intra.peff.net>
	<b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
	<20231020064525.GB1642714@coredump.intra.peff.net>
	<20231020071402.GC1642714@coredump.intra.peff.net>
	<20231020100343.GA2194322@coredump.intra.peff.net>
	<xmqqil71otsa.fsf@gitster.g>
	<20231023185152.GC1537181@coredump.intra.peff.net>
	<393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
	<ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
	<xmqqmsw73cua.fsf@gitster.g>
Date: Tue, 24 Oct 2023 15:03:17 -0700
Message-ID: <xmqqil6v3cgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 23CDE33C-72B9-11EE-92EF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Michael Strawbridge <michael.strawbridge@amd.com> writes:
>
>> Subject: [PATCH] send-email: move validation code below process_address_list
>>
>> Move validation logic below processing of email address lists so that
>> email validation gets the proper email addresses.
>
> Hmph, without this patch, the tip of 'seen' passes t9001 on my box,
> but with it, it claims that it failed 58, 87, and 89.

FWIW, when this patch is used with 'master' (not 'seen'), t9001
claims the same three tests failed.  The way #58 fails seems to be
identical to the way 'seen' with this patch failed, shown in the
message I am responding to.
