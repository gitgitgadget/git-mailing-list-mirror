Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140435A3B2
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173893; cv=none; b=XgHtYXVIFi1+VrgmjUmAeO5dUi/Dj8076FQlpE/oxse5d2gzf5SAQblkBI0wCXurnGCO12U8gZc3wo77cbdlltTUZYg0Gd0dptXKQZb1vJiNace4q1dpGpdwMUXY/J/zOafcskM8pdus62Xo6QWsFTEd1URAXRKQQ7XBkvbQdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173893; c=relaxed/simple;
	bh=uuLBcgVjxqLZAF38V2yUtaIyFvN7OaE1Y5f0uPIcbTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRilC5pkIjnlaendD2F6s4mzS8ejsh94r75MfwduhkoL+1AL7Q4hwg+0QC+zy2qR74Sz6fKgJVMYeYwFcReBJsnN8O7EwbPU0PoLe7CI4DjPn9yagcNhxcxbCbDi8L8sQjNgfV+IWs3Vh5BnZqgD9yugrrD1eXGcD/aGb8Tqclw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOSO+N2x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOSO+N2x"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adbfab4501so7759595ad.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173889; x=1772778689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkQTNn4rpH9GEGgYergb4Ws2S99Rgmn2LfFLRtnFXKY=;
        b=TOSO+N2xKYibHrlAYDwr/dOadnZqkO7SXGca+bd18Rrb1edoeGtq5rw+JYMFxP7UKO
         oO5Z1rhLyiXEphhnnWv48gzENcZ4tLoEuFYLen1lX/+isuVVsqBQ7HtGpgBniwW5aH64
         +LSuVj79AkoBZc2B2V92i2KSlKQKtCZGawExYl3oOeEBchtessRmxi8iVMylgyBbN+St
         Pg2hL565H/Dj6k0hvxTmZPs4A8/ZN31qP7bb09gqUO/EtTrdTyPnYm2ZXFFiHXAvSneV
         gCOiDI6xdp+/BQjsWW5eTZv7M6wJYGatpOHOVKFpv6GiwpHPknYc7b43j/yYLjzZRLlG
         ursQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173889; x=1772778689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkQTNn4rpH9GEGgYergb4Ws2S99Rgmn2LfFLRtnFXKY=;
        b=U0DVgbyr6cpVsf6Ydxw5HZjpo/+aw3zBbz5KfbJlLWVu8rgc+aDZrCIfUF5hUkeu0E
         wy1JPRoiJ8TUznjgjvX6pQk7xZJRt7NLohDgcn+esrpRt01RkqrQCTPnBQ96OIkFnISm
         69obNcMHSsHk3vhfcfKglZQDg8UXLm4JQ2SfWoYhkrTSjW9AVGiXw+4CrdxVhyy3cZ1I
         jTVl3wwtud55qylk4xVW8KEIhBOMEQ+FO0yGwfbGXWBJ+bEc+qpc9OGsEg3E3jlPWnjO
         L3GCOQExODGyCxwByTPOry9d6R5V/oND7CqF2oo8IsAxR3HIZrAlastUKFZSpcyJUvbD
         sR8g==
X-Gm-Message-State: AOJu0YwSnG7+vaX9eclXQDvIGD34/2zgQyH91Gl1LN4KOaEucZKHRQCw
	YkbZNcNhaJEzA6CCZfU/FH9CYdYiru55jpBv9X0bq6dG/1zBImSl0Zo7rDmltA==
X-Gm-Gg: ATEYQzzd11nudzBBPQVnOViTo5eWbWgsMUMI1B80Zzt4CQOEw1Ffj+Ak7aAevXVVoPX
	xTqRFhOSKdVe71HMmAYqHQTUkmgCCukPGudvzb8KaYeENDDqoRHeHm+F5qJrqyCX1WhjrvlONCt
	F2RAf3t8Smdi+rsjbuoaXB8ON5KuStmuH3UshzLfIuYDukgK2tzHP6KTMXOrBmt/6xoxy66ScqO
	36RdoDFqXyruXHZCChv4e8OMWJ1o+42gj1pfCReK5rBKL31GfnuEDqqxKG++P94jc9v+WAPtHPZ
	mGICQ+sv+W5LHkob4tzaTGzwPZRJR9U2st5TZT+YMP9aW9Hud2SWhBNsK+f5+xc7zZlbFFQe4Sg
	NWoR+H1CmB5/GDsmcjevICpt8IOLU6KKwxM8w+7dRHPr0TocRyYxmdcEXRgx9rDaVPoMcVt/G79
	sE2f7YkgED8x+dhH/c8iqykRC+9GGRo/MniPYjvY107KzC5Ucjc2M7iz+dEmOjp+01dHCZq5bdd
	rxS4Wpm5g==
X-Received: by 2002:a17:902:e744:b0:2aa:e3d1:1438 with SMTP id d9443c01a7336-2ae2e3ecf36mr18907705ad.12.1772173889540;
        Thu, 26 Feb 2026 22:31:29 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b2296sm47221465ad.5.2026.02.26.22.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:31:29 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v6 05/10] fsmonitor: deduplicate IPC path logic for Unix platforms
Date: Thu, 26 Feb 2026 23:31:28 -0700
Message-ID: <20260227063128.9135-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqqzq88q9u.fsf@gitster.g>
References: <xmqqqzq88q9u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> But the patch seems to indicate somewhat different story.  The code
> before this patch started with a single macOS (darwin) one, but
> because it is mostly applicable to other UNIX variants as well, the
> patch renames the existing macOS one for unix and makes a small
> adjustment (namely, asserts that r->worktree is not NULL).

Good point. Restructured: FSMONITOR_OS_SETTINGS is now set to "unix"
for both macOS and Linux (and "win32" for Windows). The build files
use $(FSMONITOR_OS_SETTINGS) for fsm-ipc and fsm-settings, and
$(FSMONITOR_DAEMON_BACKEND) for the platform-specific files (listen,
health, path-utils). No more if/else blocks.

Also rewrote both commit messages to describe what's actually
happening (renaming darwin to unix) rather than "merging two
implementations".

Thanks,
Paul
