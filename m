Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D669446A1
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878325; cv=none; b=MF2SgYR0oehQ9szh5b50+mSqfuXhF+7SpkGMxGKquAlE3P5XKHPhjlEVWo9K5a7jD4pQ74L+uHg7nJXmDeN/YuyXxpeDXjRCPEIGyfrza52H/AuXvQk9MWyAbK8lLo/L9C5k0E/weWxD14vMsXYNTv49sf7d3DYj+01YrXrCkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878325; c=relaxed/simple;
	bh=fXYkwyyNJCLwx/1+LXMILAXgVK2bnFuuMMrPjySB8G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRsMewhTOrpoLSdZWNdVtr+pVZvXs/ie+nc56Y7cmppGAkE2TvbcFNV0HGDu74vzJePgK5kwcEX6bGVXIRzz+vtgSKBCVwZy18aPzhYuoPWkC836OauiEDyFlD45K179bca+Bsd2LpvxDxznBggvXW3X7RrXQBQ2OlDaqo3jFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9Uk8nVZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9Uk8nVZ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so1749446f8f.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878322; x=1721483122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=k9Uk8nVZ4GljDFeQ5da1YUfulwhzUDfqifh25CH6ZRq9hTgTxTgZi7qtHkz1QWNYSg
         0Z7zAejJ1Q336QyD3cB7EHeWYE0Nv445hfDwoLZVVfIFDMTeJ+4kirplitrB4B4oytQj
         pcUzO/VC4M2eiq9DxcHI7zW/CH/p3S4XHY/+yU2e1RVj/Oq4dEk7dO9rGm5nyNnpmNN0
         R+DYKojGQcLN3BgoRHS89JkxtjqXnh5hwXyQnkWoZNPWYo8/n4Iyd8VEsFdAADSnAh2l
         nGIAJ2KGqjljh93vvJ9kC5NqGG8uTmqnYY0C6BknEgnTQrNdQdD9eFm1k4GCdIGgt/OD
         sROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878322; x=1721483122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=U2k3iilG3mqaaHosfvR4xwGx/ZigE4Pg1sQHrSL/Pu8eVrWt7Q8ZNUkfFGTF3b+s2d
         EAkwDjLNxEbTj7Z5uO5MKAxZy7IR5VMBSVgiwdxOunSh5gSJWqVnLOsVXKCS3DNZ4Tz3
         PF9uJ1ox1ifoUf9wPr3HGaFy8HpkXzxV99qLVbgxSJtoEKrxfNI5I5s5jqb4rEB2ET46
         OnCM7/jRkhf6MRgT5rVP4BYp3mUvnc9/Czlj2gDsMV7TR0gg927fytpZYlIi3FW7LLQ1
         MoN1qWHqIXqdk5MEDhA/ZVKU5fxRaAf8teKSYCIbPAaYNeqJ4owUfdftSbS1v8QNmLkN
         xchA==
X-Forwarded-Encrypted: i=1; AJvYcCVuc2V1VP+4sUwx42dRsFp5RX+6bsDGxIPX2jhny9G/zdA3fv81Fc6Db45B3meaRdm/dCP7Ehhmq7xPjNrcrGzLO/71
X-Gm-Message-State: AOJu0YzvUi6PeLmFTO8zsjOSEb8q23UYcSRdXMkfc4PDVWSwKGXzdJTM
	cZU1/0nYNIQgmcUPEIQRpa+WirAEM178pL0BScdPcqMjOGbjNOQ91XcZn6cd
X-Google-Smtp-Source: AGHT+IE7aRQqK1ff7hjDyYrbDGL7x1d3YjeGU4PSVE8zTUFuJFtU7ysdsQUiTcAnKQmwOaeES+zqJQ==
X-Received: by 2002:adf:f348:0:b0:360:7887:31ae with SMTP id ffacd0b85a97d-367ceacb451mr9496911f8f.54.1720878322304;
        Sat, 13 Jul 2024 06:45:22 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:21 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 1/8] clang-format: indent preprocessor directives after hash
Date: Sat, 13 Jul 2024 15:45:11 +0200
Message-ID: <20240713134518.773053-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not have a rule around the indentation of preprocessor directives.
This was also discussed on the list [1], noting how there is often
inconsistency in the styling. While there was discussion, there was no
conclusion around what is the preferred style here. One style being
indenting after the hash:

    #if FOO
    #  if BAR
    #    include <foo>
    #  endif
    #endif

The other being before the hash:

    #if FOO
      #if BAR
        #include <foo>
      #endif
    #endif

Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
our '.clang-format'. There is no clear reason to pick one over the
other, but it would definitely be nicer to be consistent.

[1]: https://lore.kernel.org/r/xmqqwmmm1bw6.fsf@gitster.g

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.clang-format b/.clang-format
index 3ed4fac753..5e128519bf 100644
--- a/.clang-format
+++ b/.clang-format
@@ -96,6 +96,12 @@ BreakStringLiterals: false
 # Switch statement body is always indented one level more than case labels.
 IndentCaseLabels: false
 
+# Indents directives before the hash.
+# #if FOO
+# #  include <foo>
+# #endif
+IndentPPDirectives: AfterHash
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.2

