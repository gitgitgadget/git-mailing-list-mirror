Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95432DF716
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712812; cv=none; b=h+D0Cgb1P4W4VKvtxFtcZuRUHjiPBs0wuzqOoHXcdzRZah4oRDQbSkTLbQ3QJ2kuh83ujvHAQRmaWDtpRHVg7B7UYVUJrj8lsjyW1Fu77/DUn9EFPoGuYt2MMTZsy/RntQW9fTZk7746umqcmHwHi97aTdlrODxOFMcr0D0tFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712812; c=relaxed/simple;
	bh=jWalMiH5E9ByZUU2XGLr5tRbkGCRqep73iyhrrSgcII=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYLJ6I+b3kji2XABhbOHfY6kln6nXkWMXYi9wmVt24FgZ7zyoOKupEG0qoAwS0yH4GDGK1PfIpb8hEm2YHEf0Sl3OsHuNm1XHlQLk+/zIZkTAkcq1LKNMLZVQwhJowtLFuHIhdpiiS+hLSPOE7iywTfRC5lVKs+IOOHxjKha2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEZG92g/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEZG92g/"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so2289420e0c.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758712809; x=1759317609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SnJ092iOQb3oFUcNU/CGy93BeTiYRWcx8TZ1tRLocYw=;
        b=ZEZG92g/u6PttBidTLcKhOJNg6abptyezKDXiSSo/+rCzHYaMfSSKjV4gw4Td5VczV
         O2wU+nk5ITexkEXTFpvgG96/VCOdgABOLgoE5g299ZXgriKvIwkO7wjuBON0Bebp8r8v
         Wihm+546Z7xIDdIskPPHCBo3yhZGn5dOdDG+V61w+A3PJg/eENW8GNdGQ8nia9vcH5Wm
         PSO/M/hrcF0RsDje4r/3Jv7hMq33X2QWiCUfsOEdeJIomPL81gmzY5ItFdAbzLZHfYg2
         dZIf37Fj2gm5vB+zzsFz7rXx6pjGCe0N2bj92sNcvL3yS6gGv9NxNY0450wQ27XIgPR9
         djjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758712809; x=1759317609;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnJ092iOQb3oFUcNU/CGy93BeTiYRWcx8TZ1tRLocYw=;
        b=EIbkpriFKGVLm4P7RPszIdxPss1IfU7kLcp5IRZHVOSyj+EdmEfJYygWIjwJ4d5KwA
         X5fir6HDk5luCIjoc3QAJw+ZTKAFIBASmfGuGa1h3q+gNn0ZSUYfmPp8DFSN29u0tYld
         6/kuM01zpJ2TG0gRFHSnCsu8j4vwkd3KPNMIHP2nWec79pJvS4Dl4QLnBQ0qW3GmSKD/
         wDFhXi+OBGaGqVKkQRGC1SM8zKTi1X3jdL5X/lzXCmeLrOFoyvxmLmxht3b4tWHtpfIs
         lErfbNjuwfYjIczV5vTDtd/zjaFQr3YSnUivg8SO5+DgkV/5VTFF1ZCnBidXwmSjMkKJ
         AWgQ==
X-Gm-Message-State: AOJu0YzUlzjtvnRhpaZBOAeBNYYcsHqvZYyKk2drwtrNbChkSVnhnGDx
	IKMr0FRTDQjPmtBkFDEaxtOHtUcsSnqMcyYGKP3TFG/e7HVz2ItbuP632sapx1VrHmHJHagweWh
	mdPJh0l4gtw4rVmPBHKlkGH/4l3kWr2Y=
X-Gm-Gg: ASbGncuMEpwxvZ4/uIB7R7Vucau7e9odflUUVunAOqCiyLZ93R33gzE64iZxoUXDKkY
	FhPNlTM3bhg/FX/6+b6Y4sZvJSCfyqgohY9D78vPpY5pB46/jyioCh/tVWD9xCY/hB+gRxbNyez
	EKvXuYi0Z/rBbSDz+daU7PEieYEcCVSfxcjyVECi2iansPdq6gWalLvPi4FopuT4ZrzuPYjrBgf
	24JBSmF5AazU2HEOoJzEp3AKb8j1QfZ68wOsE3wRA==
X-Google-Smtp-Source: AGHT+IGrRNXvHgPInO4OWvmSkN+pASQsWMEjbxgJM/eA9SXzl2UKbwm9gGit8ctXQQZ/IM5cgkN8WKbJd7Jgw98sA9U=
X-Received: by 2002:a05:6122:902:b0:537:b2b6:e387 with SMTP id
 71dfb90a1353d-54bcae67ef5mr1960256e0c.6.1758712808629; Wed, 24 Sep 2025
 04:20:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 04:20:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 04:20:07 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aNOHl65jYyoNXou_@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>
 <aNOHl65jYyoNXou_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Sep 2025 04:20:07 -0700
