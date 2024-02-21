Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E757BAF8
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522380; cv=none; b=sDU2iZY312lfYkbcnYzciMvlcMqUYZ6Einc8u5fv7WRswaQoLEZIEM7CAVU6t4t9xw/t/graoa4ZVQztnDrZA9GVPPU2s+kmjC9aBTonWDM3Nd68ZZiNI7sySnIkSieNoRb617D7YyqTaCxNWsSbC7SqPJP3QkCda46kbUjgCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522380; c=relaxed/simple;
	bh=5XtRh62SJX+TXl1q1XhjatfL4EE6RgD5vNxynAOJ5IY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AM7pjGwmFHC176XMQqsrtU+y5XR8Tg0+zPywqBmpAYZgKHj76OG6ndkFufnXM0R5N3mpH2iLHzBQot28bEq8QPmCNSMd+JPHNBSPyX3cCw6EcunlPdm/QWp023LgB2J5tpcXfwRn/Xg/jFV8pgqio3j3eVT3bOVgse0J0+UaB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzRrjn43; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzRrjn43"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso3616016b3a.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 05:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708522378; x=1709127178; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XtRh62SJX+TXl1q1XhjatfL4EE6RgD5vNxynAOJ5IY=;
        b=CzRrjn43Mco9Q8xYcxFzhfOTZYz26JRxz3zyyVNIL7C0/4Rmp6bKIMQWdqGbuKHh5v
         tjKFxeISwlq5kJUctQDz2vt1KsITkvX4XLfSnCRjTuTxAMIF5cbQBDTgFXZkKJtyssAS
         2qoVNbne3lLGaYo6UKf+N11dR67m1K5ZuiCtvGuqPvq50akChR8K6lmG4dfxz9UslEvF
         NU7x++1gu9KkQphpjRpCBNDrhxrCRtc2Lw77irrk1IkoFJ8SbJn57utq3b24/m7ETQXB
         M1fs7lAyXMbpXl/QqaM1KB0E4G34m5e0Xw7MbU2c85GcvdzbNSZEvhu1uRzo3GAABhpn
         z6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522378; x=1709127178;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XtRh62SJX+TXl1q1XhjatfL4EE6RgD5vNxynAOJ5IY=;
        b=Z3GLvKqEk8n8KwiJCd3VTDjJT972jFpnYky/ba7+irBPPSx8ZEZvc9siKFVl1kkDcg
         IZ7dNdCe8zeVXVMH9tplWrFktRIAwjqt0xfCAgqJu22s4DWVypZlutmqP+dEdi64rXXu
         tI8TXzDIMhH4iSqY5OfSSW7aKsIcsC/KR5reqixnNGIOkZ1R6Qli2etUgSqnrgtqd0pa
         zyHI0l6gtajbktiW91cHutPjfYNWjXrUGgNdrnxNtyNrcCqEo7NgbBmhSezpZYdcCxiZ
         8f3gyDg/Lwy2Kbg2d1C3sl2CvvZuw1WsXyk4bLbVQGrYQKplApJtfb84/UOfZZNQfWCA
         Ao3Q==
X-Gm-Message-State: AOJu0YxX0yBlvMKkes3f3T7ZuSpF84q8ZxGpClJ7WRVALg/C6i7khst+
	gqagugcBZi5W2NWa9JxoR7Kjf4irsj7tDeNyHon/7D2jqr3rInERLe9YQ8X4EO1tAwgI6NfqXVy
	PbP4rfX/aS38LP59ZzX4WLKsYn1xHYp6s85I=
X-Google-Smtp-Source: AGHT+IF2Qd29hUOV1iC+tYhuzfBgVHca9d2oko0CNNrnM1dZBsXeQ6UZvPEyT/ANHF0z75OvKNJ3gdw42eIWqnFHulo=
X-Received: by 2002:a05:6a21:8ccc:b0:1a0:6f51:edee with SMTP id
 ta12-20020a056a218ccc00b001a06f51edeemr22828731pzb.56.1708522377927; Wed, 21
 Feb 2024 05:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maarten Ackermans <maarten.ackermans@gmail.com>
Date: Wed, 21 Feb 2024 20:32:46 +0700
Message-ID: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
Subject: Breaking change with "git log -n" since 2.43
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I would like to report a breaking change with "git log -n" introduced
in 2.43 that's causing some trouble:
https://github.com/git/git/commit/71a1e94821666909b7b2bd62a36244c601f8430e#diff-380c4eac267b5af349ace88c78a2b004a16ed20c2b605c76827981063924bbf9R2222

To reproduce, the command `git log -n 9007199254740991` fails on
2.43.2, whereas it didn't on 2.42.0. This specific number corresponds
to the Number.MAX_SAFE_INTEGER (2^53 - 1) in JavaScript (docs:
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/MAX_SAFE_INTEGER).
The max value that is supported now is a signed 32-bit integer (2^31 -
1).

I suppose git simply ignored the extra digits of the number, as the
commit message describes.

See https://github.com/intuit/auto/issues/2425#issuecomment-1956557071
for the impact.

Best regards,

Maarten Ackermans
