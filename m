Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FC14A0A4
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723750; cv=none; b=Uiebnq/zetLumKMAo3BdcJ3td1b4SrlYNuXOqm/CixUTLcPDSg9wyyv0PtE4cssKpjDQw8AskZl9qSMxTEIemmo+Mf7IPJKOqYDVrHVbG80ON601PbzPTjyFu7eE/0UyOZo/Zf8pavZZriIb7usI5MkiAmoIAosed+KxmBSElmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723750; c=relaxed/simple;
	bh=K5d6KoKbzG62WU0JI2tEkmm4t0XIQWLokPhcJTukp3A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqSjcJWRBH7Esqj+oz9/P90RKmwvMNbiN997h1X2zAWxMvZkSc+n34mdBVyYp/6+tb8IBqX9pPhU4wsNQDGzoBLCaWi4MMm8hUGJakhuHA4RRxCm2JljA2a/kMHssaF81gdahjT90fr4bulJ5APwoG7W/YTKg4KlDPjeJvBfSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmc+HnsY; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmc+HnsY"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-26119999171so2340386fac.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721723748; x=1722328548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbwPYv3X9s6+cIl42kuZ//S6gsisL8UnM+ZWQcknZnM=;
        b=Dmc+HnsY8/Rswco4coi9RkowxArN430KZBEoTuBevp4k3akyWE3f6AuSHwvAgRtroo
         ACxY9esGzTLNSE9duRy1SH3XhRwpvLThx/jTYwiCeGMoWwahYKzz/3mFZ+R0BiLy3HCm
         wd3O2VKOMAAnoAe8FY1b/GF04YBJIw2cvKiLAeQXLPJaYz7vPcNRYWMKE24lnukmvL27
         5UPKnmP4dX1FCynWa7uyfWylNqF9KTyNY53mICENMlUKRu0XmFZaKDXEAp3slhOO8dyJ
         Am42W7UXtAUoV2j4C4fYY3/hz+yLxgqybBjt/jNAkL5uJuckCjAzovBwPqwST1V3urpd
         dYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723748; x=1722328548;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbwPYv3X9s6+cIl42kuZ//S6gsisL8UnM+ZWQcknZnM=;
        b=onVY1H/CsP5NQPrI1Xv7IiWY9k8efS9GwpoPgfcebtK17ChJzkfCas2ixCOkcv4Adh
         Y5Jmcw/8aUU+yCRr7TAdASxefxiBJrA8lRVB3EbS3tNifud0w3Za1RD3BANJBKD0j5Nl
         3/OgDfETayqudkrtJd3nK0DKkTPXp1SjdiUwtbeO3AVvMTsmNbD+MU+vf1tL3Xop12gK
         HV2w8oiKDjNQTbvnRLxonNN2TUX6eLT1ap6cHNn225bdQuWTIykzSe5jAyby4xT23sQ3
         kco4KcnK2IWNw9uin8umq2o068tetWDxtpiC6kuB6EZVzA+eiKwLeH09On4kBcZUlccH
         Abgw==
X-Forwarded-Encrypted: i=1; AJvYcCXJunz96oaOGSsxcM/KzlOHDvD+VfW4yWsx3Xz1vfbGfnuYQoGe70lWJQjjshAaW61nuiRTDbERM3CojNaYYLMKWbsm
X-Gm-Message-State: AOJu0YxmbBNB1wOx/BVWCTI5GZfgs6+jKUvYi4PHUNlPjOfgqDWmC9GI
	9y0cbTGs96M1qdyX8sqP7i3B/ycU2xm2/BMYUF5ciL58uwZWQjpFrGHzd6EjOx8HAtvp3mXgIGw
	uexZj0jKpTe2PAMdtAFskRgovLUU=
X-Google-Smtp-Source: AGHT+IEQNjgQ0P+4dsCtRv2JxObiCWQx6bOQwNajQxift0ztaTkm9FZtPooW871RqPpCVZ1morisVGMhFbWLniGxkHY=
X-Received: by 2002:a05:6870:d111:b0:261:acf:e95b with SMTP id
 586e51a60fabf-26469228613mr1937166fac.36.1721723747744; Tue, 23 Jul 2024
 01:35:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jul 2024 01:35:47 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZpuDCc8SZx8e4mLP@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux> <ZpuDCc8SZx8e4mLP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jul 2024 01:35:47 -0700
Message-ID: <CAOLa=ZQKvEEKYHj5WACjfAT4DUb3=p2g=WaWHr2zG0FE1UJO_A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v12 02/10] fsck: add a unified interface for
 reporting fsck messages
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000062dc60061de60c11"

--00000000000062dc60061de60c11
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

[snip]

> diff --git a/fsck.h b/fsck.h
> index bcfb2e34cd..a2ecb39b51 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -114,7 +114,9 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
>  typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
>  			      void *data, struct fsck_options *options);
>
> -/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
> +/*
> + * callback function for reporting errors when checking either objects or refs
> + */
>  typedef int (*fsck_error)(struct fsck_options *o,
>  			  const struct object_id *oid, enum object_type object_type,
>  			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
> @@ -131,11 +133,24 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
>  					   enum fsck_msg_id msg_id,
>  					   const char *message);
>
> +/*
> + * The information for reporting refs-related error message
> + */
> +struct fsck_refs_info {
> +	char *ref_checkee;
> +	union {
> +		struct {
> +			char *sub_ref_checkee;
> +		} files;
> +	} u;
> +};
> +

When I suggested using a struct, it was to replace sending both
'ref_checkee' and 'sub_ref_checkee' to the error functions. I.e to send
a single struct instead of two different fields. But now, we've included
it in the 'fsck_options' struct, I don't think it should be part of the
options. Because the fsck_options is used beyond the error function
while 'fsck_refs_info' is only needed in the error functions, right?

--00000000000062dc60061de60c11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 79d2455133f5e187_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZmEyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWlpQy8wYXZNc25DL2k0R21Ta3ZyNlI2UzZFQWZTUgoyUklxS2tTbEZ4
aFNvOHdGMUdHNjhGMXZLQk9FK0g0UGRtbUtxY2xPbVYrMFBDTnA5ZDJ4OEZxRjJ4ZU5uUmFrCnd2
d0haRmliVjVlbnJGQlBJcUhsSnFRc2oxZmpwWTZyRWJwb0k2WmV6QzNhNVg1TFk3d2NpUXRIR2Q5
MnpTZ2YKQ1ZQbnRQWjRkN0RrcVFvek5lTHlrN0tOa0ZGcTYxbUpKdmh5aGxyblh2QkN1cUE4YXVx
bnV1NVFZaWVPaDZjNQpWRUJGMVBpL1hZZTB3dkVYTE5PejBuU0ZBQzAzcDFDdlFZWGh3enRiY2dj
SzJVaEFpbU5YUVZXR1JYa1M0ZmtEClBGNWppMm5jTTRqaDRiZGpVL1plNlJMdnNGcm5rWXZkeUNa
TE1sZlQ5bkRxTmxaczgycXV1VGlQNlMyamxRTlYKVHYvbFVCVHROcXlVZXp4aXlYdTliNlcxcFlI
NHlOcE90OE1zaUdtU0NRdnBRUmdOZGkvNEVxWlFCZUhrZDEycgpkMEMxYkRuYXo1V0VCTk9QRnhv
aStWanJBZkNJNUhZNVhkQXQ2T0kwTTE1M3RyVDRPUDdRNnJiZDdPSUdieVM1CmFSZzQyZlVUd2sw
NlRtTXBERkxDY081Um4wWWNjWWFQWkVMaFlIQT0KPU82MXYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000062dc60061de60c11--
