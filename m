Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3443A9D8B
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713106; cv=none; b=ZNYahqxnR6m4rmml5mQmTjxizM7BJa28od/8GLlw/VNQ4bjDrGflu14xTOcvGZv17yM30A+nCqN0LHZlW4PXlNAorIS4bSZZRpTjeKY1E2qi42xRkl5PLrBaSRg0LPZBK71CR0hFgCZ+IBa69vJ4T62IMEYOwrvcsM24yWk7wo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713106; c=relaxed/simple;
	bh=Vth0/cjZJWPIeycsPIUyRfowUzOKQTZQMkkbVeMIsYc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LrDur8WAq9mwjLlvdKrgC4ZWpE2PdU5004dwf/iqYb/cQGVkbLmgsSrE3BbYlXCuNsMKq8boiBrMNuMC4kv1kFjZhh9fDvDGeuYCHg0b7Vm0VMZybT53C1NjJfL1eVmIGw3BNDcBTohEmSCRUh60WoGRNvdTpoLXy2j5V4r83us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=e+cxNp9n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEGBGU8A; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="e+cxNp9n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEGBGU8A"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6724914000E9;
	Sun,  6 Sep 2026 12:45:02 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 06 Sep 2026 12:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788713101;
	 x=1788799501; bh=RE4GSV/ivS8s38yi+RuD28AzuN94YasSca3sV3ovCXA=; b=
	e+cxNp9n0iV76TjZvB3wKnALZLkktCslsdOiwQeBJJ2M+gONTugXEM7cSVAZP4UF
	SBrrMhl7pksWs0O+K3KKB4QVAMeVUaebrSKIHajjg3iczoiPF9xlPlycQo8Z7TWA
	Hg07zsThaS6PoMcQ92btcuQMWOGLVjJ8Z/MMzy0YnNhBfD0Ng2K61L+nz7Zye6Iv
	h6Mkyrc3HxlGBXI5IU1BANB4UtIxQGuoHJnMhanyEOayDr803+sfrmjs3f8c/qmb
	KvgHx3hLdFl0bxOyJIcq6oIeQg1kO0zf0OU7wW5QybImgVhWndp3c59rq20nVJaV
	7voT+Gdm7PMfhWPv6CbEaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788713101; x=
	1788799501; bh=RE4GSV/ivS8s38yi+RuD28AzuN94YasSca3sV3ovCXA=; b=e
	EGBGU8A95bEaD1x5PoudYFuHdZhbuZizBlroNM+MdebSqCBEv6Oifx4e960VcOMq
	Mxfak6Xb48HNhg8jDBEwGy1Vq/2ceB1cy8fWe0latG0UV6Zn7dbkNJ4Ge6HSkPan
	2uz3gy03xAJ2Lag79FGAROwgG3aGLXgtD/e9mkLWRSX52oiOOBBdGbmqJU5cWVzK
	9B3OZnDGpWpZNBrk12PxkbcPSshDHUhYIaSMmmJZMj/Mm/ldgeRJQkPW+U4zfuMf
	Sft9TD8K8vNpvoFV+UOEwTnW7MpTaIlTXF6DvRaJGFf9WT2MRq3AJhexHhxvGMAU
	sOKO/Ros7kj/PSrVD4ywg==
X-ME-Sender: <xms:i5idaiBsmo2njLTJwU-fuM_IjyVVzZbo9m47ViPmpxNpzomM0GDkfzo>
    <xme:i5idanWd81DPs3fqweFdapBELf1YPOKlGEOOyyhyj1pdDdcwJUcvj5G-KX0KILr_K
    39ce4t32eRYCCH8GwSVaKmCs-S4OLah5GHhnLsDt-BStojM5oFJwvk>
