Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16F21D3CD
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916118; cv=none; b=GxxoTVyC1/9/WIdliLEGWdiXqtez6W0KuA4Kk1LMSQ+yOX+GjSnSsf2tejgxKzoGmQeqEWn3mAmrCeYiURnV9yOgGRzzWBMR7MdgWYvzyF1Qq/XccQL0F6tYf/3YzJQjqbm6CgendFdoM2EiQbKpCE3KMbKOYUwPP6P90X0sWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916118; c=relaxed/simple;
	bh=gxclEqbtjB+NAIThFipDAjpwgUUObpijOt54SWWKVqk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzgO6QMsMGBsG9oPwqmlOAb3jXYNprtmQ1nr1a5X/yATu1Ko17qVUOi27/++yeHCziUmyhlVcSf5uJKvpYnbkENuyxSJD/9yizdQM8M9hbF9aqAPOpw8qKE76vsd28zXyFel8dNQqhUFK1utRqWj8yzu4NxEE7IqtpKp6/MZgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOk8VXG4; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOk8VXG4"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4790f0347bfso4558945e9.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765916116; x=1766520916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxclEqbtjB+NAIThFipDAjpwgUUObpijOt54SWWKVqk=;
        b=YOk8VXG4sgm9uu2QK0YTliFqwCZTGiTIAZNEBNdzBgfP2w7ZV2NaksXtbVQSzGgcW0
         mGgodKCh2TFRExROobTcTqRd6RkSgA5t+TmHd4PdkL0/wnLLgC8VJe0/b0vPObJIrJ22
         AkMgr2f1eN2VC18T0pNpWJmGRp4tB3dykAyP3kekUQpBFgSmHzfOfennfzNi30ZXF7TW
         SVmaHHtyZA37/FP9uWER1NJoAwrwKdUw63NRLc7oyLWNAjXv2Qyj0SQdgy915u0Gv24X
         hIM+sDzmtUszq23ptDllxjlKJC1TcHDa6Vx9ZenmwnHDIJbmqUBfhKOLx7nZIwmRaCZy
         6r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765916116; x=1766520916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxclEqbtjB+NAIThFipDAjpwgUUObpijOt54SWWKVqk=;
        b=siRZnYaNLKLNo23eCEY1W84lC6fuQA4hW17Ip27U1TzgjW6WUbr8SFcwtO++dFh0QZ
         VTXB1jLVsARjL1NCgQ1QOkN1dog950aTbSq8EGau3rUNrIeAmpiJvzhftxXzp+Xs3W/8
         vKFwghLInsTsM3GY6twRO25oIf/ZuNfT3tlvvB7Dc8/Wpzl9BJpD/WM2ey7bz1Ug987K
         6+DUWJVmCy6W2dA/0a3fsHEAd4cnUhPLAik+aiVsYgXFbBDwmgp+lElD11vvfbwnOW0X
         9lT18u8BRUPne7897lAX/M9G4iGbO7ETRKx5PK3skiaiPEp4Sipd1mt6lF05nIbp0rRN
         lc5A==
X-Forwarded-Encrypted: i=1; AJvYcCWNsJIfsU9Vimh1wDmfGVWJgX1ZToKm2wekIs7iSZ1YiErHgZoe8RFSRzT6urt3KhKeTI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kUP13mouUAh2QVpLL67f/BK5PCHMDMVAP2h/2fSxes2yEfaw
	kiI3+GdWnAxTUcfrm0frm0jUsU7HixMln21WEs7BnmN30bBEwwIbjXqqpQedFydkJ9CeqQ==
X-Gm-Gg: AY/fxX5QndXV+KfWfA1ba+n2+Xw5uwCndr4clnwS/d12IeoDVyMOMDBA1JxslSlOrdW
	qWmZjAIZUZFp+RHKKwRD6OpfepRoWjF7MXxU0utT0d1SsQ2PdZRDUH4fBlngX05Xgenv4rmTto1
	UT7LNhiPaOZwW3cOLxY5FqRfkTpA5cvHkLsM846iFZxZO1D4qVXkV06vdT/1O1Y/rit/JRSgbj8
	qKjB6CxtqS9IdPlK0qpRtFGcEGFxlz2f8zBi386xlfZlqrFCYHKmu3VtYQCsTYhz2sxWyhfm1uk
	SuYBJH7QgAXRo37jP1Kr3UX3B+xxNFBgbmkuQNZx4phVBeg3e68O7iZrSDLkpY5p7ZAiFEFFG+z
	u77MBM7g2mUEGjFPKx4EEawpwe9UgtBqcpKL+6xkFiHWCI1KGi+U60NPxKAWeylbcGBcaNvAW8p
	+Dp4k5CH9GxpLTgWA=
X-Google-Smtp-Source: AGHT+IGWRro//4H3e+XQoJEHt07SxBVxcm2P8utSvGy8SfnmKRM7+JqPwqJha6f+BTPCDVYla5aAqA==
X-Received: by 2002:a05:600c:8119:b0:45f:2c33:2731 with SMTP id 5b1f17b1804b1-47a8f89bc15mr91942985e9.2.1765916115464;
        Tue, 16 Dec 2025 12:15:15 -0800 (PST)
Received: from desktop ([194.127.199.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd992b915sm15143355e9.11.2025.12.16.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 12:15:14 -0800 (PST)
Date: Tue, 16 Dec 2025 20:15:12 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	git@vger.kernel.org
Subject: Re: [PATCH] config: document 'gui.GCWarning'
Message-ID: <vglmz6lyxgnvmzfu2hysahds7n7tqewxt46vnupxm4z22z5gtm@ay43veirqo4o>
References: <20251208190400.64920-1-matthewhughes934@gmail.com>
 <ded2184e-595c-46f3-bba7-1bb574c2964c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded2184e-595c-46f3-bba7-1bb574c2964c@app.fastmail.com>

On Mon, Dec 08, 2025 at 08:20:07PM +0100, Kristoffer Haugsbakk wrote:
> Apparently this is a continuation from here https://lore.kernel.org/git/jcqsqytuxpqwn3yhpz7fxucbuuf635q3jfgkjzauxwhrkhl7gg@g42r5kwwoknd/

Indeed, thanks for linking that. Full context for the sake of anyone else: the
patchset linked above is replaced by: https://lore.kernel.org/git/pull.2010.git.1764195516.gitgitgadget@gmail.com/,
except for this patch which is stand-alone.
