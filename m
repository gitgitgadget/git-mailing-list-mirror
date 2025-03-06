Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F0204698
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257426; cv=none; b=XD7tICh07v/TUwGqBmSpPtFjg3/1H2z8jy/Bp9yKKYi4qTCsHQBiQAc201+ofjUCgQDZA6OoOZaoXKmYTr4QbRrcBDPCqwX4+Tc6CevsI8SJdlHb+l7JPieBkv5qOgJwbHzy65HguQFlW1eBCBExLR71LIpg/sYcKrAy4mDst0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257426; c=relaxed/simple;
	bh=luqU48vPUnzetMnkonuWW+PF90jkhybEtsWzZd+j9fc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=tq2jdpF/yiccGbtlvXZ0F8knAK65Bc4tlB97Xr235cJTE48pFpK/k/QlsAooTAkUWO5jvLmfuJHvx5fZc5OUzKmX5rivVFQwXscVDDWxwvZEA8BePM3CGUsQ4SmArflgFZrPwuc9MMIKoENh/6gjApZu3TXsdeZcYCbfM2jiUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqnFKwHD; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqnFKwHD"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523c67dba31so208362e0c.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741257423; x=1741862223; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ln3i262YCa7P4DVr5nF+dYEsHVZDRukhonxnZqXIirE=;
        b=iqnFKwHDPeduu1fF+QpqyozciV3yQHmvomodxp4iZIKlSvrACjHiI6MiPbKW+U+tbj
         C/t03p5hhV9TVE9iE3P5koTiiNVG+39p2Dff8dvFLiVFfVtwmndRYJUguQ7ypdrYr6Vg
         zU3mhyQnf+LiwvkGHhhwp+WU16fGPS0NbZP1f9MVtIYCOHT5lK/L4WNctHCB3UG38icI
         wv9YrZGkvQGb3r7ikIptcHxp0Avde/y3JpgH8YoSUgYrXzKrPC7z0yDWjNPidXCBIkau
         yW7MkAUrDwfFg1ga7+aI8hYfrgMIz9LvjLzq8y6aCQ+ppYunACGU0sPqE6UriDc8/LF0
         golA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257423; x=1741862223;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ln3i262YCa7P4DVr5nF+dYEsHVZDRukhonxnZqXIirE=;
        b=Brt2rtq9DmqXidwWeAoGXeu5vspzoLHUeLDoAedTRGaxs/6WKzd5ZGsIyosg2A6/+5
         LiW/BYwRlYTHz8oJIUJniVDigbJzWjXs2xoZBS0LZN25L6QBXnInxexqrj9lAjFmZ0Vp
         e1gK56VE5VP+4glGUSIw57qFmrtV+JkQ723THweOlyZ+RmtDrC44bvpqQRZxiRZRfH87
         Elt3YWCgOksZHrRqYsMRfjsxnCDRgd6jX/Dccm/VLe7mt25ShavjF3s1kbYd95r76Zit
         /MR8P5rlXlQmamCMvV572o8A9cx8o6dThZNOZytezPNhcdMSmQrEOlSvp3lGnhok3Jk5
         eZEw==
X-Forwarded-Encrypted: i=1; AJvYcCUBWcjOk+rdHa4xspvVL7IJ4y4Lc83XlE/n8C913HA9tIaj6Gs43tVBi7uP+QPhgGhiO0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFKgOpO4Oy6NNfuY+rCIe6Asg18vm3t9uhgrAFoPi1Zlwq2cfZ
	pfWdDojBZGWsVMbXWFibpE/G7sJLxJOgtoAhUkpmPyASWBsJoEdGU+wcmqBwWpg1OZRmxLU2ZdN
	Q4LvXHxhk++VW1+LgCHYYedjLOOA=
X-Gm-Gg: ASbGncsU2MjJZCKqn5ovk9ifiNh7Ec6NKG17cpT0dB0K//VvZitE6s33GNIuDVG2n/C
	wDAREEJp+GzEDPZZUl9OWDvxwreK8se3sh53uPT+GqHVwbTvgOHWrsK46DWjBIdn45Jh4a7e9Hb
	n3PN59xFcwVsabEYxXTvD/yFD3Bjg=
X-Google-Smtp-Source: AGHT+IHABI2702liAJtMD5CgJzkgn1LUw4Dw0F3AZSUqTAGlzOMqXISDaLoRadiQbWaIfIQOIJgNFZVfWIQX3TPuQEQ=
X-Received: by 2002:a05:6102:5493:b0:4b2:c391:7d16 with SMTP id
 ada2fe7eead31-4c2e27ada59mr3635272137.7.1741257423033; Thu, 06 Mar 2025
 02:37:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 05:37:01 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-1-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-1-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 05:37:01 -0500
X-Gm-Features: AQ5f1JpIc4GeqoN6qvedaQJ86U_PUwnLl98NYwZlqi0jHqtTnro840HxWQCdzXI
Message-ID: <CAOLa=ZREou-t8m6-HqUXpgB1SygNzP1JXSUV09NzpaoKgEUdwQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] csum-file: stop depending on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000029fd15062faa161d"

