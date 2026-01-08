Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736941E5E1
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864626; cv=none; b=U9sSkD+2qxGuvppA14ocW5govHE2P9kobSbcM5WCfucxXZr1lDWxockJmIaVLjo86FUp3DHqOGB55aLCjaPOr9VkYxsWr3pRaMFgof6IVjMbR3ixkmc778vO1+y17zTSWLi2qQoQTSTIuggaMhLzG1SgxZ0Q4EIO/aeb1oFJ+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864626; c=relaxed/simple;
	bh=lBA+RTDJ39xUmWOByivpsHpjc3IVlHabX6nQKGRw2H8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZbyhwWW6rTIRKroDs6NtqPksOaVnXTK1TQfjI8XQ71Z6UcEML0pRRzo2DypXumcakE7vt6oh4zDpo0EA0GJxGKI0WwPDxrEUiu0xLkbO4Sy0HvupykW8+UenCE4UXFBXvw9Pzn/DxTe/mCI0oEoEwyETdhidNlxzVJnjumMQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAOIBkBO; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAOIBkBO"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dbe6be1ac5so1268680137.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864619; x=1768469419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Apl5CPZpGBJmTgRZbBv82hhkppr0nmW8LNEPTTN8g=;
        b=MAOIBkBOO55EsSLUY6RiqTquSqaPb33So1q0zjaauzvXnQnCJ55ukWBkDtERj1iuGq
         AKb5XWeenqMGr+30FXEqYYNiX4znnL8bm2VOMp17YTFjcSIl5guArk4GCgG9ZS3xODZi
         x1rYvXC/OdS0IVoUXwsmoNmIRnyh2oFP1LZoU3Y+HNc+He6z8DXoAotsCCz7HxJRa+Bb
         WmQZ7FD6YDhd0wHqQdlKQZcSCgDNw6ijFGj6fGie2gqogQ3YhpvEFQyyqFxxYc1paRs3
         XQn31WSlR4rPPpCCnHmIEBcrI8DpMlgHj0zHBt9gkpyk1ndampOWb7epWmjsA1qoXAaK
         pMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864619; x=1768469419;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/Apl5CPZpGBJmTgRZbBv82hhkppr0nmW8LNEPTTN8g=;
        b=V16isSShcsSR5/Sm/w1XZfiOOVYeETyrdnYGhbWEGryFq/a1NtReYn9K9h/AwnVPnV
         4XqAruTFlaYahuttbY1OKjMDmeqP/alRWzGBxyDynVQuVS0TEilIIUKKrdc181s1QUDz
         QgNkdVDl4IRgPDmh9Zk+4FhkChQ3k78eUMkELMxj9pv4q3n+amgsm8OcYBZGaw6yUsW2
         1dJrnPou5Ti5ZEz3+zh/tsyteo0Us11Pd1wjHYAAHexN0P80+yJxp+AWlH5f7EPQidiF
         ANh1Go14EiTDWtxmAA/xc9W9K4sW6JJsWyQ0BoX621fvN0RtuqGBcJ1UqmKceINMjWo8
         ZkrA==
X-Forwarded-Encrypted: i=1; AJvYcCWbhP31XAxUYkzPXvu3GlogOMQqOC5Fn09Xv6hCRA5ulZ3KdiCoeyEpS+rWqfyS8L2xUkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3IqkDACBsHznSFJOuNCx+EicRf/lQyVW5vD0csju9lQ5N5ov
	kqxzVUXA4HDiEmeFxjfXZdVTI2sXq6qQVuLrArZhcAjnR4I5mnx4sr7soBVr2T3ifUAO5XECR5/
	jQZYB8/awMxHxrjIkne1UIeo+rrvRLt4=
X-Gm-Gg: AY/fxX7ivqXYRJ+Y07DU3u+utPuiRHZt2ZtG4NmAP6Pv/lmXWwrYbMKiTNNZ6qw+GF5
	tfhwjZnDtR43Fm25imdPPYkyYTvcHgxebtNnhNFVz+ewsn9aVK+SC+mKszrMVzhlpjY6qDK1KIs
	Ye08H6LTMm3WfyeovA2niBCKj/VvkeuDHaFozCfB+tanIT2o9hvF3bPltB1P0YR0WAxpWYbHMFs
	S12RhT88um0earfxJ8r9fngu4XS6rjCxNMyod15WFAnKvuyKTynBZCrRVfBVqMzZkcrGZen0pNp
	0zOJmzel+aiiPlnPQe6hf7YxSxh9mvUBca9v6a36
X-Google-Smtp-Source: AGHT+IEcXsExMppEWIg/5yDiumBaVkZURjmjfsg0BdEATqcmk/KAbChIrl2uZoq3SilMsTSBUXrgm2KF09D8IfLNQIA=
X-Received: by 2002:a67:e115:0:b0:5ee:9df0:a5f4 with SMTP id
 ada2fe7eead31-5ee9df0a818mr284093137.31.1767864618533; Thu, 08 Jan 2026
 01:30:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jan 2026 01:30:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jan 2026 01:30:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-1-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
 <20260107-b4-pks-odb-read-object-info-improvements-v4-1-b5d55c47082a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Jan 2026 01:30:16 -0800
X-Gm-Features: AQt7F2pa0CnD-E2iKRa3A4r1kKjcnuLzjXxePv5-tT30hgdNBivb2wxiF3GoQds
Message-ID: <CAOLa=ZSWKzOzN103CyuVstnaiviFDm8KB6mQOQLyyExy4TiUzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] object-file: always set OI_LOOSE when reading
 object info
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Plattner <aplattner@nvidia.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="00000000000099613b0647dd0e81"

