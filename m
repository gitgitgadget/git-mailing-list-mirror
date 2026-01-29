Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9751531C1
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698679; cv=none; b=RgE66HNXyP/uP41Fq4EYmGdYw3jCflyH1WATTfG+kRE7sLDeJLuA1ZoYLhCMcxGpk6NwKwvOXyV3/5qJWbei88DK2INl6UTLqGFwei5zHWbGbx2ya4QPFCq/ykq+1RW+2fJongjnTsy9jORpE7sAtX2sNlQ283E1ceT3Am1zz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698679; c=relaxed/simple;
	bh=Uo8+McilCpOMMHH/bTCJATRhCN23nOFlU2UJqIPcaU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyfeLzFEcQBxJmIFbmcDhG9M45XHlrS9Wk/0NnhIAnAgtWcH1b/FzVbLEQQwGJ65FQoQrh3SOOkeRW2brUT2OIgTsrYJAn10M/OM+xVwvlImkmZCTVHOPpDWu3/V1M8SRIS/lK5rc8drCCP22ulN4w2u3Yh0eaeUp7a24wSm1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4OdcUet; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4OdcUet"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6a50c17fdso108465385a.2
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 06:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769698677; x=1770303477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9MX7SPZ/ZYxW+7HAtIwjXyRNxHw1gDd5tiaF6rJGos=;
        b=N4OdcUet2+FQDiCsMLdatizgh7tB3qbHJPLli8Sm1tOhYD/nzD+7k7UR6uH89NtEcM
         Uj4yKEy8NeQBPeRCUgUCnGjY8AK4bDdDDvzdUB3zZa8rHyfD8T9G92hRdv4gAcEWHFEP
         om1zvwk39sFmtglxgZtnQnrV5ByeNrC0fh2pWRbDqbDef3cgmcl5Wc42g2gCjnsyZqp8
         MltRejlwgKCxq/3SPhVuXht9ATrlJzxw68kPzfbxSrqgiKIlJZzhNGu9AOIdUpOVDW6n
         FUq5fFJD5Kh+92r5bDny+Z0q3ynlLKVD4ooE0mCiT9MbnBgEdyY0c/b49Q7Xc6OSCRtn
         HqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769698677; x=1770303477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9MX7SPZ/ZYxW+7HAtIwjXyRNxHw1gDd5tiaF6rJGos=;
        b=hLYZRJ2hhOcICgt5vPxGY/i7iLkU4SHc0wyaF1UP8FRnrvx7T8tRXqjaTApVT4dqB5
         b+8XgNdGijtx9YpgUkqHEyfmERpZDyHJldCqOEcIHcK0jMixxyh8mN0MULcU1eePzHjk
         k/TCAEaYUStmt97LU9eqBjoKHwRBjkC8MWRbmeeL8BFx00vq5XcBDwuatx7FKO4WMwLu
         R3f/AmoETxl2v87msWW/cQz0Ic0pmzVNA14tTSFGFwJuPHykeRmSvDYpTI/BEEsDqmud
         RZH8w5EwnfDuVFb6a9FWYhUz9nM7tfLDQqLXzy8eZjp6vyuviN2ykJzNek+2OJcu90zK
         Exlw==
X-Forwarded-Encrypted: i=1; AJvYcCXOxJYmjvqZmQQAZN/qv6RHDaynJnwLEgMEKf7TpCSW7aSm3+Sce+rt4G70M+dT/46jNLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7Sr3kuC7Dp3RKpg9OXLdXEEnKaLHcpdft76DhjX4mMw/RlKq
	phBMCKi9hTfxiDWmBZWRTElscZKuMpyM4AYS55HUx8sk0U59YvLlnbes
