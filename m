Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C21B7F4
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554881; cv=none; b=VZyF43lpRl8jKkgL9HxRwlysZaUiAXy+QloQtpcYpi88BGvaj3WFovlz+tBE0s97Cl5LnEXLUadxRSttwRjZYFpH613lBmdAkeLIwfrP3f3YiFk7x+ER1pkX7iUYkI3lxzmCIPVtHJUvyg1/BVS3xrlw2EKLrp8NP6eBKRPZeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554881; c=relaxed/simple;
	bh=iyPZolLaZAwB8WxEqsal/Vw9vN56QaAiXTGn4MYkmTw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGW6Z1UrePHIynt0nx+8D+V8+3yV9QywaUk8tdRDUt3B4kBoqPMCAIHvmyRFrqlRK1TgfLTM45AS1CSjWQ4zY3iih7rEWcYhUrPO2VlHsgBjewqA3WmjKGJwWCyKx1vi0GOid8rcOw1Kw3IzVIFZewdWPYk2MFITeAm0pb4anqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq3pGFRU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq3pGFRU"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b423b13e2c3so500743a12.3
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754554879; x=1755159679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TkpGwOPLIbxxd3wghRAlBPGx8T/Bc4ov8GE5KKLbkvU=;
        b=bq3pGFRUDDcfu6rzxcxjIDJRSbwIEKJtBlhrSMnhYJDIfEX1oMUrhUcU/Bu02YcZbR
         +B7uKYDN7v9M849rEqb2wm3C0RxTA9YWGJtuJABamgGCoj6lMwYYDnncTLfw7CbDGIMH
         oWD8GsrgibgeIZFeiFiKrXJz5xRtCesQhoWrW2bAgcBODmv9l/pG3iU6gydf0H3AWAMV
         ks/mkTUZ4f1dalRLA+GOmuWsb9PMMCy33GTmrYxTESddLCTVc9NELdjDCrs6xIdmdKyu
         K4dkZO1mkCvjz1aeW5Gd2MHMy/Cn25eywN7jJ6XNh8dKJMtK939btnIswSf9bd3u5Dih
         R6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554879; x=1755159679;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkpGwOPLIbxxd3wghRAlBPGx8T/Bc4ov8GE5KKLbkvU=;
        b=Pru5HrQbAMHb2qMm0ah3sheGkR8trQycTN/u11mGYcBN37RzrJsBO1NkNRQAD1WO9I
         umwqeFh2AxO69ZMk+Jq+BNF/tzjl2EVcVuLGT0XRtcWf2ZT/XkOUnl/B8L2KC7pO2nQy
         YTW/gxCbanuJock/sCDmgXhU0IGnmUxnWifoiehgKz/xA1A3QgFxXYU8gi5x/Ksc5/8O
         0J0S0wFRmEaesH8OfLeRudJcWqx9iXfzLdP0QmyppxIqR9vtnpQevTvV+c0vLBm995sd
         wcgVlSEZ2hGqeoTkRZwak2J+6s5M7U8oqqJCLNzl4s5KiI+rMnzdun/juuUVcnbaF6AG
         ioQA==
X-Forwarded-Encrypted: i=1; AJvYcCXnJF6L4OW47hCTo2N/84932EnxY4EmxFqcALbnmwOUSia5xMqbe2fIoTfk5ZPZmyh/ctM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka4ydArHgrnJr7n+5duzz90Wx8eL5LM1dTX6eBU7oxP8Kj8h2
	042BgBrfv1RqYuxGY+5AXsHD3vfwI9vPk/SoJFDhoulr534Vr3HFawmma8CcNig7pFB5k5+BSc8
	wz3LeS3SKfn1ibhQC121DvKRBl6yVj58=
X-Gm-Gg: ASbGncu/L4/FniT7S7kZkxGbOdunQt5YI1FhswRjSWpvFCTY4W7zcGsWqTNGTEk1aXE
	w10MOvczpErvyKURqm+T6AV6Rs412QA331+Y6eNzNnD0KV7BcaBFXcJrbeURoKizJbxSpEnIGV5
	ejGlfQybrmi73vyCwbb2tMKI8oxzNAvZUEAL5VZZ8Aw883edkbAiD0B5u5/P09rpuH4LTXVhOQW
	sEGsN4irRKc0gfg
X-Google-Smtp-Source: AGHT+IFLx0Y4VNUoMCOONIS37q5YKtzd4xsETCYNgJ1ez5Lx+ephO8LMURIrCOiY+01SaZd436xgGqS5ARHISabPw6I=
X-Received: by 2002:a17:903:987:b0:240:2a0:c449 with SMTP id
 d9443c01a7336-242a0a90e6fmr74147485ad.8.1754554878787; Thu, 07 Aug 2025
 01:21:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 01:21:17 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 01:21:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-3-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-3-748db2eda3b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 01:21:17 -0700
