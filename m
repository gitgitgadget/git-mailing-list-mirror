Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F554910
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638934; cv=none; b=VXMczM5qx3FksUECTJ26oErLfjFBhQFkohcm7HAhjluIdtFLPbD6CdFYljF7jEDWpe8vrQxj+YC7Y8HZ56J2TOdFWzhKDKYTXLthKq9AfHs0+dWeEXMYoc6ITPbTfGmSuFo39m6Jk89Q1EkCXYgLFJkn2Ia1QcVI0NtJPXnGbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638934; c=relaxed/simple;
	bh=7DzwxMu1tZ3jFLMw+f7DkKbeq+3vu9zQB2zBnhnl9ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVGmBOd2Gluj3dQMGkEgYV0WEQ58L0yvb0Ew9KbO01qind+uQHXB85enhzxfsWVDD5LcjYQmgMxTKVaTa4LXvpxih2995JDP4qeANwjiEq4ZzJjZIyvmEWuyqplWDcAeZMVpsrvn/uJUzTXDMTNg0fshZyFHEwjwmKq6Pw5aTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcZUred7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcZUred7"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29ab78237d2so3766721a91.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709638932; x=1710243732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DzwxMu1tZ3jFLMw+f7DkKbeq+3vu9zQB2zBnhnl9ig=;
        b=gcZUred7PigWZk7J9wqbwdQTZTjxbL6aZE0nPco2PJpplTGkexFtRgdV5lZxM93GFQ
         a9IODc8NathqaQ3/9PiNRpwciR6eW+Ri1mNe/x4768HIIn/Ohe8tBRo84NB10N7UDn15
         /Ov36MAAYMRCAmwWFlzRKw7S0NI9+YFA+EzikHjgSNwTIqNxnDdhzki8sQP/OSTwR4nE
         HPKW3CYiBllvJ8X6nhUiHkEC+dzK4bwOm9s5Z4+EzeFK539oCkyeXjUS0kXKDHpVp0by
         4myZWPdqoxr6sQnKlAlQqXUp3uFQ6HA0cTz5inOAi8uJ673D27MT/ivMnyi5MOHJ7rBy
         3jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638932; x=1710243732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DzwxMu1tZ3jFLMw+f7DkKbeq+3vu9zQB2zBnhnl9ig=;
        b=BKL0FfwiCDoFdC0eSXeib3FTOxZ2N6FlFMQPOnHgrds4vLQ+ajTKhrP2qKoo8k/PgF
         LxClzkVuIC4Fbh3KYX3LpfM/graHs1kK6kRJuSf2mmtirUWkHN8Qj2HNaGjgBfcZLuRC
         9lpGXIFBCaSH+jKdz5+CQ+y03veMmghzjhU1k5FwjskbwgkrQrVIKN+U6olHsl7L0Op9
         QLqgVgBpLTYyArHQoN6ZTxqupy5ZLeOPSaDacd7TcjHoxou2iQ42XspEh/I1FQxpapW8
         iMWia66zdWa5X/vdcSTTztPCh0lK97p4GAMx/9clWXWz5dQ8EeEeFcFw+jZ3tvY3ipY5
         K07A==
X-Gm-Message-State: AOJu0Yz0FMzkqzMd+ltJUU6Irg/8zaBTrIrk1Gke3gMliiMcaJXFh7Pe
	FtT4oIBIxNHpHD992rx5b6j0ROic6l15v5mYc45toLyZvgJ8iItmIhYDs7FoaQYS0A==
X-Google-Smtp-Source: AGHT+IEkszHbCEISfU7q0g76ErbyPsgbeJqC7OkAgw4mEn+hwtpb66/7HsY/ek33mt06OKsC5BDDgA==
X-Received: by 2002:a17:90b:513:b0:29a:e2:a75a with SMTP id r19-20020a17090b051300b0029a00e2a75amr8535648pjz.32.1709638932358;
        Tue, 05 Mar 2024 03:42:12 -0800 (PST)
Received: from ArchLinux.vdiclient.nvidia.com ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id il18-20020a17090b165200b0029b6a3e1794sm780969pjb.28.2024.03.05.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:42:11 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/1] [PATCH] t9117: prefer test_path_* helper functions
Date: Tue,  5 Mar 2024 19:42:04 +0800
Message-ID: <20240305114204.153171-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <xmqq7cihrjxj.fsf@gitster.g>
References: <xmqq7cihrjxj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Just for the next single-patch topic you'd work on, here below the
> three-dash line is where you may mention what's different between
> the previous iteration and this one, if you wanted to, instead of
> having a separate cover-letter message.

Thanks for your suggestions.

At last, Thank every reviewer for your dedicated comments which make me
learn a lot.

