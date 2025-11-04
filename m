Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033143115B5
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244893; cv=none; b=g6LgB54/RNtxPY8qDlWI2CoWpN17GxP0aWjwCk3/Vo4xA0CF8cOqDqZQoxqtSO/Z00VvdZd9/t15RO1HXB7qeSGVYQW2WBBvlFsJyebZq0Hmk25iPgunRua3rhNtx1tqj+EuL3dBGSDGnVQ3akEQngR3ImTXRfdAf9MHV76fMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244893; c=relaxed/simple;
	bh=374nyAIqVN4Xq3s4ysRaMAnpLfh0Btej4aAbjcTaGA8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFRT4F7wXu8Z1t4Ls6T48oIEY4d62KWhndc7996QKBd/3GtpttdOWx0YtZIrZMho1iYTOTwy+JyV8YHYctUBpD7tnRZQZAn+jMLztHCE8oilwtXxiXshSfI1L1N1Kx8+vMqT6d5QHEP54cTdfq8dpkoKpe/BZ00JMr1tGNKCTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCBtdEz0; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCBtdEz0"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54bbe260539so265941e0c.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 00:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762244891; x=1762849691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFfx3jXXoofJnQVrpgZwkZMNNajkwiuN39mf0VwmH58=;
        b=aCBtdEz0AToOrTptux4kzLhmhrsmgwZQJQYsu2GuZ4ZVPoa2pK9JD5ZdqyNPrKpo/n
         vYXYAIl9Pi5ZcasiPIjbUbzB6I4i+WI5yUQYeCit3ul9CAhGcX9hzvc42g/UUTlFwXik
         6/zXFgvVjTedxDKQf3u+inQefpSkFqZVFJVrEajNlwx1aJsvXZD3yaZhGc3FoIC5vMpw
         2M6haugHelksJLj908dbSzr5fpC2hq4f9AUqvIROB5n1WhDt2+qUirYI3a3WrIsnbP85
         89kiaQK8efKkL31nOc/IfLbd1UiWPWfULSx3+ZGn+RpPVW6ZifB7nN4LzAJ4tTxurOKu
         sQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762244891; x=1762849691;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFfx3jXXoofJnQVrpgZwkZMNNajkwiuN39mf0VwmH58=;
        b=n/8+Cyn9ThOIL1EPE9g8C5IH8uXzeN577AIolFaJA2NPrY13i40TnL1PNbHtG2qjUv
         P3iIWJKRxLQw3EqExx/27c04ZNrZknSyosd/wvt2vkLPOmVdhmNcvHvfEs+wR1sANO1z
         wXezpo90cI6jqVGG7FRsNc/pI5nYiR0gUcUgz2EH25uPETsDDDlaHY7w/QvHKZ7j2AB5
         DCoNsVBGvGIdbwUWY1gYcflYHoP7nwZfjqj7Kl88Logw9ltaJHu98WliHVFthJbn0ffK
         OFMakSjJUvrULXV+Yczv5zAqdKaDs2KObScLwQk13pX5nJthTL/6VE4bt5mZjeHluiCu
         u97g==
X-Gm-Message-State: AOJu0Yw5gQBWTQOQWa/aohIxS6J7WSwOunAjpDvtuflRInSHMHECpqaa
	zOXJP+HF2TkG2cNt+nZkcjcm2mouO6uwEmQZ64MIsGuGvIGe3c3XYymLdyHMRPY7Nr6MiLaIixb
	7qhN2R5ghGb8XfNBe0VH5Xwo/KuHx/q21GnIB
X-Gm-Gg: ASbGnctD2yv0NEobAvs1bWMtTi/3aH97xVKAFazKI0qQoxrr1nSovMjVy3EOanNV5iK
	9x96KZ2EUxHaUeE+YY5CGebaursN9Udh/3LQN4O0FCL9Tm4jFQ6nhw8IRknITn5VPiCtVHB78nY
	O9emhYtp8x29jklcSYdkCMDQjhrGq9dQD4eT513Hn8OuHVTtVRYZDnv+PoZmQn0+zfaWx7eqUYZ
	Ic/2DrPSWqUA/URJ+Q8Gchev2r259zntVDFpuZia1NCxC/w8E12OmAxgoXYCSb6b3S3VaWcyrFQ
	koh2mwUiHT9bTUL58ZsoAvrVv0A=
X-Google-Smtp-Source: AGHT+IE/5pGTcq4G8qto796gI0/a5bsDd/t2WbxYpZADymKFgIWeKSBIY+g6rNHQjwKH+w2WbMVHfrtky8yENLfXMcE=
X-Received: by 2002:a05:6122:3386:b0:559:6723:62a3 with SMTP id
 71dfb90a1353d-55967236961mr2010672e0c.15.1762244890588; Tue, 04 Nov 2025
 00:28:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 00:28:08 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 00:28:08 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQmU_hOPO55_ojw2@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-5-a03d53e28d0e@gmail.com>
 <aQi1g9TX7FoDgo9n@pks.im> <CAOLa=ZSsEygvz1_aj4KomfF0Jo0vJi3yVLtJbhLX=RLgW6_GzQ@mail.gmail.com>
 <aQmU_hOPO55_ojw2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Nov 2025 00:28:08 -0800
