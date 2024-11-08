Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860841E1C1B
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058041; cv=none; b=cpA24nbZX+7KsZwitufkpogqoHbxaMdDBjR6uDOEbGlm0FYf9dCAiNVrQhkVRmvQLGv+/FCY/J8Vcn0+GiE0TtrVzu2SK0RNaA6QCoGaWYNhIDK8qfYVsRP1E2sb0c1cghWVQ7idsnqdKTBmSMDKCjAy3w4N6lAVYAulSserQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058041; c=relaxed/simple;
	bh=vBaRQmCcK56EJXiFiFKcuKxPwIGevbGrex7s4Fp9fpw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fupqbc+sq/kco48tysKE/WyWi6llruP+E0MQoM0qWpnUwuzH4jlDhde8LkIOX0AFrVxjZgvupJKKau5F9J9r9iYShYsWvc9q5jUF3TWJWeQazM8HaCduXX61bwEuid8CbfpUCACrFaBBDi4dOJ0zrVQLyulu1mWuq5UbPT7u450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byQF+S3w; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byQF+S3w"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so659945e0c.2
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 01:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731058038; x=1731662838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NKGjjNC9SiF8Z2d6X+0KfbYG3gGkP4lm1lLFOhMPDE=;
        b=byQF+S3w5OfJVIx3a9rrOiThwGALbzkP2gMna/r8U7+6B3DOVse5EmPOXff5gpZcVS
         /mzAd/F0/1q4+JorNiXMcFI3p8sfpvZmZUC52MoAD/ZijGdCSLytnf62FW4HDh98teHj
         r0pgrjv7OgaCeLLVBqNccli5X34PRUHOVyNSLK+vabHtgowkLmJ5/iKvbCggxIC2m4RL
         OnqQWUCAbMZnMtUL+tOhDKfBR6zNj8I8zPRpge2Qo2/8yuL0x0T803TWAobZ5Gl74Oeh
         1oNkqIEFRSuEosd9ltaRseRKgyZ+1PkzxUrlETTdB7F08Bo9rG9EdXKC+ywrd18EIj3v
         CkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731058038; x=1731662838;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NKGjjNC9SiF8Z2d6X+0KfbYG3gGkP4lm1lLFOhMPDE=;
        b=tZRudd8Wmz6RXIsReZDLp4bS8SacD+DnJmJ32FGMOam6c+oD2Q6y7ERNrKGGZ79CaP
         TcQbfJSCrgsjHKKkGtmZ6dF64ZurCwwZrPIgenefJXaMz1fZoyblQEepiDnUi4ZR4jQm
         4o+NK0l0/dRN0wMFIvr51mdneqT/wsZxlqlexscnMFE4FhNZrHhInd9/PqAic+o8SYP5
         VKscDIqGoAJJPrlGql8lGWzWaqStHcH3zqXRoRlNwpNdndWADajC8jw2cwwGvjO5M2gp
         A+QZhmcElMbsPQWVTMaqMQpEdENlBtJJM93/0wtvpMPpMTZ6G3BWxKX8EANoFn6rJYfI
         by4g==
X-Gm-Message-State: AOJu0YwdlHqeOvre29CpNMBOvylL6nJCM1Zxx3vWaXymDHb6XznxWzSS
	LavvaThB4p3cQ+ttZcCnZNhrayCO2/Sor6IzMOkQpedy2/HMjrIK2t8C9DgyB/D+xt6JtR4dkm8
	xw4Nmu3yojxf3706m4dzfO+O8m/U=
X-Google-Smtp-Source: AGHT+IF2eukfyWNX/4fAxZ8B1grrum1qya2jASSJFpwXJx5j+So/mR8geA9DwYE65BGORyD71qLywHw6TwDQj/mmWdc=
X-Received: by 2002:a05:6102:38cf:b0:4a4:7671:7588 with SMTP id
 ada2fe7eead31-4aae168c955mr2306178137.22.1731058038329; Fri, 08 Nov 2024
 01:27:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Nov 2024 04:27:17 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjyqpf1u.fsf@gitster.g>
References: <cover.1730976185.git.karthik.188@gmail.com> <3a8e3b88df28ed65cc8fbce3d51dd1cc19581e7e.1730976185.git.karthik.188@gmail.com>
 <xmqqbjyqpf1u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 8 Nov 2024 04:27:17 -0500