--00000000000029fd15062faa161d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> There are multiple sites in "csum-file.c" where we use the global
> `the_repository` variable, either explicitly or implicitly by using
> `the_hash_algo`.
>
> Refactor the code to stop using `the_repository` by adapting functions
> to receive required data as parameters. Adapt callsites accordingly by
> either using `the_repository->hash_algo`, or by using a context-provided
> hash algorithm in case the subsystem already got rid of its dependency
> on `the_repository`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fast-import.c  |  2 +-
>  builtin/index-pack.c   |  2 +-
>  builtin/pack-objects.c |  3 ++-
>  commit-graph.c         |  9 ++++++---
>  csum-file.c            | 28 ++++++++++++++++------------
>  csum-file.h            | 12 ++++++++----
>  midx-write.c           |  6 ++++--
>  midx.c                 |  3 ++-
>  pack-bitmap-write.c    |  2 +-
>  pack-bitmap.c          |  9 +++++----
>  pack-check.c           |  2 +-
>  pack-revindex.c        |  3 ++-
>  pack-write.c           | 12 ++++++------
>  read-cache.c           |  2 +-
>  14 files changed, 56 insertions(+), 39 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 397a6f46ad8..86e6e754816 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -770,7 +770,7 @@ static void start_packfile(void)
>  	p->pack_fd = pack_fd;
>  	p->do_not_close = 1;
>  	p->repo = the_repository;
> -	pack_file = hashfd(pack_fd, p->pack_name);
> +	pack_file = hashfd(the_repository->hash_algo, pack_fd, p->pack_name);
>

I recall that `p->repo` should be an option here, but it makes to use
`the_repository` directly here and not worry about it, this should apply
to the other changes below too.

[snip]

The rest of the changes look good.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 6406953d322..f0e2c000252 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -3024,7 +3024,8 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname)
>  	return 0;
>  }
>
> -static int verify_bitmap_file(const char *name)
> +static int verify_bitmap_file(const struct git_hash_algo *algop,
> +			      const char *name)
>  {
>  	struct stat st;
>  	unsigned char *data;
> @@ -3040,7 +3041,7 @@ static int verify_bitmap_file(const char *name)
>
>  	data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	close(fd);
> -	if (!hashfile_checksum_valid(data, st.st_size))
> +	if (!hashfile_checksum_valid(algop, data, st.st_size))
>  		res = error(_("bitmap file '%s' has invalid checksum"),
>  			    name);
>

Here, we're modifying an internal function since it needs to pass the
algo to `hashfile_checksum_valid`. Makes sense.

> @@ -3055,14 +3056,14 @@ int verify_bitmap_files(struct repository *r)
>  	for (struct multi_pack_index *m = get_multi_pack_index(r);
>  	     m; m = m->next) {
>  		char *midx_bitmap_name = midx_bitmap_filename(m);
> -		res |= verify_bitmap_file(midx_bitmap_name);
> +		res |= verify_bitmap_file(r->hash_algo, midx_bitmap_name);
>  		free(midx_bitmap_name);
>  	}
>
>  	for (struct packed_git *p = get_all_packs(r);
>  	     p; p = p->next) {
>  		char *pack_bitmap_name = pack_bitmap_filename(p);
> -		res |= verify_bitmap_file(pack_bitmap_name);
> +		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
>  		free(pack_bitmap_name);
>  	}

[snip]

--00000000000029fd15062faa161d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ee740f75085fcd6d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSmVzc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mem1jQy8wVm9FRzJWQ1F2aEUya1RzMm4weEpEcXJ6TAowWWwwekdWY0o1
R0ZVR1N0NFAwVjZXZStCT3ovMmtxdXpaaTZCUTZLRFpiMkJqcDIxR3J3c01tSlFpcnkyb1oyClls
YXFxK1A2aDFiRzZEY1pkQ0tpcFFLNHlVMnF6VmprREZCcEE0dzZEaFFqRVRkSCtxekdaY0R1dzZW
d3VhNHEKUzZVS1Q2bFZoKzlCQklCWE1iaVdia0srVHRqQXR0TGxZQXY1NWxkc2lkMFljLzZPQVRp
UTUvWGRCT2JEeWEydwo3ZEZ0SW54TEdVVzJXTDAvb1BndGZvOHdxYXRGOWxLRG15R1hIbEVYQU1v
NVk2M3lZa0NINERndDhFSWJxaGVZCmNqRkhCSSt2S1FhU09UVUMzcmZEUEpMbVZuT1hmaEdoRkVa
RkQvSTZYenVtVUk0K2ExaEhyajBPRmxtajJKa2UKMG1jekJ0QXdBNW5GVklmOHB3N1gxWnZiVmVM
MkFVekZmbmZ3QkQ3Y0h5aGEwYkNrTXhlRmJocW5CUWkrU0xTNgp0bEc4OC9neEdRZ1cyN2YzSE42
elpzbEIxWWs3VkJnR0tvaEQrR05yMVRUcGsrRjN0RmY5THlkTzhnOFRoVjV3Ck5MMko1VGdPQzJJ
MFRqbllwZkM1SEhTQVN6UzBnVTE4MmI1V0MrVT0KPUp3enQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000029fd15062faa161d--
