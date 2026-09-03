Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52F50AC29
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465626; cv=none; b=tkN5eg+p+jcadZ+yKCA+fS0GdWlZCER+T25JKFIEQWVby7Acm5lMTVz1WgRaoWlfno30CjVyN991YO6/Nw6yyW13aR6QI3ECsru41t290P5eut/N0ymBgRklG1gNNgpPaXIXiQYCyr40lyStW0L65HlJhqcfJR0kTIXyh+P7ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465626; c=relaxed/simple;
	bh=Q58dpy7qdCAvjfelp7ZdVla0IMPVsOwdBOvH6OD5ug0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvkrpLvY3D0bdtKfl67ATr5F877PVd3G5KgweKxDQzlxKHCUXiIzsgk0ylQbTr9nF3LKG424fCVjkMxdZROUOYHmVpJumh3WBiR4hkfkzEeOdD2eiqZcbjnhP3pwLmAhDBk4dN27KSCAYOgUVQzU4xwN4fKkPQIY63MPERLL288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=HCLx9AIs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="HCLx9AIs"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48441fa5c37so167298f8f.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788465618; x=1789070418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q58dpy7qdCAvjfelp7ZdVla0IMPVsOwdBOvH6OD5ug0=;
        b=HCLx9AIsor5JuFy0rBGtIvYGGLPaCYsm+UKYHlqK3GPWaHziw+BGv+81+kj284AkoG
         kTipKOdpLOSAwYcoP9STUABf7+aGPSyzdFjluby+4H4JXe/qKqXHVa0OxSCFVSrpbdDD
         S/7Ggou3sSPU4jsLmQo45m4iN4TouX8IXlk+dn5bMHL0PaiCUk1iwODIK0USyE7Uhw6z
         jLJoY8q/YBR1oAqUYcWI/lE9nXa3URAsDzoklbV5CbR+W61JVMuZfKC6SJAJjYvZ7Xed
         j3LSeLBUDLxHzXjDOsfH3eQhP0iQqz3M7mKjfhvmq6PQIYpkcld9Ak+GU4yssx2Z3lrO
         OGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788465618; x=1789070418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q58dpy7qdCAvjfelp7ZdVla0IMPVsOwdBOvH6OD5ug0=;
        b=QfBfiCeep+IVPFEHwcpDKmHEHjwjQSHODqY580rcF7j598MO8vQm9JMTAL2+XX3ide
         z8NkufiSU3bADhhZ2er0EXaByro7Vf/4trIkrrHz34jXZIaW+cGNrnQMQeBiyK9syGJe
         gvneEW+3LPqm0kM2QREkGilE//nyTcRhoKmD0AnnEK0cmLvlT7vKuoh9IrHHzSoLGMFH
         emLrDLeSmIyYnz9wp7emZ+umjFLyBWtiYEpG5J9mOq86pyF/rHAt7ckZPV8+zDQCBlkm
         q1pq4MHBdsUwZ9wgW4m2c++jN/2qXhsaM4EeGjKinpLxLNy/hYphSFG2oqG82aHQbz8m
         8GTA==
X-Gm-Message-State: AFuF++kNUEgj8WN2djTTe2Xhr8KlgG5ubhL3MsoJjc7i1S9Ng0odz4Oc
	lM5SRgSa+NW+ogua+oQOLNN6mt6KHj1rxtvYFiv65JRp1lU1k1uD1bV1Y5gAR86wBS1IVZMawIp
	l2jUSrA+DyQ==
X-Gm-Gg: AYBFou1iMTGrqEpUxOf7KHdsr5TiVv3xh1rNvZ8/me5ZfAvMr5bWPVmvBO5akb54/+L
	n211EEnOwfeX3toDAbqP3DA2k78VUu7E3RH8BsEB4t2aDfX8moRLp4pZRpNutfphrSu6RVCVpUv
	OjA6T5AnS0v2eBiJ/HyXstOwGn2KRTGaA80jsDEsqEDoW7sqy5TSaYPLC1AR3RHB2VkUVJsYUfy
	asW6kvtgT5RoQQI3aLg2eq86UuKogZilgL2eKhgIZCJ0cyVZFzGNeiCONH6TFQDZW6iDQ7OyNfL
	xTXjHYlD0x/CCmg73LI9jaT9W3FXfFnjgu9Rw4DRUORnexlWn4EhcSLcv7khvVPcvZgorA7UGUb
	bGfGSdyaNVZ0IW07osw+X8Q87xAJFzZCAnZRj6RHA1qqJbejoHehdZNcUB3Zy/w9kklHH6AFACW
	9Y+18KtmS6z420uNKcKEkOQTU0OawaWfLhJCoWSoofbjvVNi/yJxa/NRFgmx3M+6FGxtcFLhk8v
	LeiY+0=
X-Received: by 2002:a05:600c:a44:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49cf821e7a5mr7349695e9.8.1788465617571;
        Thu, 03 Sep 2026 13:00:17 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm8526935e9.12.2026.09.03.13.00.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 13:00:17 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Thu,  3 Sep 2026 23:00:15 +0300
Message-ID: <20260903200015.36849-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqq5x0mfgyh.fsf@gitster.g>
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:
> your sign-off must be the last line in the trailers.

I took Assisted-by from the kernel, which asks for it. I could not find
anything either way in git's guidelines, so I followed the kernel. I will
put the sign-off last in v2, and drop Assisted-by if you would rather not
have it.

> It is a bit surprising to see the fallout from a change 6 years ago
> to be addressed now, and makes me wonder what else changed recently.

The date is read from uninitialized stack, so it only bites when the
leftover happens to be larger than a real timestamp. That is build- and
layout-dependent, not really macOS/arm64 specific. I hit a layout where
it triggers every time, so the test is reliable here, but on another
build it can pass by luck, as you saw.
