Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17436257430
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042628; cv=none; b=jnsDd9Ylvn+IfkcRI++ZxECPCU9ZZ/aJh4n1xHLN5cmCR7eYcpRzlmTF38FbYE45NtC5FAThaBtG1Lfz0D1VGNtvWY0uPrDuz6Qu4qTtcbUVtp91BwOo3owz2off2thBE1MnKHk5FQTlRaAC3/VFJUZD8W6NEC3D7zNKszSKfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042628; c=relaxed/simple;
	bh=tX9u6Jes/52JOleq5cgu2uMsj5o6FKfF0r7FSKBaC9c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8gNg/0SBk+KzN0+X7I6IJANRaEqBOx5HWcfcHpdcENRLAesc7S+K+SXYP3ob4sbJjMLOmpWdJ3XeNru8F9UuWVEKMLrySulmq1HnjlBPA6jo3G95QvToj1ZO9omWIvSYkhu91fMXUHp8gbW2WOWceFYA5XQUok+y15FcZhv9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mifhuo9I; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mifhuo9I"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f7f7b70aebso3297144b6e.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747042626; x=1747647426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HSnpNvW+lvzD6XVJfh+q8j894L5oC43B5BbRO1PL8Y=;
        b=mifhuo9ITsjlJH0rL0UB0gjZU7ynnVkzhIOXdiUxpAFPlZsT6QJcjrUBNIW8lloPDh
         SntRorfcASVSCw5kod0EheulSTKjCvTKuD1FYXxCkX0Ja6ilV8ZoVoJzPJw9r9jZRPsp
         eeM3CLH3ljbAZQJQGVT2jZVrcefvAsgE3o+1oeKoQfloVo+COM78VJqGX4iJ6++GAn9k
         3N8EQhhDPyS9RL5R5CcEoFwyn26oSM9Z4OdZW+4iAt84CVvau76SuodE0nEGi5woDRGl
         3XOQO8kg05Qm4UvKXd+xcdIS/7KfQEnDGaAsTsjsckxU0+ZsWCxuOKradikgPz1ZEAAv
         DRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747042626; x=1747647426;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HSnpNvW+lvzD6XVJfh+q8j894L5oC43B5BbRO1PL8Y=;
        b=v/TPy6UzX4Nv1QsIgfzdP14CtIWLhsBUD8kmKCcrdhY1JSAgjsfySRy6JzWphA9SO+
         Mo81xPfVUsz0H7am2hzuMY7ist6FX7a8/Qo2nCSnIxDAQTlZMSORFh4lXWkqStNvXHpN
         iH8SvXQtCfnGAxUi1ugmCEYibvMZEIp4jpHdaID81ILxR20kfUnrfYyq+XRTOIadBGTU
         FcJsTzxhVf8Ggib9CCs/pD22dgtHBUqaT6alEQ4aDbvY+xkiTT/Kfza8CgehQwQtA7E8
         NZAmyviGNRr2bstswAg69nSz8p/8H5eR8A8FzFMor/uD85MvTgKynKuvlBo2+aXhJcF0
         rCkw==
X-Forwarded-Encrypted: i=1; AJvYcCU8s7ys11jTm14+ATTCt3HK6KogU9R3Tft7yj1gFvBJNzIVGcb3i+TNeBjbOe35CGfuHyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcG9joCdDMbubqMzqieNOlMuuTYUewNrJgt7qKKgWefzZbFVC8
	G6ddK6T8AB5FH0OZbH0721LeWjNHqCBK2AjD7upBw+7/wDJLivaC/vKTcZ3m6O6rmf4qn959Ea7
	rnxJd7kcF7yOOG3NmUI0jiQx9gWg3POqK
X-Gm-Gg: ASbGncuz26jSm/pYonrK/EYgVn6ZPMXgRG+naZdJrV5dAt9DtaMsK+yesbZ3iQNUHjI
	bW0a234xPliMfUZjXTZQfSx0QIrsed26qoGeTrzKSjnpWFZ9ChNCk0xQJ13zQC9de8M50sS/rTE
	1gvZk2ttUDUl0rNDPmlxKDy1M2PCbRq5qicmzxC47G9eU9PQmKuCXADIov5B4jUvJs2SHmGhdxR
	6ZN
X-Google-Smtp-Source: AGHT+IF51Plp8rfckmTiiCT1fozj1YxrlWjsDjLypXx1Mj9zagZKfTnjdT2doOktqj4iXnSzwoj38WR6B4JcjG3ccSE=
X-Received: by 2002:a05:6102:8097:b0:4c1:71b6:6c with SMTP id
 ada2fe7eead31-4deed33c0ebmr10023968137.7.1747042614957; Mon, 12 May 2025
 02:36:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 May 2025 04:36:54 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 May 2025 04:36:54 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250512020935.73140-2-lucasseikioshiro@gmail.com>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com> <20250512020935.73140-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 May 2025 04:36:54 -0500
X-Gm-Features: AX0GCFsC0cWgqBmFGJLHM47uQcsqN5gNVOaj5JlUiVAQUA0G2SXUe4JUN2_y6oI
Message-ID: <CAOLa=ZS15edO-qEfUdoiHA=P+ukaO=U49R2ZWhXtuuAWvLBZ1Q@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 1/2] json-writer: add docstrings to jw_* functions
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000078f3550634ed0edb"

--00000000000078f3550634ed0edb
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

[snip]