X-Gm-Features: Ac12FXzfQvGC9F23p9JcpEy-q_YccMk6YandX9auFVMFZ0dkvx_NzmYxNH1_BXs
Message-ID: <CAOLa=ZThnuczO3xXdVupaqmbQK6t8z30pE7krG2djS4Lfr=jyg@mail.gmail.com>
Subject: Re: [PATCH 3/8] odb: return newly created in-memory sources
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000004a1eeb063bc224a3"

--0000000000004a1eeb063bc224a3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Callers have no trivial way to obtain the newly created object database
> source when adding it to the in-memory list of alternates. While not yet
> needed anywhere, a subsequent commit will want to obtain that pointer.
>
> Refactor the function to return the source to make it easily accessible.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 37 +++++++++++++++++++++----------------
>  odb.h |  4 ++--
>  2 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 61104b7cb8..7793816f81 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -139,23 +139,22 @@ static void read_info_alternates(struct object_database *odb,
>  				 const char *relative_base,
>  				 int depth);
>
> -static int link_alt_odb_entry(struct object_database *odb,
> -			      const struct strbuf *entry,
> -			      const char *relative_base,
> -			      int depth,
> -			      const char *normalized_objdir)
> +static struct odb_source *link_alt_odb_entry(struct object_database *odb,
> +					     const char *entry,
> +					     const char *relative_base,
> +					     int depth,
> +					     const char *normalized_objdir)

The change in return value makes sense, since we now want to return the
'odb_source' newly created.

But the 'entry' argument is also changed here.

>  {
> -	struct odb_source *alternate;
> +	struct odb_source *alternate = NULL;
>  	struct strbuf pathbuf = STRBUF_INIT;
>  	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
> -	int ret = -1;
>
> -	if (!is_absolute_path(entry->buf) && relative_base) {
> +	if (!is_absolute_path(entry) && relative_base) {
>  		strbuf_realpath(&pathbuf, relative_base, 1);
>  		strbuf_addch(&pathbuf, '/');
>  	}
> -	strbuf_addbuf(&pathbuf, entry);
> +	strbuf_addstr(&pathbuf, entry);
>
>  	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
>  		error(_("unable to normalize alternate object path: %s"),
> @@ -189,11 +188,11 @@ static int link_alt_odb_entry(struct object_database *odb,
>
>  	/* recursively add alternates */
>  	read_info_alternates(odb, alternate->path, depth + 1);
> -	ret = 0;
> +
>   error:
>  	strbuf_release(&tmp);
>  	strbuf_release(&pathbuf);
> -	return ret;
> +	return alternate;
>  }
>
>  static const char *parse_alt_odb_entry(const char *string,
> @@ -246,7 +245,7 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
>  		alt = parse_alt_odb_entry(alt, sep, &entry);
>  		if (!entry.len)
>  			continue;
> -		link_alt_odb_entry(odb, &entry,
> +		link_alt_odb_entry(odb, entry.buf,
>  				   relative_base, depth, objdirbuf.buf);

I'm assuming that passing 'const char *' directly makes the function
more versatile. Might be worthwhile to call this out in the commit
message.

[snip]

--0000000000004a1eeb063bc224a3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a721e1e84fbb677d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVVlmc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGFRQy85QVprYWRxSDZpeWRWNlZkTGdscTdCNk9DaApUQ1duV1VSN1hI
bUpEUXNlU0xVV25RVXpoWFEwTmZoRmFlM3BTYTVLSnF5R0UvSnFFQnF5YWJhdnJ3TXZQVHhCCkdw
bEFRUGVRa0Q5UnZjdmJCNjZPQXVPYkRnb2UwZ011a3VlZEVsYXBMNXpGYmNKRnN4ZHhDTVh4MFln
clZPbUIKYXNTWDkxMTArakI0Y2huVXZLck02a0txOHVrdjUwOEhPcndGM1lUT3lpWTJKc3dzaVBn
bHNKZEtJajZUTmFxTwpuZXFhVVJQaGUxNmpmQ21KR3B1SHBsbG1IOHNTWkVXRDNPN1U0b3BGdGRs
M3h6Y3pMeVIydUVpQmo0RDJETzBYClFyMWpGSXBHRHh5UzZHdlc3MFduNnd6Mm4vZHNlU0RvcGVN
OUV1dVN2alJvK1pkVDZQTXVRVEhxc3RjQmYrVjcKQTI4V21LbWdQN3Y5d3A1TUlZSko5M3k0YVRK
WUFsK0pwM1ptQlJ1TGxCaXpJT3djS3pHSk9ZY25POUxpMDJxVApGcGdGcUwwUVVOTmJEZXYvaTh0
SnBDM2pXYzZ2RzdQc3BLWFJnbWIvZW9RQmk2Q3pkTUF6UXJGRlloR2loQThMCjBzRVJWSHZKMmZ2
LzU0UnAvbnlrVm9zOWF1bDg1Y3hBVjRJUTlFQT0KPTNFR0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004a1eeb063bc224a3--
