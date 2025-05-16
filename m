Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3C323D
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411872; cv=none; b=Ez33Asdh8WKr//hKmhGs4SckdnINBFRarAYMGwM29md+r4gmMng3XJe5HHy26yYPozu2GVZVw3WC5VZSyEPt/MnFGKlZatjPFfr4x9WwoZOUtlGcuAZ/cTmPUvymeoyX0AWyutYA7NnANNIJzTDYDuOkQZWjXmvP7tSvMNd3P+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411872; c=relaxed/simple;
	bh=q4cvj33y9iosocuReRDKHjSBiiZLuJaw0i6idEi8AWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LRbjHDBjJhV2oQxPv71Ir+3ACSyPSXJRf3+WBH/E2iyU3N/XLsxBZQxFxSF9kjVZoAKildC1KfL1zvdfnHrTVaSS/1hqyOKfnkvACbluyEkmNp1NRnc4yZ8wd0Y1pyrG7iBP3wBN0iIB30jhcCqftsqrBnoU/jRNZVPT29rNpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bB90JQSq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVqqgxP2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bB90JQSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVqqgxP2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C23241380186;
	Fri, 16 May 2025 12:11:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 16 May 2025 12:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747411868;
	 x=1747498268; bh=8JFu3BcZevabJ7M28c+KYIjVewZ8cBaJiMdctihry34=; b=
	bB90JQSq4DQb+SZXboIAYyPpy5jfNRteCXlC8M1a7Jk4Psoyz6jpA8PpTU3zVnGY
	bojfjmmxztLnuGZJaveEiAYH7yIfKpVx4Zm6k4UtNKydteBizAQaZm8uSZzjxji7
	pDf3UeImTYR2RurF07Usv1KskbildZt+YGB32oWrRT3NkB90286BylZqC+hvvIlk
	hxj01dfnK7CqYKDZ7t4e5svIT7AC8DtC6ebW2qPeJzQvZQ19mAZ8BA+eIxJ05Wkk
	D1YhnKsMQ0OwUKSgIS3sjB8wjErbBJawWS46z9PMMl6VH5sJPAHd+zrQ3bYV1c7U
	2t6b6PVzk/PTVUttTkb2Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747411868; x=
	1747498268; bh=8JFu3BcZevabJ7M28c+KYIjVewZ8cBaJiMdctihry34=; b=a
	VqqgxP2+TE5gsZ+bSuS/HQObTogddKkTjXesjQQfYctpKn3DaiB5fUIRbjob+wrp
	fac5oDMLhTcMqjBUdu7YXeD+ojOkQKr+9Fvf36OqWQCm6tTeVlqowLQAFOfWm932
	HycoRAZF1cDcHeeo84qdbb354mssVsXzwODpYdd0SsgQ1rJ7QBomfsTR9V6LcEn/
	gmP1aby64MeMstthbDDeoD+loxX+CvpUqYSc4Vt8K0MpF/kar5QnkqqNaM1PpCd+
	AbQsg6pCttO45V4WD0PrK3DCv01iNfwDtE0VHeNVOw8oDUK2b908jPBU76gWA0iv
	ofszw2ULowHcg34/yWtqg==
X-ME-Sender: <xms:m2MnaLmdWDwpmf64bdGmkwXvPZksyP132QvjGWkf89dlXUv_lDr1BA>
    <xme:m2MnaO158Wsg0U7Q8TCnBDOQPoo0z0CQxjgMf2HgEtyvQHUqSq5YTWpTjvX_rzf2x
    3RMimt1bD2v6JLDqw>
X-ME-Received: <xmr:m2MnaBowOM2-cVOx-gpdeT4LG87nJeqcwYnGZ51ywbZ5iv2E-zd4q7XU8ky56FgyNEqp9jzVjNY0YbQQWUZNhF9-nMqTjZvmJxOSexM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvjeehudehgeelheefieevtdeg
    leefvdfftdevtdduffeikeeiieejvdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddt
    heesghhmrghilhdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlvghvrhgrihhphhhilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:nGMnaDlD_wQuPIzlSNZIbadYcNsR3xWRXeRVJJXUA1XVXTIth74DBA>
    <xmx:nGMnaJ2Z5BmHYbdtG7rc4dHeEODJQ4DxDELCEBkbKGdb4_ZI4GnbJw>
    <xmx:nGMnaCsS-6uYBCDtJ1PAF4_AV2cZMtw9v3G3Cok7yLMXB_phcXs_-g>
    <xmx:nGMnaNXvekhm_kjv7kDPGkytQ0wdg_cFTyijCe6P21VS0Oiz7uc65A>
    <xmx:nGMnaEA5mTZfam8YywVOUTwsmaQZaTs1ZXOhhC9ZWpZ-UR8ozC94SFi0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:11:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: Emily Shaffer <nasamuffin@google.com>,
    git@vger.kernel.org,
    levraiphilippeblain@gmail.com,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
