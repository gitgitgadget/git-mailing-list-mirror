Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE7283FC5
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660002; cv=none; b=Gi4tYOWTb2TGTAVRskYaJhBdURSWveKLKM5Go59YpYit45Fvu32fLAeL76KcRrLPAQQ/xgEOfvSLII4ImDxv39+YKdbC8iMbHXZr+JR+O1xgBffsNaSKdn83cHTmcxzdoOGdxhUxPWLIINsA2aBvoQYDda9ApT6eXQeZHwVzrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660002; c=relaxed/simple;
	bh=I3dJYKohcf1rjuBf5hltgv35mMeWuRmCE5nDK5Ib1po=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QHYK2SWdNl5pTk7txY7Rvco2hhV08IMqKWZsqnaRlKqbqiWSDWXHKWjdmU04Ok9XC8iy7GDmB49lj4bsqUm7m7rm6q09ReiaFCaLlMr9QZVfbzsMgwJZOxT9wz5z6aUOvTHnoEtSivSVOm6JAggjv9SSWWWm2ZYujX55myav9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NZvapqQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GecPUVxE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NZvapqQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GecPUVxE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F69F140013A;
	Mon,  9 Feb 2026 13:00:01 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 13:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770660001;
	 x=1770746401; bh=yugxYsLRpWcwv653AIBlSpRPK9j+ynPVmqgFcdyeUDY=; b=
	NZvapqQkSIu3WMlsH73H6zEvc5YbLQ/RMwsm5nfVecUFHy3H4b1+2Tf941lh/VqX
	2CMTy7YhWifpsp0gaDm1qhXEQSLG+bBywzqwt6GIkciRHJFamVffH3OAX1M4Dzaq
	sRWB5B+kMTqDVoGTUpafirdXlDkjVMQ9veWM/viGZf2L45UClyssEscpVcEdSMXW
	sI3Gp8LILSrJDGFo7Y3KCgBMykYpYA2q5NCwrAQcRKim55tlKteTkQCNTNctKBEU
	rWfTnEpw849tqgsyfCrKbdcpJ2CCJoI6HX17JHuh+qi0/i0VcUPfN2Pvi8m9fm3L
	UnMeuU3MMDMB+SICk0kTzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770660001; x=
	1770746401; bh=yugxYsLRpWcwv653AIBlSpRPK9j+ynPVmqgFcdyeUDY=; b=G
	ecPUVxEH7T4mHJB6INQ2mMvrJImh+JQ+yDKGqVrkpQX0g7oBp3uCj3JJ6xT8nWa+
	Wo/CCMSV+6NlROnpTMfVKn6wah0sf78m6HtKtXbrhENecKSJmhbz1mFINdRzLp+i
	KkIkkyk4Dq5YPeorNRSCiypTG1koAv7adVUbgf9/mu0znZ/sVpQDTWiAUmCGDR4a
	cCdUWkwtsIt5TO6NBv5WdAQf3OgPPQQV7lPbK8KgniTScvgo8ofuYjQ60OUUegwh
	1DzetfteWCLbJePTQ0X9UGTFEKBWY8uwwXQlUb8wz/ZitgDl7/MOzdGlDAoac8JC
	9Zak7hD2DTbeGu1iMf1RA==
X-ME-Sender: <xms:oCCKaZ_N33JFQPxTWZGD25-jEOIMvE6XXlppoeZCpH9HPp1zXBIQ1nY>
    <xme:oCCKaYg6KkiJ-mqdYvdw3z-m6VTy0QpjB6aPsYgZWcBxUE-lbQ_8lmOHW7stLf6Vd
    Y6GR00acwFTjZgR2ONynZFuOnpxsHQq52pTLvQDQG_aSXSMly-Gew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdehvdffleej
    veetveetffeiudetjeevvefhudefieegtddtjedtffegvedtffdvnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghdpqddqqddqihhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    ohepjhhuughgvgdrphgrtghkhhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehmrg
    hthhgvuhhsrdhtrghvsgesghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegtrghlvghsthihohesshgtihgvnh
    htihgrrdhorhhgpdhrtghpthhtohepshhurhehrhesshhurhehrhdrnhgvthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oCCKabcfRQNRxL7anUezB4P5LzSqolexTCjg3mKO2ZJKvpBlsovfjg>
    <xmx:oCCKadPoWE6UIiK6J34McBDWajas-RnnAupMO6ekvQFwFhWw5Q_iRQ>
    <xmx:oCCKaWsEUFze6WCU4eWj9qNnLxNA_eim-yD36Zo2jSu8697b2XRIoQ>
    <xmx:oCCKaeDjYUHGfloPRCSx7BBot4leZoAYFAM6kyYn2CasrCvP5VSnlQ>
    <xmx:oSCKafT1NoM5BSdGI1la07-JO_Au0lWaxN0u4vHuBMdXV3XhgsqH3Vc0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 231211EA006C; Mon,  9 Feb 2026 13:00:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2LExlyUAPtc
