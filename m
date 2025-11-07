Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657632E130
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531136; cv=none; b=pXMTe+aS+6ak/ASTLUkvyon7lP8exR2FDEagI0pKiqPUyulM1s88JPTExhEzNd055cVuC0kjxY8vmwcBLVAB5GjFnlFxneOfkRi9Pp5DpPl2DqgRuDyV5AgRhDAKlH0Qgdp0Sxy2nZlfc3lJXLrzI8cM9NafmigT3M10WKlxyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531136; c=relaxed/simple;
	bh=nD7cd0XEM8DSstsjE1nVt1iu6TlOPA8Q3ZbQiKCbGUI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZkoOR/L8yg3FvChSImsZ02AudQdehNOp01iha868PAO3q0afMdriNl4uTxQKFXl9I7CsWDycVdGhwVVPR8ntq5QHxXGvnGn4gUy40bbWwXuaNQO6olSTf/zOSzAmdv5s9rncsNtMP5+sC4oLzRmYykUczTDyNtRSvD88mVAzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAb1HCQ6; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAb1HCQ6"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so352955137.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 07:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531133; x=1763135933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfkFcvlwrdgivGuMKxXGjTyj7IlIPttpSYFAcyoQpio=;
        b=mAb1HCQ62N//1EJ1M/0ku3WFBdOmtbyGg9tfsDqnwDL47DvpY+biMATOG7ggQm2OFV
         190Yywy/fnv8WP3DtUyCeaeCD0t7caDKWaZaqiy4g+N8+CYT9o/D36gHmxgmwAI19Qx9
         1odUz67IxpNX/7XNPWXTNxDr+qrzpecNoO5TkN2fqIClR8o5MKZBMQL929odf4gaErWD
         F9rpCajeXbfGIOWUsT/quUQYs6gc1RAXa+BPRS1NWhRopmDnWPDBtWPI/WXAwBEc/MSp
         1cNA5I5yTw9YmNhZdXD173oPrheSF0gUv6lQIXhIHOFWocu/nrpnC6LgQJev9HlRXOOx
         wBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531133; x=1763135933;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfkFcvlwrdgivGuMKxXGjTyj7IlIPttpSYFAcyoQpio=;
        b=i8ahtKhIc+DLgRLH/oDXkNNZQKMwEOtekuaeJYJJE96XsbufVftk8Pv9HNvHf5jNH0
         BSKuaS6kcAsoIAZK76HnivymDbAptNV/ohbU40wmSjnCG2fxZ9zDUNczXR0+iKb/4GdN
         8D4hgZeHyPZYrgehXqw64nooitdQ8hwK2B/EvaaVc8hNqnPg/N7xlio6ViYPtqsAfKUN
         30Ipjd6T5wC7djRgJGEhjKI99nISRTAKoNuh3KZJMnd0sQs2xA+v3WzkB4Vvs7jQlR3+
         xK3TxZYc9mQbETqhJlnO6eLalSxkAM1Q+ZGLnFcvQpDjlJPrEFbsMpPAL2PfHrP+rG5j
         aGjw==
X-Gm-Message-State: AOJu0YwOYOOkMS/o+aHZgClCgFHLI7BMbgNyZgun9TekEkb6GGr0naBe
	rpyVPmlNRsK/LQ5Kr/kVYHjcUXDW+mleZRUSnm3ztRBldGt2NZc0cr86M/gnkcVIv9of8mORsvB
	SGtaihfbPacqF93Af8+81qzpRs6h+V34=
X-Gm-Gg: ASbGncs8Kj5h8qDvt6cwjR7dQn9hPDG4LnZkIjv+2voXVOiWPbW4+2vW9a8H6ij+Hzm
	XGBb5QVOyJHK8etdUcsOJvuGK8hQZ/Nx7v2gfcmfOC77Tn84JQAikZFLe1ZYMLdmg3FsE4dnlIR
	m0Xk2qQbryEVrED8z/NZAgC8YlcXQ0TfWs5yNr8Mj6YS9oA5djFStocjgrcvJJiK46QCaFeAHr4
	VmveeQaWYmmvT/LppoD9X1bH1JhjJfiPH5Jw8gFeaLm0wAL3eXPJdFG/fsTimNdmWkIWTaIOpMy
	DBp/dBdn/Zf/s5uuB5+2nSO6Xj8=
