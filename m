Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4C165EF0
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451256; cv=none; b=Rnb584v/DWo9Ch1xLzkGYclDAplR4dhkl4YqmmRkZXhtp1I4qrZx77TgFsRBXG8KahzpHf0JbrxI/r9Ugz+rcPW3apRYlrrsexeN8QEZOb3DWEHWQ5SifI8i44CuKIwB8lZ2QzhK4obVQwPtW0YFvf8mOZno+A/JiA2vOeqQOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451256; c=relaxed/simple;
	bh=G9sgcTSGH3HqJg5NEDtzG98QjRSjp7t0E9KiYjG9f7M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1Ixfu8iPa2hnJYFDMDkpKVzjWkAdWRf2Bq5dmXde9H9otTEPFeI30L0sCpbkgORrZwc9X0A9OsjaltFaQ7IuRhWX4kr/f8gHznONVMIC69DfExnQSMwJ+KDVFk2puadXx7sIOMStuBq4s5dJ2uaGtNV3LGZjkgaOWStWZkNbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH1cfE+x; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH1cfE+x"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db504ab5f3so2448793b6e.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723451254; x=1724056054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9sgcTSGH3HqJg5NEDtzG98QjRSjp7t0E9KiYjG9f7M=;
        b=WH1cfE+xXnPUac+ScSGOXEK+2C1wk87dlZ8eOmgvE3dS81F8vIKYcVA3CXZ3XLkqV2
         Fl8f8bGzol10bHCANAIo32NT2+EeY9J1S12E37iTuH9MtBqCj53cpaM5u1Gx49ZGz/TQ
         Z9+DY94kO8aaHq6GgWhzluWZf6fDcgr4pPegHQsk6Z9B0xvtknzYbdgpG/Gdhy4Ob9TO
         dVRWv3MNe5J/1KtneqsEHlXgzN7cIQ/YEm+MJTPSMw5cyy4zsfJTOby4Ti9wrO9zptww
         srN8g+SKdxlLpxZGyImT6Ue226KzIW0UW2RunmZQh8wlP7ceP7g3VfcBqXFLdHPXZfCD
         qMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723451254; x=1724056054;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9sgcTSGH3HqJg5NEDtzG98QjRSjp7t0E9KiYjG9f7M=;
        b=jEiPLYl6UJbQ6KRZwGF3mDDCWK5Ctb37E80RPRt3rlRfx5HjSRXz9Yj6+osHYWJNBR
         zpA9RObXjRPvCqF/wRnPww357dj1ShjEAhTleYh2wwdFZizQsJ9bsJxoVlSeMIjcbMwY
         to8NKzMm020FkRZ5OKbdB2KP5ydalHcaEZK1HbDG+xWHXEZjt6JzgQtFlHri8QevaIHn
         qetGRCOjvEDqlOJ8XMtf57n3j+LLW8vXnKd8uhC/XO7dvRNlKgDiYPfBJ74ScbsqXZSr
         Jicc2dCzfH3n3nU51Ze56gI5m/+yuyUCnj5F2pl3TerGDt0XiQSlP0NI7azb9Bhg4tzx
         sQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOV3u4yJYoLHoGiLoN8Mh/Eb4aJTafwbb1IeJtJ8oi3oc9qzT1rOLaZzNjWgKQvhSr1TLaecj6kM5B/nNBQqq/rXHh
X-Gm-Message-State: AOJu0Yw1NSGHoSOf5x5AepIMaJPxt7mDP2aPihEUwqiuE+Yf2OUVFLOb
	JHMkwlRNhTEMI9Z6mfikVyR9bKDa4xn6P/AQ+/AJg2Db028sWvWi7ekJwJCuAlgSYQ6hx+pZNlr
	i6EJQoR+A4mPG96Fhv8rjSNv49QQ=
X-Google-Smtp-Source: AGHT+IFChqjVZ/VECA43kJ3GsF4qaEW6GqVl4VFDopJq72c6XJ9K0VtjswkeM8JyGrjfohFnu/SNFw3wDepQMT45Aqo=
X-Received: by 2002:a05:6808:198d:b0:3d5:65d5:edae with SMTP id
 5614622812f47-3dc416895fbmr8219877b6e.27.1723451253687; Mon, 12 Aug 2024
 01:27:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 03:27:32 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im> <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Aug 2024 03:27:32 -0500
Message-ID: <CAOLa=ZQtJTd2v3YW1sJCwMafiM619Gqk8mb8qje8EFCxuV3+FQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/22] remote: plug memory leak when aliasing URLs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c3bd95061f784300"

--000000000000c3bd95061f784300
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When we have a `url.*.insteadOf` configuration, then we end up aliasing
> URLs when populating remotes. One place where this happens is in
> `alias_all_urls()`, where we loop through all remotes and then alias
> each of their URLs. The actual aliasing logic is then contained in
> `alias_url()`, which returns an allocated string that contains the new
> URL. This URL replaces the old URL that we have in the strvec that
> contanis all remote URLs.
>

s/contanis/contains

[snip]

--000000000000c3bd95061f784300
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f070f3ed98d7a50e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hNXgzTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFNrREFDZUZGV2pvdkhTeDE5dnB1ZUdrN2czQml5RgoxTW1qL2k2Q1Jm
UGVSMVB1WHpCak1iL3p1cVlFSGUxa1B2bXdhQi9NeWF6c09jWUlac09STk5tYkFnL1hQU1oxClBT
RDhzQ1dnZEhVc2QxZUpoRjlaZEFrbHRQenpLQ1ZpUzVmcEhIOUJpRXZXdXR2MTQvRzNnbjRQKzNR
ZHlSUHUKdmd5d1VhWkhkNEg4MmdwclNmNEcrc2RIRGpxWW41VzcxaGd1bFJaWE5wT2JBWFhwcTJQ
QStwUDBDZitTcksybApEcjZNV0lLUDJ1cGFxNEhaNmpERDh5M1VNaVIvMlVPWjg5RGY0Vk53VDgr
ZDIxQk1TUEVTVGNWVlEzQ1lWbm10CkNYbys1bGg1bHpZd044ZWFGV0RyNUdWSk5XME9KTm9iK285
MEo1YXAwV2xoTnZNNmFQOGVkdHFxSkRYR3ovOWQKcVJoY3I0dlZhMTczZm93Q0E4OGNXOGFNZTdH
L01vZjFRQ2RqNnBSMVFROEZ6azFQcXFUZG81T3BNME14OFY0VApINk4xb3QrM29UcWJOUlVFUE9N
bWMwRC81V1RTblJuanNmeVRFS0ZDazFkOVpUSDl1eUw0TmkyUVNHWEkvZHRJClo0UHRkajRmb0VB
eHVSaGVJMEtlZ0ZUMU1YdVlQcDlWSGpkUDBhUT0KPVA5SUcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c3bd95061f784300--
