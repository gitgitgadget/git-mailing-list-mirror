Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6A262FF3
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185120; cv=none; b=sf0D8dBRMB4fHsrm3u90liuxiO2LIkGxZB0KPl+3F/btzi1O/vyNW610tSv1p1P8i+diGZempCiCmfNjSW+UtHT6qjQroSQBisQSXnDXDlevfH5zSWRN6XhQIz7jQbbHNZxqKXRaYA6ZSG0jkeqaG4qA7vJSwBAAWFf95ME8kFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185120; c=relaxed/simple;
	bh=A09RlOROFi+aUWr0mbY4GepspDCXjlnNSpY85GE31yY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDiXeWBk9rO9DUAtoVrSVrODNqIZvOYlr4ydKk2pTct4z90GervnMrUwUdHo0z6rjPm/h70f5uTGTPd4qHmb6KHYovGxLug2K71cvpMPmsz6+jsYrVIfKv6ERTkxVnBsh+kBwg7LjZLgZmPNBuVl3fDq8qYyRP4ULPR+yAuP6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/5GPTFU; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/5GPTFU"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89019079fbeso1865805241.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762185118; x=1762789918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=72DXmR8r0w669ZUue3f1AEkoeBqjT+DjgdTkd6mdMkc=;
        b=N/5GPTFUrF774gmx1gMsYMtCLsTSmasr73m31omcepgfkGwoIh1CTDasKqWP+bwU0U
         VgmI7bY4Cn/8jchykEEtUikPTf2C9XSZhGCO+07nczds0k8Wuk3tpF5EOmQdQqFRZALq
         pVnPxfioMqX4rvikCGMHdhbL7gttxvTmE3AdHmvmj3R9xO/bJ2zxbaUIs3YcBEYXOr0D
         8yi1deTPK4RuFOl+6HvvOkzDFgGlCag0Hm/lBrolV8alW6rggzdsUsG2bjbGVeWLh2eJ
         Nm7lfBehyi5E0z/lp7DqAvQRpazChPJleEvN3Xv9xoazb3WoOwCtusj5J+obEyRIyfJo
         X9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185118; x=1762789918;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72DXmR8r0w669ZUue3f1AEkoeBqjT+DjgdTkd6mdMkc=;
        b=DgAfmAJU9Fbgw4rnzGQNBnaunZKhHv0UkwZpNhM9VFbMQKcJYa0NiOoXE4X1buZXN4
         /FXqYUgF1EcRoxsx/APkZT13pKGfvf46UI2CeUnGuZukRSbaolw+F0u1AXryRIsL6QpV
         r11rwcSBXkVjcQGG9/Nr+I2pnCnm4p5kp1q/MtQJKO1VrYso6mPTa4AJo10N6fy3YWGA
         f1FSLomLMTo7G5G+dSmWL8TiWiPBkgmGaiJJoEn6SAOc12pRJHBBLwb/Mx8Wl8h5Y5nd
         LDUnam1vtRcdw1RtsnqENcxVZnS+JCzfsikoqI7nKlOi5lLzqdiOQ2tR3UKPyvK9NXie
         N+DQ==
X-Gm-Message-State: AOJu0Yy18Ihuw1nxMvymg/Qm57w++lP+NmGK21KxBAbOJMURB47cP33N
	fxE+lpQB7pqN4TtGy9ybrP0ppehWSij1bKQEJxraqXehYPC4DJ5rf5K2XJUPSsoZHVQA7Uqsd/A
	5PvkYJHu9tmw2LN7HP16p/xe0xyCNT0gMzYr9
X-Gm-Gg: ASbGncu58VAMzfa6GGgta4y0x3P5pV8c042u5S5ODiIoiEi5pAlV8CPXH2F5yIOsviy
	oae2oS1BiljsxJTkSqgwhQ9sSmxOA7/27Xp+mrjQ7IFbO/VCowjPp5/eWvA5557pewvF1eoS3wJ
	rJT9LbWAKW3cLTxh8Xpz4ZKJAMVbKqArNfpLDGvJ61cKMckLPufkaO7tWKHxLR8MKA0QpTujW/U
	59RWggKZHfujpXuNRCLgHLblfqhI6TLxqaikgbp5tHvTFRaAh5i0y3QcxS3LDB5Eez88jNquOX2
	QZWBe5I6ZF9FyXi3viTIfYxuhUezDrVXMU6trw==
X-Google-Smtp-Source: AGHT+IGFJfrK6D4HePT1qW20G7N2hW2WXxLfn4cBCvJfVYAjJrxoZ69kDJdEM3gBmMQZaSc4rHWMx4ucyv344srx2eo=
X-Received: by 2002:a05:6102:951:b0:5db:ae7f:7b0f with SMTP id
 ada2fe7eead31-5dbb139bb90mr3430879137.44.1762185117977; Mon, 03 Nov 2025
 07:51:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 07:51:56 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 07:51:56 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <tdgxvocyp2armupgbti2wnbjphdvidooddbdyrynmdokjgqr3o@tzrbu5lcgipt>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
 <tdgxvocyp2armupgbti2wnbjphdvidooddbdyrynmdokjgqr3o@tzrbu5lcgipt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 07:51:56 -0800
