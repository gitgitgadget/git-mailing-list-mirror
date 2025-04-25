Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734118C337
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598177; cv=none; b=loSSIe2n144Mf7GTonUWZ4gLl7bMv5c532OMI/Rbn4fxBG3hmVTFuAirb+cvSW4NMuRfEqJ54tK/wDGTFcW+tCADhh3tv7D4rIDtoNmm4q0esBuYa1f41O888LMiV7TuezS0cdkLGptZrDzY/ec0+803S+9tknyymMvqpvrpPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598177; c=relaxed/simple;
	bh=s0Cvt2u7aPzUHhyUkuxluFFVr2JCP0C2FMVkADTJ+Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sk0sAQooe9ByS6+RBOMjHh25Zd1yoGvQ57rmeoKCTECERLxYHHbFj71i0c+YtuinYWmaUZHzApeiQ6qMckJOk9SrOUO620+hPTyExThKo9GqDZvL3X4ztYFOlMt3UQI38ncYz4FMoBtfqZCf4iAYPgyPSflcwGO/jykfHoR1aLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9njcfjO; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9njcfjO"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d377306ddso1036354241.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745598174; x=1746202974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dRkA1/E5+82JfPjeXCZPcTlNHzpQOeITurHqNUqYZWw=;
        b=J9njcfjOxc1W4iyKVWny+qsfUY7g3VIXxPObPd5Tn/zLjFng0LpJSBWxp6O1L3gHaG
         tDnYzkAjRYkWJRaoYXgE5RuSwgDRpvlu+ZtA5PMaTIMrWcafn2SST+RigaqGhDFKoji/
         YOKa0YYRqB4+KxYgzXMjOHkeau1ufE/QQrHgM+GMj0OU2d1ezCqjIdGIqgeW9F1Vt0cZ
         wpNGF0kEo0eDIM/QcXsvKEg6RNO6vNaCoRhoiprytL9AO15KEK5NkJLoVESEF1yg4T3w
         cAgYDFDx/iSrDiJQqwMKrNmt6P8y6TMUZWjyKO0CvwFi9DuFP56j3+5eMeE/NndZhDds
         oLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745598174; x=1746202974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRkA1/E5+82JfPjeXCZPcTlNHzpQOeITurHqNUqYZWw=;
        b=caMCwbI68LbLm+mQhgi9+fEUTuhtW51dsBuHO+jIfKw/b1+HYeV7Qfq7Rv6fgoT30g
         dcHdMrWIx+YvRa5Ra4XKwj/GEXxZQIk3g3kVg/Jf7YuM0s6s29jXFDNL69Wi9F2dh5N/
         4X1QlJS9XrLQbcETpgK7mGrh+pvTKwtySmS2QVCthHnTys3TibgvcyqIhlyMOYEUlTXM
         1IYQQK92PFCFC2P78gUxbIlypUK66CBrjJnqha1q+BINiaYH/uGtKOXLUCWsWfxSciEJ
         p+H7k4YDxjFZjiY4qCOFTQCfRLRHYgyxi9C5rhHCIZ0VEapfR6AQIfeAtwtzh2SiIHSs
         qgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCURva6gScTc7d9GQ/Iormc572w0BXjmrPSPX4G9/mLhfK5HqHNT2mPmI0jm2sp1cm2MqpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRQjkoO7XDRFyHJboZoZPyL6jOmiVVYobPcseKHDKR4v+JGnM
	kKO7a5JtW2o3mrkHs6NSGPoNY0NrbhDXykMKBtIYrR+btUyQFFTctckJqyZ4RlJlCOzAc0Zua+W
	oAVA5bPpLM7IAbtnQSWtVlnjUDA==
X-Gm-Gg: ASbGncvAKpT7GhepWeB+g2DL6iu/qGslhVtW3+nImHmgMWLXHHNbw9WEfMqAK5CAd5W
	erbp+6ucKym0CXoRwnfvn+Oz6w2ieP52eSDssMfehCsSZqTuw0hetjbaHxv+dM0tuPqutI29U8y
	666XfR7NOsqDPjBmRyP3uzlg==
X-Google-Smtp-Source: AGHT+IG0z87XG8V6gbbA0xrvBn5IKbCQzOvGpFnNpokb+8lUIbQBAcA4jd2pjbs3GhQaxvHzC8D8tH+sSCFpBN8F5X4=
X-Received: by 2002:a05:6122:8c6:b0:51f:fc9d:875d with SMTP id
 71dfb90a1353d-52a89f18430mr2119295e0c.8.1745598174470; Fri, 25 Apr 2025
 09:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D4949EF555E2A96CE745B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597D4949EF555E2A96CE745B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Erik Huelsmann <ehuels@gmail.com>
Date: Fri, 25 Apr 2025 18:22:43 +0200
X-Gm-Features: ATxdqUGhZN4WL8QFJbFADkZOaJ6Er1qYLhhsuww3eBd_tnMBFmkAvjId7aeuKGI
Message-ID: <CACOoB6irNaLLsRRf-aEsRbAmnvLJPFhDGnD0j_D9fY_ZbgAL6w@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP server
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>, 
	sandals@crustytoothpaste.net, Shengyu Qu <wiagn233@outlook.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Junio, Aditya,

>
> Authen::SASL now finally supports XOAUTH2 and OAUTHBEARER thanks to Erik
> and Julian! (Link: https://github.com/gbarr/perl-authen-sasl/commit/958a3aa165d30cf4e3cbb36dc45306de627aa13f)

And it's official: https://metacpan.org/release/EHUELS/Authen-SASL-2.1800


-- 
Bye,

Erik.

http://efficito.com -- Hosted accounting and ERP.
Robust and Flexible. No vendor lock-in.
