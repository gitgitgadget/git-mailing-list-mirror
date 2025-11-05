Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC073218CC
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351219; cv=none; b=EtwMls7yYixRVy394mvGoLJA7gFs8ytx9QgmC4wdiVL7cXeNNTmDD2OszyRwXetjydLR5P7bn5JNOmxrEDohJ24l1QV+MzAeKc2fd3rBt/bDs0C6W5H7tTlx00RgF5uV9vjRO1gdtb8/CZ+ITno54tn90lKjMFfvy+CiWlukjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351219; c=relaxed/simple;
	bh=erZCEq1HPU99r4bw0UVA3sdYqZEQk88YV48hnU2LA0E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAYcmb+fEq1bO4gPDQkfdEw/gIb5cK45bEzIPabJNDy8ArlC4UD5SdHbLk3cl5HF8SesxgQDW5STmzlbpxI34Ah+9u2wXmHcI5jrPlTzYVHU6UE/6x/nrDdDEsFe38YKXAW8U6+Jqv870JjBf9KmrruuFO0uBU+OBTuWqIz/uNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtgQ6F2x; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtgQ6F2x"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dbde7f4341so748587137.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762351217; x=1762956017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzk5MprldWF73KpbpO9KSa5OVRm3yYh0Y1LOqILZczU=;
        b=YtgQ6F2xg8gLVGScrWzNXWomPM0JMr1vvwXzpnrz064GLERE3Ba49uhaKEXNsj30KM
         uCozBBNHdQzakdN41B/MG6OJUGFTFhNrRqzC8OSiJfidMADS3LdlHGlbrLlG08y1wb4m
         PLJ1Bax8mM1zPHpoN5dwe9fVAI65FASWkzeMHHJgayEkzPlnWhzv/RHZtMaEhCcgdxPZ
         IizngnpcHDCvnQysKr5rejtlumKXpHnuzk9ZJZ3rIHGcuxmqeh2c4PjLDwmwcuy7Oy+h
         RJ56jXfIrLnPnJjcWxKRNzUhk8ssjyWYua4PJj3ZOO88PefuF8GdrtjuHWLdbenMwXQy
         wx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762351217; x=1762956017;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzk5MprldWF73KpbpO9KSa5OVRm3yYh0Y1LOqILZczU=;
        b=m6SBj/Vkmqb9Db+ZOzkjJfa5lQ76ZP/SOKkTwgU8rD9GpkWazEX1YMr8n+MKcryqjm
         zRiIrSVzoK15XqphYjKmYXysjEe7Mf1oBPbHP8MKCHA0XsuyJ9LT6qjrcy6s2Syr4g8f
         tRf+Dqjy8qwxLnfyFMTtKNlXx3OH8AD1aLDxhLELhyKJPeqN8EmfD9BGJDcrumt6whGt
         7fx2ZCI2eeAqFDkyqzlnRF4/BpK8kB4rIXL45nH8+9DV5cqjBieYP/cD433YFaHJr2MG
         HiWIxRLQJEvElFhj4uJppEm4gXyBzNJbalXfSDWOabg13MD4Xt5nt33NjNKOIfhgFcsn
         FnbA==
X-Gm-Message-State: AOJu0YzeD9i0Anh2RiGJWNEbjOPn0n/ksrxUr+rG+BR5F6eFLmxo4CiT
	iIrOrSOMya4sry2fniyxnrP6RrM5F5yOjg4s/wOvImNh57KWCRer8XWczYN3oaWjEsO1RC567JT
	ZqQwnVtNu9TwqnWNHhD5I8zcQqQNIK2A=
X-Gm-Gg: ASbGncsBEZ7Fr1Gtt7MqDvqcHgi4orXTS4KZOIiC0IqVXhdZD/tUgURNURgSSy9gBwS
	ttmEtEm3zOK9NDPfZcVhRBLim5dtbZWD5LceCbloOGV68deAmCiyQXxxe5gh0F8Ok53PACMupUT
	3hA0yZfLmHC1CDlbK/Chee5qxUDnh2HZzWCEkYDHjkftTJTw6zCUxivJAdXp2JLhMtceIgKF+xz
	ozVzPFiB6EQwG4qYTAGXnBx6skmrALIhEOY/Oq2AxNJX46j8BIQCqgsK9erkwS1fiYg2HPPJPgM
	J8UiWrU9fJci1DyTWjzGgDJoFnA=
