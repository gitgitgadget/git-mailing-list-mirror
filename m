Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51CD23BB
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730955167; cv=none; b=dChMW/S0MWAqMa7Ny9HoatUdmTnUlcACdK/eh1X624/ypH5N9Cv2VRoG75EaL04ZYUUGrY0oMhgJdpddGz0bvSjMNrmX3k31SiCP1JGHaB85MQXfG6Ljt2TbTX84iQOGRbARsG5sIOxi0tqSg9iRl/ZzAi2CIMLxdPGwJPb3HYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730955167; c=relaxed/simple;
	bh=MH23MkUmeg7RSAULHoOyYzkibqW4OnBFE6nnBarhhfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwLyVNQSWX0YY9G+IxnS0A2bzTa6OKcybJpZ8p/2YQCFRuS1Y0UnL3tSXI69bcaqgmFUKYSLOQhbWMevF+kTbBUh5td+QVXtVG6FFzXEsar/fbCermMXYIDPdebWKMTqm7NeHYmiEjYsTWuw+n0l8p5wpDMk/XdQ9PWoR5ita8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=cvDcLzYc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="cvDcLzYc"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a2068f348so8425466b.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 20:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1730955163; x=1731559963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C4BQ4rct8RT/JSFOCUAf8NuZIHD25eVKJkb6TQeJvo=;
        b=cvDcLzYc3mMyAynXZzMFKdnlUSVER7ijn9+H3buYUlECF63Gc4T6Dfat5d9/fNw418
         Jc8NfrEzk5shoULoKhGen7VyyAwOCrgyWSi5ZTHtoaIg1Auv1RDDBEGuNswSNkDuqRgD
         L8+q4GyjZhnhq/o33vPw5nLx467N2XsUT7tdYGAvqUDYt4uAiN+8uR/DbMtm9Bzbl9WN
         T2iXEPpxBbUb6REU9i+vOIY6z5zIkjCuGH0mpQUYsiwdEBpIRGRriu8PLfzSRlGBm7qf
         Gdw0u/r2l+uMmYf/iF8sluGtC/QJoCEb0fENH3F8By2LigjWjMfrXE6a5iU8cu3tZ6nQ
         ERLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730955163; x=1731559963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C4BQ4rct8RT/JSFOCUAf8NuZIHD25eVKJkb6TQeJvo=;
        b=YcWnush1gtuOGNupwKXFu16DMHxZxXbdkw9lhrxIyKo2rTWhq+EPUR02eocPtcdQBm
         imW5tvg+tPj+dl+R+K3dUL35pESVNNQCqJkIpt9Vu2p4SKuBuEgZjOHEX1Hl1ElMJyre
         pmcja0pYfTY2JroAMVu9mlspERC0QnJSwqxC2dYcKCAX45G5NjrLlXgGiel4vzk7ZKEW
         4GTo7hiMRFuYY876GwbbZCisw8dHUeGwPgV9Z2CwfPX8qexybAixLaU4zwM48pbhwmnU
         KLG7+4LdBhosBSL9S/k5qwLWgJm1KLZ3g3g0D5sMS36v+z1O+/XPjXgBzr4mm5qni+6U
         hwMw==
X-Gm-Message-State: AOJu0YzWNS3LAVsEC0rfWpnhCprTGPrnxel5ag1bsJQzDoTz4sGfwl6a
	IdlSO+H8Rtdj9/5Voql+JIY++Nmg9AFm/GiDjLTir5cp44sIYTs5UVT7rDYUXVGDuLTPm/jtHWe
	K8IO2UqFpBCjnE7WufZ4lyDsl6oKSgqQAObJ+lW0EsPRycRPk6Q==
X-Google-Smtp-Source: AGHT+IFGoVSME1m1MrmcFku7oKbyFL+LRZdEYNt84Fl+kZb6Rh2wACW7UB1kuvqORX4yCMjA8JvizMiW7muzfJET/0s=
X-Received: by 2002:a17:907:3e29:b0:a9a:2afc:e4ef with SMTP id
 a640c23a62f3a-a9ed3a98e64mr73130666b.7.1730955163131; Wed, 06 Nov 2024
 20:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACfndskJZyOf2k2JHVo=8C6+RE3nUdMF5my3t_qcL1+3dW26og@mail.gmail.com>
In-Reply-To: <CACfndskJZyOf2k2JHVo=8C6+RE3nUdMF5my3t_qcL1+3dW26og@mail.gmail.com>
From: Manoraj K <mkenchugonde@atlassian.com>
Date: Thu, 7 Nov 2024 10:22:32 +0530
Message-ID: <CACfndskPgu5yxSCYE+x0XTq3U+KzfmN4e=rqifA1_n6HQqdG6A@mail.gmail.com>
Subject: Re: [QUESTION] Performance comparison: full clone + sparse-checkout
 vs partial clone + sparse-checkout
To: git@vger.kernel.org
Cc: stolee@gmail.com, Shubham Kanodia <skanodia@atlassian.com>, 
	Ajith Kuttickattu Sakharia <asakharia@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bump

On Mon, Oct 28, 2024 at 4:00=E2=80=AFPM Manoraj K <mkenchugonde@atlassian.c=
om> wrote:
>
> Hi,
>
> We've conducted benchmarks comparing Git operations between a fully
> cloned and partially cloned repository (both using sparse-checkout).
> We'd like to understand the technical reasons behind the consistent
> performance gains we're seeing in the partial clone setup.
>
> Benchmark Results:
>
> Full Clone + Sparse-checkout:
> - .git size: 8.5G
> - Git index size: 20MB
> - Pack objects: 18,761,646
> - Operations (mean =C2=B1 std dev):
>   * git status: 0.634s =C2=B1 0.004s
>   * git commit: 2.677s =C2=B1 0.019s
>   * git checkout branch: 0.615s =C2=B1 0.005s
>   * git pull (no changes): 5.983s =C2=B1 0.391s
>
> Partial Clone + Sparse-checkout:
> - .git size: 2.0G
> - Git index size: 20MB
> - Pack objects: 13,560,436
> - Operations (mean =C2=B1 std dev):
>   * git status: 0.575s =C2=B1 0.012s (9.3% faster)
>   * git commit: 2.164s =C2=B1 0.032s (19.2% faster)
>   * git checkout branch: 0.724s =C2=B1 0.154s
>   * git pull (no changes): 1.866s =C2=B1 0.018s (68.8% faster)
>
> Key Questions:
> 1. What are the technical factors causing these performance
> improvements in the partial clone setup?
> 2. To be able to get these benefits, is there a way to convert our
> existing fully cloned repository to behave like a partial clone
> without re-cloning from scratch?
>
> Appreciate any insights here.
>
> Best regards,
> Manoraj K