Message-ID: <CAOLa=ZQfU56VnqOOAGNJEeGqdEoKg9Mg0ic9Kfpk5qFepbYXig@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] config: make `packed_git_(limit|window_size)`
 non-global variables
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="00000000000075f6f00626635b4b"

--00000000000075f6f00626635b4b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The variables `packed_git_window_size` and `packed_git_limit` are global
>> config variables used in the `packfile.c` file. Since it is only used in
>> this file, let's change it from being a global config variable to a
>> local variable for the subsystem.
>>
>> We do this by introducing a new local `packfile_config` struct in
>> `packfile.c` and also adding the required function to parse the said
>> config. We then use this within `packfile.c` to obtain the variables.
>
> This patch has no string "packfile_config" in it, other than the one
> in the above string.  A stale description?
>

Yup indeed.

>>  		if (!win) {
>> -			size_t window_align = packed_git_window_size / 2;
>> +			size_t window_align;
>>  			off_t len;
>> +			struct repo_settings *settings;
>> +
>> +			/* lazy load the settings incase it hasn't been setup */
>
> "incase" -> "in case"?
>

Will change.

>> +			prepare_repo_settings(p->repo);
>> +			settings = &p->repo->settings;
>
> This change is curious.  How can p->repo be uninitialized?  p is a
> packed-git list created in some repository, surely it should already
> be initialized, no?
>

Here `p->repo` itself is expected to be initialized. We're however
trying to initialize `p->repo->settings`. Which might not have been. If
it is, `prepare_repo_settings` will return early.

>
>> +
>> +			window_align = settings->packed_git_window_size / 2;
>>  			if (p->pack_fd == -1 && open_packed_git(p))
>>  				die("packfile %s cannot be accessed", p->pack_name);
>> @@ -661,11 +667,12 @@ unsigned char *use_pack(struct packed_git *p,
>>  			CALLOC_ARRAY(win, 1);
>>  			win->offset = (offset / window_align) * window_align;
>>  			len = p->pack_size - win->offset;
>> -			if (len > packed_git_window_size)
>> -				len = packed_git_window_size;
>> +			if (len > settings->packed_git_window_size)
>> +				len = settings->packed_git_window_size;
>>  			win->len = (size_t)len;
>>  			pack_mapped += win->len;
>> -			while (packed_git_limit < pack_mapped
>> +
>> +			while (settings->packed_git_limit < pack_mapped
>>  				&& unuse_one_window(p))
>>  				; /* nothing */
>>  			win->base = xmmap_gently(NULL, win->len,
>
> Other than that, the changes to the above block that uses the local
> variable "settings" looks good.
>
> Thanks.

--00000000000075f6f00626635b4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a0c557ebb821aedf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jdDJXOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlBLQy8wYVNicnArRFJEMWJzNWlKTVlQZ21vWC8wbQpJOERWU0t6R00x
T2hWdGpjeFMrcHozWmJwMktrY1FTUjVHOHltWmZMN2ZLakM2YUV3Y0VMdXdHSk5Lbk5WcEpVCjhx
NjFVWHFlVHBKT29FRTVtWUpKRFJGeitDVW05SE5lRDAyOER6TlNDVnczZXQxYkFLekdVc3dMaFdJ
K0xLU2gKKzBnZEUrVWVSb2pMeU12N0MwQU9ITmg4cmcyeWxjTFh4YXdhd0lUWXQ2OVFERVBMbkJK
T3hSc3ZQTVNNRk9IVgpaRmtQV3FHeElaQm5ycnRIaFNjS3lDa2szMzJraWhuMW1jcDZBMnlxd0sx
REVPaGpRWThuWXhIb1Frd0kycHlYCjRLSVFDUTlmaDJxczJBSTlEeDlIT05wSCtra1NhUFFCRU9y
cFUrb2UzL0JNR2JucElVNS81MTdtUkVnU05DenEKMEc0bzdBc3N0cmIyQyttSkFSd1ZOanFmWEJL
eEJGWnVQbmI3Ky9ieEVHalZCa2ExcTZLdW9UeTRFcFlEd1FxdgpIcFRSYWdjYzZwNHl6ZnZ4UnRQ
UUZWRXBuSzdwVHk1Qm9NdVNZZmhjQTBYMUNFQjFWQWFrT3czdUhiNkRVTTZTCjMxMER6SlNNUGNG
MTlSSnNuQ3ZvelRnWnQyVmVzMXdDaEcxckxVZz0KPUFSMVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000075f6f00626635b4b--
