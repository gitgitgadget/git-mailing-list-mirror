Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9B3CB57C
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032505; cv=pass; b=D8awb19WlJuS35p6aMU6xNDkt45qTtIPjheak57n6Yi1jt0X7CqPBTdq4JLgb51rT0S2vBrTARWdEqzueei4Bn51kxZP2AcDRoMNH/LcUsxt5XzbyTGVKioAwjcKu0T78AerCnDzg0g81NvD6dD3Leu1VoFQ7BIyVBeoIn1nkbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032505; c=relaxed/simple;
	bh=iVaak+jmYhcbBWBokIUpCgPSuT60hNNlAWkscCtaq18=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ofk36xenlUZrK9wB3PQglsHbm+E2+z20TS1H55eklKX1fIEwTM3HCLscWHxBlrgakwNXuQZc/uXMyUOrysoscm7v//uTgxK8RkhrsdDlFGjEZdo4N7VAGnFow+4ctOvok8EMi84k0+PWD9m79JIwjHDJjTryK24UGOlEz8FIpdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNUIeYwy; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNUIeYwy"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-782df51b4c1so5088263137.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 02:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789032502; cv=none;
        d=google.com; s=arc-20260327;
        b=U1WQ3gIx7+V61OCm7X7U3/TnsY55DNL5Bw+3rotlVypZy12cSqa4yZaSYztecSYhgn
         AzwCzOdZDyF37fRaUNbP8mq1ykmszv3JDWVaJlp8MOfKI+LDmc4ldfA1It0LH3wkCTVY
         hiekaojcwdA8BvZ5dgc2v2V5PLYLiofraiT8M9y7bJYXr4GMlXDle1bTXCN3MTx8O2/6
         /8TlqjYnxMLHbuz1rq7dp7UOU0uyR/hpzafH4+xtRAlIfltI6BR1vrdDElCmMj77PJ+i
         //EK+2OSQOGTKqRTOy+KCAg5UFl3WB+n6LDxY2Qb3dmPgZSLUhan9N10zILElFs8c+Gs
         BMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yx+g1Qr9oyWElSVZh3mOmeMH78bNJPac2gJoBjD+sYM=;
        fh=i4cU0M/2jfplGXQGWPEv2w0E3zy0UqEKPgJVqrNnAsM=;
        b=JXeTgUlWscYNErSFJP0xPIlsBFKffYihXXpx5LuSA+hGSmNhPRNMXAelEVH3tW4JyE
         vxfN8RZmRdkhdfOp5YTHetNhCos0vFOxKNQcq3z8+I8VlpfZSuc3wj5GL4k1IoLw+2p8
         yFlElSHcnv/8EyjHeFDgnWIvYb8leWktXUSElkLdU1/yLng9DChdNQscrBoOZVvKxM+X
         sw2G5epUVkcJzn6L49OThS2OfO+TJMj65oL47grD5CV+qRPjbQL6hHAEi591Umt/ANBN
         mWIBAZUhnbBWqi4aEMkpDgaYL+anbGk5l852LycLNsJc8PdJdSz4dszNBk9c/9zHNW67
         BUdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789032502; x=1789637302; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yx+g1Qr9oyWElSVZh3mOmeMH78bNJPac2gJoBjD+sYM=;
        b=mNUIeYwyw6aupJF2+9k7qaQ1PRfcl0uCP9LfuJEk2DB5MAug7E2PouUoKtp5wIQjOU
         U0T/YgY7SchK14B+ytxW9mEX8hca9QrBHnBMKyz8/gx8bYOTzXziSQ1k75pSIGmeU8o1
         ePyhmmYxNmFinuWFmLoaJh8c75CzaURgN+ChgrMxyyq5xV9jEI+u6T+uQfQFassOeaSy
         z4X5GI5pY4CZNTNs/ynASpsH2iAsbbHYUz6CFeZ6Lws8I/LTd0M+dSIhYp6GpgIz2SUW
         N9yHBiM+MQGQU0dx/QAWyHxmEkHDhi4Pg3DhwwuJjLMtxJvXYwI4msKhHBYSUyHQtFyC
         hR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789032502; x=1789637302;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx+g1Qr9oyWElSVZh3mOmeMH78bNJPac2gJoBjD+sYM=;
        b=mEPtHMUw5BnKIihHZQ8DldGghVM/7S8ovCJNbtgspyrua9GPSlqfN+fcPBFONswgP5
         BfU2EhUH9nAzsfya4wg+2tczK1pDyasZ8kMQKUAUU/RYVXCDG3J+4egpimbR64xkVzlI
         jeahcDYzFczaXp8c1jP07Gwnt+AcL3Z6MctJckEIi/GlMXEqdetALSUtQnJNyGkYutcS
         kJWxvXNX6216txHkNYW9pjSwmhYDx7/UheGCknhpW45zgmHhzRktnT1OSFqVrkguKcf5
         msdOxW+B2gna/nUR8nURduoJ3zOsfJ71HQTk8S514sg/OEACOJKsf9XD2CFTZoK4atg/
         zNuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUvYeocHTgyDZ2LHhdM4xK60mFuo0Iw5dqDP4bnCbXLwSElBBcTQlFGKfcgsC/MhjPh6M=@vger.kernel.org
