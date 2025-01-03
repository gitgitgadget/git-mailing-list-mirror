Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57261F9EAF
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904049; cv=none; b=iXPjYAY5+1nbfMNqLoB4Pr9CXOnc0kjPVMoP7VkR0AWuM1/+4K/YOnadCix0w1BIE7ywl4qU0vuycbttkbP3FsiB8H5lxD48AZDowl5b/jmrQ54kfQqqFcDHkTjascKAvmpqFw0DFzWW1IVlkR5lpv+65PxWMjA/w4nB1rvosz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904049; c=relaxed/simple;
	bh=A4xbpSb6US5AthBXX5UI9fz5QGpJhNVSXpjAc/EoyW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/3z7Had7wmrVL9QTw5dpFrGgjEFjTcXBl41HbQBoGeZLWpBGj38pvXn4SIzetu3UBNIZMTRB/wrzs17YJ/I3SezqAy3Zd8FnGrfJkLLAaGvVgIvcK1GMY50qwAJei8pNZARzJ9KxISEn+7UDDLh2NNLbUZMCxq38/UHshZ+PIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyiI8t+I; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyiI8t+I"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3022484d4e4so151243681fa.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 03:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735904046; x=1736508846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AYxCk1HbI9ozu7g6ZWktVvzLDZBrIVqSnYD/fWrrOU=;
        b=AyiI8t+IuKdPASeXrXqvD6o5QHGY+3Iza1QbyD0ghLdN/PvF32Y5DSNkpL6/vCapPV
         eCBhIoOObPi8wWXTRv6o8MRYpHqxrB9+cHOgAsMmCo9QMO4GZKnp3jjEba5xdLY9UkbK
         B1aP5XL5WHjuDEYzPjvrb4KPd7zwjiuEHVYHLY90t+T2piQ07fSE4rIQ4+kZ2ER9r4ji
         9iByiv3McbUXQfyiS8g1LAq5AIe2Is9iaH3yc06+Ab6JBkW1QCuvst5BtRcO/kDMKdcB
         LTPNAOeN5umVSIY8DNsS75Zl94HHtr6+xAZZt7KkIGYn0k39lSgZh7mDcfqbB39DihKl
         II2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904046; x=1736508846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AYxCk1HbI9ozu7g6ZWktVvzLDZBrIVqSnYD/fWrrOU=;
        b=QCBgV9a1NIjwSSZ2QVoaQTeY0jkaPRstNAOJ2h4cOQ7ujxtS6DJ12s3BVjm5MWpcIN
         JWR2RJlx/4f/k92icx9B0lIB/NhKXXuCKJeHHACkQMTAU8auqiFcde8Q6QSmpID/AJoj
         2FxXh6/cWwtFJTcHJrD8QN1kVYqnRinkqWRXq1gwsvkvb3sry57z4C7FCsfjNkOWHJ5A
         E+gNPdG9pPDhc7CSGua960WZA1Igp/NgN8V/KErMTTjYFeXS5oEEnrJKOTmx7HhD6A81
         WF7DJFab+XtEDTrrtKb+qusB7hIUkP60ReJutuwxmtubRPK6gpwMCgk+kLcjTU9yz4vZ
         RH5g==
X-Gm-Message-State: AOJu0YymyRHidn3MAuqZFcWULcFK4bjUWjiNw3035Zv57d+QV/D4ITcS
	Wvv1iHi81iE85nPS7zvrXLtOWgX1jIBG2xSvzekVZttN1EWfENqDQgywzQ==
X-Gm-Gg: ASbGnctIv6rMcZv6WXDDfuU+ErcRkn6T7uMw92po9qQAbgVqRtW6uUfWJOgQpa7v2Ar
	UBNCzphI9iD7yOK9s5fKhe429zls7w2U7+2RwU/jAMQHtYBj6uYzfbZK4oSLKTlptHI+5oLPWBr
	LdK/F2sm9ns55/SXJX2jsr+aCq5ZD/m8BnXXeAqtdxZtmC7m1Tz9dJqA1aXv8Es4Js0u2YBY5RF
	BBHGROcpNZKTk+4ptaFUilf2OwQomOppG8541FpoacBHJO/Wo29RjC/SaH0RGY1Wx61xSlY4RQX
	wQfThmhvtHeQVX2bM633MrFOf15IUsI=
X-Google-Smtp-Source: AGHT+IHi+c8BtG+pQHkIR83Vqsee47CQjM3UTz2wsriHOpjpbkgnIApqVuD4ch9OiGeOVHxRoUUVtA==
X-Received: by 2002:a05:651c:611:b0:2fb:54d7:71b5 with SMTP id 38308e7fff4ca-304685785c2mr131665681fa.22.1735904045570;
        Fri, 03 Jan 2025 03:34:05 -0800 (PST)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad99d06sm49527951fa.34.2025.01.03.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:34:05 -0800 (PST)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Alejandro Barreto <alejandro.barreto@ni.com>
Subject: [PATCH 2/2] gitcli.txt: typeset pathnames as monospace
Date: Fri,  3 Jan 2025 12:33:31 +0100
Message-ID: <6e0abe96b60a94d4fdee15a45b7d53c2f44a0c69.1735903029.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.48.0.rc1.241.g6c04ab211c
In-Reply-To: <cover.1735903029.git.martin.agren@gmail.com>
References: <cover.1735903029.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 1bc1e94091 (doc: option value may be separate for valid reasons,
2024-11-25) added a paragraph discussing tilde-expansion of, e.g.,
~/directory/file.

The tilde character has a special meaning to asciidoc tools. In this
particular case, AsciiDoc matches up the two tildes in "e.g.
~/directory/file or ~u/d/f" and sets the text between them using
subscript. In the manpage, where subscripting is not possible, this
renders as "e.g.  /directory/file oru/d/f".

These paths are literal values, which our coding guidelines want typeset
as verbatim using backticks. Do that. One effect of this is indeed that
the asciidoc tools stop interpreting tilde and other special characters.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/gitcli.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index bd62cbd043..fcd86d2eee 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -91,7 +91,7 @@ scripting Git:
    written in the 'stuck' form.
 
  * Despite the above suggestion, when Arg is a path relative to the
-   home directory of a user, e.g. ~/directory/file or ~u/d/f, you
+   home directory of a user, e.g. `~/directory/file` or `~u/d/f`, you
    may want to use the separate form, e.g. `git foo --file ~/mine`,
    not `git foo --file=~/mine`.  The shell will expand `~/` in the
    former to your home directory, but most shells keep the tilde in
-- 
2.48.0.rc1.241.g6c04ab211c

