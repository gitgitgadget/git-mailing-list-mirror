Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3B34E744
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160985; cv=pass; b=Z3tJ3kULWlqwNDgg4urwn83xQ+A2L4wWJNfNdr526mEJyqt4lEbpCnhj+3nIB1vTyCybEEf++B4S1VpQrUjPIzrkKdY19XFV9w86ikY5hDH3yMAMMVpJ1gU1kAoZQVI46iIrC5if8zGL9xRhtXR9GXcbZVX85itnPfpZJ8FQ57E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160985; c=relaxed/simple;
	bh=qWnrZWCvprosHsE0PAZtah/t0T1IRWnb7AnpgOYLhxg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APb15rKVOCPnV0WENXrre0MiWKQzf4uRNHz1/VKtX4Tm17OSDGVn43MKeWDwN+LEwtwfx9t6Q2to2NWVqRKPL5L4VR2xm4YyV919+sV6y4VSd72c4lfBkyOGPnznELHKdw3x3gBrJPw5CO5/m0JSj2JEUEWOJBC+Dngvg2SGJ5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQJm0N3J; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQJm0N3J"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-728e2e57e27so2830718137.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782160982; cv=none;
        d=google.com; s=arc-20240605;
        b=SUvs0EEPckgbhXMOPlcS7ybyGoIdCBTrYeCJeGvMXXp1XohAvc61QokkyUzl0XgzL1
         XhvUaE/IS2SjuV4VEdNDbvGksTyJ4r2Sgs369nOGtSbGUGrU+EY4TL6cGZlzhKZOQgBi
         aMRLcHs1Lr2ThSEaqoRP4+HveOfIyut8B9SkNHSXpl7pyin7J4SdBavzz69ZrgZ0guBF
         SamEU8eFBhoBvWxnMMX1DvqQH4de4Q0tgsmHRsFnm6Z2Rs6/8sjFg67M0VqzVLJE1ySE
         2GgfhRTK4AdzfVhwNbVrFGzCjRicPZlxpwoumgSS0fDe8ShaDf2PVtLHR1/IEscRbchy
         LBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ermyU4XOIvakL5JIETLNuTMJjVpRZ1tVhJ+tfdFA2GA=;
        fh=cXep4ytkqaGO3DGnsnKOi2fkYP6zcYO2Ni2MP/8SHrQ=;
        b=KjscCDTD8lh0r743r2ZJdFokbvzU0Z/q0oY51B0wborPXn+Om0sJTBGCGINLf6m+MX
         +O0G+bRljgmxwCI3XxSkeDRGcmiPaOKofJoMf/9TP6MjUsYNnp1xUbgTW65EHueNZO9v
         Ft35fP9UixPQvByf5GPqyJL2ti8xZysMG0FlmAC0eXrfhslSEUauYFmoqHf0tlNQpgdy
         vbGLXtfZNOgAGxZxfRhDV/JV8JfJV6FRBRgCVa8+v3IaswhTv9Zs9eT9gIX/TxRzAFqC
         7cbXza/b95yCPW1z6tzZhLU4yyBvDpQY0F8j5Ah9++WbwKkSaG6Df1TwG5XajzuukvOA
         UTaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782160982; x=1782765782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ermyU4XOIvakL5JIETLNuTMJjVpRZ1tVhJ+tfdFA2GA=;
        b=kQJm0N3JJvLNxqLlwOHO4590xe46SFW+Smim1zTM60Ap12wgAS9ixvILi7fuOmk7aR
         SQ5JqvUFDXJptBkr97ByuZvoPyGRl4MvICNnQi5GVFyKRgYIMHDqNfVbmOdZdqJXi+b4
         BzBdH5p3iBKd/9hxd0Y1CCam1VzMdljrqAhMw6W0tLVzdN0Q2nPgYrtVqrqd4WJdmzxE
         vB9OPv341JCS0eO1+30Rk8yL8By3iRjD6Nx8wC+kWfO8kXTLSa8sClCCqS4k1h5GHLsz
         7eGhlfkXiNLSPuJNf91p1lWwFLW613MYIKMTd15mK79uZhlF0VilIdNw2mhm43Zdc54V
         BehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782160982; x=1782765782;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ermyU4XOIvakL5JIETLNuTMJjVpRZ1tVhJ+tfdFA2GA=;
        b=HWVg1HpNHsEXNOjt/tHZ1fUcF2PBEo4Wivxiu2cGs/rNy9oPEBqfamIzoUtI9FpYNO
         HAgYkmP8iyTSdFR2PyU1krwRgHarUVYJg9lYcWL6pUOPvLMnbIuqHeLB6EmOSiwIfAsa
         sSJZ4uW1YgYjgUKugSUGLzKC8JDGev8+AHahf5M2T3NhO1EmZMombHcwXUy7J8UwOUhf
         mi3bG1J1sLaaAcWrwcagCpRZrxARYmCVzwWYnS2KoS8qS2waYBPEbUKrEjLzhlhxCz6H
         bna4t1gnjE6G5x36knw/vbAcN8cAeEdYYkVV9G8x+tnWcZu6MaCAAaQTActz2wP7rF3Y
         XEaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9V37jhOsY2TcYUpPdA6sK51Sf+nF6TSpHQqvPLdVTLx2nMloAYSvYuri1si2AY5IYoKsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Y6b1usWBbY+FXS6zvydTDecpFToDYScMGO6BETf7aImLovhP
	TuGxoKJeslu3Ahl6kBv9TLeIZH06x9u8t362vxkcLbjNhEIMI6a6EEdZBctoe5R5NMkvKQDjb0l
	rWpzNjRhVkUAEFmZcFDuBtDcSztaukQ0=
