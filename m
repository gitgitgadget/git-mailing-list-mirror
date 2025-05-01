Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997041A0728
	for <git@vger.kernel.org>; Thu,  1 May 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116983; cv=none; b=G/8KD60XIvSeDH0tjU+12Xh2/HGsP7AF+U3oVvtJeVoJx+ay9W/xrAd7sAZuBPDvupK/DvKwxfXR9M9fDAuB9AadnXo8CtYbLnCah21MDkR2NVNywnD+CaOHgAIcStkp6Wj1HjV858PPmAGiJd3PrSGz9lWaekI02/8m4540Yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116983; c=relaxed/simple;
	bh=ors5z66BCI6eICxYuSYeGmgLpWFeCs9PYB46SL9OzjA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AUp3Z5xGxxGTyC0mWfU1zsu6BsnPFsQHvZwiBP//B8maKP4HpSKETjvcR7KKHkO7Z7uvX8iEsIyQ7NCix4lD5temgKLVtgj+S2nZif11efRrIgF7aVM0acxztB8uRzSc5wjjZhMxJ72MJM+amhuOElr/6+bcqqN+o+L3KvRABN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWsc61OE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWsc61OE"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af5085f7861so854409a12.3
        for <git@vger.kernel.org>; Thu, 01 May 2025 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746116981; x=1746721781; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ors5z66BCI6eICxYuSYeGmgLpWFeCs9PYB46SL9OzjA=;
        b=QWsc61OEt3tWbONOVhJZsZxeFu0/pDqzWDhbegP0H/vTvWXEHvnaJfh3x70DyQmCXH
         XTm0U19T3R016BO7t/8Y0xlZ9hyJft35rxyOxShRp5w7vSySML3FxY4a8RRXtnqnjO5n
         MElURM9NJ2UosT+pBmNElLX7jyWVYEcviCWxOw/XSradZopM9/gxJ4rnTGaM3V5jg+73
         TvhgX+uj9VHnwnbhhYVEgIRCvZv5kJoRoq2Y+j0NE4C0MIA+Ir2sJfkPmjr3ya97rOxL
         Hjt+Bq8t4usETfuMzihvsaFMOyodpnvSTphP2Sct7FyvC/1xlRl1DEsu0ndZfBqEx8h5
         VL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746116981; x=1746721781;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ors5z66BCI6eICxYuSYeGmgLpWFeCs9PYB46SL9OzjA=;
        b=sXt+acE70HIW4QCxB44vSibeF4A2/v+C3A9F1Oyk40jvsU9n8ez+d66NeG/ote9pDJ
         hg9L35RYxCw6V/CR7TlapQhDH+SSg5n8+5JYX0E/IbIckmBibkUzEIELoQ8qdcBmMnXT
         RSn+jlO8rdNNxg1mpq1WYkveKJu2XVoCH/gM7H+hTfDTDLptGYtcvh8a2JYSYiO+exrg
         NHk25/Mcv+FGlFsH+kiLaLHLZeNFHKrjS4AZfQY2Wy7Aj7ySXvC4tZTBgTmf/c0dS8++
         G13SB8nlQW5BjfGld6lHxSeUeI8sUCwmc2rFM06oGcTx+QtQ9hLJOGJMski3Bn5O4WVy
         FgvA==
X-Gm-Message-State: AOJu0YwKSTkd/NRJulsFAb1BaJpJSQfQmNL2EZNayFVJ6I3EHP5nqt8X
	23r+pHj81F9jgSWoKFEqTJT5BB5vvvuzTnNoiyLShWAXb4Q8heOYmMVtRCeB
X-Gm-Gg: ASbGncsm4lYAxilu2UWscq1ytIMs8A6ARed49s5MBiI44kM9QKAHtbSVV4kvlv83RPD
	cPCTbbmMcaBAg9pgud6QvgFxZCpaFYVMvpSkLu/CSoILioy3E6GW7++jrOIVwwruThWnY14LVSj
	tmyvg5zCkLPb83S2kpWOECWwFy0K0FpwfQOVrHxQJTATnTa29DyYxIy6/pb3OY/SwSLFp77QgL+
	kjctnwXPcVvQ67RE3E2BaDyQWR2c+QdLaZDCLtipMSlmnaZJ+CrTlqB9QZW0krk4E3d8u3YgLol
	H+wxt/JplqnFAleeXJiQHYzXO2fS9Qff/OTawWYOTEAn+vU5jxhoi0PM3dEuoRw9
X-Google-Smtp-Source: AGHT+IFxrejGF7ZjXxz7YFp+GKwn621KtQIFphZA3sVOeLbtM7VuYh6GJFsJ6/dhbgYkfQ97rFhimw==
X-Received: by 2002:a05:6a21:350d:b0:1f5:79c4:5da2 with SMTP id adf61e73a8af0-20aa4182f30mr11478980637.31.1746116980753;
        Thu, 01 May 2025 09:29:40 -0700 (PDT)
Received: from smtpclient.apple ([189.62.149.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7404eeb1a67sm1006420b3a.25.2025.05.01.09.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2025 09:29:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Draft of Git Rev News edition 122
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAP8UFD3b8as+Qk8=TQACdXqCpNXxFtW15m4G76=r-WzsE3QbkQ@mail.gmail.com>
Date: Thu, 1 May 2025 13:29:23 -0300
Cc: git <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 Jakub Narebski <jnareb@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
 Taylor Blau <me@ttaylorr.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Barkalow <barkalow@iabervon.org>,
 Catalin Marinas <catalin.marinas@gmail.com>,
 Martin Langhoff <martin.langhoff@gmail.com>,
 Darrin Thompson <darrint@progeny.com>,
 Patrick Steinhardt <ps@pks.im>,
 Scott Chacon <schacon@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E1A9D11F-D9AD-4AF8-A17B-29324D68F3BD@gmail.com>
References: <CAP8UFD3b8as+Qk8=TQACdXqCpNXxFtW15m4G76=r-WzsE3QbkQ@mail.gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi, Christian!

I'm really happy that the Git re-written in Haskell somehow was mentioned in
this edition! I wrote that just for fun some years ago and I wouldn't think
that it would be mentioned here!

Thanks!
