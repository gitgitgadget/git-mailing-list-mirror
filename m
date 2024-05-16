Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487B4688
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885093; cv=none; b=DNHVWXVmflU4QEeSNCzsMe/GUD6BEZRaioI35pEKUBJC5+D220S54n/pJtI3Zw7wdjxGPRAPOy3ZDXU/9tdvVo+BQ/f7KnGCIgCJQisgKC8G4qasGeHewvTMrFl3xJs/jRC67fY+GDugSWO9z0mM7gYEU6KA+0lDxkCvSwSA2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885093; c=relaxed/simple;
	bh=rD1K8piYBHVZ41LAMZpLB/EonJSY/xHv9CadSC4De2k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LrezUxQpWpl+xsatMZf/z1zZo35xNWq13LTy8dVaVpq1jjarUPPRcz/xICsKMdOx+YVfGQbn0K7ALWdkCYKxEdyrnycoYGyI1RGzJKCX+nkPE8ZUdYWj0/QC9aVP2a77bH93Gm2KFY3b/zpewkEx/dioBMpwGCcxahVXs3Cnfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXPfBzZs; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXPfBzZs"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b290669b0fso382057eaf.2
        for <git@vger.kernel.org>; Thu, 16 May 2024 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715885091; x=1716489891; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQQgYDcZpgum/+fycBYXyA9r8Ltm7YnJuTNh9awsfsE=;
        b=BXPfBzZs4KF5g/SPzx5ArZSnnfaPQqPU4kt1oWEJyMCISLze7mZfdwqKu/UZqX0Euq
         WAEkI3gNbg+grdZKjFBvP5FCe40ATMwAewn/m02GwxefNwypqvxTSeLl41Nr8iZuXRi9
         lX7cGF8L3ZGxhVGoMAyxLHP7Ea14CE2rLvA2kAq3UWGG7N0+vvsQPG8lVJA9tOmCGeQr
         EoOX5gXA1peiZ+LGKxfaLCfREkevMD0Pra/DZHBYaGKvox6kdb9Qow3HqoG5uISAqxTi
         xyBXBR+BgbkixsveJgPRrg6TbcsOX6nuOT+cr4u5LrTZuvoJ3nI491d+uf8HTLIPt3Y4
         KapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885091; x=1716489891;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQQgYDcZpgum/+fycBYXyA9r8Ltm7YnJuTNh9awsfsE=;
        b=FMv6loMe+tA3FkcV/C5sCJQdli89UY2D5xbZu9A2dw8xsliaNLrCgROu9lPgLZDkHl
         aOj1ZWK0mMBh5SpDLWgaIpnwlBaTfQUm/iGk5g8KaWri0IMXZY8aog5vZ3kQmlG3vb+F
         wOTJc3M69GULsFYZc8ILJ+pD88ObrU4CJvQewoJv/bA+QNZTZIurfoPEs6cXRL3q4jT5
         /9vf8ddQb9Cg8FPJwKp8ZNXywdbh1tfOfliCn6to3QjRK+0OBkC5vgmpcbQVwkMfTLKK
         zN2xlXwY1ez2suQTjjp3Mv3N/7Z0MNF9+UbihWhkyUtz5vhCQSHPPosqdzJzrZVNcmS/
         /PGg==
X-Forwarded-Encrypted: i=1; AJvYcCUqDbt+QRTTa4gMI06bGSVAJZBxql9da78hZ40Nicadibvk26dKKAmh9XHqBt2uuxwWtHWbFW5oXHsxpo3rVXNRZVLL
X-Gm-Message-State: AOJu0YxhXQlVLnm5r38TJUWXmEZ9d2FcMIt7XKsAArRa/YohMvEaRUON
	GN90QEqYlMjG34b+sq6K7UB2DD33XGcb6p68kiT9ib4WIolJmd3LHP4VbHabOu+PI8+6Rywgxzy
	lRxj657slM8yKd+119J1dJAlUna5bHA==
