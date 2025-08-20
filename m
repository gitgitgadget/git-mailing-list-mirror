Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF072D3231
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696909; cv=none; b=bUMcO2ZCOWyNiQqDtxsDsumV+ckcNhQkWyFBfKWfrUHz7JS6EBvktvrJaUPdtGT9rzSJfmftkbAq7+8TjnHXfZuuQOK2uA+tLZSm6BM49/V48wpTOUOQsSHvxUaNC6u3Phz84kgo/JZlG5NCMcOpjwAtCy8Wp00Dq2iRVuKQFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696909; c=relaxed/simple;
	bh=r7uPCFeiuF68ZLiMEUg044D7WyqqBngZh5lXdSjjV9c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=bHnrRoohHCaw+dO0kMA84A5lUIFj4uSlh9O6QQuGfGOuiJnPbvz7cVRueaGFW8x5eoCq7vGaOJZHZHdKU3QzsbiXuAHfc2gJQ0bkta+ZWGR8EWlt5NlTy7e38vewCshtSyMLe1LPSa2tzWQrhCcL/mnl7JGR+Kl1zAz5V61hGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5E0ehOs; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5E0ehOs"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-50f88cd722bso1945576137.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755696907; x=1756301707; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7uPCFeiuF68ZLiMEUg044D7WyqqBngZh5lXdSjjV9c=;
        b=A5E0ehOsna/w0nn+W84rkfDejmyxzzTyzLSd/icoVLDFuPobaQlkXRLa+/bxZkG6m/
         cLO0d69YZxpEEOJNb1att3povQY2bpgNzp4wLcNxw7+cJb4/DCI4K92TDwQmvzEMOylA
         mK5/X/H3T/MBtXkQJlG4kTuXTIXICUMCc1Y/PoN30ApfZkJtttnJ+mn5tD3IluyHKgCh
         S2FQMq4GWkN0VQdHazsA7+iBKw4LlssWOoSvUDbvsOlaZfEsZhzSMmuoFCanFghgxlgR
         YlVcS0Mq/wZDUnlWlv7rMFLOtCU2qDEcN0iO849GvfvwcRjZzeBXONt9I0T8h98AcbaY
         2Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755696907; x=1756301707;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7uPCFeiuF68ZLiMEUg044D7WyqqBngZh5lXdSjjV9c=;
        b=YBG2wU9ZuPMsRZU/kUQuG5Ic5DT6jtstq9LNGGI0CgiTHas2GN3z2/kl9IBWpAiANc
         +39JAQcaWVN9NtkEj7lQtgOs1NxrvBsGTSDUcix7sz7VRMFNRmo3ka3Mc1XNRTpoBhgD
         gRDnr9BG3PdEC2zulffGqlXXL/wiIGjRka0xpWj6S/MKm1qXQGJXD381Q8TikJRNMj1J
         zrNF/YNjURwjh6DECSfWQyEUnA/4IuMODu6UxaWyL40Fq4sV6lVGyu/cbnjW/nyW4Cei
         PoZ3nhR2a3uGPeyUpJnweuzRdt72BK2vqvDdyiAv+FpajqCyOIBddNwxfnkSxYptRZ17
         IDGw==
X-Forwarded-Encrypted: i=1; AJvYcCUWWY/Zm0cpP7BA8/KgfzBoW5kFIpxUaX0ug9WzNBLBOnCu0WZKyTCegSrc+5REGws0Flw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTYzCZCTYJElD3CtB0DXcTA0Aqr08ZIIUSHSQbo5I9khOS1GG
	+dHELy+EO3M4k7sFF/GICgB2Eu37TFWG+RWJeiyE4wSHcbCa+fJo7HJHwtzFTKG520huV3MYu5x
	ZnD773ga/borDFEQISmyx1NgBIfJrYw6/Sg==
