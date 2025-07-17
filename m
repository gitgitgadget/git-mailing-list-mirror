Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296912264CD
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792090; cv=none; b=biBHdacxKfjIp+qKK02dmCvfbxbfu1szw/0rUJ8rqRf3lA1fITdfJGxXVOyNhVJtfarbidxW6rh06lfP+l9d3l+eYD8LkHF2LXEgIpwxH+Ytu/bVCRRClXN0/Vup5s2RSIVEccy0lDSm3dxwHbtlG/aZmBV/6zI0x8X+xe/XWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792090; c=relaxed/simple;
	bh=sk/Zt471+ym9/x8eBNSZZb3Hnw6IxapYUkujCbKgG8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCH8I84lMYGLMSYfLimipBd0gTpRf/pXF5P5zZ02ozm6tGaGfM3uPDGk3ecRtFCT6NOyk2/CftZoAc//WMCWKJYboSAo/15Q9Fkst4vLz0+Lv51im6awRVmXOLA93e6z3rErZHobhvoGVxgqI0knrWfBw6xVVITF3ntMA0/Dvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DUbOH8fD; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DUbOH8fD"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e5e6ab7b8so13110257b3.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752792088; x=1753396888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0elUAPTQH+9B6sbnpbsuBjqOMvovMQHR8uLsU1QUhs=;
        b=DUbOH8fDjaQnYef67El7CZdtkWalBOAWUtJPAYXj58WB5YKk2Xw/rQ18SHMF6w3Y8x
         lYshQyRtgkbrXFkuVwDj05dP6vOo4v17LclRK4TSrVYPUSq3GwoJkG4WsSO7S+YNV6z8
         zWsHFLIdi5xfv9zRYzEVxx0eOcAKPBIx1uvrrAG72BNa0N2EFG8xXQWERfAnjzW/KLUX
         EmAH1kvHfetVmOx9hwL9gJLsSyONE1LMgVuH8SWSAwXlgnmWDOHQwDfL4CWtifN3ZYZr
         D0EIxX4LRRXMY+E+ZzvE/CdkvxwSdCAGmwmdAovjG+hXoPJ00bJfIrArq//6lR9Uq0Us
         Tb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752792088; x=1753396888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0elUAPTQH+9B6sbnpbsuBjqOMvovMQHR8uLsU1QUhs=;
        b=iRloDxxX6PXTio0QBVVYF8PJEetnDbH0rzlQwoGyiM03twHXCql5pgD4EQ/XU1B9UN
         TCMHgYQp+6ML2RBST9ttSoEXo/ci4YsE4Zv5iOnlhLG7mtlRbsWdgPOCjPM/cNRpvXLY
         VaFM+7fx6OH54SizDdbZqsCB69e+9dWsAxchR+C8MRH+1k8jof3OFeQt7ZQvWciNNS/n
         TD1ft/dZdxyRaHf35pz6AP2bF0kIoDLcNp0NZZh4RGhhHiubRCSvl8wwEAG/8Nc62Vin
         67RbaWTQY+JCK1TgV7YlhHqF+qk3Gl8wyfmGYOo938JANlNOUMMBlS6CO1lY30dFevg0
         IXSQ==
X-Gm-Message-State: AOJu0YwrAUVu7ZhtNpSUeOyigbOPFOa+IIDE8qZgCHbRrAZJA2d7Gb0b
	/wis7kBQK2lhY06RWeTrUCsPmndwUhqipf+VSzf2PQi6tZPZQhpZ/s07IN02ctZL134=
X-Gm-Gg: ASbGncv4Dn/rUsQZCTrNBohm7na6/yUGr3a1na6q4dcelvlhHu+i+31RwWNxMw8Yh/Q
	rYKT02jv4HnmL+pXWAI6VfYkS5hE7oEFG6N3lyUKcH4SiuKIvwuOowHkYvgCR4i+0+XkrYBiCuA
	KNExi8ONFTVLtZwD9xSI9mz/EnkzCdAqndU5qQ2ESDzA9RkChDE++2qFNkIvFISHzC7w9q2bHDO
	VhRoX21YPNDmdYEya0PbmFNT9xUcNZbKB4QCFrCKV7jsF5QiUpF3LOpZzozElbQSWeKRbWKzDNz
	Rl/gkGSUYmg+HWMvuAdkH+LhDg+f469o6hKJwaeWtPaRsukkk2/HuIHJMnvnJGHhAexEkHExSjL
	6dDGHq5kUsLqve7qCX2u+/plY9uquprTge/I4AJe8MuIrH3iA+6QFGn9Nsv0bHHA+MxyvUFHGVm
	XEvVEc
X-Google-Smtp-Source: AGHT+IFYI3Hgom0qPZGN1i9ab9zHil8MF692oJ5v9CEXEUfU8LWRDZILJr5bOyPvAxxCVNBGoysUJQ==
X-Received: by 2002:a05:690c:650e:b0:6f9:7a3c:1fe with SMTP id 00721157ae682-7183516df3dmr120581507b3.23.1752792087936;
        Thu, 17 Jul 2025 15:41:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719532c7bbdsm431627b3.60.2025.07.17.15.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:41:27 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:41:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 2/7] xdiff/xprepare: remove superfluous forward
 declarations
Message-ID: <aHl8FebhIEd5+kah@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <b0b744b9acf5299d323d56cbcc01411a228c1fc8.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0b744b9acf5299d323d56cbcc01411a228c1fc8.1752784344.git.gitgitgadget@gmail.com>

On Thu, Jul 17, 2025 at 08:32:19PM +0000, Ezekiel Newren via GitGitGadget wrote:
> ---
>  xdiff/xprepare.c | 116 ++++++++++++++++++++---------------------------
>  1 file changed, 50 insertions(+), 66 deletions(-)

Makes sense. Reviewing with "--color-moved" makes it straightforward to
see that the contents of xdl_prepare_env() were not modified by this
patch.

Thanks,
Taylor
