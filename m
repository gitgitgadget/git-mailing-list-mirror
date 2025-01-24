Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AA156879
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733728; cv=none; b=HgZPbnpxQCrqXCGDOwAckfcZMt6Ot1ToFvB8MOzTAd5hPDachifh/vbbJhZr9OvGOl4q2+7uAF+jHAl43oXeJR8g31Raqq3+RJK9C5j/6vZ3zYZf6maO3c6dFe7hcRwFR5LqHonzOyM4Lqrmo+zRi0Wv1KAg1yoJdyNdIL7BS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733728; c=relaxed/simple;
	bh=+be89LEvD2jUHpBCrAYFHy5s4DOcEkGEtCwH7bGGhMc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyRvHcuf/8SiA3Tmyg1AtovKxmaPv+aEPJ4timFDvTSoXiXPimsjseXYi4FcPkw9IuMVCGOfmfkSWYWXw1wPidScK+hBpXNG83miooj4t8yInbgbaX6lBC6x6VQgV6/GGUX8i3MTfAodLUe28C/6CWy2/PmPiKOfNnlGay+Xoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMzhR99e; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMzhR99e"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-517aea3ee2aso1300708e0c.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 07:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737733724; x=1738338524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtQeZ7Jfcsa4kT7hBqNcHDJMKtquyd2o0nSxmh7ScT4=;
        b=XMzhR99ev8/+DYiNEGr7btDtcLBu6echy24kxM63eP91f8yFxGjMvjtB6X9rOrmHyf
         9TK0+s4qAK7NUBKV/7b7kChFviYsr/94QNTZKUWthaE1WTfKvBH746tNRbJaEEM8luic
         iTybj/1MiTLYfvCqQD8FrYd35BC/qNgNiwMfiGs4UXsUOMQUFMEcEHYYyOLtQkIKnpMy
         AgQ0z5yjJ3xDQ0cTTm+e5HMOqdtsAkZhAUeaN+CNFN55B8LyEtuVx79EBRiGgiAuRnnt
         DEJS/WwVymYwMiwR3ePbuPEDb0fX0JMdnpxAy+VljsFjQ+JeMFkJaeWryRmpORmdmE9L
         Hsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733724; x=1738338524;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtQeZ7Jfcsa4kT7hBqNcHDJMKtquyd2o0nSxmh7ScT4=;
        b=RcpezIZKNt5FZ0Vw2xveMbf+Dlt8uzxueSZ110dR5GDg2ITuGHU8p09yiAr1yhLnEF
         8YVqevZ/dxvDug5iSzSCZG1kv8YNYjdSW6mPOjsIu87WSdPVXX8xquQHBT/TBedagl9o
         W4wXfOdelS2TIIjCHqdzPZZofCvEn18rm+que78KSgFAylfoPlA1yhCP4tx4UVl2vOCj
         DOtSikjuzym6ofC4Unaa/pLpDwmPZlJH8tR4TKz4tMUwD2rcjyKptX9U80o0HiiJiyX7
         zEcjZLB6eXhywoxitGKJl36Ko6v/Wr5k6UQbJ3IKVn2MM1UKcbmYzYFRvkJdHhb/fpOt
         m5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVrwvqXmiA+V/OZMD++9bYsptZjutS3jp/HTZVH0/2lwJwuwD8MGLMGo4NolSa6FmUm03U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/np0Vp88P4i2udg719GeouQVSWIgUZwkMBoWmDbChU5CB6Dsx
	B6HR+er21GQyARknIID339erBk24gh2lPOHV3ffwfCvnhb9GdoVbsvuLzpN2+LULUtz2SxlgJAq
	RgXQdbwU2GauRiroZEZIa5XviFpw=
X-Gm-Gg: ASbGncuu3Hp3xelHANAyYO4i+fPCs0iDd5i8z+D02Ob3KYw/pi/YpcTv8G5fbdlnBwM
	vBElevwxLshpkH946HPJEN2RxEvbuhcoHeAwlksG+bAXgf6uopivrnVnbXM/suA==
X-Google-Smtp-Source: AGHT+IG74co7WpZ0/30e+RCer1fTPKrBaVE+LEh+zIfSDOyRtoYnHiC7tStigGh8ZH1sVXOUqzDWhKPLU4ZxWjt4k1c=
X-Received: by 2002:a05:6122:29c2:b0:50a:d1e3:82f7 with SMTP id
 71dfb90a1353d-51d5b33f74amr26141839e0c.8.1737733724526; Fri, 24 Jan 2025
 07:48:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jan 2025 07:48:43 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z5On1waE-2uwIjS2@pks.im>
