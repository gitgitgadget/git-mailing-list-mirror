Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A719D07E
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641101; cv=none; b=oMKLUMEOIaVgu8otTIPGuOXokihWpKk9m2ZgqtT8TYEWtBbqEQMvrSaZuzYO0CWjCUj93PtSE0J2vIq+lojBfa2k4OzRSIZscEdINZeujc0P5CWwVDUuvqalcY75rOOCWxfUcQYCnlaKnGDguhvxgaZE7Kq1YElc0/IbsMd4GPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641101; c=relaxed/simple;
	bh=KcqSjqYaG9gvSgFkzpeff8b4QsILw/y0y0YHvDKWEVE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Byz+0vYssjfhjiAYcl7yT/eOzWOMVqXd5tN4IsGikALQr3ntSmOZggfpiR9GyQjUXTLFKnj14Gj8aq2SA52kJJFBD3kYyoNBz8Ho/MuxTFNJe5KJRzOS68JVhjX2oyu3K7Cya79V5BQCs+jvhBofaSRjodT1buVT1046bdFslps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiiHdIOv; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiiHdIOv"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so550265241.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751641095; x=1752245895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K2mRFqLocQrNVeknC1oVnBjCUGvRceFFglsT0tSPM/0=;
        b=OiiHdIOvvoKkVLShi+GveCcOw6gU6ciw3WF7L9KyJIv1FoZk8MIjmY5HVE4PBB9OuO
         aWGwNa8sezcajlruT1pv+/Pg1X/NDCW6UwFaJdIFvU3K9q0Ok/4ZcoiuNvkhBOlmxjc6
         sVM/wcnPhTXj9ccrwN/UK1NuoqOBNRO28S7f9JmXC+q0zd47gLoTi+feXl5dvsVhYY+p
         LeCm6n/PPufRKBoC8GYCX7K81V/hOkYcrhvr7jAQIkqKxV078AWE9hiaVKe0tYfKIxgw
         uDrDfKEdMGD+omimKb7feKbSfTSgh+gxbVVhjJiInI2zfKfvhux4TJHFFhrSlV1MLgny
         ebfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751641095; x=1752245895;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2mRFqLocQrNVeknC1oVnBjCUGvRceFFglsT0tSPM/0=;
        b=Chwhu0/lqtoyqzBW1ajm+jGSaAfg9E0CrItaIpstbOAiv3ot7ZKNFes3sKyk0f6LmC
         KC0OkFMyiC04N3+RAZMaXNVtDW4qBP7DSjDxQs23wBz258b3dSoIOeclLl1/6n8CH1wy
         T6BhO2irbfLftaXPoCjGEpL1izeVSI6WqrsdBloKtknMRmHk0fcLP54VWJjxcGGMEJ6s
         aE0gzM+upnXA7CfeuREFmHiOZjx+tGn0XoLD0vt7qV/C4o3E7261nBsZNt5+bC+FvYeB
         iiPMfWu7/rEBQe9309/lRnqWGLwiK4vgJ2zlFzVIrnI3IxsmgT2rh1qvDMp4r3yhZkuK
         VpJg==
X-Gm-Message-State: AOJu0Yy6GBhIt9Gx/YkGUo6F0SSJv9f5sYFR8SP0Ai1ebvPAshoCkgdO
	uls7msmnTV0v13izoR8vkoGF2Unr+ogqBw2du7l/lJzJ5cQfLbyWvpB6K+Z9DPga9RslWR2PQfs
	A6WvS5dlXICfdPnjeTgLfZKhotjbXCA8=
X-Gm-Gg: ASbGncs8cXVs+ohkMsLMx4N4xDT2Eyj3quSm3uD7UXNMXgn5+s5HwydIZhRqCmr0/vO
	um46W/yDOqfb4kCSOa8HM/KkXyweNDHWvY+ngq9gCZc/9EaRiMx5oznirmAydJl5guAx2jVvzJs
	jteeJu69uQnaLZP8MH8r8u0yoVG8+c0fAN0iCfkUnUsWdRalH/sFX5
