Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16831CA46
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186816; cv=none; b=CyMMa8Ng0jvwBmL+yuM1i/TPmCEz0VVCle6KB70Ku5MwLMPYWGl+grX1glH7C5NRMAopikZwVNk/wJt4EJm8Ch9bXLou0gPDpy3mECdo3rzQMohECWczP2/JRq+1cK+5kpqcsVJ5X0MoknetcHCw8A2pOJOJ/2JZu46Qtzhm8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186816; c=relaxed/simple;
	bh=vbcbIMq9By/lbQ3fm5NPoPUk34amZIDJbA3D/4Kba5s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NccbLcEZqV7nwpAfx7RA6Oaq5/g1WixJM5lXVbIE6eXLfIubxiw5MKT7jqafN79S4U0pSsCBnX3XJnhlve2wxy7f4LQ9DKvDExplpAZnEmwZ1/9BAZlYvYMXe5ixBWkqokj9oSg14J4Yk5Bd2UGgn2K4Cvaq1DXOqXTOgnaK+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Uy/TZY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Uy/TZY"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-559754a3047so145019e0c.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186812; x=1762791612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVUh7V1PbUoOF8O7+M2W9pPYgqCU3kEC7XdZbQOAN+A=;
        b=A/Uy/TZYE52kP2Bq6ECbRgIiaXQdCsCA/ClpCE0bJUh4xGabdUg5OcBRzxaN7F3ns6
         xc4uk8wLF0zoCZIAfomEAsM/qyK7ZLeKQ7E6WxYLhfa4yTFYydDnSarnHI4kl3iFzYBY
         BSV7LN3nJYlH+X8l5PkGKVLS42CYw6E4JeP3tbBlx/prg3SGxcUurQVZzd7e2z/edMkZ
         HSdGyTrej25yygWGyaU/PkdXFFONYaG4nizUGyD0M+FxkX9Gr0cYE7GQgmry7fWSvzwa
         /weOwcHL3XrSeTsikwMM80a/rVt3pctyNoaNSL+NOmMtLlaNWbziLf4uiwiEglbFmgMB
         mlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186812; x=1762791612;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVUh7V1PbUoOF8O7+M2W9pPYgqCU3kEC7XdZbQOAN+A=;
        b=NHfJ/kKCPbYbCy4zv84WpY7fOIM9ndBVXWACtisrZGT5U7B0Rj7E8Rhyx8W6GNg1eA
         RLjxATNO6FBJUumUYvxRfNMHPiwU8oe8ZnKgVSAc1zTvy8cXdY2DzsEXYZ+r5WxdM/TX
         NE5EQRRE7X/xZ7bXye2E6nMn6aouDD1ZRxp03L9ffnZEvRYD3tnvi7/D2OjuY0BfLB6k
         fGCaweMnGjKpcwliUL+nUneOm/m5Py+LuCDaWlnpz0CIGNG1ZM12Fic+pvLbKgJkfavI
         aZAYQxlGK7xXQD6OyT1I6z5KW9JzbVVe2+RrVyfGbhpMj67RBkjB/eA2aKV41pOwjwC8
         B/HA==
X-Gm-Message-State: AOJu0YzBHz/58KaZKUeulzX8kaOrBJQZ/j5MkqKgCQ96QtrhqloF+tLm
	Ru2cZvCFS+jyzp3Q29I+rW71556NF7Uk0cau+/nlSSs32dvDVefpV4ZWznSqU+FD6dPN/zWfKxm
	h2pQHFLZfPOpWfetzLbAsK4J7bSfqCuQ=
X-Gm-Gg: ASbGnctyiASel9Gwmx8kl48NGMh91zWUM1uVBz1OZGUXwCQXYjfmERDVmE/FWkoLHZ9
	tP+CgdKn7zYoI/AsvQ1DVM/nNM+rR1A1IoRf02QVcUM45rIlFxUW/kqtg3R0Q4neq/Y+tqd7v3l
	odfFEVwVhUtVz2WXtd/Wq7tXHqBY3xo5k923qwp/UyDaTeujBjgyuArLAd987XNsi61+felz1my
	XzsqHgSmOZTpO3nsHvY6uIIU/UxPYSTh+DWLB3THveYnEwqpmY5lCmP7+9ecsavi2E4IcUFSuol
	ueieUytnZitInVaPa5z+jkZOSw==
