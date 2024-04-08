Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F91420DB
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592956; cv=none; b=PkQZAYBTEk7i/k8y0MC04lL5BD67DI+0FoDVsAHT2Pk/704Sj2EjN3Zdcg8Rf7fQ5PZCtt7p5RefjYwSuy7T878b1xpLE26OhmXKhZeWswykt2q2+iLYOpFzdYzUykc/0r2yRVhw9eTcx64DrCYW7bbkDN3H636naf4COgwhZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592956; c=relaxed/simple;
	bh=1bXFOm4l3HXBSVRTpXL23AHQy2Fnn64u8mu/XKR2Jj8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XbvqBRE76NSHfFcxvK4Ag5cR1MwFy9VSOteC89TXtjcSbH+NDof97j7bestwrqZh4wS0yV7UYPMK/XArRYXc0iSxH9G9TJ7OtSMgnLFb/L/qH+Fox+0Yte63tM4NxDxW8gDb26nd0Q4iiCLzsY0cZpyjrsCMtitEhm0bkgWp1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CvVBKKSM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CvVBKKSM"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712592949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgsIfj9myZM6+eDfLL0KLSkkvJJYLJwzAcqBShCp59U=;
	b=CvVBKKSM3Q80Q3h4M1SHKUZ3E6gz30/e2w51a9ZDHZtTlEel6hsucA0N7qu4otQ9FtzokP
	N0kQgPHtXE0W5xUcqKrQMqsqAwpknYgioIKNmBwxjEpElw3FcIh+8Pw2BLjWG5pvGniC2a
	le5yQxPDktDZtxhUa7blTc0PjoHHwpZRUpgdZBuSwZjk23Gu3loZ+Q2luDJXbCgoP1HIsf
	q9rC+XC0+uUfnokuHWmKiSshju+ql3pk4Msj/Vv5LVJxoR1xgdC6xLXcBopoM93iO2VaxG
	5/EI2+BiDngO1q5VhlalZd1BgYmtPII+xkNFY1xeWSeNhCSZeDdono15GN+PCw==
Date: Mon, 08 Apr 2024 18:15:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v4] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqqttkbetd3.fsf@gitster.g>
References: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
 <xmqqwmpbm4lp.fsf@gitster.g> <xmqq5xwul8vn.fsf@gitster.g>
 <6cd48321180195e7070825dbc3f49578@manjaro.org> <xmqqttkbetd3.fsf@gitster.g>
Message-ID: <d334e0cc3a681d7ec5b06edac7d21232@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-08 18:01, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> On 2024-04-06 19:05, Junio C Hamano wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> 
>>>> The whole thing deserves to be a three-patch series, the first one
>>>> being a preliminarly "let's move the final newline out of the
>>>> translatable string" step, followed by "let's have a gap between
>>>> output for each patch sent out".  Perhaps another "even during
>>>> sending a single patch, we may want extra blank lines when use of
>>>> editor and other user interation is involved" patch on top.
>>> Or the latter two could be done in a single patch.  I'll have to
>>> re-review the thing (if I were the only reviewer of the topic) so
>>> doing so would delay the completion of the topic, though.
>> 
>> Huh, I've already separated this patch into three patches, and IMHO
>> they look nice and make everything less error prone.  Would you agree
>> with the three-patch approach, please?
> 
> My "or the latter two could be done in a single patch" was
> "alternatively you can", so either way is fine as long as the result
> is well structured.

Great, thanks.  I really appreciate your highly detailed approach
to reviewing the patches.

> I know how to explain "insert a gap between
> patches" well.  I do not know which one is easier to explain,
> between
> 
>  (1) now we have "insert a gap between patches" with patch [2/3],
>      but when editor invocation and confirmation prompts are
>      involved, there are these three cases where we want to tweak
>      the logic to show gaps.  Here in patch [3/3] I explain how each
>      of these three affect the logic from the previous step.

In my opinion, the insertion of vertical whitespace can also be
seen rather independently when it comes to separating the patches,
and separating the prompts from the patches.

>  (2) We want to insert a gap before showing the second and
>      subsequent patches, unless in such and such cases.  We also
>      want to insert a gap when we do this and that.  We do all of
>      these in this patch [2/2].
> 
> So doing it in three-patches results in a series easier to
> understand by readers, by all means, please do.

As I mentioned above, the rather independent nature of the insertion
of the two "classes" of vertical whitespace makes the three-patch
approach look more suitable to me.  I think it's also a better option
if some regression is discovered later, because the patches can be
applied and tested separately.

I already went ahead and submitted the three-patch series, [1] please
have a look.  I hope you'll like it.

[1] 
https://lore.kernel.org/git/cover.1712486910.git.dsimic@manjaro.org/T/#u
