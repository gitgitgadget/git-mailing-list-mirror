Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707493C3438
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465425; cv=none; b=IQb4mihkvAw7nGs17sS1gKggKwauTMm/k55Priey7+MFUS4L/lOGNXfNp+oEdSaH/av8AV2M+od/rx3dxriBp9nhXZZRYIfTt3XrfPXIbz62HCEba2XDjkB3oHhyXWWnWxxztwzLeuq7YYIB6bIaXnw09pl1tC9UMQYrwB9WQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465425; c=relaxed/simple;
	bh=r76l119c6MeCxZYDEH/15PLXet6qjJnKcxHp1WSzLXA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zjqz+voqaikROpBkt1AiRTAyw/qNAo5RYG4IE4SgOFhOQCD44Kq5Avie8piPeaVP0OrVy7vBttf43B0seq4o4H1eUkNHiZlBzeQt7E8BmLvOsxpS6sI7SwDZ6zJ2Waxp8Llf4pY/FX6iGwQqzTmuwq63izsvC1waYilq9znLk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c96tJka1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZ6d57Hw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c96tJka1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZ6d57Hw"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 487E07A0065;
	Tue, 11 Aug 2026 12:23:42 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 11 Aug 2026 12:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786465421;
	 x=1786551821; bh=fU8L5Wb/A5HoY+GWUq99eWh8PpdJVf1sQq0lLK9/eXM=; b=
	c96tJka1ifBbRQEOnHGFoj3pHNNDJbbNTLEBPI4Sec7SYobKhVl1h4yUAWpmzEvG
	G3pI5xLAMqqg01ve1rwJHA+rOFGE0faQYb1RGY0ebS92zLS/HFWI1YO/uvLES2ut
	kQVziPweoDiARXjDh45JgH9rVyQG2mpiiSUeTBQI36m0Sd4AZc45eq2U3K4ZLZM4
	gJGk7gO9hdTlgoVm69TZCBiacctehrRbRgtCzTy4Y26ZI0d2nDKKAmH+Jqinl6cL
	GhNx++Xoux9FwirVqm5xh1XqIsztO8cYecLP2qbewhb2dFlQEtkLwUTNl4PGclE3
	PMiVpyff57x6t/aXJqeipQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786465421; x=
	1786551821; bh=fU8L5Wb/A5HoY+GWUq99eWh8PpdJVf1sQq0lLK9/eXM=; b=P
	Z6d57Hw0IABF4WXuwwhZzdS+wd/Se4U/bftobjzjFb8UgNdbT/L4vBn8QOi4qS4Q
	COOMcUJHkinOvZT5mnAJ/2sdwJ1PhtTwSXIaI8O7VJC5c/nWPUXil6JLBKi7WRW9
	RyStHsE2xLUVLAsKMgFo27z6fS6VR6lwL4nOh08+Kt/wmLAwfma+qOfMq3sjS1vz
	36jPkQItZrr0XgXhEKVsqJp7GbXBmhoeMGMMJwhvKI+TwW9Z3v/qVbz/Q1JsugAo
	PNkHXwBuB3tFS4eAQ4fK3db887vrDqJrFeNlFtIN8aiL6cWOkhRrFMeuYmz5iQxi
	XJDVDt9GsPIMPYExlKj9g==
X-ME-Sender: <xms:ikx7akhNB9Hd_yKUzZFm3LYrGPlF-DgEz9tqls_RlCeb2nRk6ao-bBM>
    <xme:ikx7an1reRkOTvNvci5akKj4TF8GD7mxV4RLBtm_B1iZcEbGfPVIyCumhNgg1vaMQ
    eXb9YBmJ9hTM2kVZCQlksrC0zvQ8bA3kokXAam_nOZANZutaD8L>
