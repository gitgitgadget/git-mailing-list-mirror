Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2336E573
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568646; cv=none; b=RqObvctHKeP4IP3YOVwUPtjvhlk0kzD35vSU0f8x8swHIn+oaOWsJOqZtlV17Txuo6ms4ceH8J9wMxEEmAwp4zLv6HzjRtrpE6UTxKTnoHKAsnJB2rjUJoZlUDMjFkd04mM0tz68nCnix3ZOFV0OcvjPEUxhxA7yAVpCKRjZ1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568646; c=relaxed/simple;
	bh=rklLhpZZyATjN0HZRsdYYVrwqpA4lwvKF8cGlcmwmkw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=aLKTNFatSg5JAOTbPHeGmIa0Ba03seZSXfNwShaBozxvsagI/Gkxom41bBj5C9hhHEKspGONp8msiNx00xRKpFxRFKJzgzK8egpreOyWzS3N4tiUXvNtxlRqDCL4FY+EogAUdTeb5ZuMhjsXCaW3ScL8OZeBZiQOdUcKC2N+KcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA0Txwdy; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA0Txwdy"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-55ae07cf627so1949703e0c.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763568643; x=1764173443; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzytI9iMDa/U/U69a7mBEjF7HFls02XmtvktHe4+ivI=;
        b=MA0Txwdy/DnFc9aIl0pyvoBBGiLmUTR+dPftPSGxe6zQBosVsPi3LFxgPNQWMPPbIb
         RVhB/p36dNhfRrLU+R6wY9O0BEyZKt9x++B7hYFIA1TwL5MlmgTzejmMol+pyoEmxLvm
         SdX7pLhCtbOgJ+/m4TBkfRdybAD8Hj0CQ+zpyZddPZifGbgOHeWGCuGFml8cKOeZu7xn
         8nPf3ogIoggEUQuGvkzOxqbqopvQ5iBnBkQDhCe2RW201hMQ3KqXyQ8dUvkR4iGdEYgw
         cGFjpHrV0Me5ZvXdA5oyN7TMumYdg4ek+etkBxnjgaZ74o8xaGzM/JcoTQKdSXTgZVV5
         suYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568643; x=1764173443;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzytI9iMDa/U/U69a7mBEjF7HFls02XmtvktHe4+ivI=;
        b=j2obn8zesb7sMFMbnk2PHkbnGDo/pR9HrGEn83cBUnL7xAH8GieFT9gn4pki7z4hVq
         JCwDTMRW8cwznL42h2oNswOZLvOWYh/WDPDAuOYAvvjJX7yd7MOTPNYkeraxq6mYGG1a
         ZNk6puvh49UOVVD+Fp3daYqXmBMlUGG6moqf0OoedoAhwgj2s/8bPsu1oGgFFuInoMcK
         FgefRm/NyeRruGtpergt+ybOx0lYNdVmiiUGpEG8Mh0OnpyH5jv4V/ZfxiodNkZeoE+v
         mdINMtsJY45meO4/wNHwI9v1eNWCoyZs264mZVMTdoI/DopHT1qf9LRkP5eyr5S59wnK
         PeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Z/bqU4AmS2ocUA0d0wnV0dE1ZkdCcmz69Yu2qwy1ZxBx+jOPqjr6XktYdJBIj2qofy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8gepLa+6pdbWVLwsnMkRF3M4IKYnqU3EkIl/0ty3i9iw/AT9
	Rl+5FimwyLP1cbkYWxodQPMbA3/qBjM43F5vmCu4z4H/EgzSRfUNZ5UMZwUGSnp5y3J73tItluq
	Lw2z62WCp6mL8JVXBcQ+hAnxrg30BfjeF3Q==
X-Gm-Gg: ASbGncvpw5Ya2i08iR27JZYsf94PgiV/JziQD56gU56jJgZRpZs9IJtyZXXAhBHFTZn
	EdV7AO72Gwb1hlBMG/Fa4ZeJGeqo/ew/mE2SWyx/tFwXTdUkkqUSLz44OCiRD/IujOrSuQC75Lg
	Z7JGgx6++ZCPg2nGMlZ+64v4S2u3Pq/aBKJDVoo1EcJknueTmNScSSgm4rn5d93FEeO++Y+oW6I
	JBrwJ0Ap72OzLRDz/x78NZru7CQSyn9VI0d6grXGdfs75s0lFQQ2klZZwlvJPY2u812Dg==
X-Google-Smtp-Source: AGHT+IErZiAvCz1u+PE3Mj9wXRGUjnk0y/Ctj4HLhjbsbb6RAMLBiEBDDj7b1NYNs+PCUr0tTnKmdvmp/KvDxy/W/50=
X-Received: by 2002:a05:6122:d89:b0:559:8089:9445 with SMTP id
 71dfb90a1353d-55b1beda7e1mr6786205e0c.12.1763568643134; Wed, 19 Nov 2025
 08:10:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 16:10:41 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 16:10:41 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-12-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im> <20251119-b4-pks-odb-read-stream-v1-12-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 16:10:41 +0000
X-Gm-Features: AWmQ_blGr8a8epAoeIysM3pBdkKTq_Vtt7lqP8Ff0pr__MvQF2z80Enn1DhIy9k
Message-ID: <CAOLa=ZRwnsYeHDpdL+uvnw0YMTbG1Gx2SKsq+0hTWMto+QZ+Lg@mail.gmail.com>
Subject: Re: [PATCH 12/18] streaming: rely on object sources to create object stream
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000082f6f60643f4d2f4"

