Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879C34C98C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977323; cv=none; b=cYIHFaz+3Z/If1rIM74jKbE95qBWcWYrN48w3NyQ2yObcJrfhAUcxcmGqfCo+LUMgXHIcNQICORcWkT1J4XNDqt6AX0rno8e/AvqO07yuJhekPMl+/CK/LJbPWlq47Svq3M0B8aRP8nF99BT8zypQmbZDp7DdGIAtvEDSldYXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977323; c=relaxed/simple;
	bh=C5zKLNoUISMTRzdvuRfAKmGw1gG60lXaKiu6xHNLNy0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LtVReT6D2IhcxFzbCVYVSuY3L8XJB2hbTPJGHFmEBAMG6gdC4eCQctKucRg46RNEzI/4btr+U3eKOJodDTwy6f3dc2Dxg7r9E1i5cIm0Sy0vkDOu9OOHYfgOl0xigXh5anKCJkwtQKehECZo2BOlAx+SYpFG7e8GBG6J1khythY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m3lb7CXJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gi+NzqXW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m3lb7CXJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gi+NzqXW"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 99CB4EC0210;
	Wed,  9 Sep 2026 14:08:40 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 09 Sep 2026 14:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788977319;
	 x=1789063719; bh=2LQBDBZWlT2qdC4jK/+zWf/CdJM5Yv5QhbhpBop/hdY=; b=
	m3lb7CXJiW/OD2B2ZVNP2GSK7Nok1giTvHONReBoG9cWtTyA5NrTYiK21/MCUCWr
	2oSlX7gOiXSzFGxlXM2/OdTFR82XNhVK444pfylpn+/24ieGS1BYEHufMkb68T1V
	1Dve2mMHb7+OARompMpk/Mqa1P9JbiftoLJJylGk+oIgC0kJDeoY2m6zNTV38Vif
	o9knkvkM4zvnMQBjw1xmQTFFu7OZ2NB3OUMv1AAWgbAZQHHIEZp0BWSNNLjVAToR
	3LIeXH117wtb+Z97BQAAYN7jVbaXUH+kMzPSwy82PcQLMB/fNcLZ0jNnO0OmQ0K6
	G0SQi57mC4kKGxbaNuSeNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788977319; x=
	1789063719; bh=2LQBDBZWlT2qdC4jK/+zWf/CdJM5Yv5QhbhpBop/hdY=; b=G
	i+NzqXWLmNAZGQZCyKxRbm1kQewXjKp3PV2uzrBKOd1wCPQs2a7wAxEBrQ+sD2VU
	7bBK2kkIrvX2Rgr8NhQif4WYaZaKZzF/lKxhFk1uJzr9ARZqYmOSBQTla8OHmnUV
	TKW2NOSwTxHEd88RYVuCpX+iiiWk9xxYwViJQQMzH0tKw9vABpSLfXDmFF0Mmnlx
	ZJmUyh2/EED4My6QYIDc//LsHRJySNynClanlj5ZzYEox4SripMMDFE84eTX+TpI
	zYmw4aSz+nFGMLAaN/0sGbKGLkRyi/qLfkRWgm/4hFYAXUNt9vpqdYDG56p6ScTJ
	894KsfB93b0IT1WimaNrw==
X-ME-Sender: <xms:pqChauo0GdAKnHy_4Z1u3zlCI4tqZBRTkzIes_5cLK2FMiBuAu6cjPo>
    <xme:pqChaneXjM-EO5X_5MG6KkQZKLY9UoUcYJVhfYKD3TGE_XkTsXJVg3pbtHNMR-n9k
    vGX-Vcun6nEIkx5fQzHbhgi0vHR6tWsjBSeLqE-s1M_HL4qX-kpfx8>
