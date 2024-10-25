Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032E1F8189
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853605; cv=none; b=UK6rKrnfulpuxY59nw/+A5qDj+YIfhhDSjZvKAdZysbQqseKanhWCFzcpM+vDTCaFDvBG8Xg8NmSFY7GQNeGGahQ6c73AM5+kNRsiPNOZI0PaA6jCnyQRhOZvdT8u97QPvZbHNn5bFWoTEhm68Mbtu+mreHa+sD8KjfYbNSko6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853605; c=relaxed/simple;
	bh=KqqoNUeIp2Wl/FHtNdz9rpb7TDcnDS2GliYjZ4eNhYw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbyIH80s5Ar/wizk//PBAscJo8duEE04P+dgd6fIWik5PpVJyR/XNmfjsNWViqdfy5/qgKLlr6EUxOw5Vdn7pRmdJHAM6MqESdbC5GH0rjbzUodO0TIpmf50ycQRBD7ZGseamTse+hrB8xGbCYgJN1iPHWhWW6beaEZ4xaOU/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv2DcwLV; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv2DcwLV"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fc21ac668so495263241.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729853602; x=1730458402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3769xZ4Tsq2TDYj7D/e7rVY9Va6G9JbJ/hK9He8X4uY=;
        b=kv2DcwLVViJcooEJIFNyyH5qluwmBKxorS5o+9JeMKb2EWBV0sgc0VaPBPs0G6le5p
         2qC1JpofeMPxnNRSKXM49UgeQTPCEvYsMW+hkZEIEYGC1nkaLY7FuidEFIFYVUWoz0xZ
         lJvXHnMeAensw89AmQoWwxOIaz9nHVUnH/JDOoaKwodkGQxeSL3aUdvIYXLi+W9vJmk2
         ZTif93/N78NH6VCUDPHHn8fHBkkLO5H0ygkwnO5bvysWYwkYXmJTIOXQarlHl0fXRp3Z
         /WZ92SV4vCyLnD1hIMnCrrUF7wuED4XJezJm/RakVOEbsDNP/sWcAFdwGeYJNoXo1OU6
         xs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853602; x=1730458402;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3769xZ4Tsq2TDYj7D/e7rVY9Va6G9JbJ/hK9He8X4uY=;
        b=lcS7tEIqaDW0pZbm5muUdiB0Dmf2iN7O6dF2eadRnYwoIbAjksYGo6/aumGXBpaZD2
         ywdTyF4VsPB/WQH6U9UJAQHo5MI6Vg2LoqtfFrxjhQOsKuuuuI47VL6TncBC9n4pqOmH
         yzQtb3K4qXtOFvW8hI+bHwDOh6BNx+rF7MNmoaOAN18W4fZG+PW1JGNeXhLqTM7W6x/O
         x5fyGKHYXOrx16zckfUciwVaJiKfiXcH40V1A1U063eH6qtqx212iSbBGTHGw3CsoAAa
         mIMH3a337DAp7xNr3V4nzprsjptTTbYSATkEpSFXkZHoj4qELEXyKh5/av6tYiHkMLfj
         knrA==
X-Forwarded-Encrypted: i=1; AJvYcCWmvCXT/3zHZLtycForii0FZPA/1jdGxKn37MFAe5XS3sFcdLBliHkqCcPgQJqiiG9zcv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBF4i7qGFrUNsWmzYReBtoEdgF71RMA2nK/lxMShWyBxO6BPSU
	cLxpXwiH4QxUeG8GEWV3/mvzd7bS59vHNqUIYZ9w/zHiurF57vKZPXR6KCvWNVD+RsqkwGQ90Pj
	JR5Q3VRm9JV+5YQoC47lqeXc0KdQ=
X-Google-Smtp-Source: AGHT+IEanIzES0msyC1ANHtTPTXhy0F0NLhLdFnO06asnNv6zh9BxrD92kv0Zyb0xrH4OhtDYk5gllmzzURRhmurkso=
X-Received: by 2002:a05:6102:2acb:b0:4a4:849b:7616 with SMTP id
 ada2fe7eead31-4a8711df706mr6828190137.25.1729853601841; Fri, 25 Oct 2024
 03:53:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Oct 2024 10:53:20 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241024205359.16376-7-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com> <20241024205359.16376-7-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 10:53:20 +0000
