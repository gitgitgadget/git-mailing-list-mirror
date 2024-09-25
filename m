Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E626AE0
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289958; cv=none; b=m3vCDc3X70v8eDMEjhlJ+zQ0yP/T2g9QIpMBe8kNddDNNjQp7zXctmCV5Qg3xQxomf1C0gsAzNRuC2/R3PuiT6qyYVm/OKF+6q+z+VKjoOjVhXbJo8+VjJR5eHOQJbGGzMI9AlSHg51/ZX1WsWAkXlONq9PBEzgUUDQNHZX9FcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289958; c=relaxed/simple;
	bh=7T7OKq8Zyru0Gw9w/ZOjhGDMfdAj15aQR1Odnr1skaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUlJOgvfBFvHYpWxlxFsMios7gxg0OQcpU2mzarArzXtpDe6xN938egS+Q2Myo/GkLahMdJ3TAFSg9rlxbejuB/3xIwO6oCTVPp1PxyMO64n4W6ZARwEQGNx2JMXvFb5mHX7u3FS7EQfEmL7mrzdYNLpk84AuwIbnekzKbYvDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3g2I9ma; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3g2I9ma"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-456757d8871so759251cf.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727289956; x=1727894756; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMV+tosJMmMADlowWwKImMMdR9zp1TWGa4YapCHwiKw=;
        b=k3g2I9mahWcAMtdDrjnylpqxfu5/P2Rcfmi+5hSdLwt+1Jedkm8MWXUytQ/gKG5uLg
         qW8V83ezRTCxIWUdIiMV+2eToFkvskwRXeF38d8QLt9aP9EQO1vpmWpsczMAiQi6Ch88
         clBEthdgSzMqvC0kZOBRCzyC45Pa2qX7jluTSSipIzpa+2GPrgoSvD0E2U53WpOVUfMJ
         yztFaJnkRUCFsMthG+Ispl98SSPc4va7rXUHwYNjFaiT3cPub8vk4U73KH91EISpjWyH
         CQUAQyBgRTW9F8cC8w5f7lM/LiOnt0ktdBMuYaIq6Fn5s6yAfnX6F2lTzpi8bHIdShge
         8fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727289956; x=1727894756;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMV+tosJMmMADlowWwKImMMdR9zp1TWGa4YapCHwiKw=;
        b=Ri+aMvw/E8xqavAiTWDPjnVv/5Gl5rdNw4Vod098mY+sjF3KOjpdJVmgkWiEGuIyaX
         2jpW+DtCNGZWQ5lOm35Tu/bwEMPUzCiSyX0BWrATluOTGSfo4aej+COD+3gkDeTQeSKn
         kQ9YuO6eU3guD+FtybdtVJ7MHVP572i1rpq1FzigVxT2HfAnKe/ve/u6/Qqc7RD/cNur
         9Gr9Yk9QESX1RbASUk4PjIuoiNm7JnQnc6Rn30mDBMkbU5e0X+Tc2r9ohHku4qtuyeRz
         nBUbsNlI24w2BRt/hCvoPofn9uz38DrPOdSFC6wFvJzTS9Em1XxQEUkFdTvJPtPMT/7U
         QH9w==
X-Forwarded-Encrypted: i=1; AJvYcCWx0khp33hz1UfjD3USLKjHXQ/fY4txcJCEE+PIwGNnFheH4EJNcNDTUnsj29CcTOtR9sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatmXLUeyJTNfjbaJahbEmcOO35GNjmvf3awHqE0W1QpPLkdSX
	PJdJS3/JH0nFcKcHPTVeQwV011WwGfy4LtbrOpfuW8w0nnWFMhThU4CPxQ==
X-Google-Smtp-Source: AGHT+IEuawiziu5AZZEULpKk5CnqnrClAbHFQPhIzKsdNqu9vIMz9iwTPVSPJHzACVIT83UQlov0uQ==
X-Received: by 2002:a05:622a:d4:b0:458:27f4:5e1f with SMTP id d75a77b69052e-45b5dedea7dmr52414171cf.18.1727289955910;
        Wed, 25 Sep 2024 11:45:55 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-l.epic.com. [199.204.56.217])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b52544854sm18493521cf.6.2024.09.25.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:45:55 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Ron Ziroby Romero <ziroby@gmail.com>,  git@vger.kernel.org
Subject: Re: Pretty output in JSON format
In-Reply-To: <ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net> (brian m.
	carlson's message of "Tue, 24 Sep 2024 22:06:45 +0000")
References: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
	<ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net>
Date: Wed, 25 Sep 2024 13:45:54 -0500
Message-ID: <m0r097mv19.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-09-24 at 21:52:35, Ron Ziroby Romero wrote:
>> What do y'all think?
>
> I think this is ultimately a bad idea.  JSON requires that the output be
> UTF-8, but Git processes a large amount of data, including file names,
> ref names, commit messages, author and committer identities, diff
> output, and other file contents, that are not restricted to UTF-8.

This strikes me with a little bit of 'perfect as the enemy of good'
here. I'm sure there are ways to signal an encoding failure. I would,
however, caution against trying to provide diff output in JSON. That
just seems... odd. Maybe base64 it first? (I don't know -- I just
struggle to see the use-case here.)

> However, if you were interested in CBOR output, which isn't
> human-readable but is capable of handling byte strings, then I don't
> see a problem. CBOR is used in FIDO2 and a variety of other protocols
> and is interoperable, so it should be a fine choice here.

CBOR would certainly solve the byte stream problem, but I think it would
primarily be only useful for 'serious' toolsmiths that need to handle
wildly unpredictable data. For most uses, JSON would get the job done.

>> What do y'all think?
As with all things, I'd suggest you draw up a more formal proposal of
exactly how this would work, and then that proposal can be discussed.
How would you use this option? What would its behavior be? What's in
scope? What's _not_ in scope? :-)

-- 
Sean Allred
