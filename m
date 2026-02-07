Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5426B76A
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458931; cv=none; b=E3GltIdvnv8t0b0AOT157bllkkS1j7W/bEUZVApD1+KOrq992MCn/W7zseAPLoAUJaTCr0qYXs43BLY9RAq9CJzxHu3P7TPUH/zeyR/WZ6x23Sa9Tnn8BMBpKvy/LYGN89qoKaXS0TWURRtkC9KzC88Yk/KGJLYwDPfqWtcHc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458931; c=relaxed/simple;
	bh=3UZVJCjwlXXSKZY9OI3UhZ4z7JQ5/KESRLlzRUwKKrc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JXHkN2Bw8T8MCsyobwHDtdHqDnqD9QxskzkgXuyV+ebC0OGFKCFt9NBWjJ7CByvH20z7y/+1wpybSbg29EVEE2To+23zcYQgZHehO/CPoWkn6rOWsTIm5l4pOA2Ad+xh4fDnIfMPoUC1l1gDqpZHe4xCZvn+4XQVbNzkApr1ZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kHBUU3mi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dhDGwM0X; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kHBUU3mi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dhDGwM0X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F5AFEC0316;
	Sat,  7 Feb 2026 05:08:50 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 05:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770458930;
	 x=1770545330; bh=oMlFbwuhdWHyKWuEQVGoDPQ0AF6yEDpXTuMoUeDRUzU=; b=
	kHBUU3miFUWDc27ZlRtd7fyvOd1wDPFztNjFhCg9fTzyd6cnBRi+UpDG2KtoXP8/
	ws98ZolYFtDI7G542Gs0cWc6QFU8z1XSCCCWWvXOze7v9mP7qasnDUXzpz1Tyk/i
	X3KNYFLXEnD39w5kNuqAElWiJz8y0D2BlAffV2p6whrlmLaONHRHHKdALDlhCM9t
	MjGPK/chzQTy1otnIQVg5dE/f5yg37pgZONfJpMcj7AlTyJDWa8ih7u6E10hdL82
	HO7qdRGtL0TyZweeIRTgXuIyx4FxSL8fdEt7pIkhbBeyII6Ysc65kwMpxn3OEbDT
	1fI0KnjzUtLF73bXEi1ePA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770458930; x=
	1770545330; bh=oMlFbwuhdWHyKWuEQVGoDPQ0AF6yEDpXTuMoUeDRUzU=; b=d
	hDGwM0XUeBFLrU/EvgjBurxNfOPlALwVTFnD33j8wrsFOF5G9YYZDQW+Ap+e8StK
	keRiq6bT5qjKg2/ZeS15ViHqLZpmZ+7MZBf94l3jyYtP4oclAaGemChENsAZW8ou
	sWZ+DEbw0DVkQ4ulCwy3I8lxWkLxurjiRtDjov+BFpUSXBID0jMosmYvlh4Od+JY
	Dt4OHxQIIZ/aW8usC5+WOR5ibzydR0mZC7IjCWl3AYVTwYFKCx5bPbFam8caF6XU
	kVEHxnEfbrx87U6K8iDt5HqM5wy6LBR0kWqxWHqucJljwOMLY4JNt3Cx0vSmKhfF
	/vNFPy1eprmp2JPhn9Q4g==
X-ME-Sender: <xms:MQ-HaeUPR0YEVN92eG4iglcprdBB4I7L0bTrk_IJMHNxJmsk-s77-xw>
    <xme:MQ-HaVZWNN0vSPwCTAhRgU03DXdc9YQi7hq7t2esh2Sm07FjWRjRr17SyNO9RiyT5
    xrLzLtwugJ4hmbiVUsRzNqe4GYZ-Fq9ZX81A_JF8fVQ3UEBnimJrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefhuedvieeiteeujeeigeekheetheeukeetffevveeludevkedu
    jeefjeeijedtgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgnhhurdhorhhgpd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehsuhhrhe
    hrsehsuhhrhehrrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:MQ-HaVTv-ZYjiKhehAe7lKuZ9YJwV1nNOszwxNNw7NxdX-IVsQfDLw>
    <xmx:MQ-HaWjiqjdGPICBcGSBw9ytpcS8bUr9z_wBU2kkNjRalJNojbrEpA>
    <xmx:MQ-Had5RbY1xCWy4J5XEbf_V14OYJXs5EInNA5TxZnCYlv7H-rZbxw>
    <xmx:MQ-HabDQUnbRvvmb3WTdzb4Z8_NPf6WRu8Z_5kULq5g1a3my9vYRIg>
    <xmx:Mg-HaU30THLItXR80qngWow2IYR_H7cXu35gwU0ecGNt_ePyZZTGfTxJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66EA11EA006B; Sat,  7 Feb 2026 05:08:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2RKoXrlnTsZ
