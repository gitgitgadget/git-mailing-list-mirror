Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963A182D0
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903717; cv=none; b=DZif1LIJHBTB16Q+twr5uN4HJRgE6VCmpBI39S9ha3WXQ2LHOFZeYJwPe994MlG+5Xn8YS3zTCf1Em3hs7Esxkj+QeHnNAySMJcTVZcSI65a/k8PEmTCqxb0aCHdAmt1bDbYOpfylaBJ3oJ0qw4XsxdZW73uyMBAHc6Fh1fPjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903717; c=relaxed/simple;
	bh=aze6hIjWmoslk50yhdrn6x0Gn/zGqZBXVeUGHnliszg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQO/TNNL6q48KFcs937Wxzrdf37XH+W929MJnjHRI7lV1SW76GXIcFQo1bCgO2NM/lSbMcm8ex5TfxQeRVkijGUQJWhn1r3fpv2MMjlcuU+PbiaBSvdBXgW8GnWaa3ljIghmYrTUjGVG1+jlWEg+qJFX6FUHdZvlb7c5+c1r1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5J08q8h; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5J08q8h"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3674258b3a.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748903715; x=1749508515; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoRz/fueRcSJNpN061IbEN9eKTldZhMJMW1Te/NO5p8=;
        b=e5J08q8h9hMI+kSNROAUeYwvQIffHs5z61rtMvXlx6F/TxID6cRxuEM2wSjWiTD/Jo
         0V0DYgq6YUljLNDIHfsV9ENMYcjjKyIQv0AOmhOp8jQjkpor8hZsC9u13SSM1Le6NoNq
         ZbJPkAA5VmsKy0KZBGGKjA1BYlpHdUScS1qKM28fBlEk8uhgGkoXQf53m2BSEWrJSqk7
         DPiP8uUB8pYymA1UhBuizH+0l8JFVH9XDbI92h+fwl5GUgjTQsvS62fMPRye1Uh7S+g0
         UiWO9AiSPbQmyDCpb4/nZU2WJECfon031ZlI7voN44fxXC40cei7r/k8xDcaUPXqMYxZ
         4+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903715; x=1749508515;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoRz/fueRcSJNpN061IbEN9eKTldZhMJMW1Te/NO5p8=;
        b=br+r5C9X8UyghSS4j2VigomJ1U5TmdXQ96fBrUyC4uyhxbhuteg7IOzBqDen7jQkGN
         Zk2v/gVL87lIUnctBUJulI35XP9E7dBxYltyCw6zMYqOZjuixggfSnbdi3kxPYIz8NKo
         xkCcjfjDwJUY3msWHwhSi7uORKosKhIwngZjKAn00FCRP9YrSiFAbHxhprJirAawAs/3
         SM7WwcivY/p0wbDwNGW4pLBTZPDLIgZpkRixAJcjcPyIB5IBTTGA7PVkye8vps5GnPPz
         pyznzsxi/6EtwAZ9ju9A4mK79SDdninF5/mcKIu5MHjH0d9GET1JlP8SOsjR5fsHOUpt
         byLA==
X-Forwarded-Encrypted: i=1; AJvYcCW1QEQvcqBIGkY9FqA2rn0Af6aDeP0ZaD810iO/zG+Q2Jv4zVSfC67S83E9XNKuevkkNHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2t5iS/NK4jJrbNwqO9HEFNA1t6OSIHSBZ0KGFakhV4bEQjl+
	xfNmeoAa5tZeMKlbSF3RW0qfz6BbaKy/nxFuhwNEytgqLAAanOKAsBBOXjwwAA==
X-Gm-Gg: ASbGncvX24FRlNXH0le9iqybJJXFCNI6bAFFGUkJjpNQ1PB3lNjIUEhNIBApZJLXjIs
	bCjUFQJw5OmziHTCfgSEr+SpV/dNOTXvzahKWvxWCFMgAdDOp6QtnA56iQB9ASIrXkZUyIhDyNg
	W2vZxbo6oh0GXqWaA7a+sSdrI679wiSDfr8xk7U/ocuLq8hFsshO5YPE7OIJsa+YCh+ZkMNoryM
	bvLiuB99xKdbiBk+B3AkSxiQ0F64t+Nqt3HHq7uD8eUtxmr1QqlVpS4313WuCjbY+mdmQZ7Ha3k
	j6RfmqFVRu+6NTy7PSSfH0FyI9xxTyQ=
X-Google-Smtp-Source: AGHT+IEFHnO/BKv+8rm5p9qeNuP88blZHM9dmxZy8VDSzixeEvSdaDh8CagIp3UIjPG+wxugSw0gcg==
X-Received: by 2002:a05:6a20:e609:b0:21c:fea4:60e2 with SMTP id adf61e73a8af0-21cfea46126mr5976477637.3.1748903715244;
        Mon, 02 Jun 2025 15:35:15 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96474sm8171954b3a.22.2025.06.02.15.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 15:35:14 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  <git@vger.kernel.org>,  Junio C
 Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: Make sed command that generates
 config-list.h portable.
In-Reply-To: <e6a4b604-c5b7-450a-b4f5-3863441e0c6e@intel.com>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
	<1ff542bb1090cc5185644d6032addac5cd0df402.1748892261.git.collin.funk1@gmail.com>
	<3631972.iIbC2pHGDl@cayenne> <875xhducs7.fsf@gmail.com>
	<e6a4b604-c5b7-450a-b4f5-3863441e0c6e@intel.com>
Date: Mon, 02 Jun 2025 15:35:13 -0700
Message-ID: <87msapsrfi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jacob,

Jacob Keller <jacob.e.keller@intel.com> writes:

>> Then go back to the simpler sed expression before your most recent
>> commit. I will wait for others thoughts before posting v3.
>> 
>
> I like this approach.

Thanks for checking.

Although, I now realize my explination was slightly incorrect. Some of
the referenced commit is still needed for formatting, but we can remove
part of the expression that causes the problem.

I posted V3 so others can check.

Collin
