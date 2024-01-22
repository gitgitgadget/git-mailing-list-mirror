Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A93D0C9
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932752; cv=none; b=dj2QR3YFOAOfKsRPhFabF/khenE2lhb4sv46Pfwh/o+UUUMxbbBRhpwBvx23FotyytFXV3gZ8BGfYUYtiMuUPyCHA72DBEo22JlNQQkCTApMk8mnJwmYQLgAmVQ2wkxn9DWgfwQEBE7LiHnvXIbyqzMSFxpUwHrlkd5VagUcrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932752; c=relaxed/simple;
	bh=BXerluUPsIrgM4SCM7LYkOhrIMILEiNYktHWWX+rw9A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th1VWs4F/UgpFfPbzLUCV2R82yNaf0IaXfofOIul06jELmbwlJ9SiCYX6qeD9HvNlzhn+E3jTq0glcIoAXDpAxxGUPV3uOReLVOVB5fL0wBlYhojjEN4hLWjvGtVxC5GpTQo1oe3VglECyh5hWVPy9L2KzRSU8SU3pEAQkdwP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqoaZ+Ht; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqoaZ+Ht"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e0df9aa43dso2521254a34.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932750; x=1706537550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXerluUPsIrgM4SCM7LYkOhrIMILEiNYktHWWX+rw9A=;
        b=YqoaZ+HtGHRA8lgVD91okRT/dFheKzdQhlgl3K0WXp/4rOB7gJO8w0P/1ur+0CPn5q
         ZAgFS6ooENVrtgvREiMtI462yG8bM+vdE55PwfWnVKYp0o8zLXKY5eYCKJDWOFj1Nfu/
         I1pG5MMF0StFujf6NNWWpe5f/ZUzWt7QrSkOfQeuqmfPI09UACUv+A8J0QQ5OMJbK6Ap
         N6PQYtWa/1kohU+k0Z/UZWRekDGduI9GK6eEUGaNNZ6CgPwdCz+4nqYg+CuHzgzLq7Gz
         JuVKHvC0aVxmobNY3OVw8hHXrbSEhjQAMby1gTO/rx5LOpkmpZIKIfh1vuVE2toyY78y
         qUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932750; x=1706537550;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXerluUPsIrgM4SCM7LYkOhrIMILEiNYktHWWX+rw9A=;
        b=ItdW/V42GTpoFjaAd6LDWPItLIXapd8Ogrvb4QS3FMULfRdz3U+7ZZ5CiIWw3RIyBA
         JIjdn8BNMqK2izQjM2STsIHcp38y12ng4e5Xd5viUyvy+BsmmQ7y27BCvLtOsp28Abl3
         yWeuOXACYvPz0G00cgHF8k3nzPlV52J27ZhhJKsRWcRWF2DI6AxwSf4YGpDh3grEKnl/
         +Jg8BFDn6xEfEQ7dF/qYqymQ6CxyDMIe33NRMjWUJWJe/u56WSrK/6Cz78LH/b1a4lQO
         U4QHQVvrxTdsLz0e2oG5WRyvXWl0TpEB0mcS38qACv7l0z8OFcZCCTz++t+XBUlsP4k5
         SMAw==
X-Gm-Message-State: AOJu0Yx5oKzBampQlZdMucBn87QBtd4Iy/9mk7VShKqycG3pPGmHjC+C
	onbOrfDLljgciXvH9wnC1kS3AKlb9SaOmWxrG9Z8Y7pAzw2iZMs+3zNFtOzvw1F/Men1hl4tj1z
	GdUPDwDkKCK0jfksLE6QSbjrq+Po=
X-Google-Smtp-Source: AGHT+IHPsMemzA8benXSR5CU8RBr90k8hTdePVSPImxijf3w5gGfkuxyaLyS7pmuNCETImQPKqHTx1qurY0cNKibbwY=
X-Received: by 2002:a05:6870:179b:b0:206:daf8:4ac7 with SMTP id
 r27-20020a056870179b00b00206daf84ac7mr5177375oae.6.1705932750455; Mon, 22 Jan
 2024 06:12:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jan 2024 06:12:29 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <d93c9c410b995b0c72958b1e9edc27c785857c55.1705695540.git.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com> <d93c9c410b995b0c72958b1e9edc27c785857c55.1705695540.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 06:12:29 -0800
Message-ID: <CAOLa=ZRS4TLVVYhVxkjmtFyQQNWb=qXGMW_dQC2HUBq+eErFUw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] t1410: move reffiles specific tests to t0600
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009a1b91060f896b87"

--0000000000009a1b91060f896b87
Content-Type: text/plain; charset="UTF-8"

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Move these tests to t0600 with other reffiles specific tests since they
> do things like take a lock on an individual ref, and write directly into
> the reflog refs
>

Nit: missing period.

--0000000000009a1b91060f896b87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9b778b74c6d8efa7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XdWQ4d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXNlQy9vQzQxMmtFMTlPVGNkdmd6b3huWFhlMGtRcQpPK215NmNQc291
M2IvQVdMYzNqVHVWSEN0OWJxbi8rcjZ3Y2ZXaHpPVnVwYW5RTXlxQVc4R291VGRCNlZDRG1hCk9H
T2lyYy9PeURJcVR6YTlaRit2ejZ6MEpFS0VBcklPZXA1RWc1LzdSbGNzRjNlV2t4eWdaNzg2NXg5
UEhVaFEKbE12U0w4S0JiTWNEaW1KMXVHOXlYMFFUbENvWmRwSC9RTFlHRnAvSG0yQjhoQ0ppU0tz
MnoxdHZNTndkMWpsNAoxblBVRDJ2VEMyZ0NsNUtrdWdKOHNWRktFR2tTUVFHbkxrTDBGY2M2TEhB
enRkRjBJYjMyUTRRK01RNllUeUp6ClhVdlNFL3hINE1MSmdveTlEWk92QXR3ZFl3aDRZcnRqUXJp
SzJZVktaMzUvaXBqTE1MMko2aUpNVTN4QS9laXkKODQxQ0hESk1aT1RjTnhGSlpONXRPRTUwd29s
b2VidEszdENac0NQOWEyWEdXVUxTNzhKY29NQk95TWxCYmNqMwpTWmFUc3NVRC9FZGJKYXpoV0lB
YW53OWRtY1psRmE1cGJ1T0hsT1d1aXVGbjYvZ3FHRE1sdTZGU2o4MHJwdEFJClJwVXdmU2VmZ1cy
L3N4a25tSjUzdlZoSUJhWTBpT3E0eklVYjA0OD0KPXhnWWYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009a1b91060f896b87--
