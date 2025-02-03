Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CE1367
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738541076; cv=none; b=igKvJQh46vyv6QSSs3ExxBU4RIu5w3Xq67T2YPSA5br+bRgkd1OKyirTXtrAh/7uiBNWrVw80j27ZOhs2MPq+MOL/aZbhyjPr//C6f2eZBzxcic62APbmsyFael0Mb27G9w9l/eMiCY6eOXaK72XVA0ctl8vUkLYALPEK47F7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738541076; c=relaxed/simple;
	bh=Ct8/GTTYRyCLUqTd4xCD99BO6WFMZ7qitWzOZC+Cn+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AnQHir2htHfCbumC5BLGUlDBaWev6WYtzrO/jCrAhiiGJQaYe2X3aiUAicenw4deO9YbnSD/BShhmvbEsZm3Bw5+K95SWH+nBPj2IpkZrZ8mBaGnDZIqyO/EA83I3ZYZit9xy1N3b7m+RDlKlXOtTeN2yU45t5Xjf09TVqL9V2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C0Y48nI6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bVndxqRu; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C0Y48nI6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bVndxqRu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4685525400A4;
	Sun,  2 Feb 2025 19:04:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 02 Feb 2025 19:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738541073; x=1738627473; bh=3MgQWuVlmd
	nqlKFd3p/PZug1NeyOTsGCRzvVwsIiRwk=; b=C0Y48nI6A/m+oTbYp+O68+WQki
	71uDDLcnKGU7v5bihliyQd3wfd0oYEOawis+3ke5f0x8p3WuNGmwH0B2tL2P/rYm
	nVqb/kbD/dZnA85+8kO+nSf/cbnkvAjpMTrTOfoMJcV5Q/l24lNnbFk/2m0kHrl6
	XMKnqBJj1CWObUvh6cRYLEawNveDL/yQ6DNOvM4//8iaCcjCDWltK2wK0392BUPp
	bS3IR9favwD9xjyRtPoB7pwRhSQjx+Rc6Bj1TjU7O5ZqeZvAcALE97b5CQUhwme9
	yLYcPkyTJ+1WBsCHfzYczkODdKsRc6lV2vXFlQPbJuD6MfWsD6T8A12vwZsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738541073; x=1738627473; bh=3MgQWuVlmdnqlKFd3p/PZug1NeyOTsGCRzv
	VwsIiRwk=; b=bVndxqRuDqU1NFC1LnWKPWYgrK62Fiu0xb09BQd+Gu87ikUohYI
	sJuPdZzlEIeJ9JUsz2lg590+8sudM1amPLN9eieemmsYxrRyZaQRUlPV9aWROgL5
	YNPLP0pIRCWuhDAgqJBy7fKV6LN48ayQiuPV19efG7rsyrwu2HceCJtADPG6iolt
	Q0ZchcZ6CPLnTktrFiJSIq5TBJGkjQ2h7nKGiluJ/8v/TDVcRi1ylGgg6CeoY5ZW
	Fmqj8ZWtziQzCPSm7bOT9CrPA530HJmMzlBZrOl00SLg74idc22bpgtvP3w+e+SM
	QY8fwVjelMuFnZwGEkbGaucU2a7+dLKGG8w==
X-ME-Sender: <xms:EAigZ9P-ShRis3qt6slLnJQADz6yaDp7vP9GCEw3qrYhczXqRY-GKQ>
    <xme:EAigZ_8tWjGOH71gZKfsmp0F6Gz_JIVuYyQTuuw2e8Yy8M1uUBA7BFfKi_bx0AvkF
    PNbgV1LemoFsd1POA>
X-ME-Received: <xmr:EAigZ8QHLYlHJd3yMV8lUPxbsbe9vta5CxKM8zdFuiJ6fyuQ2Z8DNRLuOfSsQ2SHjRttLDfin6NdPI9NOQ6l88P1e_nXk1M-xR7F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefgteehueekjeekffehudfhgfelgfdvvefh
    leeludduudffjeejgfetledtieeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgr
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EAigZ5vSuULQDXvfyaNVqy2ayp6PfHeQ4dWakpqpKTtwt2pz5Ki_GA>
    <xmx:EAigZ1eyfSkNOPapKrYw-ynlUX56DQvgfnMo1hV3YLf-F0exC4qelg>
    <xmx:EAigZ1212fPvKxpwfz0dhEToaRLycaV5uxtG16LQ8DjRVOS-4VFJxg>
    <xmx:EAigZx9Y_bY6bkIO9hUJJNgJSSi2wLm9XQwTTR5rP1b92RyQPtKacA>
    <xmx:EQigZ84r0ELbOK05yDvVCZrDG9DKa5KEOBuxzPH4hN1UND9ksoF6IpD2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 19:04:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: ayu-ch <ayu.chandekar@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t6423: fix suppression of =?utf-8?Q?Git=E2=80=99s?=
 exit code in tests
In-Reply-To: <CAPig+cSBi05Kq1ohxQJ8BwTsis++fAAaVCd8Ep8k=8cLS74jsw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 2 Feb 2025 08:35:45 -0500")
References: <20250202120926.322417-1-ayu.chandekar@gmail.com>
	<CAPig+cSBi05Kq1ohxQJ8BwTsis++fAAaVCd8Ep8k=8cLS74jsw@mail.gmail.com>
Date: Sun, 02 Feb 2025 16:04:30 -0800
Message-ID: <xmqq34gv3nch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> I was curious if the project has a preference between `uniq filename`
> and `uniq <filename`, but apparently we haven't:
>
>     % git grep 'uniq <' -- t | wc -l
>     2
>     git grep 'uniq [a-z0-9]' -- t | wc -l
>     2
>
> Though there does seem to be a global preference in the project to
> specify the filename directly to the command rather than redirecting
> from stdin. For instance:
>
>     % git grep 'sort <' -- t | wc -l
>     54
>     % git grep 'sort [a-z0-9]' -- t | wc -l
>     140

Have you inspected the hits from these grep runs?

    $ git grep -c 'sort [a-z0-9]' -- t/t7004-tag.sh
    t/t7004-tag.sh:17

Among 17 of them, 15 are on test titles.

    $ git grep -c '^test_expect_[sf].*sort [a-z0-9]' -- t/t7004-tag.sh
    t/t7004-tag.sh:15

So the above numbers are totally unreliable as a guide, I am afraid.

It is probably better to use sort/uniq without input redirection
because your

    $ sort/uniq input >output

can be easily extended to

    $ sort/uniq input-a input-b input-c >output

but 

    $ sort/uniq <input >output

cannot be extended the same way, and you'd end up doing nonsense
pipe like this:

    $ cat input-a input-b input-c | sort >output

which is a no-no.

In reality, however, we are not all that logical.

    $ git grep -e '^[ 	]*sort [a-z0-9][-a-z0-9]* ' -- t | wc -l
    46
    $ git grep -e '^[ 	]*sort <' -- t | wc -l
    51

with "s/sort/uniq/", the numbers are 0 vs 1.

There are a handful of sort invocations that take their input from
redirected <<HEREDOC included in the latter number, but the overall
picture does not change with them excluded.



