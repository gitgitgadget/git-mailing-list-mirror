Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495B39F18E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714408; cv=pass; b=pg8+6ioxETRRTAq3T6JDK78YLsN5M5bPZFBfdJd4+0nTTWL2wZQt0bQvyh/bVem+W8A+fet+SaCiyBLSUfzo7gALohmLzPzvY2ssiO3it7+VuDngu01Yhwamfddz1NJsnLid+eCqWDJkx560u4DRi6SDQggzxXMBbztGfzsqPa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714408; c=relaxed/simple;
	bh=t/K7buUfUe7OsqdcbDPPptQwxI9w3ZgJ5jF3fZR4SBo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=eaFHzgEgyoVgo0/hiLYg12/Yd1/zs89cM1FoXOsyBLS9sz8wXQIetb7BerGgFZImYa7c+XrMOjQA32+4gGVqW2a4W5SfEAJOO+5Nm+LRRJlZWKwV7N2okLUiTj6qdbr76j9kVbpUVPNWCd1T6EflJ+5DC420uxOHePpy3hvmzkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YliIKd4b; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YliIKd4b"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ffc1e25d6cso317629137.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:40:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772714406; cv=none;
        d=google.com; s=arc-20240605;
        b=kSYYVS9aGSWpv+hxv28La/ureUdZZ/FgLpNrFI5LXg8g76B3Y416DHEvBde9prvoGu
         kwW62RLKg87FTFK9BNku9YdPL3wlLgbdk9AH7/8AEKf8hkVhMYAhKhYdyb5HZwLf+0nF
         AV+l3otselO7EgarbKGDo5YDC8hh3dCe5yrr3Kanpb+Vz95HUJmAB5Z6mf+rf0V8GrJ9
         xUEpI3hOsUI+BEKUH0J+yx5UW0xkP//ve+ZYBsnBnAY4t32FP5rcolafO/L2tVeCgTfd
         +01SDUOlP60stEbMessQEnl2Wmfq5WNWzjRlY9wREAu6/yqdRQTd7RYijkzZ90d5m0kc
         +2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=BbGFE11R3S2M8jY9oP14v7JXldPgpVrRKgnu0YILppE=;
        fh=StDqHxb555f3ud5mjBj0mtbIpZsoT1cT6ilini4KzyA=;
        b=Kke7IO+qm6Mo738GqLaWxH2lh+GYrwIKy4nh7LKDrykAE+bXG7b/6LYYbD2ANxU5bq
         wad4b0lJElnTRd+ZKCx+0TjOq1s40/CPBdNiVJsjpMTV5GGMJbdU8ESI665hZmb09tIL
         meiRvmLykU/aQ49ImYG5mNYT3IiP+myFSlGgbYkOcNc0gHwGUttEwozEv6hHQXUWNiJr
         x8BYY7dgYNkY2jK91Y3fMCxTD1WNkMRpd8Y7lsq5fgFFKhgiBN8BAAycSsBRpLNZkdwG
         W7T9evc6jzIm5t7uNDVWfF0M5AP0EmD9r//DdMDhX/d+KuUToWD76PfsRnLCgjvrvd6z
         bawQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772714406; x=1773319206; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbGFE11R3S2M8jY9oP14v7JXldPgpVrRKgnu0YILppE=;
        b=YliIKd4bgLD/dUAfCTNniUumkTFC9QTPFMJv38KOVfuJKvxUsAzMjZqSTC6woI46sn
         If9gNCd3yo4Y6mOoREby7PEWQszg7rD/7KTQ0gGuB6CSb5WTFJDeMfL7hJptYt3m1Z0x
         os9oB+uU18S0t4abhbDt4cb/EgRJWFDMRDdaruZ2m9zEFiQCnhrV8WUfADscTvXT8Jg2
         +c2wk/ontaY4n1mtq/NGv0LYxWnd1gnqCPL/75Jh6pRazdCeRVtRdUYdMgpnjpvkiTij
         PyQT8OcCdKkKiyKbN01XIjsqE8hwSjzE+BihabJ6foJKIbc7pUG6E0P2FgzFfThDzCE/
         qVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714406; x=1773319206;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbGFE11R3S2M8jY9oP14v7JXldPgpVrRKgnu0YILppE=;
        b=ULzQbS/g+oc1F9GOsSTZZP1ZBro3wXnYle/KHV6tYJit1bZlS42hvNq355yBoonGM9
         Hrv5AEePge9CKucHVcOr3+RLJ1vJAwoldnolAkA2ZH29bcUKHXBuy/hGDFjCaOHAHBRn
         g3neQ5pocAeu9AxA/UEKh9PW+JzCXe7AsDITRBVfIbgIHThT0gkKeNt/7aZyrZhL6zZC
         CyX8Q+SsRj064MtbVC/tWe8P65k7EyXLYkQiQiiEQVoI5yOBh8JNN7sZ3fnt3etA1zxA
         iSJ0HHsL8RWtucjhPT84ZQyCXLMuqj/gfZ7QK/U6RkmybuPkWD7fTXAihb87VgcI8T2J
         Mqkw==