> +/*
> + * Append a double field to the current object of the json_writer, given its key
> + * and its value. The precision parameter can be used for specifying the number
> + * of decimals after the point, using -1 for formatting with the maximum
> + * precision available.

Nit: I would perhaps switch s/using/use to make it present tense and
easier to read.

[snip]

> +/*
> + * Append a field to the current object of the json_writer, given its key and
> + * another json_writer that represents its content.
> + */
>  void jw_object_sub_jw(struct json_writer *jw, const char *key,
>  		      const struct json_writer *value);
>

`json-writer.c` also has a docstring for this function, perhaps we
can remove that and keep the header file as the source of truth?

> +/*
> + * Start an object as the value of a field in the current object of the
> + * json_writer, given the field key.
> + */
>  void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
> +
> +/*
> + * Start an array as the value of a field in the current object of the
> + * json_writer, given the field key.
> + */
>  void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
>
> +/*
> + * Append a string value to the current array of the json_writer.
> + */
>  void jw_array_string(struct json_writer *jw, const char *value);
> +
> +/*
> + * Append an int value to the current array of the json_writer.
> + */
>  void jw_array_intmax(struct json_writer *jw, intmax_t value);
> +
> +/*
> + * Append a double value to the current array of the json_writer. The precision
> + * parameter can be used for specifying the number of decimals after the point,
> + * using -1 for formatting with the maximum precision available.
> + */

Nit: wondering if it might be shorter/nicer to say

  The precision parameter defines the number of significant digits,
  where -1 can be used for maximum precision.

>  void jw_array_double(struct json_writer *jw, int precision, double value);
> +
> +/*
> + * Append a true value to the current array of the json_writer.
> + */
>  void jw_array_true(struct json_writer *jw);
> +
> +/*
> + * Append a false value to the current array of the json_writer.
> + */
>  void jw_array_false(struct json_writer *jw);
> +
> +/*
> + * Append a boolean value to the current array of the json_writer.
> + */
>  void jw_array_bool(struct json_writer *jw, int value);
> +
> +/*
> + * Append a null value to the current array of the json_writer.
> + */
>  void jw_array_null(struct json_writer *jw);
> +
> +/*
> + * Append a value to the current array of the json_writer, given the
> + * json_writer that represents its content.
> + */
>  void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value);
> +
> +/*
> + * Append the first argc values from the argv array of strings to the current
> + * array of the json_writer.
> + *
> + * This function does not provide safety for cases where the array has less than
> + * argc values.
> + */
>  void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv);
> +
> +/*
> + * Append a null-terminated array of strings to the current array of the
> + * json_writer.
> + */
>  void jw_array_argv(struct json_writer *jw, const char **argv);
>
> +/*
> + * Start an object as a value in the current array of the json_writer.
> + */
>  void jw_array_inline_begin_object(struct json_writer *jw);
> +
> +/*
> + * Start an array as a value in the current array.
> + */
>  void jw_array_inline_begin_array(struct json_writer *jw);
>
> +/*
> + * Return if the json_writer is terminated. In other words, if the all the
> + * objects and arrays are already closed.
> + */
>  int jw_is_terminated(const struct json_writer *jw);
> +
> +/*
> + * Terminates the current object or array of the json_writer. In other words,
> + * append a ] if the current array is not closed or } if the current object
> + * is not closed.
> + *
> + * Abort the execution if there's no object or array that can be terminated.
> + */
>  void jw_end(struct json_writer *jw);

Thanks, overall this looks good, I would drop the 'given its key' or
'given the value field' and similar  statements, as they don't provide
any additional context, but that is probably just nitpicking.

--00000000000078f3550634ed0edb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e5e4b728ccadc731_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1naHdUUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXN4Qy8wUjBHTU82OGlDT2tPdTkxc3VDRGxxaGZsQgptcklMc2dzRmlu
YnhBdXN2c3lXbTZZdnY5LzRlWENGQzA4NE15MElpNnZTMlEyRmxVSkFDdnZrakRxNDdIVnVFClNh
VGJoSmdmdkExcUpZVnR0eksyNE5Wak9jRFRQS2w0Tk0xclNsekdEVTErK1IvTE1DMjFoT2RDOVZY
ZnVqR0wKb0JuMVYzeUhxaTZNQ3hRMU5CcEprQyt1OElZVTAyL25OR1BkWENGbjFDVVhLTGNNb21R
c3ljTnBPK2hSMGxuVQpaL1N5TU1jTmZMeDVMcUZsd1VKZ3dZZUZNUE5namxWSXJBMXFuYVRVN0tD
MDUwaUdzSG9tUTBxK0FEN3o3RUQyCk9xZC8wenphZ1pkOE5QdFI0Unk3OGI3RGZZR2dDbEtHbUpw
SUFTcTh3TURPcldYNkZsOGJ4QlBLU1Q1SWRDVDUKKzl2RDJQT2NGSVE3VXdKM09sZ1NRc0ppQUFD
Z1BHdlhwL1pNZmcrem9IQktXNWJvNG5Ha0lXUE0yRlpqMVd2aAo0OVdSYWZUWmZzRUxWMlZJTThr
NDF6QzVIUUNqbUdpM1EwZGhsYWFLa3NXY09MRURub3lpNUxaUE5meXNmMUdsCm9EcGZOVHVDQndL
b3pKWlltRmJxNVA4SW90UURQWXQxbFMvTjdOQT0KPWoxLzUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000078f3550634ed0edb--
