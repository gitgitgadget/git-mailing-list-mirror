Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39416DC08
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202909; cv=none; b=qgpq6YhJRL47Uv2n6FUFAsP5i4CHQLsielTSgCT+QjxdqJvlp62r29Ik8csELtrDWH3INB34x57p4w/rt5CogE2jlya15vmTvsZY8+HfsO7ZnAThAVU4x1nxFGHPaWv5QqDSnb3SDLjB5iyyf3j0QUCvtkPsXeD4b6O9mBAoe0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202909; c=relaxed/simple;
	bh=ZU3yi7kl9uIrDNEX4Y8TCsuaUqVSDpaHUghb4UUkAKk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELYYxM9z/tJONzX+zAdnJL5OaR3GmJXfgMNJtiptQXIkITwim/o6Skrwq681eiGEfPuC6n5d3zcEIUW1r5F/KTL6xFiW7g0x2mN1xPnX40WWMnrpm5tFvo+0tUt8xdyLnYNwpmJT1RZRfqYSbEMSGPIlA+C24U5voSH0Lfvat8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFPEM4dx; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFPEM4dx"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e24900a82so990947fac.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720202907; x=1720807707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4734zEJPasLRy3py3e3aTgXbLX846FG8TBHYXxuU2k=;
        b=jFPEM4dxvTTXLgIEiKcWmmKpfwCX54vGa1oYh2C5snDOlUwsXOmGvW5lNOJSB7Sy0m
         uxUUu/T0EevVNxqiYyb8dwZ6uWea6xG9/0UwcMwPcFPucLQzKrg0ZOKqHSxyL35nngWv
         v5l4RgXIx/IDunGeb1hmF1bGuttY/ki/vXhcH8Zg6jtY5hHnugiO2OqEi8aiiYbV8QCT
         0TCyTQcU4QxkHbJG/eMiIAWlK1R1NjKaTVt7pq6l/6fRaP4N7t2jIfSJ+ObDk/BLW2xJ
         jjcq+xx1vYAQ/DbQV7VnGPyTLt11RpQpC9wTGbMNkUgXpzbyzVy0Aw2/7FDUM3hVZyTh
         CS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720202907; x=1720807707;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4734zEJPasLRy3py3e3aTgXbLX846FG8TBHYXxuU2k=;
        b=d6KlpCZ3XtNc3hN5CAIEdNvpB2euLj9oqSt+T3Hv59TP4KX+lG+LWiEtVzbZx647V3
         Y5d2Kwm9eJoEsTNO55TnVd7ARiYOwMB2czJTEEu7fKwUxgaj9UWgTQgYoFd2YyKnvnwR
         yLf60bsNeJ/T5LdaoDPM9O182e/zfDmw0UOQt9ZuPbOHma4nB8Lpt/yW4y4Rn07i9Lbl
         8+/U/8OE1L73wPCEO1G+FAKL90fwkimzW3Y60ZLRZlQ9aXmjQ23sNMcoBulyZt9Xif91
         B4FC7YLXhEC6+dY5hAI7l4IXKCIGazAljh/oAaXoA0hAQzIznC7tD44xtyWidF9OijIx
         2wgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4UY3RWkjiSm88zBs3fvm+cqRmlxFFnMQSMmZlVUxWqE/Q/36d9cnuJzh/cczvONngCuDaxqJ9LgHjSRpA+YsPK6tz
X-Gm-Message-State: AOJu0Yy23jj1aqA8lb/mroC3BWzYCIvNRXcErAvJi2qXEIkpXlG3xR9V
	dcVdrH2G54txO+2Ym7kIwuxEPaBrW4OQEiI6maJh2jjS6rwn936A2tdiPRxSp7XkY3rAu/hYYN5
	Nq+14tns3VXDsaa+QqzlkrYb5ANM=
X-Google-Smtp-Source: AGHT+IF7SrpFgXDwr32oXW48/MejjYWirhNfutrDJDPiHHJpzUxC91IbaW+irtT4oUmr/JF9R4EU/xgAkYICFkEhOcY=
X-Received: by 2002:a05:6870:a687:b0:254:fa3c:97f9 with SMTP id
 586e51a60fabf-25e2ba212f1mr4237431fac.15.1720202907406; Fri, 05 Jul 2024
 11:08:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 14:08:26 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240703171131.3929-3-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com> <20240703171131.3929-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jul 2024 14:08:26 -0400
Message-ID: <CAOLa=ZTdH5YHxs3wOkO68CCoMQM1WOYFi4LpTuuDj11fCRqK9w@mail.gmail.com>
Subject: Re: [PATCH 2/5] t: harmonize t-reftable-merged.c with coding guidelines
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000003ced6e061c83f3da"

--0000000000003ced6e061c83f3da
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> Harmonize the newly ported test unit-tests/t-reftable-merged.c
> with the following guidelines:
> - Single line control flow statements like 'for' and 'if'
>   must omit curly braces.
> - Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
> - Array indices must be of type 'size_t', not 'int'.
> - It is fine to use C99 initial declaration in 'for' loop.
>

Seems like I spoke too soon, some of my comments from the previous
commit have been addressed here. Nice.

[snip]

--0000000000003ced6e061c83f3da
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b53e44a868d46920_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hSU5wZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOU9PQy85d00wUEIxaUwyeHVYZ3ZPOGsvQkEvY1VhagpvQ2gzcVRHV215
V0pWRm9zaGs5OW5aMUdVUkhtcG1BT0gzRi93MU1EalZ2U2xxQUg0dll3YjZvQVhneHRnbmorCjFu
cGlGSHBSd0p2TmZJMjJKMjFMNkpQVHMvd2FuZDRiTjVMR081R2pJU21EYVk1YmZJSm43Q3d1Vmpu
TW9SNkgKN0MyVC9rcFBNbW1EWVpYSCtoQ003VzlTd2hTWUdEcHNpWTlkNGd2TjFCTnFaSmJPRE56
R25lVnMzaHZiQkIzcwoxUE9sYWR0bUZ0YmFLcXFRVjMrRlRjeUJpZEs2NjdlNjNLeE9QTTJqVWtT
aW5LR3FEWHhLMTIzTkR2aTRkb2FuClJMekdlM01uVkV4YnpCMHQ2MThqanV0RlRKQmhObWVzbjdU
V2lYd2xPaUQyMkVuei9STkpkWG1KTGM0OHlUVnEKRkk0WThhSkRDQkRTaStsdGVHaUNqUGh5Y2xS
OUdhWUdZOTU3UXA3bzJJdisrUmZzMlFhZFFWbmhiVlBRQW1KbAo5R1F2S3VTUi9xUmxoRkdCSFNm
WTI2VUdRbktyMXJtZTJ2bysweGw3S2RKTmJXZTdwaTcxNTFuMWRTVWJHSkl5ClhMVUJYT2d1dGpa
K2RzZng5VVlNeFBISTlPcUY3Q0NzYmdMN1p1OD0KPUVxVXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ced6e061c83f3da--
