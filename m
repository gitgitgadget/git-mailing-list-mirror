Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B761CC14A
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026240; cv=none; b=IZi0wZE3Amn2O0yoi0ausccQHjdvXiYsewQmXfVBAriajCmyFdX/imb2tnCfgcap1z6SA2KWaIqhTaoBE+6obEtn7aQTAjq6Ij7oUoPNFu5XrOX2ODuKK1ZdbN2AIm4BIWhsx7xYNBzm2Tk3oKSxpzPcVHUhnkw7csJmzVzlLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026240; c=relaxed/simple;
	bh=1kCY6V0mG8b4gNMWjH/z0CB8Im95HlX6o2efWtErfIY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE+kLgRgP9GnBLRU9gz4E32SFwZByZzV14hUuG05KKcNUXv96oMD60Jt4KYBQQDQrPEXwVlmRyVpZQ3tLKDxDakO1osj5guM56SknsXlk/wcqWH90b129R7Vfy3hCE/W8pBeUQ879QpbKnnNnFE6lb9u7uayWCLa2mIUBRBOvu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/xe0YHv; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/xe0YHv"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85700f9cdd6so1170479241.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 06:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026238; x=1732631038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRKFMfgXo9RsyTZd2uqGr3WEsVHosnFaO4fn57HNqBs=;
        b=C/xe0YHv8xklMVf5TJ2/dDQoXoaRH4Rr6Ac7atvuWk4D4Z7mjh1k4L6AwfmLP86vPj
         CE+ddvI5l0LhZxFBKarVCFnQwT7/ETmPSlYum7hlKQzegYarFUf0w7V8qCGUZvRuTwFA
         HGwLqUoDg2Gz3U8T/mE41E5nU0TtBw58WpkVCSsoKx7ObSJEMNEKmRhXua6+6+ivpsOu
         +eLinoNcZ6vn1RhKLemRO8GPMgLlbjo2dt/XqRxcbYeE8FnL+IcknwKolelH066St5Il
         VoIbY4eK0Bb3Gg9lUtgmWFKpTPiW/ghcapm45H9+dlKkvOpSIaa4eyxOVsKwF6T/vZ2y
         8XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026238; x=1732631038;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRKFMfgXo9RsyTZd2uqGr3WEsVHosnFaO4fn57HNqBs=;
        b=jmGgi80LNde2pqFJROUxqBs2tZFlRksvkHAUFh5SyAMtGXHJCZ7WoQhafgK/ypadER
         hbQ42GCrJxTOxbBDqGm7pjAgi+qIejyloHZPtLpv0XMwTOrlkUyHqMlPmhgX+2ctqJDx
         QcaVcmHlrdNmeYc68qe/L6ixUHz2kqoz5MDZinflfOD/8AuHS0bpSHcgapP/u6NzTtGq
         CZBhwQ+eL/Bd6Jen+zXD/n5RXx/Fli4dk5KDr3Aksj5T4anM3x+2EXqDDbtAKR99JuhG
         k1h690CunMtTnizskzTIgQHWO/NAPfQsJD8swL17//RfdVdN2fmcdJoIanu/XxHrsesR
         Aftw==
X-Forwarded-Encrypted: i=1; AJvYcCUEu6RYNyXJpWaD2xYSPnJEyxfo/AHziIYOBWBOjRLWtKVRP1byog8T9dFiTdiVPZzZOgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzIABMwx8KqoMFm6kvidSmdWnakH+Oc5zvXcKSJEWk6x0NumU
	m6ovQW41FVIea9neNGu4MhmHHuOYhjsaxr+SrNOAMeKZy9geWVfIEu/z9o7k6xV0cFHYSGtOzjZ
	MR6mg6FAJdWBwDqKPB8ydPqxYT5o=
