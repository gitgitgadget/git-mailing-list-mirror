Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E31DAC92
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488556; cv=none; b=rU82tb/7mMp90VANg0jdf3VfU9Gr/R1LzkZ6mrLSxylLeBtPgm2/Eov7taiJgw7NXiP6wvusE9RSndQNrILys1uTNKhrrIISVv7tUXm6iOUwGgOkqVqgRixKFGXa4oCwJ1oOpBnIjffAtcycU+aQqWBvtlWTKFQ7t0mJevziDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488556; c=relaxed/simple;
	bh=kP+oE5EBqitFcabDACnzRaDiTMuHGyojZ8w7vdlakS4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oZywit/nn3rgqimnnEF1sN5SFBjPPMTM2W1oAvTdk3fWdTgYBXcRq4Rw8nOZFcSmwOFxBsWVW+7KVj9PnFEqBV8XAwcPlWaugSuNSgmqMF0Hyk9ipJcXRbOLL+kC062W0ww8Fsl4uzSQV3m12BKv1LFjAJHWQX+P9SrCisnjWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1z+4oSU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1z+4oSU"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d425fc4e5fso616257985a.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751488554; x=1752093354; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP+oE5EBqitFcabDACnzRaDiTMuHGyojZ8w7vdlakS4=;
        b=c1z+4oSUodBq8jw2OKgsWKOnEGErXK4LYzz/tpouB6pO+W10xbE2aEKLNLBnafi1Lp
         UrNQK5JpMbgzNSgN/9pQsX2/qXnx/RraLWggs9IFA/QErMaKlwAVAcejMOAQ12KOfn6W
         ljriFvNQS9KxD5bFdBjgO6eP1CsepkAaCMTMN38iO+qwrxLW7iy5Fx9x0u2xo6OTDhxc
         st1mqj44MlKeLlqEiDDuS3g3yDXSoKPykDRjHdTbIYXW7162YvIUH+VtnWLx8x9t/Qyf
         QmdrZAYVVB5UVEh/S8mKgfhM5loekVp9WkYT+eWVy5Qp8kMfyCKUCReVXnHVsjXU7Utd
         NT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488554; x=1752093354;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP+oE5EBqitFcabDACnzRaDiTMuHGyojZ8w7vdlakS4=;
        b=tcdMAgZYzO9aZqNQsJCCq+zuRlJVLi3NSPg0kS0dpyf/Fqz905OaYMjT01vA3YZOk9
         k6JvrtXVIvxhZPRW2JYh8hx7sY6CVbFckvk+Q8krWZlheNYWpT00blFtVWFnkyer1mkB
         pBUTEMZ6GCTn641z1fFVuP2rvvLsKsmp4wNU9Lzro3TMTVS3e8/MrP0SA9X3lbPwq873
         ROf+1Ygjb67KlsE1Ye5tbz9OfDugMtH1ip7KigIUbXcBuvlF146s6mLYrBTyfLpA1twE
         cTFLC1wmtHr63DmtwLyHDxgyIEciPhk2ZxNvruv11fpuYVgFg1XsJqOKsU0l6yRHuWZv
         D6Ug==
X-Gm-Message-State: AOJu0YwQo8MwABItOPwJPKApHlPvSAqk5p8w1Ew9wjhCxYnWkoml1wxI
	52JhTN8lV/hyJi+0q84/zDwhPoxk3xqORAAm5JgFnv/wJpQu63ZyUqyQTrDADaN4
X-Gm-Gg: ASbGnctY1QTjYHystTN7yduwtdHnMAKXOOwhaDPnXiiMD1BbWHCyRfadm1gdQJoHzoV
	0iHoPxhPCkWIapLT7wJvYiAw+76hZmELUIrz2e767+Cp3hR/DrZskv7ODg+hjEwt2PuiBo7LDs/
	nKcJF0nafPAWb4RS4EWUHFUrbH69JRpIBkyoeR5ekZwruzCUtgOjtead/BJgc756pyCvNuOHUdt
	a7wfwVE+F4iUj8ZFrEwQWRk62SbEe3vlXmU5zswusrFPxkVV1E1Dt5D3TFgW+A0QxLNomLNik7j
	Z588sqeqXN+HG/p4RN8ZDdwswt/wzQC765W4FJ0WyW9YMA+0uWSUV/wDfgT3uAh1BnQ/mYqdaMh
	0DfjzLGyVJg==
X-Google-Smtp-Source: AGHT+IHoKIUVyY9Zl+4lIYWyGrrSl4kU2eXK5F7ycW3WWxkJJNPVBzXmFmgdYrOvdaJrN+dX1swsoQ==
X-Received: by 2002:a05:620a:688a:b0:7d4:5439:daf with SMTP id af79cd13be357-7d5c4704045mr580308685a.33.1751488553622;
        Wed, 02 Jul 2025 13:35:53 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44323b4c4sm995151485a.106.2025.07.02.13.35.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jul 2025 13:35:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 4)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <01D987DF-4B04-4DCE-BDD7-48E1492DF12F@gmail.com>
Date: Wed, 2 Jul 2025 17:35:40 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <074D44AC-1A0B-46E9-B0A0-85B2D03BCFDB@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
 <01D987DF-4B04-4DCE-BDD7-48E1492DF12F@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

Here's the 4th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-4-jun-23th--jun-29th
