Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95E186E27
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735627347; cv=none; b=OiDHMn7n2wzPVLmTZM41lG34YW+0e7sOD/2HQws+gr1Y5p8IwVREskQQgq18GH92s+VJJ/ma0cHonZOKi/9dX2r8eBTdUYm81sCM/uKtK6AKZhB7oYwbiYddyRZMXAMZ8c6iEfADoArREekjsIP47LoFdKKkEKQRVYQ4xA51eA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735627347; c=relaxed/simple;
	bh=6ptHT3skAUWJpyKTX+0bfNTc2bnLkWbYYvPYXdzbFec=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=XgwC29eb2ecfoX5oq7q30pPc8G3EhypfNieU291uy18O/VdXpz39CEkajKGOuwUBI9xpwhvmHXM+tfJjiUgPPaUHSmp7YZG0TpF8L3b15WA+ZBINVAzCVDEZVIKlhWz8eVPG0mBETxImATzWTgXMf8A2NDEaMYxu9caGVXDGpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOewZoHd; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOewZoHd"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4b11a110e4eso2785456137.1
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 22:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735627345; x=1736232145; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ptHT3skAUWJpyKTX+0bfNTc2bnLkWbYYvPYXdzbFec=;
        b=LOewZoHddSdgXl81qE6K23RTDd8gQgqAOD2lKvPSmBSjVvbNb5cBPvfW1gHS93Pbyc
         Rzvlgab09PyVn/pq/wm0mQWDXkJqUHX9iGd+C002Ps+8asyDGd5gQ2SVVOTxera58AoE
         BDRdrE/QaqujWpdeRmWnLy/Jv4VnHrVNmZDKntjrQ0Y/P0hJvOBOjF+XdYC34j9w83us
         xfUgd5b3DpQzjUuoDMRqPCTAsp8A6e8eppyXG8SbeS/AcRuacDgWR7/JySbpPvFLrwv2
         45X2aZr555eF5WsD55AhL/tLELAw2FvqK96hmT2sb1Z0a7cVFblStCi62B7hD0oAruEF
         6VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735627345; x=1736232145;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ptHT3skAUWJpyKTX+0bfNTc2bnLkWbYYvPYXdzbFec=;
        b=vzuYdYTBIjGPl2tJ7XpGK71iwaomzFKWTl710pegTWyp6yrvf7+XFROXmqGgq7qzFc
         nbmQeFey+f1AZp0ff59WdRoJys3+BOSlgsSJNnK+bX39THjbVfdzaUlll58SdyNjGSOY
         D5iOcv4UMHHJYq6FoPXqsFhhtGf10cGO/Eu6YpT6olNWBF0Q4rDajSNnAwKBW4dmnjwn
         TAPO6xCiz1jbgulKppQ2P91tTaGh5HeBZpJOjLPpGN9WJ87u43Ehcrsc+8YGnJYdZBDo
         MYfPhOseeIzeV2CM2ibli6W2eADCy+MAw+wQGAq7GskId3dJlYPL2vGJfoix263cjbvR
         w0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE12qKQ2urHGkZ7xRxklr7MxScXth/ucDfkaEIDIuHjE+oM/kPMTJ3sXn2eHrehKoFWyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgg935Tj4+/O1CsP0t3QsBmBwZJafay2mA8tgerNHXIGVc4tM3
	zGT8VAgt9icwBPuly4kl10+9nGhxTmeWpURsAqLtFwhB18/wshpBb3xFb/WGNDRI6YnmifWrFvH
	TFR7Qc+pK0B/nPCVxq7+Up4jkqiQdLg==
X-Gm-Gg: ASbGncv1z0R9H4o9aTmYKCXdJHY2GwPTF2gyj0mRoHWsbHJtJJRa97ORb+dmeURApQ3
	T4Edvo+50Ocq5HGsHbJlgltzOkQDQ63NUH+2j/hw=
X-Google-Smtp-Source: AGHT+IGzATbH/Xy+zF4wnzOnYlZYAbtdbFUNGSxzdPodB7Ap6PEuRKKpG52tZFsnrT+X9Fz17BsDKQBe5YmvE4cl4B4=
X-Received: by 2002:a05:6102:dd1:b0:4b2:af3b:90e2 with SMTP id
 ada2fe7eead31-4b2cc35dd51mr31456579137.8.1735627344677; Mon, 30 Dec 2024
 22:42:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Dec 2024 22:42:24 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-1-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <20241217-pks-use-the-repository-conversion-v1-1-0dba48bcc239@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Dec 2024 22:42:24 -0800
Message-ID: <CAOLa=ZRgzD8SPpfKcF5Ztr1f4oVfjP7HumvSVTTLbdLWW7PmSQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] progress: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000057ac04062a8b3bb0"

--00000000000057ac04062a8b3bb0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Stop using `the_repository` in the "progress" subsystem by passing in a
> repository when initializing `struct progress`. Furthermore, store a
> pointer to the repository in that struct so that we can pass it to the
> trace2 API when logging information.
>

So that's the only usage of `the_repository` in the progress subsystem
currently. Makes sense.

> Adjust callers accordingly by using `the_repository`. While there may be
> some callers that have a repository available in their context, this
> trivial conversion allows for easier verification and bubbles up the use
> of `the_repository` by one level.
>

I think this is a good approach. I would be vary if we ended up
introducing more instances of the `USE_THE_REPOSITORY_VARIABLE`
definition. But that's not the case here, we only do so in
`t/helper/test-progress.c`, which is expected. The patch looks good!

--00000000000057ac04062a8b3bb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 288c7e8dcefb42c5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kemtqZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejhmQy85eXZvVFJhczRxME9LeWxreENLQUlveDB0QgpuNVJySzg5aFVt
RFRDRjhXUUFJZ0Z5WkFtOTVrTHlZdTJJQitGKzdRNStGRStrNWZBeUt6YTNRcU9Ud0Z2b2NJCnZy
cjhmWHFzNTdIN2lEL0dDMUxmcjRRaS9xSVh6QjdkV3lhSVBMZmxlSWZpNUZoZWdtMFFobDJyRUZ2
OVZ2NGUKUlNXSjA2RVBjdlI0dk5GdzJnSW5WUnZOY0JuRkRHb1gzNjRSK1V0OVZmVnp1MkgzdmNW
NFF0QnJoSWc4WGJRcApwNU84QWVWeUJuSmdpS1l5S29BcldMVGtadVE2VUFYZk1wSFUwM05GMjlC
VXN4ZGdpWlluQzRLbFZlRmxCcEUvCkozUzJ3M2FnWlBuUG9JRGNCaUdIRk53eEV4dFl2Rk03RVlH
VXlNcnYrUVhkbCs0aDkrcGpJM2tKc01wS0VKZlcKNUdDUVFRazg4bm1xZk4zOEdjb2xGOEtRWGE4
UkJ2VGdWVmhJNjN6WFFmUEp5N254NWthU0hGdmlNSkRieGswZApyVEdqNUJGZXlOTmpYV2s5MHdz
YVVaZjM2TUVGcllMSExQTWlwbDhuSXgrMDV2UStScWFEenQvRXU1QXNRaTByCkFPajFjVW9iOUx2
TUszeS9FNTU3U0hOYjVHN3FtNDlKYkRKNVNjST0KPVl4UzQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000057ac04062a8b3bb0--
