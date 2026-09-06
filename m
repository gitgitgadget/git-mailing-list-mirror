Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A67DDA9
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679374; cv=none; b=BNU5hXGmadWRGDVl8LF8GekDLKk3WPZDUYmhwoBr57AoOZmHIoxejujBZBEG7O8vRd0Yuz/edOgURikTi4IwDZWWVc9AhB/Dp03Ox6deu9GcUXVxintr710Zi1tXLCX4Hn4lZRGchs5K97/LnWtLWOiZc1Kd7mTxEeMTLFe/a8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679374; c=relaxed/simple;
	bh=Ft52vbBTfsKb9wxKASyOhetYgVDZSx1IJMu2N97arXI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=trtv/dc5nFpjWCKCNuM+6+UAsaevpF133FEbA1N2BTVVzNxGN3AtO0lfBqzKP/7B41OzFgM8DgL2XyJ3ydn07I+LU1cs/h2BJZw9qQdpXcjS17t/fbBrZuYjFhP6KDf2GmCYb+rdZYNub1UithP2UFZUxUxHxe5aNZArWSdeP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MC+jhThx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gH5GtZy4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MC+jhThx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gH5GtZy4"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 293BFEC008A;
	Sun,  6 Sep 2026 03:22:51 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 06 Sep 2026 03:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788679370;
	 x=1788765770; bh=EhYQByaSOyN96AInhMQUu1XxkZgrCsawacUXbrgCn5M=; b=
	MC+jhThxYdzvlEuQd0Jke/xPhbe67xPE4SEW/feVF9DumBu6agPZaNqA4iEgG/le
	tyXCLD79S5IwBASQXmdvVOL1X0CdxYRLZyZXG6lHWlja6hxI4h60AXa+lAaS+JjW
	x4yWaaU9Ht33rxb9Uv410DJtC/PZXQ3Ww3f+NSS+At9wkDQ0ZTGN1/xq1amhNNOX
	MJiQKoKhShXTVzVC1dSClWyvXn7E5mbjWbGIuOgqTfdFdU9InqUnFlTxS6CFqNmk
	Zrb5pRzT3gqoxnqV6wSNEEIijRG1sAwiwAxPPyI/R+XUHNtL0DC+X6spGuJs9mw/
	VzNbkGSY05cKncAggC6EPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788679370; x=
	1788765770; bh=EhYQByaSOyN96AInhMQUu1XxkZgrCsawacUXbrgCn5M=; b=g
	H5GtZy4CHaJCrE8XCfvmxAPN7ndtEG4QSCIYG9a5M8cT9y8gsr0OE8CASgEfUbrF
	KgsDGvwRDz253gJSAIwQr0IZA2rTUWT/pHmAOGcmM/qYKPfXIAPyMQu5t7va2ZrZ
	IJWZIy2XUO6GAn2RFPTtlx/TynT+lCde8T5F+Ys3sGeD7ULjiZ/41L6QslC5bYdf
	mZe2KaNZenfTT3czd1PUSJVtS8Cee3goQkQZsBBhBu8M0w1TVPhAJmlhzw7i7zH1
	ZFepuaQ3SOCwPtn9UV38n/FZkMXegmFhnFLnkWLRzn2Tl4xDIH2ot6AvQPsvViT4
	D1d1jtSsJOBTHRib7TRPw==
X-ME-Sender: <xms:yBSdatsudlQgNs6Z-QveT53KEgCMPeFNJ7-8UWBiUjEpTLH6Pm4LM54>
    <xme:yBSdahSJ3RuXzR7kPEU3dGIK8jKpqPG3lg_ZbqGHAohfak1Ip3pLSo-PRZrMqK7Ba
    LKVxO-Hp_llyFAmMruqu6E4J3KpqhNil1UMi-E4w3NWKfawjSN7Aw>
