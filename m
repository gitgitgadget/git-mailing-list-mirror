Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF7154452
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214945; cv=none; b=kHL7gdW4LDZ5XuWvV5qmjMPec48Bgqew2ptOcZ5jKZZJ2XwPsH4s/PZkRlNYN/msAe96TXUSmltIkpEA+ANxKOVYTJk6u/xN0Ae8uB1oCUXcMH3iIGxoY5rKRObv9xqxN8s7CWegHWM+ceV2ivhUB3jau41eruxBDzzxKXLqFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214945; c=relaxed/simple;
	bh=Luqh/ruKkgNTb7QN14Gj7X2G5LDaKLWRiwSEUqxZx+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUt2+B/hcu0RgYwwMgfUDH6DD+V0FHNqWaPfRVmkze9Aee67i8PDUY/c6wSxPOZAHmXa6IP4e1zqeTA9zvayJ/rf25U3uH4v4VdR2HvoaF+LmCL30E4RpGGSu3jXyEMQk7FeskyaJh+hT8qPh02ka5dI7ICTwigFFW9f4KEKPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qDSQKGRF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qDSQKGRF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C7981F1162;
	Mon, 15 Apr 2024 17:02:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Luqh/ruKkgNTb7QN14Gj7X2G5LDaKLWRiwSEUq
	xZx+E=; b=qDSQKGRFv/IGIpNxF6wjIJwS2l/lQUwbl0PsE34leZxDLvXhJGi/No
	DxU9HUJ+7oCa+VM4P8iZNwSpr+1g3k4aMPArE4WBXtO0PdPNgngA8OTk3DnsOHV7
	P8YmfPJ1NqDDGHqXq7vl2N9FACCt9oCFv2Uf8EzuDEBZkaebPPEIs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61D871F1160;
	Mon, 15 Apr 2024 17:02:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A650E1F115F;
	Mon, 15 Apr 2024 17:02:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>,
  Emily Shaffer <nasamuffin@google.com>,  Josh Steadmon
 <steadmon@google.com>,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Hariom Verma <hariom18599@gmail.com>,
  =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
In-Reply-To: <owlyjzlg623v.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Mon, 01 Apr 2024 17:27:00 -0700")
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
	<xmqqplvg7j1y.fsf@gitster.g> <owlyjzlg623v.fsf@fine.c.googlers.com>
Date: Mon, 15 Apr 2024 14:02:19 -0700
Message-ID: <xmqqedb6l4pw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73BE9C70-FB6B-11EE-8960-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> This series is based on the initial series [1], notably the v4 version of
>>> patches 10-16 as suggested by Christian [2]. This version addresses the
>>> review comments for those patches, namely the avoidance of (temporary) test
>>> breakages.
>>
>> It has been 10 days but we haven't seen any reviews on this one.  It
>> could be that it did not get to intended mailboxes due to the header
>> corruption (I manually fixed in this message), but without reviews
>> we cannot move forward.
>
> Adding a couple more folks to the CC list according to the
> contrib/contacts/git-contacts script. Thanks!

As we saw no responses after two weeks, I took some time to scan
these patches myself for the final time.  I didn't see anything
gravely wrong in it and am tempted to merge it down to 'next'.

Unless I hear objections in the next few days, that is.

Thanks.


