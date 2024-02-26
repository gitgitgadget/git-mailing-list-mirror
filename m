Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08985605C8
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960309; cv=none; b=VAd4JTC5nMrpMC4N1Gvm8AL7V1xEL06VVIlQQavE4S9A5Y9Jku1NZk11onCj/syfXaA4rQK1/gVBTK8a1v2TmzHGjQHqM+CdG2+dGurBSRIzWwSnkNDF1frH8sbr2HvhHB15sJUkpIJnGaa9DStHodbrMz/RqWpYLi06eokCFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960309; c=relaxed/simple;
	bh=xOQQiEH66Wf3HM4gD42ipoI612C0inHP9U3YsDmEbI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCBpP8HKxXoQq/gyEPMzkziBKhEPZ/6h66IJWB0DwVoeRVqAK0OCy0OEz4Y5jUfOeBSUCjw2oUH2eWiwAp6xavLwrsdr4a/nR5kcHxAudPAMfPlgufCRU8ZaEsvQCGXoxfmm0MoBVac6jBK1G0fI8xtakrTersqJqeOEMDZx1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGK4wSAJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGK4wSAJ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso3940761a12.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708960305; x=1709565105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2Am78WMmF4GeU/sUV4lbH1ViJHr9NndU+EYqQu0oCE=;
        b=OGK4wSAJDGVJEDxCZyqujgurg5NCNNOMD2Ynl/7QPFejtupFxdazL+L5515GHqxq7G
         AVYYWAhwETfzVrfm388kYRZOdwQ5J33RiDtwrYoC7mVr68BMKzs7/9vuln6talkVfvyl
         ul70FbO0YOt6uGzaXpaG2PS//eOHa70REVoD6763F4oyj+t1JOq1GLYQVMgbded4YoZR
         LAirTPfvCXBigXi9ROIK9t6SsBD7BWfVHsL9KxWda/J+xvKZgvDI8aKXKvMWHjv+HHZ6
         ucmUaTyr7vzJPkD58BM0SekQEFhpoNzN3m2Wu2cNOgSKFkLNx7QrowP3hoyqKa2H/Lgi
         nE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708960305; x=1709565105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2Am78WMmF4GeU/sUV4lbH1ViJHr9NndU+EYqQu0oCE=;
        b=Pi8daEw43cx6Wvph4Nk9ifIGVctm3nDNro4Nh1VEMXFkNnopqzcr3NuPIZMAnRSEjq
         KzWiZVTcpKOVLnTh86fiD9cBf7U2t3RVuz6gG5F4jGebbWR4Lcsvt4HiXOzCwqtZK7OJ
         M9mkoVPsZ26axMAo6u3kUVHpAaVXIGlsv6H20/+mUmsZng4DLJ6R5GKwQTu4n+w74YXK
         xApCK9VTalUwE71vwrvy2JXC5+2+m/y72SMpe8Dy2dPFwf0cob88B6Jfnm2FOiRHlqld
         DT9nvc97wAe/2mch0jmY1ciDyv+rdPX7vcIxA26zEmZgPeeD68SQJ1jxLvsK1LurkVFw
         sVlw==
X-Gm-Message-State: AOJu0Yw2HwGZhejClyAHiXojvGUCpUc6MSqfOrPaD1/0hrV2TJmCcEIC
	oh9E0i/35EcBw2mZf0bCOg5U+GNxK0Fn7IkenX3EFGrF0vhCP5KfwmAEMDVxBBQkl4P1qY5EDPm
	C7sxYlUFg4B+sZj8eHnRCZHc4FSwU0PBtpiE=
X-Google-Smtp-Source: AGHT+IEiFcv3SF31t3CZIpZMlcFqjXDsOYVb+GomMfqQXrM0IlMf0XmDSag//VVK7RDYX4BfbYE+2xusXz2ky9eqnEs=
X-Received: by 2002:a17:906:5fce:b0:a3e:73c9:7acc with SMTP id
 k14-20020a1709065fce00b00a3e73c97accmr4569891ejv.33.1708960304879; Mon, 26
 Feb 2024 07:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223193257.9222-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240223193257.9222-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 Feb 2024 16:11:32 +0100