X-ME-Proxy-Cause: dmFkZTE4uvbyLTL1XCDP8B7ZQoxULiJK8lb9Whtok5nk2MeQ4cwcqQ73AbLM9VUIU3u4+/
    +w1Gr37t4yARawmvvbsqM9QsSO+o/xBs7YmQDnrJ9DpvPn6CIxvMOCi6jOWdZCqSHBP5Fh
    buLn6YQzLA3RkrOtjYcN+YpZ6afVythEzzeaMoPZVr9Ym3YCpQ3hC0NeeUtq8ZcUj4u3Bx
    zLkklvWhdEbKMAJ1zgwXdFYcnQz+kz0DoCvZDI6ODOYmmFig4/0rBAq2d1LOmRKoPyCnkV
    6ny2crU7ykWS93o0K8CdyAVZ1OzAxfHqrQOf0iSOeme22a6yCeLGSZs6IQtKMyxaDME5Kd
    uVHDeWc3Oqm8+FlySaRl3QqMHF43aqab4Q+5AVp9C+iOraBTQvK26e0U34zCPTB0S3sRKH
    iYMvzE6PqWtqiYLTtBwjD3PrJ0onplCy0zL0zyTtFFJeHegBq7w9jI1tSwCT9odNMRXiK9
    zPAwjO5wLNmeTFYsOKYc13VxpmrtGRlCpicCI5LGw45TxOaXq/QNce2SiMn8QzwgIAAPK0
    LuqEIIUGARkydqjp5bGtkRdofqnvD197g5o8EzJ8+8ijDut7g5OJu0kUyA3qJ/womXC1Uw
    yxiISG1WZymowSxpAlUk+xuHa4oF4MNrwCrBGe8ozPaIiTMIFALICCgPptIA
X-ME-Proxy: <xmx:pqChapWqIr6CmEoslng4jFe5ExchVTFdvsrsJips3cW5jZ8c5XBv6Q>
    <xmx:pqChanjIOrmIFXCYdNTR2f4tpoD8HPVXDznW5sDEgvqPmFPVAvHxKQ>
    <xmx:pqChas-oiXbfEd6tgCcaNhB5vHIvCT0LwKUyS8I96JldB3TX92dDRg>
    <xmx:pqChapDFsuTthPG7G2lNRp1hpUhJt5Li-98h8LS6cOAHAP22YxEfSw>
    <xmx:p6ChaqMfKcpIsFmZChRUhq9nWevsuAabr5-SJHsI_TsV4ttd75gtxEvx>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DDC0022C007F; Wed,  9 Sep 2026 14:08:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaez0ouLjM7B
Date: Wed, 09 Sep 2026 20:08:17 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <8f0a076b-4822-44e2-a842-cc1e39ae1c1d@app.fastmail.com>
In-Reply-To: <xmqqcxuq483g.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
 <xmqqjypfp2vl.fsf@gitster.g>
 <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
 <xmqqbjan6q7l.fsf@gitster.g>
 <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
 <xmqqpkz24193.fsf@gitster.g>
 <b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com>
 <e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
 <xmqqcxuq483g.fsf@gitster.g>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026, at 19:12, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
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
>
> Up to this point it is quite clear how the two interact.  Even
> though it does not appear in the above paragraph, the rules
> essentially are "Without --range-diff-notes, the refs that are
> specified by --notes are used for both purposes" and "When you use
> --range-diff-notes, --notes and --range-diff-notes give independent
> sets of notes, the former is shown only in the output, the latter is
> used only for comparison".
>
> But the following paragraph, while it may be correctly describing
> what the code does, does not tell me why you would even want to do
> so.
>
> For example, if you have --notes=3Dfoo --notes=3Dbar always given in an
> alias, i.e.
>
>     [alias] fmt =3D format-patch --notes=3Dfoo --notes=3Dbar
>
> but in one invocation you would want to use different set of notes
> only for comparison, you would
>
>     git fmt --range-diff-notes=3D

Side note: using `--range-diff-notes=3D` (empty arg) to signal no-notes
would be inconsistent with `--notes`. Those options just take that
value. Then they inevitably output:

    $ git log --notes=3D
    warning: notes ref refs/notes/ is invalid
    [output]

