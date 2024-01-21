Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990F13FE2
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856239; cv=none; b=A8S1vucFD9bE3WtEiBnyMjgSApTdg35Cy8ZP4NWlQomRwnJpbjg7bkz3USqHPq6TlNNCxB907KbFWf854uel4mc27kT6NshPpKhAZwuFVZ8XnOJwPJaHxYBD2y284yyrjsB/SPZ3i7/nVchjlHMb1f+Z+AnbADruYu++9d3PfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856239; c=relaxed/simple;
	bh=0mPqScdlIEEnL/jnHjSJ+TSEY3giUaWOA+Kf/KR75fQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDLctF3mL+ABUeDl+90y7ldnB140U+UFCEOtvQlalUZB7b/v38bMGROYbcjr4X/pcY0DtUb6WoJg4eVtT7Qfzxa3ZkJT/jCTPcex/obPITOIJmMkVuwokp48Tx4MWl4BT+wPCsX7VasyOnTfxB8pjhZPdC5j2pPaIWXL5T+KGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0EiiWLb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0EiiWLb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc221fad8c7so3368096276.3
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705856237; x=1706461037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mPqScdlIEEnL/jnHjSJ+TSEY3giUaWOA+Kf/KR75fQ=;
        b=o0EiiWLbQN7iG9DF4+4QqAESe6TSPk1gYZBEASWCE5v0ge5W64o5kcqxxTkgEKckfc
         d0hIfFuFCBg35hU7XVvZi0FOaTW1AxaqFIpqg5rBYudg0ae7aNp9pBfj4UFwdOqo39LW
         BvOYYuJYxdFraVpSTZ2lzwqqEYWw49TI/vPmUVnzOpcAmV+IzSBHDCsK0/8e0OqpnrgE
         SNSu/XZXXQSEuAlmn0RK4jxeokQO/yG0D9ycNt5M6i71YSBR705xH1tgwJMjNEfVy3K8
         qQ3o+WxAPOwoGbAwDbfkfkr6LFXQ3ImtRjw6JSYIeFAGA3tEVXFgutmaTGfiTelw1SpT
         TsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856237; x=1706461037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mPqScdlIEEnL/jnHjSJ+TSEY3giUaWOA+Kf/KR75fQ=;
        b=mBQixxZYZqgMX2TEM2SetCj3J89P/9wz3COkcukDFdaLuqOvpMEuxRWYv8/OTeQBgL
         fjpSuJ9/oKzTkSu3W35HGuiCQP8tAj69aCBzsT/gq9wJfbjOvOlk4bJmwEUUrAbK+ERh
         rQGBApROInqOVGqFfmgAAMP8fJc3m42x8ApkigXfrrFPwTXveZtw32pdBsSwjqgJHShc
         mzZjZ4DeqKI3VkhcMyj6X3BaDTAfyYqXOFw2cIIs5gkxcQxpZnaiZJp6Di8nBgmiBulI
         nhpRVeXLYGPTDmYj0J4bGGV5bgAecozVUlq4xS1erx6eeRywsM0kTetCUp674l0+ucyF
         HIwg==
X-Gm-Message-State: AOJu0Yx9cYVme8mv+voHiKK2Ly+tRbcOMYKsEEv+D3/cMu4jRVrlxI5B
	8qvqPL2DXwmehlB5v/tzDHNthViKtl4+3ICnuMGkV8Q3bA69E5JWdFePYpfgeoGdkJfdjPV2wgc
	D9A==
X-Google-Smtp-Source: AGHT+IG4I6gmdSn0y/UTbwtNnqS7kZ9qxgKUTFL4C6Irf4Ep6hwKWFUOviKvt6OBaHVtfzc8zNtcEhRKK0w=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1005:b0:dc2:5525:f6b with SMTP id
 w5-20020a056902100500b00dc255250f6bmr1444098ybt.7.1705856237491; Sun, 21 Jan
 2024 08:57:17 -0800 (PST)
Date: Sun, 21 Jan 2024 08:57:16 -0800
In-Reply-To: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owlyy1cifwur.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v6 0/6] support remote archive via stateless transport
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"


This v6 version LGTM. Thanks!