In-Reply-To: <CA+rGoLf7jf5r3C2mN7X84HNrWqsA9mMueEkCowm7Ftsgcd5EbQ@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Fri, 16 May 2025 13:50:05 +0530")
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqr01si441.fsf@gitster.g>
	<CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
	<xmqqtt5ncq87.fsf@gitster.g>
	<CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
	<CAJoAoZnYOjqgeW8Stuj5T9qcxmUBE=_j_ufO8Hdbn3GV8LmMzA@mail.gmail.com>
	<CA+rGoLf7jf5r3C2mN7X84HNrWqsA9mMueEkCowm7Ftsgcd5EbQ@mail.gmail.com>
Date: Fri, 16 May 2025 09:11:06 -0700
Message-ID: <xmqqmsbcwn6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> On Fri, May 16, 2025 at 4:09 AM Emily Shaffer <nasamuffin@google.com> wrote:
>
>> Mostly I lurk these days :) I do still keep an eye on the list. Will
>> happily take a look at your series tomorrow, I'm out of time for
>> today. But per what I mention below, if you don't hear from me, please
>> don't feel blocked by the review, as I think the MyFirstContribution
>> doc is comfortably maintained by the whole project by now.
>>
>
> Understood!! thanks for letting me know
>
>> > So for now I will cc Philippe
>>
>> For what it's worth, I don't think it is harmful to CC people even if
>> they will be inactive. CCing someone is not necessarily the same thing
>> as saying that person needs to approve your code change, right? So I
>> don't see the harm in CCing with low expectations - in fact, in my
>> case it would help make the email stand out, so you'd be more likely
>> to get a review from me (I missed this thread going by initially).
>>
>>
>
> Oh, ok I will keep that in mind next time.
>
>>  - Emily
>
> Thank you,

Thanks for a pleasant conversation; others can also learn from this
exchange, hopefully.  In Documentation/SubmittingPatches we have
"Choosing your reviewers" section lacks anything more concrete than
"who are involved in the area you are touching", and those who use
common sense may say, just like you did, "ah, most of the text I am
replacing was written N years ago by person X, whom I no longer see
on the list very often" and decide to omit it.  Perhaps we would
want to enhance the text there somewhat?  I dunno.

Since there were discussions on contrib/contacts recently (a few of
the participants there added to CC), I tried it and unfortunately I
was not very impressed by its output [*].

After applying the four patches on top of 'master', you'd run the
tool like so:

    $ contrib/contacts/git-contacts master..
    Jonathan Nieder <jrnieder@gmail.com>
    Jacob Stopak <jacob@initialcommit.io>
    Jeff King <peff@peff.net>
    Jean-Noël Avila <jn.avila@free.fr>
    Emily Shaffer <nasamuffin@google.com>
    Atharva Raykar <raykar.ath@gmail.com>
    Junio C Hamano <gitster@pobox.com>
    Todd Zullinger <tmz@pobox.com>
    Kyle Lippincott <spectral@google.com>

The tool gave output in a different order every time it was run.  It
wasn't obvious what the ordering meant.

By looking at its source, I can tell that the names and addresses
are collected from trailers like reported-by, which are counted with
the same importance as the authorship, that the reason why the
output is different each time it is run is due to use of keys %hash
in a Perl script, etc., but counting sign-off would mean that I'd be
summoned for each and every change related in this project, which
would not be very productive use of everybody's time.

And it of course is not clear who are still active in the recent
past and why the name was in the list (it would not be as productive
to ask for a review from somebody who was listed for reporting many
problems in the area affected by the proposed patch than those who
wrote the original) from this output.  There may want an "explain"
mode that lets you feed a patch and get observations like:

    The majority of lines you are touching haven't changed much
    since person X wrote commit W 5 years ago, and the text turned
    into current shape with contributions by person Y and Z.  Here
    are the URLs into the lore archive for the discussion that you
    can see how X, Y, and Z participated in the original before you
    touched.  You may also want to look at commit V and U as well.

    Last time we saw person X, Y, and Z on the list were ..., here
    are the URLs into the lore archive.
    
Perhaps some AI minded folks can write such a service for us ;-)?


[Footnote]

 * I didn't try other alternatives which I didn't have, and the
   other thread there was a mention of "git related" with "seems
   like rather more work".

   cf. https://lore.kernel.org/git/aBr9bwNQ1J46NNXI@pks.im/