Date: Sat, 07 Feb 2026 11:08:29 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jakob Haufe" <sur5r@sur5r.net>, git@vger.kernel.org
Cc: "Matthias Beyer" <mail@beyermatthias.de>
Message-Id: <f6e4cdb4-ff82-4853-aca5-0c152f287286@app.fastmail.com>
In-Reply-To: <20260206184508.5a014df2@beer>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <1b1f8959-aa11-4bce-8535-7245c8567d6a@app.fastmail.com>
 <20260206184508.5a014df2@beer>
Subject: Re: git-am applies commit message diffs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026, at 18:45, Jakob Haufe wrote:
> On Fri, 06 Feb 2026 09:43:04 +0100
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> wrote:
>
>> Like Jacob said the cure is to use indentation for code blocks.
>
> That doesn't help here as stated by Michael on GH and his Mastodon
> post. Also, to make sure this doesn't get lost:
>
> From patch(1):
>
> ---
> If the entire diff is indented by a consistent amount, if lines end in=
 CRLF,
> or if a diff is encapsulated one or more times by prepending "- " to l=
ines
> starting with "-" as specified by Internet RFC 934, this is taken into=
 account.
> After removing indenting or encapsulation, lines beginning with # are =
ignored,
> as they are considered to be comments.
> ---

Yeah, I think I understand now.

=E2=80=A2 patch(1) will apply all the diffs from git-format-patch(1), in=
cluding
  from the commit message
=E2=80=A2 git-am(1) will do the same
=E2=80=A2 git-am(1) will do the expected thing if you indent the diff in=
 the
  commit message
=E2=80=A2 For the git-format-patch(1) output with an indented diff in th=
e commit
  message: `git patch -p1` (I guess to strip the `a/` and `b/` from
  git(1) diffs?) applies everything, including the `sleep(1)`[1]

My hodgepodge assumptions from 2024[2] were off. I thought that as long
as you did the following:

=E2=80=A2 Do not put the magic `From` string at the start of any line in=
 the
  commit message
=E2=80=A2 Do not put `---` at the start of the line in the commit message
=E2=80=A2 Do not put diff output unindented in the commit message since
  git-am(1) will think that is the diff and not care about finding any
  `=E2=80=93=E2=80=93=E2=80=93`[3]

Then git-am(1) would apply the commit message and the diff part as
expected.

=E2=80=A0 1: Related is https://github.com/i3/i3/pull/6564#issuecomment-=
3863278059 ,
     specifically the link https://lists.gnu.org/archive/html/bug-patch/=
2026-02/msg00000.html
[2]: https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb1=
9.camel@scientia.org/
=E2=80=A0 3: And my assumption here that only the diff in the commit mes=
sage
     would be applied in this case was wrong. Or else it would have been
     more immediately obvious that the resulting commit was wrong.

> It's not exactly written in a straightforward way,

Yeah it=E2=80=99s not straightforward at all.

Something useful might be to apply all patches if they are all at the
same indentation level. I don=E2=80=99t see how it is useful to apparent=
ly strip
all indentation and find all the diffs that way.

> but it show that the behavior from patch is intentional. So even if
> git-am gets a fix, it only partly mitigates the problem as I'm pretty
> sure I will not be the last one to pass "git show"/"git format-patch"
> to "patch".

I don=E2=80=99t pass output from git(1) to patch(1). But I have often (l=
ike the
handful of times I=E2=80=99ve needed it) fallen back on using patch(1) f=
or
patches/diffs that are thrown into email messages since it is more
forgiving than git-apply(1), and I guess also git-am(1).

The diff in the commit message doesn=E2=80=99t have the trailing whitesp=
ace that
I thought would be needed for patch application. Since git-commit(1) by
default cleans up trailing whitespace. But apparently patch(1) is fine
with that.