X-Google-Smtp-Source: AGHT+IFgJEho2udJa2fbhIGqc6gIkz7+aj693Sd2dTFIoZqPPv3HVQSBcTwcVsKaRECA8i/7f6LMH0VaBQu4aOlmEA0=
X-Received: by 2002:a05:6102:6481:20b0:4ec:c513:f3d with SMTP id
 ada2fe7eead31-4f2f1bb51b3mr1168293137.25.1751641095263; Fri, 04 Jul 2025
 07:58:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jul 2025 07:58:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87ikk8c8jr.fsf@igel.home>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
 <87ms9kcbtq.fsf@igel.home> <CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
 <87ikk8c8jr.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Jul 2025 07:58:14 -0700
X-Gm-Features: Ac12FXwMmGLe4uO09xQkOViFDANfhILzRK5sMcik4-58DGt-u28TrbNbWvurJiI
Message-ID: <CAOLa=ZR2=5iZzUVTS1o81a5NhLLiyHLiJfznz2Us5q0VLU74og@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000041f85606391bb98b"

--00000000000041f85606391bb98b
Content-Type: text/plain; charset="UTF-8"

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 04 2025, Karthik Nayak wrote:
>
>> Consider the example
>>
>>   $ git for-each-ref
>>   refs/heads/bar
>>   refs/heads/foo
>>   refs/heads/main
>>
>>   $ git for-each-ref --seek=refs/heads/cat
>>   refs/heads/foo
>>   refs/heads/main
>>
>> You can see that the reference doesn't have to exist.
>
> That is even more confusing.  What is the first matching ref if none of
> them match?  Doesn't that mean skipping _all_ refs?
>

Well the idea is it would seek to the offset where the reference would
fit in.

This is to ensure that seeks to references which were deleted
concurrently doesn't leave the client hanging with no results while
paginating over all references.

> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

--00000000000041f85606391bb98b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1d34eae0bb563a03_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1objdBSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkVYREFDSGUxbUdMSUUvMmg2S2FHc09XNzNNSXE0LwpwQmEwR3VOTVNW
TkFEOGY4NzV1QWJZTStaUXNWODJydk9sOThNNElqaFZwQlpqZTU3OWFCMEwzNjNTcUgwZ1ZZCnRv
RFNXNkVSbmpTTVF3RHZvQkxPanlhVXV3MWVrZ3BLNStuSGZFdEdEaTdXQTJEbTZlSXljaXQ0TFpC
eDczak8KamE5YWtYaWxzM1Y0cjVsbW5CajZYTFd2QnZySlRMeTdoZWZaWUhDOXpQUVdrbXRkU056
cDFqcHJiOUpkNFR1VgphS3JhMmlKY1BxZzhGT3B6eFpyZEFPTk1GZW1iR2pXU2dRK3NBNUxXTmlv
ZVJCVkt5VWxQdWE2dUFFTjg1OXVLCjZWQWFRVDNuZ0kzdXFHVk56SXo0bVFlSWRIQzZaMVBKeEFG
ajBMMGRoUlpwcEJ2bFdjWDdpM1Bha3BhcFZkNEkKUXoybm90RGMzSVpOdjVqZ3JUTzg1c2lkQVRG
dk01UnF4Z1VtaHBvQUFFS3pBaDZ4YmMyMUgyT2FFWFJIR1FwTAptUHlOTmZPMGxYOUdXaVVtRXhx
SUJtbXNZRW1peXZGT3JqYlcvL2pmeXZrcFp1WDZPdnlnS3IwbGFzZnBnb1BBClpqZXB4ZVlYWm5N
NHNyai84TjF6WlBMME9iV2FwQ1VXbmNJU0pyST0KPW1EWS8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000041f85606391bb98b--