X-Google-Smtp-Source: AGHT+IFrf+cGIUhSKxX0o5a9TA4yo/aqNMsEmglpSwJV7GmB6WArYLXRAh9IMRvws+RVsBhyismp4CZdWm8r+4ZQPg0=
X-Received: by 2002:a05:6122:208c:b0:4f5:22cc:71b9 with SMTP id
 71dfb90a1353d-51477f0eedamr15891965e0c.5.1732026237840; Tue, 19 Nov 2024
 06:23:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Nov 2024 14:23:56 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1731943954.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im> <cover.1731943954.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Nov 2024 14:23:56 +0000
Message-ID: <CAOLa=ZSbj966S+kXtyr-1iJ3eqnDvDt=vN1kfPsSAFaAENmOJw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] reftable: stop using Git subsystems
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000a62107062744c822"

--000000000000a62107062744c822
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> Range-diff against v2:
> 1:  2b7d4e28529 = 1:  2b7d4e28529 reftable/system: move "dir.h" to its only user
> 2:  38cfe85bf5b = 2:  38cfe85bf5b reftable: explicitly handle hash format IDs
> 3:  745c1a070dd = 3:  745c1a070dd reftable/system: stop depending on "hash.h"
> 4:  7782652b975 = 4:  7782652b975 reftable/stack: stop using `fsync_component()` directly
> 5:  b15daefbc83 ! 5:  430be1045d6 reftable/system: provide thin wrapper for tempfile subsystem
>     @@ reftable/system.h: license that can be found in the LICENSE file or at
>      +
>      +/*
>      + * Rename the temporary file to the provided path. The temporary file must be
>     -+ * active. Return 0 on success, a reftable error code on error.
>     ++ * active. Return 0 on success, a reftable error code on error. Deactivates the
>     ++ * temporary file.
>      + */
>      +int tmpfile_rename(struct reftable_tmpfile *t, const char *path);
>
> 6:  83949837a29 = 6:  b9ffdc605b9 reftable/stack: drop only use of `get_locked_file_path()`
> 7:  80fe5bc5e10 = 7:  e1ac1cc2e67 reftable/system: provide thin wrapper for lockfile subsystem

Post my previous review, this range diff looks good. Thanks
- Karthik

--000000000000a62107062744c822
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6d7013ec69b557c5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jOG4zc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNThFQy85aGdWRy9peWt2SS9jTU9RSGVnYW8xT2xBSgoxK0t2akRRTHd6
VXhtaU5HRFN3WXlPcmw2Y3g2bUxlS0x6TzJaU0tSVW1TWG9FUXVqSTU2VnpXUTMrUjB3bXZWCk9L
RmM5SC9oREF6WlZMRkRPUVhLMEF3Uk14alVPRHFEd3lEYkhjdjlNckFYRVJkbExUSXp0M25GSmV4
dSt5RnQKeVJHWVFJdC9KL2VoQWM3amhiL09GallCUDRPT0lqS3NxeDh0VllVVXcyZmVYSEdQZVFX
SnptaGdHdlFwSTUvaQpPRXdvZ2hRWFppMXdUYzZOVWF0aEJUdWN2dk5wdy9RWXJhcWhBRG9oaHJm
TnFSWmtHTTFZbW0xakpuVUZjcTBGCkszWEcyYXM5SzRxRWsrRHAzYjZzckpYdEhreGtPR0RGS29J
VnkxS0E0UndWb3NqM3JtL243SFd5dCtSc3lsY3UKcTdmNEhvbTV0WmluQU9vMTFFRm55Q2lxZ1lU
RnU5Y2o4dkNqZTloUjE5SmcyNy9kdU16ZVZjd2JDdUZqR2xwNAplM0ovUVBVVk1BVHBhcWErVzZR
N2V1ZHFQTml3RENSNkQvVnNCZUlKalJEMW1ucVhlNHFXUlZITXM5UXRJQnZZCjZ0aGE3Q3Bnd3dr
bHRTQlVTRkQ1eGVOVHFZR3ZHdHBxeWpCT0lkTT0KPTRTQlUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a62107062744c822--
