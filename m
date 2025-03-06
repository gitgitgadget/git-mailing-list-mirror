Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CC2101AB
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275172; cv=none; b=FyUHKTxCDsaLCc9lhL0siAojymToleQpGic4S1TIr7GquJEf/KQKIJI1AeYoCwXRR90uI9opwEmlEYU/6u2TyOiuOx+XTIbyGGUNkHXSGzsrfk+qUAT1z/thFgjE8o9sJK9SF8BYHcDLzpxHb3ClTcMZ1TsQDMCJTYR5h7MKSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275172; c=relaxed/simple;
	bh=D6hg3jC9+WtrZz2SLWkWtsM4tgQNoAWOgh883jmXVwI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJ7dyCV29MHdnCkpajOAPj6IizfK6rg8VilmeozQBCOnvm8nw0fsCMCl4bdBcQvlnvxU8WHS0xvNKpzFVg+BzsOlfDJDHeTrOmCabjLpcfoG+uVLYoM+V7AFgOCxy+Ozb7v8TmFfrJWsje29A18+1O4kRMfOfSBRYSh5AHkhkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRKgOKGf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRKgOKGf"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e89a2501a0so7034186d6.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741275170; x=1741879970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4s6rfICiODJdEmiSuoEUe4XpJVoMjbd3muBSEv1BVQ=;
        b=VRKgOKGf/7HT1hztAmcdyVyuaG3nrtrDOh+GWfZGkqjtfrMdtiP8w/ZPc4fJG0OwS1
         xNZpGJc2aGy+1VDcUHVHIt2feoGNo+I4fRZZsRh75FpAYmG1w6Wb0KyITBGYMhJ7FRrE
         SsTBAYbDFzq8ts3PCNoyJYIAc4ShF0bZbPouTb8pEhjcMU5DI2YoKiEoWyy77dYTvrPR
         vdyNQceIWc4Wefp5KwJGzkvntjb0muCYwtNRmGZsv9/2TZf8AB/x/ogrVE+ycC9RBBdq
         9HlaBwQ0LsaaGV/ITVgZjmhnBPB4rxkqJbZnVCwGyrkM11y7OtyQJoipw7hPh0PRovGj
         bzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275170; x=1741879970;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4s6rfICiODJdEmiSuoEUe4XpJVoMjbd3muBSEv1BVQ=;
        b=gi2gb/tcjRNyNbcVi7lOrzPTvoOiDyp7wlysOJTwC0b7eee9+eKV/Eiu/EyLOxDNES
         jhohJQl+v8UMV1wJ6/sOYYHB80Vly6JkwJJ7w6/tcLM8037N8RWhnOu6GkAt7iDg/IQw
         OWU59DFXJO+hX14m/UeRtkCpF6DXsbd/+eedlENK94Bl9zWXpQWPkAp3Maycplq6IkAQ
         2aQWhA0AQAWbDhFwZUPUjn+CzWI1TUF1/InDnU4CrVn5y1BHIas8a6+8Luy+g9Aenre4
         KzcYYlUpIe5mz9lYlyDYR9UWznwdqg91Ud40rxSUImVRpsVA5XYtDfFsraf+9nz2MCdt
         Slcg==
X-Forwarded-Encrypted: i=1; AJvYcCWAOhIgif9Y3/FwdZsZxJXM/ybfL0c7olVCvvO9l2qiRngH2UJvoDiePLyz4N70fP4IVac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS56tvv/1+kNAnknefzMmJ+RzSK2xt5uSsy6ieKnVf2wTv1LZX
	SZKNF7Y9GiaoEGHfyglvOEPvaJxqW/SM7JLfChfVdDTCXrTLi08UxTSjiEKgX+tE676GYjbiiC+
	6ByootCqYBTW3oaGeIDze4n/LIqI=
X-Gm-Gg: ASbGncvdADxE+pRqz/w02jjE+KhdN3wZBtK9u61EilS6KMAN8P6QyAEu/calh6mfXtI
	jqST4s+FmSAOjrAdcW+aBVi0Masf2UI3eksQdSfs8ggAS3FiChF6yAAb1lFTxPUW1tfZ9UfyTXK
	bMOlC9KfOxUeZzB4Fg+lXT7I+O
X-Google-Smtp-Source: AGHT+IGihs7NfyxVc29qVQiZ0zwWkck4K6y0pjUAUF7uUyyfqu13mmw2p80zsgaL8aW5qNVxYSkuYQrWLWBKS3yidjo=
X-Received: by 2002:ad4:5f48:0:b0:6e4:7307:51af with SMTP id
 6a1803df08f44-6e8e6dd3eb4mr127019736d6.36.1741275169605; Thu, 06 Mar 2025
 07:32:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 09:32:48 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im> <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 09:32:48 -0600
X-Gm-Features: AQ5f1Jr_q7b8KZUb1pZvI8twypphg2xcBKkZ3ceala6ETJtqSFpo6gVOczMYGLs
Message-ID: <CAOLa=ZSUDq+uqBhbpf00k4i=mT9D8VFzjyR_a7K=3UzRiNj8eQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] refs: batch refname availability checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000f11580062fae375e"

--000000000000f11580062fae375e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> Changes in v5:
>   - Improve a couple of commit messages.
>   - Align `GET_OID_*` flag values.
>   - Link to v4: https://lore.kernel.org/r/20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im
>

The range-diff looks good (snipped to keep my email small and direct).
Thanks for addressing the comments!

Karthik

[snip]

--000000000000f11580062fae375e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: de1b68c81c42525d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSndCOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3JDQy93SUdpcllzbHpLdVdPbTdVNlZUbVNZU2I0YQptMkFGTVJHdUVo
M25sZXEyVmFYa2lMdHZvWnpmeDY4UCtuQzdlYnFVbk5zL3c5bHY0ME5td2piTk9QcHV5MmdjCjdw
ME1OMjdmRnpuaDZuYkR1WnVzcmFZcWhDSWl5R01YSGpoTVptNlBXcE1jK3NBN2FudkdQMlFycE1C
M1I5NWsKWUNPbDROWldqU2cwdkd4L1pralgxcCt0R1kxU3krT1JxTUIzNVJxRXpod1crYjcxa2Js
eWZrdnpxWm9LOG8vUAp3c3ZxUWZHWkNDajF2clRmQU53bGtjaWd1TVBuSm96RWxoNjJFTzZJa3lL
eXRidlI1WWg2MCtSOUpEQ0tnQmt0CmJTbzZRY0Z1S0ZCN25ZWFVJYlF5b0Y1UzN3RWZkekNqWjB1
cTc4UjB0RUhrRG4ySGhKMWxqNXJNMGNXZE5tbGMKakFGczlVeTFwNWVCYzhvTDlySnZKVVIvTURV
TThEcFh6Nm9YTmRqUENGdXJYWEhTenpDOG50ZmdKOGVJVU9vQwpYUlFBQnFHaS9zZDEvZmQzNXFW
dEM3YlhGZVZVS2pKOVRpUllGRU1GK0ZsY2diaEN0emlFSnFScjFxUXhZaW1QCjBvMEl3WThPdzJp
RjhzWStHMXBJb1dKYmgzRDg4MFVVT2pCc1ZQZz0KPW9pOVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f11580062fae375e--