X-ME-Proxy-Cause: dmFkZTGeDD4tTqsWCVVWH5sPIZ7YS+gPDmaGXEFYW2678v8LErou5A0ldSswOJ1Z9BT4Q6
    ef625Ykf3oazpzIaJUSOEOEsmcIqkMa+pIZDwXxL6QKJ4LxHmgl/XaX/DjjsapNvvZCIHo
    WbiKFsa1evQV6Xtne18RO6F0g1MCFA2v9XNp+z5IZDxdDp4qD8rFu0d5q8n9bIbYExCuh5
    p94zhB/ZvFRFx4XmzrvteUMWPaGFl/3PS1wABDVq/NLUGNr304byXk5vAPXzY4+hELaxFN
    3TAdn5/JFMy+pGd7KiIIXbC8j5dsuVAvLr+oGuWWTcXiLDsRUSxrzS+RjmsHDxRV0a7rBn
    Pt7yJWAFnwfw8b9MJV+hb30PIzhWMglSNO9YkqoUR/ArqG7EDPuCpgvTydnWGpuT5ASnXV
    Fo/oKrpOb4Ar/XU0KYPavFEAyV8m7HyVRPN05FZKcB7xj+FYyJS3a0v1GOIfbOiuiRCP7v
    yOTKNC8U37F1NWDfWddSWBjWpGvm4BBqfeAHNW2Qsryxu2meVQufZYUJMH5mz6MuVsgE5k
    ycWVBQvpcyydiDLUhXdTdjNgqia9HpRv8FQ1Ncot76roCpvdVsWJYhmAazLb8/DrMUdw7M
    AjiWFmfrsnpu6O7e+UUg9IcG29lSN7wR6ypapsf1zl4D3Nz13nvgpnKt7ZMQ
X-ME-Proxy: <xmx:jJidaneA2S8xrXziYRh46kqf-5R58moVPpTjh6pmGbnqtEZqJ8sfqw>
    <xmx:jJidak8ghVG9IM4Ydr_DEXOZE5OIstpYvjBVIG9cOnxU8tqovVKw1g>
    <xmx:jJidajk36wUmUi8jkFxtNe-x-s-TdvTyyK7AoOUpsNUNVGgNOyN_Cg>
    <xmx:jJidam864TmCJM7353AeoUyzj3T5IeATMI4tK7Y3mOgsbM5oHKHPQw>
    <xmx:jZidal7duKFgyDIjzpnxIbkxSEydS-UNOIQ7rGYazB5bi4VmDSVqUPvW>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 92BA422C007F; Sun,  6 Sep 2026 12:44:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaez0ouLjM7B
Date: Sun, 06 Sep 2026 18:44:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <392dc2b3-59cf-4fd4-8c73-38a57c8d0423@app.fastmail.com>
In-Reply-To: 
 <CALnO6CA-6m58sJCf=5_GwK3GE8=EfhzgsheWBqMQjc0r+N7+Xg@mail.gmail.com>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
 <xmqqjypfp2vl.fsf@gitster.g>
 <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
 <xmqqbjan6q7l.fsf@gitster.g>
 <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
 <xmqqpkz24193.fsf@gitster.g>
 <b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com>
 <e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
 <CALnO6CA-6m58sJCf=5_GwK3GE8=EfhzgsheWBqMQjc0r+N7+Xg@mail.gmail.com>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026, at 15:37, D. Ben Knoble wrote:
> On Sun, Sep 6, 2026 at 3:23=E2=80=AFAM Kristoffer Haugsbakk
>> >[snip]
>> > That this wasn=E2=80=99t clear is the fault of the doc here.
>>
>> Seeing as how the doc was unclear and did not spell out how you can
>> build two separate list of notes, here=E2=80=99s a draft of a rewrite:
>>
>>     `--range-diff-notes[=3D<ref>]`::
>>     `--no-range-diff-notes`::
>>             Used with `--range-diff`, tweak what notes to display in =
the
>>             range diff.
>>     +
>>     The default behavior is to display the same notes in the range di=
ff as
>>     on the patches; see `--notes`. But you can use these options to u=
se a
>>     different list of notes. For example, say you have given three no=
tes
>>     refs to `--notes`. At this point those same three notes will be
>>     displayed in the range diff. But then you pass
>>     `--range-diff-notes=3D<ref>`. Now the range diff will only display
>>     _<ref>_. You can of course pass more refs to this option, just li=
ke
>>     `--notes`. And you can also turn off all notes with
>>     `--no-range-diff-notes`.
>>     +
>>     You may want to turn off this notes override behavior after it ha=
s been
>
> [nit: should we call this "no notes" override behavior? Otherwise I
> think we are referring to --range-diff-notes=3D<ref> overriding
> --notes=3D=E2=80=A6]

