Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DC1E507
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709756; cv=none; b=Ixp0BBvzAs2nc6it9JKx6KYhKB3Zeh8lWEnLpZgRNeH6HboN0AYgCCFcVILATj7gRVbWRHABQehcCHFg678T8NddNK/hX+Kai6O+JF+vylVzitHLVcR4Iq8VB0RET4bm7qarnvp9MQG0a2s+mrufJ/b89WuN6hjG8gnUoQVkkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709756; c=relaxed/simple;
	bh=GHqxoLgRYPIf7XGQDXoAZmvqhyKpO+SttFc5l3y7ahc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzNjzen7Odukktmy5q0CwULALgMfGL8vvL3lkEjI5vLgElyARLqhjLuZM4aG0uuNlmQpjdn3J0QUgc35uNZkKcG6y6T76XP4MQvyNxEypdV+atT/o4or1hxyMbn+9emNOGPAi5vNojbOVeZW1GiZ8HvkJI4QInlepUCEoSo0vdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbBYunR0; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbBYunR0"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4addd900de1so1893118137.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 04:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732709754; x=1733314554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7N7m+H/Z2ZgX2uJCJSYaHNEsdx8FCGHW2XKItLchpc=;
        b=UbBYunR07Bplc9Vjg847B7I2+MBI1b6avHKC69w9UMc4HawCHZUDD/v5DGhftUCA1X
         l4nmxls+P6owvi7xGYdi5e1mQIhSdbpqLXdQizgnqWe2dhBKAgRneduUNTw2HsiJnCmL
         eSMkCmL66hdGx2lhbBUoI0bwfj6sXr1szNErQDXw/RE4tDRDs4uY+IsvZyIobZHkQWW4
         ZdhSVuyM7mvbX2VKd4dYaVr6sEeyXTNVUlHBH1jZaRSimpa2HnRoCHwFZ7SWxQFO4a3T
         b/tDI79psRQZiEvrtPXCM8x2T7YMyB3vlDABC+HwfAkFNtF7nk6EHzS9n+1qv+oDjIJe
         yCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709754; x=1733314554;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7N7m+H/Z2ZgX2uJCJSYaHNEsdx8FCGHW2XKItLchpc=;
        b=vrrCUBnXWFVFGnFgZRq8ld7vgCZp0IRkw0vhywpXxvwPPOD4ju+xfxib7hAwLU0lAj
         7hWk8sR81nJ5mDFvtUanTx83VX8AtZHnvh72ZaOdQIV8cQ3SObs6AOLYHf5+HQrcfTmh
         kiJ3GVVed/PjUfDgyVGMXNIlxuog8DpLFOpwxB/wmfsET8nXnMqz7IwEvGXfqMmJ+GTC
         OIkKmSTACCBSLWM4D4hoPnVZSz5wxJzkhv/2Jda6jF8cIRF3yjLgcmk/WoktbOTxmxAf
         eAXhv7nqMiHQMzM4X+dhjncsfYRdI9rusNImtFxkKVKq00hGHQT1H7kU698w86l30ryK
         JWaw==
X-Gm-Message-State: AOJu0Yw/5JcrEEYWYTHeWYbwx0f/vsYgM1PbTerv9QPrrx1ud7CX3Zbw
	r+rYXOLD2uRSQdteK1oVOGj25AAUrExCdgql7NN5RrLY45gEp36zPgQgOk6L2sqA6YLqm/qeUPQ
	2I2QoXcr6vZh1Zkgu/egppfNYpVFdGrKe
X-Gm-Gg: ASbGnctA9vhTJV6Jsphu5STX6xYZF4rDAfDB8i3oQcf0kH0BhZ84I6/ATYAAsBis1ab
	EB5372k/4vQartWlmeVjGoDDpp3sVGeA9cOs2Y/Vf/OhNrn8ayz6T+1pRTn9CIsHICg==
X-Google-Smtp-Source: AGHT+IECwc9chlEfxmqzGl6wYbAPGAU/HhjEpXYMFO2rijN4m5kLKGeknTmJtWXikeXhARIszvDR93NLZew9rGKBbso=
X-Received: by 2002:a05:6122:1e0b:b0:515:4fab:301a with SMTP id
 71dfb90a1353d-515569cbcb5mr3524462e0c.5.1732709753961; Wed, 27 Nov 2024
 04:15:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 07:15:52 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <9ca6bb8a-6597-400f-860f-3546296c441d@app.fastmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com> <d1fdd6996a6ee94534905fd993f3472ad318611d.1732618495.git.karthik.188@gmail.com>
 <9ca6bb8a-6597-400f-860f-3546296c441d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 07:15:52 -0500
Message-ID: <CAOLa=ZTb_nqj1ppyuZy44xKxuyTMCSO4nxJ5ohPanNCzK6xLXw@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] packfile: add repository to struct `packed_git`
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000062671c0627e3ed7b"

--00000000000062671c0627e3ed7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Nov 26, 2024, at 11:57, Karthik Nayak wrote:
>> We do need to consider that a pack file could be part of the alternates
>> of a repository, but considering that we only have one repository struct
>> and also that we currently anyways use 'the_repository'. We should be
>> OK with this change.
>
> The =E2=80=9Cbut considering=E2=80=9D needs for a conclusion to come in t=
he same
> sentence.  But it seems that the conclusion has been put off to the next
> sentence: =E2=80=9CWe should be OK with this change=E2=80=9D.  That doesn=
=E2=80=99t read right
> to me.

Hmm, yeah, perhaps a comma right after the 'the_repository' instead of a
period would make it better.

--00000000000062671c0627e3ed7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bf88b1831f2ed616_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kSERYWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGQrREFDZWJFbmFKUWxnMDdGek4xT05ubFZlcmI1bQowbGZkdW1jMTJ2
Q1FrVDZJUHlLcko1MHFXazZRbkZUbjUwN2JibkF4NlJJeG5yWnNhQmxCbHNvZ3FwOXJlRDZhCjVT
Wlg0aEpYcnY2M3NmdS9reHZrb2wwWjdBelhHUjJoZytoaUtkMldoMWRvY2xGZzJQWHVZSzdsUzJi
M0w2OFMKWTdkU1dlZW95S1liN1VnUUVIWnFWcElNMVlQSFR0RWlvbGc5T0hvKzRsVEowNU0wRkVt
TWRCNUlFYXp1NUppUAo2U2pYRUJXK255QVpLeWpQeFhLekFTblBNRlhqemxnRVh4NzJwM09MUElz
anB1TTAxUDJmcmxieitIc25NZ0h4CjJrV1RLL3V1YWppZFBLeDJUV0RqcUdxRnVrU3JYa2t1c0s3
ZWhYTzQreWVlQytWR2VPc1pPZHM5c0RpS0k2YjMKcnk2M3BpYmd2RGZ5VWQ4S25ZREE2d2l1MnFV
QWRZTUx3c0wraGpDT3I3UldCdWtYbWNMVGRhUzQ4TnNZbkVOYgpRTnJ2bEJYdUwyWlh5UFhLbXV6
bEJyb1Z6NTFwYWVqQ3o2MUdqODRQZWx4NXhmcU1BV1VnUEg1T2RtbHUxa2ZYClBEcHZIK3p2UXBJ
NHJicTc3TFMwV3gvTG9JR1MrWWk5Ym9KdXo0ST0KPW9zczEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000062671c0627e3ed7b--
