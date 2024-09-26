Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6A161914
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374155; cv=none; b=dyWbl+7ZDCNhKOZNUdpzFTX0TevpNzydY+W+gZVNz6mNBfY5AWN1k2artIh5VvMr+3sZ63i9hDkxTGp6OYZ8SMEM/0HSJlbEKw6hmukc7Wq7BCwaQHmVHkkOUBp2h78kvxXU8XJq0RaZMggxSNJqa8QDDqwdQg0wG91FYEC0Gt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374155; c=relaxed/simple;
	bh=YGbJjtUfSXav6P+YNbEg90Oa/qcxDSMWGVrPjciyAO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UEqmw4MInRfm+z5HZxtuoYdroSK6gjFYtsF79dkh0Wmn+Fw4BwFZAgW+312+tVeH/06hFFbij5GQZtZL8glOyaKTMq2ehIJ5zLaivtHwpOC7xjhUSJ0TEFE3SZQbbrOYUTjt+5b2zdAoZyR7ccfN9IWVmXcgTBC3Vgmp2aNUYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuXHDYxk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuXHDYxk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2068acc8b98so13639305ad.3
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727374153; x=1727978953; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZIGo5owBGVg5IVO+Bv7TMpg4iHcrlt8YT97Qvii7cs=;
        b=VuXHDYxkf3Q4zRsTKv2G3X0Uod4dVbZOkIWbksGpaP0k+OPYP+KcnPfWwkBsNOjdXL
         f/Px2sjZz2qj6KAj147zmL0rByY3HgT+p31yXIeSxxnUCX0iV2VV9KMv81UxZBw0xqMn
         7Q3pdq3NtMgTbqKGjkAbYz0ALWdepTpG8C7wBTQex7TC5yZzkR1gogVpWQC0p/7xmnaj
         ZvrtI5fPrlneGtMa3KKj9j7e6a+hz5hi3Yh12yj8f0fvpm2pojZM1rALX/kVtaqBgaex
         pvtiFXX0j2P/UZwR9nPk+6VjBfBMq4XrlZ6MVGjOulzyoZpvbpN/UAq0JaPgrST9NQ6v
         h8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374153; x=1727978953;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aZIGo5owBGVg5IVO+Bv7TMpg4iHcrlt8YT97Qvii7cs=;
        b=ciIv/idSiKp79TfLPz5g8GnhYGbz6rD6X7N3L3KKzW+UhAnY9YffsYyohspc27sh2g
         9jtL4hn3DsFv0+lg0f3GPhkNmYn0IyzSjJTAxWQzQEBkYUDOV93OfwuNOdSR1CSyIiAG
         r6G52SRcI1aP7bYQohvAwXVSeEivtVYf8sC3zwMm+M5oIIPIqn9ebXOoZiCTue1Cj+JG
         QWT3VtOIZv0zYeVWVg2wx/TDKMZX+0l8wHETBtx4CtTzGx9sCM6kZtga4CfFh3O/q9Fr
         5TQgsS8usGxFUbQPglxk52HKxD5lW7nbA3TDfvL/Wvgw60+dalBLOHv3kDeOvQfsgiWA
         8l3w==
X-Gm-Message-State: AOJu0YyvF64mtPf2YaRJeA5cix0dwRZArTBwqsyO+yvAhUpJk4cK7FY9
	CNVthdqOohamxEO11VVvPFqzF6q62zV/wrz7ozyPaUSX/VHVt64z
X-Google-Smtp-Source: AGHT+IGD69TgL9uEQ4HMgZ4GrDrw14XT6d7mu0HgqsK8w9tAAnNxYKe/PQvvT3tJIDAQjke1+WTNFA==
X-Received: by 2002:a17:903:32cf:b0:20b:3338:63dd with SMTP id d9443c01a7336-20b37862f4bmr8011115ad.34.1727374152835;
        Thu, 26 Sep 2024 11:09:12 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1cd35asm3820566a91.24.2024.09.26.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:09:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
In-Reply-To: <20240910163000.1985723-1-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 10 Sep 2024 18:29:56 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
Date: Thu, 26 Sep 2024 11:09:11 -0700
Message-ID: <xmqqikuijni0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Changes compared to version 1
> ...
> Thanks to Junio, Patrick, Eric and Taylor for their suggestions.

We haven't heard from anybody in support of (or against, for that
matter) this series even after a few weeks, which is not a good
sign, even with everybody away for GitMerge for a few days.

IIRC, the comments that the initial iteration have received were
mostly about clarifying the intent of this new capability (and some
typofixes).  What are opinions on this round from folks (especially
those who did not read the initial round)?  Does this round clearly
explain what the capability means and why projects want to use it
under what condition?

Personally, I still find that knownName is increasing potential
attack surface without much benefit, but in a tightly controled
intranet environment, it might have convenience value.  I dunno.


