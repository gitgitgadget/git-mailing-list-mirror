Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B9730BB94
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714760; cv=none; b=snU9tXQEiP4DJuE+r3zSqC/i2r7N66R8F0moq9t5Z6Pkmh4aniwhFuhTRGqUd7re34h/oo8tlq5QHYWdRQG7NwYk3mD5UPII2cdg8CaF0IHDuVxq72CRn1NKWndansl6+Eo43pqokzFvQWZpDYK69i/D1zUPHA+0KtgdASl8KSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714760; c=relaxed/simple;
	bh=PcLsNwioDrtaPeUnrvvJ2Rf1ThawJ8fiP4y4H6zvdZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+qtjVbo7+Y08bnUKlDTKCv5OPRfvPxZN8xxC0oXxvKf9WKedep9SwMvtBTeSxWUMTCxKNcJkvF5rfuw92i1WrpTQ1Dp/oz/0RjHXm6yoHaVy9kISXyXnn2FclESsJThBo17wz4DHqvjhbxkStpy1NMZ98evgks9MpBIxF/NpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VA3E+G2x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uDBDFfZv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VA3E+G2x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uDBDFfZv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AB3914000EE;
	Sun,  6 Sep 2026 13:12:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 06 Sep 2026 13:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788714757;
	 x=1788801157; bh=PqaunqT44y21m9qgH9Gggb58DfhEyiBSqMF1gbJwLPg=; b=
	VA3E+G2xrDsxxaY1jimHJ9EdFCc/qWdLV/mGDNojrB394O5/O59kS52WzpmG+tp7
	UVaFwEe72TmsVRzIQ+JpInafCn5KY+D/Dk/Uj6sCNRUEssF76kzJJhlmhHAkuwNv
	AXpQgIkzKL8da+oROH9Tw0uCZZ8RV9l1EJ0RiaFF0LG+DKtA8HSFcWrpb6bj01wT
	S+7ppfx5D7Je/VnTQSZZzr4DVjyPcnjli0NGlZ4cyG9E77CB142D2nZaO6uMGuQj
	8MtvIE/XNR79AxILVQtGeXv9rnH3xZrEvWx85PW549mGnydZ5PIg1tRWADteLTi7
	sV0N2deUnnmPY17xia6nzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788714757; x=
	1788801157; bh=PqaunqT44y21m9qgH9Gggb58DfhEyiBSqMF1gbJwLPg=; b=u
	DBDFfZvZAo9AXbI0lNRT3oRF1jgDfoo4WUQNUfZVyEvy83/6sNz7s9nCsECPGwjN
	fkt3jA5PA4gv3xauxYs6acRUQgyhvtckhDPuvcetWKZ0ApcfozhSl0UKsL1Dea13
	fXexs1qVQOSf75pbIa16j+3SubrEZPsFXzb63g1b46LSO8oUKgIx2HkKP5nchOW9
	REJuMm8PpVdSlSY5oJbMT3T020NU6fNtyAozhHX3kqQn1z2LuKZtiedwYIM2F+Fj
	LQqUtijWqPulwvRadekHRcBbwM1BJmuXguyOGTdWS78oB+uIZpwuVGFQTaQIg8Sr
	Bh+lEGLA9lIDgIlGqlHhg==
X-ME-Sender: <xms:BZ-dajYGMaA0j4UbVr3SeAw_8GirIVGQNJ9wwEMZwwJgGv2hB0N7CA>
    <xme:BZ-dap0gDoDJIUJ79Riy3x0z6_ArnF__G4_P97IR27DQPdOrR0ArKt5pWKNfweFEL
    PaQfmbm7gQSkvT2Wd-CqOkdCdMm8dcQJknh3CMGStjMZZ-PBzLR>
X-ME-Received: <xmr:BZ-dajX5iqI3A1JsyflfLTSWvFUA5C-jMc9MZcmy5RnEZsR7B08gg529O0pdrhNB2xX8OiBvIdfhKladUkHqrCzyG6aAoF3aa6gC>
X-ME-Proxy-Cause: dmFkZTFW2hMTZuNs7hp2YY6o1jK+b684GMbikvcm8/fNLsuCqcUNgS7qpWMwcxbJ22nqhy
    xbo0VXfubidNTyVrZRFLfm4OtC1iaO6VvI7ImbkntSinPXqoGB/1xb1Bwf+z0BbpBeE5z9
    sWjs+FeogyKBCnEwyIqR8ENnXA0bBPRzN/ZaTcj3oZEhTg6PPjITFyVagrxmiXE+UA2cVB
    mQqCiEWbQffvefZdMGUMK4O3/tg0Twwy/z8MV0Ln3PCOxqzo46OVXXsEA28ACooKO1ZVk+
    sBW6gY/YcOcJExQuPcVb2WT2965n747HPdeYfG+Ueh1QAYpimjmwCnhDmcK7zgsYvdJIZB
    pCTxySxs8m8hmXScAhrTeO1Q5dcClb0qw/9o4jsIjboX1ICZ95LpzNcmh00HchGveWDQiy
    9Gra3AxlQke0F5KQuYMQ+gCNoA5QNihxozp1yqGkmS3GzaNiBhdH8DITo5ae8NmWgI/u/d
    6pCnrUZKb4tXXp9ccxxPVaegcfxOOJ/mmu2h69ZflDM6PHq4dv7OQx8+jC+5BQr9WbtJw7
    iEp7JlmUgMw2Q1nAbdEXewHRpMgDTGU1JNNwP1EJeAZUZWD95sZMmpgmhjPppafeftSpDR
    67cizZeWYHdyj8ceHP2VC6P7BFK/aXVRbibLt/FZNM2qoBIp0wuXjwpQtbVg
