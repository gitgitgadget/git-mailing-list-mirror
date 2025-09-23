Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92235959
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657619; cv=none; b=etOO0OFpZfaTtbQ1T/Awfwm2Z2jf7aUNHw0D2JbmZAMRvQPmpUa5ofrLlKcTcOkqTU3chn4Ap53sonvNAlr+n+ES3gKIHQ9V6Pey8uWdRMo0FuVxNUlHtYLmIKE9l8t5PAIlCUlvGHuenjHQ1eieLnrZ9M2NgQcs2YSyPGhrUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657619; c=relaxed/simple;
	bh=+Gf7L1NoiafVtwLuoefpcja8wRJiVktiMmGnNHcxCWU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gRLdysQfilx70E/yBXqWUbBYB33m0xhLveTBuc3u6aA885inmOn2DQJGg+sgBcV/PobRLHEx9v4xLnQgLTlHyvmFCv6WbQnrZPaOpNuqFZ40V32JFdYSV9mVuuwrCKBbhE1u4UL12TK/L4S71Icqg10Qlrcj6nRRTx24X3UCbBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dr3Bepz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YqvCeT5u; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dr3Bepz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YqvCeT5u"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E05041400139;
	Tue, 23 Sep 2025 16:00:15 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 16:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758657615;
	 x=1758744015; bh=nwW+kwlQtxfcYUl9Zb5uFdxTf2stUp+zqY5LcJPkllc=; b=
	dr3Bepz9m2Aw5Q3uq5szVDQKfyAOL1NZnxXH+z95hKODXlr/LM9cK62WHBoXe+Du
	c72DajwueYXjez+ej+i4GRohHvrCS78ttURrunR6ob6x5eZSCqNNPPJC6qcAm1d6
	BgtkUM2dwWvb7FmndGusEsSgnCdwt66purYqRKykDdSAPULM7d9fT1PvMP1Rx3F4
	hHhIusyFLCd1XTRIXQLw1e7++4Z+mgptmUodwkNpV6O0epMHQNLOmtV8BV+LDU7k
	jysCdGKOqDTfZUKojRx8gDf0x2Ug2lLXO44Wi2SCDh7NL1eLqHBC8wBnVjpADhJh
	PWWw047rIqtO5phkMX9SQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758657615; x=
	1758744015; bh=nwW+kwlQtxfcYUl9Zb5uFdxTf2stUp+zqY5LcJPkllc=; b=Y
	qvCeT5u15Dbg/tF1R6J/DO8i/efbdf6OOTfiQOrNTivm2q3nr+ltlJl9dMYD/+//
	5gdQNW53R/DP8VJ6pcQFMGVxP8MmDthUMfu8Oj+SmpQ2xxr7KYV0HGHY1FUciumu
	yokDr8DiHu5x0Vx63QqHbq4dSm1KTOgRFOOVH89kJliHmC2qJ0hNGLsJwDyJUw36
	Y8QNYAkRdkEOhZ5eYlheXVOBRVHoD04G9JD6iiG++DI8hV9xSrGtu4NccZSSGLky
	VI9qALqv5YB0VRVbj5G0Yr0GrdCU6JBCk1/vJe/FvhymNCO6GYPaADsyLsMALE/x
	QZgQYVMeABrWdSWY1fh1w==
