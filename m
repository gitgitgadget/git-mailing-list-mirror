Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B61B81F
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761109; cv=none; b=UFvtCk2pZqSwcSDzIAWJ6yv+XYsUf1xU87dxG5ge223RsKtoPOjW/5YMIOm8IrD91oaKO9R8nACScFLSzog5kSqmyFOE5QNIy6DWMdc54oK7t7JWUxYrrDpKEPgQZnVQp7STqCI9TkwrlKp2ZuR0tmFQMa5xqxdAUTB01t4XJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761109; c=relaxed/simple;
	bh=c7sRNOHkKjHgPkVWudNMwCj9wJEkTOqKFZhS+aCz6yE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ZBfFLtvugw04WZ0KQelR+VSwGalTZMDNNNEox1KLIxRcKk+9UcWxhNFHYwTcD97E1u8PrQEX3KK0ZPSgJnAuPdZrawYlc4KavnpCYwYhbWzF+dY0ZypgLzeOT9rJDVa5SG7+UrJeFEXwNCGZZJ2rLocCP/pQIOhLKykhr9DMdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOK+pL10; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOK+pL10"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22008177fbeso57198fac.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709761107; x=1710365907; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgwE09/eIljQQREWnOD79tIDthPqzsXsyrU8PcCLFPk=;
        b=gOK+pL10iMPMQ2xpoTCSr+BsoDM+3tkNUmePt67kNEpIDwbd/d4qJvLtR8EZSyprXT
         8vYOnwa9q6L4mpFZ/8hp+Ghu5VemPf7vFhKtZjvapn4PGlTfDrtlo+Q5i1qe3bfLRNoV
         yVlfneYBkqrvEMc3wTCzUN9FEIk4SS6aSuStjPjM9wKykKFrjPTenX5k7txAnCtA9iD+
         1adPia4os/a+lDQi6GKIWO4sSEDvRnrI1dTGchE6pm1Yp+7RSNeflRqXvZ5SmkTkVjXa
         YBmrrs79cyCTttK6k+OheMi37kQDUKZNjk/bUXv4PQS35HI7ffW/ufpvp4jtwORWjFmM
         ycvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709761107; x=1710365907;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgwE09/eIljQQREWnOD79tIDthPqzsXsyrU8PcCLFPk=;
        b=L0FsZYKNzx2o6r8lAw7sBDdLtxIv5vZvF2kQdb4slbyeRRRiopb4cpBcurMq+h8QMU
         WPZbrsnovE+QrfMLAPtGhLzaaqukvC7mxR35Knl422/RsuCuzjof9F7DOzAuVb6ROKPr
         awh/rThDj+xEKxwAY1eeRJWRied1lixFl2JS1V63xyJuAa3lKirR+edGZvwlMDBJIfbX
         eWaCjpJ30I19ecD6Ded3OmKcPYKnDIHcKjVOblyP2M3WnuUVanDpWXw6cmVLgSZGCJIt
         v6P0tjZIWXht/U9frZBBTTsduIELGqKuXHxNwOaodOmBWSq2OeRwms4PDdoqan/B1QeE
         eJDw==
X-Forwarded-Encrypted: i=1; AJvYcCXT2C/vF9weuMHuI6ysnBQ7unt39bZnM0ONVgKcqCvcy8NPiifVHj3Z/PYvUBdD8ArUy/OOwqwOYviQ2tT+ht+r4USG
X-Gm-Message-State: AOJu0YxwxzlkpMKkrl9+apbnTx81TMlhQ7VfaK4in3802xW9FHmMK2gq
	6pQ8DV96hIXangdHZNG8Zk+YUqhsfdYGO+wi0t4QN6N5SO1gKYkodspF3q7hX5Q0TNBScAvSeUT
	ZNql9yeRzy22OoB7Gt0AgxPVyqR5tCut0gH4=
X-Google-Smtp-Source: AGHT+IHSA8UmFow8f++SSEbsV7B4s+999cYR79okQrhoZm8NAmyK9aBH2SKr/K3DPHZEI2CfP1sQlZH1I3LQEqRXI1I=
X-Received: by 2002:a05:6871:54a:b0:221:21ca:1523 with SMTP id
 t10-20020a056871054a00b0022121ca1523mr6279145oal.17.1709761106653; Wed, 06
 Mar 2024 13:38:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Mar 2024 13:38:25 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <f79c0f94e415de5c1c7b4120af5270fe4900d825.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im> <f79c0f94e415de5c1c7b4120af5270fe4900d825.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 6 Mar 2024 13:38:25 -0800
Message-ID: <CAOLa=ZSg35atoTsBVtWj_j94n2Mt8otzfw3DYLYS9FCbNgp_Xg@mail.gmail.com>
Subject: Re: [PATCH 6/8] builtin/config: introduce subcommands
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000069cd1c061304c752"

--00000000000069cd1c061304c752
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> @@ -910,6 +930,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  {
>  	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
>
> +	/*
> +	 * This is somewhat hacky: we first parse the command line while
> +	 * keeping all args intact in order to determine whether a subcommand
> +	 * has been specified. If so, we re-parse it a second time, but this
> +	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
> +	 * line in case no subcommand was given, which would otherwise confuse
> +	 * us when parsing the implicit modes.
> +	 */
> +	argc = parse_options(argc, argv, prefix, builtin_subcommand_options, builtin_config_usage,
> +			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_UNKNOWN_OPT);
> +	if (subcommand)
> +		argc = parse_options(argc, argv, prefix, builtin_subcommand_options, builtin_config_usage,
> +				     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
> +

I wonder if we can drop the PARSE_OPT_SUBCOMMAND_OPTIONAL in the second
iteration to make it stricter. But this is OK.

--00000000000069cd1c061304c752
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 831ccff3c59d5c46_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YbzRsQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekZLQy93UFhZbCtwNnE5YndVYkdLOHM1RjJYUWVBUgpJcG85NGs3Wkpa
YklGeDBBVUVqZkpwdXROcStCNkp6MWVNQXk3RlhFd2JLcTZIQUJTbHg4ci82cTFUUkJpT1hNClhV
ajFWMk1teXJrMlRqb0JBbnpERTVaQUd6bWZQVUpacFp5dEVvUExrc0tKUytvL0k3cFVvKzZPSldu
dmZjT0oKT0hvWTVkUXE2Z2tXMXJrUitCKzg5U0E1bE1xbCtFWEhvMzVOS0dwVWNVNDNNNjNHZXQ5
UmEwYU43aGNuTEZyNwpOZldweHh2U1IxQzJtcXJTYTBOd3NtK2lxK05QemM4ekZSaERldS8rZTBu
MUZlSFJveWNlU2VZdzhUaGtOb2VyCmY2eEY2RkRmekJxVXREQU5RYWZJWEE3aXBHM3ZvaEJsTGZz
VzhWa0VOTjVLcGNIVTFlTURHTTI0Vys1L0tRdjEKYUlJZXc1WU9MalVINnBMQkJOZDVKU0V6Nm9F
N0M0dHFzMS9DS0tIdWR5VXd4OTFwNFA4SGRLUVhpSUxYdnFwQwpKWGsyY1d6TWpvVkMyYUk3UVNx
aWwyS3g2OUh5ZTZodEVrVzZRQ1NtYVNBakY1Z1N2NUduR0FKTkxqTmsyK0gwCk50cHVEanZBOC9s
TlNkNTNlNS9KeDcvb2dreWVCZ3JaRThTaytaZz0KPTE5SlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000069cd1c061304c752--
