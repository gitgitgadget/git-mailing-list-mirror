Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AF14F12D
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956956; cv=none; b=P/xVPrsKi94x+acblviN1RpINoVab3z84/emZj8zFdEjyDSg0tjbRIG16L+139GN4ZfYSaHqrRgHfBbmkLDVDufb7T1UIl3ubjiGjS+7hY5QiXBnwpZvCTRa0oZtV5DB3/2DBMr6HFXNFJQhKWHakVrtP2wSbZO4wTjolfFazlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956956; c=relaxed/simple;
	bh=rZoBGILty6mQ3XGokYCMn5/JerOVEsXPqjdKeCY9N0M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1RcCj8jKJ+dnUOYENAGbMH1+7wGLB7hCxotBJXaZXqS6zskuW5wtU8Dd4jtyngJPVSmzfffyc9vUGrGTTVYe89fIKzU8kP3/AXizSaZtjBpfWO3CgSQfvJ9agFpdcgQ3YjtU2WDE5UhX8S0Qzv46YgcGtxRlXjmOOBuvmqJb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buGjsOIU; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buGjsOIU"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c5adbca8eso1770868241.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736956953; x=1737561753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZoBGILty6mQ3XGokYCMn5/JerOVEsXPqjdKeCY9N0M=;
        b=buGjsOIUxptgOju3EAw50RJlHDs2xEz+7UB/yXPwOd9AgF+d5p8qnCrRY1WhAKLWPK
         Qt5P/SOy8j44o5Ocr7LraEDekeYJloDY1OXD0mBnzJ5CmGOmHSyQQtf5qN+fzM4qwxQY
         SuZ5azGLRRRlhOS7Eg0ucL8Aps+WXRkvR+9rTa0VS4WMl9shzyrNMZYgF5/iuKtbnz2A
         RiGxgzG+7XeLZzW4yZBZOsHkVcgpBUG00PXRQ3UIsVeYBjZfbK9gpUalLSGMEuP1Y+we
         gmlHSQ/0JntMDVIjiUIWWBUuV1+mnX9357S/BbHIwZ3ooZYzG98DnlSzQFx3VtgpWuSP
         mpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736956953; x=1737561753;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZoBGILty6mQ3XGokYCMn5/JerOVEsXPqjdKeCY9N0M=;
        b=gti/tb9jaxmROMLfQEYZfaceY/N4CPgWGyCYWR4h49uPbCkJP2O9ySx5z1Abhbpu4a
         ExLx69sSPAlTQgYjQzcUVaKR8tTxXV6v7nzLT9fOEyCa4u5f6Njn9Gqmk6+pA+C1IF6a
         s94u9OgGw5MFA3RIQ4J9PTjKV9LgvHzl1JkNNhoHqx/+qrSm8M4noUD87NmjCBRLY5kX
         v1QAebKrmN4+aY7MuQdRSsEbJR273c2y0PUHa0B19/ezSS5tTAylcBcQWfkwY+qTGliE
         McGmACVwjiL1ZAn0jlP9rOsWDr1lmow8+z28p9k3ywH4GCqEMG6Z+FTmf3LFunltmUnm
         TLYw==
X-Forwarded-Encrypted: i=1; AJvYcCV/DqhLlDGIyIyDdNzemlO+aPKUWRTgShouGE1Dw7kUxi0tzRConlgDWgidkTxiViz0R4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7kwThwvILdsZL3HyzclCswSJxXRHKDTceqzK41S/0NFbSE1I
	aYVjgLt/FkadYUI8ZVm9TeZ/0HwvmIaZjiNdJ3ZUNk9vZFAJ981SvmPv1cQMJ12TKDR/bZx3aAZ
	Faom7K4OPGaFU3heh8HdmO5dZlra1G/bH
X-Gm-Gg: ASbGncvPaI1aMQImtlqID0sf2XG2I1uiySyrlUaqp56a55ueZ82yyTK86s/BJlQFz7p
	3nyt7SHNnuJFl0aGmn8XedfAaSHpvg1LaiwWDSPI=
X-Google-Smtp-Source: AGHT+IFJQa5QsPY0RjCjOTgAlNjXu9b2IO5uISqNOD7x9Ew3r/u4sG+5pwj36NhPZB9MGtU5xFTkJTSk4JjPDYmS4Uo=
X-Received: by 2002:a05:6122:1788:b0:50a:b604:2bb2 with SMTP id
 71dfb90a1353d-51c6c536deemr24260511e0c.11.1736956953365; Wed, 15 Jan 2025
 08:02:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jan 2025 16:02:32 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-6-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im> <20250114-b4-pks-compat-drop-uncompress2-v2-6-614a2158e34e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 16:02:32 +0000
X-Gm-Features: AbW1kvZmBDKhcYJ_K9l7uxIAUYvbA0EiYcobe2698Xh0zcH9vQ28sYbEXEex2x4
Message-ID: <CAOLa=ZT74wUmF1xgDB013mmCpm+PmDox84L8OFJcDpJA+8jP9g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] compat/zlib: provide stubs for `deflateSetHeader()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000322ce1062bc0ce29"

--000000000000322ce1062bc0ce29
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `deflateSetHeader()` has been introduce with zlib v1.2.2.1,

s/introduce/introduced

> so we don't use it when linking against an older version of it. Refactor
> the code to instead provide a central stub via "compat/zlib.h" so that
> we can adapt it based on whether or not we use zlib-ng in a subsequent
> commit.
>

--000000000000322ce1062bc0ce29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 52255cfdaa59d5be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSDNCVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMms1Qy80bndjM2ZRM3AvMzVwYmk1VWFYV2ZrL3RtcApUK29rWlpsM3Fj
Q2VjMFZQN3R3bkhNMmFMQkM4Z0lCY3UvaEtIaFY1TkpWL28vUHdCbVFDeDMxa05NOTlkV3dYCld1
enY2cFJ2K2orSDJncDBKZS82L25YQVRZYmlCMUlEYlhvbWFUQmJmNFVWbFhrdUNSVU5XbmRaSlpL
aDBpVzEKNHJKQUZsanpSZXJxQ1Nhb2hCNCtENW1TMXEvb3VhWmMwNmN4MHNWK2ptYmprZjUyRmRj
UDVhM2xhbDZiVlNNRgpGMGNBcGhPN1RBSGk5dlpvZ1lrdnVzU1ZERzBtUzM4TVJqVFNVeEpBZ1V5
LzArejI0cE9ZWTg2RkZpWUZ5TnB1Ci9sdVV3TGQ0alZDL3pQQlpQbkRRMkwySmRIZ1dPMkgwWVNT
RDk4RCt5Q200aDhxVWpuYU1Yc0kzditzbW1PbysKSldCVm5HYTFRaytoYTI0WFA0MGk3aTg0Titm
MnJwWkNYUys4VDNGeGc3c25xWlJFZ0JmTXB6ODVQK2lFaUwrUApKKzFxOW1neFZxZEpLUldNYlAx
Vi91YnMxMVFCcm4ydVpmd0xOSFNPcTlIQm5SY1J2Sm1qU2s0dFNoNjZZQU9LCjRsQXdCTGtCdDZ0
UThKVEMzaUpNQXdiVDUxSk1QLzJINmRqeFdPZz0KPUV4VUgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000322ce1062bc0ce29--
