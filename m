Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8632DEA89
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781233223; cv=none; b=Q90ilzoU0qvboaQNbu6OMHuaL0KoyZCPBf2w8hQ34b2qXJhjMdU9pdl4tsHRFFHmX6xIOX4nA7wtJMdTFQigLeEZPkv69VyzfMZIlGz9Intd6xxrOzl62kAte4TcRp8UIb/5YSxpgXg2Z+OLrz1SfBOpKQiWKUFwqiJCauNTKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781233223; c=relaxed/simple;
	bh=ZtNF9PQGsWr03Lg2O7q3BrTqpcgNJgljaTCbnLedHis=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=jLXGijMWG6ABQaJ02rVAn8RRDTtsrhj7TSxmkZ3fcrdgZzgsnZl/aXm19zSiR3Fc/ICSp+9M2DDKu7iGy4XtwbE03MgNhvYRnH6jIVBDgWUgYcvRqBytiwulBdHfm39v62wNwZkstHICY4R+lKca7xv5aOJrn8Jy3Mf9let0bWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjDoAYVL; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjDoAYVL"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43d133d9a28so243025fac.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781233221; x=1781838021; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVbcyI2E7izrlgu5qlr6t3x2PaLtBmz++uz9TRddrPw=;
        b=gjDoAYVL4nwgI4rJpUfiUJ33v3NBRUEwX+HJw/ADfRgx1yFw/IgsXU26l0vVFDUfeA
         v2R4sxg1A/yus1wy73QfqnMSXoZlZaUSMwp+DfUj1RONETKkd8iadWKk0J05T0M1Q9x8
         Eyq0bi2IqjBGXToLviVK50GqIWjeR1IQ2QPDV+FlBmddaOzpiKa3luQJSvQzjMGZLllq
         H7loSCJ6wedDJW1QNIR131/UJh2ZYLrtGC7YGdS+i3IR1hrCAIy0D6NH4M8GyKOF60RC
         ico/p3uxLxb9xFdtIiRW7evFCJDugXxAYtY/8H55j6b7GMDwHYqrwdCFyijQiq1UE7pJ
         oybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781233221; x=1781838021;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVbcyI2E7izrlgu5qlr6t3x2PaLtBmz++uz9TRddrPw=;
        b=WdO0gZLqcv4cNjM6MOlviCf3f7Rwyu58axZlbuB9HZCNqGTcFFF0Xy3ukuuxST2Vgb
         E7F6PE/eCHFzdMbsr8o1KuYS06GWjYtHQe27eHCqaFb9U89UL7WjPw+t4+1WIKIo8Dbg
         FLNNtJZEUC96oz0MbjY7RfLazl+PBeoROYIP5oTqK7nU/uigPKJQbZd74TMqqzmZCa7y
         uz+Krqf6IhLJ4Q7wzi0Pal3MKHe7oiT/vaTSfuj8KpydVfPWANlJ/uMCTGqhcru5bczx
         G3XuL61NbkLRgugXBi1zJDwR83ZAOO2VP6Dfsi9tnSSCpT2SGUUkhtdmzjDiQoerxOuF
         GPAw==
X-Gm-Message-State: AOJu0YyoCDtN4meUR6DElm5/f8wkbJ3yt6voK5cMtiINUPu3dSHEsMm+
	NluSjjIHXTJenUmFX8fd6S71Y0j3H95EcyAvpm8UNZlWksAknwcqNp5Y
