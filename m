Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA3176240
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728208873; cv=none; b=pnpf+dGy6jcgVQy0WFoi9NNRRcscDg9IS/oGcj/5lpmvsLkTJRTwMH+PJh77lEaqU14zA52ga+6ckzdJp6uMa1vzuPejVtyaHRMf0sjrD5FE4+/M81BlFCPQKVAUVXhzeMmzyCTsdIJvmbLpIJFbP6yIJ2oeYIqwGC3VDbdqtaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728208873; c=relaxed/simple;
	bh=artVKeI8h3YUx2V+qYNrCzyynEP0AKAnKuod5xNDmLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc6T/S+tIm7zCvI6Uojk746384LtZLQupr0ENGN57xRLQE9yxvL7RBU+FPZmaVl0pIliayh4KK8kVDpR5YmdHvhGIX/o+dbxMsrwx7GK+M9Vm4bw/ousWCupBHTjGe7xd6/g5/DdOevCLZJxX5bdNQLDJtL2Bf2RXbXrxZvL+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR4mAG4N; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR4mAG4N"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9f98f2147so495992a12.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728208871; x=1728813671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u71aWF7LAvglO+ofTBrWSrOXlVNQaXS+pkgFzQuz4u0=;
        b=gR4mAG4Nh3xwWgRPcWQLH9zWd5uWHchWM4g4HnA8YT3tbJ6mvRfQ6re41A38zvRorl
         FcLiu+ciSnV43AYm/xuUZGy/P2NuyQmk2g7ydnlZyquJlBxAJak9ApP7jcKlE+aokVSx
         fpnK0ys7rmhGRjpnUkoDLu5Fhntq/ndm9D8Y+tJQtEUKwSdbkaQcg47dmrWsJCRQr+vk
         EEgGf/M+XXJxD7u/aSoRivn8OwzxsiNJosmtmDRjCmfLKlRfAxEsatfqkY1YwtSmOU/e
         yKYdl2KvM/gIGgPPr8guJd+2rf8SW6urTP24kx3Wbhqcma68wm48WSCo1avxJru69d8m
         GyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728208871; x=1728813671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u71aWF7LAvglO+ofTBrWSrOXlVNQaXS+pkgFzQuz4u0=;
        b=O+n5jDrsiHo4zGnxlo/wR9AlAeT9YMhFk9lh3r/YjrmTn9lR44X0tI8HBBRhiOV5NB
         An9ThyGW8onRKBIeWN90jUtgbrRaWSb+w74JV40L3bKoKV5UHW6dRV/RtA1BEU5BfNCg
         esQzHRF9HGZjQmTjWo9YK7Sqbx3WN51nLapTElz351590pHt6r/b+CuXE2LkUPEYZiE/
         IEoK0ww9yWHNrCHBFajt5QYlrXbb/Wjdpoz+8a/yQshRZEjgK4dunPInKRIoEYzABVaP
         4wAdJEsgLQ5eFZnXfQwCRLtaFgBuglbasrzjoRCijLtUcXecN41bYv7CgNpJp8X0f59s
         hB8A==
X-Gm-Message-State: AOJu0YwgM4igpkbEL1BDdLxPAQvbXnwNdeUz441XN+9GqaWFiqEitz1c
	TWUHJ8X5nteenSbqwU9FsXbPDeJk5Q8EbtXmVwmvbOysUoS9BtczuN5zGw==
X-Google-Smtp-Source: AGHT+IE5rpY6xCbSTBEDldKbD8uxRaI7yAEpVpYczlXqFDlq2b4ceiuxicHkGZ1VO2I9QbcwwjD4ng==
X-Received: by 2002:a17:90b:4b85:b0:2e1:e3f9:8af1 with SMTP id 98e67ed59e1d1-2e1e63860a0mr10061600a91.39.1728208871251;
        Sun, 06 Oct 2024 03:01:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20ae69766sm3142493a91.8.2024.10.06.03.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 03:01:10 -0700 (PDT)
Date: Sun, 6 Oct 2024 18:01:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: Teng Long <dyroneteng@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	karthik.188@gmail.com, ps@pks.im, sunshine@sunshineco.com
Subject: Re: [PATCH 1/2] refs.c: remove redundant translation markers
Message-ID: <ZwJf7A9vnRWQgF41@ArchLinux>
References: <ZrSroE8vLlZCK2jp@ArchLinux>
 <20241004191433.64416-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004191433.64416-1-tenglong.tl@alibaba-inc.com>

On Sat, Oct 05, 2024 at 03:14:33AM +0800, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>

[snip]

> >> @@ -7,6 +9,9 @@
> >>  #define REFS_MIGRATE_USAGE \
> >>  	N_("git refs migrate --ref-format=<format> [--dry-run]")
> >>  
> >> +#define REFS_VERIFY_USAGE \
> >> +	N_("git refs verify [--strict] [--verbose]")
> 
> This define may not require translation, then maybe it should
> look like:
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/refs.c b/builtin/refs.c
> index 24978a7b..3a799aa6 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -10,7 +10,7 @@
>  	N_("git refs migrate --ref-format=<format> [--dry-run]")
>  
>  #define REFS_VERIFY_USAGE \
> -	N_("git refs verify [--strict] [--verbose]")
> +	"git refs verify [--strict] [--verbose]"

I am OK with this change, actually I just followed the way what
Patrick does for "git refs migrate" subcommand. So at first glance, I
wonder why the "git refs migrate" subcommand usage should not be
changed.

After searching the mailing list for information, I found that Junio has
explained why in

	https://lore.kernel.org/git/xmqqbk5y3j8a.fsf@gitster.g/

Because `--ref-format` could be used as the placeholder, it will be much
more helpful when translating in a different locale.

Thanks,
Jialuo
