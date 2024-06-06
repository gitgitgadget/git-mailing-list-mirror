Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD54196D8C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690452; cv=none; b=elGicax4eOI3r6CfFlkr/UseNsGr2vCFgFXfnpBmDlRJflDO+hlMorCpUvVra+YlGPDcMfTsIKs8YPYKZUyAM02uZ7JBzZB0kCI6bXJaJH5U0uYPTq1FfFeod2IY8/9XSOv0jupXMT82udfCxzH+VpBAVeLeRi+9qlv0hhfhGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690452; c=relaxed/simple;
	bh=NSSDYeV0bZlSpkdSOMjXHMstNqAmJfM7bvmf2VyOjeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwsAOkyyV9EopokUYSCZ1qE+2VIcl7DLr9H9HshhdI0CDsb7Qub+izu1upkB1xxitFLSHt5pVu3YuglDsDIsi0qLjbn0lNg6StjWiJdSyuay3CWp3lk2NO9EkrPKTtC617htjNey3pQ14aGauyG/Yjff0HD3MZ8wjSGmk+VT1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUrC9ujX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUrC9ujX"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso14438361fa.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717690448; x=1718295248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C46j6UNm39w3RII3XztH/aMC/6hgw7yTpdd+WHml4M0=;
        b=eUrC9ujXW+5GPbyRgWQnzoWGnNDQjfFTTL0tRsjB0gMC3SXKyVPiYRLfvNgEs3pU9x
         MWo/GToOPTGbD3eu+VwVWapOkh+SCLw6q1Ze5AWvFpZMIBGC6LOVf1cASq9O1GGqZ+9M
         dxYlKhLdGYSLyeWhDR+FJtfQx1wlFUnMOUOpWfASh66UwpCU0T7VxcRyjX/D2xsHkxVt
         SvBomH3dxI9nvGcJDqWBeUXjMybvZa1IBVlrMqPanhPVBwa8M/m/4rPJTxcgADTbbCdF
         OvcTX5URypgncg40ypHrL+J2Sa2hUN0ZI1tc/Zy5MvvLrus5/Z6R4ebWjMkoJIR4BqK6
         RgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690448; x=1718295248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C46j6UNm39w3RII3XztH/aMC/6hgw7yTpdd+WHml4M0=;
        b=caKE5DCqsdpwd9KPrPgtpYAwDwOdtuBWvjS+E3gKvGW3aLVAIWlduLqrheLQBBkmom
         LCzNHD9ZSCeQILbFqkF3B0CMMhGRIL2bYQL7VMgbq89IbZwLXlkr4tOnvY/ycvqSxqqX
         tENLFlGYt6mLlZLzSi5qCGwx5+tn5GUGVIkR4qNTaPdgGvrOP5jn3AOsyb6oGBLe4UMF
         THgRhLo7lXOBibt3pBejbEOw7JTZOoqtsnnbkSeLSAZUnSYkfClV+9FCroCOPBf5RTYZ
         OkTF+gcuHtTiYrSs4UwLMC/NyBQaJ0k/zeUcoHnCVgr6gpW7lQqsY2QEgzi1O3HTN3FX
         lSnA==
X-Forwarded-Encrypted: i=1; AJvYcCUq4KyS5FbtwO94M7uhyWSHI0jcbFJMT/LeNYyIPR+cXLkFckQPk0NXiPUbRwMp5QyGt0tDYTUGp8y0s4ohEzhIalyT
X-Gm-Message-State: AOJu0YwhjdwSSL/cejREg3clSJ27tXshalIKzV/vxH1mNIwz//plFVfp
	5VDCHWlFrkLhMmLQmFrjlB2vQQBCQC834UN7XXWPQKZDztMfiVGG
X-Google-Smtp-Source: AGHT+IGyJ963V14JBte1t9Gr0gbFwQSbJKh8rK0Qom0Kty7BMRN1USOtKqB3jaSpbBHdfmg2LBsx4Q==
X-Received: by 2002:a2e:924d:0:b0:2e9:4b33:dcff with SMTP id 38308e7fff4ca-2eadce3fe3emr1098261fa.29.1717690447938;
        Thu, 06 Jun 2024 09:14:07 -0700 (PDT)
Received: from gmail.com (200.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm61995875e9.19.2024.06.06.09.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 09:14:07 -0700 (PDT)
Message-ID: <b1ac45ae-05d6-40ad-a9a1-3a83b5f662de@gmail.com>
Date: Thu, 6 Jun 2024 18:14:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test-terminal: drop stdin handling
Content-Language: en-US
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk
References: <20240606081724.GA1166769@coredump.intra.peff.net>
 <20240606082237.GB1167215@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240606082237.GB1167215@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/6/24 10:22 AM, Jeff King wrote:
> Since 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
> 2015-08-04), we set up a pty and copy stdin to the child program. But
> this ends up being racy; once we send all of the bytes and close the
> descriptor, the child program will no longer see a terminal! isatty()
> will return 0, and trying to read may return EIO, even if we didn't yet
> get all of the bytes.
> 
> This was mentioned even in the commit message of 18d8c26930, but we
> hacked around it by just sending an infinite input from /dev/zero (in
> the intended case, we only cared about isatty(0), not reading actual
> input).
> 
> And it came up again recently in:
> 
>   https://lore.kernel.org/git/d42a55b1-1ba9-4cfb-9c3d-98ea4d86da33@gmail.com/
> 
> where we tried to actually send bytes, but they don't always all come
> through. So this interface is somewhat of an accident waiting to happen;
> a caller might not even care about stdin being a tty, but will get bit
> by the flaky behavior.
> 
> One solution would probably be to avoid closing test_terminal's end of
> the pty altogether. But then the other side would never see EOF on its
> stdin.  That may be OK for some cases, but it's another gotcha that
> might cause races or deadlocks, depending on what the child expects to
> read.
> 
> Let's instead just drop test_terminal's stdin feature completely. Since
> the previous commit dropped the two cases from t4153 for which the
> feature was originally added, there are no callers left that need it.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Rubén Justo <rjusto@gmail.com>
