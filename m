Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7F2836B1
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182357; cv=none; b=Ghq7JlQJw1jU8od9M5iv8+dUq4Ftnfih8X4lZktdPQur7qFgHQZy6jePDams9DFm1F3opKUhwlT+VZfTrisn4k5KGwknSYsh4+mE5OVnGFa4rbJUQGIAEcTX4dXTyqkdqSMSDj8T9d1XTWcQuWVpuoekEkxNNb+iSdXyzwQoDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182357; c=relaxed/simple;
	bh=tbSMvYKje8OhKut6I7uOPhppv12PvFsy+9JWXYR1AMw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH9vmiE1atEPPH9nuRhY/0nbKLMMwR6D+WNuPgPoM4Y29ttUmlaBsrsSsYcHkxoDB3zYw2PJ6ibxv37WECjjvndwIl2FGGy30vX/8HPkdsktzu45XTvyj1d4luc8MT7bDX707PsPej5eFkCX1HJ+ED9TleUmpev65dbIG4KkvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chz7Bs3t; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chz7Bs3t"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so618794241.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 07:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762182355; x=1762787155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAP+56eHmW9bqKLGhMkJ7Z+xuLqGp049G0A66ii2tuo=;
        b=Chz7Bs3t7q8DUQL7wEyi5TqOD7JeLyC0CCs5+B/1pYJrEd/IkYahMOL3xzkdMXcVy6
         IEex5guAUSI6bwxZfpvqoIxNXl0cNZjJoLummLfDz+WOqS1w5tl5Af3flYIK47b5VwaQ
         zOqpWx31jFuZRWPyvu3VgLn2YNYqeMx+1yhGzTNA1dUu7tem4c0JZIU3uUYC0vpFf3eA
         QdG6ylqS9jpnsrArs/BWksLvIRTAFCj6SINH3nV+nG0j6T8C3hEXvzrN3vem7Eiw51Vl
         ICyxNOP0vX3e4N9E/EOBZ+ijeFHosohy1ievJxtIImhPKlmC0A2bRQ5F4mUw3LvfYpaP
         dKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182355; x=1762787155;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAP+56eHmW9bqKLGhMkJ7Z+xuLqGp049G0A66ii2tuo=;
        b=qvD1e0Lbd1YgSWdyPuckRuRGM28LDVkRAXDYvJuXEA3MgUSRJ8LlTw4Txi04GtnkrQ
         8hnUVMskbN2WFkSipPAzqlsI4BdynPO+ANUIOoaoBLZ5rrPCRQ6PyguCYhvl99+UaI88
         KAKtL0ObvzwKrn102sNFb5kvr2+NMxSQ0i2VY9DcCYTlHB48Wpm9PbGLSyq0+3bDpQs5
         yNTCF/ayEjgns7lmLXaslWsx9vJcQ4svH/oVLOozbSzJNpGZLZHSkG0GiYcmhMG6iGjn
         PMV06zOOdnOKj4sIW8+2fsB8CPry9sggsA0TIks1sO8zBlITMIg59CYsnALtoWFJT5Qy
         qWwA==
X-Gm-Message-State: AOJu0Yyh3dvPIDMRXQcfkyYd/qDOOQMlJJ8HAL/15g6ygQcUVB/YeXs7
	lRFgPlKhKdE7PHGP550LHldJubl0d5fXtXBrvYkkxc7/5mW56hvCneU7O5qQFlg79cVO8bOaDCW
	pLYu7Nz0wuKpcRl45TOVZkhrzgqhEiqqFcsHq
X-Gm-Gg: ASbGncuZZLqX/X5NXX5i33knvZi615aeBXNZWVlsih9Zweu1xhQWPn6u1rSigiLjqCz
	TQuzw917iBRDQLK00KIYVr5P2YiXlF4ggPOltf3Q1WPdYNRPGBjUxUQQDJMi3NU7Jv1hg9C4dVm
	WfE/mjfNO/gxqTkJAOhVQJBHUre8kKN65Y6ECEYJYTLK5TqbdOpeMlr7ECAgBKeHV0YXl/LT5sX
	zyNTdEZbvl6tPLxbBAhRUoJvCfkF7ZeKDqDf0lxY5VhQk0fg+f+gscKvu4jRkH+zEqEZj9mF00f
	ASuZFWvapKf5zRTU