>
> if you do not want any notes participate in the comparison, or
>
>     git fmt --range-diff-notes=3Dbar
>
> you want only 'bar' to be used in the comparison.
>
> If you had --range-diff-notes=3Dfoo in a similar way in an alias,
>
>     [alias] fmtr =3D format-patch --range-diff-notes=3Dfoo --notes=3Db=
ar
>
> you may need a way to tell that 'foo' no longer participates in the
> comparison with
>
>     git fmtr --no-range-diff-notes
>
> If the rule is that once you say --no-range-diff-notes the internal
> state is reset and the command behaves as if no --range-diff-notes
> option is ever given [*], then that would still leave --notes=3Dbar so
> the command would beave as if
>
>     git format-patch --notes=3Dbar
>
> were given, which means bar will now affect both, so if you want
> 'bar' not to be used for comparison, you would need some way to
> pretend as if you said
>
>     git format-patch --range-diff-notes=3D --notes=3Dbar
>
> and ...
>
>>     +
>>     You may want to turn off this notes override behavior after it ha=
s been
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
> ... may be a way to do so, perhaps?
>
> BUT I think that is a strange interpretation and notation.  Normal
> people would rather assume, once you said --no-range-diff-notes, you
> do not want any notes to be used for range-diff comparison.  IOW, I
> find the earlier rule [*] that makes --no-range-diff-notes only tell
> the command to pretend that no --range-diff-notes is ever given,
> which leads to the above conclusion, a source of confusion.

Thanks for the detailed walkthrough.

I don=E2=80=99t understand why you contrast these two approaches:

(I=E2=80=99m using `RD` as a shorthand for `range-diff` again)

1. `--no-RD-notes` means =E2=80=9Crevert to whatever `--notes` is up to=E2=
=80=9D, as if
   no `--[no-]RD-notes` of any kind were ever given
2. `--no-RD-notes` means =E2=80=9Cno range diff/comparison notes at all=E2=
=80=9D

Since (2) was the only design I presented. Is the point that you can use
these two approaches to eventually find a way to implement the =E2=80=9C=
revert
to `--notes` behavior=E2=80=9D? Well, if so I understand.

>
> If the rule were "if you say --no-range-diff-notes, you are saying
> that you do not want any notes used for range-diff" (and similarly
> "if you say --no-notes you are saying that you do not want any notes
> used"), would it make the workaround in the last part unnecessary?

You seem to be saying that (1), which is not in my implementation, is
used which in turn necessitates the workaround presented in the part of
the doc that you presented. But that=E2=80=99s not the case.

> Under such a world order,
>
>     git fmtr --no-range-diff-notes
>
> would mean that --no-range-diff-notes tells that you do not want any
> notes participate in the comparison, so any --notes in the alias
> definition of fmtr would be used only for the final display.  And
>
>     git fmtr --no-range-diff-notes --range-diff-notes
>
> would tell the command that on top of the previous state, you are
> adding 0 notes to the set of notes used for comparisons, so it would
> be a no op.  If it were
>
>     git fmtr --no-range-diff-notes --range-diff-notes=3Dbar
>
> then you'd let --notes in the fmtr alias definition to be used for
> final display, --range-diff-notes in the fmtr alias definition to be
> totally ignored, and bar is used for comparison.
>
> Would that logically make sense and make it easier to understand?

Here we lose the power to revert to what `--notes` is using. (Which you
demonstrated the utility of with the alias.) But I think that is
fine. It is a niche behavior of a niche option. Does not warrant the
end-user to think this hard at all.

So here is my redesign:

=E2=80=A2 There are only `--no-RD-notes` and `--RD-notes=3D<ref>`, i.e. =
the last
  one has to have an argument. Since we have no use for arg-less
  `--RD-notes` any more.
=E2=80=A2 That means that we can use a regular pars-opts callback instea=
d of
  adding it to `revision.c:handle_revision_opt`.
=E2=80=A2 The same rule about interaction with patch notes: no such RD n=
otes
  means that the patches notes determine what notes the range diff
  gets. *With* any such options, however, they are determined only by
  those options. That includes turning off all range diff notes with
  `--no-RD-notes`.
=E2=80=A2 No feature for the niche behavior of turning *back on* =E2=80=9C=
use the patch
  notes=E2=80=9D behavior for the range diff notes

Thoughts? I=E2=80=99ll try to work on the reroll in the meantime.