X-Gm-Gg: AfdE7clvUlW1KdEP1KFeCL7feDF/5ZuE1cyBCssFCVdkIJlld2wB9xfOMOgbXN7Dp5g
	Cl4E1qHqq11D1o6BICyhu0wna0GeBrAFgwPmeUgjQO3NMk/fmip+ch66oRSZ3ai1HLIUVgnS3Hw
	HO1OJluky+JSMKMKq1dW9xhgZilG8rgO7UIyxKJuBc4nW23vflThXC0cNMrBQozU1/FTWIxSDPQ
	8G6D88IKpqik2PuNyQHIT583nKT+GmcxEhVU2ODSxhZsiPOBuJoYqeicIHlJTqraJhCFdaBnudC
	K/J637S2fUyxkTcHP9KVUwZbpnkrhT531YYlcoN54pkOmsc9mwYWq0Hw+i2oYQ==
X-Received: by 2002:a05:6102:3ed2:b0:723:b92:31b6 with SMTP id
 ada2fe7eead31-72a2001dd8bmr10238629137.27.1782160982576; Mon, 22 Jun 2026
 13:43:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 15:43:01 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 15:43:01 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-6-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-6-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 15:43:01 -0500
X-Gm-Features: AVVi8Ce39HxTBdY8UFr__Vr9dBvCjSaHXZ5OA4tAvIhOR8p7SYvwg9aj_NrYErw
Message-ID: <CAOLa=ZSvxXuf_bSzKMvViNQ5MuDAqxnQdo4asF9vfMhJaDQcVw@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 06/12] connect: refactor packet writing
To: Pablo Sabater <pabloosabaterr@gmail.com>, gitster@pobox.com
Cc: peff@peff.net, eric.peijian@gmail.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	chandrapratap3519@gmail.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="0000000000004ca9bb0654ddb097"

--0000000000004ca9bb0654ddb097
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

[snip]

> diff --git a/connect.c b/connect.c
> index 1dced8e632..78c69d4485 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -700,16 +700,16 @@ int server_supports(const char *feature)
>  	return !!server_feature_value(feature, NULL);
>  }
>
> -void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> -					  const struct string_list *server_options)
> +void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
> +				    const struct string_list *server_options)
>  {
>  	const char *hash_name;
>  	int advertise_sid;
>
>  	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
>
> -	ensure_server_supports_v2("fetch");
> -	packet_buf_write(req_buf, "command=fetch");
> +	ensure_server_supports_v2(command);
> +	packet_buf_write(req_buf, "command=%s", command);
>  	if (server_supports_v2("agent"))
>  		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
>  	if (advertise_sid && server_supports_v2("session-id"))
> @@ -727,7 +727,7 @@ void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  			die(_("mismatched algorithms: client %s; server %s"),
>  			    the_hash_algo->name, hash_name);
>  		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
> -	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
> +	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
>  		die(_("the server does not support algorithm '%s'"),
>  		    the_hash_algo->name);
>  	}

