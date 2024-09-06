Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EC374F1
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637796; cv=none; b=s1TwoZirkNzpFPdoksrL14qz6BJFwIRcdM5WkAoaa808+Z3sIJlQ1RZ/X5SP2RVbClJipjWP82GKbOnYXQZh7yma6PmXftV8vL0BwOaKPpoUUqQtGo95UsDo5SDF/hz/Kvzl5dwqn/VdWYJpDUIio5H7vzjxSOY0cZGzJ+Bn0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637796; c=relaxed/simple;
	bh=+139RIV4Z6k9hPtY137pohymFPPNOteDXnVQlIU4RFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SE2XyxBL6XadLpK+ptzIGdX6l25OAx2JeGZ2oUzPnCTwXEJBQfwVooVf3ECThEKgVORyRQfBlCcBmdM2FD7fxkayWyHhAuzRjNlq5jC1kFWj44htLXgUOwoTiq9AcudMVhypYPWO+yFre6w+pM4hElawFVpdXCYbKnwo6FM/k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5VQ9ZGR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5VQ9ZGR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068acc8a4fso22923455ad.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725637795; x=1726242595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uel/b73RvmyUiuHBpFcOFNhMBlLOscitE4YNSYCdONE=;
        b=F5VQ9ZGR4N2Zwz3xPRA4DsMa1+ONCXWEmEZsnZUeIMlbn9riVqFaRY3lBh6NX5bROV
         /aRLputMJiCqCuiKGEegm5LkpNLeJ78lw99HLxSXyEFrEsazvAgJcR1pCbrg4hlbteiQ
         Ss2VZSmBxB9ugqEVlREL7NWhUNRNWFHZEodJBsAXQZBnnNIDX3HI/Mt/3V0gjISx5y8f
         sSyGC27i56OG9tv0gl3qkDsW0eTkrZL76dxYRk3xC9IPlR1CN42sKIi29w40p8Ne9Reu
         qiW9a5RbAvUNk74/YHFMOboFBizUigDIzu3YRojQXFQk0mFtoIbnT2DIYmirjUUXWhmX
         qIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637795; x=1726242595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uel/b73RvmyUiuHBpFcOFNhMBlLOscitE4YNSYCdONE=;
        b=GnmWpbTf1Bu5SiWvFRNflcYjNTK4P0yjdDEvkU3m8HuP+TBKGI9JsT8o47Bjv9T6Zf
         Gsi8n7HVzLDGULTjmfpkyghD0/Jz5p9Jc28k+6Sz8q1NpuTZE7wvGD4ps6FqAVS5tBSu
         Kd88CszJTYkzm/IUrzQ4QqEt33K6c43dKiybRQhLvU1vxP0RDdRy6043zpDq3S8Vwfc+
         73XbJXJGuGJln1a23wh76+pMvAZ3K5HNEqc+LaTroTY3cwK7mVKe/98jdx3h8wj0SciP
         jyzde20/4GZq2kcpzsnYnzxLFNpfLFqxcActb2P07uLPUCaK4FT1KpCHsS8HlDjI1cSN
         CW1Q==
X-Gm-Message-State: AOJu0YyyJaTxiVKVM7uiss0JOmEGPeC3kzF3mJJr2sZLSUGKnznWcJr9
	soIXE4ITLusQ3fhIMCNauhmqp+iQ+PmRIvDVswt1MqTSZO4Beuk9B4Kl3Q==
X-Google-Smtp-Source: AGHT+IE96K1gsxe1U5dHRo/RunrbYRqQRBbI1ZVu9sCpgUJpihah87pHogG7KnlxkEN+g3JKgnpm5g==
X-Received: by 2002:a17:902:ec8a:b0:205:5f36:ffb6 with SMTP id d9443c01a7336-20706fa0c57mr3074115ad.38.1725637794855;
        Fri, 06 Sep 2024 08:49:54 -0700 (PDT)
Received: from thunderbird.smith.home (ip70-162-122-51.ph.ph.cox.net. [70.162.122.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206b924710dsm41234535ad.108.2024.09.06.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:49:54 -0700 (PDT)
Received: from thunderbird.localnet (localhost [127.0.0.1])
	by thunderbird.smith.home (Postfix) with ESMTPS id DDD96196011C;
	Fri,  6 Sep 2024 08:49:53 -0700 (MST)
From: Stephen Smith <ishchis2@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Stephen Smith <ishchis2@gmail.com>
Subject: Re: [PATCH 0/1] Add entry to mailmap file
Date: Fri, 06 Sep 2024 08:49:53 -0700
Message-ID: <5909617.DvuYhMxLoT@thunderbird>
In-Reply-To: <20240906153003.110200-1-ischis2@cox.net>
References: <20240906153003.110200-1-ischis2@cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> From: "Stephen P. Smith" <ishchis2@gmail.com>
> 

I don't know why git send-email added this extra From line to the body of the 
email.  This line is not part of the file that format-patch created.

> Cox Communication quit supporting email in May. The accounts were
> moved to yahoo and I was never able to figure out a way to send an
> email that the yahoo web interface didn't modifiy in some way or I
> would have sent this patch from the old address.
> 
> I have since closed the account for cox.net.
> 
> Stephen P. Smith (1):
>   .mailmap document current address.
> 
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)