Message-ID: <CAP8UFD088GRkVQWjrBFk04_HFfiEk64Saxm2toYsci36oHgkdA@mail.gmail.com>
Subject: Re: [PATCH] unit-tests: convert t/helper/test-oid-array.c to unit-tests
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 8:33=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> Migrate t/helper/test-oid-array.c and t/t0064-oid-array.sh to the
> recently added unit testing framework. This would improve runtime
> performance and provide better debugging via displaying array content,
> index at which the test failed etc. directly to stdout.

It might not be a good idea to start working on a GSoC project we
propose (Move existing tests to a unit testing framework) right now.
You can work on it as part of your GSoC application, to show an
example of how you would do it, and we might review that as part of
reviewing your application. But for such a project if many candidates
started working on it and sent patches to the mailing list before they
get selected, then the project might be nearly finished before the
GSoC even starts.

So I think it would be better to work on other things instead, like
perhaps reviewing other people's work or working on other bug fixes or
features. Anyway now that this is on the mailing list, I might as well
review it as it could help with your application. But please consider
working on other things.

> There is only one change in the new testing approach. In the previous
> testing method, a new repo gets initialized for the test according to
> GIT_TEST_DEFAULT_HASH algorithm.

It looks like this happens in "t/test-lib-functions.sh", right?
Telling a bit more about how and where that happens might help
reviewers who would like to take a look.

> In unit testing however, we do not
> need to initialize the repo. We can set the length of the hexadecimal
> strbuf according to the algorithm used directly.

So is your patch doing that or not? It might be better to be explicit.
Also if 'strbuf's are used, then is it really worth it to set their
length in advance, instead of just letting them grow to the right
length as we add hex to them?

> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> [RFC]: I recently saw a series by Eric W. Biederman [1] which enables
> the use of oid's with different hash algorithms into the same
> oid_array safely. However, there were no tests added for this. So, I
> am wondering if we should have a input format which allows us to
> specify hash algo for each oid with its hex value. i.e. "sha1:55" or
> "sha256:55", instead of just "55" and relying on GIT_TEST_DEFAULT_HASH
> for algo. So far, I tried to imitate the existing tests but I suppose
> this may be useful in the future if that series gets merged.

The fact that there is a series touching the same area might also hint
that it might not be the right time to work on this.

> diff --git a/t/unit-tests/t-oid-array.c b/t/unit-tests/t-oid-array.c
> new file mode 100644
> index 0000000000..b4f43c025d
> --- /dev/null
> +++ b/t/unit-tests/t-oid-array.c
> @@ -0,0 +1,222 @@
> +#include "test-lib.h"
> +#include "hex.h"
> +#include "oid-array.h"
> +#include "strbuf.h"
> +
> +#define INPUT "88", "44", "aa", "55"
> +#define INPUT_DUP \
> +       "88", "44", "aa", "55", "88", "44", "aa", "55", "88", "44", "aa",=
 "55"

Can you reuse INPUT in INPUT_DUP?

> +#define INPUT_ONLY_DUP "55", "55"
> +#define ENUMERATION_RESULT_SORTED "44", "55", "88", "aa"
> +
> +/*
> + * allocates the memory based on the hash algorithm used and sets the le=
ngth to
> + * it.
> + */
> +static void hex_strbuf_init(struct strbuf *hex)
> +{
> +       static int sz =3D -1;
> +
> +       if (sz =3D=3D -1) {
> +               char *algo_env =3D getenv("GIT_TEST_DEFAULT_HASH");
> +               if (algo_env && !strcmp(algo_env, "sha256"))
> +                       sz =3D GIT_SHA256_HEXSZ;
> +               else
> +                       sz =3D GIT_SHA1_HEXSZ;
> +       }
> +
> +       strbuf_init(hex, sz);
> +       strbuf_setlen(hex, sz);
> +}

A strbuf can grow when we add stuff to it. We don't need to know its
size in advance. So I am not sure this function is actually useful.

> +/* fills the hex strbuf with alternating characters from 'c' */
> +static void fill_hex_strbuf(struct strbuf *hex, char *c)
> +{
> +       size_t i;
> +       for (i =3D 0; i < hex->len; i++)
> +               hex->buf[i] =3D (i & 1) ? c[1] : c[0];

There is strbuf_addch() to add a single char to a strbuf, or
strbuf_add() and strbuf_addstr() to add many chars at once.

> +}