X-Gm-Features: AS18NWA581lt7_P6A_j4M9131jIXNAoabRgqbIgRoDILGfZA1ZxMqctpbI-hzUM
Message-ID: <CAOLa=ZTf7KL23+=Fggfg=4LXt1Dsd6nRCFg3q_Dhuom2Bk+L7A@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] reftable: ensure tables in a stack use sequential
 update indices
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="00000000000038870f063f8a3cea"

--00000000000038870f063f8a3cea
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 18, 2025 at 10:11:45AM +0200, Karthik Nayak wrote:
>> diff --git a/reftable/stack.c b/reftable/stack.c
>> index 955be1edb6..a458f5a4c5 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -317,6 +318,14 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
>>
>>  		new_tables[new_tables_len] = table;
>>  		new_tables_len++;
>> +
>> +		/* table's update indices must be sequential */
>
> Let's make this a full sentence starting with an upper-case letter and a
> period.
>
>> +		if (prev_table && (prev_table->max_update_index != table->min_update_index - 1)) {
>
> I wonder whether this check is too strict. It _must_ be true that the
> new table's minimum update index is greater than the previous table's
> maximum update index. But in theory, there is no reason why there cannot
> be a gap between those.
>
> The reason why this makes me a bit uneasy is stack compaction. Say we
> have three different tables:
>
>   - A base table with record r1 with update index 1.
>   - A second table with record r2 with update index 2.
>   - A third table with a deletion record d(r2) and a new record r3 with
>     update index 3.
>
> Now if we compact the second and the third table, the compaction will
> realize that r2 is deleted and thus no longer needs to be part of the
> compacted table. So the new state is:
>
>   - A base table with record r1 and update index r1.
>   - The compacted table with record r3 with update index 3.
>

That's a good counter example. I didn't know this was possible with the
reftable format. From 'reftable/stack.c: stack_compact_locked()', we
use the min,max index from the first, last table being compacted for the
table name.

  err = format_name(&next_name,
reftable_table_min_update_index(st->tables[first]),
			  reftable_table_max_update_index(st->tables[last]));

we also set the writer's limit in 'reftable/stack.c:
stack_write_compact()' similarly, which sets the min,max index for the
writer:

  err = reftable_writer_set_limits(wr, st->tables[first]->min_update_index,
					 st->tables[last]->max_update_index);



> I'm not too certain how the minimum update index of that second table
> would be encoded in the header. In theory, both minimum and maximum
> update index of that table could truthfully be 3, and the result would
> still be both valid and sensible. The new check you introduce would
> trigger though, as there now is a gap between those two tables.
>
> So I think we should loosen that condition to ensure that we have proper
> ordering of update indices, but not a gapless order.
>
> Patrick

So currently it does seem like our implementation, still uses the first
and last table's indices to set the min,max index of the new table.

However, I think your point  holds. I do think eventually we could
optimize this to ensure that we do something like you described.

I will make changes accordingly.

--00000000000038870f063f8a3cea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1bb88600e01ab38e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qVDArWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1llQy85V3M2bDlNUHNaMGs3ckxzVVQ3M0pwc1NNRwpHMERoR05zbmw1
T2NsZ3FLaExjK0k1MW5nc29ObVRncE4ydGVlOWNqMWRSNXhnMzQ5c2lCbzhESkQwZHRURjNHCjNk
czlFUW9RNVNycUJKTFo2ZUZ2RHBwUFAwU3FTNm5jTjZsL29yeHV5b1NMdDFIclpxajNnUkJiQmM1
YlYvSU4KQk15T0Y3VnZuY2p3WFBYNTFQR0hZb0J2eDFCdy9XaFcxN1VjYVdwSDZYZ0hzY0Z3cVBQ
TmNUc2t5N1VDeW1JbQp1dXdlOUJNcU5wWldMcFFaSTN1NEZiZkRQdjFZVnJtVXMzRkNXOVgrSXlu
RHRNR1JtMlE0RXExV2Z6ZU1rTUVICkVjVUFJQ0dCRm1MUWtVMW9XVlNMZlVWNDByQ1owMG0yUkgv
Y3VIRTBxMFJtVjFqQXlFOHlKem15aUt4L010NGcKbG1WcFdRbUFKV2Zmd1FyTnV1djQzTGJEeHU1
cFV2WHlCeWcrUmVnMnRXRUdHZGhnb2pEL1Y4Mnp4UEdXSWdFMQpYcUl3U05vVWRjYnM1OEhsN0Ru
UEh1WEJTU0Z0ZllTSThXNWZueG1KOEx0SkZTWkg0R0EzOXpGUlBORWxHdG5JCmMvQzZ5ZWxMaUxG
SExUZTZlYkh1RkZnZHJhaFBJeWVyRVJrRlU2az0KPWI1b0MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000038870f063f8a3cea--
