Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54731197C
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453148; cv=pass; b=sR3J++h5DVlug03B/qtt66Nv8DxCltmNRd3Ha2ULmUw2fVRwkUaia7fS5Sct40vRCndWvVubua6bull/euHWWwWYP2aU5W56JnI1ZJkrU3g1KAel1oPQJg4y6Mb/oiv9x8a/H9kZaeZetkw6CdeV9VNR1LlP999PttnZxGvpb3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453148; c=relaxed/simple;
	bh=FRxCWX49DdKW2YuCLe32L0vHy1RBKpwQEL7f5fSGczo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7SII4YFQfbygT8/8ujemYWa9fOgPRMabXGTKG6bsao5PyqhKxdasIlEbuuIQ1Nd07C3i7Z3NRWmjc3juz8c4oFzXxUASSFrL8jGwAQOsMRbXnQIdK6BCgxiYhN1njzhmZZP9Q34sgAPGRNfL4nOFO2GQsXd4WFuRcwjiF3Xkoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syJV5r5w; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syJV5r5w"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-74ab99038afso411137.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 09:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453146; cv=none;
        d=google.com; s=arc-20260327;
        b=o7KeJLHWPH5+8SwRHu3mmoXWN82GR4872IlJ8OZ/UIpJuMecsKHilOcdeNR6MIvc31
         TL6sj7E2XQVlRkSGlUwVIWRtsQfMjj0MV6e2hZD48ht5FYGPB0sWREKG3n9ObvtpTdev
         5D/yWAseWDXylbLUdENnoB5c4WOd1z7xRYNmrVCN77B4F6JrfxYUdCW/ImigHf2tbjzL
         S+4GfqO7/QEEHvZ5P6b/Vq/Tkup/D+HTXX2dsv80LyQuCM9LU6f827msCGijoIBFl7vu
         2eE8tdNMMEUDDPaCPr9+X/YX/ogk1YowKewR3WWcAGN85YJYSO4OHTzysBIx8gCz5OxH
         GxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tCHGm81m60nKCUfi6w6y6OVvBhHRYWJb0KG9oXBxw0Y=;
        fh=Rn9EFvid+bDsg8CskbihT0m5GvhnTPnaZZUMwd/52l4=;
        b=HZ3r4PirBsV8zbrCrVtgZ2RnnUkMhJudvlQuOgzhMzV3ok5Zj2re9Na1A0r0aVkah1
         VtS5EBor4PTEjBr6NIoJ0Px3yfFKqMbs1L+SAfqrNq+2G8oxDiBusbUMCZmOyNwY7wYt
         u5ABowweSBwNnxWx98/FIHMaHadjrb5SJccUhf3rx7AyBMWjoXuq9qHz6tVb9fGpRs+i
         Nr007nrRHfHvD3ZZ21WmCRj3Vf5wKFzW+w2AKijlnfrkRES6xWi7FZDaVe4QMNeizLOR
         5zTokULwAr54mq9oNyFgU4OgTP8eF2BXCmQLwSLaGPikxQTjhKWCRp8S2qfNTahUUeki
         /k2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788453146; x=1789057946; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCHGm81m60nKCUfi6w6y6OVvBhHRYWJb0KG9oXBxw0Y=;
        b=syJV5r5wjdAsDiHyBqI2NajJ9/TRGUod8Jd1PqSqF4o6+SH8nCCbzBr3dqo5cyi/YL
         MzuhzFLfPtQmBRMU/zBAtW2VzaAABQ41K9MfmnGW/m1NLCohddDhVqonCKX2mV0BmSPj
         SmwkUOsL5wRYl+ekQNUQgQ1z5qrEEMh9Dd5H6FzmUINYlnqm5NVLYt+iPqqeRmv1tpSU
         VeosrPmfLjHxAGeLWZfWxVch/rHwAElohnipMWUKxetYo2txW3TIxGk9PB6/B4agiL+d
         bUGn/w++4J0bQUShFj8sh1y16toVyAoR+Zs9506p+lR7g2cLrOkvs1n87YMV9yK16/kN
         5SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453146; x=1789057946;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCHGm81m60nKCUfi6w6y6OVvBhHRYWJb0KG9oXBxw0Y=;
        b=dopdZxcCPeKBb1fEzpggvisQIPeidHIA2NK0CHECgnv0TOmLLNbxNhwAoQH5jioImW
         W//goaP6Q4qW/WrGI3dX3yoY1sfV1jIccSf2+l14esCX0UxSaSodeKapZk/tCKo/bbnU
         ycjS2ljJQiwxdljyiXVThjeXG9+Hz7ZJnw6SuLSX7Y4Nd5HIS8Y4K6fog1VRvwiYyByn
         1bkaNx8S7oXgOXZDVeTQAJIUUiuwqcul9jg0vIAo19spP0JknktDLpotBo3dg+PWzahU
         zHd10RSoooHMk4vwFMpGDJn24Crw/UCUnaiB9Ur6vU+3H0tgwYT/f93/xkseASr2uvTR
         J/cA==
