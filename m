Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F271BD9F7
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340854; cv=none; b=plNy00kEhPIMrni/MfT+JwKi2VMQEh6Kv6YeY/kkD32JigkOkEaiBAj5GW7fUh5CcLfe+Rqwk5nINRz9UBKnINGnChooxDwxdKAQOSgPMCDhc9y7nWUMxQM2bJlBzfc+MKz9bMAnRhC5DB/2HfGHlzbjQ8PEKZeo0VzH4ATnTm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340854; c=relaxed/simple;
	bh=Dn1gRV/DYDmGZu8ptWabh5B5SYLe8xxZQRX+ev/Z4PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHH8aV99iQc0hWNhw3Q5mJkTsZPcRyPoqGSk+ZhcHl0ztpy6WrYrNU/KDRrfq62aF/xmVBZim1keh/KUHDcUD+cmue+GYd7mbOzUXqY8HlUIxWvKXsNZwrDj83L/s5KN4y8ePJXwJbu+rJKw04yboSruRRaurEDSbDsa5eKKphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBttSEJu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBttSEJu"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ea15a72087so3435587b3.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730340851; x=1730945651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0Nk8ihWqzLuD8qKuRS31htJqwo/CSOOLaesoLs3yaI=;
        b=IBttSEJuKv9p+PkUBxWg+2fywpu2QgEmyPH4bHVvOX7rERDZ+svjZ9g4Cq21znOkgO
         qx6NXK8MwFsaXKClO4zND5A1nEjyjKiUBoKaAGH1GXtmQpzeJkz4UiPdfN/8q0xor/Iq
         VROcESwn18B/Z1ujaB5NxbLE+cqFZa93yxXhshqe2VrvYinN7pkt28Yt/GQ4rvGRx8hk
         L2gR1VTxNNoCninHqb/hS7AYTt9qYyPDjRrOc1Eq3HCI5t2Khxy9NS9h7vrxz+SVAQFP
         foKsCWwAMtKAB2c4AP3oIYPbk/lDTcuOGVq4Oqn6eY/8CjdcqHkher8mmUEADeZyx98b
         mQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730340851; x=1730945651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Nk8ihWqzLuD8qKuRS31htJqwo/CSOOLaesoLs3yaI=;
        b=OCrwPKSNCwsiTpbbdL7xbbj54SdqBPHMkRfSs2YNZT7icmgeygtOVFeCJ3c+9nPtc0
         smFy/3zu37hdOFGIPxNskA9dLGPucKrYyG51ICYglQZPH+bQhX03nAJsvPQb/8LWJKNK
         zSTFc4WmSQzWcy+02Vr/eMOUMSYqq4yo46OvU6/ALYQTsS4WU2rqgS38K1Ixg+tD83O7
         82bhitpXiQjM9kIcZClblW7XCc0zXwG+G7CwwSKWQZp4V1kMYJd3MUi+nUqErPdBFXKd
         ResGJlcpNB7rD0ejpWoUaLOQEVazwVKqfXmagIs+ypNtySw/f26JD5pUhGkorBbD50RL
         De6g==
X-Forwarded-Encrypted: i=1; AJvYcCXzrPuOmBjgsQTyHYbIWdJQPwo3Mobap5zEvfcmdLUENn+wrngVreS0+T4ToNtf2/DN/d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjCNc552GiwPjJj9Htb2vL52OCOH/5cc2Oxt9hdJGAJB5HxTh
	+UyOEDIfpjiPGo0IWGEJJh2RHz3mllOX9AfACQWYowQbFQcjJaix
X-Google-Smtp-Source: AGHT+IFq96F9YQjVPs1pLnTcPyG4Uj0va6l6uINvDsxhmIBxu9LAYnATZa48q5H104HHLuFJEsXnEg==
X-Received: by 2002:a05:690c:6306:b0:6e2:c13e:20e8 with SMTP id 00721157ae682-6ea52520e27mr20531157b3.30.1730340851092;
        Wed, 30 Oct 2024 19:14:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c963:384a:338d:bad6? ([2600:1700:60ba:9810:c963:384a:338d:bad6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55cdb41asm925317b3.133.2024.10.30.19.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 19:14:10 -0700 (PDT)
Message-ID: <1dd36099-1f3f-4078-9009-6c142723430c@gmail.com>
Date: Wed, 30 Oct 2024 22:14:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
To: Taylor Blau <me@ttaylorr.com>, Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
References: <f8ee11d3003e743affb39835ba3583dd2498e576.1728396724.git.gitgitgadget@gmail.com>
 <20241028195404.4119175-1-jonathantanmy@google.com>
 <ZyEkWyB/C/lGb36b@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZyEkWyB/C/lGb36b@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 2:07 PM, Taylor Blau wrote:
> On Mon, Oct 28, 2024 at 12:54:04PM -0700, Jonathan Tan wrote:

> Is the thinking there that we care mostly about 'git push' and 'git
> repack' on the client-side?
> 
> I don't think it's unreasonable necessarily, but I would add that
> client-side users definitely do use bitmaps (though not delta islands),
> either when working in a bare repository (where bitmaps are the default)
> or when using 'git gc' (and/or through 'git maintenance') when
> 'repack.writeBitmaps' is enabled.
I suppose some users do use bitmaps, but in my experience, client-side
pushes are slower with bitmaps because a typical target branch is
faster to compute by doing a commit walk, at least when the bitmaps are
older than the new commits in the topic branch. This may be outdated by
now, as it has been a few years since I did a client-side test of
bitmaps.

Thanks,
-Stolee
