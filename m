Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323B4685
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629527; cv=none; b=B+c+DJSFzFgAQYgEjFgpcrcU467ejIVJqZpd+RBNANQ0SQ2TspSy9JyXFt4iAif8asxJkW0ubENh0Aj+pMKUiVzT+Szbk0oRdhF2V8Wy/eIhz/9ioP/Q2tI0Aaeubq77ZhGoYwiI9V40MUsOMV4dBNi3+gwffEbfaQrg/2tjpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629527; c=relaxed/simple;
	bh=Cmi4jfwh//kAQj6ptI1Ipyrgxtr8mgh8KAQwhUh7814=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZLGMBREkdt+ogpStnBLsar/7XHnKLG49kDjYhtq9fh+s/xWLflWteZmS5QsfIdz5n8Y1sLjkB6jBFpFENgRH4MIrvL3U0FXOhzfjgbT9t7687NnWd+Oo8ES+vehrGfaGJ/BV6fanGpsqnn/ZZ/1BRp1M8ys9/C4QJXSubUjvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0Nrkx/7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Nrkx/7"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f44353649aso6512185a91.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 16:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738629525; x=1739234325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rGM4GwcDYaXGM1uQAklJbjBj0XxBwYSUXOVzjfMCGo=;
        b=h0Nrkx/7qxdiu4uve5tueNEsNzHXu+Mal+OiGRrGMU1ZzyvVXk7MFUrsxw9hUPqUy1
         34TNmonYgn1Zl6Vf3xgeWWz6dk3Vu5L6iHWi05QgA4H9cqB6pllDOvtPRxI3uCc5uytR
         KgCoAzSziSulAHQPa5WEKuf80PVVSMPB8CNR4M99IJ4H9q9JFsI+v2woqE2YjJjbHvWo
         wgKoWsCuqmrHQk2tU+ecalTaTQgOFdiuKI85YC38rcwAgkHOM3nX0DzqGGt3ND0Wr35k
         fCLC0yJYF4CWl/1QtPMR7C1+nvUPA/ChUm1KqcHFJto3c2uNY2hWH2x00hlW+CAxP5fj
         SzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738629525; x=1739234325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rGM4GwcDYaXGM1uQAklJbjBj0XxBwYSUXOVzjfMCGo=;
        b=tyIQmuHNqCvbrwFw8wkzW7eUatxj+WJRCWJC9K9nd7fbdC4vs4BuGpAyDyqDiNpj8E
         ScZB5xdX3ubV086+cDDI2jw6sb4XgmInqNktwaVHjJidQSpHVjCZsXpaxgS6uEZo7v4+
         gYX4V1UbHVi20KUVye28DnARrM5Ny+V5aisQud/rcCjePyJViv+vMG8GEoxYPkmS+uE4
         VaUAmDaBl35PMelkB0Dy8xlZQVLnlMxhQrdoHuRfC8OnNLIj9YqZ3Xv/JZVfyDFnZwDk
         cbEUrYrOu4+pC4dzZz3A9rglRpOoACD2C4CsASdWtcKjp3+6arsn8m5lcTA9a0bHl0xf
         OARg==
X-Forwarded-Encrypted: i=1; AJvYcCXo8C7aySVCOdiJFto7dqgZvNf/O7evPcNPt2yMNkDgtT6iq++7oGtXfc2GCFRe+1y6i4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tGjdun5InnfR2SfH3VbQ5mpv1foh/foVgGR7QBPAfuR4jPSu
	ROPHwnYUqYnrOU6WtV5qDGLncQzy7/LAGGaLn4LQFNaIcqd5YxY2
X-Gm-Gg: ASbGnctLGSZVPBXBEXriUdqySBPhQTyrS0Qwx1neXLToBUn2E+lE00s7ejvTFHMLeIP
	cjeGs8aY6VJESgaDpyLSAUWFXuCgQdz2czUhETv8UzCRXjhiodacn4gKJNJdhf/5CPWsCYQBPAS
	6cC6ivoyiZvG1TOwLe8+tlBgx+c0ZY8u/QFGiohzVndGX6yxAiiHBDBouuYnYfh2Oj4fTmmjT2z
	+fE15OYsT8kX2uPty4LzDShf4QLjnM4Rv1wRpydWxesgXdNoiadkBjdKsmN/YpfZsL+7NPC3fE7
	+l9gyXm3n6Nhp4XvipRanDzpe++rCDCO
X-Google-Smtp-Source: AGHT+IG2eigCzQKq1yynkji/kFi0Xm2yV7KZWQogbGU6glZRW1D81cplV9G+0qhdBBIg1IJ63DVjrg==
X-Received: by 2002:a05:6a00:99b:b0:726:41e:b321 with SMTP id d2e1a72fcca58-72fd0c7835dmr37606552b3a.21.1738629525005;
        Mon, 03 Feb 2025 16:38:45 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69b9cb5sm9365900b3a.107.2025.02.03.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:38:44 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: gitster@pobox.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	sunshine@sunshineco.com
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=5D=20t6423=3A=20fix=20suppression=20of=20Git=E2=80=99s=20exit=20code=20in=20tests?=
Date: Tue,  4 Feb 2025 06:08:05 +0530
Message-ID: <20250204003815.61391-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <xmqq34gv3nch.fsf@gitster.g>
References: <xmqq34gv3nch.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Do you see any other changes needed in this patch? Let me know if there's
anything you want me to adjust, especially in my commit message. Since my 
previous attempt wasn't very suitable.

Regards,
Ayush