X-Gm-Message-State: AFuF++nt5MWTx36kWEKE9+AvXI0WPce02fdO0cGJ2uq6NndyFu4yUmi2
	hiiktp1GcKIGa9+QYNzCJcQbs4WlF4HtUx/Y1i2jjAgGMyCHzRxeHUcOOMMusIWGitgTSeLIuUU
	NhHf4FdI/MHaL0YnOB/7yejjHTCu75Sm2fOZ+
X-Gm-Gg: AYBFou1FR8UVx1RNx2HTLmrCyDhmmj1osAp17LvJek2+rimurBP9i0Zd+J0UYX15Wcd
	EeRngis8Un1fRpOt6xX2oOe4/Wx1eZsOjK88ZFH2z7nu7rxZRUEDuxKDgCKPHeyi5NT+T+oKm4B
	3dQhRIkQ4b5tZ/kxOflS2b+8VsGDwcynVmTzCsq6pA+vXRI86f2M5ggcuZgcWf/MySVO7jIi7c8
	1RZDvJmJaov172Z4gkkBQkoPF9QgUdb4tqI6l43+CY4OcT0JfI/5WZ14AtBPLyLUMcU2J/u2iex
	vkf/dyuWMijDBv+tivCRkOkAwylf16YdmGpP+Klp9qNNv3tiUyZTIHFOX+giRc5gIJlWMvtIhqE
	aHQAqmRd9IvJuAx2wTd5LcDJTbbcht80yemQ=
X-Received: by 2002:a05:6102:fa7:b0:786:dfa:c5ea with SMTP id
 ada2fe7eead31-78a1f233c09mr6201143137.5.1788453146105; Thu, 03 Sep 2026
 09:32:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 09:32:22 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 09:32:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aplGBSWKfn02k7Ku@pks.im>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
 <20260903-758-introduce-hook-v6-4-6283b1fb9b1c@gmail.com> <aplGBSWKfn02k7Ku@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Sep 2026 09:32:21 -0700
X-Gm-Features: AcwNN1U-BrAmCctfgLuMOhAhf24PU7m3l1M4uklJxK5yXmqa1O47rXR30m9jUnY
Message-ID: <CAOLa=ZR30-=dBrayaWMZAv6Zm=u3w_Va1vNcPGBMmXpVk3V1Ag@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] hook: introduce the receive-report hook
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="00000000000078cd08065a96b2ae"

--00000000000078cd08065a96b2ae
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 03, 2026 at 11:28:01AM +0200, Karthik Nayak wrote:
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 9ac10465ac..edfd5cf9dc 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -2535,6 +2570,13 @@ static void update_shallow_info(struct command *commands,
>>  	free(ref_status);
>>  }
>>
>> +static void override_cmds_error(struct command *commands, const char *err)
>> +{
>> +	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
>> +		cmd->error_string = err;
>> +	}
>> +}
>
> Micronit: unnecessary curly braces.
>
> Patrick

Yup, will remove. Will send in a new version tomorrow, if there are no
other reviews.

--00000000000078cd08065a96b2ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a8b3e984b3f54066_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWm9SUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2JBQy80anhNR003WDM4WjJRenFVOHB4a0VUZ0R3ZApLNEFITllCYTBW
NkNYOVpJaFFBM3h1NVZKZmpHOXU4bGVXTmFkVFNjL2luV2JXdHpXMTBST2t2cVorUmc3UDY2CkhP
US95WDNzdXlkNEZ6U3BDVVY5MUg1VWNseWRjeG1yb2hCNmhjbmo5eXlDTHNUOHppNXdMcEpkdHNQ
TjkzTVoKTWlDRHVwd2pFcnpSNkRxY3Uzc2Y3cGlyVmh4QWVJbmY5dFFTRmJUMFVOelZHeGZGQTZX
LzhxYWVoTDhORXRqVApHM3RSZ1N1REpVYmhuOTlMTVBHMzdPS3JyTGhPVVEzb1NvVHRkMmtIQlg1
QzY5aEhFR0l0K0hsZU85dXg5Qk5DCnRJZFFZTVJ3Vk0wbmVIa09vQ1B5WGZiSXBRdm93YVlwUm56
dThzWWo1Ui8vbWxJQmZyaUdHMExuMDNuNHNGWUQKMnl1YzVJLy9DN04yY2FsTnJ0SzNud2Y5ZTBZ
RHJSR0wraXBlSXhGZE96bGNER2FmdlhwM0l3VkZsQ0piTGpNVgprdkNJYnBiQzRqbEFGK0dxRE5Y
ZmQxbVFmUkI4N1UxY21JcUhVcXRydUNTZkliQnRxaEwvempOaCtpRFlxN0hMCjlNTGUwYy9PcHRY
czR3dDVXS3FhS2VISHpQM2k5NW9pdUhuc1UwQT0KPVFaTEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000078cd08065a96b2ae--