X-Gm-Message-State: AFuF++m2hMoSCI+vc4hYDkCcMtnmHWk1OK8/qPeowPh+B6siAEAV2Kgl
	9j+hQsCc6TxTaH6Lu87gpl+yaRfrCF6uPQnf6p6cqEsiHmgRtnUA5Ddy0Vb8wXxmbPlmUqUz/R/
	RaY2KXk3hZIVfcgD0Ek2cJWcoS4OIrXqDBA==
X-Gm-Gg: AYBFou3F+COQKBngIM/vkmRbPcNi7eUAZexzxO8km/zkYNJSSKsBIfQZ16AiY8T+AXH
	2vgdrK7xZQTQBI2tUmjO09/Nc6EpYqU/yOg05ecsQALqrt9vMcRHzKzvxIjdR/w0Yhzk2DHIUK5
	Ig3RaOms2QIHdxoD6srHspybNpjpuf+yKg/eWEGRrr2Gxi+ckhDskQizTXyo7RphrSNqfr/YeD6
	NB63MHKTWJoSR799glbRyS8mn555xSSYTSfYKYrauL8bhgmpHVy7+EecKwUSr3Jn0GcbEFSHf7F
	AwOnwpQvI+qG7A5rWg5qyVXy6n2em7i16h+2RYrI9YkvFCIT5PuzJzxuTAK0FajdipPyKRJu3gb
	Ucj9FeZtczyLuFjj6wCIQ1s+gr7vwbxtT+Hc8DW2BSky5
X-Received: by 2002:a05:6102:6447:b0:778:f972:32eb with SMTP id
 ada2fe7eead31-78a4aa9259cmr21796002137.12.1789032501924; Thu, 10 Sep 2026
 02:28:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 02:28:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 02:28:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-2-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-2-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 02:28:20 -0700
X-Gm-Features: AcwNN1WMHQphgersmE6vTvNk-pBmNDy2Gppmuw4iheR2efUylfGcREjeIZDOPjE
Message-ID: <CAOLa=ZSH5WtAej++SuWhupLjYv_rLQs8cCcXgETNjLH7_mkZyA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] builtin/clone: defer setup of the object database
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c4f9c8065b1d9657"

--000000000000c4f9c8065b1d9657
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When cloning a repository we defer initialization of the reference
> database. This is because we don't yet know all details required for us
> to initialize the refdb in the first place. Most importantly, what we
> are missing is information about the object hash.
>
> We don't do the same thing for the object database yet, but here we
> essentially have the same problem. While the "files" database does not
> need any information about the object format at creation time, alternate
> backends are likely to require that information so that they can
> properly set up their data structures.
>
> Besides this forward-looking future proofing though, we also have a
> second use case for deferring initialization of the object database,
> namely alternates. When initializing the object database we do not yet
> know whether we'll need alternates or not because this depends on the
> repository we're about to clone from. If it is a local repository and
> the user has passed "--refernce{,-if-able}", then we will end up writing
> alternates into the object database.
>

Nit: s/refernce/reference

