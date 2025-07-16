Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2E2C3745
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666226; cv=none; b=cIU9KsDUdgMfFslCEhQBsFybDeD5ocQax97+9IMeTfizJzjoccEz6Htad0mvl0haMGprLhZ95W6DgkwNqmhuNLFeguHfwBQyogjMXRD27DCdYMiSP2OxGP86cPV0I4KLK2ANGZMOiFwP95wwkM6tVWWzWzEnILfAZ2vYEsIEr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666226; c=relaxed/simple;
	bh=UKM2wuCmXMjFfumtUeR7kPf0WAxRq4tf39mC8Qssi7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5RhrDIzZ4uQCXs3SRtcYkvyQZyHOYrpkcxxNWEy6ptsfZO2d2+GKvbp+SoDHpeiyC1ZeFXSW5uM08CNxPBPPPTq9r7GPmq5B26wP/Gdpq4NqxsPukQ6lE8O7Y8HNeGJVOPijIms+hvBPs5S+L+BhRrsGGAIBFZf1QPHRpqqY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRK8TMS1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRK8TMS1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso6904124a12.2
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752666225; x=1753271025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj842sHvPqgCBtBn7faV/nVZ9dHuGkUXgGiYCktZPDg=;
        b=FRK8TMS1Gyuc4+e7gABuF6Ho3y/zBdweX5Lm336+Kt17Kl6m78WIGqjTsbHRtmXAlM
         ytYaSTJXYLW9iViYe0CyToEaVGiqf2zOXNR74Sudb3C7szXvWeqUDcghOzW2kaDY5wX1
         cRpfw++nhfuQWt+NYeS9YFZWuc+p1tEQriMN5gyFix8Wgv1RosCMkEImU39BMJxG/YEo
         voWiUGvLK3lEMKG/g+8fwWluSuZQxVIaOtgjymk6JvmhfKQSGe91/DU2UyCq0l2ugxAN
         +NQwNHelTfnBYhQR3zoyGGzJ1y+Bi1c32xn2y2qFv7aDvHG7cxIB55XGrchfqwVGRoZW
         HRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666225; x=1753271025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj842sHvPqgCBtBn7faV/nVZ9dHuGkUXgGiYCktZPDg=;
        b=lKAGlDaLv8HOMPPCXFYx9pJHPNUuqGrdUdFV9DMuLPYBs+dWz+BvGGNwDPb6cLXPzI
         z/Zz8118R3skR0+M3PZWY9jQ+YE03n9rPMjVhE9FXZXx+73+0YtWSInUey64rDEFjPy2
         Bl21kvXc4hdd3IRObh0jLK0YHFGZJfeMC1eoKMxZQboK4F8gm9ZCC86ofE7m72L2su2U
         Cv+vRaTN/1C6mzpDbWiu7ubcG3Ee6a52N9b3QxUoQnVADGOIMQyuN3BZ131ULJdxmC86
         VCXqWFzVrTmmaOzf+WMNhlrdjIXoKemabJNn8aensmmc46DiFynF050BldS9EK3PVRO5
         Sq1w==
X-Forwarded-Encrypted: i=1; AJvYcCXik7eK88WrtIz3VgSXiCP7+e4aoVFOtWwFg08aXyb2nA/Ulx0nksxt7H4ppqWr4h88gNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyctQnSxG2Ma88PAnmHOXZkcoyduhUt1V8oT8YlZnxKAHSfmSe7
	rsubqRj5G9DaC8mQnZVssjwShUB/hq7sjSY/WG4/GP0mImVzPXzlsK37QPvJfxgj
X-Gm-Gg: ASbGncsDacAwwRpPC3GWtPgjij4fmdtnlfBjlQ8Gw8s9FJUzU3In76NkllaEDsdqwHa
	wirqRM7OVhVDSGeZgC6PL8R8ifrZeZvYM47iCx3+h6ecxYw/S7gbsAZBnM0j+nobXj/8EYwW6kK
	OZfJv/W9YjGXG38iv5mifHU6dPDYbD37p9+ql06v80aHKli9at10kJAhRqjlyz1es6rN+C0jPW2
	Zc3UA+dkbY+R4+VZMcq7NxMAjSSsPy22Q6FK5kELvcmBbGoVCR6NN/GYklX4XBXz/IkC++OC2bv
	0Fz/Hk7ZINpSGVGlDUAjLWZ4cRfw1XIiXEqIffaPbNYnWIM1inwCnzqCVMFU8xyNRYEqNhaVVvQ
	N3L8Kxay1Hx7Q97KjOC5YXmHXQ8EObj6u1E8=
X-Google-Smtp-Source: AGHT+IGjp3++Z9xlEFgtKRsxORoyzp/OybqSVFlRUltQLoopMUxEWJTW/Fl3MwlTOtj2p1E3PfoHlQ==
X-Received: by 2002:a17:90b:184d:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-31c9f3c6068mr3450352a91.12.1752666224663;
        Wed, 16 Jul 2025 04:43:44 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f21e970sm1267553a91.39.2025.07.16.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:43:44 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v5 0/2] commit: improve behaviour of core.commentChar=auto for comments in commit messages
Date: Wed, 16 Jul 2025 17:13:27 +0530
Message-ID: <cover.1752665506.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626132233.414789-1-ayu.chandekar@gmail.com>
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hey everyone,

The aim of this patch series is to improve the behaviour of core.commentChar=auto by the following patches:
1/2 - Fix a bug which reads comment character of the comments in commit message leading to change in the value of `comment_line_str` and thus resulting the comments in the final commit message.
2/2 - Standardizes the behaviour of code by resetting the 'comment_line_str' to "#" when 'core.commentChar' is set to "auto". 

Thanks to Junio, Phillip and Kristoffer for reviewing the patches and also Christian for the reviews and mentoring me.

The only difference between this version (v5) and the previous one is that I've added credit to Phillip for patch (2/2).

Ayush Chandekar (2):
  commit: avoid scanning trailing comments when 'core.commentChar' is
    "auto"
  config: set comment_line_str to "#" when core.commentChar=auto

 builtin/commit.c           |  6 +++++-
 config.c                   |  6 ++++--
 t/t3418-rebase-continue.sh | 13 +++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.49.0

