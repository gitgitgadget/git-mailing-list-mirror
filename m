Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2A4D8C8
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180567; cv=none; b=raVdXzqFwKLxd4O5qFw7sS3961RXk+0xObHgVzP708nqinQ+laX4hcl6R4ARP4Wk+L3WQDtxGVQ32uelKwoF3SsCf64OyfrrNheR+x7MTnRGhaoNzlPG22iaSaonSnYKKx/PmKMON/wN++2C2lMKc6NSNQKHqw9gdINSSz+S1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180567; c=relaxed/simple;
	bh=hX6Itf0wtcalvns8Y+z8fSURvu8seX2fjS6PwjALnns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMta3HAexXc8gtPYmmZX+Y/dLru3ka83LfkekUdDB2oLTNvFj/4gEr2Hlh/AGkEzT+3f5sFwbPLEoT972DevR+/bUCntHglAT8v77Y7jGTZlPhyVLovH3HAWrcmpPxuE+cjid8I8zyM5U6NCwIX8rQBRdmMjS4mkd3GOP3CobG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=6xXzhxFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UvIEz51U; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="6xXzhxFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvIEz51U"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 652712540043;
	Mon,  6 Jan 2025 11:22:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 11:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736180564; x=1736266964; bh=kf5WV4RUp3
	o+2fOWFrW5gro6AxmjhyVnKq3LSnxWo4w=; b=6xXzhxFhEUF3JV4pUqBK86SFd6
	2MtsGSXK8YmKlU7wsX/VzntiGryeSVoxbaeQ7HC4JsR2HNlAHAyiTK/9PVEtGgCN
	Gg7Z71U4kIXtxzS3oeJBpYe3Ia7YIwScHzWF8QuWFFUvQY4pQD1NeWYNGPSw9WGi
	pWqfcWMwLCect3k0ODzchooMlZNgr1quaE1X8iEPJKtPpsjzco+CkFzZPaubIZHu
	Utvs6wjExc3BwRuwVz2KPPoWoLbnzEcRuE0C/xNNQOW7STeSY0WuYzM22eClorcV
	XRT/5Ggn3bl1qqcdImCPvfU7EB/UJyY+AQ2XFJ9+3woBCg/DbJtTaD3a507w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736180564; x=1736266964; bh=kf5WV4RUp3o+2fOWFrW5gro6AxmjhyVnKq3
	LSnxWo4w=; b=UvIEz51Ut1z7AD537i8Mi0tvdKm875wH3kjvMEcKJXb22cvJtYJ
	BRCzY3UX7gUojhXSTpovUe+dG1UEuVz9jLGvxkVJQP3eCKBptd+q5Y3ekHVv/dN8
	ih8bBVsmU0EwBA6lI+j1N8dQvfEiYiIb5itR6I9cyxzUQ5nYEb1fpJ+wqf9TwOQ/
	8kOhRchNddIChtgmGH01pS1cLsfTEaCjvkW6+EY5C8PL1YPaSfJk6aJZZtln9osp
	QOHiyiRAcDChaZYAigUFQelDrCCx8nYnmmA/F16w3xGnAD1zhv24ypHMxyVMbhXQ
	Edrlk60xeqw9i+QMO1YxeHHsK0uD1GIeFkA==
X-ME-Sender: <xms:UwN8Z-zqMgN7su_Pin4E50OzzSo-pWvjG3S7mF9zVIhWAxIpkFu9Og>
    <xme:UwN8Z6QqRJ0iVrzif-VEhrJlmqG0ibF12rkPckQ7-wkAeYLwOF6p38g6czMZBejMZ
    67TnIof-ow1uUT86A>
X-ME-Received: <xmr:UwN8ZwXY5bJ0IU0khtDDW78IRnDStTWtGlbxYDaHkO4h1AM-wrDMepQsuzi28zQvPjAezvoBMVGoUs21KZXqRSbaOZS5ita7oL5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:UwN8Z0jkcGuTJBsOlVRh7DxYcvgfkNndz7FM5fkOt8Oq6Eb9g51YDg>
    <xmx:UwN8ZwCnzUpC_2Xijz7XljqxpeBJuBzKmOdodRXH8FjJGjx3okBwsw>
    <xmx:UwN8Z1K3gBKZUkr8uG714_KR6E6d7FJMkhoxocNITGcaUesnK7VV1A>
    <xmx:UwN8Z3BLtxNpv6-FP54ooT116SQMvmE6_pNy52amtTButIbuCcA5Uw>
    <xmx:VAN8Z07569UQmDdMMdv5-eiZZ7DLY6B3Ro1RkApbVrvf-GM21lft_Oqb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 11:22:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] connect: advertise OS version
In-Reply-To: <20250106103713.1452035-4-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Mon, 6 Jan 2025 16:00:51 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250106103713.1452035-4-usmanakinyemi202@gmail.com>
Date: Mon, 06 Jan 2025 08:22:42 -0800
Message-ID: <xmqqfrlvzzcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> +
> +transfer.advertiseOSVersion::
> +	When `true`, the `os-version` capability is advertised by clients and
> +	servers. It makes clients and servers send to each other a string
> +	representing the operating system name, like "Linux" or "Windows".
> +	This string is retrieved from the 'sysname' field of the struct returned
> +	by the uname(2) system call. Defaults to true.

Shouldn't `sysname` be typeset as a literal, just like `true` and
`os-version`?

> +os-version
> +~~~~~~~~~~
> +
> +In the same way as the `agent` capability above, the server can
> +advertise the `os-version` capability with a value `X` (in the form
> +`os-version=X`) to notify the client that the server is running an
> +operating system that can be identified by `X`. The client may

Hmph.  I am not sure what's the value of mentioning 'X' here.  To me

    ... can advertise the `os-version` capability to notify the kind
    of operating system it is running on.

conveys the same thing with much fewer bytes.

> +optionally send its own `os-version` string by including the
> +`os-version` capability with a value `Y` (in the form `os-version=Y`)
> +in its request to the server (but it MUST NOT do so if the server did
> +not advertise the os-version capability). The `X` and `Y` strings may
> +contain any printable ASCII characters except space (i.e., the byte

This is misleading.  ASCII printable characters range from 33 to 126
(inclusive), but by saying "except space", the readers are led to
believe that the author of this documentation thinks ASCII 32 is
printable, too.

About 'X' and 'Y', we can just say "the value of this capability may
consist of ASCII printable characters (from 33 to 126 inclusive)" or
something.

Is there a need for a registry of canonical os-version strings?  One
reason why you would want this user-settable (as opposed to being
derived from "uname -s") is that a system that is presumably the
same in end-user perception can call itself in different names (your
Windows/MINGW64 example) and having the users set it to a string
chosen from a small repertoire, the other end would be able to
identify them more easily.  I do not think it is a necessarily a
good idea to limit what value the users can set to this
configuration variable, but at least with a published guideline on
calling various types of systems (and an explanation on the reason
why we publish such a guideline), users would make an informed
decision when picking what string to send.

> +# Trim and replace each character with ascii code below 32 or above
> +# 127 (included) using a dot '.' character.
> +# Octal intervals \001-\040 and \177-\377
> +# corresponds to decimal intervals 1-32 and 127-255
> +test_redact_non_printables () {
> +    tr -d "\n" | tr "[\001-\040][\177-\377]" "."
> +}

Just being curious.  Do we need to worry about carriage-returns not
just line-feeds, and if not why?

Thanks.
