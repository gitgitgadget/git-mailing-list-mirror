Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A4482DD
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952111; cv=none; b=k/2RTGC9Vkaf34cMxzljvUBympt+vTR68YH7EOrViMNLjqlGHKxMV1ZbiZLru1dAy2OglLcdvRrCm1QpbadixdNOLVeNlDalkfdLVNkgonGU6ze4kZMNrmL2qNWLFOYU6ZSNIyo53Nm/baA9sBA6uzJ7MkC96b2WDkzuBurcgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952111; c=relaxed/simple;
	bh=4Ri7kladnbBpfW8sKqdvyjg9EsYKIVBTu1MikNz6Fco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU362NReku6GrHmn5KP0xq+RVTTAlqdQH6w/QOypnEz13YoaUevsGCfXJg/hU5vFg0CMXBHSr79dZ2TDvJgdQvcn/Fg6D+DW9F2Ch7OuCpacIPgufLAvDKy7QFm5SyLnmNVUwEhiL8X5tKmcdyouACRp4KKzL6gcZcdzSGVPlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xpIINvpw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xpIINvpw"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7afcf0625a9so549663885a.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952109; x=1729556909; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Ri7kladnbBpfW8sKqdvyjg9EsYKIVBTu1MikNz6Fco=;
        b=xpIINvpwsqBJjnQmnm5SHnzSK0sIdcaHhkYK6tA6neJu9Sfdz1d3El5SzOP/5foCUu
         OT+RUDcSn9TJXtENn7dDCR0XBeG5zgtBKKWZ2PAw3SoOm/hl3ET5TwyJTYIDI/wAv9Mu
         5tQ7dAT3aWy9Grbxsnvtb76oE36B2HQPjqTAT9nsFTiFl2yObTxmnilM1q2KGlm3I0yQ
         FujvAYwigMuE5BScw48/ERhDrJJB2ma0WDq6tlnXtldSVT69HvVwdvFrZtp5URWKi4Ky
         vvcI99puZS0L4FHeMqWtJUNh2+apZjIldgHScEv2ny8k8A4SPBHP8qmkZlodtiiNH/bi
         mV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952109; x=1729556909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ri7kladnbBpfW8sKqdvyjg9EsYKIVBTu1MikNz6Fco=;
        b=LNzd+inMpID3BxQ96zddOL/6DsBSwFStqUWIYY0rXOqxkrwNIGfvSJMbBCeMACv3MN
         OVKb6OxY0IhM07JoqSoGmFR9hdAxbESq838ZXPhB+MJIqMlaVNW4E74y0b2GGzGTrAlF
         YuRky5nr2B9+gtTfzXka6PdLEoaI8bx/0IOvqNH7uEIdc1J6hAIb/XXoCRCD2uJOjBwy
         LcLG0JjGgr3KuWVVP5N3IJjpjGjRl7Ou/Fa/Bd5TnNb5OccX9OgDFOgMOepLq4ToUKL1
         BZD0THn2jCjlkHosgLd+fR8TFsllCHr3qetXQoVyemESkdcHYBwXuSPdM65ASgvqCSCU
         QORw==
X-Gm-Message-State: AOJu0Yzse5yCZyuJiywGS5jTZu15bmBFm5wjXkOyAz9c+72cVP9TEIMV
	7FbJuyBWpvkop+8fQzTnt+/PrLGI/lN7qtK4L7Gmm5I/g4gO5Y3AtlFPjtUHermUFc3zck92wk2
	7
X-Google-Smtp-Source: AGHT+IH7zNkdcrr13wwC+ZkXZbASH2iBmkNefprwOujsU4xOfSjNYMHiyC0DQ2+iOhDQmPgAyW1URQ==
X-Received: by 2002:a05:620a:1aa4:b0:7a6:5c8e:10fe with SMTP id af79cd13be357-7b1210180ccmr1433510685a.53.1728952109200;
        Mon, 14 Oct 2024 17:28:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136395215sm8490485a.75.2024.10.14.17.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:28:28 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:28:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	sunshine@sunshineco.com, asedeno@google.com
Subject: Re: [PATCH 0/2] Restore support for older libcurl and fix some typos
Message-ID: <Zw23K4zPN9e+JyNA@nand.local>
References: <20241014131346.3556163-1-asedeno@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014131346.3556163-1-asedeno@mit.edu>

On Mon, Oct 14, 2024 at 09:13:44AM -0400, Alejandro R. Sedeño wrote:
> This is presented as an alternative to the patch series from
> brian m. carlson that bumps the minimum version of libcurl
> to 7.61.0 [3].

This conflicts with brian's series as you mention, so I haven't picked
this one up in 'seen' yet.

Could you summarize why you think this series is a better approach than
what brian has posted? On its own, I do not understand the motivation.

Thanks,
Taylor