X-Google-Smtp-Source: AGHT+IHuINE47w0VnCirVtnSUPRcZnp6Dg855CKxnFvm7Kgg7JR5wJUuTNHK1xsZmhJTHV347/mjfYFPEhzp4Y3AUMg=
X-Received: by 2002:a05:6871:7246:b0:245:407f:96a6 with SMTP id
 586e51a60fabf-245408edb80mr3701323fac.36.1715885091303; Thu, 16 May 2024
 11:44:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 May 2024 18:44:50 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <09ca848e7d8a9c4f4d8927d8f01a1c3cb5d34e8c.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im> <09ca848e7d8a9c4f4d8927d8f01a1c3cb5d34e8c.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 May 2024 18:44:50 +0000
Message-ID: <CAOLa=ZTippqNQdmFeKVj+z=synSaePiAm=_A5Nu9FGUrn7P52g@mail.gmail.com>
Subject: Re: [PATCH 12/16] refs: drop `git_default_branch_name()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000057cde8061896a19d"

--00000000000057cde8061896a19d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `git_default_branch_name()` function is a thin wrapper around
> `repo_default_branch_name()` with two differences:
>
>   - We implicitly rely on `the_repository`.
>
>   - We cache the default branch name.
>
> None of the callsites of `git_default_branch_name()` are hot code paths
> though, so the caching of the branch name is not really required.
>
> Refactor the callsites to use `repo_default_branch_name()` instead and
> drop `git_default_branch_name()`, thus getting rid of one more case
> where we rely on `the_repository`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c |  5 ++++-
>  builtin/var.c   |  2 +-
>  refs.c          | 10 ----------
>  refs.h          |  4 +---
>  remote.c        | 12 ++++++++----
>  setup.c         |  5 ++++-
>  6 files changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 554b29768c..bd3e8302ed 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1468,6 +1468,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	} else if (remote_head) {
>  		our_head_points_at = NULL;
>  	} else {
> +		char *to_free = NULL;
>  		const char *branch;
>

This is a really good pattern, Makes it much cleaner to understand.

[snip]

--00000000000057cde8061896a19d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 206fe05c9929e010_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aR1ZDQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzhVQy85V3BINlhxd0RBdkxjVzdnOVZrK1ZNT0toMwpOMHRNdTA3SDJh
YW5SSSt6cUpQcW5FSkdNOFJITDUwelA5M3RmTjF4MHI2UmJhUmpXSDYrMmNYM3NQZTExdkRaCnJK
L1Zud3lBbTVMMDFpOHppdW51M2svVHJud29KRWlOMWhJSVg0dzdFYVI3bHNsR0ZoTTNaRDdBM21z
OWg0M0kKeENiN1BBdXJKR3pjNjE0ZWV3YUVmRU13SGFsdGg5WXduV1F6dWVTSExhWWJ3d3UvNjJa
elQyM3ZhQWtnWE5YTgo1bU5ScE9JYnlJUUovclRxWFZUM3JuMzkraDUva21PZk9tOTdrVjVUeGI2
Ty9FY256SzdtYjVqalRWUU9hR1hPCmdNK2hkNjgwT0J0UUhlNkJSODcvUUV5bExnaWlsOTQzTGQy
QnV0VFRaN1o1b0lrdmpiNjh4eHYwNWU1UUxQaU4KRmJocVB3YkYwbnBrKzFqZ01ZS3pGWHdRRkg3
cjkyS1NHamM5QjhYOVZaMXNYN1dQL1pROG9zZDFVVXpEbDFwVApMZ3BsZ1pnN21lUWFld2xOSUI1
Uk1KZ2lhMyt0Rk9PbHcwdVVxVDhSTFc1dEwvY3pRMFc3MThEbzUzQWpMQVY2ClA3MzFZdGlETERX
cmt3WGdzRkFsZ3k3dUFKZG13bzdoQnRXZDQrZz0KPXZrWTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000057cde8061896a19d--
