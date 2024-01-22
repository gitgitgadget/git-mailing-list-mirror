Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643173D572
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924180; cv=none; b=Y0WJu/FQB3ZPVqU458f/ORf9Qh1MsbZd9Tk/Y/lvhpU2/Ys6DRv8qtjlvvRYMJaakQ3MXh4HfHdxVdgaUHtf06AoFf0FvBBF61nWiRB2ECQZ9552YMqnFTbBwI7jqtrm57w/hTI2HSmjiN1+76n0d3nkHMB77ZqqA70oYpyczp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924180; c=relaxed/simple;
	bh=1Fw9Snt8syY9gaH9lrvxrPph3AiPQWI9u3kaBy4x+5g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=E54+4V7JZz9qC8vXn0+4s/0Z+Ei8AjxKerlLtQbWVYtc/k/Q0wP07VPKJx8NUc9d5S9DqeiKoUZSi6cZE1HHINrZkjsYdiFCc5aH1vLeLCxqMUq2P0jMBf1L8cjOUMMdCQd+aRZTSK+8Ox70U9v2hN4haeQufGkS4hgYuU0zYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxW51+JJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxW51+JJ"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd6581bc66so2483338b6e.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 03:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705924178; x=1706528978; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Fw9Snt8syY9gaH9lrvxrPph3AiPQWI9u3kaBy4x+5g=;
        b=ZxW51+JJF8xafEdaSGT48rlobGT4vGKv/BzC2BSRCqPnpRLS3KgJCwrBLfjA6KCB8Q
         Mm1Nkul4Gma17+avLoxdFIy2FWu57MPYWsRte1atK5JCoGaqWzq8sdv+lObpIEpeJOF8
         jHoVgzbSHwi1mHtrLvtkCYJKHSkg2yI+t0mB+HRDz2wIUGJ6JH684/sfUVxmTxdv6P20
         SvGz2OUkkwl1ulIIBMARW11LajQ587A1yurnFHltkESpZpn9MB1q5QuSgqKtUbGD/NBA
         m7iByrRC4KAIJL1NudSFLqYbsH+Gj6SmXkB934sMXDozHi3eFEh16Y9FiVjTskPWFcfV
         UKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924178; x=1706528978;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fw9Snt8syY9gaH9lrvxrPph3AiPQWI9u3kaBy4x+5g=;
        b=tWsn7t7P2juoN7LHDb+Qe+CUYwe5eKIIAOkVq94HU7DmW8cfnD4suRAfPYQ2f8fJjZ
         2hZ7XJvNi8lYZelmrV3yrDjZsfxjA7M4NOxt4RKkTCc8ZfGequ3DdZLM4Tiw4id13de1
         Ti0iHzp/yZy2bbPHf+dfOY7PUmtqevLY++VGES0LbHBYCxYRgnbCGZ/hVmlCJydZ10mP
         lFjaCRT9d2xTe26Df8RW4vagrqffpmUB8bhCUD0Cnuz+ZLvgg6me21Wwe6RvmewvhI9u
         WwJW1bhcIYVHgQpSLPGyRCSkymeDaN1R4BoDfc8nMWNb+W1WJKXV/0R8rRSq4VKNflNm
         OgiQ==
X-Gm-Message-State: AOJu0YxXjcb7T3m/RApPjAnRCnTG9WabRXjODN4BRgk/HVEQcX6WCFU8
	ySkr5bg0o/2HpoMjFvMIgW/rGelDWjWvMtOrGtmedKk8yHRqM9ICFrwePiJ/o5S3hnNvDjz1E0T
	tALVWEH0Lk6nrdGWY+En3M69GJsRpv+AT+tA=
X-Google-Smtp-Source: AGHT+IHwCV+ObQxKMp5/hsgE7zGAV46KIAjW4dEQWgVGjwRk71CJw5maQ2NjOe/5jES/BRcPxJW9Za/DV5VdliZrVaQ=
X-Received: by 2002:a05:6870:7b53:b0:214:44cf:a81c with SMTP id
 ji19-20020a0568707b5300b0021444cfa81cmr2636175oab.96.1705924178313; Mon, 22
 Jan 2024 03:49:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jan 2024 03:49:37 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <48b95fe954c1dbdd080ce7a0cc871f4850bddeae.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im> <48b95fe954c1dbdd080ce7a0cc871f4850bddeae.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 03:49:37 -0800
Message-ID: <CAOLa=ZQakWpRgFZdLnALq9f+acAR3hBwgO_kxJ6gb_yv+vrX=g@mail.gmail.com>
Subject: Re: [PATCH 1/7] sequencer: clean up pseudo refs with REF_NO_DEREF
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a99a8f060f876ccd"

--000000000000a99a8f060f876ccd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When cleaning up the state-tracking pseudorefs CHERRY_PICK_HEAD or
> REVERT_HEAD we do not set REF_NO_DEREF. In the unlikely case where those
> refs are a symref we would thus end up deleting the symref targets, and
> not the symrefs themselves.
>
> Harden the code to use REF_NO_DEREF to fix this.
>

Just a question for my understanding. Is that that currently
CHERRY_PICK_HEAD or REVERT_HEAD are never symrefs, so we don't really
worry about this, but adding this change makes it safer?

--000000000000a99a8f060f876ccd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a89a1106b137d67d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XdVZrMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTZIREFDZ1oweFJUUklzWDhwazFZc2F3bTFweUwwZwpGeTdmYnlZZDZI
Q3FDd1Jyei9ORXBmWk9aZDZqYmhpUkVHMUJpRFdLejZ6NWJmYTJpRnZQb0UzaE00bzU5ZXFKCjRB
VksxYXBSbFJ1cFdlc3B6a2V0dTdKdkNEVnVsb2s3NjRSenpNMlByalFDQWg3ZTF4SW45L0hUZGlm
SHBidU0KbVJydGFEeE8xUUdnbFN5Yzh4aWUxVStrUzdwbU94WGVlcjZKOUxNNitEQnhjcXRNUVVl
K3ZmVXMzWW9GZEhhVwp1ZTFQamFtZFkwdEZiOHF5YWg2WVorb1F2cWYxQTlPWDNJajhoandGUGdB
S01XYW9sQUlUL2U4N0ZMVzJFR0tNCndmc3JCYWxuczFCM09TSDErVDIvbHB5Y2Q5TG1vZytpd01w
WDVCUjhjRWFPSTRQVVFwVi9pUStaWUxkdFFyNDQKc1V6WjVQdHBBU3IzNEc2QUd3aFlGc3NUb1lp
dHFORUJMV04veDdpQXdXSlJ4ZTBvMU02S0ZGaXZrNDRPbGc3UQpBVlNrRDFYaEp1NFhWUU9FdGYr
M0UxVTZES1phNjgvY2dIQU5uRnZjbWw0QXc4Q2RMbjVhYjBuMDh4SHdPdU50CmtMRm1RdFlXazFo
dVRwZ1pDV3VnaW5zZFdpYWY5WWU1cHZnd21ndz0KPXZDa2MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a99a8f060f876ccd--
