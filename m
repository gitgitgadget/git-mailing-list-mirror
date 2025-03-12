Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809661E489
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783474; cv=none; b=Knc6eekUTyku/TwqyvU2dNOnprf9YJ6VvOjfXrqolMzDA8Ofpgr4y0mf7NQpXnd6ejrsGWyfxuSMvYwP7ma+qmnbwlRtsMfAT+njm0X7JADxQ8e7wJEhaEZb3Faoniny8QMuL7jZpj3qZf3k+T1oDjteJJ7vs6IcE9QAMb5Q0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783474; c=relaxed/simple;
	bh=++pv1awPV56pjKVo/L2wSMDNZ0qoadgteFS8Bk2a1Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doPLFBDTbf4kXxAFtZLwjzh/SOKzA03rzxTbO0bIOtHyZrHQZlWEx8iy7KKEJMzF0Nloj1Sp1XLdaK0QH/v1carewrtQplmmTg/ZhytrGpvi/Rnu06BGUyo4rTYLBOlhBqfuupMKfy/v/Py9qiP9MvYwQ3J9QZ7SOD5oIPerfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A05HfcTq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A05HfcTq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22359001f1aso156411385ad.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783473; x=1742388273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaZ3YG8Qq55RVr/QEVpdtXPAVN9Meg9QgxcjedY4qSk=;
        b=A05HfcTq1DEkHDgCo9wwVmbfqtae4G6ygZzyrPbEwPzoC9mI7z3flt+j03NohX0bq6
         WuVsA0/+O9TJRJpliMpHTXoX44X8nrSncq6wnySqX4okjDNd9Xo393ic5ZIIkiYH758+
         5FPr6XlOXMoit7siT0tv5nUPy1J9SaRWkKeVhrgsln6Oz3xbq7EwyfS/Z5dPT+O4FhVK
         thNLA6CQraULzPQ3jUsy+4rKZV6QERPsKt1cHcQs1OUIx2f2jE3v4aC35wxCvJh560m0
         U5tdpFOGA0hmJQ3vQEliL7ET3C9kBjv5ih2LWiGzHVKI/v/iHANmVFK9hdBVUpppNVWx
         529A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783473; x=1742388273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaZ3YG8Qq55RVr/QEVpdtXPAVN9Meg9QgxcjedY4qSk=;
        b=H8Cv+n4Ccy1a21gPa+h4a6q4+bw66alkM83QGWMkpVstlnsqM+jXE7hsgpYccAXO0F
         Y2jPz+GIjQ1Od+ufVkGfskVQxM1vlRWrj7mW8HVDqi7kTeRbpDYYY50Plm2RweYqbSAu
         zD0Yq2/ub0dbkv/Vial/m+S+96NjPO5WXRDMPShC2GMW4Pbdewzd1G02K01ahQfwG9OI
         R4CiljSCv72tsPAk2xnCF98ViNxxbY8+4jADaq7RXRSfPtt2/Wd0m4/flpOmSiYUXY4K
         fZvloADdG8JnufNRuYMCADcF+rcosQyqiNxjxPAzhbAyoYBbCR4pVMknOTIh1yqaKOaT
         9dDw==
X-Gm-Message-State: AOJu0Yw1V4NlqVAoG/H1fI5WczUqwrLPo2xbqjZjMbPxVP48YGEs+dlX
	iHqkZ0fxkeNFp/QvNEjo7VIu+Xc90GF9Hx1BeCU5eRSw6tJNTQhm
X-Gm-Gg: ASbGncs9G3GutAeWCurs9wDbQdZ8ij2dCcpCVvJBN4Db5gKgGgQgrtq7N1q5X011nkF
	kHjajsuWvyKhptphp15INwmekuhx0E8AW9WTVehFC1Ch4NcpDFGxLhHLdGAvcZ8o+3ymhR4tNzU
	nQXan3zp9q5roW/WmKrortY4ouLx7LTqaqQpHjcHI1qqQvsSloM3ban5G21N6f9nKt+328tqT5E
	uObcaAI0FlNoU5DpjvlihttiqXb3yH8EEf/Ep0zHodQ/JTmYwkU/v54YGLCUdnropDcYpBIdudG
	2o4SV7hqSkkuf66RrzD4hJ1sVlTAmFDgHDX3ZIEy
X-Google-Smtp-Source: AGHT+IGkg6LWz+mXsNLt/C4UkWHP1pzBUWDtC78g8tNXe7L12Kt3lJmNRYy4YSci6tAd8Z80HiRjMA==
X-Received: by 2002:a17:902:e84f:b0:220:e896:54e1 with SMTP id d9443c01a7336-2242889f4e7mr301152815ad.26.1741783472700;
        Wed, 12 Mar 2025 05:44:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109ddfbcsm115068555ad.21.2025.03.12.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:44:32 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:44:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 04/16] refs: introduce function to batch refname
 availability checks
Message-ID: <Z9GBut33q1puzliq@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-4-dcb2ee037e97@pks.im>
 <Z9F_3xu6RXeelXJK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9F_3xu6RXeelXJK@ArchLinux>

On Wed, Mar 12, 2025 at 08:36:47PM +0800, shejialuo wrote:
> On Thu, Mar 06, 2025 at 04:08:35PM +0100, Patrick Steinhardt wrote:
> > The `refs_verify_refname_available()` functions checks whether a
> > reference update can be committed or whether it would conflict with
> > either a prefix or suffix thereof. This function needs to be called once
> > per reference that one wants to check, which requires us to redo a
> > couple of checks every time the function is called.
> > 
> > Introduce a new function `refs_verify_refnames_available()` that does
> > the same, but for a list of references. For now, the new function uses
> > the exact same implementation, except that we loop through all refnames
> > provided by the caller. This will be tuned in subsequent commits.
> > 
> 
> After reading this patch, I think we may could add more motivation here.
> What's the advantage of checking batch refname? From my understanding,
> we want to check the group of refnames and if we find one which is not
> good we will just return and we don't need to check further more thus
> avoiding unnecessary checks which improves speed.
> 
> When I read the commit message, I wonder if we will loop through all
> refnames, we still need to handle the same number of refnames. So how do
> we avoid this?
> 
> I think we should make this clear.
> 

I totally misunderstood. After reading the commit message of the next
patch, I have realized that we just simply do a refactor. Ignore my
comment. Sorry.