X-Gm-Features: AWmQ_blDMXnQ71rWfiPabcTxAAFwDgAmu3ml9MxF1_6QAMz4HIU_6oqmf6VMFQA
Message-ID: <CAOLa=ZRzLviMkc8C8617L48NwJPvi7F1Qsozezm9gUQ0_dRU4A@mail.gmail.com>
Subject: Re: [PATCH 2/5] reftable/stack: add function to check if optimization
 is required
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fc6b540642b2b16d"

--000000000000fc6b540642b2b16d
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

>> +int reftable_stack_compaction_required(struct reftable_stack *st,
>> +				       bool use_heuristics,
>> +				       bool *required)
>> +{
>> +	struct segment seg;
>> +	int err = 0;
>> +
>> +	if (st->merged->tables_len < 2) {
>> +		*required = false;
>> +		return 0;
>> +	}
>
> Both `reftable_stack_auto_compact()` and `suggest_compaction_segement()`
> already check if the stack has less than two tables. I wonder if we can
> avoid having multiple of these checks by instead having a single one at
> the start of `stack_segements_for_compaction()`?
>

Well we can't for two reasons:
1. We want to perform this check independent of whether `use_heuristics`
   is set or not.
2. Currently `stack_segements_for_compaction()` does one thing only,
   which is stack the segments. I wouldn't want to introduce another
   responsibility to it.

>> +	if (!use_heuristics) {
>> +		*required = true;
>> +		return 0;
>> +	}
>
> Is there a reason we would want to skip validating the geometric
> sequence and just assume it compaction is required?
>

This is the difference between running 'git refs optimize' with and
without '--auto'. With '--auto' we will use heuristics to do a geometric
progression. Without, we simply compact all tables into one.

So we need to support both modes here.
>> +
>> +	err = stack_segments_for_compaction(st, &seg);
>> +	if (err)
>> +		return err;
>> +
>> +	*required = segment_size(&seg) > 0;
>
> As mentioned on the previous patch, I wonder if we could just return the
> number of tables in the compaction segment as part of
> `stack_segments_for_compaction()`. A negative value could indicate an
> error. All other values would reflect the number of tables to be
> compacted.
>
> This way callers interested in whether compaction should be performed
> could just do: stack_segments_for_compaction > 0. We could maybe avoid
> having a separate function like we do here and just expose
> `stack_segments_for_compaction()`.
>

We'd still need to expose a new function as
`stack_segments_for_compaction()` is still internal details to the
reftable backend, which we wouldn't want to expose externally. Users of
this function, should only need to know a boolean value wether the
backend needs to be optimized or not.

--000000000000fc6b540642b2b16d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e83d601d6eb216a6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSXo1b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUJnQy85TmsvZE1GYjdFMURqV29yNDZrd05RYVpPSgo0RXBOTWhBRnFD
QVN3b09PSWRjMFdTR041NXhkUlgvYTEzT1Z0bVpLc2FxWkhHaDdvbVJRejEzRndRanlWTVNDCnJh
bHpJZHdOVXpNdXUyc1BQYzhXcU1NWC9uR1IySkprQVJCWXdxUHppWWV5bWRTT2NsUFZCY0NGNU44
NnpDOSsKditEU2twckZnNHNPTkpUdFBjYUVjdkpicmNqcE1OOE0vdFdBM0xUMTYxUnlQL3BPNElK
NnYyVzZIMlI3RTNkRApDOXhxWFh3V3NJWFVxR05JYytTb29iNEY5MFh0ZmdCVjVYWUVJdnoySERE
dXJycUVLY3JLb08vckpTWFgxcTMvCnpuOG9vSXZiWG90UVpzM0Y0UnYza1RrdWxKMUNQcHpxdUV3
STRLNDdmN2JNdFkxR3l5QUxncDhLUmJHWGlSL0MKdjRqejN2dlpSQU55TTZ6eTViRjBEWk9aWkhU
Mk0rakVybGI1VnRlVm9QQmRCV3U5cDFCUzkrSXBaQXA4a1drQgowTUNCeWtUNW9iN3RMMDlzT0w3
clJXcUZFeTMzMXBWSWIwUXdyUk5ubEx0d0N6SEpGbU12dDFWd29QZXFzUVB6CnQvNWVLT3JFV0F2
b0M4QzArQ1pueS9MM01mWWNxck04bU1lbDFwZz0KPVo3dDIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fc6b540642b2b16d--
