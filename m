Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108651E3DE6
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594313; cv=none; b=X2X4jQM9jH+DUsSUVVjyFaSZDhHZgNwSCyWeHCNkY0mYrJdjV3hK9yP50HRxvlTWR0cGUMUoTYyVfffif/tFXct/yffGqf41JqwDGldkBsSrSC/P9jE9dh233/QJm3yyEXd0xW/GCBtZH3tZlYILmZ/MV+kdkbUl59AplRKBfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594313; c=relaxed/simple;
	bh=zzdrBzNeUwxNwTqogYei0IAftd/66ZugiDQ19hiXS/M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2D2LnGLHOE4bSuaELD9gzbDXHh5Bg6o8JN68/wkv/BZIfmcjHT4uBmHifSpEwcnzwYeENquq+8IxcMpqOxiwPEPu2U6ZRPevniLBozflxgA4ueZ46+4x9L73NFk8ggU1LIBn54tcX4KhWsnho/ZXmEKJEXnR9bVVF4ltsYu0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b29KGn/P; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b29KGn/P"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e988c5813eso682896eaf.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594311; x=1729199111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OQDgMlq0he33WBSYnVhWPHKVYg4FDDfispSfEE/WZs=;
        b=b29KGn/PcbAZQ5Hw/vDeON7gqJh5yP505EN5NYKSRXa9bt1LNr71JXhbUpa7RU3VoQ
         W0QNFHp5Ot1szu2WSMNR+GzF9pQsfD5buR77dRj8ubx2gHlg+wRpP3tPyRrPDT7Z65Ao
         na1HgNauq8f6GvS2tTsuOwfv60r8COaHk12PJgXhryrtsBzKC+wRjlFdLWshKmXbOBAs
         HbMlImRAWwgjz8Z8Bt06LT4orX8TotRr4SsZQnBtpWmqY0/1jVusgINEfAoi6N3v6uYG
         HGHK8Xxko90PcWgMZRpAJMmnvXrrH9PeWVZuHD3cmo5fTTlkNzpKBtGe+YZ/iXmGkCZm
         4MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594311; x=1729199111;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OQDgMlq0he33WBSYnVhWPHKVYg4FDDfispSfEE/WZs=;
        b=V+zmUHKQrYql1nZnNfJ8y9xV3JfociP5lHdBa+MV2rwYvTDuK5wtiuYrVnl+AlpohL
         TFTiWuU6e7V30ZgOGVdl6s9ZW+DbMj3XryyeFvHFt3/7L2+7O+3pgC/CRnnnf5motxB2
         zI89WbU15yaW+1n6F2NRe5MZQvNGd+Ph8Fa3g/OQc96y1es6FXQqE95XDEbg1W+NNrcj
         +YTQVKNf9MI+3sXwAqGtYcpH5ngDQbwp3FwWrNJdOazUBy8qdaxrg+G+A5Psv0W9rAFr
         eqUsh1jC4FJMbUdJC/GcHHJfUb+dwIT35CXNS1qQ1gQGZ3qqO8K8mSCzhVSDVQz+quLF
         pTuA==
X-Forwarded-Encrypted: i=1; AJvYcCUThTzqvBfG4M1YSQ61ZcfzVBaG5svlAsI4EStmW/cNs+ENyEJg7+sS5FMcYU028klIUtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Dy/MRVP/bP3lBILXZglVIqw6MELvxIM6xPP8OO9nRaDlQ/p1
	pxvv6D4kKSj9YhcluUPU+O4UcnpE5IhK9usvS+LZn5Vc5Jemh1+np785Kuz78spkUV4NFsNtwFE
	SSbF2KSVItpU16wzmhUREn99Lq2Y=
X-Google-Smtp-Source: AGHT+IEIxCkWPCBOU2FPKg18NVSuYXX+JytiDv5mTYo3jBJ0SFuYh7ckjj5DOFCPp4/RXFkcKfeAvUWQIWbpT/ws0zc=
X-Received: by 2002:a05:6358:914c:b0:1ac:f7ac:e302 with SMTP id
 e5c5f4694b2df-1c32bcb5af2mr57520155d.18.1728594310970; Thu, 10 Oct 2024
 14:05:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Oct 2024 14:05:10 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241010133022.1733542-3-bence@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g> <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-3-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 14:05:09 -0700
Message-ID: <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000de6f1f062425b972"

--000000000000de6f1f062425b972
Content-Type: text/plain; charset="UTF-8"