--00000000000099613b0647dd0e81
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> There are some early returns in `odb_source_loose_read_object_info()`
> in cases where we don't have to open the loose object. These return
> paths do not set `struct object_info::whence` to `OI_LOOSE` though, so
> it becomes impossible for the caller to tell the format of such an
> object.
>
> The root cause of this really is that we have so many different return
> paths in the function. As a consequence, it's harder than necessary to
> make sure that all successful exit paths sot up the `whence` field as
> expected.
>
> Address this by refactoring the function to have a single exit path.
> Like this, we can trivially set up the `whence` field when we exit
> successfully from the function.
>
> Note that we also:
>
>   - Rename `status` to `ret` to match our usual coding style, but also
>     to show that the old `status` variable is now always getting the
>     expected value. Furthermore, the value is not initialized anymore,
>     which has the consequence that most compilers will warn for exit
>     paths where we forgot to set it.
>
>   - Move the setup of scratch pointers closer to `parse_loose_header()`
>     to show where it's needed.
>
>   - Guard a couple of variables on cleanup so that they only get
>     released in case they have been set up.
>
>   - Reset `oi->delta_base_oid` towards the end of the function, together
>     with all the other object info pointers.
>
> Overall, all these changes result in a diff that is somewhat hard to
> read. But the end result is significantly easier to read and reason
> about, so I'd argue this one-time churn is worth it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 115 ++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 71 insertions(+), 44 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 6280e42f34..e7e4c3348f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -416,19 +416,16 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  				      const struct object_id *oid,
>  				      struct object_info *oi, int flags)
>  {
> -	int status = 0;
> +	int ret;
>  	int fd;
>  	unsigned long mapsize;
>  	const char *path;
> -	void *map;
> -	git_zstream stream;
> +	void *map = NULL;
> +	git_zstream stream, *stream_to_end = NULL;
>  	char hdr[MAX_HEADER_LEN];
>  	unsigned long size_scratch;
>  	enum object_type type_scratch;
>
> -	if (oi && oi->delta_base_oid)
> -		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
> -
>  	/*
>  	 * If we don't care about type or size, then we don't
>  	 * need to look inside the object at all. Note that we
> @@ -439,71 +436,101 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  	 */
>  	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
>  		struct stat st;
> -		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
> -			return quick_has_loose(source->loose, oid) ? 0 : -1;
> -		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
> -			return -1;
> +
> +		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
> +			ret = quick_has_loose(source->loose, oid) ? 0 : -1;
> +			goto out;
> +		}
> +
> +		if (stat_loose_object(source->loose, oid, &st, &path) < 0) {
> +			ret = -1;
> +			goto out;
> +		}
> +
>  		if (oi && oi->disk_sizep)
>  			*oi->disk_sizep = st.st_size;
> -		return 0;
> +
> +		ret = 0;
> +		goto out;
>  	}
>
>  	fd = open_loose_object(source->loose, oid, &path);
>  	if (fd < 0) {
>  		if (errno != ENOENT)
>  			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
> -	map = map_fd(fd, path, &mapsize);
> -	if (!map)
> -		return -1;
>
> -	if (!oi->sizep)
> -		oi->sizep = &size_scratch;
> -	if (!oi->typep)
> -		oi->typep = &type_scratch;
> +	map = map_fd(fd, path, &mapsize);
> +	if (!map) {
> +		ret = -1;
> +		goto out;
> +	}
>
>  	if (oi->disk_sizep)
>  		*oi->disk_sizep = mapsize;
>
> +	stream_to_end = &stream;
> +
>

Okay we use `stream_to_end` to simply identify if the stream needs to be
cleared.

The changes look good and indeed the final outcome is better here.
Thanks.

--00000000000099613b0647dd0e81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dc5b8c43eb195e37_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZmVTUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTVwREFDaTZub3FTY09ad1RwcU96SWxBVFc0Mmk0UwpUTDFiYSt5UExi
dVUxRWlXMG94eVdCZTlFV3JRK2lkci84TlZPYnRqZHI4UG41c0ZiN1ZaNndQVDJqOUM2TS9VCkVx
bUt3VWU3OFpFK0xKeDVSanJRQzg3ZGhtSFV2TUkzcTN5Qk1pRzlyei94Z1FlalBYZktHa1RPaEVH
djZIalEKTUtXWjRRV0ZjUWlyYTFUYWhhclJDc2hMdkY1Wm9LMGUzVkVmc0RZdVJXZEtaZ0xqaVhx
dlpZRE92M2o3RkRoMQpNQjMzaDBLWlI3Z3NIeHR6V0FSY3JLbUlBd0NOeEF2eGQxUU84dzZJM0N1
T1AxS1k2NUJHdi9iN1YxWlpvb094CmlIR0tBd1ZZWEw0Ry9lUUhxaWlqSVVhMlBBYmRXS2s2RW1w
cjRzVDJnVmhqdU1BUURuNC85S3Z0T0lxclRJOWEKdVQzWjlvejl1d0lHbkU5S05XaFBYZ28vZmNs
SCtFaEdKaWRRb3A1MU5nUS9qcHlyVFdhdEJNV1JVSjh5UkVsVgpabkJkK1BSM2RSQWpmZld5dk1r
L2tiL0NFZEN4RlUrMUt5QWpCcjhkZTVQUFIzUWZwRjBkUWtWVFBvb1JuZWRSCkh0d1ZvWXJ5TUk1
a1RhdFJNcjlRUnVpZGgxM1NpTnROVHhWbmtJcz0KPXpFMXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000099613b0647dd0e81--
