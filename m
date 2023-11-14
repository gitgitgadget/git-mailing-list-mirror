Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9026AE8
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="EUnl5wJr"
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C9D7
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 15:16:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2809748bdb0so859822a91.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 15:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700003816; x=1700608616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0x52gPOqHVL6yB9YMtXp+L1BB9pCMHsZ1/Rg1BmvSjo=;
        b=EUnl5wJrcEyD6tRElr1KMST6eqWKkivfUbuT71i4mnJNiZYJWFNa9OzKb9c1eaZKUx
         C+tpQuGa63aSln2AQcylkkBcOobJB6yFZXhyqVeWZ+ieDd+iBrn02edD6x3UA91HmVMK
         dPt1IBd5BxRQlXUVdkDeFQlYLIBWT8a4rf0W3bw8tSJCubLdMKYEISt3a5wFa0d1Sffk
         KAnpwglqzUYbw+Be3KQtkBNIHajqNN/qYcDFMGJ5gAcrD0OYHmN6wI9Ad/qhQvDdtqAq
         a3CSmoe/OLTRcIrolT2B1NBQSWoQ+1WKUdTyWS9tyA2q3mifJx9UCI//uoNmCaIS64AA
         GCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700003816; x=1700608616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x52gPOqHVL6yB9YMtXp+L1BB9pCMHsZ1/Rg1BmvSjo=;
        b=arcP1QzYqnZVv072xPvyTuKTntLTZzrg219gdCJkEPIISrANb4uwtBoRee/9vnvblE
         +9DqTpN9QLBymo2nIPVwFp+83jhpJuvo4ruK8nxEsBUqFeS5IShR0iWoxhBn3sJIVM0M
         DxWH+QzVNF2XmAi1+IqwnnHfXxiw3NKl/qRomvo9mZqLZOwQBfjGHd15DIezYaUTvYbv
         O8jg1YPLuglkKX4289Z+ZFbf4lzEijcmlE1s3ge4sFtXxRpj3CPz90vh9534cX3DvMed
         xNQH1iL0p9suzcQ/47VLaTbB51wN+ydmAjqNNFjQsCqTvNsjRrVJklxZSVr5jfRvav+h
         6OYQ==
X-Gm-Message-State: AOJu0YzCggspPQfK/xCOArKPD1Mc3d0U1Zv4Pu2DQBeeI0se4ZOo6sd6
	SaBBAiRoaSo4Xe8OnUD08qQWeMHxMY5JFN7AsD0yAg==
X-Google-Smtp-Source: AGHT+IGfSOtUuJOxw0annLuEImxMniWB+R7SAJ4TgpCWnwYAFr8bOYPNd3/39TPu1CHm78CQk2HhQEDAcwZCagY480o=
X-Received: by 2002:a17:90b:3544:b0:281:291:a6e4 with SMTP id
 lt4-20020a17090b354400b002810291a6e4mr3555250pjb.1.1700003816329; Tue, 14 Nov
 2023 15:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
 <20231113212243.1495815-1-jonathantanmy@google.com>
In-Reply-To: <20231113212243.1495815-1-jonathantanmy@google.com>
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
Date: Wed, 15 Nov 2023 00:16:45 +0100
Message-ID: <CAGE_+C5PrqgMiyrJCSzb12ukihad5QHpwtUSpTXVbsiNWBgYuA@mail.gmail.com>
Subject: Re: [PATCH] remote-curl: avoid hang if curl asks for more data after eof
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

Thank you for the comments,

> Yes, please split non-functional changes into a separate commit
> (preferably one for each concern). I do envision reviewers saying "let's
> put patches X, Y, and Z in, but not patches A, B, and C", so splitting
> would make it easier to decide what's worthwhile to have.

Sure, will do
