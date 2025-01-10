Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F218C03A
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544769; cv=none; b=er8Ow7++AetiKOOCSgpf4ettRZdvWny5j9G9Z0KQc/HK3tFydJj5RqqyXH8VDbgRvOyZcPeFJozkO+oEtCfuOvmy/MDPLyoMIW8MjAJjx52OtBMuND3mEKRgfbUqJYM4u2GfInK70ZwmRpM/CaKBguWQZkomYNWkvyvl8MAz27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544769; c=relaxed/simple;
	bh=YLrO0vbDORyoTALHihambF0ermTOm5NWWnzQv5N5KY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VjqW0XBgZjmdT++pSZpYdP2ZgX8sZ9DcuPENeAFVUI+euKb5wV7g3NZu0TIip06MGdsJi8VPTEsL5E1yfybbBoH7aLIaAtcqch2vuydyN4zkO2BfsYA1rvAlfHXeKOoA3C6gkmAIRPgBGSN5B3Eme4ew7ZWdnHY1qtb6XyqqO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dHRLU4na; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vz/O1E2M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dHRLU4na";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vz/O1E2M"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B9D5114007A;
	Fri, 10 Jan 2025 16:32:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 10 Jan 2025 16:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736544766; x=1736631166; bh=YwGBbbv92k
	AfpU3hG7m1S4iCzM3RkUA1kQBgLAd2WyA=; b=dHRLU4naKJu7TMj6BA+Z4via3O
	OOhPcFWgCjXoRjH9uWneoQ2z+xt2EZE2M3oyQDhmB49UIfKfwgQeKwqjP+0hVkF+
	dTmxUwKWbfoFdVqfLZdJlufHw0iDs2lBh/kviGilLv3yYLlafpf/+nak8QoDbCpt
	MjRKeY2pjqYHV8wUot7JfZDxGYeXv0UBcBAdrwIvyN58JPYD87b0/NkXaKJiAWvU
	+GrRqTG7w0YKbWQniG02xJLuTRMY12aLSVCBU7H90SgARScnz4Fdy+gWrr9fpMst
	LmvsN2a3FVKZItsda/ODnW9iU62/LKpDNQDwu2tI0EpJw5s0XAIQCrxp8teg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736544766; x=1736631166; bh=YwGBbbv92kAfpU3hG7m1S4iCzM3RkUA1kQB
	gLAd2WyA=; b=Vz/O1E2MZ/q8PUqn9cQcX1Y2AGDWQdy9FdeqA6GTKFBxSb51FMW
	wLlmM9BMDnkWa+gZI63khObZ3blKC+7zvDjmDrxnbXgYx9JIX2baG98iD1OhReoN
	TpKQSbiHgaeqEEbtIDGBRpY6bmIIGkZkuWU3nnDvWoZc56lAgED42l7FM1ftD9uJ
	18MgYVJTJ3Zo1+j5bzv17pEaUek4tteuq7Iia6oz3nHIg3/PyrEkwtZBTtv8ENnT
	iYyPmPatRJy9SwIghj/6ZlpM47Pi2ws9DSgLdMBCHf/LVGpoFvNr12VqAyaXb8mS
	sDel9ZVog6Ca+VwVmIMdwDLeNbeuyXb/8yw==
X-ME-Sender: <xms:_ZGBZ9xaeqJAZCaupM5k5J1TSOydzx1SAb2xLddGpnzDbgvjdEdodQ>
    <xme:_ZGBZ9RzgO438E641wTqOJst-GfZzn7hsZ89IofFH0ft2urT8uUzl5ec3Q-2Blmcu
    jRPXoAbYxRX-ONuOA>
X-ME-Received: <xmr:_ZGBZ3UhkosDW5I7iExoGWTIimm1KVEcwkkyUX07OR5jwCuko_UJI6ErP86KOT_iILwxPRAME5HSk-Wa02_1XfJMGpWD3ls_Na4O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefgveehueefkedvgfegtdethfelheekfffh
    kedttdeugfehveefudefgfdvgfdvueenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    hsthgrtghkohhvvghrfhhlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdr
    hhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghrrhhitghkshhtohhlvggvsehgihht
    hhhusgdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_ZGBZ_jIBkqO6TNaRAY-SKaKGGgLVjt8EZkufWKtCMxYeJ64s3wQKA>
    <xmx:_ZGBZ_AlVi54T3T4u7mxjWORGiGNVtUNqtnEgKxFesNihUAA06bA1Q>
    <xmx:_ZGBZ4Jj6rqDOFDka3VbKM8eayDGo-w0wBvULahN7cTlCz45aqJqCw>
    <xmx:_ZGBZ-C7qBVzQuDg8BI-bw-faadBvoCpbs6x2Cnp37C9C8CHPI5gyQ>
    <xmx:_pGBZ65obd7wXxyGhYBzetmFNKsFyovx1iHGIv6LmR9CEfGCxsvKmDmD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 16:32:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org,  derrickstolee@github.com,  stolee@gmail.com
Subject: Re: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
In-Reply-To: <20250110210500.675629-1-mirth.hickford@gmail.com> (M. Hickford's
	message of "Fri, 10 Jan 2025 21:05:00 +0000")
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
Date: Fri, 10 Jan 2025 13:32:44 -0800
Message-ID: <xmqqh6665p8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

> It would be neat to warn similarly if the user includes a personal access token in the *user* field of the remote URL:
>
>     git clone https://<pat>@github.com/...
>
> This is a popular practice according to StackOverflow
> https://stackoverflow.com/a/70320541/284795 (800k views).
>
> GitHub personal access tokens are easily recognised by their
> prefixes "ghp_" and "github_pat_"

Curious.  I do not think we have *any* code to special case such a
"token", so to Git itself, https://<pat>@github.com/... should look
as it (assuming <pat> does not have any colon in it) is trying to
access the site with <pat> as the username.

How do we _know_ that this request with <pat> do not need a
password?  I ask because I'd prefer not to see us hardcoding any
hosting-site specific heuristics in the code, and these users
apparently are doing fine without any such hardcoding.  If we can
reuse the mechanism that is letting them do so when deciding if we
should warn, it would be great.

Are users expected to configure their credential helpers know that
it is a <pat> (perhaps with authtype=Bearer)?

Sorry for not giving any answer and piling more questions on top.