X-Gm-Gg: AZuq6aKTUySNbojjanNemiPaInV4yY5cFzaHvMJEwRYbgXvK5YzGgyVH3G6NHYNnva4
	hadsVEszbvHhNCoKt7mc1TTjf5JM8eP6bJs4/yXTvr4I29gRHzB7sgpX2JVgURd0YCk+5f22piB
	OHhyZ1iERKy/kPy3+gZzi+FL5zweHj3UFfMXoutbNr6ZCPNz06SygURKgorFymyRduy9IXxj/Fk
	XUs45X8PMOpQsdMKrWUNqXXMrYJC6YG9hrNK5W2/8wyA9DgJrPHCEhnthhkMpc9AraYouf9hCUb
	Po8+bLxixbH508BhpmatdNU17lZoS5DiREMwxsudldjaiAzVBZJAIYHND3pNsvQbxumPuQN6E8D
	+GFVioLwOa40fJPjIFhz9Ks6XyAyJw85cXhD2n+tVkTQdV0plKLEJpCDH4D307BtZRA4zOJkKUf
	Xdu97Uhtl4EPi7/ztKSFBmmlDWCOWmCkX0hYm3h2A+EBx81R/HWNC0liQRbt+rQzzVKiZT
X-Received: by 2002:a05:620a:7112:b0:8c5:2ce6:dc2 with SMTP id af79cd13be357-8c70b8451f3mr1185754385a.17.1769698677403;
        Thu, 29 Jan 2026 06:57:57 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c2413sm38513276d6.15.2026.01.29.06.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:57:56 -0800 (PST)
Message-ID: <9193fab6-f7e9-41ab-bf76-c868feb86db1@gmail.com>
Date: Thu, 29 Jan 2026 09:57:56 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] revision: add --maximal-only option
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
 <xmqqikctl3vj.fsf@gitster.g> <7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
 <13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org> <xmqqecngjp87.fsf@gitster.g>
 <f363c16c-1c36-4485-b1e9-22abe32b3a25@gmail.com> <xmqqfr7wgq1p.fsf@gitster.g>
 <c506f9aa-31c9-4c37-98eb-d60076e2e8f5@gmail.com> <xmqqqzr9cm28.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqqzr9cm28.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/2026 7:14 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> Yup, I do not think show-branch nor merge-base were good home for
>>> the feature.  We only needed to make reduce_heads_replace()
>>> available somewhere, and "git show --maximal-only A B C" might be a
>>> much better way to express "show only the independent ones", as it
>>> would allow using all kinds of output options the "log" family of
>>> commands support.
>>
>> I explored some of these directions, and I see the value of allowing
>> a --maximal-only option to them in the future. I have some concerns
>> about them not solving the needs I have that this 'git rev-list'
>> implementation provides. I believe that you're suggesting that these
>> are other places where a user could benefit from such an option, and
>> I agree.
>>
>> Can we delay such extensions to another series?
> 
> Absolutely, as long as we all agree on what the longer term
> direction is, which includes educating existing users of
> "show-branch --independent" and "merge-base --independent" that
> "rev-list --maximal-only" is the future even for their "positive end
> only" use cases and it also can work on a history bounded by both
> positive and negative ends.

I agree to this direction and have some drafts in this direction.

> The only small thing we need to decide here in the above is that
> "--maximal-only" is understandable as an appropriate name for a
> superset of "--independent" by those who are used to what the
> latter has been doing for the past 15 years or so.

My strong preference for using the word "maximal" somewhere over
continued reliance on "independent" is that a set of commits can
be "mutually independent" without any of the commits actually
being maximal within the range.

Here's an example:

    A       B
    |\     /|
    D E   F G
     \ \ / /
      H I J
       \|/
        K

In this commit history graph, each row is an "independent" set of
commits:

	{ A, B }
	{ D, E, F, G }
	{ H, I, J }
	{ K }

and some sets like { A, F, J } are also independent.

Only A and B are "maximal" commits within the history.

I describe this through an example mostly because I don't feel that
I've adequately described this distinction in this thread and
would not feel satisfied in my arguments without it.

With my reasoning more completely described, I am more ready for
someone to overrule my opinion with the argument that "independent"
has enough historical context to mean "a maximal independent set".

> As long as with such understanding, it can be left to the future to
> even advertise this option as a better alternative for existing
> "--independent" option in the manual pages of these other two
> commands.

The other, more complicated, task is to have the rev-list command
use the algorithm that backs 'git merge-base --independent' when
the input range and options is appropriate for that purpose. This
performance-only feature will require more careful construction
and review.

Thanks,
-Stolee

