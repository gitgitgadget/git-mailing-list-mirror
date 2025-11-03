Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13A23EA82
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156355; cv=none; b=G54DDnWp60VokBRB1bxZ18FZlUvEgfWoIFbnfcWi4/FLX+MkvQnIAyWSn/SQEpMjMH60CQqBKM1Wl1BssFuvgouR9OvZM5joFwGhy6sFwgYY74k1sOlmHol/5qY0hcxFYAsmPViBqHkpu+wOKWXQ+ulJ+RmDcS5H3PlX3ZD3bq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156355; c=relaxed/simple;
	bh=FE0qtV8bZNdAr26JCJrprQmBDYMulUrSqBbjt5WQFTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoBRX71cIRLzvCBNpQoYuAHXItyCfTKrU4zWFf49S8/CTphsVfAs5Z91J79kGlum/YSjXq2tO9QC0tfcLvBjdG+MG1gAYPV2E7GHDC/hxz3eHtNpdjAbvXtaXNSohJNT9QInNHEFSGI/4m1pZNuu40SHyhY6RUbfI2Vg+7SB1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf7HouWw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf7HouWw"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so351555a12.3
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762156352; x=1762761152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE0qtV8bZNdAr26JCJrprQmBDYMulUrSqBbjt5WQFTk=;
        b=hf7HouWwOR6ZCeh2kmCW6UT1lXQZvOmWKbpinfro2kCCdwniZHno47LSVS5jZwMBpY
         Z41HHp7MEw2cH3D1zEHyzFagm8fXiuZrHYCwSMoZmXyIO/FpZ8yZNkJb6Fa5jm3jvQer
         wFlxZgBlBNaBhpTQEFcqLKko0HyPOYBdEwsq7EoqYDBcv/AkQD+HHESilWYHy14tyIhz
         yUrwh4kI39JZ8fbnCWXyJf+vMbxOBtIXaISUXJB/+q3ZyAbOPWAj+evFhh45X9JSlNYV
         HSypeX++iFm2kIFzx8oqILotRrqzVfvfo+pmWLT+hXT0O4uIZbpY/4XkJmYB4C8XkXf6
         Ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156352; x=1762761152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE0qtV8bZNdAr26JCJrprQmBDYMulUrSqBbjt5WQFTk=;
        b=e26XcVgLbJuz3GB7oZNqFVlGMznCldn9oeop2ZQmsOGOFN0vwJVwD5Skazn7R2Md43
         QLCClpMijGdmwd+mvQYi4kPY+Z8w+vFnehh/9XqL35FHK0M+3WkTsMb2SB9HoT3UUClj
         kU1t5lI6ToqEEPRnQkMyVTtw+pHRkGkZ6hwxHSv2R6HpVnrIldjnTPhIU0Xpkc3KRoB+
         2Vj1Z8JhLJoR3l8KwhI/1Toz765SxKROLISTC+iE5bk9UH3CVCgZqzqHOOb1/s0zEMjW
         6yT9BDQ9z/YviDDsJaCdH7VZPVOHZZHSbqCgMV+cKNCgFoTitUK0uyB+4C0LleLA2goT
         Sc3g==
X-Gm-Message-State: AOJu0YwDzpDQ0sqqiUkJRFsu1ZjhkK1opg5zEySu1GSczowxbLepHhir
	lcBjZIUNHCd2ntUL7Z9aQDpZg8oFJDo2b9L0xG5HdbHMu16qhnQanpbicR2Glr9AJDrw5rGGenK
	UfHmjlBgkCprCJGgmpd8YEyvE0x+HQ9s=
X-Gm-Gg: ASbGncsH+QgRocWAC2D0UOUhIkIH5gfRrKRP5BMte48vQzrpulci5EeHcVlEb3I7ceM
	mH/SlKg4+C32Y0kSSVUfJHRYyTvc9BEPIpdCKhGshg1O8lV2t5YMu4t4sgyR3QnGnpCBceWkLH9
	Yx31LwkTBQdY4/mj3X5O//HAES4Io5laGaRgIOrbB/aAFcCaTTyIyA0S0Qoefp+8PJJdKLY3zsq
	HvTBl5CKAwtCixnZ/SjKOaEH9iCIPrRlfT9bv8GF0BLgxSggElFhXY157qx
X-Google-Smtp-Source: AGHT+IE7OscWzLdbUaNVToJMCMy3WA52v+PgdmS8DMC9O/RHg/3KPawOCJF766WPTIAiDqBTAdDI+7axnqyDoHWnFOc=
X-Received: by 2002:a05:6402:d08:b0:640:d184:cf0e with SMTP id
 4fb4d7f45d1cf-640d184cf5bmr488879a12.21.1762156352142; Sun, 02 Nov 2025
 23:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQZaqG6t4F6XE0nt@ubuntu>
In-Reply-To: <aQZaqG6t4F6XE0nt@ubuntu>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Nov 2025 08:52:19 +0100
X-Gm-Features: AWmQ_bmVKed6dZQMmb6WknB2WEf2xUW19upWcgpzG8aE__0roVGdcfNkYBX8C74
Message-ID: <CAP8UFD3TdUb9RBktdxwA7Qj=6Oxqpzg-ZrVP5eT_+38TPE+n-A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BOutreachy=5D=5BProposal_v3=5D=3A_Refactor_in_order_to_r?=
	=?UTF-8?Q?educe_Git=E2=80=99s_global_state?=
To: 20251030144934.9689-1-belkid98@gmail.com
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 1, 2025 at 8:08=E2=80=AFPM Bello Caleb Olamide <belkid98@gmail.=
com> wrote:
>
> Hello,
> This is the third iteration on my proposal for the project
> "Refactor in order to reduce Git=E2=80=99s global state" for the 2025 Out=
reachy
> Internship program.
>
> The change from v2 includes correction to the subject line to have the
> correct encoding on the mailing list.

Thanks for iterating on your proposal.

Please make sure you properly submit it to Outreachy though. It looks
like you haven't submitted it yet, while the deadline is today at 4PM
UTC, so you don't have much time left.

I will try to take another look, but I am not sure I will have time to
do it before the deadline today. So don't wait for it before
submitting.

Thanks.
