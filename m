Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4134C9A
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404606; cv=none; b=lUNe+Oqj9kVw39ivaDpPLGxyIvvO0r+mXt0m6/2gjTEaIPtX7JE0ZgVP+smoon/3Pory3bntMeNa1LhPEOAs6FJ4qhCIL1hIwz32yPe5SkVIgqy4KcfwutIlnHXuM7ps09vlVCXhRtNmTjsexyh729zOAnxKEO53jBHfNioNTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404606; c=relaxed/simple;
	bh=FiD2y0tGpwELu6WD1pn3gbvvec4sbjmsnmJ+lJXk2NI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GShvIIY7cNhhciuwX9gmgK8hyJG/xIzJ10SFbiAfeTl2BWYPQc+MqOyAzf6JBBRse7MGLoAIY+QRGgFT5p4M4L9ba3ac63xVFZmDwHJwkHCjnkXgjBiFypzPmcprPbheXh80qSBtAWYEqii2Y1GQKTDQxrufm3RGZbFJGcNWQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ugImw5mf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ugImw5mf"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716404601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hv3fQ5gljdxXT0sBGHi0SZt4kvxMHjLIP1oO3d14ZJY=;
	b=ugImw5mff61riShNdJgqgypMAJRidbSrlHqCZla2G3peHYkXU5nt9y6o10aI0URBW46bqY
	o1xXksTrPZ7Jl7vaz4E3q8t5egSY2LKiaYigSOmC8+34+7HF3D6V72nAfbRrHcpjE2nUYz
	ed1oNYsv5LGfzuYoy+V+16sQsOoixTmsjd6b1HpNcHov2Jzls8PBwksSjm/x0/Nimd/YVY
	gy/st/rxw2SAxpkp75+VybbB+Vlomqadt+A6ogvFR+mvv/PtvSFCYnJP77L4diy0DEsQ4n
	+igNuKFrmfbx6vG/QymKsN02IdC6Pfss1u8urSFv5YlCfuMVs02fxK7nKl8JIQ==
Date: Wed, 22 May 2024 21:03:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
In-Reply-To: <xmqqzfsh6cjf.fsf@gitster.g>
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
 <fbb9c7d3e7c2129bc1526dfa5a8eca0c@manjaro.org> <xmqqzfsh6cjf.fsf@gitster.g>
Message-ID: <11abab810253d654119fab69adf44fab@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 18:23, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> On 2024-05-22 01:20, Junio C Hamano wrote:
>>> single-char mode, we may see 'qa' as a response to a prompt
>> 
>> Perhaps s/single-char/single-character/
> 
> I shouldn't have been loose in the language.  Rather, we should say
> "single key mode", as the knob to control the feature is the
> "interactive.singlekey" variable.

Yes, "single-key mode" is better; "when interactive.singlekey
is not enabled" may be even a bit better.  Not worth a reroll,
of course.

>>> +		/* 'g' takes a hunk number, '/' takes a regexp */
>>> +		if (1 < s->answer.len && (ch != 'g' && ch != '/')) {
>> 
>> To me, "s->answer.len > 1" would be much more readable, and
>> I was surprised a bit to see the flipped variant.  This made
>> me curious; would you, please, let me know why do you prefer
>> this form?
> 
> "textual order should reflect actual order" (read CodingGuidelines).
> 
> For more backstory,
> 
>     
> https://lore.kernel.org/git/?q=%22textual+order%22+%22actual+order%22

That's exactly what I assumed, but frankly, in this particular case
I really can't force myself, despite trying quite hard, into liking
it.  It's simply strange to me.
