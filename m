Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47661C6A3
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732964122; cv=none; b=UIbCu0icD7iwqQ45+v8zFAHonV8FrEtQteCfsNn9laNJioWoAy1m+2HeyEJOKy+GMosPCg8N+MCnqWYps3HXvI7C4X8xk9TYbIjNsriB8sc8SR2RKT3g3iBxWG91bSosfUZYi1V3QQ8GOhtS1P6PkdV8Y0X10nw1xD5NFYom2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732964122; c=relaxed/simple;
	bh=tB//pOSynLUy1c4ChqoFLyMz3H/qhw2CXnb5YlK3wP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWA6DLX7hCmeyc3QZf+iA33LklvTuBFzuiPQFi469J5QYKwxGZeNJdVNW+tR+VxtFwygbEdcaJaE+NmCfKipIS0c5cxjK1Rk/zlCsZ4R43bno6cyXKedjUCOzIe8sSv7Y8m4EHcr74SgD//Ozi6zojaio04q8Pbh1UL7+FB4ORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7GNH7ME; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7GNH7ME"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21290973bcbso25501825ad.3
        for <git@vger.kernel.org>; Sat, 30 Nov 2024 02:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732964119; x=1733568919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5KfTDSA26aX3J06XMn2YW4EXTDaEjpoy3OyhuogAzz8=;
        b=T7GNH7ME48cTE1m1T0qEERP4/0yhnuTIDoIz3RV2qWaTE8UYHvu4uGGSGpSqWFmEbY
         n6FWDx26YtWyOTjgqQvYYJy2EzOWVbXwZxMnWrbavrxOIRlrrmhowcA5N04uT6oKJbig
         1ySKp4bHXcaWOKexlkNCWQM4xnHdiBUbP5Fnrz7obXoy0VS1kDsVJ8XrRxjIpUesms80
         JKN39RKKhg4T3w14sPEqyIYt55mrFtFFF5OmNKQoxIlf5e3izFblOtmsx07+mnKoc9h/
         NBglUqfQGpF84BwbpSFQPmXQEzCtoWLXVk4j3nKtPeAeeIKc4GmVtLCjPjSGjKNVSTV+
         h+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732964119; x=1733568919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KfTDSA26aX3J06XMn2YW4EXTDaEjpoy3OyhuogAzz8=;
        b=fOEfcb1Dx3HBfzkVcHISHStWarbHnYPH1PQjdFl9vu4eIeMO3x/ClwVOVfz5AqeWkz
         pzS2MzI18iUrkQ3DtvSEmHysRqqNxCcPmrub/WXuayPqhcbbob8JreTNAbtvsX8BZcjz
         1K1ufshHmC5pqQCvpd07ThSiHJROBUsPFyHXo0cau2wXmrIaXQNNG7kQU8TRdgg9NjnL
         LvScMfv+z1dsF5YQOvE9ai0m+st3sXOZ4fu524MOlUSVThFj+X08qrazgd+Yu08sqFZA
         6X+KhCEOkfeDmXLSgEP0XlQga5Z6Rjo802XUHiIAkgrTldvEL094uxu3dYHIIRL5+IZM
         6jDA==
X-Gm-Message-State: AOJu0YyfYNMH4wFEijfbkHO8JTCH3RrZLkTgJvSb3/MaKvAzCVpiAU4F
	u76yvBPQw1tYJglgeRLHvJwObEEEJtQhVVohRppAaO6ZIbsYoM/j
X-Gm-Gg: ASbGncv5jmZtXEOo1fy0bLeok9TJAv/89deI4tZ2EYYVH6f8eeJXRmDSpkF2qllYRlP
	wA9lXKbBn6zkZMUoXb0aQWK0K551tb6aRBTq4Mh1Uf9SDHmORuLO40QhEg9si31bg6tEiR08vZx
	5mRWNeuG+mnhw1e/MbIhD9OgD8cgc1oVXfkllO9c1wObJoKJ6DxVej/g3/7lS0Xyb+5ppoXhjs2
	kSpw6hz+NPGEedBK1XzA4wAIY1dWstmeRLHFIszkxRv1w==
X-Google-Smtp-Source: AGHT+IEBBTYKUHeOypEydpx0vB3aSEJ+GFaeBHVF4Ahou+PrsX79VTsP0oVvGKpDtqnSIV2Gc9hAyQ==
X-Received: by 2002:a17:902:e741:b0:215:50fb:ae4a with SMTP id d9443c01a7336-21550fbb41dmr56893105ad.0.1732964119084;
        Sat, 30 Nov 2024 02:55:19 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21544fd9b4dsm24281815ad.223.2024.11.30.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:55:18 -0800 (PST)
Date: Sat, 30 Nov 2024 18:55:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] Start compiling with `-Wsign-compare`
Message-ID: <Z0rvKwXh8mUikBeU@ArchLinux>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>

On Fri, Nov 29, 2024 at 02:13:21PM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> when compiling with DEVELOPER=YesPlease, we explicitly disable the
> "-Wsign-compare" warning. This is mostly because our code base is full
> of cases where we don't bother at all whether something should be signed
> or unsigned, and enabling the warning would thus cause tons of warnings
> to pop up.
> 
> Unfortunately, disabling this warning also masks real issues. There have
> been multiple CVEs in the Git project that would have been flagged by
> this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
> the vicinity of these CVEs). Furthermore, the final audit report by
> X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
> that it might be a good idea to become more strict in this context.
> 
> Now simply enabling the warning globally does not fly due to the stated
> reason above that we simply have too many sites where we use the wrong
> integer types. Instead, this patch series introduces a new macro that
> allows us to explicitly mark files that generate such warnings. Like
> this, we can adapt the codebase over time and hopefully make this class
> of vulnerabilities harder to land.
> 
> There are a couple of trivial conflicts with kn/midx-wo-the-repository,
> but I don't think it makes sense to make that a dependency of this
> sereis. Let me know in case you disagree and I'll change the base of
> this series.
> 
> Thanks!
> 
> Patrick

I have read the whole patches. Only left few comments in one patch. The
others are looking good to me.

Thanks,
Jialuo