X-ME-Proxy: <xmx:BZ-dajU9uKw1k1FYv1K1nrv7tt2jCw837TEspUUNsNySPpWp_GUfXg>
    <xmx:BZ-daicprd5BNw8x7n1NjdbSgbOLEW41Wwmh23SlfGZ_O3PpflCtMQ>
    <xmx:BZ-dasUQOS_4Zep5kXsqZVcWk1-AaA0B-5_Nplwac_tS4umFTbpTrA>
    <xmx:BZ-darcrzBkLOU2DhriTKrFJWF08XL4J1u5mDLHHFsvvExHFnHqNQA>
    <xmx:BZ-dah8hP1m23eutSgVkf3lO14jdJjf8PnijkscNt0S_6bBjc-X6USSK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Sep 2026 13:12:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 06 Sep 2026 09:22:27 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
	<xmqqjypfp2vl.fsf@gitster.g>
	<16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
	<xmqqbjan6q7l.fsf@gitster.g>
	<9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
	<xmqqpkz24193.fsf@gitster.g>
	<b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com>
	<e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
Date: Sun, 06 Sep 2026 10:12:35 -0700
Message-ID: <xmqqcxuq483g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Seeing as how the doc was unclear and did not spell out how you can
> build two separate list of notes, here’s a draft of a rewrite:
>
>     `--range-diff-notes[=<ref>]`::
>     `--no-range-diff-notes`::
>             Used with `--range-diff`, tweak what notes to display in the
>             range diff.
>     +
>     The default behavior is to display the same notes in the range diff as
>     on the patches; see `--notes`. But you can use these options to use a
>     different list of notes. For example, say you have given three notes
>     refs to `--notes`. At this point those same three notes will be
>     displayed in the range diff. But then you pass
>     `--range-diff-notes=<ref>`. Now the range diff will only display
>     _<ref>_. You can of course pass more refs to this option, just like
>     `--notes`. And you can also turn off all notes with
>     `--no-range-diff-notes`.

Up to this point it is quite clear how the two interact.  Even
though it does not appear in the above paragraph, the rules
essentially are "Without --range-diff-notes, the refs that are
specified by --notes are used for both purposes" and "When you use
--range-diff-notes, --notes and --range-diff-notes give independent
sets of notes, the former is shown only in the output, the latter is
used only for comparison".

But the following paragraph, while it may be correctly describing
what the code does, does not tell me why you would even want to do
so.  

For example, if you have --notes=foo --notes=bar always given in an
alias, i.e.

    [alias] fmt = format-patch --notes=foo --notes=bar

but in one invocation you would want to use different set of notes
only for comparison, you would

    git fmt --range-diff-notes=

if you do not want any notes participate in the comparison, or

    git fmt --range-diff-notes=bar

you want only 'bar' to be used in the comparison.

If you had --range-diff-notes=foo in a similar way in an alias,

    [alias] fmtr = format-patch --range-diff-notes=foo --notes=bar

you may need a way to tell that 'foo' no longer participates in the
comparison with

    git fmtr --no-range-diff-notes

If the rule is that once you say --no-range-diff-notes the internal
state is reset and the command behaves as if no --range-diff-notes
option is ever given [*], then that would still leave --notes=bar so
the command would beave as if

    git format-patch --notes=bar

were given, which means bar will now affect both, so if you want
'bar' not to be used for comparison, you would need some way to
pretend as if you said

    git format-patch --range-diff-notes= --notes=bar

and ...

>     +
>     You may want to turn off this notes override behavior after it has been
>     activated. Use this sequence to do that:
>     +
>     ----
>     --no-range-diff-notes --range-diff-notes
>     ----
>     +
>     Now the range diff is back to displaying the same notes as the
>     patches. Going back to the three `--notes` example: now the range diff
>     will show all three notes again.

... may be a way to do so, perhaps?

BUT I think that is a strange interpretation and notation.  Normal
people would rather assume, once you said --no-range-diff-notes, you
do not want any notes to be used for range-diff comparison.  IOW, I
find the earlier rule [*] that makes --no-range-diff-notes only tell
the command to pretend that no --range-diff-notes is ever given,
which leads to the above conclusion, a source of confusion.

If the rule were "if you say --no-range-diff-notes, you are saying
that you do not want any notes used for range-diff" (and similarly
"if you say --no-notes you are saying that you do not want any notes
used"), would it make the workaround in the last part unnecessary?
Under such a world order, 

    git fmtr --no-range-diff-notes

would mean that --no-range-diff-notes tells that you do not want any
notes participate in the comparison, so any --notes in the alias
definition of fmtr would be used only for the final display.  And

    git fmtr --no-range-diff-notes --range-diff-notes

would tell the command that on top of the previous state, you are
adding 0 notes to the set of notes used for comparisons, so it would
be a no op.  If it were

    git fmtr --no-range-diff-notes --range-diff-notes=bar

then you'd let --notes in the fmtr alias definition to be used for
final display, --range-diff-notes in the fmtr alias definition to be
totally ignored, and bar is used for comparison.

Would that logically make sense and make it easier to understand?

Thanks.