X-Gm-Gg: ASbGncuiEWgMJh1TWjNZiJsYgjJ23edTgaPrOkW9lEw3LhXtIcZRypgCNZH9i51ZBI4
	B8s3AGAqnWIe3v/zXI5kMwPvdT9xgt+m7yoo5HOYdAtL0FYxA02CfX0rV87kTOyb26tdx045KWp
	4AnsVkE/XIcrBWzAcd0Taj7hclFMay3te+60u3EN/Q6lx11vkaf91PREszSBqlBy29mLIG4bljs
	11M8fr81Q/ck0hI
X-Google-Smtp-Source: AGHT+IH1sJ4kK/883i03fdxQ/EFRHVIsMmmHk1YvNvOgMr5zZWMWXIZvD6ndvv5dVvUvG1IzHd6AhAX4Cw8zMQlsWAg=
X-Received: by 2002:a05:6102:5716:b0:4f7:d553:3cfa with SMTP id
 ada2fe7eead31-51a5076a069mr955760137.12.1755696906958; Wed, 20 Aug 2025
 06:35:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:35:05 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:35:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-11-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-11-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 06:35:05 -0700
X-Gm-Features: Ac12FXxA4bwRu1NFVmF91HoKuaXpuFsXei0nPJl2VYuT-3bIDGjP_iVp6V5rE1w
Message-ID: <CAOLa=ZTv-=it8WSDx2SwdC99mzUF=0q9NJvp6yWwHzCThaL0Ag@mail.gmail.com>
Subject: Re: [PATCH 11/16] packfile: always add packfiles to MRU when adding a pack
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000791a30063ccc0a73"

--000000000000791a30063ccc0a73
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When adding a packfile to it store we add it both to the list and map of
> packfiles, but we don't append it to the most-recently-used list of
> packs. We do know to add the packfile to the MRU list as soon as we
> access any of its objects, but in between we're being inconistent. It
> doesn't help that there are some subsystems that _do_ add the packfile
> to the MRU after having added it, which only adds to the confusion.
>
> Refactor the code so that we unconditionally add packfiles to the MRU
> when adding them to a packfile store.

This makes sense.

It would be really nice if the internals of packfile_store is private,
that way users wouldn't know/care about the mru in the first place. Till
this patch, we seem to be moving in that direction as more things move
into `packfile_store` we can slowly abstract it behind a strong set of
APIs and internals can be kept private.

[snip]

--000000000000791a30063ccc0a73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f3b792114d97180f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbHp3Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menNEQy8wWWpkN1JNYkRNVlBLUVV1amdvMFJnRG5rSApOTUJsL2lXZXV5
eXRzNjIyVVhOTjhEUWxJS3V1Nng4WjFENGpYU2VwMi94ZlYxQkJHajlHTXBLMjI2bHJFcDliCksr
Q2xoRmthYm5ycXpXZ0hEV3k2ZUFXb1JabE9XNXcvMkhIRDM5M3VodFB1b3Ara2NCZXFhWlNDd2Rv
c1NydHkKY1RlQmtxYUMvdFhyZjJ6NTBjaXN3d1MrR0JJR1NMOHFNNFU3dXVXalRHQ0xCZVdoczZI
R0NYZEJCcXlMVnUraApTUUZySllUd0V1eDZUSG5yN3I1QWJhV1JYWUxNTWIyaXZSZ09jc3hXQUtO
aFlBSytoZk5VUWhHZmsvVnBrTmJaCjJ6RVFOS3hwZlNWdEpNNDg3ZStxVTZ6MGZrZTJOTlhYcWdT
bE5WTVBubklEWWx3TVdBYi80RHNsQ1RLRnpXZEIKWDFWa2d2R3VKRHBId2k2a1V4dUdDL3NWUnBE
M05meTFCd2cyRkgxb3ZqUU5YNWg0WEVadzBIM0Q2V1cwWUdBcwpmSUx6RmRMdDBOc1c1ZmZRQ3NB
RXFhTTVKakZSN0E0SDVySng0bjQxU1JNa05oWEY1dlVPemxUMlJxWEx3ZCtWCklJZkdxUXNyWmhx
RitEcExKU01oSFRqYTJVSWlwZWJXbnZ3Z3VDdz0KPWRzRWkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000791a30063ccc0a73--