X-Gm-Gg: Acq92OFtU1vcgi+cM2QXKEgH8MYawpoN1BmeJ8jz8MJIzU8cTAY34lHQ+GMLA1CpTpg
	yjmT7O8GRYpYQGACyiO46BVSvmGu4wcCHL3GKsJx+sv3Nr/IFqoPdpbHjYInI99RIucwMLdn/Wf
	AV62aqs+0RKTI7hkbgm4q4wkfdQU1zxFybDhk4JAPNmM8EIPbg+bWBvjgSj1vIJiJP8Ra/+N3Qu
	JYYUAJM9xnRLdWdviYYK3xk02JIVyskAfbGX2igfZWsHtHGyN8IFFPVdC6r9rF+nXT40dJ7e4zB
	FHuujKrLx9OOD4+HUeoZfW+cOlI6oRkvsjtsDdHl5zLLN579uXwpe79GaVZC9JoLGZbdlW2a86/
	gVRrQryL5ZDeqNBf5wJyIhMCyYRIkes7dKf+k9r5OHMXlv+qEKRf3OKYpuZpP/ObEATlMmuWCoE
	g39noOibS77jt/ibl8DtE2ZUy2/z9fgZFshsKaequby9SXFVGVjCJ7C0VIUsPA2iqyNn/CNBa5O
	xZAcF1oKcQOGbvjNJpw2GlDMcsMczul8jNWzhPkqed/qvSuheSX9GCA6iFobSLEfobMkJOHHsZc
	rVdsZuTWRRn99M+uC2HfRlGD6s62keQUdGy6HRkWX9SVdwz+t0e4
X-Received: by 2002:a05:6871:281:b0:417:6224:5855 with SMTP id 586e51a60fabf-4426d640d1cmr588641fac.0.1781233221090;
        Thu, 11 Jun 2026 20:00:21 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.237.239.3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abe97c4sm702031fac.7.2026.06.11.20.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:00:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/3] Reuse --contains traversal results
Date: Thu, 11 Jun 2026 20:00:12 -0700
Message-Id: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBAAv0J6dk1bCBVP/sN4KNtF1gA1LRKV8
 HcBL9z0OMlkZhSRAlMUx2QUgQaO7LsZ0l0isLbdlYDdzEJLnctcGghUQcVNTwFaaj2/yQH6rrf
 cRTBY5mVaIlqnxJy4zzY/1/z58uX4KG+E/dJcjJpj78Nr/Q9q8f5cDQoUWFUY7RwVaPLTtbXc7
 NG3YlkNehs7/IhpkEBGGy3TLLMGt7Fpmj5hOJHtJwEAAA==
X-Change-ID: 20260607-ref-filter-memoized-contains-7cb6b3bccad1
In-Reply-To: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781233216; l=1976;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ZtNF9PQGsWr03Lg2O7q3BrTqpcgNJgljaTCbnLedHis=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG75bBYufMVzAWem5UzOfUt4lAbfwAB0iIPJsJCgB45Ktc+zbfTTjC64JgF0v0GsgI9ZVLwN5xE
 1zuCAciVQHQU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

git tag uses a memoized traversal for --contains, while git branch
and git for-each-ref repeat a reachability walk for each ref. Reuse
the memoized traversal when generation numbers can bound the walk.

The first patch makes the memoized traversal handle replacement
cycles. The last makes the non-memoized path report reachability
errors.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>

---
Changes in v3:
- Split missing-ancestor error handling into its own patch.
- Use die() for reachability errors, remove redundant cache setup, and
  chain cycle-test cleanup.
- Drop the unrelated empty-target-list behavior change.
- Explain why git tag retains memoization without generation numbers.
- Add p1500 coverage for all three frontends and a shared-history
  case.
- Remove correctness checks from p1500 and drop output hashes.
- Link to v2: https://patch.msgid.link/20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com

Changes in v2:
- Split cycle handling into a preparatory patch.
- Exercise cycle handling through the existing git tag path.
- Move perf result verification out of setup.
- Link to v1: https://patch.msgid.link/20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com

---
Tamir Duberstein (3):
      commit-reach: handle cycles in contains walk
      ref-filter: memoize --contains with generations
      commit-reach: die on contains walk errors

 commit-reach.c                 | 40 ++++++++++++++++++++++++++++++++++------
 commit-reach.h                 |  3 ++-
 t/perf/p1500-graph-walks.sh    | 28 +++++++++++++++++++++++++++-
 t/t6301-for-each-ref-errors.sh | 22 ++++++++++++++++++++++
 t/t7004-tag.sh                 | 21 +++++++++++++++++++++
 5 files changed, 106 insertions(+), 8 deletions(-)
---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ref-filter-memoized-contains-7cb6b3bccad1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