X-Google-Smtp-Source: AGHT+IEN+/7iFLB1Jd3PYztvDuAXGCWhpyqcl81y5qutqLtmYu/pf2aJF0NznEh3EqR8pBifXJgNrlrNv1Ktd2m+0eg=
X-Received: by 2002:a05:6102:26ce:b0:5db:e32d:a3ff with SMTP id
 ada2fe7eead31-5dbe32daa95mr1113762137.19.1762182354529; Mon, 03 Nov 2025
 07:05:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 07:05:51 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 07:05:51 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7gjrsjgi32akawqwcamzil2rblqelfvgmrxmgef5ssrslntmc6@43cra6zhledc>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-1-a03d53e28d0e@gmail.com>
 <7gjrsjgi32akawqwcamzil2rblqelfvgmrxmgef5ssrslntmc6@43cra6zhledc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 07:05:51 -0800
X-Gm-Features: AWmQ_bm0BqK6VpqjwgR3jkhfbM0U0ApqWkFI6yWWk8xLtoLUba-dDY1EiZD64lI
Message-ID: <CAOLa=ZQa21A+fF=ukZMmx3zu1DrMFU-EcZGrZConS-L16+ih1A@mail.gmail.com>
Subject: Re: [PATCH 1/5] reftable/stack: return stack segments directly
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000459a9f0642b20d2f"

--000000000000459a9f0642b20d2f
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

>>
>>  	if (segment_size(&seg) > 0)
>>  		return stack_compact_range(st, seg.start, seg.end - 1,
>
> Do we expect the errors returned by `stack_segments_for_compaction()` to
> always be negative? If so, I wonder if we should also have it return the
> number of tables in the segment. That way it could also handle the
> followup `segment_size()`.
>

Currently yes, since all 'REFTABLE_<error>' errors return negative
value. But I must say I'm not a fan of combining errors and values
together in a single return. This only creates confusion.

I'm not sure removing `segment_size()` is also a good idea, because it
describes what the check is. Otherwise we're looking at something like:

@@ -1655,11 +1646,10 @@ int reftable_stack_auto_compact(struct
reftable_stack *st)
 	if (st->merged->tables_len < 2)
 		return 0;

-	err = stack_segments_for_compaction(st, &seg);
-	if (err)
+	err_or_stack_size = stack_segments_for_compaction(st, &seg);
+	if (err_or_stack_size < 0)
 		return err;
-
-	if (segment_size(&seg) > 0)
+	else if (err_or_stack_size > 0)
 		return stack_compact_range(st, seg.start, seg.end - 1,
 					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);

I'm not sure that this would be better? Or am I missing something?

--000000000000459a9f0642b20d2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 149bc95cbe15af87_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSXhNY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejB0Qy85K1MxeS8vSHYrU2pjbSs4WEdwRndQejQvWApsSmJqRGRNN2tr
NGJrL0hmMDZBWEpuY0dQMTgyTmpoNE10dVNrV1E4NFhScDFXTzhKVE05aEpHTDVDNXJGU0Y5Cmhz
RjVOc1ZxMG4xRE5CZzN4cEY2OUVlTi9zaktYSUZxUElTUWdDTVFXV3RxejhacmNhbWg0MjB2RDk3
bUZ3L28KUVErUUpZL1ZVMjdIVnFrZGI2NG5IaTliU2NtUlovU0FxMzlhZGYvb09JalhyOEJBK2pP
MlAvS3lvS3JWdE5oUApLYktrbTZpaXRFWjdxejBoeXl2bVJQeHF1Q3pNNjN2UlZKN2E5U3VDcUUw
dWdZVDJEeE96eFVUWFl6Y1pHeGFKCkVpalNDY05jbi9PeUxTR3VGSU9RQkRpb3d1aDNTM0NPbHhM
SEVrSmkyN25hek1CQzhkN1JMWjZWM1B6Rnc3ZE4KVVNId21CSW5jR0ZvTUdtbGdkSjlhNjB5L3J4
Z3pKaExhV0Q2OGkvOUk5NG1aUEpuQ1BzT2Q4MHJPWUpVVWVqUAp0aUY5aXlONzV3Y1BmUjl3SWxi
U0lYdEc2anA3bUpmamw3aGs5Mkl5b3dBam5DS0s1bkgxYkxJUnhwWTdlcHowCkUzc1VZcDhYeDNP
TDdmV0hwTDUvYnVDOCtVTkFhRnMwbTNET2toND0KPXlUZ3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000459a9f0642b20d2f--
