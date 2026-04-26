Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6CA1C3BFC
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777191672; cv=none; b=MDTW1PQkE1pIzSlpv+AeHBN9iBiSqvSgVb7/WQsHx+pOQtXN9RAzFbhvBCzgftCJWhQMyM4/8j+ohNQ+g8/pIUXsINCIg5bHosfOiwoO35MF7WxzXSjsQ5D8kM58lKZGNJ+Pem3qhT5xEB5Sn6NE5zWL2tpbJcMz4PHeVWF1u20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777191672; c=relaxed/simple;
	bh=KxCOD7BIdsbfApcWwT1tK4pMrtEp+JIJtirzx6pgaXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm0elLRtvOb7eJtNz/EsCzgKrVxOD37XfFQYG9KmZ2DqdxjAUEj6tqg4eRi1Y5QKO7zvgjmof2jepBmAfutj7c5lWYDAFpr0t/f4jFW5LvFP5ZyFVethmm+SMOLBp5/GwL/5CrLPBsXR3AMjF+uVkDxFnxNS4eAjld5gzE7gHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FECzB5Y/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FECzB5Y/"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a01c80c34so90175421fa.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777191669; x=1777796469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KBXooCM564XA87RW68+FXlr7zhQ1GOvjq58rpAj+hk=;
        b=FECzB5Y/6BTwjwOr0p5hu0wMbb4ZgtDHCgW6Z1RLBUxmu0y42YzK0FO9nsW31iMVCD
         ELaCdQR14QYKO+maUPIfBudBmNNueHcZgrMcizBA58fbjxxn37JZOZnrad9ImbUyCkrT
         ALHYfEUzD8ZgWe1cSB4nqw5mK9KpxrQBdco9QurKykzjBrE48ZWEQgudxi9PO8bUg0TI
         VqMnCqTLbAcGmMMu788TQPhYXFYw9V4ik8tsSSKI+oCFWCIA6mRNkrmVD79M4Gj3I4UQ
         1FF96YiR5XZL0zXu6RIoSSiXzm5E/T0JGMfgkgbZFUIQbOuaLECIkHmSupNgyywl3gje
         s7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777191669; x=1777796469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8KBXooCM564XA87RW68+FXlr7zhQ1GOvjq58rpAj+hk=;
        b=QBB9P+OxeBnXBTKDzkvaVLdTLXVlB5TDkEEMla9Pfz6/8Sf+psM/NSjdJW/7uH4Zs4
         0/CGWtCm7CasTfnLnXK7+LYqNU4N0sUanwINJbTG34mNbU33Y+l00U/ZE5A7UR2N2Ytp
         HsFUV6IJ1+sNuZFGJHyFqs5j1tqa/zt612RTMPy/7GPCMaasUphRhgCmHmpupLIkL5Vk
         tpAc57DPMP8MBtHLhXENiHchZ5vzJf+fTWnpQEUshVS8wPJ6YQ7YfLlRPCsmckFvM/lU
         FIaeUr0JvcMA1jUHuXQItMMCQAP+7ba4MzBJjk09CrkY7cX1QQDgKm2wdGjwJhVAGth8
         ySbw==
X-Gm-Message-State: AOJu0YxBJoMFJC7LaPto2u4Hs47UgjXQ2FiVmAlJ8xo2vRmhGbW6D3zb
	ctjC6nkDV9lVy8niyNS7K/DZ49uVfgrn2lFB9StQ/ouyYG4pQVhktIS6
X-Gm-Gg: AeBDieshlQhfwrJR0fT0m5tlV1yRU2Ykpws2HLJHXIwu4+ULbW5pc79CCehQTRlc1vZ
	lNWGkLYYb4/WlO1jpk523gQaeKmvt/EfJLT48MimxUqjwfyhp/BfZXF16+A6SbKA7qftV+/iu8l
	yhKWDAj/38MAG0qa1Ab+a4Jg5QWYlxPYdWKV7NmRdWtcwc9PdGLbUFFnEcPY/0eATaeyKABOaZX
	RJ37A4BMlnmB+FjUlSnq9Xh6aGMP1WBgEceiswP8fsZjyYnHXXTz1cYvw20xOe6OTqgAQSU9YoX
	fjigW89HcleY9vy8MrC2Dfi48wedG1XepmvX2PcDwPbjGbePM/Duc/wPTiSGVIE8HPIWW1/qJv1
	NE0c8xBhzLv0V2XJ3OvPIDmUP8ZjzdoOtoz8A361bp0+xJq2qiFCIencGPVGC904xaKm1tS6Udk
	8RjEC8Wlh11qSqEaD7WQ7uV5N1z3y7lwMKrU/NMt/SS+KYwfX9fRuhPlwc3dIe2/pnZdvYqV/8B
	+RVpjnJRYgQpQShZbtd3V7dgEg=
X-Received: by 2002:a05:6512:1dc:b0:5a4:19f3:f2b8 with SMTP id 2adb3069b0e04-5a419f3f3a2mr7861831e87.10.1777191668807;
        Sun, 26 Apr 2026 01:21:08 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad2f4sm7414224e87.17.2026.04.26.01.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Apr 2026 01:21:08 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] remote: add --set-head option to 'git remote add'
Date: Sun, 26 Apr 2026 10:21:06 +0200
Message-ID: <20260426082106.11266-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <20260425220629.GA28590@coredump.intra.peff.net>
References: <20260425220629.GA28590@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It already does, doesn't it? Doing:
> 
>   $ git init
>   $ git remote add --fetch origin /path/to/some/repo
>   $ git for-each-ref
> 
> shows an origin/HEAD link.
> 
> Which I think is not too surprising, as it is just calling "git fetch"
> under the hood.

I think you are right! So maybe all of this new code is not needed at all.


Harald
