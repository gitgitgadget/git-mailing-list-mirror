Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9223438B9
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377276; cv=none; b=qWv0lSWSOgA7BJnEBaUdb11RDN+5enrtLRpSR6oGWA5v+Yc79oKLNKH7FV2slcT+AwTxtG5ioFok1DYZUiljOsAVEaILUNoQ2OI8v/RB8DSrDRW2SJfy4aF3ndeDyD4xEjmQdxDEuO6y6Yut7xDKABObDT4l3WP8zf/7q1HAo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377276; c=relaxed/simple;
	bh=F68BIFW1zfli+M/BobJLYMXNUs1JlIMIhOs6mkopl9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er/5yU8qypLa5elQfJ3Efbjnc47LFZBAOkuHmnrmRIpGaqsaDFmIyR+dN6dbmo///GE5ubHUVP08UB1cZpPYaYXA1yVtWr+mxBCxxcy5GqXRubyIpBTl0Vc4BJf002CcSFjZIp7DUYtW4I25E5VPx1nehjNHenupsi6A3510X3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BeWRJsHD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BeWRJsHD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e0d1da913so982801f8f.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1792377274; x=1792982074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F68BIFW1zfli+M/BobJLYMXNUs1JlIMIhOs6mkopl9w=;
        b=BeWRJsHDbxU1giKrYi62id9ezzKHZJpzhvvO5cSCu2fWyNJKv4pDNYywcuPgmZpL9S
         HMBJfMCjlCGx5QWVz6iE3qvgFvwyGNjm1YKV36fxvwyMS8iT+VoQVAMhnC+2MU4z9ARY
         jcjIEiUFxHNPuCJ7fDnAOTgej9Eh8IFn/XLj9eFjyJQgM+hTie3TX4hzpMRvzGZEW2Gn
         lXnqV4UXpD41Qq4eX+TbS00DZgfE4XQU8gk23VjXWVe14cNvb7qqsgK5Zu3HbL0k1b5C
         DZbIClyyrKa0LS4N9hFHu8HuhmmsT0cDZnMxRj4Mr62W8sT8WY4IOp3bEzJ0JX5chVsn
         dDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792377274; x=1792982074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F68BIFW1zfli+M/BobJLYMXNUs1JlIMIhOs6mkopl9w=;
        b=VUOe9j10IOlf6bvoiSrrVntLR4Y20ALlQMsxVs1OwM93Pjma+MAi34cK0zGdZyblsm
         sxSXf/cZ9eI2/LX1GyzPV2SpWDOo7DDd1ufslK2YUSNVHM359wdM62OZFZGLLTkzyUQG
         y5o4YbZkxVNDpMPOIEziFUKmD7u8sH1sGFHCBCDaV7bDVJFq9z/mGYJ3fv+V5eLe95To
         6oB4Pkl6B6tGWiuNglj1XEWPWIi1L+Ai988lkLllAuFMRgnlmHMytwKoxsCSyKXx/C3+
         BDep0x/5JaVMW0HTNJNPlOpWyHbkzjdSzYZIztg+vztq4w0yVAitA03QmjGBlT2Ycb3S
         blCw==
X-Gm-Message-State: AFq9FYJScmofxaKEFypDwwrnQIQYyhXyWvl5Z37D+Usnf3/HzmQ1V+Kv
	xruQr6t9MklluWuMZLo35m5dM2BuEAifXrqrpwXJytH/ACn32YucE1sdNKeTl54gf1q1XPw51An
	fqUIGmltRBA==
X-Gm-Gg: AYBFou3Am8Pf5zyY/xsOzTu2BsamezGwmRkUo5a8YIH7e553tWluqA7juU/Q3EjRmue
	Y1f8y/d70v2pE5MMoB/fJIibAeo7TkD6RtjY0pmkQsgN5XbiGixzvx2ajIKxxK+JIY0uR56sCyA
	M3pA3eHw3MuGoLrDvNsgGq7yvNY42DbZUq7NPw70VRPcWmiE3lGVtmrmQ88Ew6aZfKnb8vqhKPd
	K8dYTmRN27mrdIRN7TcsLLBnQ2NbN0LgwJvqTQt4Z1Rf0k9g834WueC45UwJs58Lt8fhJaMwZff
	ciAfB3w5Bjh7cAhmezRjx3Fic9yS+aXeVpvaA1N++BoDm8//FcuzELzt5gCqjNnSRN6kxb0S/WM
	szXE+360j2ERyEzhurQaGW5x7jsuC0xsjqKLIQLFl1b4o4KQg9Q3VEGu3p64CJ+3lLazoGXXv77
	W+S6wRQwMrXsUlnBhN3FdnlQgFKA6FGuAvo0KDw926bc71q9zJl9s8jNEF2l5q9O6gV+QWAqkms
	JFaQn0=
X-Received: by 2002:a05:6000:298d:20b0:48d:f9dd:e3e0 with SMTP id ffacd0b85a97d-48e07bab931mr8721655f8f.4.1792377273797;
        Sun, 18 Oct 2026 19:34:33 -0700 (PDT)
Received: from ownbook ([195.181.160.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4fe9d9sm18965443f8f.40.2026.10.18.19.34.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 19:34:33 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-contacts: ignore blame boundary commits
Date: Mon, 19 Oct 2026 05:34:27 +0300
Message-ID: <20261019023427.13157-1-f@lex.la>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260903125527.67934-1-f@lex.la>
References: <20260903125527.67934-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No comments on this since September 3, and it is not in any branch. It
still applies to master. The parser has ignored the "boundary" marker
since the script landed in 2013, so a commit that never touched the
file gets its author proposed as a reviewer. Resend, or is this not
wanted?
