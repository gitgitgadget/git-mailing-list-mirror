Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7272D8DDA
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550152; cv=none; b=XvTaUbJzqMCvK4iIazW4ijwfBNYKnRibgo2cOehV0A12FggT4UE/6fBJy+7Yh1ZT/FpmycAvBjjZzv7KUpX3+9U9QFTuLUSO6nTiU3u2GbQU6h/qa4Td29onnnyUIwBD6PBi3PUj7rsGmYdqestXwzOc58NWR7sEgYR0qkjBdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550152; c=relaxed/simple;
	bh=W61G01S/hjeGEv4qp9hYOIrG9IV5xVZozwxdnc3blAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZysCtegwi+sC9MXTmLw6r2ZvOmyZoCiA5Q2budEo6WRCZD3J+9SdncUN50Vs3Ino3PY30+HopGNdTrxCri7xkTVgB3bcT1QCGk5tCdLgOmzwgiM0W9ei6lQeFFLmuITc7VmkOiUoRPmuaZ1cbwCqdgfQg2QRQECOlDB6TZElBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtBROAtD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtBROAtD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-236470b2dceso48442205ad.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751550150; x=1752154950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gxXxpD+dkLD1Vl54sHq53V6J1hpHOJcitCZ0rWyKUI=;
        b=gtBROAtDKDAuJUD5cQS8k9VFncjzxPaAdZgISeafzIchh/wBdVWcPLs2uTDXihgvJO
         zAjQkG/3x9rharxuzIJ2muLmAYsNwR/J0/cAP7a3rLw1okta9YkoxNb0Vf3vJNID9HYU
         7XggKRPfij5lLvyJAj/zBY+nxiKvNQYOZHA1mKfq/bEp+5sAiX6sROfwp0CMAY01zvrH
         spcKefN3hd0zkL6FUQOyULYlNK8zpGB6mkkHg2hO4P40h3gyOz8G8Uzs6b3VbDUlK39G
         JqEMHBGbeLGAsR8N6mKPHa+S1rOYC6AgajZmzGikaPu+BMcZOlx2yhgxLynDKOx9NdKW
         WF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751550150; x=1752154950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gxXxpD+dkLD1Vl54sHq53V6J1hpHOJcitCZ0rWyKUI=;
        b=m6Iv50wOmFcIYAYCrK3XNWti0MqYrfaJggqZYDpszDAnc3+wpMMXUF96th1uc7oG0C
         1zufO3aSC7gkrRo69OWIxWfieMF3WT/L+GfsWEwhfeQoSYFQnNWA6xa2CEcdQN1PIHRb
         xJZ7LeWPwD3XEr30OdViskuXEoZJaVrRb3QrMcKtYKqRxaZWlt5NCLep2VRIKY3OdwWc
         kvg3EZaivMvPScpuRWspm7Xa6LDsXIuvhwPZUwTf8DpXxHgS4A2dDyvU7+yIYi6BcTYD
         wLHWEpJro7ZNmzfTMBfjV7ZNhUAdSQObEwF8XDciSVvPI2tOHrtugXofZ42UC7Q7/NT8
         dAxg==
X-Gm-Message-State: AOJu0YxflFF9QOtFZTP+/KqxTGyZjJSeA+6E/CnZ+Vv6/V+EhLYWC5/n
	xN2bQF9mGLb5QAvskWGuF/3k77L1eZr0ZcwM9fujppjONzLkNdzmBzZwwO70Hw==
X-Gm-Gg: ASbGncuhV559wdKuXKse0K9vB3z8+HfPwSK43mEPa27NUBDHtR2f4tZFKXwjxCDn9Tn
	AOSb8gSVDwJXjAb6hkHz/lX8EOdyeVMBhadIJNkpeTDMxfIJCf06BLF/He/8PVFwS22kkrOZZRP
	O5VTPLOnFpz62nRnuODbbOO8DZQuoev0fzyVTVZd7PZS88udfzDGcaI3+63HX1eCUFaTDC6Pih8
	78bgJO6Ic1slBtFWn9XMidBQxxRB7LfHFyYOc5DW/OfhggMVz7OlAJA7O2Ja1RoRn+MlKf3WqA5
	1aXbPS4IizVUZbC3NzEOTD1I+Q+4p5vxcWGWbor7YhkVrywCYX72dCLZoJJyAqTWiFbuwYfd1MU
	=
X-Google-Smtp-Source: AGHT+IEw7pHQPUKSB2koPcaXUikGpx1Smds13j3jk6CPTyRMGlLK5Ovq6Rq8JLVDT//8caXx9puw3g==
X-Received: by 2002:a17:903:1a70:b0:234:ba37:879e with SMTP id d9443c01a7336-23c6e5b0f47mr125555645ad.38.1751550150155;
        Thu, 03 Jul 2025 06:42:30 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm153819065ad.214.2025.07.03.06.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:42:29 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: ericsalem@gmail.com
Cc: git@vger.kernel.org
Subject: Re Behavior of git log --diff-filter=d
Date: Thu,  3 Jul 2025 19:12:20 +0530
Message-ID: <20250703134220.31638-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
References: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Nice question

Yes, this is expected behavior
You're seeing a difference because

--diff-filter=d tells Git to exclude commits that have deleted files in their diffs.
However, this filter only applies if there is a diff to filter.

In other words, 
if you run git log --format="%H" --diff-filter=d, 
Git doesn't show any output unless 
the diff logic is actually invoked. 
But --format="%H" alone does not invoke diff generation...
so --diff-filter silently does nothing.

When you add --stat or --name-only, 
you're explicitly telling Git: 
"Please compute the diff". 

Now Git has something to filter, 
and it applies --diff-filter=d 
to exclude those diffs that involve deletions.

If you want to exclude deletion commits and get just commit hashes
This is something I think should work
probably set this up with an alias if you use this many times

git log --format="%H" --diff-filter=d --name-only | grep -v '^$'

This should work just fine...

Or perhaps if you wanna tinker more
git log --format="%H" --diff-filter=d --stat | grep -B1 -v "delete mode"

But if you're just trying to filter commits 
by file change type and want to see 
only those hashes where a deleted file is not present, 
you'll need some way to trigger the diff 
even if you discard the output later.

Hope that helps :)

Thank you,

- Jayatheerth
