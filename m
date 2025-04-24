Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5627A126
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498602; cv=none; b=R/KhA92J0tqRa8pSubmzjgF6wJqyHa/3ETTn7PtunOBFheghnEs/diGgrS1IMqoUIFwtk0Se037T2utvhu5DInnl62pwwWLddprlmiS7uVnOq7dT0aiO3udKv/msfQ3saxWPaUIcYQbDOI+qw4I+eLhMZpfDM5yf7lzv2qI+sZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498602; c=relaxed/simple;
	bh=7d/t6awXYioZlwxq/RHl8X7whujYqmR+zBmoTKolmps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4IFmKthxrL3Ca0oX8NN00OEwX2NDq61BMwhsQvGdARXZNCmqVLvy4WNh5uFCafMxuayR8MMnZlrOh1j0C58mtB/0zsBiBYsFbeuFAg0FDyK7Ntay5wcIEWKDZymJci72CoD7+LLM6srBzw1s3nqqLkckfJZjyHOo7jLfl+koRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iqx4NHSh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QllMGhIT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iqx4NHSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QllMGhIT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1A662540246;
	Thu, 24 Apr 2025 08:43:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 24 Apr 2025 08:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745498597;
	 x=1745584997; bh=CtQTzqojIwDX8BpUb6m/X3m8HXoEdjhWfkRXSrLSf1E=; b=
	Iqx4NHShqI/D74uNmCWvwvn2pOSSMzLKVI6yj2LYnriqBubIYEKullxEDRl8eV+1
	HGQpOyaUCjPZNzh368W38lQwSwrPUOrL45FRfE9h2p7Skh7KY/9YVBbsUwY6T5LD
	v04W+vZRvCPxa6ez9E5XeloZOFdJ6dqt2jSV3ij493mItpbFcC8JiAPCOxEUcFzp
	HeQreT5PudguNIEoNhIQCR1TZzYSf2f8joT7BsVRUWY3nVFgRR3M8K9meuZlFIyG
	PFJ81Rg6tL5emon0huEuEO/kFZzwT0Ha09y7coLyBjxJKrvkP3EDuXxVYKXZgODV
	5FMadIglVt4PBZkzcAeJwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745498597; x=
	1745584997; bh=CtQTzqojIwDX8BpUb6m/X3m8HXoEdjhWfkRXSrLSf1E=; b=Q
	llMGhITO/t4dj+yiW8YKJ0OLhzLA+J8gEYmDYzcIUK80+Uk/4jeYQEyxjcvp+cLb
	dWgi4Jic3875BIVjtCuLaKUXFKRLoZ8D5egB32pLXlMbzBQ9qNR/Kcqyvx5OsyUT
	KZtCsdKMA9IYvzZ5DSgZBzwGhEho8jxaFVyRIqJlhGpE995TW0OoO/Tn8OmVSbrz
	guvix3CatwF5RbWu1Wt745AuglKRFv+KJtgAFG3T5/U/FlBc+09h6rcytKplfVZ5
	JymXD29qq0M59SloCiEHHlROj/nakEL3/NjSQ2yhek1BQaw5kFO8eLbFAKHDkV4K
	UORJ89mTjGYYpFpOKBXKQ==
X-ME-Sender: <xms:5TEKaHnBO12Dn-c-aiIUoJs3X0B3gMeW031k6inhXqxx3H4GgXPK9A>
    <xme:5TEKaK0yxvNds-HLLXWHBfnLQ2WGkvURwF3C-QnGWjhnuvUm1ZPqupmZUWeB74M3d
    N2x4sg_-KuWIef41Q>
X-ME-Received: <xmr:5TEKaNpZx5GOEJ0Nk-euCawol1vMfu-RqfAelUPyPklbpjnDX1-90uPW8luwkrGQZviC_v8S_qw6ZnOHKRB-nJpSfJOQvzHlSOuu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrug
    hithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgv
    mhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopeifihgrghhnvdeffeesohhuthhlohhokhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5TEKaPmJdlLWNSd4Sl8EMMeW-GqtAQI3EjCLpVOyN5QhqXLhyCNppg>
    <xmx:5TEKaF05Pvji3-IbVRHBr9Ioib6mALSxcvQFBjLkuRhVRsVrdvJrMA>
    <xmx:5TEKaOuWqqI-mCysvl0KUvXBaZa5q7gnW_4rYnjFeW6f06BEaNJGyg>
    <xmx:5TEKaJX1euMGShctJ0BYTPGoEIbiPUalKAvmFf9OFS1dD0KRMXefQQ>
    <xmx:5TEKaPTN8pKMO3gkyq9A7XUlyNsUhengIvICfv1qO6kCMfuBHUUyOBgo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 08:43:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  M Hickford <mirth.hickford@gmail.com>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Shengyu
 Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
In-Reply-To: <PN3PR01MB9597B700337C132A0FB053FFB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 24 Apr 2025 03:29:09 +0000")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B50EF69AD097C594F844B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqwmbaya21.fsf@gitster.g>
	<PN3PR01MB9597B700337C132A0FB053FFB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 05:43:15 -0700
Message-ID: <xmqqr01hvifw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 24 Apr 2025, at 12:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>> 
>>> @@ -230,6 +230,14 @@ or on the command line. If a username has been specified (with
>>> specified (with `--smtp-pass` or `sendemail.smtpPass`), then
>>> a password is obtained using 'git-credential'.
>>> 
>>> +--smtp-passeval[=<command>]::
>> 
>> Lose the pair of [] that marks the value optional.  Compare it with,
>> say, --smtp-user that is described as:
>
> The value is not optional. It doesn't make sense to leave this empty right?

That is why I said "Lose the pair of []".  IOW what we see above is
wrong and it should be something like

    --smtp-passeval=<command>::

without the [].  Just like --smtp-user takes a mandatory <user>,
like this:

>>    --smtp-user=<user>::
>>            Username for SMTP-AUTH. Default is ...

your "passeval" takes a mandatory <command>, hence =<command> should
NOT be enclosed in a pair of [].