(I will shorten `range-diff` to `RD` for semi-brevity)

What I mean here by =E2=80=9Cnotes override behavior=E2=80=9D is turning=
 off all
`--[no-]RD-notes` options. It means turning off `--RD-notes` as well as
`--no-RD-notes`. And without the override you are back to the default
behavior where `--notes` dictates the notes for the range diff.

So that the utility is a bit more clear than these unmotivated examples,
here=E2=80=99s an example alias (with forced linebreaks):

    my-fp =3D format-patch --notes=3Dreview --notes=3Dtesting
        --notes=3Dattribution --notes=3Dchangelog
        --range-diff-notes=3Dchangelog

The patches will have four notes while the range diff will have one.

But you may want to disregard that last `--RD-notes` and in turn get all
of the notes in the range diff. But without repeating yourself. Then you
can do this:

    my-fp --no-range-diff-notes --range-diff-notes

The option (the negation) is not sufficient since it would turn off all
range diff notes. But this special meaning of `--RD-notes` allows you to
go back to just regular `--notes` behavior. That `--RD-notes` has a
special meaning when the list of range diff notes is empty does not lose
anything since `--range-diff-notes` would just be a no=C3=B6p otherwise.=
[1]

But I should point out in this doc that bare `--RD-notes` does not use
the default notes.

Of course, there could be a dedicated option to turn these options off.

Or to just not support it. ;)

(my standard verbosity level might not be doing me any favors
on this point.)

***

That might seem like a lot of =E2=80=9Cpower=E2=80=9D for something as n=
iche as
overriding-then-reverting patch contra range diff notes. But code
wise I don=E2=80=99t think the price is high... :)

=E2=80=A0 1: I just tested the behavior of `--notes` (no arg) on
     `format-patch`. Yes, it does respect the default notes ref just
     like git-log(1) does. So an alternative would be to have
     `--RD-notes` do the same.

     But I do not think some convenient default notes ref is good for a
     command which is supposed to generate patches for email
     sendout. For `log` you can make convenient notes to yourself and
     conveniently display them. But `format-patch` should demand more
     intentionality. (I also wrote about this on a bugfix for
     `format-patch` behavior some years ago.)[2]
=E2=80=A0 2: I suspect there is a bug-looking like behavior in that
     `format-patch` seems to use `notes.displayRef` for the default
     notes (not just /refs/notes/commits). It should just respect
     `format.notes`, I think. But I can look at that later.

>
>>     activated. Use this sequence to do that:
>>     +
>>     ----
>>     --no-range-diff-notes --range-diff-notes
>>     ----
>>     +
>>     Now the range diff is back to displaying the same notes as the
>>     patches. Going back to the three `--notes` example: now the range=
 diff
>>     will show all three notes again.
>
> A bit long, but easy to follow and understand the interactions, I
> think. The examples are helpful.

Thanks. I noticed the lines kept creeping up, but it is more involved
than most options; an option for passing on to another command which
also overrides the behavior of another option.

Thanks for taking a look at this niche topic. Though I see that you are
one of the dozen of us[3] who use Git notes on his submissions. ;)

=F0=9F=94=97 3: https://lore.kernel.org/git/CV_format-patch_learn_--rang=
e-diff-notes.c57@msgid.xyz/T/#m6a7cbbe0fc456e7e62125d903b706ae5a547315b
