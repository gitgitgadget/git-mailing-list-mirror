Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EB350A27
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132019; cv=none; b=Rjid59onWsYfSzPfmg/KpiAcXAXMxdYBYNGLZIl+ns7PxEjNIagf/R7YfiT1/NcdFzWik73OdY1RqQLwzo/VQMqpJrX6Yvpwpm2646wo7OgP5rfgdR7BHgUNy7w1u7NO/JLYlVZzRvwMW0GObcgdLRTFE2PR7B4TstSawDHe74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132019; c=relaxed/simple;
	bh=SD7seyxlNp092fcjjia2uI95eesgIll/m2u9s+75jR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1gqvCIbKt6j5G3w4AucHugfzmFly52uqhC8mtxkXlTlw3NZNQFBHwcC6rnnSMWv1/EN9hofwm0cjhfouu3oGk1YN/mSVgKkKeXBoNhPAsOsTssl/XQX3k8/wqrcRnFaJ5HGiAThNetk6jjyfvC57Ew4UVqbFKJ54iUONt3hx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvArfCHk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvArfCHk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f102b013fso59788405ad.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770132017; x=1770736817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ajFEZ8O0vpcEXAK6+/c48/0mtAaWU5q5xnddFlOjos=;
        b=UvArfCHk5a64PrO8xaX9mRpRUpvFMmo7WByFUUCAwsWDYMWFyGKEzGucDvdv9FIPOG
         eXkTlCYOeDiQGyS0UwjW0mGNksVQfETsS+2VtZRjTiDmQwGV4olw9UL8mf5yeywbgbhl
         z2a/XbZEhfopo1P5fNpNc/8P9j4yF41wPGbpWBAZvvtguXf3jGe7/38tkZb3mh7JytCA
         Sypi8VNifsYUQCbzs9Kfx2BqICWeO4TFgQusAq1e4HsttIR8EQzBKaXA+SQ8TBjSrTZ7
         U5zzJHacfPamKPHhna7m6kPFEz8JUgPAw6PbQuLADuBmpRZqKhefJllfdz66RBzoH86N
         7VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770132017; x=1770736817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ajFEZ8O0vpcEXAK6+/c48/0mtAaWU5q5xnddFlOjos=;
        b=fYR2uUy/u7/+UFuAoG4e8uocsaAm/44P/N8infuF7s2XTkPVlNfVIDfeeHVVPm14Tp
         jfn+2s8MaAMunMgmNj/ml/AOw8YgI3dCWuZJxfnZ8ByxGRy7ntvoYXdb7lrKsrhy6G2U
         63rrkbs/yesSSrAYYVlXmVihf3QxhUGY4Fh0cw052Hrl20DN7DVH6qGCvwqCV4oTgC91
         xQ2xSpqDqJnSjXIw1lS9xyhV1+BsdHFUc62QLQjpcwIQE9/nawbgncvhwQ+Oq0D7V4sn
         vjbH+3KYw8V8ZU2TyjQcn32bUzwpnrnEOmpB9P3N5GBQ+7wMcPbAuw3H5KeOMqEbH3ib
         ngLw==
X-Gm-Message-State: AOJu0Yyk4ZxsRD9hwhFtoQCrUTttN4zjGNllvyAIb9iG6iBZPKuMg58d
	NOGqE0E2RZlX7+snByUQP9lEOqGK+tp8W/rkOXR90WvuJHAwbUL7lCnO0lmfOQ==
X-Gm-Gg: AZuq6aK1lcP6Qz3IwQ2F22Y3Ds6FsPQNjwd7Kw60VhAVHaDWxtaPZ9nJLf31/sDjFrO
	A6C6Nokr1kxfmwcuxUvb5s5BKAkelz1cvOkOW1SV6M3ZMN1vOarkAxuHAN8o1HiMQNwIER37vpJ
	BuKcMvzlYLh8KLWv2qLRGiXK+RYDwivfKsH7G6JysXrPabni5a10l2boufwUsnDZ29wpGhzzYqa
	rD4AS9zxvFT+1lCpWH61VIOV6loxpXx8VpKFajxFtTaRADDi+1ChZnGi3Ke5S1fPBzxpmuS9NT8
	olODdxOIZGvzRHbu+I48z7D4+RCqwXH7/D5FbAUoEk5aNdxWNlw2lqXdMy2Th04xBbBaENQ6Qe7
	5IXjCMi5Pp9D92U+zsQ1y08fpsIHhXg1iMnn5ZrN4Iw4SjgbSTi7Syg8Qmy83A9gbbPgYq+T/PL
	iL3P+QGDEBw/ET19WXhtKyMPjaKHC8ZramXMlW8fFAw8Ke
X-Received: by 2002:a17:903:f8c:b0:2a7:5dbc:ed69 with SMTP id d9443c01a7336-2a8d96bc4cbmr156611045ad.27.1770132017035;
        Tue, 03 Feb 2026 07:20:17 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:3444:c9e4:e4a:f1df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b41474csm183278775ad.31.2026.02.03.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:20:16 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Tue,  3 Feb 2026 20:50:03 +0530
Message-ID: <20260203152007.38187-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <da3221b6-f724-49ea-99e3-9baed38d5bd3@gmail.com>
References: <da3221b6-f724-49ea-99e3-9baed38d5bd3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 03/02/2026 09:53, Shreyansh Paliwal wrote:
> >> 
> >> Clarification.  This function is like an initializer for the struct
> >> wt_status instance at 's', so it has to take both "struct repository"
> >> parameter, but what I meant was other wt_status_foo() functions that
> >> take both r and s as parameters.  Once s has been initialized and
> >> s->repo becomes valid, passing r as a separate parameter, as if you
> >> can feed a different instance of "struct repo", becomes confusing
> >> and a source of bugs.
> > 
> > Actually wt_status_prepare() is the only function which is taking both
> > struct wt_status *s and struct repository *r, because it has to initialize
> > 's' with the help of 'r'.
> > But all the other wt_status_.. helper functions only take one of the following,
> > i.e. either they take struct wt_status *s which is fine, or they take
> > struct repository *r.
> 
> You're correct, but I had the same reaction as Junio initially as I was 
> confused by the functions that take a "struct repository" and "struct 
> wt_status_state" which does not contain a repository, but at first 
> glance looks a lot like "struct wt_status" which does.

Ah, got it. Even I got confused by this once :)