X-Google-Smtp-Source: AGHT+IG+bEk3lcLVUknCg4s+/n4t+5cM08asG7wf4X+oH/1TJQ52h3mUjwQd/wIOSPV3CQg+HQfMC/LvCFb+saTE6W4=
X-Received: by 2002:a05:6102:41a8:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5ddb20e6e72mr1160039137.5.1762531133233; Fri, 07 Nov 2025
 07:58:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:58:51 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:58:51 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqpl9vjiaj.fsf@gitster.g>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
 <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>
 <aQyNSOdPWAxm15U3@pks.im> <xmqqpl9vjiaj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Nov 2025 07:58:51 -0800
X-Gm-Features: AWmQ_blWEDRCHRayCXLPaTdywn1M3tifpdR9iBSkdrZgqDZGthpBmRai4jldZes
Message-ID: <CAOLa=ZT9_d5yKPP9g_pWZL23RkbMLN+SXgPCuSmto0mF6XCy4g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] maintenance: add checking logic in `pack_refs_condition()`
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000001a35490643034280"

--0000000000001a35490643034280
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> +	/* Check for all refs, similar to 'git refs optimize --all'. */
>>> +	string_list_append(optimize_opts.includes, "*");
>>> +
>>> +	if (refs_optimize_required(get_main_ref_store(the_repository),
>>> +				   &optimize_opts, &required))
>>> +		return 0;
>>> +
>>> +	clear_ref_exclusions(&excludes);
>>> +	string_list_clear(&included_refs, 0);
>>> +
>>> +	return required == true;
>>
>> Tiny nit: I think in our codebase this can be written in a more
>> idiomatic way by saying `!!required`.
>
> Comparing for equality with Boolean in general is stupid, as
> Booleans are designed to be usable as-is.  If it is "true", it is
> true, and you do not have to compare it with "true" to ascertain
> that it is true.
>
> I do 100% prefer "!!required" over "required == true" or "required
> != false" all the time, since it is more idiomatic, but I vaguely
> recall we had something that contradicts it in the CodingGuidelines
> document.  Perhaps we'd want to fix that.
>

I could only find

  - Some clever tricks, like using the !! operator with arithmetic
     constructs, can be extremely confusing to others.  Avoid them,
     unless there is a compelling reason to use them.

I think its okay? This is more of a suggestion than a rule.

> Thanks.
>
>
> [Footnote]
>
> But doesn't your suggested rewrite potentially change the meaning?
>
> The original allows required to be "true" and nothing else, while
> "!!required" allows it to be any form of true (and in C, things that
> are not zero, even a pointer that is not NULL, are all true).

I get what you mean, but with the context that required is of type
'bool', this would mean that we simply convert it to '0'/'1' here.

With all this, perhaps `return required` as used in the v1 was the best
approach. I'm happy to go either ways.

--0000000000001a35490643034280
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7ee564154c536fe9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rT0Z6UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM28wQy80cktHM3k3Y3FnZ2pXMkZLWThtVEt3ZzluWQorc1JlRFd6aWVN
RUZuV1hmZmdaRjZNbVhIWE9QbDRUejhKSW1PNjdjams4TFlLTEJ3WS9vWDRRS3FaMXMxWXNwCkkw
Z2dqeVFjTnBQdzJpWnA0YWZwWEtPc3YwOXlXaE8zeW9ydFN6T0NJOFYwK056MDRMaUQxc01KK2Jl
MEcxUi8KRHZFNlB2YWllYm1aUjB4MjBqRjQybTk0eHp6NnNDOUd2YWtMaE5jKzlTZ0c5RElGeSs2
RFZTQ2F0Nlg4K1V0NApNVU9KU2tkT09FUGFXSHFObngrbDJ6QlJKbW5xU2p2ZnJDbXJCbGhEUHBD
K1M3RHJhdjVkSmg5cnhoOU1FVlZGCjZpK0JNclMzNWZzWUp0VysrdjE5ZnpIWVZSczNWeTVsaWJN
RHd1ZlQyMTRnOHA3Qk1YM25ucDljWnlGRGt3V1MKeEprYUtMZlNTc3hoS0FXVFVkeUpFZ2p3a2FU
L3NpaTFFZEdHcThzMTNvc2NvUklnWUpjSzh2MFJ6OXA3TENncQo0NjVMaDFpbEtrRW5iWjZoQ2xB
VkNCRkY1Umt6ZS9aWGxneFdwVlBobTA3QTNFMTVZd2VpUHZDYVprU0xhV3ZvCksyTHByaHNmSkNU
d3RBaFZ6bno2aE4vWXpnZDZ5ZVdCQS8vZGN2bz0KPVRmaEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001a35490643034280--
