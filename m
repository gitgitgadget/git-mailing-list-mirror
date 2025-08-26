Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C5149C6F
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239640; cv=none; b=aKoQA7ZOl1m5r5bu5+OZ/ECqwSLCb9+tRTsRDvpJqn/w46MNB8j31/8awBHK2zzk0KWwMycxUyCW5Gkqm79nrQTUYEJfezFFcc6uB0SBBDKzOAx/QnRD6kEOpd9Zl7Xsj9C7srWcfHctOo495y3RJh56QpAvzOTpqVSkuQY2m/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239640; c=relaxed/simple;
	bh=DrRz1mOTq+7T+jS27H1ZrbzNC8snXfX6WgTVy2gNqpo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FuEY+tfHJWDdgTqtH+auo3V17H8grPf+uhvnvtonuFJeUP/9ce8MRTFx4uwyv75ytHgttV4XIS0CwfgvSvq15uCcWF70jwGR95lMVeWfAsIdqQjPL0leoA37c9RaR3urYcxma4mAYc/R97Pxz8nQf8GQpOdb0sJSCNAuTXXZgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeKCD+Al; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeKCD+Al"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771e15ce64eso2091369b3a.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756239638; x=1756844438; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrRz1mOTq+7T+jS27H1ZrbzNC8snXfX6WgTVy2gNqpo=;
        b=JeKCD+Al8/d+w5/aW2dIlnYyFzwnZs48KgTJG5XQMd5a6tRHRTyAi5isIa7CKtW06l
         hwboA77RN5IsErQTrUT/im285PpGGpRvFEzn/51fjzogFivHT976T5mQ7B95N1cjRSGY
         ud/5hrPu4VgdS4ef03PywFWNfrvdpW5sTJIDksR3bazRpjqVf6OQPbSpbZftpwyEeDLF
         IKMhyvLyjrIOYP0t9olB5iQVdMa2qvZKXV4eVJuKfqjClgDHRfnwlcDECKoRJZ3sWDes
         rC4cUEU1gD+0g/qyp173eUN5b/l8qv8mVvFr3/fGZ8CVTpGMCnBQAX2tOYJI7kPkDNTA
         gayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756239638; x=1756844438;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrRz1mOTq+7T+jS27H1ZrbzNC8snXfX6WgTVy2gNqpo=;
        b=h5mPhSIzerOxDXqBIglv+u5ndlkJahxmpHNdckUJpK5J3buR/TOxrp6+D6QuovuNbg
         vFVH0Hn3Bd9necObhwGYiNwCH4MI21cEw7QMdDpidoLjMXgapKCpIQ2Q2rde2D6GV5v0
         qvODmUKdHpZPREFTC8Hz4ce5seWTObESmm7B5/m6xz6pIOCVAFIx7NF9+bkkYlMiAIBQ
         gq7SvyiSV+hugZKkOR1004AkULeYHjWFOwdXFiUB1+syOgwB2x0y64eeHzfVim450OrB
         MPaZQGXkSDv+Tn2YBpnVZ9FGWgiJpC6DzDS1QYpILGUvV7JCimTe/xlrPjJCJYVp70sV
         CAlQ==
X-Gm-Message-State: AOJu0Yy/itgH0gdk7GltsxN0fNAeIHYGeAHPabn33qGTG1Q/YnhqRf8z
	kv9QWxbV8mJYUFKHLrkXIHe03QAlS2Wse4Xks5Jf2pjk5FF2NPC0HW1Toq3MRA==
X-Gm-Gg: ASbGncsQ2uZVeXTLBAIf1NiiYJOq2bAYX/k8OhyBxZiX8+wXcJx1qX5xOpLM5Kjnnk/
	Bgss43iGMarNdGHX08iROTw/4Si3932XVvRZ0GmCp43wGCfpgfxC/m62xZXRitjBm7X9+xkadb0
	3oEGB1hL7lOMiNsXyKhzDsj7BhZI+3Q85tao1A+8rkDN8Q1vCnlrYYRbATs34T4gsou9EJNvZPG
	0dNJRJ+Dt3Mk90ACwd7e0TTYGBiD7MGUBuwpHzxvGqkA4vnPyfji55WlRhIBSaBMO9EqmMDg5zM
	+GxR7TzUl65ToftnJRKpVfUcBQI6mko8eJEUjjOecLavrTK9tOWfWQu8iA83ofOumgiZY+DKkbt
	fd+pptjwoy60UlOMw10/AkQXIrBIQkQANnqlVDS/B07LdptmNgk68BqrM
X-Google-Smtp-Source: AGHT+IGdrZYIPRqsUTKjcGYHE9Ja/JWQSTi8Q1JmCKC3VsxvvGx/emYtCWXHy7wYJlZ5X1gEBUa3rQ==
X-Received: by 2002:a05:6a20:a110:b0:240:763:797e with SMTP id adf61e73a8af0-24340b8a6a0mr25666798637.25.1756239638062;
        Tue, 26 Aug 2025 13:20:38 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401adf58sm11250935b3a.71.2025.08.26.13.20.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 13:20:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 12)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Tue, 26 Aug 2025 17:20:24 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <75130C2B-A3F2-4614-B790-6FD5CBA4E8A5@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)

Hi!

Here's the 12th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-12-ago-18th--ago-25th
