Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB71DDA24
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321753; cv=none; b=E5B4pk+55can+l5s1R7EflRGVQknlDza0B6VKN05absdJouLqsIUtTKffH94EuzaMeCE1/+/0cXzG51PWe3SqPjiEmoZliwhRUlWYgj2C7EfcCK95uh/Vya1RTts9/o96sM7HvSzjPYEmShheSPX4vApREX/0+3nBJzQbh3gV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321753; c=relaxed/simple;
	bh=OiZKZXLCP3kFe64UdSV+9XFevj+cx1uywA1mrPEAyIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tuODvAL4QfGJb11G7AwCk3rJT7mL11724iCeBjHx/SQW7kDDS6UpIa6RMPieccqKdFTs787i2HXvniDrTQclA3zFYu9dp8UBvIrzWA2QPeTN3QgeIuKSbws5IUqFb7/nzy4bKUgUd/3Ximf04VyTVcIxgzPrziHcca4UpsXgLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kiz8T+oV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QRyUCwty; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kiz8T+oV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QRyUCwty"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCAFE7A0069;
	Fri, 24 Oct 2025 12:02:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 12:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761321750; x=1761408150; bh=6UuLAHjOTP
	HJfLolVTNo6RhHFcZ4NCPVN6Peb2zHxbQ=; b=Kiz8T+oVit2ErZyeq9KBkg6qTg
	qfgamOWUOQF4USbcIuW/e3jhyzvJ0sazHbxhyIHZwPZcLLFIxBkDNKe74TsifqiM
	RR7Y/JGagSxTlFZ5xu4kr+aKQ1gh3KyG1Ko+hLGhmt4sp4D58zgyUky8gY4Yn/ZU
	qju3VwfkgR7MEK/0Rwc3wVWypfXsLMdjWDb6K/LTpz0sjWIrYXoILRMK+mp2xd8+
	m1JPlzcnn8UKvCPGrRtv7KmJGbtb+bROngLF6JXl/BRII5LwTgUoxtqnb5SK/4QV
	pKppduPlCGFlUJrPl3fLXY0pHYHJ+nZUZy0XEiZmNJZupDbmCzdX6vCK/a9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761321750; x=1761408150; bh=6UuLAHjOTPHJfLolVTNo6RhHFcZ4NCPVN6P
	eb2zHxbQ=; b=QRyUCwtylqS4jBYuUpKrmMN7mUWBAyIeG2OfOkfTSKeJAW08bP6
	ePCFRELXzOZneOyUNKkm9twmRhxSEa+1+UGmFVC+8hZuo50OX3VzlgjbLY9d4d/v
	afKFXZ56F0WACsvVXrgsWtts5AbNdcA+1d9Cony+mqso/2eHyDLAfGdXLJ7UcoaL
	TJqAFz7N0bZvyHhYeU3v1ERymIaWZIVYFCee4KYEYwH/UBqXGqDepxXGUPFG5jFk
	qxse/TPRFgraU/ExLv66F8pj9I4TT+phTEkHufrnKyrFHeaL96jGnSgp9x1btXfo
	R+6LSueaQ8sofoufAUGLdyaPjZ5B9fsZ7Yg==
X-ME-Sender: <xms:FqP7aO62vGwTEKHQ-8qymSJ9NYJ-VtuF4p6VToVlokj09naIMLZmeg>
    <xme:FqP7aOydSPtB0d3q5NmEY7Gll4An1uHNdtiALYktDrK6q0ZKX2ILGGV0bwb_SxX4Z
    DjbDM2RAWX8J8pjCbvaNIY0Tzqdk6SdgLde49N82gkiuwweK3NObQ>
X-ME-Received: <xmr:FqP7aFzYbxy_jZ2Y9Zyw_lZIpSKX7RthX3SGC5dJzMKNj0Mdts5xa_DTtP2wTE68ON_keRo8iDMJxteNXwB3Sg0wW6ffOn8ZinuR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeljeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhjvghsshgrieeivdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmh
    grnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FqP7aGzxclrbMXhe27VnAEfgkcCrxLiyREcxZpzkcnvHzNUicucCvg>
    <xmx:FqP7aPaPfTROcPyxe6n3N87_lfhCULYd-2hpoDKEaYi5y5UTHBP5jA>
    <xmx:FqP7aHWpkTcjBA-2bnTNIetqEu-KzYI8l-LkKnJRwenbi03zlSA9_Q>
    <xmx:FqP7aNiMWYtfRKT8tbpTxu5eAnekyOl0hVSINRSpkj_iCZkYkni9LA>
    <xmx:FqP7aKDSOFueY03GO0qC_sU01gcriTNkx_q-lpTirAmnbyP9YIf72GWB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 12:02:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: QueenJcloud <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [PATCH] MyFirstContribution: add tip for confirming patches
 reached the mailing list
In-Reply-To: <20251024151532.1968-1-qjessa662@gmail.com> (QueenJcloud's
	message of "Fri, 24 Oct 2025 16:15:32 +0100")
References: <20251024151532.1968-1-qjessa662@gmail.com>
Date: Fri, 24 Oct 2025 09:02:28 -0700
Message-ID: <xmqqwm4kp9t7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

QueenJcloud <qjessa662@gmail.com> writes:

> After explaining how to send patches using `git send-email`, add a helpful tip
> for contributors on how to confirm that their patches were successfully sent
> and appeared on the mailing list. This provides reassurance for newcomers and
> helps them verify their submission.

This is a bit wider than desirable; it will bust 80-column limit
when quoted twice in a discussion thread.

> Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 7 +++++++
>  1 file changed, 7 insertions(+)

We want to see that author identity and the identity on Sign-off
match.  I can tweak the author identity on our end for this patch,
but if you are going to send further patches please make sure that
your [user] name = "..." configuration is what you wrote on the
Sign-off line.

> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 02ba8ba5f6..94acdaeddd 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1158,6 +1158,13 @@ prompt for each patch that's about to go out. This gives you one last chance to
>  edit or quit sending something (but again, don't edit code this way). Once you
>  press `y` or `a` at these prompts your emails will be sent! Congratulations!
>  
> +[TIP]
> +====
> +After sending your patches, you can confirm that they reached the mailing list
> +by visiting https://lore.kernel.org/git/. Use the search bar to find your name
> +or the subject of your patch. If it appears, your email was successfully delivered.
> +====|
> +

Use of [TIP] is new (we seem to use only [NOTE] adminition blocks in
the existing text).  After reading the part before this hunk, the
structure of the section is

    (title -- sending email)

    It's time to mail it out, with this command

    $ git send-email ...

    [note] ...
    [note] ...
    [note] ...

    After you run the command above, you will be presented with a prompt...

And you are adding a [tip] _after_ that, but the existing notes are
also about tips to use "git send-email" correctly.  It is not like
existing explanation "After you run ..." is exactly correct.  When
you get prompted, the command hasn't finished running.  It merely is
"after you type the command and hit return".

I am tempted to move that "After you run..." sentence up and above
these three [note] admonition blocks (and rephrase it a bit, perhaps
with "After" -> "When").  Then add this new piece as the fourth [note].

What's the vertical bar "|" after the closing example block
delimiter (i.e. the second "====")?  I'll drop it as otherwise
Asciidoctor complains

  asciidoctor: WARNING: MyFirstContribution.adoc: line 1162: unterminated admonition block

and makes the rest of the document part of this [TIP].

Thanks.