Date: Mon, 09 Feb 2026 18:59:12 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Matthias Beyer" <mail@beyermatthias.de>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Chris Packham" <judge.packham@gmail.com>, "Jakob Haufe" <sur5r@sur5r.net>
Message-Id: <c70adde6-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com>
In-Reply-To: <bf5d1e84-2a59-4e1b-a524-c8b251dbae70@gmail.com>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <format-patch_caveats.281@msgid.xyz>
 <bf5d1e84-2a59-4e1b-a524-c8b251dbae70@gmail.com>
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Mon, Feb 9, 2026, at 17:42, Phillip Wood wrote:
>[snip]
> On 08/02/2026 00:11, kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> git-format-patch(1), git-send-email(1), and git-am(1) deal with
>
> I found the mention of git-send-email here and in the documentation a
> bit distracting as it doesn't do any formatting itself - it just runs
> "git format-patch"

Okay, I see now that git-send-email(1) already says that it uses
git-format-patch(1). So we can scratch that command mention. The user
can see from the rest of the git-send-email(1) doc why we have a caveat
about git-format-patch(1).

I first thought that it wouldn=E2=80=99t be obvious why we are talking
about git-format-patch(1) here.

>
>> =E2=80=A0 1: There is also git-commit(1) to consider. However, making=
 that
>>       command warn or error out over such delimiters would be disrupt=
ive
>>       to all Git users who never use email in their workflow.
>
> This reference is formatted differently to the rest.

Okay, thanks.

I will change to using just one style in the next round. :)

( https://lore.kernel.org/git/doc_am_gitlinks_and_am.messageId.321@msgid=
.xyz/T/#m38026ad670e866b9ef1a0ef3827fd69316bb1aa3 )

>>[snip]
>> +Patches produced by linkgit:git-format-patch[1] or
>> +linkgit:git-send-email[1] are inline. This means that the output of
>> +these two commands can lead to a different commit message when appli=
ed
>> +with linkgit:git-am[1]. It can also mean that the patch is not appli=
ed
>> +correctly.
>
> Is this last sentence referring to diffs in the commit message being
> applied? I don't think there are circumstances where the patch itself =
is
> not applied correctly.

I tested with a line like

    Index x

Yesterday and got an empty patch when running git-am(1). But I couldn=E2=
=80=99t
reproduce now. I must have made a mistake.

I think this should be changed to:

    It can also mean that the patch that is applied is not the same as
    the one that was generated.

(generated =3D shorthand for made by git-format-patch(1))

This sentence would then serve as an introduction for the =E2=80=9CFurth=
ermore,=E2=80=9D
paragraph later.

>>[snip]
>> +----
>> +```
>> +diff ...
>> +```
>> +----
>
> I'm not sure the markdown really adds anything here

I don=E2=80=99t understand? It demonstrates a markup for code which does=
 not use
indentation.

Well, maybe it should be:

    ----
    ```
    diff ...
    ...
    ```
    ----

Or maybe...

    ----
    ```
    diff --git a/example.txt b/example.txt
    ...
    ```
    ----

I=E2=80=99m leaning towards the latter.

>>[snip]
>> +One might want to use a general-purpose utility like patch(1) instea=
d,
>
> "Given these limitations, one might be tempted to ..."?

That=E2=80=99s good. That leads with the problem instead letting it trai=
l off at
the end of the sentence. I=E2=80=99ll use that.

>> +given these limitations. However, patch(1) will not only look for
>> +unindented diffs (like linkgit:git-am[1]) but will try to apply inde=
nted
>> +diffs as well.
>
> This is useful context.
>
> Thanks
>
> Phillip

Thanks for taking a look. It=E2=80=99s always appreciated.