X-Forwarded-Encrypted: i=1; AJvYcCWcM87nqX8PfjALa/EWQduS2gigLqLbFtAr4hpLU6d+jgJjlyMRb22OLE+aBkX3joDvHV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmiuM3KVzmU5rbg1wB/ZME/MoD0Z9HTAI4bqipF4//vSJ6zNj
	zLltdXoMWl0SJ1ZqvJlym4rfk9fNllVoD9qb4ElHUnH0HcOI5vg+sOw4c8c3Pj9F0cKDR4tmf5P
	ngMVE6J9eEPJn3Ok7FOCQfbvYf+99l4uvM7jl
X-Gm-Gg: ATEYQzz7KO5BQSMPmmIhgWRNV/deNsaNEHu/MA05QGvuKi4uqRGv4/LnH/Vw7oTQNaM
	0MiVEpniQziIgDHgtCFFjrOfBYznU9rp8TywptFSITIvIwfZlYuvcrDQUwzIOdHz540V1jOSL1p
	zMGUrD+JlIJcLvAR+WgD5vYOvKUbiZ47XtN5lDcnAtSLnCF6IROkhMTWrzEAg27P5U6pG/m61HU
	ph1wTi82q7koJlDeqFNZWy1UQTWN4LUISozet4FwIuoU9FmJl+4Z9/NlueYLgXhRqAUE2EWvAoS
	nypytNeXhigo6YyzRIweFcpPAoG+HyzvxSLPOLy/BQ==
X-Received: by 2002:a05:6102:4411:b0:5f7:2474:eb9 with SMTP id
 ada2fe7eead31-5ffaae999a4mr2055547137.21.1772714406499; Thu, 05 Mar 2026
 04:40:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 12:40:05 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 12:40:05 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-11-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <20260223-b4-pks-odb-source-pluggable-v1-11-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 12:40:05 +0000
X-Gm-Features: AaiRm50k_MN4hhLG5c6xTUWLpKKoGxsy99jJucvWHV0IVSkV71e-IvH-9B7QYGE
Message-ID: <CAOLa=ZSHmZ+gXnUg+Oa7-H21K9hAyx121+rdgKz24BubJHkMDA@mail.gmail.com>
Subject: Re: [PATCH 11/17] odb/source: make `for_each_object()` function pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007cf3ac064c463cfc"

--0000000000007cf3ac064c463cfc
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c              | 12 +----------
>  odb.h              | 12 -----------
>  odb/source-files.c | 23 +++++++++++++++++++++
>  odb/source.h       | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 23 deletions(-)
>

[snip]

