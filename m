Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9A1DC1AB
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869023; cv=none; b=olmMvFCtW8iHbLzs3ay9zkKRrVb/X2MZeKb0swTWjT9c63Z/H3LzYCw1ktztvVzIGkDN6LrvbW4EILb1OvjXzPlCpZfq0gwEzH1n6r+zxupeejvdSQujUaa8+iimQxr/yxqORVspf+jK8FE7D7urfC8X0VEnhql/Ysset2Hz7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869023; c=relaxed/simple;
	bh=emiV6qkPnSxgO1PQL2DAzVVPz/ikvaQGuN1JuEKPgFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyITrOS3aFa5rcs8/zUDgYQAZrxsB0O51kVaG5t9VKMFliwJAVL6zZAB0PXXfhWz6HozA+aOp/1Q5OS9i6rtX2wFDNCXq+lWwX6UY43VlN8JJwW+pYB2gJsfm3HllCUpSoKN7DYzm+MpSKzo3FuCS6DzPTH2IW/1F2ISKLNrjjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMH7DQZ0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMH7DQZ0"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-581b92e680bso2937608e87.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758869020; x=1759473820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrqMAvU6R7OVJRl+nvKPbKOMLOfVhh/MELON6vuEkvo=;
        b=kMH7DQZ0R5XmWtMaoclPpJi7sd0Y4jS8ybLEnvzkPSBuwyH7+qUBh8fFfMJFLDEf1C
         nEo1mnmral74ScovF1LW6jyP20yGveNAAtWXU89y7tSS1LKsGureelB7qB49nAvE8nHY
         +isMxoH1DyDGa8aHdB15yFooAYRw/R/iGJMjLro5pkxMEzsQM8qlb1T6swOvWSt0DQZN
         eUwUI9V6WOyoCCzrw5nXflJzrFL+SEGHq13KVwUENoftfKoFObRVV853LEb1MJLVV9kd
         +qlsltJtORSzq8SzIQ9oUF+meCci2nG2HZcmDf4rw50YPG8Gt72hnWv2el3+PALLHPDv
         ORkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869020; x=1759473820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrqMAvU6R7OVJRl+nvKPbKOMLOfVhh/MELON6vuEkvo=;
        b=iTChVU1H3MC8xZFy7vu3/Vcz9+a3g8HlJJSw5lhDcz0jGuFwvwECCXsB/Acx10ZEy0
         rgDLTTT2o+WWm40OVUPNIDKnlMEADDDwtjWidK6awrgZCwego0dIv0mk13lA5u1ftQu5
         HasuQFe6/TzdsGoih3BnWrF9lX7cV4ulHiIYXIdSi3g5Nb/It5Febg4N5z3PWoF+820e
         Xnp8UBybKeB4Pyh0f9Q9wJtxM3Zx259whCqhyjKQnGfqnBK7wzI+azMVwuWCgBS5cuvp
         tAOD/oAgLgDuaBJRVGxnO6Yz3+1kODyROYw0yoKHu/apZeIY9QP2uq5d347e5cBQXe7i
         UEWA==
X-Gm-Message-State: AOJu0Yy/4LA4gz9/DCFeN/O31r/sku98M6jgNOfJgapmP1eivwyjZxaP
	yBYBIfCjxPJ+7SnUGJ2i1Ser9XkUrQFzl9tqYHTVCXQ9FLbAuqBqGZXC6SwhaCBd5DaXPL+JKij
	PFrn8WCAuwSa+6pHHLP/Gafcs+Rj07ss=
X-Gm-Gg: ASbGncumyRHfaXjBkn+94m4vGZHqsjU97gdiAMSruF6i2iwdey9tfMYk4gT5SEKGM2R
	I/xT73Iu6UV2KVuOcSXOXOgezYiuFmM9/pEUtgev9lVjJLv/gPrBEyoeddhEVD94cnQoBLDJHUg
	aR7Cyi5dkwWh8JHZsrmR2Sqd6VPUPMCQmiMhP1pNVgxEYw2hVguIwWzp+w7a6r2rQdudXf2HQbO
	Hq+k21u
X-Google-Smtp-Source: AGHT+IH6Xgsdr1e9364051E/JopjBkRc64LGlEVtWYYBJEeRz24v3GX1C1/3WhwEcK8lLKvixNq66qDHCPpmRFqk/f8=
X-Received: by 2002:a05:6512:68d:b0:57c:4428:4f14 with SMTP id
 2adb3069b0e04-58307a37356mr1686636e87.24.1758869019587; Thu, 25 Sep 2025
 23:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com> <a5904a2ac00ea6de142344272b45f6b4697b4f98.1758800669.git.gitgitgadget@gmail.com>
In-Reply-To: <a5904a2ac00ea6de142344272b45f6b4697b4f98.1758800669.git.gitgitgadget@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 25 Sep 2025 23:43:27 -0700
X-Gm-Features: AS18NWARezaWj_VBtUiCWZdNvVqGZDB4Ss_0SOYESGaxy6apfl9F_Y08MkTmGbg
Message-ID: <CAPx1Gvcj-mVfXFMpLuvda_s89e_3jwdjMMdywEOya16yStXvFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libgit-rs: add get_bool() method to ConfigSet
To: ionnss via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ionnss <zara.leonardo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A bit minor, and I'm not a real Rust programmer, but:

On Thu, Sep 25, 2025 at 4:44=E2=80=AFAM ionnss via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ionnss <zara.leonardo@gmail.com>
>
> Add support for parsing boolean configuration values in the Rust
> ConfigSet API. The method follows Git's standard boolean parsing
> rules, accepting true/yes/on/1 as true and false/no/off/0 as false.
>
> The implementation reuses the existing get_string() infrastructure
> and adds case-insensitive boolean parsing logic.
>
> Signed-off-by: ionnss <zara.leonardo@gmail.com>
> ---
>  contrib/libgit-rs/src/config.rs    | 24 ++++++++++++++++++++++++
>  contrib/libgit-rs/testdata/config3 |  2 ++
>  2 files changed, 26 insertions(+)
>
> diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/conf=
ig.rs
> index 6bf04845c8..3f4a32c72d 100644
> --- a/contrib/libgit-rs/src/config.rs
> +++ b/contrib/libgit-rs/src/config.rs
> @@ -68,6 +68,26 @@ impl ConfigSet {
>              Some(owned_str)
>          }
>      }
> +
> +    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
> +        let key =3D CString::new(key).expect("Couldn't convert key to CS=
tring");

The string argument for `.expect` should be phrased in
a more positive manner in terms of what is expected,
since failure will cause a panic. So, something like:

    let key =3D CString::new(key).expect("boolean key should be valid CStri=
ng");

which would produce, e.g.,

    panic: boolean key should be valid CString: ... details of key ...

A similar rule applies to the later `.expect`.

Chris