Why did we make this change? If the server doesn't support v2, then the
object format should be `GIT_HASH_SHA1_LEGACY`. While the value of it is
indeed `GIT_HASH_SHA1`, it indicates a scenario where there was no
option to select object hash, which is the scenario here.

If there is a reason to make such a change, perhaps we should highlight
this in the commit message.

> diff --git a/connect.h b/connect.h
> index c4f6ea4b0a..8f4c523892 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -34,8 +34,12 @@ void check_stateless_delimiter(int stateless_rpc,
>  			       struct packet_reader *reader,
>  			       const char *error);
>
> +/*
> + * Writes a command along with the requested server capabilities/features into a
> + * request buffer.
> + */
>  struct string_list;

The comment should be above the function and not the forward
declaration.

While we're here, why not `#include "string-list.h"` and remove the
forward declaration, is there a circular dependency?

> -void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> -					  const struct string_list *server_options);
> +void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
> +				    const struct string_list *server_options);
>
>  #endif
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 4a8a70b5f3..3d32114907 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1387,7 +1387,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  	int done_sent = 0;
>  	struct strbuf req_buf = STRBUF_INIT;
>
> -	write_fetch_command_and_capabilities(&req_buf, args->server_options);
> +	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
>
>  	if (args->use_thin_pack)
>  		packet_buf_write(&req_buf, "thin-pack");
> @@ -2255,7 +2255,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>  					   the_repository, "%d",
>  					   negotiation_round);
>  		strbuf_reset(&req_buf);
> -		write_fetch_command_and_capabilities(&req_buf, server_options);
> +		write_command_and_capabilities(&req_buf, "fetch", server_options);
>
>  		packet_buf_write(&req_buf, "wait-for-done");
>
>
> --
> 2.54.0

--0000000000004ca9bb0654ddb097
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d8cc8ffa205ec494_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vNW5sTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2p1Qy85S0Z5K0t4emRmQ3pLSkJrYTg3WnUrWjY0NApnUm9lRWs1bHFP
SDdsSWhrYk1Ia1VnUXIvdnBzRU5UTlRqbDUvM3R4cHRWYjV2Tkc5Wkdvc0tMTGQwNWlmdVlVCmtz
eEFJcmx1cFZDSExmckEwUHRvSExhWENYS3VsdHRmNjBtMEFEaWJWTEZ2YWhnWXRuenhYSmdOREpr
THJnS2QKMjh1RS9UWnZDdGZ6citiZHFzaFMwZ2NjRTkzS1M1K0taYXc1QlY5QnFYOTU1dmNQQkhB
VmRGNGhkYml2UVgybgp0OXJTMkErVXpnZ2k3alJsWEttNkx0YzNraEVNTzFvKytyamk4R3B0M3l4
dU1JcmJGdi9tWkZ2N2F4eHBDSGt6CkZMYTFoekR1S3NNeUxRQklaUW9BTThXK01taXdSbWNxOXRM
TlFqeVNudE9pTXhCNGt3OWdGWkxLb2dlZ0RJVEoKRmhQcGNwNERNaFFnZjdCWUtxTTk3RnB1UzdD
UHVwK1poVjRPZ3FWY2pVeC9uRUFueDJYeXlmbFBiQTJrNUNTYwpCRGNwemNBRWpYQ0ltYVBtSnhV
TjVyYnl6WnUrQW53VXB2ZnBITVhlYnA0YWRReFRkZjFZYzB2aW9FaTFVMGZiCityc3R2ZlN2WE5y
WDdLZ3FZUnc2VEgwS1Q4eWFxdE0yT21wVU1YST0KPUFIQlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004ca9bb0654ddb097--
