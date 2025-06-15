Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F0262FF0
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750023012; cv=none; b=Q+iLgsCOltI7/zr45c5B0KTks2/kSPgSvct9RxSaEP9IFZ+XyMV00nwEspFGfeE66XDHv5QSUMvRe6Oz779AitYIfW7Nsg+uVk/Qu9G513alUHJhtoh5Hi9w4atVWBNZXCtWYEDEUKqj92kTmGMVq9wm5tT8tdh/MVuE+nmQU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750023012; c=relaxed/simple;
	bh=ayCr6JwQT4hohRSHtx8E12GKDnQ+9BiRJvbiRLdvaR4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FrZUzxnP8iWYew9hoGtCweMZc1Mex/yvkcB85IN7hNLuVSReS1I0CUIYWOB17T/jnoYHHWmOVsBWn3yn8wyrSMHaZP5WcPqdHhAFaFRLkECF+v4wWxI/wiBkRRq0TSTFkgiNBgrfZzpIAlcOOykfEWXN2Iqz+ScHLE38yo5n6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEYXjZ8f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEYXjZ8f"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23526264386so36733795ad.2
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750023010; x=1750627810; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayCr6JwQT4hohRSHtx8E12GKDnQ+9BiRJvbiRLdvaR4=;
        b=MEYXjZ8fEgA/YVJ9x0Xnb++mi7qtVe8HAMADkOaz7gV26RgP44QzyDKVtLpB5jG+UC
         S3si8U6atMO/KKLmAOaHeS/kre1g+bHFmEfXbSzm5XCHsxZo6ZcCWl0kZQwnyDVQoqEC
         DTo6kBC3CuF4DG1WOFUg6BXueT2LRLYUpFsHWRJLpjCBkMWYp0ipnxf0XYnnC735d1G/
         mUUEUKDbs0cboFmBkfD+layF1pX2TMkIQ9a68OjifxJXSaqYQ9R1Rj0oQ9WS/vIygGr9
         mvFQqvCA1oy9xPrtdJvUNach6tw87e1dl8A5oB3SO6jZipGdob/Be3mxSZukC829FOGv
         mXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750023010; x=1750627810;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayCr6JwQT4hohRSHtx8E12GKDnQ+9BiRJvbiRLdvaR4=;
        b=Xvy4cH6LBTm0WwZD1jsKGGbP4JJPGIUdv5qNFnoqS2Ho3Y8yDacG/KWQLzss/FFmGa
         mOPvOMJ5mg6KlcFo0jbpmmEkh84guTslki6UZKJXvK3pUsV18M+EMjafQH6/R3So66tI
         abx2PzfCSruXyRnpM93Qr3QED5YjbqNujtZFAfx0J+2zj8eugwlV7hnUKW2gg/SVS1ah
         XbfgTh2JX2Rd0WcBT4Q6Y9IdVCPn9GDIbc8dRp8doIGY9WEtSWUCfvh1KaqlSP5sMqE6
         VdVwAcrvpzJUOKvnMKbLdw+Sb0AqvBYWBvXp0wq6MJBaTQiJs+f5N8mjofJ48Y0gfGye
         F1iA==
X-Gm-Message-State: AOJu0YxpByTTwpSmEPwh91COg56PCGfK11jBVmVUZcVqI10HF4nDG6zV
	1Gn8JfKIcVY9fYQ3ge4aySyPoxlO4XCKAOCB8j+3xo+GE+kvZrioSZcqa4eHYw==
X-Gm-Gg: ASbGncvM+DjpzIPxGBY28tM+3NObHkC7m7J6Rg4tOFrZR5o8uIyZQKtkP0EvVdtx+GA
	I+e0l1qVy//d77ztz3JuwPgnaPy5iOFGLckAvz7d0yhGZPXcz8FrzdMwxTF5NVJa4o+zNW9Mfi1
	oCBIYtqNs2RzokMAP7EZ4xx2KjLXSslZdU1BXWbaNaMuGmMOJWHHNlT6fR2ckFcRPgx8tr3MVuh
	TCZVo8/wePiSIYThQjK/zwi9HAnevlMjuIYp1XualdnBcbT0Ye8+l+2u1X8kMhzfIs6V7GO6rh/
	dniau+mIrB8+DSTpSjtbQwrw4ZFUkBzZKeERmBkPaOngTJMTCp+25oD3rJWGLxwzAIky7TzpI0g
	jbMQN1lSakf3f
X-Google-Smtp-Source: AGHT+IGj4je9GNTN6xJc2KPN5JFdQZpBSajJtTcqxh8AqbVi9E4NpXcndnQKMHU2IiuQ8+vc/Ly7Gg==
X-Received: by 2002:a17:903:124a:b0:235:f3e6:467f with SMTP id d9443c01a7336-2366b3138e6mr108754575ad.2.1750023009956;
        Sun, 15 Jun 2025 14:30:09 -0700 (PDT)
Received: from smtpclient.apple ([177.76.102.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89387sm48218875ad.121.2025.06.15.14.30.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jun 2025 14:30:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CE4644B2-3FCF-47D2-B869-8926BD58A8AE@gmail.com>
Date: Sun, 15 Jun 2025 18:29:54 -0300
Cc: git <git@vger.kernel.org>,
 Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DE467BC-8846-4F94-BBA2-3E5ECA2AE6B3@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
 <CE4644B2-3FCF-47D2-B869-8926BD58A8AE@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Just had a quick read, and one question: in the plaintext format, why =
do we drop the keys?

In this first version I following the same output format as
rev-parse, which doesn't have the keys. But this is still
under discussion and may change.

Thanks!

