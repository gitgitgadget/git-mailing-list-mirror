Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60351DF994
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778895; cv=none; b=jsVF6425pIS0g8UxPx51vG9/5CwKUsnUUxp31Dn3fWFa9e0BsNf+05H8K0V1aHBitD6DZkWoAwQO7JZJOv4bPjfzcR4IUWlHCoYI6fvyedbh12MTq0wvRtwPLXC4Ugc0uvgBmGvU5I1NiTzzw88c/508OhuAcqtO40Q+NK9xZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778895; c=relaxed/simple;
	bh=8GWnOHCzOmtyb1/C9m0vcWBqbgeCWBtfixMR6fs6JZo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lrDRTLAHw1W9nF5xkyDBlzZ6eoaggVYSvhSLz0JI3HK384fK0vWIUV7x6w2fI8wGZJBCx1yx6xM+crZxkqdAciB5+h+rbe8uvNFZpfwAC1SkE1bW1f8Hx2MPy3JiLlWjeofj33csKNN1F8HF3xG8wHXHb7/rPZbZyTU/0dUm4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDnY/Sq5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDnY/Sq5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so1720569a91.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743778893; x=1744383693; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GWnOHCzOmtyb1/C9m0vcWBqbgeCWBtfixMR6fs6JZo=;
        b=RDnY/Sq5Aov+xQi1DENfH8uQZN88Kx4NKyEeAbwHOnThW/MRpVGtQfH8ly2WP+2TOB
         gliCSvYkfDBY2vAYWYbcvecAKG22KcRFDgWc+6B0eN1k23xoNJs19Jt6S+XYSlMjBpo2
         TLLcwKiFSVa/Gh0dsOVZ0eSd+Ow/2w6JDvmctb40ORZHk6PMxlgDzbVxL4aiuEU90jSq
         /TfMPrz38APGT5g0ZYSVpBO7T/3awIqgb6f94msT6skA1+db6BdgBXkDpL6DV5EJjfnx
         3aIEUYqa0EXya96r0yoG7psJO0yxGa2wikYbsZTew5QLmHYeLEXlLPAF1Je89GxJdilP
         OL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743778893; x=1744383693;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GWnOHCzOmtyb1/C9m0vcWBqbgeCWBtfixMR6fs6JZo=;
        b=tT1r53al514C83ZBKyn1P6/cCaz2mFcDzmc+8AyoLFyBAieHeJQDrFdlHA/AmsnICH
         xN3FWZsfT7GSP8TmkGnkI7z0S4oDnsPf+tqxvEZ6XEfv17c2p2VqdOR3V1UedmuK4U/7
         pdvxXGQRjSjSprccXrKjWcSQMaFA369uymgyXbUYOm0JlkgjHzohRT+tyz/8Xaud4eaw
         UcOE2qFU4WZkMxHQC8sjlKw65Nwucd69URjDKz4Larq+8lbo405LspNsz+vAdsYhdAiR
         Bu3onnV7Qt3aW/sWKK1CDvMbU7uAyTmZblTggAQJ+pFNj7znv2B5UZ65WGPRo+RQPPve
         Qj7w==
X-Gm-Message-State: AOJu0Yyd9X6/oQVI7VdsCmZSYMM+gm/qWVC1ZIH1RlutthCA6FdTLRId
	RZs0BrLd2sNQ4FIH0dtOL5xJ4M9N9WkGCYmeu5uVMnVcazd68tr/
X-Gm-Gg: ASbGnctPfkOxogfxPP9ayESrXZJ3oeKUlqLrX89NBP0XHWiEQfesajtARqSTZgC6ipg
	7ocrMrSrPSefUy/PVVdzR6wAY6DMifAFVYISdoNXNLP/56Ab7lfzOLK0wTtCR5z/CEhvAdUrRaA
	nDYKchkyP4qSSklEbm3xdiltrruUcEo21bzdvS1AswihxFAbwC4oyoLtE4yJp8EMocNW1F6K82w
	KWhQ8qV+JYwxpCR+s+J3yXaLbaXrxhjklRUv6EdfDfU8L2EeaOb0T0CdirMWr0Tyx9UP1qNtM9Y
	Xq4wNcBQjMEZm5WStuZ4mFUccLg9EMDBLGfkTPrcrgXVeHQqsyLvEwXnZtvdLQb/W69mzu4sWw=
	=
X-Google-Smtp-Source: AGHT+IF2OZ5mSCj+smaEB5NH1PTzdRBHnwOa71R2MbZs4U0TAyTne98LFtr/q+jxu5UDmJcmxBe3VQ==
X-Received: by 2002:a17:90b:5347:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-306a4b85973mr5369582a91.33.1743778892435;
        Fri, 04 Apr 2025 08:01:32 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30562c6264esm4618621a91.1.2025.04.04.08.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Apr 2025 08:01:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC] Project Proposal: Machine-Readable Repository Information
 Query Tool
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <Z--h3rhY5XAERVHm@pks.im>
Date: Fri, 4 Apr 2025 12:01:18 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <A951AB6E-2CFD-4849-BF93-3DC34EC3637A@gmail.com>
References: <7EB151DA-0BDB-4D54-BBB8-CEE69F51F13A@gmail.com>
 <Z-5famP3CgaSfDc2@pks.im> <BC393559-6A33-447D-9AE8-BB2D9D0BC0D6@gmail.com>
 <Z--h3rhY5XAERVHm@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> So the intent of the command should be clearly defined to avoid this.

Thanks, Patrick! I'll send a more focused v2 soon.

