Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEC1F584C
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182810; cv=none; b=E+lj/GXyhcpc+6FMIcC6nphL/OgHf+USLuCTWgSBKKa2pGi68MxsiE1VnNOiqjvxyq2IYpF63RwHuz/yN5ctizimDTxGc9DDPyk8cd0Ue8DWbOQVpCT7UIgGYyXlIZ89gTMaIbaERF+WwwAPaj3iYYxQokIxo0ww9BX0Toxqotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182810; c=relaxed/simple;
	bh=N7pETZeG59S9lij6o7qWoA+ebU0U9WEH2TvF99DzWpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=acbLsIVjUAeV1v6plQ3Iv4x18518yphjC9hDlH3ZXZcKVUQXjFxCnWoLcaO2+82362tRZ+yluE1yNsu8J6ZqKECOqWKiwVe/9xx9UxjDdB0f0VKMIcRiN/jgO51vmk2MY1NLy8i2OPOafSraD7Nd2Nf2dMT8849m1zt7brnpjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ll4NEcG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M5aGY6ka; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ll4NEcG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M5aGY6ka"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A532EC00D7;
	Thu, 14 Aug 2025 10:46:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 14 Aug 2025 10:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755182806; x=1755269206; bh=uCVxOYnzvt
	miFuczOnkIsC+CGOp5j4ZGmw0tPpNuxpY=; b=Ll4NEcG3XOB7GQz6SrSMHG2XHv
	MFRd2b/goHDPY2xkNwyYTxcdW1Jiero0jPKeNTMOoMP2tXIBVoWJ6nRcMGdY4An/
	OJ1iMOeJB4XlrZG19IRi4r65qtVfbFn1qS2oANsd0yKZniBnslyPVjTmg4NCeGdL
	gjsrLCS9g03aW5/BoVTyOy3/ES824jd9IiL9WJ9IgDf5sKmaqGZI+K9H4b0aPaSw
	krcwjNB+eVzYgyUn3cEgs4Acc2RtbFaSbxYbu4vJcXD3rkMG/IFkfON2WnCCHCT+
	Qnm0Rt6mbKeIf+iJGxE6O8Aq/QPMBNAvSGS8KwIYzJIy6VOZskUbSWQsdEpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755182806; x=1755269206; bh=uCVxOYnzvtmiFuczOnkIsC+CGOp5j4ZGmw0
	tPpNuxpY=; b=M5aGY6kaarG4m7aRYQpkUjw2g42RsOkJalZuRNTIlsf39slqB5R
	iYW/bE6XFnBYDf27ER8Z66iN2JfLEdI1hHTAdkI9FukoIkzmCU+2nfirubd2VqhG
	ghKs7sB3ccbBgGcnDVfg0ocxDyCZCOXr0WfERkQtYncSFS92/7/o119FuTxdGruA
	sJS8OBr0Bng1dc2zVKcNNuBiUaj1QGjB9VQ4z64boIjsEz8StBMtyWYsPqE7BIJE
	TnjgmfPysbMlPW6IJoSZgpimVTZwFYMjTfYpxcKIgq0jnVNUi9cLzcKVHpISz2WD
	5vATWIYymtASJvPV+f7O7drq6WPjIsoPjdA==
X-ME-Sender: <xms:1fadaJ2MbIswn_959xKpt_u6uQHuwD1Q2olthtazuUMsHymypsp-Xg>
    <xme:1fadaLl_W02HVxxm1WNBB11r50Yjc0MZKaOvpsrSEXrTzt5IMab8PSvBz5PUmXYxM
    bT_vJXj8_E-g3YyrQ>
X-ME-Received: <xmr:1fadaAXC4tZ7wsfFqkybwunNNvSRmYvD8s3IyALfZCDiz0sBwFguGbM1G4igboW8GyeP92i5qRBWDNYIUsY8D5xwaFuVM87atpg8oVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegurghnihgvlhgvshgrshhsohhlihesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1fadaBvXjqBQ7FvrzF1w5f7vWSznEzY2It_uOik0lcBe6GX1bYU13w>
    <xmx:1fadaDYy9Gzehjgk7AlNv4XCiRUHNw8-HFdc-1MXB7qPR1k23uONZA>
    <xmx:1fadaAUtFz0uE1on0cnOOh24qgdIJDPsT2ybOgFfCj8j90UtHe9-iA>
    <xmx:1fadaITqXaOnHKAFBM4InNcKdJnUEOxZLtmlHi1aOf9kJelf05InMQ>
    <xmx:1vadaFHoK6jFpsGRBjU6c_4T3DYWEysubHHvK-8Glqg4LOJsYa15UgDC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 10:46:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Daniele
 Sassoli" <danielesassoli@gmail.com>
Subject: Re: [PATCH] Document count-objects pack
In-Reply-To: <8147cec2-f898-40d7-ac3b-763920eb7947@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 14 Aug 2025 09:30:51 +0200")
References: <pull.2031.git.git.1755078045397.gitgitgadget@gmail.com>
	<8147cec2-f898-40d7-ac3b-763920eb7947@app.fastmail.com>
Date: Thu, 14 Aug 2025 07:46:44 -0700
Message-ID: <xmqqwm766jvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Aug 13, 2025, at 11:40, Daniele Sassoli via GitGitGadget wrote:
>> From: Daniele Sassoli <danielesassoli@gmail.com>
>>
>> Juno added the printing of "packs" with ae72f685418b.
>> When 0bdaa1216 refactored the docs for the -v option, this was missed.
>
> s/Juno/Junio/
>
> But commits are usually just listed as-is without mentioning authors or
> other metadata.  Something like this:[1]
>
>     ae72f685418 (count-objects -v: show number of packs as well.,
>     2006-12-27) added `packs` to the output of `-v`.  0bdaa12169b
>     (git-count-objects.txt: describe each line in -v output, 2013-02-08)
>     forgot to include `packs`.
>
> The text above is a bit more terse around the commit references since
> the subject line for the second commit says what the intent was.
>
> Alternatively, just referencing the second commit:
>
>     0bdaa12169b (git-count-objects.txt: describe each line in -v output,
>     2013-02-08) forgot to include `packs`.

Thanks.