References: <xmqq5xm5s80e.fsf@gitster.g> <20250124140203.886324-1-karthik.188@gmail.com>
 <Z5On1waE-2uwIjS2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jan 2025 07:48:43 -0800
X-Gm-Features: AWEUYZmBNALjDoak9xvooiwvi7iOUaZW5yTj-zZtjiEAYhendyHx8EsrDOGOAO8
Message-ID: <CAOLa=ZR=Hz+LU0n-uC2dpk8_sLqAyaxO0NswJH8bP_kEdDdbUQ@mail.gmail.com>
Subject: Re: [PATCH v3] refs: fix uninitialized memory access of `max_index`
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org, 
	sandals@crustytoothpaste.net
Content-Type: multipart/mixed; boundary="0000000000005dd67c062c75a9b5"

--0000000000005dd67c062c75a9b5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 24, 2025 at 03:02:03PM +0100, Karthik Nayak wrote:
>> When migrating reflogs between reference backends, maintaining the
>> original order of the reflog entries is crucial. To achieve this, an
>> `index` field is stored within the `ref_update` struct.
>>
>> In the reftable backend, before writing any references, the writer must
>> be configured with the minimum and maximum update index values. The
>> `max_update_index` is derived from the maximum `ref_update.index` value
>> in a transaction . The commit bc67b4ab5f (reftable: write correct
>> max_update_index to header, 2025-01-15) addressed this by propagating the
>> `max_update_index` value from the transaction to
>> `write_transaction_table_arg` and, ultimately, to
>> `reftable_writer_set_limits()`, which sets the min and max index for the
>> reftable writer.
>>
>> However, that commit introduced an issue:
>>
>>   - In `reftable_transaction_data`, which contains an array of
>>   `write_transaction_table_arg`, only the first element was assigned the
>>   `max_index` value.
>>
>> As a result, any elements beyond the first in the array contained
>> uninitialized `max_index`. The writer contains multiple elements of
>> `write_transaction_table_arg` to correspond to different worktrees being
>> written. This uninitialized value was later used to set the
>> `max_update_index` for the writer, potentially causing overflow or
>> undefined behavior.
>
> It reads a bit funny as a bulleted list with a single item, only. A
> suggestion for the above:
>
>     However, we only set the update index for the first
>     `write_transaction_table_arg`, even though there can be multiple
>     such arguments. This is the case when we write to multiple stacks in
>     a single transaction, e.g. when updating references in two different
>     worktrees at once. And, if so, we wouldn't have initialized the
>     update index for any but the first such argument. This uninitialized
>     value was later used to set the `max_update_index` for the writer,
>     potentially causing undefined behaviour.
>
> Other than that this is nicely described, and the fix looks reasonable,
> too.
>
> Patrick

Thanks Patrick for taking the time, this seems much better. Let me add
this in for the next version.

--0000000000005dd67c062c75a9b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6104f10339914aff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lVHRrUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdy9qQy85MDdLT1pTd05SSE5DUlVUWUtHdjZpY0xWegpqcUhsNEhhYUFy
QTF3bnAvbU5HUDR3Um1jNFZTcnBCaVc3SWtWbk1GRWtQMmozcGZiK1lqZlQvNzdZeGNwRHU0CkUx
SUVEcUZ3YVhDUm9QM3RSaUowVHhKcTFmb1VuZE5xQ29iM3RiQlZjNytUNDREWWIzTXFGRDRLcEJa
bmlsbVAKcUVoU3hwVTd5SXE5R0JUYWh5K1ZWQnVNQnF4aW54SWtKN0pLZDFOVXYxSmVOdGdHYTNK
VTFtMkFUWmx3NHVLVAoyZ3ZnRVYvejlVYUg3TVBNZFFteWdrS0hzSHpyUE9nekdHSkV2RlRtTS85
cDlXc1JYRitrOURrcGdZWS9YaWhkClAyYWNkSXdrVFg0N2ErMjV3aSszV1lSc0hNTDVTbXdEQktw
SzN6ellBclRLMUo2d0pXa0NKZEFLeVVzM05aQU8KQkQ2d1pUZitYZnFuWjdpMTNST1c1Tmw5NUdw
Zk01aDF2MzBheGVyK0liYTlIT0QrZStKU090cnZ0T3VLdmpqZQpXZjFIK3hlVmhqcyt6eHZVMUxQ
VnVMT1hwZ1VWVDJveld1M3NGalovTmNnMnBxU3lPNlNnQ1EwUU02L205MlJxCk8wVXhCOXN4UFY1
L0lybVRJaGJRQUpMa0d2bXlibDh0RUpOeGlHUT0KPVNUREsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005dd67c062c75a9b5--