> @@ -151,6 +163,27 @@ struct odb_source {
>  	int (*read_object_stream)(struct odb_read_stream **out,
>  				  struct odb_source *source,
>  				  const struct object_id *oid);
> +
> +	/*
> +	 * This callback is expected to iterate over all objects stored in this
> +	 * source and invoke the callback function for each of them. It is
> +	 * valid to yield the same object multiple time. A non-zero exit code
> +	 * from the object callback shall abort iteration.
> +	 *
> +	 * The optional `oi` structure shall be populated similar to how an individual
> +	 * call to `odb_source_read_object_info()` would have behaved. If the caller
> +	 * passes a `NULL` pointer then the object itself shall not be read.
> +	 *
> +	 * The callback is expected to return a negative error code in case the
> +	 * iteration has failed to read all objects, 0 otherwise. When the
> +	 * callback function returns a non-zero error code then that error code
> +	 * should be returned.
> +	 */
> +	int (*for_each_object)(struct odb_source *source,
> +			       const struct object_info *request,
> +			       odb_for_each_object_cb cb,
> +			       void *cb_data,
> +			       unsigned flags);
>  };
>
>  /*
> @@ -233,4 +266,30 @@ static inline int odb_source_read_object_stream(struct odb_read_stream **out,
>  	return source->read_object_stream(out, source, oid);
>  }
>
> +/*
> + * Iterate through all objects contained in the given source and invoke the
> + * callback function for each of them. Returning a non-zero code from the
> + * callback function aborts iteration. There is no guarantee that objects
> + * are only iterated over once.
> + *
> + * The optional `oi` structure shall be populated similar to how an individual
> + * call to `odb_source_read_object_info()` would have behaved. If the caller
> + * passes a `NULL` pointer then the object itself shall not be read.
> + *
> + * The flags is a bitfield of `ODB_FOR_EACH_OBJECT_*` flags. Not all flags may
> + * apply to a specific backend, so whether or not they are honored is defined
> + * by the implementation.
> + *
> + * Returns 0 when all objects have been iterated over, a negative error code in
> + * case iteration has failed, or a non-zero value returned from the callback.
> + */
> +static inline int odb_source_for_each_object(struct odb_source *source,
> +					     const struct object_info *request,
> +					     odb_for_each_object_cb cb,
> +					     void *cb_data,
> +					     unsigned flags)
> +{
> +	return source->for_each_object(source, request, cb, cb_data, flags);
> +}
> +
>  #endif
>
> --
> 2.53.0.536.g309c995771.dirty

--0000000000007cf3ac064c463cfc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 311c146d6d647ee5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcGVhUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkU3REFDWVl6djArWlhrUWZkUVRBRUZ0dTR3SUlwcgpIU2E3M3ljS2cy
Q1VjZWU0bWZvRWNEVTFsSUVad2g3ZytWNytlSDZjLzU0SVVVWmMwZDlVdngwOVRlanRZaVYvCjdK
UUNnakxhZXpVSmNxVGZ6Z3JyM0VSSndVU3kyWVVUL2JpNEVVRGxkdmJMd01OYVpQUnE4NDR1bTBs
TTBaUU8KZjJva25pRE5tRWJwNkNpclh1a3JyUGY0U0VKM1pwaEovVE5tT3ExUzBpV3AzbjlONzRD
Vm9sTUFLY0RKaFZKaApieTNUYjlVeEtYQXpIdVIrUWNPMkF2MlVIdWNnTUtYWmZLZTJFaUxoMXFE
YjNtVWZmL2VOQk5vNTd5UzJsNEliCjRiM3VqeHpicnRsOXdORjVaV24vVVFEMGhKRW5DUTdaSHBU
ZWR0NFY0SHNJeHhIb1huRG9nQ21KWFduS1RsbUUKcHJ4eWs5bFdVdjh1eTFkQkZGRHBsNWdYNFBB
S0hHc0lSOGF2c3dqd0luelNvTUFhQ3pRKzNwMXFGNk1qMDVuTQpHUFl6aHMwdndYVzhXZUlMSDI0
bzR0L0tUd2twcENwREliK01GdnBBVGtsckRON1IvTDJleVZDVTF3TTdvTGVoCnY1VXhyOEZ6NFR6
ZWdLRi9sQXpZSlVMdmZCUTNaTkZhamhDTnlTQT0KPUcxL0EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007cf3ac064c463cfc--