> The ugly part though is that we cannot determine where the repository is
> getting cloned from before it has been initialized. While we of course
> already have access to the user-provided URI, that URI can be very well
> rewritten via "url.<base>.insteadOf". We can of course read the global-
> and system-level configuration to resolve it. But we explicitly resolve
> the URI a second time after we have initialized the repository because
> it can happen that we copy a ".git/config" over from our templates, and
> that file may cause us to rewrite the path.
>
> In a subsequent commit though we'll start to write alternates as part of
> the repository initialization, so we'll need to have the URI properly
> resolved before we can initialize the object database. This is ugly, but
> as mentioned above it makes sense for us to defer its initialization
> anyway so that we also know about the object hash already.
>
> Defer creation of the object database until after we have resolved the
> URI.
>
> Note that this also requires us to defer the call to `setup_reference()`
> until after we have created the object database. While you might think
> that this function has something to do with references ("refs/*"), it is
> in fact responsible for setting up alternates. Consequently, we can only
> call it after we have created the object database already.
>

Haha. I like this last para, you kinda explained the thought I was
getting as I was getting it :)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 904d2d859f..bdcbd7aa1b 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1188,7 +1188,6 @@ int cmd_clone(int argc,
>  	create_repository(the_repository, git_dir, real_git_dir, work_tree,
>  			  option_template, GIT_HASH_UNKNOWN, ref_storage_format,
>  			  do_not_override_repo_unix_permissions, NULL);
> -	create_object_database(the_repository);
>
>  	if (real_git_dir) {
>  		free((char *)git_dir);
> @@ -1311,9 +1310,6 @@ int cmd_clone(int argc,
>  		strbuf_reset(&key);
>  	}
>
> -	if (option_required_reference.nr || option_optional_reference.nr)
> -		setup_reference();
> -

So this is the alternate setup, which we move down to after the
`create_object_database()`. Looks good.

>  	remote = remote_get_early(remote_name);
>
>  	if (!option_rev)
> @@ -1342,6 +1338,10 @@ int cmd_clone(int argc,
>  	if (option_local > 0 && !is_local)
>  		warning(_("--local is ignored"));
>
> +	create_object_database(the_repository);
> +	if (option_required_reference.nr || option_optional_reference.nr)
> +		setup_reference();
> +
>  	transport = transport_get(remote, path ? path : remote->url.v[0]);
>  	transport_set_verbosity(transport, option_verbosity, option_progress);
>  	transport->family = family;
>
> --
> 2.55.0.1074.ge7621b4bad.dirty

--000000000000c4f9c8065b1d9657
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 77c417af6dee61c1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWVETVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkFTREFDZk9VNmUrd0hEeTVnSW9hdDJjLy9sSWFCaApEQVAyWTlHN3JZ
dk1WdHdwRUdqUFVDeTNqSm1LWU9QdXZ5SHVJaHVXZEora3dXVEkzL0JiamtLTEdMUFJCc2dvCmRo
RHJtQlc2TG5mcjFQU28wbzU1VzhhNTRqb2NHN29RbzlsMitub05PR3lJZyt1dk1KY1U5SjZjR3NM
aXM0SDEKZmhDV2xEWWtSTmFYbkJhb1hJeUlONTlJenMvTmZreW92UmR4QVdqWFdON25PRVZUdDhR
bi9aa2ZTM0pzTXU2TgpMQ3VDYlNnNHRIcVpVdWxrK2Rhc1lzMUNvN3NXeE9iTWhQT0lYQXFacVJq
TVo4RXVEcktoVDk2RkdLQ0xkTnJrCnltdmliYkVqdzFLdHprLzVXSjNhWEYwb0xRalpjSnhLdGNB
VFdGN25CWFErOUkwczNEcjJsWUxxNmF3SEZralMKNlRNQ29QNVd2c2JsdEtRZ2w1WmNxU3dFSy9r
azhTV05zdXZvbXFKLzBJSWFpTXo5QnRPM0dYTUFKYXQ0RWgrWgpScEFyYlBJYXFhR1VzTmJrbHdp
ejU0d3EzeFN5bE13YnAyb3E3VnhOYW8waGt6WWY0NGxMQXc3NHBiQ2hjTDhjClUwdnphdGFRTFZO
dEZ0eFplRHJqdzRtelQ2TmRaS2g4MTM5Y3Fudz0KPWRwNmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c4f9c8065b1d9657--
