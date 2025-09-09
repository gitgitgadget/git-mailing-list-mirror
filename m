Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22F2D061A
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436252; cv=none; b=S0jT59We9+ChhWS+zYCmJrNYoCHChTUGFfR6ysUKvW8yknOyGjT8nZEXsI5OdBOV22U5QhAHgCjCR+bgyRB5mfEkjuJGqIeZLhhGz8SrP8QTW4yXSPe0O42Fplgh/Gdzj640Wz/LvrVZDiTxgnaYJZmQIt59M1KF4gKTvBWY9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436252; c=relaxed/simple;
	bh=OJqhITLL0JbaedTSxCYRdC3YEe5k3J6WVajhReMm0N4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L7EGmXi/P2JYRodbPgLSsVFeqCoTcSf3NgjH4i45899ESUn88lvIFJg8zJNXRrxySBP5D3WWL1HHeJ7H8tuy/g0frSgJZXj2uq4lkMChym9J4023opMFmQVk8jNzac6mIjPj+WDspC53pUOrMXIk82MwAFszVriJpS1eO9JpPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z7tz/LiN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F5ckZ7DP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z7tz/LiN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5ckZ7DP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F26F57A014B;
	Tue,  9 Sep 2025 12:44:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 12:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757436248; x=1757522648; bh=+FytNV08tQ
	pzEBe0jZ1374ovSwFUEOVlORghD3LOIbY=; b=Z7tz/LiN5rPf+mjazfmke3//Cs
	n6pVsQrrWbN/Nx1EjHpO2z+fm0gMxFyBw8EQnwe4nRGUk2IHKPJXejcwf26RPqVa
	nYF2cH3pxh/SMcNcoD5YF168CfySl8ZgbDzTk/ERyHhJzain+HA1VsNqvDOyy8YJ
	La9VNFdEJZwNwM1nT6JYzfZAYaK2lLPLmUSzjqnuJlkuKWnL197U5HLNyPowxu1f
	3QGbsyJPKHXmjIcAn+IOgBJPpa/4vlGF+KMEHM6l/HTrDp5w2SykdZMrXQdTdCJM
	0MDerxtY5FgGYua/IcmoW9LZ9fakhM53UbBQFxBQgO56NFGQpXOm10njoK1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757436248; x=1757522648; bh=+FytNV08tQpzEBe0jZ1374ovSwFUEOVlORg
	hD3LOIbY=; b=F5ckZ7DPIzpIJebpJEBBoGxA5n7lFQmmOVYU+oDZ57ME7BvmPrH
	b570CswurWcp5NjwltqtS0dxQWo225kNnbOJ9yY4Gj430NjPJ4tuXotJJvm0dJ0q
	vHz3s1ajD9VeogIsfZ82GArK4ngdu523wuCxXSc5tyovA56Kii+wBt7Y5TXDaW1w
	7zoEwCJrcUusaJ9aepXjXPzUPcABedvZ9yX/uE+GvvVH0NlKYDcBTVEpm7L9pdM3
	G4ed0FIuM25ZCg6dlwKxDqMSA/p4OjNc3OVdwdtuO/22ThDvqDCbXCMpwzQ68Q2o
	pEabdjbeSaFp9EvcDrl4E+rsraT1e86Uplw==
X-ME-Sender: <xms:WFnAaL1gkoahPfdI20snTLZXUoZpFUhq5rDbzyu3ZG53Jw7g56FuTg>
    <xme:WFnAaJzA82zeiEnEmzL5_nkxHd1oK5AGODr6hD3angc6leij2SjLPGnRduTg66eBv
    2CjMB75pCyOA1IUtQ>
X-ME-Received: <xmr:WFnAaHiwHZ1JbxYNi4t2P63cyLc17yL0HL72kRexGkn2IS0rgenYDBZzHj7MRcm8WzFs0T8Yej5meGA0Yf_C6uF6jzruYvZESarKK6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:WFnAaMo2HkgSMPqcdq2NDv9x_bb3JSf_vSXS082htQpJkE9ZsElKQA>
    <xmx:WFnAaOiiM39e7kyNILRCu2kA5sW6EGdyx8lZ8imsFPPaObn-MBuISQ>
    <xmx:WFnAaOPnA7sqHO8GCpvDv7pIIkECcJm9ufdli7JmyauC1llY7XJAvA>
    <xmx:WFnAaIwYdX_K_Nkr2x0I6HIyj2KiOjKU_V1pzWtMjVP1b_OTTe4dsg>
    <xmx:WFnAaKm39GzQBIAJujAEmnBf0AIZxHzMUAupLQT2tE_CslljxqOOMkDY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 12:44:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Toon Claes <toon@iotcl.com>,  John Cai
 <johncai86@gmail.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replay: add --update-refs option
In-Reply-To: <CABPp-BHWjyRv_f_HKkz10Q_cOZKPvpgf=SEUR1ThmbttkQT+Uw@mail.gmail.com>
	(Elijah Newren's message of "Tue, 9 Sep 2025 02:19:03 -0700")
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
	<CABPp-BG6A_mwxQheE5ED5HQj7STVtf1_9NhSmjmzRPB7QkdWyg@mail.gmail.com>
	<CAP8UFD3GU5Xwq7WMihmHtpWc-GjB-guTU6JHG7BdkhxukMihNQ@mail.gmail.com>
	<CABPp-BHWjyRv_f_HKkz10Q_cOZKPvpgf=SEUR1ThmbttkQT+Uw@mail.gmail.com>
Date: Tue, 09 Sep 2025 09:44:06 -0700
Message-ID: <xmqq5xdrvand.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> > Seems fair...but why not make --update-refs the default and add an
>> > option for those that just want the update commands?
>>
>> If this patch series had been sent a few months after `git replay` was
>> introduced, I would have been fine with this series making `git
>> replay` update the refs by default while adding an option that only
>> outputs the commands. Unfortunately `git replay` seems to have been
>> introduced in v2.44.0 (Feb 22, 2024), so more than 18 months ago. So
>> even if it is marked as experimental, it's perhaps a bit late to make
>> such a relatively big change in it?
>
> I don't think so; we marked it as experimental much more prominently
> than other commands -- in the .c file, and three separate places in
> the documentation.

When we are talking about a change that breaks an established
end-user expectation, it does not matter much if we wrote anything
in the .c source files.  The end-user facing documentation does.

And as you said, "git replay -h" and "git replay --help" prominently
show that the experimental nature of the command.

If this new behaviour is a clear improvement for majority of use
cases, I am perfectly fine with changing the default behaviour so
that everybody will benefit.  It may still be good to add an option
to allow the users to ask for the traditional "we'll give you a list
of updates you can apply as you see fit, but would not update the
refs ourselves" mode, though.