X-ME-Sender: <xms:T_zSaCCMsRIXRDHjA1DrBvzTCjtje_Xrrccljl9CqbI1n3TK4VSOhW0>
    <xme:T_zSaHU9jEKbbQF5tgfIjB2vdY7GRHG6Rz--n1SBVsI8Yc0qmGzczJVrFJGBxRXNa
    GNAI1Cp7lzHi8wAoyvDXvGgs1isuzWCgGG2oDNryqsaPtKXYNGvdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggt
    ohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T_zSaEs795ukHC2Q925cpOZbpqJaZXcRWdhUHSG1IGWiFyIuC_tkFg>
    <xmx:T_zSaPbph2L78JevFtcS0f1pKOJMJPOwk_rrt8GKcjwflU7-6xyMBA>
    <xmx:T_zSaHUfoPytF1XsajXjE2Xi3CdIoeEKKbu3bdXS1PzFz8pfg1d6JQ>
    <xmx:T_zSaD5u5H9lPdW4AlM6M5IR_It6TbOVbXQE3n4iFo28YX1BMMGobw>
    <xmx:T_zSaEFsT9iNPzNqdx0fv6b6TVjfA69d9i7AO9uS-qk_uR1nfNXKjPF6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 751E71EA006C; Tue, 23 Sep 2025 16:00:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFbIE0ooG9pR
Date: Tue, 23 Sep 2025 21:59:55 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Message-Id: <54b9d6a1-6edf-43e0-8e6b-e096f322df64@app.fastmail.com>
In-Reply-To: 
 <CAPig+cS-qYqpK2GOzSLQtqF_gqan6hftnnOnfMFUKby1nT5n7w@mail.gmail.com>
References: <3945bf06-ba04-4ecb-887e-0f3a76e1c2f8@app.fastmail.com>
 <CAPig+cS-qYqpK2GOzSLQtqF_gqan6hftnnOnfMFUKby1nT5n7w@mail.gmail.com>
Subject: Re: format-patch: why are the Range-diff: and Interdiff: headers translated?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025, at 20:16, Eric Sunshine wrote:
> On Tue, Sep 23, 2025 at 12:54=E2=80=AFPM Kristoffer Haugsbakk <kristof=
ferhaugsbakk@fastmail.com> wrote:
>> git-format-patch(1) has had translated strings for `Range-diff:` and
>> `Interdiff:` since they were introduced.[1][2][3]
>>
>>     // Example
>>     _("Interdiff against v%d: ...
>>
>> Is that how translated/l10n Git is supposed to to work?  I get
>> translating errors and such=E2=80=94that=E2=80=99s for the user.  But=
 a Colombian user
>> might send out patches to an international email list.  Why should th=
eir
>> own translated UI (again, if I=E2=80=99m understanding l10n correctly=
) affect
>> the patch output?
>
> Making these translatable was deliberate. As I recall, I had been able
> to formulate arguments in favor of both making them translatable and
> making them non-translatable, though I no longer remember what those
> arguments were.

Thanks for quick and solid reply!

> One argument in favor may have been that (a) the titles "Interdiff" &
> "Range-diff" are meant for human readers, not for machine consumption,
> and (b) there may very well be non-English-centric projects
> (open-source or not) using a patch-based workflow.

I=E2=80=99m not concerned about machine-readability.  My thought was that
localization/l10n of this software was intended for the user themselves.
And also that users might, without intending to do so necessarily, end
up using localized output in contexts where they do want English
strings, like on an English-language mailing list.  Even though they
might prefer Spanish (from my Colombian example) when using Git
themselves.

But there might for all I know be Colombian/Latin American patch mailing
lists where localization like this works great.

I=E2=80=99m not really in the natural target group for l10n Git.  I migh=
t be
totally missing all the use-cases here.

> I further recall that I was expecting pushback from reviewers and was
> surprised when there was none. Hence, those titles remained
> translatable in the final version.
>
> As far as I recall, this is only the second time in the intervening
> years that someone has questioned why the titles are translatable. If
> your reason for posing this question is that you believe the titles
> should not be translatable and you wish to submit a patch series to
> rectify that, then you won't get pushback from me. Also, in support of
> such a proposal, I do recall (though can't find the email) that Junio
> once pushed back years ago against someone proposing to make the
> diffstat "x file changed, y insertions(+), z deletions(-)" summary
> translatable.

Oh, not at all.  I don=E2=80=99t intend to send any patches to change so=
mething
that only me (and one other person from years ago?) have questions
about.  These are only questions, after all (from my side anyway).

Good night!

--=20
Kristoffer Haugsbakk