Message-ID: <CAOLa=ZSVxOoS0iQ0Ku1LF2jwSw2uK8DMjFJYL77Bto98_sKMUg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] cat-file: add remote-object-info to batch-command
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	toon@iotcl.com, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000739fc006254aed77"

--000000000000739fc006254aed77
Content-Type: text/plain; charset="UTF-8"

Eric Ju <eric.peijian@gmail.com> writes:

[snip]

> @@ -314,7 +323,10 @@ newline. The available atoms are:
>  	line) are output in place of the `%(rest)` atom.
>
>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except for `remote-object-info` commands which use
> +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.
> +WARNING: When "%(objecttype)" is supported, the default format WILL be unified, so
> +DO NOT RELY on the current the default format to stay the same!!!
>

This seems like a planned breakage, wouldn't it make more sense to
implement %(objecttype) first?

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5db55fabc4..714c182f39 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -24,6 +24,9 @@
>  #include "promisor-remote.h"
>  #include "mailmap.h"
>  #include "write-or-die.h"
> +#include "alias.h"
> +#include "remote.h"
> +#include "transport.h"
>
>  enum batch_mode {
>  	BATCH_MODE_CONTENTS,
> @@ -42,9 +45,12 @@ struct batch_options {
>  	char input_delim;
>  	char output_delim;
>  	const char *format;
> +	int use_remote_info;
>  };
>
>  static const char *force_path;
> +static struct object_info *remote_object_info;
> +static struct oid_array object_info_oids = OID_ARRAY_INIT;
>
>  static struct string_list mailmap = STRING_LIST_INIT_NODUP;
>  static int use_mailmap;
> @@ -528,7 +534,7 @@ static void batch_one_object(const char *obj_name,
>  	enum get_oid_result result;
>
>  	result = get_oid_with_context(the_repository, obj_name,
> -				      flags, &data->oid, &ctx);
> +								  flags, &data->oid, &ctx);

Nit: we usually don't fix parts of code, which we're not explicitly
modifying.

[snip]

--000000000000739fc006254aed77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: edcca7f9110d212_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jYmVKd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNk9hQy80cjNDMVhDNHRMWi9GclIxY0NneWJOWHhUcQpXSlJpQ2Zod2RM
Mk5meUFTK3M0WWNtcTlJcU9Ec0N2ZWxNMnVpc053MWw1OG5OeU5UYnhyMFFYd2s4emVROStjCndQ
WmVtVkFKREJlK3FKamprazR1ZHYwYWc4TUNsckdIYkNPQ0hnL2wvdEVwR0srdGlrN2lmMzN5NmNU
c2pXTW8KNkl5WXpsQ2tjT2VOME0yVXpJMWgvOWhhakVOOFd4VE1oYVVsWTQrSU1kd1hmUUpPOWJI
MTFEaXZJVUxST0d3UQpHSnRGbVFqVm52Mmw2TndpOHUreXFYVVhzZ2MwWGRpeFNGaFNLV0xudmZw
TGg4OW9HMFZXU205Y2tKRVhjYU91CjVhUjR6UmJXSzBxTG14S2J5OGZpaERxTjZFQ0JRQ3BWMEd6
aEo0KytQK2s2QkFxZFBYTEFlQUpEREszb09BNzgKVTFwa0FKaWZuZ05BMEJxRzdOK1JsZlpvcG9l
c0pzODY2QXNobmFINlBPTldOdGZQUXRrbGVUSGpYeENuVUZrWQpYY3AwNUNmQnhFZ3JRSUh2dUNU
SkM4VkdOWnVLMWg5OWlqSFlkVmxrendxWjBGVVJ3ZW5pUkNHcVRwaXFJZms5CjVLUVN5TU0zd2pE
THQ2SHRnT3oreUZHcE9pWEN5WWVnTTZaK2Nzbz0KPXpqK2UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000739fc006254aed77--
