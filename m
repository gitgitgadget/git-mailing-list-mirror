Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0A23644A
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873539; cv=none; b=SYXN6oNhGlOKZ+PgT+ZgQSGKyzZI6u75u8Oxmq7+UjvaEJgfHfRXgbOILBnz6gYvJag/SOg2EIHv2p1onpAsMx1j/RUzKncwMnqPxnH5DuZjkF2M+Io6nglUVnUIqBFMlisf9NzJC+3cQfGLAnqYx29WZGK0ubhu84j9XfTWT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873539; c=relaxed/simple;
	bh=tbxdoMPyShDMtZer8+s2BQnotheFx9DO0ZxIstnrnc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5syOYo0rG/5Y7DM/WRhBybuYhAS30/03lxDYj+VreX3yzMFDO1xk95XNGbEMiZ3MIH1uRjpyO2rmoH0dvXX6tJgjBBqJ5XCnbT4d1lvFc5xTRvdkCml+NUYs13Du6zkLyV9zdtktGrA3X7QTR20B4c589q0C6wTJjYHUoib44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iru0rtTz; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iru0rtTz"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e65ee08779so7502356d6.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873537; x=1740478337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tbxdoMPyShDMtZer8+s2BQnotheFx9DO0ZxIstnrnc8=;
        b=Iru0rtTzkGLbEcooghSixskb3YLMMOff4MfRA44gDCjK+ZuqGEWQIH0ELM5rhTTtRY
         mKO82F30dp8KSLZpEN+OEXjLs0phypux2xa8n8P9rJSqjla94UoD+Ni4Kk8bplEbgPc1
         nhP0fgjstodB+NmSeYcpA+a71MOh41eyoq9MseElOZf4qd5KV+TtLSY42/1DlLoKGzP0
         7DbjjWocYpaIzffEPrRGhy+rWXW3zQxUsHLNJoSIx8RuOpJRsxAgSuzH0MpTkU+nTB6x
         i1E/sscYDqli29cANoECEs6mpw4yY3xAVCIQdEIFphLzsxYy2VVPJKPip81TkFuZsgmi
         92PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873537; x=1740478337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbxdoMPyShDMtZer8+s2BQnotheFx9DO0ZxIstnrnc8=;
        b=olMDMa1RU2mhCl/U82gHT23OBaVqvmlf2OnV/l13pb0LWSDnP+NoJdFKi5/3HK4DJh
         9nz0CZqwEY+2XX2ivZE4Wwxp/YNHb1iupF80hVKwnCN/51n2vphxzsx9m1Nr0PAKsKEP
         MYX15EKMGYOHOve14XEfsPaqd4okP2elKpQcmwlQaM8TGvoA5y793Kmkk7EMFLlcFw8w
         3xqy8pxmpbaSdRdV2gEzbXwWsDeFsB9uqeadjQcN1sTZSCKN8eDtQy4k6eJiJKrNjpMC
         A54tWhZFatcBTl/CCkzlTM0pDoyBk9FUHeYuqid8zX/jH8+j9YGSmwJLsmFa1yc3qaXe
         rXiw==
X-Gm-Message-State: AOJu0Ywojjojnp+skN8C/DakO1j5+RH89e/m47B8g+q4pvdpycxtxxMZ
	MyWCqo+iHb7UgsnXDRScAzi2uBKiOu1793AcceiogTVwjNBOsXwNebp3mNetI8zJOlamaLHT+kv
	U8Q1TFWVUHAZv1LCYjJ8R6Ibg6xKhfeLF
X-Gm-Gg: ASbGnctJpIQsjLemWej9NurPtMLqmPt/FTQa7Ku/1bZpmjmAQ7CQQjiJuiobTShtsYV
	g2DQRRlwQ1R8j/P/FK9a2OT487bFfUN2JuwDcbc47X75qkBVTQOztJSHfTzIX2CtCN6uQ4hubOR
	0=
X-Google-Smtp-Source: AGHT+IE/0Midc/ZeDN5JSTYaKnLLzNhOLdmkCtRj6RB3tHGDEAspNPqeFdaWCMusohFV460YrtIxfJeRW/IvYGwVxH4=
X-Received: by 2002:a05:6214:e83:b0:6d8:aa37:fe17 with SMTP id
 6a1803df08f44-6e66ccc414cmr68518396d6.5.1739873537056; Tue, 18 Feb 2025
 02:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im> <20250218-b4-pks-meson-contrib-v1-6-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-6-c3edd292beb8@pks.im>
From: M Hickford <mirth.hickford@gmail.com>
Date: Tue, 18 Feb 2025 10:11:23 +0000
X-Gm-Features: AWEUYZkmYhpqeslWtUbuMQcikZd1fTtQmGQg5PZ4zyo-e7M0n6Y0Vv3Ojz2yrHM
Message-ID: <CAGJzqs=+mL_GyXfR44iQ6o6L+gb=D7DWm2Bq4eW19XhuEFuHew@mail.gmail.com>
Subject: Re: [PATCH 06/12] meson: wire up credential helpers
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Note that ideally, we'd also wire up t0303 to be executed with each of
> the credential helpers to verify their functionality. Unfortunately
> though, none of them pass the test suite right now, so this is left for
> a future change.

Out of curiosity, which tests failed?
