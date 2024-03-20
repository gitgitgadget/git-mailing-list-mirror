Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C741E522
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978994; cv=none; b=cVG/5Jw8XAmTprKrKG8uG2iEGHu7rIT6a6gwjkLqFc2utzpR7a8kW0F0ITIKM2K9q2sTioV/dVyQAnYmn2i3Noh7O3Pjs8p4Qe/JAuJxoSxRgl3jyXosD1jSCbQJE51or025jL0PxJRkThaakVQOrL+To69regm58qrBwj5PMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978994; c=relaxed/simple;
	bh=rveHHFrkIYAjP2jQndSC65WZtEqM6bc9TVRW/ZzMquA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMTt871jQn3VrzpMXpJ32sfYoCCQJDPxHBcX4x6jXeV5W0SVwfWTRMLzyQZOe3Z+gwLw5WzkHEJ1mRbJnNxig3DhCqhB+HTWmtgbVf5t+4nUAa83XfRSDDa01/Bhd28TxUyQrI81jcdixqg7HEvnT6+YZ0DJ0kTQCN5D1ez1Ij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSNEAhms; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSNEAhms"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a1b6800ba8so192593eaf.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710978992; x=1711583792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rveHHFrkIYAjP2jQndSC65WZtEqM6bc9TVRW/ZzMquA=;
        b=dSNEAhmsLNVE+roGuNX8ttVDD9Dvme/mJ5ki+T//MAlVvDmEBnJE7guAqnxHdQ/P/7
         RwDjF9Xrcg99drULUabeqeI562m3gEjWdYuySTzDQq8Fi+GXO2TscpFkqoW8hn/PrsQr
         GQtOFvzyiClgaQP5MZeb+RPL1RCdwt44kXgkKBTgwnGs9ROn4wbLst7xtC9fuf8VuRLd
         8bY6yiCDkftxYV9Cfn0kNRf+naIVd32C4hnL6+hv2fGbMHpnaJkw4oqFXbqb3OjjBtKl
         yvrIY1Ekzcl045PA9ji/1rDA4PGZYFlMVArNz5UQfq3Q4+Un7stWAxDeC2KRMFn1R6zc
         LtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710978992; x=1711583792;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rveHHFrkIYAjP2jQndSC65WZtEqM6bc9TVRW/ZzMquA=;
        b=ZjK6wqua1J7idZkNnzD3f+aEGVcseQov1aqcx4Gsn5om5EOMD61zmNKhvslaIpjrSJ
         3aOJxhKRdetTIbVSjDqtOsm32eQE3DHF3rd0XziFHIcc4SnANpazL53u59F5PG/GdBdJ
         E/vAr/8RH4oBJNjwjqwWEyo4OkMBkrorhwhRCmDoaUwANZGwj3ABRsCw6da8pQ+Sbi0W
         96AhEH4vOJG1D9xwa/zhAj9EhprXW3QMVdIqr6vwRFonP0LPNKDMWpzbASY2f8n3I0vY
         RqfOcG2w7VaT/WreXjPd3uZBjXhTz7fNG/ZfOec8DkBOusfOtj8eekzmdTI28y0cr940
         VdAw==
X-Forwarded-Encrypted: i=1; AJvYcCUWM5knUXwfLQGOVXRyKgbnmiUzz/Pzhfq9fyDmVjhjn18grly3KizJgj9un4/kW/F7BAU6oij61YRm927rcTYG4dfH
X-Gm-Message-State: AOJu0Yx4fKQ24C01xgWu5uzocEolLDFfMKJEB8IJ821ryALLax4xOju7
	izzFfV4H+PoJZY/mnvwBy04a73qio9j2VMrPbOycSlgkWe8bjZcJGhdA+YYQtx7Ux5ODpQQ1M8C
	DRfDC2AjCApb/71ZVq2NQF9Zqtn9hoNFApf29+g==
X-Google-Smtp-Source: AGHT+IELkiFk3Gi//F8tgjNzRX+mT0WWHhUf4AkbJ6G2zBQujr6FQmc8uc+H+7pOB6rj7F31rwaL4a7kF3JAtGCX0mE=
X-Received: by 2002:a05:6871:28c:b0:222:bbb5:83f5 with SMTP id
 i12-20020a056871028c00b00222bbb583f5mr646267oae.46.1710978992264; Wed, 20 Mar
 2024 16:56:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2024 16:56:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <474cf66b26f5e459dccd60a2dcd1a09eff86178c.1710706119.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im> <474cf66b26f5e459dccd60a2dcd1a09eff86178c.1710706119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2024 16:56:31 -0700
Message-ID: <CAOLa=ZTWvLkzdJMOS4nU=zGhmXS2nSEXzK3Wo2+=jRgV56atrA@mail.gmail.com>
Subject: Re: [PATCH 14/15] builtin/gc: forward git-gc(1)'s `--auto` flag when
 packing refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000000d9f5206142057a1"

--0000000000000d9f5206142057a1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Forward the `--auto` flag to git-pack-refs(1) when it has been invoked
> with this flag itself. This does not change anything for the "files"
> backend, which will continue to eagerly pack refs. But it does ensure
> that the "reftable" backend only compacts refs as required.
>
> This change does not impact git-maintenance(1) as it won't ever end up
> executing the pack-refs task when run with `--auto`.
>

I'm not sure I follow this one, the man page for git-maintenance(1)
doesn't mention anything about not running pack-refs when `--auto` is
used.

--0000000000000d9f5206142057a1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 60399659029e863e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YN2Q2MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNC9oQy80djl3ZGNYWElSVkJaeEtZTk01cjNWblBRKwo2OHpPa1BkNWxj
MkFPQjBoTVlmNzJHUWN4OEFncmU5TmQrK01WcDJPMmY4Vkw2ZndHVitjUlQxaHVUOFpYLzVTCnZL
dWZzL25ZK0RMeEIrNTlKaHJ0UUIwemEyL2lFWnhRQVk2QkgrcVZUZFJrWVEzNHFwaWFlbTIxQ2Vm
cmRJbEMKMngvUjBnTE9IUE1WMDVKeDhXOGxpSDl5aG01SXBWNElDNng1TnQrK05DTytzK09Oa3VL
TDhjV3FnRjZnUU96WgprcVZhUmRXcFJrb0hjV09wbE1Jc1p3cDJEU2JGN0ZHdXpzOUxDOW93bUd1
MnBEV2FIZW0vaW0zM2hodzdEMmZICkJleG00eWEvdFBCbmhTbGlxZlZZVktWVTRHSVlpZitEdEpY
eDBRT29kdVY2dWM1blJIQ1pWbEdsa0FxVUlkMkMKM0JKNUMrUzdWZXlUdVN0WmhQU251bmswbFlZ
ZFoyeUlqbUZLVnowZWtpQUFsQUxhLzMySXRRSS9TdWdRVFpsZQpWcHQ1OXdiWStiVHAwSnFMMHhj
ZE5mSlpGSmRpMElDWERBUkl5eEF6UWp1VDF1U0N4ZzRVSmo0UU9NQXQ4WFJhClVueDRMTjdtMGZI
dXU0Y28rU0RZTFd4OVFYYnk5cm5aUFlVNk9QST0KPXBmMTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d9f5206142057a1--
