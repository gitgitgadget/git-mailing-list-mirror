Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD77494
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008539; cv=none; b=a/u76stkHAixjuoefOGGrFkhKrSWAseMyOA07HDNr3X/hsVk+ZA7wjpKwCBiNPSz7B9TXAu8rk4H+VUrGl0ayuE8WgePxsKC5mUw4gAdWI47eXkveXW9fkn+enH06AcUqLtiqDHhBiyyx/jez0jVD8kJGC0Ll6L981Kwxt4ikgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008539; c=relaxed/simple;
	bh=xdYPgGI72M1RM5DQR/qhb96POpw9arA+l/p3SCWbciU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pxxo0qFrYz8upn2sjobXToL1PHRDRVRnbBIWFaa/+wdgrVWnQx6LjjsYNAD8zpub0tS+Ho2janWJQhz2lwlZ7Nl8o3AcSU0SJ+JjcdBbHvy7Ek07yt6URNHri+dGP1NIuOxHSRa/7GMWRM6EaY967EpzlZ8+gUt9rITz+uIn06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA0DLp3O; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA0DLp3O"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0b111b59dfso2052758276.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722008537; x=1722613337; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vUs+hXgowKRI3H0R38V9qq6KDWlGyAQzRDI0ZaZf7tU=;
        b=aA0DLp3OUIwg+hbsffATqAsKrVUFxRK7P9Yk9OrRXasvZFA+ez07PJgwjytMjaNRh3
         WJeJvZ4TJPrNDXPf7CQQ4Gi1wUFHVftmq6wYAOfXaXeyGyjAs2Q0nkdxTWxCveUPge0K
         nS5XZw+Mf4wEuJuridvXjKBtqJ6PfkOctRaw0HaX8dd51rp1DBRpSjt0G57TgxThtSp4
         1Nz/s3HsTzcPvUQq5V5Woe1JH86BMKkG2J+m/RSpC3GR/mle1zQDWTQMw1WB7rWUNwWo
         0vvIbnhO+0LwAoEgf8+F+O65x3xv2od4wrCphBZCLYqSBZKqe339LMYmIgdKKshZe2uj
         Kx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008537; x=1722613337;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUs+hXgowKRI3H0R38V9qq6KDWlGyAQzRDI0ZaZf7tU=;
        b=gUhDxihGvvTEold96+xXVydpli7IimN5Wk7yWFdAQ+7f8UwO+bp4fYMQijn+nmXvy9
         0d5YAY//dTYyeT1wLR7AgIiHn+k71jXVByTo99Ffh2lfapuHmkOG9flTGgIQwu8tsPbu
         3ZT6FzsrchZVx6VqJZ7kqUdr0UOt9gnCMKvkCcMKgsWXcFobQmWM32eCNQwr78gzQNaq
         jJojiDafK45Dad5jveguzQXvEaemITt3yfh8QqZ26RGDfQ6i7EHVWcGyrOxqWWsVRVha
         JKLVUWRvakYrhMnaMQoMQ3Q0qxP48QZ4tQmHXOTJxTxYDoeKDWbJ1YI4xF8nhpKHR8rH
         vKkg==
X-Gm-Message-State: AOJu0YzEjFi1SUKTjkXiVHopjfP72wMva8cZwea9fLA/cEyi2oL3STFq
	E8qmIeNe3F4I30NjrbW/6IS8YT5/Qrz1ydjvlzAsCKTQ3QU4VbZv/bBi8Wp6Oh5PVwxVp3mnY5r
	gXdljQjEri7+lJprGJz5u4oH6rZpwBi/Y
X-Google-Smtp-Source: AGHT+IEz2oSckFfwPPeqzpPopGB8o94Zcvj/fKUTmyK8BHhbwLbN2OVM6ubV236v7H34bCZoD8gxp8lt2A3R3Qjr98g=
X-Received: by 2002:a25:d80f:0:b0:e0b:3dfe:9c7b with SMTP id
 3f1490d57ef6-e0b5447a0f9mr177634276.20.1722008536697; Fri, 26 Jul 2024
 08:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jayson Rhynas <jayrhynas@gmail.com>
Date: Fri, 26 Jul 2024 11:41:40 -0400
Message-ID: <CACStHN-Gs2Sxej+md6zWr3V1dFo+pp=B4yEPm9=uPambDR2NaQ@mail.gmail.com>
Subject: [PATCH] doc: fix hex code escapes in git-ls-files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The --format option on the git-ls-files man page states that `%xx`
interpolates to the character with hex code `xx`. This mirrors the
documentation and behavior of `git for-each-ref --format=...`. However,
in reality it requires the character with code `XX` to be specified as
`%xXX`, mirroring the behaviour of  `git log --format`.

Signed-off-by: Jayson Rhynas <jayrhynas@gmail.com>
---
 Documentation/git-ls-files.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d08c7da8f4..58c529afbe 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -219,9 +219,9 @@ followed by the  ("attr/<eolattr>").

 --format=<format>::
  A string that interpolates `%(fieldname)` from the result being shown.
- It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
- interpolates to character with hex code `xx`; for example `%00`
- interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
+ It also interpolates `%%` to `%`, and `%xXX` where `XX` are hex digits
+ interpolates to character with hex code `XX`; for example `%x00`
+ interpolates to `\0` (NUL), `%x09` to `\t` (TAB) and %x0a to `\n` (LF).
  --format cannot be combined with `-s`, `-o`, `-k`, `-t`, `--resolve-undo`
  and `--eol`.
 \--::

base-commit: c2b3f2b3cdbf5ad9feb978dd367d77561a1271f7
-- 
2.44.0
