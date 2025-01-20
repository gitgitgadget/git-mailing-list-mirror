Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267A1AF0B0
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367646; cv=none; b=g1415wGF6zgV6aJVvFUt1I7Jc7rxp4T58LqmxGayONMWPAulbINDLJq/rKZmH+8xaPZRlwhq3ng1XS0KDIfYp8f631S2w3mMlB4rHddyCKHUsXZU3mG1IKs7egIYFec6Fy9vDkc5PzL4lLqRSVol8w8CTXx3XQQZc2FfV+7y3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367646; c=relaxed/simple;
	bh=DIrXZTd4OIce/SonTitxdQu6SbDB5HRR+y4H3DzkZFo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=PAwMD2MaTg3vfZuH3fJuwTnrt/IvzAeo0IDV2C131dFAm0vqRpqbd8rVA3HsTMAv2la8gQtnI7vfbmyNYWc8xS3cDDpUEGv5NVxRpQ3K9GXZzTxPYEB8GKQo7mUmr8MwF601r3gL17CyZ8zRhPTLFrfZc01379y0ThrXCCezQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgzS92jj; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgzS92jj"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85ba92b3acfso2034363241.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737367644; x=1737972444; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIrXZTd4OIce/SonTitxdQu6SbDB5HRR+y4H3DzkZFo=;
        b=EgzS92jjt5rcHQbaGd8UmpvI7aE9snpQzpVDG0R6eYs42q9UATPblwpAsLi36JdvgP
         lHSqJ7dE7UGQ2kfkZyz0AruuZdDFf1ooX/2E4qrFi065bQLQ3/XxFccn+wPBGRdQiaHn
         8IayTSEU+idRVYExRCInhBqzNn6BAjjJZu5C2fJ8GL8uxeW+NNLBoffZ4qnQfrYogtGE
         OWdavyPdFnlcxnMsg3tM00r5kBIGUmiTGi6ault7/eXie+sQygCvAlWcNMn+wQwuBv/d
         OuLwMR5Exv57uXDtJD1AYcWrOwhuntYieg7zXnsT6sQqo6LUU8ErwJiSCp6mpJEavbrU
         Yrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737367644; x=1737972444;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIrXZTd4OIce/SonTitxdQu6SbDB5HRR+y4H3DzkZFo=;
        b=sAPkyH5AXgCKyHxbK9i2GrbMwWEOn+/TNTfnhSe3HmGlY5d7yIPT75tn2cHCZ6iCRg
         FDoI9QGfz5Q5SXKMJVCiArKFtuxLdzT/UWd8jZ2Lq/X0lUgcPu3zSjdrdua2dfvdDurr
         2PS/J6DIzad/kF6QPPzJ1q7rBaMTv6J9hHB4trG5RThmSThmOIuG7MB0pgCkTWYHBXBY
         1980Hw+DH5QwYzWZKs8PVeiLKFd4j01Klqu/5PhXNVm+jiyjtUdPcs6uYgshjFEAjEtS
         VnCmzR7XWpe9l+XJckgG/L4YyympFNWh/Lnpi5tRbUidlh4/hqtM9rmJ5aBFOBFrphB5
         2g3g==
X-Forwarded-Encrypted: i=1; AJvYcCXHQfSrp5B6yizxICxFSWpzdVMoZz7gMj5u+9PdTeQNdlpUyAlQyioxYsZeCK3sUpuZpqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwywEt/GADKMHx7oMHfCmBed2YDy8GdwJifwvUpn5hL6v1kUa
	ab5nh/P+VIDGVm+tnAZdUXlljQ3duuBJ1YDdzTlK6++1GjE8joChuyMMjB76Ng35rQ3kIKH726C
	I6Al6HkK4F9l2isWHpysl/zyx/8E=
X-Gm-Gg: ASbGncvJYOt0SeNODL5urz7XUxOCCnqgeb3/A2GzIMmPTAZQsqT0ziojZUt4ZDLf/0d
	dQWtVZgGXcKBrR2lfxbZs5Dt66RWvaAO4UmE+bL0RFbIXFLJM7bbv
X-Google-Smtp-Source: AGHT+IEwU9/vq0OvmdR+nRCnXQhdcBUpDAv5hDS8rsclRQ4wH5kFVR0xXyFuR6XYpqdrPy3UEW7dFp6AluH2Agr1ju8=
X-Received: by 2002:a05:6102:5712:b0:4b2:45a3:59fb with SMTP id
 ada2fe7eead31-4b690b7beacmr9942794137.2.1737367644156; Mon, 20 Jan 2025
 02:07:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 05:07:23 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 05:07:23 -0500
X-Gm-Features: AbW1kvYTQUn5JFRsrpjSJrEbhnMt41vZBgu7KyboCKHo4oztLxF3UKlFJiS5Pb8
Message-ID: <CAOLa=ZQXF8ewDVmusbXPSCPPp9qqj2JRTvZeiiDZRckG5BpV6g@mail.gmail.com>
Subject: Re: [PATCH 00/10] reftable: fix -Wsign-compare warnings
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000465387062c206da7"

--000000000000465387062c206da7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> during the last steps of converting the reftable codebase to become a
> standalone library I noticed that the new -Wsign-compare warnings
> created a bit of a problem due to the `DISABLE_SIGN_COMPARE_WARNINGS`
> macro that we started using. As a consequence I wasn't able to easily
> drop "git-compat-util.h" anymore. This patch series is thus addresses
> the issue by fixing all sign comparison warnings in the reftable
> library.
>
> Thanks!
>

Most of the patches were straightforward and look good. I left only nits
on one commit, which doesn't warrant a re-roll.

Thanks

[snip]

--000000000000465387062c206da7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1560bce8c6c94b59_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT0lGa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHBzQy93TzlHRDNTc0UzVFdFYkgraXowUk1wOXFKYwo5cldUcEMyRmli
MGVqZCtNZHgySU9PRXAzQUI4WHN3dXoxamZ6R3N1NnI1RnBKT0VkUjlOUlNRaXN0TnhMVGRWClJx
RmowOEVkbEMxeUlqWHdLYnlpZWJWczZva2tZZTk3N3krd1BUKzE2T2JydnI5QlcyMCtWWUVkb1Zk
K0dzMDIKV3Y0T3pKVzhwZWk4U01IMC9pTFhVbWNrTkxXcFRwaU9ncHQ0citpRnFhM3I4Z0hBSngz
Q3p4eWVBWDF4K2hUZAptaGc0ZWkvRVk4S3J3L2daY0xGTThSb3NWZ2x1NEU0T0xBa3k3dkNNOHVz
cE9Oc1VTMWNVSW9KWXp3ZmNIUS90ClFXSmNUMEh6Zk14bkh1NGVybWFhS0hjdEpCMVdVd1p6WTIw
YnZwWEwzcnlQZ2VqN1NGY2Q4L2FZVGZXRE02eU4KbmFtWTZoV00vYVlXenlKMUxOTVBRNTI1SVBW
WW4wQkJjcFFlcDdXcktCcE5LL2ZYZEhCRHRvdk91KzQvTkJhOQpUU2xwdlN0eE5leThyNUd2YXRy
eGkwQjZYNXUvNEJ3WjBkZzVPZW03VG9zNmpobzFuWDVtNWNoWExMSzI5RGdnClVoc0hYS0twY3VV
RnRpL0NlNTJmMFdibTVtb2g0VmhwbHN0OXJ3bz0KPTB4emcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000465387062c206da7--
