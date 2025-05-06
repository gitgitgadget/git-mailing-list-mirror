Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84D283C97
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549457; cv=none; b=NqtELN/tiBw44lD6oGAlWE1GRAOMrbNepi1bJkjYCywXjkIdsOCoF7T17s1HS1IEzb6JjaflpkCGtUfPhLzfIBAR/iyTBd4gQ00fUyKq9Hu0R+Q/lCm/sbTQ3QfopYBcTxvl79z72nSQ4/IjmIKkdKludUqDrOK3lL6ugFevLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549457; c=relaxed/simple;
	bh=43J5ZCEdhipsNJ3lhClRx7OuoFdOWEP7BEbd5bLfhsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPdaXCw3kSAmEdIsujOpgfNLlYFsPNRUcsg/a8Y89V2TJxGL9ghrdM1NZvYMpKGjgdCFG5w6bwkEiCxL7FBbIr9C5mfcrvFPfHRGniqW1io+z+u2Wv/1D55UWD+RLd9O4CiX6wS5JzSAk+8c0jWE0iaukwvrDRnDSLmLX3piYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GxMzxocT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDu7nFM/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GxMzxocT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDu7nFM/"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46D37114030B;
	Tue,  6 May 2025 12:37:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 12:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746549453;
	 x=1746635853; bh=+FIc2llEjmwNVw71Q6TGV2gIb99wYdjsEOa/ErhDZTU=; b=
	GxMzxocTZpvZ6Ln9jmIKrJhaexK3wgxoV1h3zUJhJmdMncwhvcEjatsPwSMYfTyD
	Zlqjlskfaq+cEkGMibtO9F6gmFuYKdGBl6v+MgR9iUQ+QADb6r493NIAsRplJHJv
	OQn2GErDFD/Yze5jeBlk1S64V0hw14w90/uZaaNtXj98jE50g2Ryl4+T9zMynNMO
	4zdRSo4+tXyLGC6Za6m7GDsVW04v/upEyLqAglgFc0bFozVvMbRRSWXAKFLVV6BY
	5O3QrQ5RV5G5/ttg+H3JTwyI3FmeWLi/tVs8Gm9oApYgseIW/e8cNLoqLHDukRpN
	OdR8ZJm3ZcB74pdtqkT86g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746549453; x=
	1746635853; bh=+FIc2llEjmwNVw71Q6TGV2gIb99wYdjsEOa/ErhDZTU=; b=g
	Du7nFM/o1nb3YOE39CN+QZW4El5x5CAA7fe87qpOKHEqWg3Vcd+0K2bjCXarNCmk
	RVpis4GpZXHjq0oBnf+tuny3GvwduhpmzDZk/RkxrhbXKxc/a8GiwrIIqvzmgOjT
	BdytdtO2vY1jSuwNe4/ITLyqT9v8AeThnhOLvn1f0G/QOITFRfzubz/dQaIMOk7a
	7JsskoavByQtzwW0XdcwdJGA4KMtRrOsTvuctBytNiK3rlSQrCalOULz4lr5T0kD
	g1Oaa+8XOT4yp4Ckzg+B15HEp/4YGnqHfBKfO43AZQ4TOLNWs4uPOOQIXwcHyV4S
	ikk3VMwMwzZbMhevERRaw==
X-ME-Sender: <xms:zToaaPwjNabNouDCphp0CXdLAtFa0p5fjPCbAJGmfy4rzkz3j7Fnjw>
    <xme:zToaaHTWOn-gCPx9uldFVxlOSmujDHcagXVBPquWFJhuk86rLf1dnAbKesFiDziv2
    JKSxld4Ar0SE3nzRA>
X-ME-Received: <xmr:zToaaJXfCUsZx6iRo3QUF-T12A-aMcNZYbWpkcf_9ZDSC7SH9kqOvYMCzTjU9QthF3vyeNPjS-KoNmx1RMzi9Qh0Azuj-j4qWh7Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeggeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zToaaJh8U2r0XxSM9jG8b13GCRSp1sG1OyG9qF8CO3ljESCuMi2LGA>
    <xmx:zToaaBBh4C94sUaWcKbU87okiuBxRS48TZMbQi7CbnJST09BEmt9sg>
    <xmx:zToaaCJQZNXQifWlwrjURawfmK562kYU6DIsfZ9y-NqcBdNL-Jr1bg>
    <xmx:zToaaAA8qskWpbD6LZNIYyAT34WkDMEjeF82jteFwMtIMP0Y6ma1yA>
    <xmx:zToaaKInZtafAM4N5dYDaShMaT13wAsSRVgxeNPYwuqw3CDfZ2LyZM6g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 12:37:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
In-Reply-To: <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 5 May 2025 20:02:09 -0400")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
	<CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
Date: Tue, 06 May 2025 09:37:31 -0700
Message-ID: <xmqqldr9lmpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 5, 2025 at 5:19 AM Leon Michalak via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> This teaches `add/commit --interactive` a new "context" subcommand, which
>> changes the amount of context lines subsequent subcommands like "patch"
>> or "diff" generate in their diffs.
>>
>> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
>> ---
>> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
>> @@ -265,14 +265,15 @@ and type return, like this:
>>  ------------
>>      *** Commands ***
>>        1: status       2: update       3: revert       4: add untracked
>> -      5: patch        6: diff         7: quit         8: help
>> +      5: patch        6: diff         7: context      8: quit
>> +      9: help
>>      What now> 1
>
> I'm not a `git add/commit --interactive' user, but I can imagine that
> inserting "context" at 7 and bumping "quit" and "help" to 8 and 9,
> respectively, is going to play havoc with muscle memory people have
> built up over the years. To make this more friendly for existing
> users, I'd suggest adding this new command at the end of the list
> without changing the existing command numbers.

Hmph, in the real UI, the first letters of these commands (which
have deliberately been chosen to be unique) are shown in different
color to hint that the answer to the prompt can be like 's' (for
status).  I would hate to see that quit/help, which are somewhat
special, move from the very end position.

Perhaps the example of the documentation page shown above should
respond with 's', not '1' to show more prominently that it is
possible and encouraged?  I dunno.

> Also, looking at this list, I can't help but think that "context"
> feels out of place among the other action-oriented commands. Moreover,
> if --interactive mode grows more configuration/setting-like commands
> in the future, do we really want to keep extending this menu for them?

That is a valid concern.

> Specifically, I'm wondering if it would instead make sense to
> introduce a new item "9: settings" which takes the user to a
> "Settings" submenu from which the number of context lines can be set.

's' is taken for 'status', so it shouldn't be '9: settings' (it
should come before 'quit' instead), but I think I know where you are
going.

An alternative that may work better is to allow subcommand specific
parameters in the answer to the "What now>" prompt, e.g.

	What now> r -U7

to choose an equivalent to "git revert -p -U7".

Thanks.
