Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FF145FE8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539931; cv=none; b=TUHIPXEnUcvXj4wuXmvU3jHpyAN8g9Bok0QxofrYsDI47e1uHhUMIYUx+VJzhLdGu63t1kNmoFHZdBNlGQPwCWrQvBpe/E5UR60CY6G0DUYlnZF7O78bLmbOaQ3C2SLbD60HuMH9huFlJqGU8f/qdcFHR+PJB6YCGdP1dnBxUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539931; c=relaxed/simple;
	bh=ccEzQCneuZ8CyO4/X2bUTFyRoXS1UR4wDRwW0xgxWsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5iAGU7rdTdjFf0ThgR08YRpb3IFG460nL2dCBJx+3siMig2N2xQQu3XgSFYpU8ZV4mDmpI6Db2/bA1GQf5FJLHOklmQQvU2PyLaLkMUxmgsNzJW9Ly77T8whOH9wZYHpUpgpNG794eL0Ut+fkmR2gBjWzzdSXEPxvZMsYLcV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aV0ChbOk; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aV0ChbOk"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e290d6d286eso3848435276.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729539928; x=1730144728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccEzQCneuZ8CyO4/X2bUTFyRoXS1UR4wDRwW0xgxWsE=;
        b=aV0ChbOks5CcdPl9xNOVnOSlvXUvJPKm5bhfH+Yh/lC8F9zqVKMNSZydwKcoKidRDh
         yMjoky+UX4p5f/VLccflrthvPL7R6wcPiFcwLaZcNNabJuVgxfH6yaBwrhfaaZWT9NwN
         2xFReDgUKYy26YMutk3M19xd1ZhAbqRC1URaUJSTzNZP58uCRQIVdJvbko1YmzKxSygT
         k3r+iaGRTFLZhRpQ/ndjsVW2FYmhVkt7Si9iRzQCz/I+QSiHGTRFmpSoW1LoZK9yxgbj
         Ai22C/pxvDJBYvprbhk5j22mNA0FAEV8cHtcCuH+AhVf1e7m0TwJ5TEUn5mVK9XW4JgP
         O4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539928; x=1730144728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccEzQCneuZ8CyO4/X2bUTFyRoXS1UR4wDRwW0xgxWsE=;
        b=fDJzdlOqCgGsMEtn66K17WXR13kK2pYa5dTFfzuLiur8GF6SrfoBawHHi3CG32nOqb
         eC6rjrFxAAA/VfeZIz5PQ01JzOCG8Hl3QnqwmTULtqMYzvgIRtdQ587Vls5prX/ueRVQ
         yOwPYFaBalOxomb5/yA2IFtLATXRc6Aje5HXEG3Y2O5vugC2iEVYDgNAXVtkbxF5iO7a
         rU6ZxvpIFMxpLDCmrsgK0fLcn82SFUfNi5tZ4Iq1vJL+P+AUAO32Hxb7Nk0Qf7+6DZBi
         lk9EH1Ov/Jh06im4nt9PJDdFC4goNlZU+9KvJAHXvy90C4VwYWMwQxghNK9mwX0RmI7S
         FUiA==
X-Forwarded-Encrypted: i=1; AJvYcCVzUaZ4nmpsjnhm3jMwObn33UETkX1IHBG2UcfCwSE0lmgcpJb84FoToub/IiG3d37JUJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPBRm3C22f3mfMQ5vRi8W7sHCel3OplkfPis/DXY8djNZFK9J
	h6LmNVfuusPgCZ8odBj/20UOnmx4ZQS6q79GeucWnZfcsQi1lrXqpnqc5vYRdyU=
X-Google-Smtp-Source: AGHT+IGZcBZA84qL0BKQHj1R0RhFBmWGAW0yU4GeX6oum+AHIMx/otLrGkrBVgx4sNLM8zSpkgdxCQ==
X-Received: by 2002:a05:6902:2607:b0:e28:fc1c:eb4f with SMTP id 3f1490d57ef6-e2e2305b360mr1301244276.45.1729539928209;
        Mon, 21 Oct 2024 12:45:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9b3471sm825114276.34.2024.10.21.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:45:27 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:45:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Message-ID: <ZxavVmjsshVHCPcL@nand.local>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>

On Sun, Oct 20, 2024 at 11:42:38PM +0200, Bence Ferdinandy wrote:
> But so the long story short here is that for
> (origin|upstream)/(master|main|trunk) we can already have agnostic code with
> HEAD for the second part and with a patch like this we could have agnostic code
> for the whole thing.

I'm hesitant to pick this up because of what is said in this paragraph.
When you write "(master|main|trunk)", I think you're really spelling
"HEAD". And it's fine to write HEAD in a script when you want to resolve
something to master/main/trunk/etc. without caring which and instead
delegating that to whatever the remote HEAD is.

But determining the upstream of a branch is already easy to do as Peff
points out downthread. So this seems like a band-aid for scripts that do
not care to perform such a resolution themselves.

Thanks,
Taylor
