Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FF286430
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307466; cv=none; b=alKvASDwiWla4RGhv/hNnHecqwg16jFGsDA8U2SPyWjUg040DFOkz+msa7v3BvrRJmtY2A+ClJwsDVFgnR3C1svzaRTv83QrSGo/01hYeNP4rYygW5VK79jiTp8PP3ZcRdBPta6PrKrl2LJK7YQjSWMZDWWxmRifHxESAaF4tL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307466; c=relaxed/simple;
	bh=s5wHGDr1kf08RS/VwH8fmHggIauDu2MY2yv5nUK9tZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTP2lBdMuUMRiTT7oQD5qI4vG9kUvCZvId7vDrH5DP6KIlbvn02ZWVVXTgp1+3pAlhlNLY+ReqP2n9uoYDSSoxYKO506lclH2oeKsUgRuuDgKmQK+/dnkBrli+WfhTaNWZvApl+f0C4mrItvCHuCJTixQ7p0d2k3npYSVWZASzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLWjx1rD; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLWjx1rD"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64455a2a096so9353379d50.3
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 14:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767307462; x=1767912262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31PwJOm2UGOFi4D1ictBvZ5tVOsZVI4Rb8m5Q8QyJEw=;
        b=mLWjx1rDKXdEi75kYVTQAjbaHHGN01E9WnvnPltrn7HTPe/+xzm4yb6/XMaoOvk307
         VhodUVzFUmY7UH6RcJGbMAtUIP2fQLFkfsQXheJPvEwAqlB+ujhvh88QU099rXiZfpdn
         grAs5IrxjFljHgAT1UY7FAK+219R0RdvHzSH2GmqKzUR0O2SOktxYz1j22H8xDxpG9wZ
         horHYXUjrkoTkRfCsOEU+82UXvnw2ooBFnjyPCV+25DgfaXNvVekaTv8tjeejOH54SDR
         /7SD+MKF1hvmdqcpydb/sw8fvRAFkP7NHD5ge8lNkCJU4CFH7CBrfiPjiGENdBxWoXR1
         7AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767307462; x=1767912262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31PwJOm2UGOFi4D1ictBvZ5tVOsZVI4Rb8m5Q8QyJEw=;
        b=ZPWdPmLihcSR+mZ9tAZaalqrZguJq2QhC6+SisfkgEvlyy9nZyEYoLROwNqRIZeB3T
         2KVVKd8uyl4xKtUH4aRgP12Hc08shoQ4Ax8vQqn4Sh8h+qBWLOQmJcXB9yVCzZ7ZB/Z1
         RY0O0CgZTGUhelrUl+5pRQ5n+2ICCqESNFgJ87WeOV9tm1AqJ1lZ9NCCD3KKUoSVyakF
         QfG43/CGxqVi8vnwPFFv8t7dy7S5+A3qkpahGV/GPZVtAxhvCxB1WUvFElQL2Wxq9rBR
         cL7okkEC44zl3J4rGrvbNKzL5ESQHFSfCPgClLsb40bm7ln1SWzdrvVBaCiCrdntPh99
         Gf4w==
X-Gm-Message-State: AOJu0YzcUWgZ/E6atVT7ah+FWD+y7seQA3G5HSW6/e6hIy2v2Q0DMDLA
	UXY6W0UreZGXCrlKf0napNQgx3XrhcdGxXrbT+OFJ27gNHeSZ7A4mA7/LjaYAg==
X-Gm-Gg: AY/fxX5zGWLlZK9oEgf4dqkoKq6tqJ0crCQt6fAXDngBimKDPmr3b+hLDD21TO/BoP0
	FzZC+CMRJYSNUrvT3iDKqvZAnVh/6E8jXZxW6MkQZ0S0A9o/RYQtQqMmEbz9yDoE4H+D6UVR0wY
	rSG+vdXXlDpURPHqdIQO5BemnxMmevkq56lMEVM4Y7+3OxaSKI8dTM5/JJlxs1fT82XMG6DtmPv
	0EWaWu0bJMkcfDSJWLzM9mBq7DnT8uuDxSUR+RjpFPsf87o0y+EBRHpOt6E+U1ufS+Ylq/erN18
	cGr36ZcDMwQTKUoQ2+Ur+Gut29V+aVay2vPjItQGsG8jr80uGSPg6k4s6BWceuO6g5L+9WNsG1V
	49g3Pj2ynI4EPvp3BnlpRqRdqP8uZzjkyNj7FYHEIzFRE6VJ3YwThAv0YkVVmLv6vudHc5q8I2C
	iw8I177djJfqvkEREGqxR7H0xXqQ==
X-Google-Smtp-Source: AGHT+IEkx9KwleHBx63OI8s5oX2P/YmuUlv+djHGDHYSMvaVQPTSLWAoBFwssY80MHUeL0zM7fdUmQ==
X-Received: by 2002:a05:690c:2601:b0:78c:697e:738 with SMTP id 00721157ae682-78fb3f37a5amr700389307b3.18.1767307462197;
        Thu, 01 Jan 2026 14:44:22 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43790dcsm150521117b3.11.2026.01.01.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 14:44:21 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 0/4] doc: git-reset: clarify DESCRIPTION section
Date: Thu,  1 Jan 2026 17:43:55 -0500
Message-ID: <cover.1767307382.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1766103827.git.ben.knoble+github@gmail.com>
References: <cover.1766103827.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues Julia Evans's excellent work updating the git-reset docs.

Changes in v3:
- Adjust "git reset -p" description per Junio's review

Changes in v2:
- Mostly address Junio's review while keeping to Julia's style (?),
  taking at a stab at a few gray areas.
- I left alone the first patch, the commented-upon part of which is
  later rewritten anyway.

v1: https://lore.kernel.org/git/pull.1991.git.1760731558.gitgitgadget@gmail.com/
v2: https://lore.kernel.org/git/cover.1766103827.git.ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/git/tree/bk/je/doc-reset
Generated-with: git format-patch -v3 --in-reply-to=cover.1766103827.git.ben.knoble+github@gmail.com --range-diff=d6582dc53ca852ef01421d2dd2c446dadb731dad~4..d6582dc53ca852ef01421d2dd2c446dadb731dad -o PATCHES origin.. --cc 'Julia Evans <julia@jvns.ca>'

Julia Evans (4):
  doc: git-reset: reorder the forms
  doc: git-reset: clarify intro
  doc: git-reset: clarify `git reset [mode]`
  doc: git-reset: clarify `git reset <pathspec>`

 Documentation/git-reset.adoc | 105 ++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 51 deletions(-)

Diff-intervalle contre v2 :
1:  a558c5a868 = 1:  a558c5a868 doc: git-reset: reorder the forms
2:  f90be8559f = 2:  f90be8559f doc: git-reset: clarify intro
3:  89c87c14aa = 3:  89c87c14aa doc: git-reset: clarify `git reset [mode]`
4:  d6582dc53c ! 4:  96566265d8 doc: git-reset: clarify `git reset <pathspec>`
    @@ Documentation/git-reset.adoc: linkgit:git-add[1]).
     -	in reverse to the index.
     +	Interactively select changes from the difference between the index
     +	and the specified commit or tree (which defaults to `HEAD`).
    -+	The chosen changes are added to the index.
    ++	The index is modified using the chosen changes.
      +
      This means that `git reset -p` is the opposite of `git add -p`, i.e.
     -you can use it to selectively reset hunks. See the "Interactive Mode"

base-commit: f229982df19c327876ce7ded40f6efefe20da5d4
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