--00000000000082f6f60643f4d2f4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When creating an object stream we first look up the object info and, if
> it's present, we call into the respective backend that contains the
> object to create a new stream for it.
>
> This has the consequence that, for loose object source, we basically
> iterate through the object sources twice: we first discover that the
> file exists as a loose object in the first place by iterating through
> all sources. And, once we have discovered it, we again walk through all
> sources to try and map the object. The same issue will eventually also
> surface once the packfile store becomes per-object-source.
>
> Furthermore, it feels rather pointless to first look up the object only
> to then try and read it.
>
> Refactor the logic to be centered around sources instead. Instead of
> first reading the object, we immediately ask the source to create the
> object stream for us. If the object exists we get stream, otherwise
> we'll try the next source.
>
> Like this we only have to iterate through sources once. But even more
> importantly, this change also helps us to make the whole logic
> pluggable. The object read stream subsystem does not need to be aware of
> the different source backends anymore, but eventually it'll only have to
> call the source's callback function.
>
> Note that at the current poin in time we aren't full there yet:
>

s/poin/point
s/full/fully

>   - The packfile store still sits on the object database level and is
>     thus agnostic of the sources.
>
>   - We still have to call into both the packfile store and the loose
>     object source.
>
> But both of these issues will soon be addressed.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  streaming.c | 65 +++++++++++++++++++++++--------------------------------------
>  1 file changed, 24 insertions(+), 41 deletions(-)
>
> diff --git a/streaming.c b/streaming.c
> index 572be98248..bebb434cd1 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -204,21 +204,15 @@ static int close_istream_loose(struct odb_read_stream *_st)
>  }
>
>  static int open_istream_loose(struct odb_read_stream **out,
> -			      struct repository *r,
> +			      struct odb_source *source,
>  			      const struct object_id *oid)
>  {
>  	struct object_info oi = OBJECT_INFO_INIT;
>  	struct odb_loose_read_stream *st;
> -	struct odb_source *source;
>  	unsigned long mapsize;
>  	void *mapped;
>
> -	odb_prepare_alternates(r->objects);
> -	for (source = r->objects->sources; source; source = source->next) {
> -		mapped = odb_source_loose_map_object(source, oid, &mapsize);
> -		if (mapped)
> -			break;
> -	}
> +	mapped = odb_source_loose_map_object(source, oid, &mapsize);
>  	if (!mapped)
>  		return -1;
>

So instead of going over the sources, we simply check for the given
source. Nice.

[snip]

> @@ -462,30 +460,15 @@ static int istream_source(struct odb_read_stream **out,
>  			  struct repository *r,
>  			  const struct object_id *oid)
>  {
> -	unsigned long size;
> -	int status;
> -	struct object_info oi = OBJECT_INFO_INIT;
> -
> -	oi.sizep = &size;
> -	status = odb_read_object_info_extended(r->objects, oid, &oi, 0);
> -	if (status < 0)
> -		return status;
> +	struct odb_source *source;
>
> -	switch (oi.whence) {
> -	case OI_LOOSE:
> -		if (open_istream_loose(out, r, oid) < 0)
> -			break;
> -		return 0;
> -	case OI_PACKED:
> -		if (oi.u.packed.is_delta ||
> -		    repo_settings_get_big_file_threshold(the_repository) >= size ||
> -		    open_istream_pack_non_delta(out, r, oid, oi.u.packed.pack,
> -						oi.u.packed.offset) < 0)
> -			break;
> +	if (!open_istream_pack_non_delta(out, r->objects, oid))
>  		return 0;
> -	default:
> -		break;
> -	}
> +
> +	odb_prepare_alternates(r->objects);
> +	for (source = r->objects->sources; source; source = source->next)
> +		if (!open_istream_loose(out, source, oid))
> +			return 0;
>

This seem to be the crux of it, where earlier we depended on
`odb_read_object_info_extended()` to tell us which backend to rely on
and then we re-fetched from that backed, now we simply go over the
different sources and try to get the object stream. Makes sense.

>  	return open_istream_incore(out, r, oid);
>  }
>
> --
> 2.52.0.rc2.482.gaa765fefd0.dirty

--00000000000082f6f60643f4d2f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 93c99c0be8228cff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZDYvOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3hxQy85bFlxQU4vbDllNnJNUmFrdjJqS25jNlNzQQpaRDZMejVoOER6
dUxCSld3eXREbzlvWEJ1b3JJSjFHemxkY1pzV0d3Mnh5QXg1cnV5dFc1dlkzVm9Dd0ppekpCCi9U
VmlXYlZNWnY5aVArTkpuVFFXcmxLWEpkZm4wclI3a0IrT0VDTDV1REVUVnpVWFhBZjN2VnB0Sy9p
WEI1R2wKSkpkYUsxYVVMNGpYM0NRK2xJZjNEUnd0Y0dOWHJrTmVkODlrY0lCRTRwNTRzaUxzMFRT
Slk1OXluNmdwUVhLdwprdXlYbTZXWkxSODc2b1RwVTliZFIvWlMrcDRYcTdQTkI4UzBUU1llOU5B
eHdzRVlMYlBnOGp3MFNINWhKZGFrClRQQ0kzZENPM1QzajhpWlJ6U09FMDgwTGFRcUU0M3V1ZHlL
WE8rUXhBRVV2RmZSRStwaVhIOUd5NTI0UmkyL0YKUUxBbEhINW9YTldlTGpYUGswWlRVSnBVSFl2
b0pQaFM2T3ZUSmd4dTJxSVBDOHJJbnhqaGNsNlB6S3I2SEVqcgpBbzhLeC8vYkFhM3FEYzVmQWhk
ekovODFpRlFCYzU5S3dHamJOQXU4YVhuak1DMUhqb2NESFZQRitoWFRxRVBlCi9XT3dEajZTSjVN
ZUpnM3FjUVVFYWVHZXFXNUJjdDdrRmNkS0RxZz0KPTZvQUoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000082f6f60643f4d2f4--