X-Google-Smtp-Source: AGHT+IE5kPwgvzpkYFOY+VwGxm+/PMErmO8XKJCkWSx9oiR3a5IQy4/JAwFP/P8V233bnioOetMhmUgzyAVSATsvPqM=
X-Received: by 2002:a05:6122:2888:b0:54a:a3b1:db63 with SMTP id
 71dfb90a1353d-5593e4297cbmr4611487e0c.6.1762186811687; Mon, 03 Nov 2025
 08:20:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 08:20:10 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 08:20:10 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqseez0wcs.fsf@gitster.g>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
 <tdgxvocyp2armupgbti2wnbjphdvidooddbdyrynmdokjgqr3o@tzrbu5lcgipt> <xmqqseez0wcs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 08:20:10 -0800
X-Gm-Features: AWmQ_bn87Z7sIPt4CtuKir5htVBVuoLIss8PbjQDNC_20iJe5Ct1_4GEMvpWRNI
Message-ID: <CAOLa=ZRywiKbsdAZYzVqGUKO1NBPz3iBhcjch9KFq72eZvUoPw@mail.gmail.com>
Subject: Re: [PATCH 2/5] reftable/stack: add function to check if optimization
 is required
To: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f086b30642b3168f"

--000000000000f086b30642b3168f
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>>> +	err = stack_segments_for_compaction(st, &seg);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	*required = segment_size(&seg) > 0;
>>
>> As mentioned on the previous patch, I wonder if we could just return the
>> number of tables in the compaction segment as part of
>> `stack_segments_for_compaction()`. A negative value could indicate an
>> error. All other values would reflect the number of tables to be
>> compacted.
>>
>> This way callers interested in whether compaction should be performed
>> could just do: stack_segments_for_compaction > 0. We could maybe avoid
>> having a separate function like we do here and just expose
>> `stack_segments_for_compaction()`.
>
> Is the cost of compacting a single table expected to be roughly the
> same across tables?  The number of tables to be compacted would not
> be a useful information to help making a better decision otherwise,
> so I am guessing that it is the underlying assumption the above
> suggestion comes from.

It would be sufficient information to know whether or not we can
compact. But only when in 'git refs optimize --auto' mode.

--000000000000f086b30642b3168f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 304f26b13b9df09_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSTFqY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHFCQy80Z1dqWnB1NzlvdkhROEVxZVAvSGhlRHA5RwphWStSUWxjTk9W
QWpTM2FnSjNQWHVzUEJvQXk3dTd4VGkrYTUvMVJBUjZEV3YvMTR1R3V2S0pGSXdQcVBVRDRTCm5T
eFFuTVA4NitGWFR4VGxiaGtkTWVXUG92WHphWHB4QThNZVc2eDI5QkhFdS9kQnZZZkVLSTlPUVdS
TXJVSzIKTmZGTXR3U2VESDkvTE4yajd1SSthUDF2VFRJQnN1c05RSFU0S2xPZ1lBNjVPdjN4MEpG
em1vM2lDc0dwL1RrTwpZODM0dWpEY28wTmJMV3lTMFdaM0dkVGhlNEdnTFFOT0VrRFltcEJYanRk
QUNtRW8wY216djF4aWY2Qkp5ZDJiCkZKc0VpYThjcDdLWTFJNTlyUHNnSmZRcGFEcU14anZTMWFO
NUpSS1pkTTlLNXdLOWJ4ZXdmUU1RcnNER3ltdHkKR2ZuM0YzdnFvbTBscWlzcXRvSHB3QVIwa3d4
ajEwSXlHTU0xMTZzRDBsUVlOSjVCM2M1RmdUUUpGSzArWDg2UwphMmRWQWQvRHI1bGV1VEo1aGIx
dmN3ZURYT2FHd3dFYUpKQjQ5YmhENEQwWml2VzhRTXdYNEpzeWxCOXptVHJKCkc4emVJNTdJYy92
WU84VXFXaXQvMUQydTdLbjhaRnRxbmFzSW0vQT0KPVIyVUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f086b30642b3168f--
