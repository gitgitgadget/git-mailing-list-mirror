Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A31119A
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373155; cv=none; b=V7Xo8RQJ0rsnZFQdGrj5H9nldeCnDz0OdS0yopmYsWsiCveq5DElF08apSzdhQVMPWERO2WhPOuEu8Wi2oJwrMY4CVf31rUBrK5A+hnRXV5STEyUI7yjFjQJ9CIwncA+nEbJqmzMDYVKqdnPQqwFUEP6yIzjGlhW0pTVQThlxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373155; c=relaxed/simple;
	bh=CuJiyjVWOL6+vBiJIAryNoovsVTBlD4ZkyuxugK7QoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBhSaV4ZY/eOd8mTdF4fWkUdxRm61bacrrCUhWYCTWsYzeIK3FbrO5FqBiFJGYIG8y1QsiNYMrsHq0OU1yGr5h2MQrAY3YulTHjurrHLTZ2SDrdH1UNhEBBqeX5kcZjlKifBPKif59EnZzw406qDxcBbqddqEnvC2ClDZ/IcOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOX0DcxL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOX0DcxL"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a609dd3fso429219866b.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715373152; x=1715977952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV65fZlE3Z0KS3KTUAi8wzVrU5BHvBln9uHaArfQExw=;
        b=VOX0DcxLjA4Iqzsxd0jCAOzlH8lQIywT14LpniXms4ve4dgxZVMo7AEjDrXUbExMI2
         5fTpY+C85h3Bacj9e24ljaqKXFE4w6+h0u3xqQbfiTNepfvcEByIvQbV80A0K2JrMgbL
         MB0vy2/kRwq4MZwIJb2hQDtAd30oUwXVwvbN5NR2hEBnxBHjcX3rz3LIaYJ3kIC1IqlA
         5hvomCnMq+y1uauGW7kjeL8/uqYcdj9DKI0Iff4EXyHBPeWT3ZiJfS8RTrHDhl0FPoTb
         93jgTLZcfWx1K7xab2hRz43SIQxYgiwQ5w2BOd9wsMMeel1MPukw/AUn6CCyHydKx5Sd
         Qemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715373152; x=1715977952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV65fZlE3Z0KS3KTUAi8wzVrU5BHvBln9uHaArfQExw=;
        b=fdmqnJ+hfZhdSSxl6dGSTxCOl6rAfoRutGiM/m0CK/5rwcanu7KOBbcRtAujt/Qryw
         ud8t6l4VuvdiOWXKB3dGXeKIi4gaRv0yN/SPKeaL8BUzoZe5sla4k2GKpRZayGgzJ8h2
         tAugTZ4ZL3Q+eSAthUimdQuxSC8RM12+nJS45JBslVXV4v0OR6lO0/j1/qSIcC510/J7
         /5ub9WXtlum9YlbFfSRf/Sr3ltshwfoTV6u3XABiiMI8ClfMOHujzhQYRwd+ppRddPhF
         G1HbZGvVMFjjFvzL+3tg5js73nk/NZidFAbDhhpG7sg3qSU2UjX6nL+1DiL3rroOSrNP
         QIxw==
X-Gm-Message-State: AOJu0YwAIFAsWnoSt0o9RPpSMxrAOKG8t7ocSwm/WdyBPyxZp10I1GzX
	LrZVTUpr58n4qQ+NVEdA90lT7R3i39Yjx22oTmIxeraJjHanE48MY7p3WCKZxZ3KqbvZ+QbfBeY
	e8zZ/s7T4iKEs8q7ct9flM2F5xEo5hopluWQOlqhogV8eG21MXw==
X-Google-Smtp-Source: AGHT+IGuUQjgxA4g0RmqvK4/H3FnvksTla6LAKthzFcL3685xwdwwVy5SQDEdOmCUDiktzAwMRRZnp5SGX+KOvNy4G8=
X-Received: by 2002:a17:906:70e:b0:a59:a3ad:c3f6 with SMTP id
 a640c23a62f3a-a5a2d18b03fmr328854166b.3.1715373151462; Fri, 10 May 2024
 13:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509162219.GA1707955@coredump.intra.peff.net> <20240509162415.GB1708042@coredump.intra.peff.net>
In-Reply-To: <20240509162415.GB1708042@coredump.intra.peff.net>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 10 May 2024 13:32:15 -0700
Message-ID: <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 9:24=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On macOS, a bare "gcc" (without a version) will invoke a wrapper for
> clang, not actual gcc. Even when gcc is installed via homebrew, that
> only provides version-specific links in /usr/local/bin (like "gcc-13"),
> and never a version-agnostic "gcc" wrapper.
>
> As far as I can tell, this has been the case for a long time, and this
> osx-gcc job has largely been doing nothing.

If it's been doing nothing (which I interpreted as "it's doing the
same thing as osx-clang"), and we've not noticed any issues with that,
do we need the job at all? Should we just rely on clang and not test
with gcc on macOS, since it's not a compiler that's provided by the
platform anymore?

> We can point it at "gcc-13",
> which will pick up the homebrew-installed version.
>
> The fix here is specific to the github workflow file, as the gitlab one
> does not have a matching job.
>
> It's a little unfortunate that we cannot just ask for the latest version
> of gcc which homebrew provides, but as far as I can tell there is no
> easy alias (you'd have to find the highest number gcc-* in
> /usr/local/bin yourself).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We'll eventually have to bump "gcc-13" to "gcc-14" here, and so on. I
> don't think we ever cared about gcc-13 in particular; it's just that
> older versions of the runner image had some ancient version which we
> wanted to avoid.
>
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 5838986895..5f92a50271 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -284,7 +284,7 @@ jobs:
>              cc: clang
>              pool: macos-13
>            - jobname: osx-gcc
> -            cc: gcc
> +            cc: gcc-13
>              cc_package: gcc-13
>              pool: macos-13
>            - jobname: linux-gcc-default
> --
> 2.45.0.414.g4009e73179
>
>
