Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FC263C7F
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039212; cv=none; b=fujpC3GdDGs1SBWuApaOX0o4Bl+IvFLIyrc9deEEMWMNfffcI2hWyaLvou7cWg5Jyy+ftiqxSZZ/tzKex9looGG71FmS1I9Ovby6KWpnJbCJEZRYRROlwDeJX5uLKPP/oc6P9gIv2jA4L2ndJx371zacY/NaB9PtXgHZC6tRayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039212; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZokXWlj+8YjnNLA4RDSH60GIXiuKcIlCt53ol9HYKaQS0S0JQMQjf6AqXQEdZ6p8TWRVN0SI3PV+h3c/NJl9f1w+VbFbwVcFmTJqJGLu+riD0E3/9PEbK2F/Pfkg/blH5Xz/E/+T31vmOnod+VQSm0JvZcEgXwV+5OH93b+xjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJXSQBZW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJXSQBZW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso247130a12.2
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039210; x=1746644010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=kJXSQBZWw/vMmQgflKHTSoCVvFrHpJwz34J2kJHXHZ0/b2lUumlvqmXtVQ0Ttk9ETG
         BMJQASnWrliUyNqBfdoUUPYorgSIfvjU8qf3kDJDZG8/B0ed6VWuiEKdD7IXwhm1wV2z
         sWX/nUyr/l67y1dRJFeyxRruo/0OpziYSbt5zRPbSEq8nhBO2grAgC5gA6BAIN6fX293
         r6Nqoz9JRKbw0oj9l7g5/iPO1LHdgHP9ibA777WNEWYPOMGu7LUotC96BDXAhGa99nmz
         lZFhPaSGWEyK7HSU8pRV+cn8ntIF4xhVm24h1MZyrOvtJQUXsAOWa0UmEQExcI8VTOSG
         8GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039210; x=1746644010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=a4z3Imc9h82G1P6B8e0vlH5CqBvUkqSx7H2xuQXlwKYjOhhzZzaghl/BFs9APqOWDH
         tFuI5x9Cb1xOPujCeATKFwNg0AIBCuXcrZZBHLhmm/cGa5pPcfebOmDtprp9VkxnHO04
         4YDKo/RTyzJx13c2ZQMTtN/vKmCbRgmuFCh9pYc3AfCieswU5MihE9x8ZDtvXDMc9fOI
         czC5TObFB9uahljfg7g9NuVQuRS1ByAzNPsM1GNfRXFBt2VwK6SAzaL4YwzuPuDZxA/N
         qmf2e1hjOBLrtV5fIupSaThedI3ENisnZBbY2wkNop7gdUj3UkF9JVTHIbfcBZxavcxf
         vAmA==
X-Gm-Message-State: AOJu0YxaFecxbjbrCpPKLKRE6LYRcGNMadz7502nbYGNBFiXdNhLTqWA
	koLIxE5QVlTPYkhTWZOUTeaJT5ItvIrQRbAcIcX8Is8NnKCXOErLNrIyKH+S
X-Gm-Gg: ASbGncvBSluSHhT230PI7ArDV36cQ2tu281sonEzOWOXk2j+cx4x2f394Vlg9Q6E0Yb
	0DW0v3fqF+hwzqxj1IvFqIm9av8n1RwPRaHbuQTbTF86iDqzqBVVLm4+WnnOVGPq0cVYepk0Mu+
	m/nXUkLVvm4SFLZbhfQpvcbbzbT+WtFJgsOv4iqz/TDh/WTNLdJh47CJKthtk1acsdsVPOvEbbw
	7ZznyOBQTgnYRgHyPZQPrS4TdMntiEfeEX6+F8XdqOxqxB2IozkRP7jaN0O7Kd0RiWaHIp31Uju
	o+ogK/xq9b1kNd7s97SSJk6owrpP1qHEXjYVxnLXEEmWlnBrV5sBPE565nEYHOQpZ5jrGaI9P/5
	yFMC7FGk=
X-Google-Smtp-Source: AGHT+IFgJ6C69C/2RLKN2MBEFnmJYROnU1Q7xFrbwl5kSxAVQxSbqAfgoeFWGqah/Py8VRc2vCXkWg==
X-Received: by 2002:a05:6a20:d526:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-20aa26d41b1mr5581574637.7.1746039210233;
        Wed, 30 Apr 2025 11:53:30 -0700 (PDT)
Received: from occam.ucdavis.edu (campus-079-147.ucdavis.edu. [168.150.79.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f45b1sm11142958a12.1.2025.04.30.11.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:53:29 -0700 (PDT)
From: Jake Roggenbuck <jakeroggenbuck2@gmail.com>
To: jakeroggenbuck2@gmail.com
Cc: git@vger.kernel.org,
	roggenbuckjake@gmail.com
Subject: Re: [PATCH 1/1] Exit on invalid diff status of diff_filepair
Date: Wed, 30 Apr 2025 11:50:38 -0700
Message-ID: <20250430185309.11197-2-jakeroggenbuck2@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250430185309.11197-1-jakeroggenbuck2@gmail.com>
References: <20250108060151.7218-2-jakeroggenbuck2@gmail.com>
 <20250430185309.11197-1-jakeroggenbuck2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