X-Gm-Features: AWmQ_blzws0jT1zvGqqKCZSHjHTWYhNc-I9MEF0waggHL1grcUt7DJuyOyw_D8c
Message-ID: <CAOLa=ZRA33ro1-9jbh71QpAa3Sj-NZY5fOL_T4Shyn8jPYQi_A@mail.gmail.com>
Subject: Re: [PATCH 5/5] maintenance: add 'is-needed' subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b6107e0642c09cb6"

--000000000000b6107e0642c09cb6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 03, 2025 at 09:18:35AM -0800, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Fri, Oct 31, 2025 at 03:22:25PM +0100, Karthik Nayak wrote:
>> >> diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
>> >> index 540b5cf68b..edcc88f4d0 100644
>> >> --- a/Documentation/git-maintenance.adoc
>> >> +++ b/Documentation/git-maintenance.adoc
>> >> @@ -84,6 +85,11 @@ The `unregister` subcommand will report an error if the current repository
>> >>  is not already registered. Use the `--force` option to return success even
>> >>  when the current repository is not registered.
>> >>
>> >> +is-needed::
>> >> +    Check whether maintenance needs to be run without actually running it.
>> >> +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
>> >> +    Can be used along with `--task`. Ideally should be used with '--auto'.
>> >
>> > Okay. I assume when `--task` is not given we'll check all tasks
>> > specified by the configured strategy? Might make sense to document if
>> > so.
>> >
>>
>> Actually no. It's similar to the 'run' command, if nothing is specified,
>> we check `maintenance.<task>.enabled`. By default it is only enabled for
>> 'gc'. This is important information, I will add it in.
>
> But we use `initialize_task_config()`, and that function knows to use
> the configured strategy unless it's given an explicit list of tasks. So
> we do use the maintenance strategy.

Yes, and the default strategy is to run 'gc'.

I miss-read your earlier comment, you were talking about the configured
strategy. I thought you were asking if no '--task' is given, we'd run
all available tasks.

>
>> >> diff --git a/builtin/gc.c b/builtin/gc.c
>> >> index 72177305ff..4d20487ed6 100644
>> >> --- a/builtin/gc.c
>> >> +++ b/builtin/gc.c
> [snip]
>> >> +	} else {
>> >> +		/* When not using --auto, we should always require maintenance. */
>> >> +		is_needed = true;
>> >> +	}
>> >
>> > I guess for now this is good enough, but it's not quite true. Some tasks
>> > won't require maintenance even without `--auto`, like for example when
>> > the reftable stack only has a single table.
>> >
>> > Patrick
>>
>> Good point. Thought I'm not sure how we'd go about it. Initially I
>> wanted to not have an `--auto` flag and simply make it the default
>> behavior. But that would restrict us from introducing the `schedule`
>> flag in the future. Which I think might be a worthwhile addition.
>
> Yeah, agreed.
>
> I guess eventually we could extend `auto_condition()` to honor the
> "--auto" flag:
>
>   - If it's set the task verifies that it needs to trigger housekeeping
>     tasks with heuristics.
>
>   - Otherwise it checks whether there even is anything that could be
>     cleaned up.
>
> But that's certainly out of scope of this patch series, I think it's
> good enough to bail on that specific part for now.
>
> Patrick

I think that's a fair conclusion. I'll leave this as is for now then.

Thanks for the review.

--000000000000b6107e0642c09cb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: af901a0638087c93_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSnVSTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0t4REFDVXlia2Zlcy9FblVzbndlOFFDQXFpam1YUQpjUXBXQ1d5WlZR
UHpPWWZBVmh4azIvaFhySm10d3ZOQlVQSUUzNnNhd1hKUUpFWmF6MjVaOCtuNllJdzBSYmdsClB2
TmltbzZ3MTZ1cFJQTlV6MERXalh1eXM5MmZNaGEzYTJFTHpDYys0SUdhMVZ1SzdWNDN1ZE04ajJv
RXVMTGoKVVljTHBlR3FPYUNhczVDZkwyM0lkSW5kTEJ2MU1rd1lBZm1FMzBvVndxZkhKMTA3NW95
RGxkaHp1aGtLd2VXOApubUhIUEIyd2s0bTdlc2U3cEMvMGx0RDFLRlduSk5yb1VzMmIxaFluTzFt
c2lTYWxWOGFmOTNwRW5Wdk1yZU0zCnF0V1BHdUcwV2lmZGQxVUttS0oxdWZwMUptV2RHYkdud1JU
SFJrOFVhSW56VHRUdUZNM2d0akJ4TS9LQ09ReEQKbVlFYlNFeVpWaWNXbmt5RXJrbUV5L0lxbk9u
S28wSTdKT0k3RnVURFRYdmxhcXAvbXRsN1gvT2F2RWhzRmZhRApOOUtydXkwSWJYR1JGNGk0K0x0
dVJtY29TNmY1NXUxR1N6SjZ2L1pzZG5JUTI3eEJ0ekVTc29LYk5icHhkcnIxCmJZQ21RYUV0bHJT
aWlsbTFuY09NQjIvd1Uwcm9TRkdXZXZuTjArVT0KPXJMRDAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b6107e0642c09cb6--