X-Google-Smtp-Source: AGHT+IF20BNQuUKKTV0VrVpLKxhhas0zC/gT/mzwNCvG4+RVwAICx05EGN73gO3AbsnYrGdSWWowuou7IvceO2cHJos=
X-Received: by 2002:a05:6102:d86:b0:5db:e885:6b0b with SMTP id
 ada2fe7eead31-5dd8872f4e1mr1258042137.2.1762351216626; Wed, 05 Nov 2025
 06:00:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 09:00:13 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 09:00:13 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqa511reg0.fsf@gitster.g>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
 <xmqqa511reg0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 5 Nov 2025 09:00:13 -0500
X-Gm-Features: AWmQ_bnywW5FI82wg-O1By_j_btFcGYrgm-YhoDnWJUNl0QOxTREJY_sd4fwA5s
Message-ID: <CAOLa=ZTqqenfKETuvssJ-8KbaVAp5gG1n_jypkm-uBuH6vAO0A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] maintenance: add an 'is-needed' subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000003caebe0642d95ef3"

--0000000000003caebe0642d95ef3
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is based on top of master a99f379adf (The 27th batch, 2025-10-30)
>> and is dependent on the following series:
>>
>>     - kn/refs-optim-cleanup
>>     - ps/ref-peeled-tags
>
> Yuck.  ps/ref-peeled-tags needed an update so kn/refs-optim-cleanup
> that depends on it needs rebuilding on top (no action needed from
> your side, but somebody is doing the necessary rebasing somewhere),
> and then these five patches need to be queued on top, which will
> require further shuffling when any of these two series need to be
> updated again.
>

I know, and I must thank you in this regard for putting up with this.
This dependency chain is certainly not pleasant.

> I expect that during the pre-release freeze things will be slowing
> down, so I'll manage and survive ;-)
>
> Will queue.  Thanks.

Thanks!

--0000000000003caebe0642d95ef3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c5fb7be4bcff68b2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rTFdHa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mem81Qy85V2t3R05wSjh3NjE3ekpJTHM5a1hYVG1Ndgp4VmtqVDNZRUpN
dnEzUmZObFBlOVdheUk2SEYvVklCNXJCaWlGWGRHMkpNR1lTUFIzdU13VXlWeS9hb3h2ZVVEClla
NWl1Y2FaZUtDOHRMVEF2MVREMlQvdVJWY1cxNjVnK0dISG9jWk5lVUpEeWlITzBYQy9sNmdZQ3hq
L3pyeEQKSHZwR2x2V2JHOEtUYk5OdmlQbnc0cklPeDBxN2xOZENQL1RpcjdqYTFRZ3VobXQySGtB
ZVd6ekh2Q1JObHBZQgpaMkE3cktsRnlLcXozbUlFNzRneGRKVVFmbmlqT2V4OWVYdkNvc3ZiMVJ2
cWlVTnRlMG5IcFFJK1ZoSys0eVlsCkFxYUZlMFUxRm5COW5Wd0U3aHQxaG1nckx1ZG1PY0Zjb0tW
eFpoM0ZRT3NpMndVN0J1d2lCUkRyMm1sZVYwRjUKeEZtNVBsdVRMY25vWFBWNG9iRnNTbHNkWXlW
bHNuY0ZRR2p5eWVZZ2ZGZEdPVk5zTjgvZ0s1bjI5TC9FMG9hMgoyZWFkNW5tRk1jUTV2ZXpzaG9V
c0lSd09YbWlIYllSL3hSa0ZaQ1RSVkZjU2tjbUlidXEyaFV4STc3d0JTUnVGCi91bzBLVTNMT2Qy
UXZ0M1NkWGhxTUFyUHhSeFgyTFJqWEhoRGZlYz0KPXora0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003caebe0642d95ef3--
