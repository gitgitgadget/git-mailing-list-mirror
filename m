Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110B33F8C1
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299997; cv=none; b=TB3tRoCG9fCD1/6SMdMMD81pACaCQAb3+9Yxhmfju1RTQ5LFWpV0I43oU4sjIED8WhRil61n+e9ekp5eavDNvVspIFPGGSnunxXbKM23ssIQ4v4Pg311ykQkSnstMnWtSqe4TzNLJnDOJZ+BDuEYWV2jg6BcnJG4A6rQSYS0lWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299997; c=relaxed/simple;
	bh=OfslXntqB7uBBsCJRSOJF5eM+DcrEgDrZBL6fPM8e+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXJ4sq28BvVnMjeORH/a4cEuVVL158wy2OQxuCRfm0XNMnLyAc0XtHioagdM7Q04oUerQXy4CQ7suMjzlR2kKrWdOPTWjiIB63ECKJ7R4juu68FAIiceBEieOXK9Sg+m7SKSAIOGAE84tYvvXHm9y4uP79DNRFzVOTAaKJqUmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvE8B3Z6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvE8B3Z6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9f316d68so14664115ad.2
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772299995; x=1772904795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfslXntqB7uBBsCJRSOJF5eM+DcrEgDrZBL6fPM8e+k=;
        b=FvE8B3Z6stwxdzNm8FgN+LcL6uYTgOaOCtGBYsvf64NKOuyIzEzx7hLvKi4aq2WUsY
         KJ1ni8my1Lly1ws0LsWtxU0Th3Sy9UERzFXbCntY0WDBw2+HOzdMggQR2amRx93R9MX3
         Yu6Ac65XsA8mIWCUFDbTEkhB3qNGsKslIUBcUtt+c92z0I0ldmjlL+xusu2WR4GMgisW
         tN/uw5QAGhNgOZNm6sYoJ7qVpyMXwWIDHVuW7Q/v3YspjmclZSAbBBupwpegmi6S636f
         HCzXhpNJc7tUCHT1Y6tLa+aZFRymUGq6wDdvM4pgvygfkOlslkIXsRaubuHphMOYa1A3
         fDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299995; x=1772904795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfslXntqB7uBBsCJRSOJF5eM+DcrEgDrZBL6fPM8e+k=;
        b=VeLXAOwuNWJPJu4EqALK7+kiSlw+0V/n2+lcnZYNd335/Uf9xdDcrR7gj11u+CEupw
         BD+xepwiZhbUxY2lNzZ9kRtxUx9znHGQnTjhe9PvO/S4gP4zp+nRvZEtRo446uhgNnT5
         DehXN1eGy0IuJ/LafK5H9oAH4dUNxyEpNS67KndL4sS2I73nvGgtRJCkQhShtLKpvemk
         QDhGs0rYD0Ku4HYF+fCu+FXD1+gwfQ1etpejXRT3jKkSUT4lOhvuyngbSG+ZTwmNSbq/
         5A3WPlNQ+3EHWjL9LhFy87LsCqKYJ9dOfmBf2NkwSfBTN5a+7y5aj+t57081N8KsECXf
         HOtQ==
X-Gm-Message-State: AOJu0YyxTWHvPRzbOesEE5HpdGBSOnw5W4cGUHrwKZxw3pxPsg16dErC
	oWunNceuEwOPXiIcyyExeaAulpkxCybkctOxiaT5POBpFDXUB5HB349eWYoeaQ==
X-Gm-Gg: ATEYQzzXARliaX0iDhDUJ/x/IG8Oqd3624mfL9TQ0uR1x3Z27KMse6+4m76Gmp6qu3V
	QwZtOZSR7YTJCZkC8eZYvM4PIGWUrv/F8M5C60Fxb+mUA02dHPhMbT0pjz8XiID+hal7tETZIQK
	8NZgvQjwRg586Wvyrnbe8mlBLsIxWKo55wBeRVg9tV1jxhFEZkIpJNZtWvDakwuYsS/wcKZZbFC
	k0MKL3aPCBUc2yyWuONdnIVIZAIWydWeY9IdtxENKQOvPWMLnaPpEfQbnxaBWlj3I10caBnBGEG
	n5/wSYxUrDIngICKJUoetnim17g5t2+Goeu3mzvje0gYqYxcTmRzuTEABUtBqag66VOoohOthiA
	yL7kyECzDvyaqR8oN3zhR55rYC6hTmIVhiRIxkZHsKEHFxJSpmMUlaQ7d46ls7IAuPQH3KHGUP1
	B9JNUJd1mPDEEFEtfRRDPCfeIaAQGTQsvOV+72NrvlZpAps0GlPkur+TFR0pu11j1BBhsWxNE5l
	MnnG4mN7w==
X-Received: by 2002:a17:903:46d0:b0:2ae:4445:f38e with SMTP id d9443c01a7336-2ae4445f7d3mr10019865ad.12.1772299995617;
        Sat, 28 Feb 2026 09:33:15 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1913sm126754835ad.77.2026.02.28.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:33:15 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: koji.nakamaru@gree.net,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH] fsmonitor-watchman: fix variable reference and remove redundant code
Date: Sat, 28 Feb 2026 10:33:14 -0700
Message-ID: <20260228173314.97952-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOTNsDyy2ZQDhkVyML6j5naS_UC=SjE915hjygj+QmKe4bqc=A@mail.gmail.com>
References: <CAOTNsDyy2ZQDhkVyML6j5naS_UC=SjE915hjygj+QmKe4bqc=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> Although I don't have much experience with the Watchman backend, the
> fixes look correct to me.
>
> One suggestion: it seems we can make the code even cleaner by removing
> $retry and its associated logic, as they appear to be no longer
> necessary after these changes.

Good point. $retry only existed to prevent the infinite recursion
from the recursive launch_watchman() call, so now that we've
removed that call it's dead code. Cleaned it up in v2.

Thanks for the review,
Paul
