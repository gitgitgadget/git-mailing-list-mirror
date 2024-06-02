Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6A42A9E
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342977; cv=none; b=sKgkGcfaL0ZOVVivKFwro9GrFZwt4Yd9szojz1UQlGYEEHx8R2qjKhgqSEFCHBppA7+KSZb+pm66dsPsde9pzP2uFVjCXtzdy35iiZUSm1NY9itDGQ1Vp9bE+dtqszwWSDiV/goEsLWiEI/3dVL+7KYCelp/ixIT1Cu5N/GXn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342977; c=relaxed/simple;
	bh=3b7LwQihlpQ+zRRGRbG4TlYa5Tk3O86RCHn22emgUm4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cr0XEGgzk6ef4ZpWGWoqGenyuNzf4aX7lAdw+4XgX2aemhLLo08kDO8ttZltBPrs6Q1pBB1YfjRZMRbBm5wpr96sBj3cXfGpUQCX2TczLvEVQcYJg1r81OExokDOb0OO2XmOqzC6FJMGfjSo7EDXu7g4kQMLCdV4ECA8uTzkdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGUrN/lP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGUrN/lP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so1921775e9.0
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717342974; x=1717947774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bXvkN8jWUutuqNXHryhLFWRZnY3qucFonzAOf2d3Pc=;
        b=NGUrN/lPqFwdgXajbpYyD92Mv6SIMX6E3U907Ptc5xTvEhl87GDZLKsUKQNOSOCOWw
         BCuk2lWvkOiiXr59zYepF66mxtKeuFW6HxSwaseFwILZf4X3j2g/TILEVNSDG7OGdUL8
         u3jhakFEJ9e3CByVmgCNykB7lTI5zkX3LO9retgDsCGBYisVkXiy8B8E8xGH/CYwt26f
         Wb+6JkuDrx1VF+/e/+9DVEik3wJAzOPZcEcWW5oAqctXWtIa+8i59HyousS4st1Ybn2m
         ZzLPfboAh2fU4gC9N0yIUd4bYKfcNxUwSc6tDYaJBmlvC7xREOHBYtTtD2YY73GeSJQL
         wWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342974; x=1717947774;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bXvkN8jWUutuqNXHryhLFWRZnY3qucFonzAOf2d3Pc=;
        b=ErGDDgiaHGr/NoLvixY+bbvpa4BNhKfqyX7FCE6JdbPizzdnqL11YTfP2Oda52dmwF
         kVgFdzR0VvPzhabrNC3VySCTFIfDbQqPoUtQ0EbZ/m1wsHvp7QFtEot4nBRlDmd40J8g
         zFB77lk9XR0H9yVkgXMBFPabuhsM0rZ+PjXTvkixoO6v4ZjYxwdt34tp88XvA1/vETWu
         YgsJbi4WX2/768N2z/u4qLZK+V42CkGDnuiRiMC4NT5EfbHoIbcj5IydW292oisD+vBH
         kknhzuNR4+3PqPniUOZrofdm4EAndcHEWnd1W8oTaGzKHzRI2vYY2VYVk73XLFglikVo
         JElw==
X-Gm-Message-State: AOJu0Ywo765Yz/vagRAoiDwpeOzO8PiuAI2u6Xl890yaxVP+zEwEJoI9
	coZIsFAWnuOjOW8XQOIkBkbQ7dCG0M992g0d10p0qAH6buRKS/+1H6/r3A==
X-Google-Smtp-Source: AGHT+IEgQ5lfjwumzOFRbc1QdVbOKZLAcfRa54x75hthw/+fNTlt8Df5iyPVZLXDpe2nh+mn8Gy2QA==
X-Received: by 2002:a05:600c:1554:b0:421:35d5:39bb with SMTP id 5b1f17b1804b1-42135d53c88mr25561845e9.40.1717342973883;
        Sun, 02 Jun 2024 08:42:53 -0700 (PDT)
Received: from gmail.com (12.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213411b25dsm63184975e9.40.2024.06.02.08.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:42:53 -0700 (PDT)
Message-ID: <5aca7ccd-d119-4a4f-8234-2c6ba3387435@gmail.com>
Date: Sun, 2 Jun 2024 17:42:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/6] pager: do not close fd 2 unnecessarily
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We send errors to the pager since 61b80509e3 (sending errors to stdout
under $PAGER, 2008-02-16).

In a8335024c2 (pager: do not dup2 stderr if it is already redirected,
2008-12-15) an exception was introduced to avoid redirecting stderr if
it is not connected to a terminal.

In such exceptional cases, the close(STDERR_FILENO) we're doing in
close_pager_fds, is unnecessary.

Furthermore, in a subsequent commit we're going to introduce changes
that will involve using close_pager_fds multiple times.

With this in mind, controlling when we want to close stderr, become
sensible.

Let's close(STDERR_FILENO) only when necessary, and pave the way for the
upcoming changes.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index b8822a9381..b786601074 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
+static int close_fd2;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -23,7 +24,8 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	close(2);
+	if (close_fd2)
+		close(2);
 }
 
 static void wait_for_pager_atexit(void)
@@ -141,8 +143,10 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(2)) {
+		close_fd2 = 1;
 		dup2(pager_process.in, 2);
+	}
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
2.45.0.97.g9fa538478d