X-ME-Proxy-Cause: dmFkZTEAct18I8xzCPdcbhvlFNgk6BFzlJ0vUuLLbLKEwH0rz3/7M8dc7aFdW/D+rRUF/0
    cZqggrLhjDlmHQbHViuKVPvwtYYUT6Q40JXMS4Mvwlzfgze6OC7wOm0OzZfaQV2GepFwkd
    Q4OtXiKz1lAQ9ndgGTq1/2ewdGYer0oLAiLfv9t8tiItJTpYJG8MS9kmUXJQC5cdj1JqeW
    jWtUNmfdKNeKuTMLN1Q2F/Yym1yrcq3JzQPpHYeUp7vu8kq5sY4d+xnB/iZryaWCLGS164
    TG+sQtc3MEGJNPVxkJVsBp65HexuyIU7lurpwtK2LFASlV9s2dbLxjp0GpY2/7esRUmrAx
    8Ri/Zq4kszrlRQdZemb+aD3Y4vgrHyNro7l+cnVm2UQEno7dVdPznegkSk+Eu1jnhee609
    5zwJt3bPB8CavVj2bKISpD1Wplrjkik2SNkHeDhnvF9PxLji4N/GtidzTur/fLat0dRq41
    HlsuVkKdEAir3gBKsMoko+0DLtYtUQpEOyQM4Is2onw81+BuLBcUkRA1d/O05b5yys3nca
    /7Je9eGM+9YPehS89RgAqh/ARwogbnZRJJk+V67bFWYNH3DDLjj/LSjl+Je16dc+tvVoz+
    HJ01y1r7T7vYplZwqDUUeLFQ5QyVA5rxGEjGGjLlQh39hIbvgajqzbP4GBsg
X-ME-Proxy: <xmx:yRSdasYC5rSx_8hsV04YWbbc7CX6IMmv0Uflo-fd2BsUqqgLQrm-tA>
    <xmx:yRSdalVbzxazMvyMuXM_86hH_d4MYVirMQeU7BjO-6fW7TMcubtS1g>
    <xmx:yRSdaui-etQ-bcuwGmMoTKjQLpVhjg_SR1ulTK1FzldutL4TdvEc2g>
    <xmx:yRSdajWkP4tdpQmPkuGE5T1lkrqwI5-kZN1KLWaBbg9J6Op2SR7dKg>
    <xmx:yhSdajB5bFTTlZvVKaCOujrnQDuxw1kPYNORxoy9OosfZcMefjQuH4qa>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 281B222C007D; Sun,  6 Sep 2026 03:22:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaez0ouLjM7B
Date: Sun, 06 Sep 2026 09:22:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
In-Reply-To: <b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
 <xmqqjypfp2vl.fsf@gitster.g>
 <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
 <xmqqbjan6q7l.fsf@gitster.g>
 <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
 <xmqqpkz24193.fsf@gitster.g>
 <b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026, at 15:19, Kristoffer Haugsbakk wrote:
> On Fri, Aug 28, 2026, at 19:13, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>>>> I do not know.  My preference actually is not to introuce a new
>>>> option whose interaction with the existing --notes option cannot be
>>>> defined in simple terms.
>>>
>>> Let's drop this topic then.
>>
>> That is fine by me.  I was hoping that you'd come up with a way to
>> add this new option with simpler-to-explain interactions.  E.g.,
>> when only --notes exists on the command line, it is used as the
>> material compared by the range-diff and as the material inserted
>> into the final output, but when both options exist, they work
>> independently, i.e., --notes gets used only as the final output,
>> while --range-diff-notes gets used only for comparison material,
>> or something like that.
>
> This is how it works. The `--range-diff-notes` behavior that the doc
> discusses is just the special case when the list of notes for the range
> diff is empty.
>
> That this wasn=E2=80=99t clear is the fault of the doc here.

Seeing as how the doc was unclear and did not spell out how you can
build two separate list of notes, here=E2=80=99s a draft of a rewrite:

    `--range-diff-notes[=3D<ref>]`::
    `--no-range-diff-notes`::
            Used with `--range-diff`, tweak what notes to display in the
            range diff.
    +
    The default behavior is to display the same notes in the range diff =
as
    on the patches; see `--notes`. But you can use these options to use a
    different list of notes. For example, say you have given three notes
    refs to `--notes`. At this point those same three notes will be
    displayed in the range diff. But then you pass
    `--range-diff-notes=3D<ref>`. Now the range diff will only display
    _<ref>_. You can of course pass more refs to this option, just like
    `--notes`. And you can also turn off all notes with
    `--no-range-diff-notes`.
    +
    You may want to turn off this notes override behavior after it has b=
een
    activated. Use this sequence to do that:
    +
    ----
    --no-range-diff-notes --range-diff-notes
    ----
    +
    Now the range diff is back to displaying the same notes as the
    patches. Going back to the three `--notes` example: now the range di=
ff
    will show all three notes again.
