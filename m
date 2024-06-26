Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564817F51D
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403163; cv=none; b=Sjj6nfjwWmqVwlu5vs0pm2OazrQvsAmpM3d/J99BKzrTWZt9DKh971NiR0/CVVp4fafxVx//YcBm0CxpAtPsGoay2yyCAwc0x0u4h9pGYeGVKw96PI/wdOGAWGdJJn3adbwAdDFJwVt0BVR5l/an/aQ4ug1A/bdOZKTkvz0xnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403163; c=relaxed/simple;
	bh=cXQg85y+eeBwuD/tSccSIkfCpvmUSWVs0fZXnyN2g5g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVdzGzCR0qbiBQEVSsYxhZq03Y9E6NqiPW3ODxrUV11SpfaYukYkeq4gy9ZQX4X+yVmoJ8K3739uGvnadD2Wp6jkPDwJgm7kVY/NfU2GCw54QGnqTE7vNzmsueUUidxGj7ghNjtrRBwAtEcXVIIlwbHJ0F1ODtjSsek+aqN/eEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI8LWLlr; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI8LWLlr"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c224424a8bso204881eaf.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719403161; x=1720007961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXQg85y+eeBwuD/tSccSIkfCpvmUSWVs0fZXnyN2g5g=;
        b=nI8LWLlryhKLtwLDq4KIvIGu52vGfH2SVlXbiI8vE5sDGPRvPw+1X7aR1zeOcABK+f
         QJmDwQBKuzX4JgjC2W6LTPAdQ1QPi5yst/X4/dgYNWl1nptjzbpM5nn/t9+qNtx4kK+c
         lOEhIsNf1n08leEJV8/lwKj+DPDt232jlOcXB3+3y4A3IetdxvqhBdmeYQvfyV8Z8uta
         PrBipNk7Epfy7f5e8xi6JNg8yUKBnCeWs0ZRnGaO7PjmqOIoO3Qp4ezltSNM1nBMuo5A
         BnbjoOAXR8lugHKNsuKkQUgayUixIfWNZMGquRO6x3QUoAOt7VjLuaQnvRw9mwYMXV+h
         jT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719403161; x=1720007961;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXQg85y+eeBwuD/tSccSIkfCpvmUSWVs0fZXnyN2g5g=;
        b=GP3nLSpCj9TQdY6Yr94SQX7PhY+o8MNNYOII+oBfQ+ni0BfxdSxarF0mVdxWpLeSJm
         s+q9fTWKBR9lzGbP36JEsR8yMgN6sibr+UvJU5MDb9W15NENOf8VDtIfxogYRBNHW2yd
         9BZ68xYJbnkupSfgxxywzCAt7OV22XTTCAvj2NlmekM98Z3Wosa4EC5hJ1RwOU7WbE2n
         OoBVjOLQcrwEoHY57+8Y8eXarJIUD6TAru7ihqqUBFKVGlz8kxv+K0BoepFYZkAr7SA4
         XpobG1RWVcgV2wTCHPQyDCjpZnV2e25ji1XWUui+1b27bdLGb01zXwkTIQkaatUNlMw6
         SCmw==
X-Gm-Message-State: AOJu0Yz4fQH7a7YEz0Z0SjNfAHofdGIh4RVKl17ScUk0y0AdAPCkWcBH
	8HzM4ZPyuhVN+9kNJpJ7E6so6msD8xejVz6HV0Vt7GjCCc3vTwZBkBzMl/qkUXIGvgwZYosMlQ/
	R8wnQIPT260FkFXOAy6DLa60SopNtomPH
X-Google-Smtp-Source: AGHT+IHGOVxSsLioU3EB/XKJdsIRWtzzG5YNFi0F0CVkCShMxWbwtirItCxJX0ZPV/u5e9tu76yjSL9KwwkSxd2ntjU=
X-Received: by 2002:a05:6870:558a:b0:25c:a044:bbd8 with SMTP id
 586e51a60fabf-25cf8c5f7camr4462716fac.22.1719403160791; Wed, 26 Jun 2024
 04:59:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 07:59:20 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+J6zkQ4z6AWsy2uxMQfmtjqN0b_i1njR_a5agcQrnd4o6tmsw@mail.gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-10-chandrapratap3519@gmail.com>
 <CAOLa=ZRTwCvuRFCrHoK9f+zaKqz-Bb2HNAqpD_1y3tPYgrvatA@mail.gmail.com> <CA+J6zkQ4z6AWsy2uxMQfmtjqN0b_i1njR_a5agcQrnd4o6tmsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Jun 2024 07:59:20 -0400
Message-ID: <CAOLa=ZRqPDicF+vPgRifntz1AKASTooToBzSd6v5bb1hSOOc3Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] t-reftable-record: add index tests for reftable_record_is_deletion()
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000a00af4061bc9be26"

--000000000000a00af4061bc9be26
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Tue, 25 Jun 2024 at 14:49, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>>
>> > reftable_record_is_deletion() is a function defined in
>> > reftable/record.{c, h} that determines whether a record is of
>> > type deletion or not. In the current testing setup, this function
>>
>> Nit: 'In the current testing setup' holds true for the series, but on a
>> commit level, this statement needs to be modified with each tackled
>> type.
>
> I'm not quite sure I follow. Could you explain this a bit further?

Patch 06/11 says "In the current testing setup, this function is left
untested for all the four record types (ref, log, obj, index)." then it
proceeds to add tests for the 'index' type.

However 07/11 still says "In the current testing setup, this function is
left untested for all the four record types (ref, log, obj, index).",
which is no longer the state. Since we tackled 'index' in the previous
commit. So forth for the next two commits.

--000000000000a00af4061bc9be26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e82fb39308c31e2f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aOEFwY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3RXQy9vQ05xY01Yb201VUpocEVJNlRUeW5CMGIvRQpkY21heEJCWTQ1
eXRXdklMY0RRTzBFZ2s0aXNwaWNnWkpFcjNaSEozdDhBeUtpa1NUcUlaK2JubVNKcEZvaXdhCnVl
ZnloTEpNNnZoMmt4UStKbjFLeXE1NEZKWWRMVFhpQk9SaWF4eTNQODhtRGR1TXRaY3ZHb3Q0MFps
Z0JySGoKVkRBZVJmYXJlNFdtV0x4STRBVnViZU1NcWlkSFZ4cmhBenpaaGoyTnYwaTk0eVVzNWlo
U0RnTS9ubTRLcFpYSQpxK0FDcGpCMGcvNFhrRmt0akNSS3pTTEc2dktEeFJZWDJ0enpGa1liZWd1
SHkrZ3N4b2NTMjVtMWhjV3BabktyCnV5S09ycEd4UkU5TWZ0Y1RkOFNjbC94L0l6MEFvdlgyMDFh
azNQQVc1SythaTM1NFM2RUxGMGc3U25SQ1A5RFQKTmlFR2JYdWhRS28rZUp0RVVMaDBnYlZ4QjZ6
dEZmY0JVYyt4cS93cEVKcGxqWTU5QWVUSkhFYldiTzZKUlFmZQpURUE2YWpWdW1CUDlyY25sa1hI
RURZQVNWODNLSjh2VlZTUXQ1b3d0T2QrUHlxWU1GSEUram54OTVYbnRqdHhtCkEwR2ltY3FqTUVz
Wnlmdm5iSnNGTUw5MzdMT0RDK0x5bzFQY25FST0KPXRZVGcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a00af4061bc9be26--