Bence Ferdinandy <bence@ferdinandy.com> writes:
[snip]

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 353ffd2c43..24f9caf149 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1399,10 +1399,34 @@ static int show(int argc, const char **argv, const char *prefix)
>  	return result;
>  }
>
> +static void report_auto(const char *remote, const char *head_name,
> +			struct strbuf *buf_prev) {

Nit: would be nicer if this was called 'report_set_head_auto'

> +	struct strbuf buf_prefix = STRBUF_INIT;
> +	const char *prev_head = NULL;
> +
> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
> +
> +	if (prev_head && !strcmp(prev_head, head_name))
> +		printf("'%s/HEAD' is unchanged and points to '%s'\n",
> +			remote, head_name);
> +	else if (prev_head)
> +		printf("'%s/HEAD' has changed from '%s' and now points to '%s'\n",
> +			remote, prev_head, head_name);
> +	else if (buf_prev->len == 0)

Nit: we tend to do `if (!buf_prev->len)` in this project

> +		printf("'%s/HEAD' is now created and points to '%s'\n",
> +			remote, head_name);
> +	else
> +		printf("'%s/HEAD' used to point to '%s' "
> +			"(which is unusual), but now points to '%s'\n",

Isn't "which is unusual" a bit vague? Wouldn't be nicer to say why it is
unusual?

> +			remote, buf_prev->buf, head_name);

Let's clear up buf_prefix by calling `strbuf_release` here.

> +}
> +
>  static int set_head(int argc, const char **argv, const char *prefix)
>  {
>  	int i, opt_a = 0, opt_d = 0, result = 0;
> -	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT,
> +		buf_prev = STRBUF_INIT;
>  	char *head_name = NULL;
>  	struct ref_store *refs = get_main_ref_store(the_repository);
>
> @@ -1445,15 +1469,17 @@ static int set_head(int argc, const char **argv, const char *prefix)
>  		/* make sure it's valid */
>  		if (!refs_ref_exists(refs, buf2.buf))
>  			result |= error(_("Not a valid ref: %s"), buf2.buf);
> -		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", NULL))
> +		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", &buf_prev))
>  			result |= error(_("Could not setup %s"), buf.buf);
> -		else if (opt_a)
> -			printf("%s/HEAD set to %s\n", argv[0], head_name);
> +		else if (opt_a) {
> +			report_auto(argv[0], head_name, &buf_prev);
> +		}
>  		free(head_name);
>  	}
>
>  	strbuf_release(&buf);
>  	strbuf_release(&buf2);
> +	strbuf_release(&buf_prev);
>  	return result;
>  }
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 532035933f..77c12b8709 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -429,12 +429,51 @@ test_expect_success 'set-head --auto' '
>  	)
>  '
>
> +test_expect_success 'set-head --auto detects creation' '
> +	(
> +		cd test &&
> +		rm .git/refs/remotes/origin/HEAD &&

does this work with reftables too?

> +		git remote set-head --auto origin >output &&
> +		echo "'\''origin/HEAD'\'' is now created and points to '\''main'\''" >expect &&

Nit: might be cleaner to use `${SQ}` here and below

[snip]

--000000000000de6f1f062425b972
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b7b30f431d447815_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSVFZRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNE52Qy80N01Ud1NUZkJNdXZaQ015Z2RFNjRSVGwyRwpZQkJvNFNKY010
SVFRN2c0RmlvYis5U01ZWEpDaFo3TlJ5aDRzZEc4WUtZdzZ1RHluWU5FeHQrcU1GdXBoMUtuCkUz
d01nYnhTS3FmbmtUUVp0WGk3cllQZzkzNGVQQzl2dCtlMkR0TGZsNHRUQnFrSytIOEcyRTZOby9y
WEhZT1AKUVVhUjc3N2hCZzBmR285WUM2c2RsQks2U3hJQU84YWtJL2k5em5sMFFmTDJTNS81Q2dz
d0NJTVk0K0toTENyNwp2cnhoTVlFZlpvZDN0NVFRb3VxcGpXVk81ajl2RDFZZitiQ0NwNmVIVkFx
N04vR25MRWhTcVAxVW1LSThPTzNYCmdGa3N4dTBZNjliYXBuSTlEWnhPTjhQM1FkaGh0VTllM0RP
alZkZ3FOZC9MQ1B3bG8yZUxuYTFhdXNRNzZuNDEKMGlvMG51M1VKckZQRU54b3dxbnhUL21rUk16
MjZDbmJ2SWRsbzJ2eUw3aFgvOWsvYmFyY2VmT3VsOEJTNDRkZgo2V25vaGpsbWVGZzljNTNJTkEr
T1VzZlhNTG9LaGNLNmpteEMxeWtLMXVmdlJFV1kzUFVXeHlVTWZZK093TEVLCnJlWFhTekZON3NS
Slo1QzQwN2lzcklkS0xtNld1M2tFcHZKbHhrWT0KPTlaWGwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000de6f1f062425b972--
