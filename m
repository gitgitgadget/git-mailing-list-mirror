Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107019E7D0
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801324; cv=none; b=rVMZgEFzF1JfpSVl7R84nYoqGNxZcjMu08ss7cgqiZJ+KFfVLImYVvAHnjBrLSG/JK1DHy3pr+CHxnxGVrGsw6kQYWcRcURDuHOauUBmIC4OaDMd+ijYgL0WmxeBNpU0mSEqFJWDXoX3GoTbgQx8nYuPSjR3mhs+deupiToaMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801324; c=relaxed/simple;
	bh=W1SoyCHTMw69MjF6ROJ9q7DFtkuIJ3Lcv24Zlr/GPLs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZB4MLD7OKKCLMmeKIqvm2r1NvXU4tfczBHo/0YSIUrHgphF6l4lSKtYS/6hYYKnNKFToZkOHQOAaF52jyH0YrJhPgAr7EYuHfdTSVNnfG+C1uhXpaF3jid1/uLKvQpFF2XL6DvhVarHR5YlG7hQl4uoosTWJLadev5lvupjSnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/5OaYH5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/5OaYH5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4810508a12.2
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753801322; x=1754406122; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1SoyCHTMw69MjF6ROJ9q7DFtkuIJ3Lcv24Zlr/GPLs=;
        b=O/5OaYH5unE29valY8NR/X+1A+6Xnjr2GcvCI/u2INHXm+Ds6UKGEmKLSgiaTTCCvV
         w0S3kSUziOpu3m+oLiEBIIiICwF5wNobJn2yltMD9+FjAG8bgFTwwQgJ7U/7vwm2ImZT
         svKUt6w2a4JlRVl668V3WLvgKsX223JXmYfhDcYYvS5XI5pAjehBQESDyUWkV7YRbLsM
         StZT03oHENQDoaQ1FSM8JbLvGrb+eWss0+QP9LM1gDXzM9CY3wITpW+gvMwARMe5x4Yz
         QX9WILJgngDrL2pm0w8+norhxaWfEcE5ees1uywcyR17aPIaD7EK/aJVMhG5L2PvHY24
         815A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801322; x=1754406122;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1SoyCHTMw69MjF6ROJ9q7DFtkuIJ3Lcv24Zlr/GPLs=;
        b=MPuvvVMbntpEJ6xiS+FlNcia34bAfQ7j0WqVZ+l5PDYytPxmKsOUFHkZbbMQTjCpZk
         MnNYwwEddhg6n+DnKxF3IvDTKaGpvyBa9qikk2HwH/5PEQRpfu3m0Enl3A80bjXus73d
         JOWrJp673I7jNRA4MY1MBf3L+wDG/dbvgILUFheEyDn8EUhSCgbv+5Zic/7k1AosKV1l
         PrzPyoENDars64R6h9tdCakiw+gIGb4kYeA2XqUKNk7AhZ0Q3jNXqV3VUPbtaQkZQORR
         y6GjxUZRx1NqWMKhBq43B7OzBnlETpUbQLUCRGNpDvtukGJWduURyzMEp/HoYrCDbcvs
         sBgQ==
X-Gm-Message-State: AOJu0YwP6I5+hiphzi90PDa7efp2ytEDnuCzHjI6eSAr/8S3J2Gndk77
	beIiH96tDOJATYbUaPbp+xqU6EGtZjINzwPWoOaJI2Kg+L3sa117spz8furiq7T3
X-Gm-Gg: ASbGncvKHQrhEkSoRIKQVkpMpiDaei2QbpseXrXcM/m/vxfyAJGGkxMy6qsroxYV5XF
	2slh9XS2Ri8xW4dXvj6kNO+UJXbjAFxJ36Bxq0E2CHeYAG8RMBdOrk9cEWUE8/v7eLMXyQliY2r
	pTIIGUn/H9nG9c4lkk6Y2wtRG5uaHj0eJHkFWhzCYvaNLPd2Z/MEbtgJA515zlPuidUGa1VrqZh
	5uoQD/CLrL1F/xA66SRnYUGXQ+pYLEGuCbw2Vlu9QstTE3rY+VmDeoVBi8UU+J6IyDDxJ7leunP
	PwmCj0xdu4dqY1dQ5umLbfrJiXM8F24lOQUP2dYar2yV68XrHrer2IhTWNuS0PS9KySgsvuaA7w
	xtNeDluSidrfq8JSHuDuI0gLNUhSa3fKvs4DhpfmxTfimRyvD4Mt/Ror0
X-Google-Smtp-Source: AGHT+IG0HczFqnMjDj+mKpaZhsnTZ22gbQbuTDWh5uK3qDU1r2j+jwROoVGD8Z7SvXQq9orxkq3rwg==
X-Received: by 2002:a05:6a20:244c:b0:21f:5aa1:3124 with SMTP id adf61e73a8af0-23d70048cdcmr27016791637.13.1753801320435;
        Tue, 29 Jul 2025 08:02:00 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403f4dbd1bsm39243665ad.59.2025.07.29.08.01.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2025 08:02:00 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 8)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Tue, 29 Jul 2025 12:01:46 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <33D8C1F9-2217-4924-B6C3-DB230B16C11F@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

Here's the 8th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-8-jul-21th--jul-27th