X-ME-Proxy-Cause: dmFkZTFc2wlHfR0vTC/o5wJXeMu4PCAvC5/JynHyD/2S171pRHqI6kcvFngYDxMBlXqPik
    ttesdEHoTydddlvqLlGdCxxMaSuO1BMYo/WInMRWSGvP6AI7xOnXJtc6ADjB7vK57pm/xd
    wKpkAFvtCLwpN6+cVRlrLu9FWCCNg26dce/PxSqPRMmHgg01zYCQxSo7xe3nh+wFOtL6+j
    U5dIHdSg8eVt9QDLcggQjM1Nr804RKpg7rbTmlFB0v+1FIEV86qjMKo1jCzaCfKjaa18T0
    +BVE6290FbteSLUO5sPqvTfkEsildPqcNOcSHr0R93PsROlYNw4usgAw5/SJvmJ3fIHlQK
    9TCZfYJGBzAjyMQSmwUkeLgQMsji/wgE6pfEloRHvSBBZn5rT2y5Y1ou/mnylhIDLO/D2C
    VU4q6muZ4nY0P76jKe7iSKvNIh7UpUucA+TU068Je+/S9bJmkJc9WkB6b9s9wcTFNBl6pW
    bLeRSLfWlLcvD0BEE746A3x9KmC6RrYj8IG3m0N/w/jXL4TEgYd2zHi9MSISiMax92tf+n
    TyIpgZx54qSBw8kG1CmRCfl8OlTHnVRA+DkAA5jMbFCbrM3pLuNEdShxQJaVwXIAuLCHNT
    zKbPluVEMBD1tkxOsFOEpGS3YLoQ0Y3acnGv4TkgTyDd65GnUzNhru4rBPtA
X-ME-Proxy: <xmx:i0x7anOWXyHVRbRY9onRdXAmhsARB-raSdiYiPMG_5O0CxM2xMF5LQ>
    <xmx:i0x7av6pvKq8u0okEfPwHedKcudYxdGNm-xKyFX2dO_sB_5FGGQNuw>
    <xmx:i0x7at0S_RYeYLJOmXoAZ7VfHhi-DCEkyJtgodKZj1lb4dkUsv6KNw>
    <xmx:i0x7aoaBB9Dc1aXJXXx1ghq_mAFmq9u6XNRecC9rvrTWv9DtE881fQ>
    <xmx:jUx7askfIrCuMwPW4UWjQQPVZjkwVF3ZgeSILkmHYfMS4IZ7eA9MZ-4B>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 677BA22C006F; Tue, 11 Aug 2026 12:23:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzsVqDuXP2Wg
Date: Tue, 11 Aug 2026 18:23:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com>
In-Reply-To: <ansWZxZ6lB0tYIJD@pks.im>
References: <synopsis_block.af9@msgid.xyz> <synopsis_block.b37@msgid.xyz>
 <ansWZxZ6lB0tYIJD@pks.im>
Subject: Re: [PATCH resend] doc: format-rev: use [synopsis] on code block
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, at 14:32, Patrick Steinhardt wrote:
> On Mon, Aug 10, 2026 at 06:58:05PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> This code block uses the placeholder `<subject>`. Let=E2=80=99s highl=
ight this
>> placeholder properly by using the `synopsis` block definition which w=
as
>> introduced in a34d1d53 (doc: convert git-show to synopsis style,
>> 2026-02-06).
>
> I'm not particularly knowledgeable in AsciiDoc, I only picked it up
> because nobody else did. So please consider me even more clueless than=
 I
> typically am :)

Thanks for taking a look.

>
>> diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-fo=
rmat-rev.adoc
>> index 505a52feccd..836ba4b0c24 100644
>> --- a/Documentation/git-format-rev.adoc
>> +++ b/Documentation/git-format-rev.adoc
>> @@ -96,6 +96,7 @@ The mode `--stdin-mode=3Dtext` replaces each object=
 name with the
>>  formatted commit, i.e. the format `%s` would transform some commit
>>  object name to `<subject>` without any termination. Like this:
>>
>> +[synopsis]
>>  ----
>>  Did we not fix this in "<subject>"?
>>  ----
>
> Hm. I was always under the impression that `[synopsis]` is used as
> exactly that, so it surprises me a bit that you want to use it for a
> random block that doesn't look like one at all. But going through our
> docs (like for example git-blame(1)) I see that we also do this for
> other non-synopsis-like blocks, so maybe this is fine?

To be clear, it=E2=80=99s not this kind of [synopsis]:

    [synopsis]
    git blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w]=
 [--incremental]

This [synopsis] is for a code block to highlight <subject> just like how
<subject> is highlighted in running text when using (_) or (`).

> There's probably a good reason for this, but can't we instead just use
> backticks to make `<subject>` render the exact same as four lines abov=
e?

It=E2=80=99s a code block and the literal text is supposed to use quotat=
ion
marks.

Well. I wrote the text to mean that subject is supposed to be quoted. So
perhaps I should have written `"%s"` instead of `"%s"`:

     i.e. the format `"%s"` would transform some commit object name to
     `"<subject>"` without any termination. Like this: ...

;-)
