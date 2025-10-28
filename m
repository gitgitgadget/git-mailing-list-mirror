Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1770D2D739C
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639189; cv=none; b=EpF9UGjXC7cyDvNmEzl/5wPOl6PJUNr7wxxGraRtgRCqqoEedWk5xCATiKgOd1LvIWi0kZhA2SESYLeNlakktP05tBF5XZIjGWw3MjD5I5BPhEx4qAkN5k0lJzytXMDmOTrpD2Nh+qgSKiO66PeHtf6arfU4GhF7xL4ofqM8jYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639189; c=relaxed/simple;
	bh=zRDBHPmi3HAVjrYLzJSA30/BSPrd9QAhq4wDiX8LGZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPnVAUdrntYMmoAYVfq7FocFj/0fhXnyVVv7DioVEMyh9EAHrMcvR2IITqC2i8PGu9Hw4GvKp02U/JIDz02jpdd0FSYQ+JGRzc6zWgTh3Yttnym6ZuON9c9lJ6QzeYU3v1QsPci8TSKNn/VyJh+Ub8R3ZAVVxdkDeIHwhXwAqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+HKvlGS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+HKvlGS"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42420c7de22so2805573f8f.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761639183; x=1762243983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyQ05EYVWrLBRWkDQel5ldfPtn92oQBbkUI1hW4cC/E=;
        b=g+HKvlGSWh8tj8nX/U8NeSykEfYLBZn9vkShWc80hbgbGdUMvouI+nNgeEKsL7lcrK
         m0hZ0AIJrHigfH8zdISukfauuOQwiFzJb1n2bQsxO1nP1AjKnitEoU5GdK9MNrvXFFUw
         M6KH+nqjgbgNXy9ejdjYClrJNAeZHKNVeaPONdXcECQsIKA6a2NmUVlUP0mtNXof5vnD
         1WnoX4WoV5qvOIrR+tNfbo0e6Gda8rvvXtlmdluK93dySaebPBdLUU4/5jAImIYmWTKS
         +CwnUgIolNlEMcyi720cchaXBi1QHbmofou89Cp3jTIKrDrccM0fO7C8nbTBPeF/Ha6M
         Nnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761639183; x=1762243983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyQ05EYVWrLBRWkDQel5ldfPtn92oQBbkUI1hW4cC/E=;
        b=PybwveQoAJMLL0VEk84HZvDkv9kXR3L1fF7VxWbWxpqUMQAr3Y0+tYx+IQJlkRmLfj
         3JZJHF1i7ncv+AN8n/2qYWSBvR8JuBZ9+ycC82g8229lTo69/m9DaE5OedDS4/Wsfyz7
         u1yGhz4mQV0Q6TpQl/wdGjLLJTvstIgLVKxoNXvyQ+W1jPfzije5sJQt5ICN6riqXOyA
         sy9IjOUp3S2/uW5u7WwtpsovVV0wQdS6xPE02H4n+AzdPdfZIblCynTDkow5X6hgjdL0
         TzX04IuabrHDSKJphBjbJGuZYUbE5s/LZ+WBYGCcfBNbkmvOFcvav+eJzDx25C9boZCV
         bzag==
X-Gm-Message-State: AOJu0Yzc30teGXbfcPrvCyYbY0yMTGe8aqHv/dVEQo7VhOrKm72BSkwC
	9TgYcalIZzMQt7P7kAXfbkLpSl7LZJV9kLTL7gPhH+9RaZP2xEct67RfEAi+SQ==
X-Gm-Gg: ASbGncsUbG6Gb1+bO5JjMc9KxrbYP+gJco7SkGG4GFfEy0Cy3DEwfDrpHxL7HtI32BT
	FHq10/oeGcfMHfoql0RjKwBUFndjizyPuxvEBKH4Ftr7lKfqZ4uJ7gb/b4KtMSFHw0wGXngrcI7
	xYNVrW6pwFrmUtuFQ4QJzcAf62gOiLQUt0Swc9BbF3bt3dCuzXY5tIB9l2P68yKboAO6yhx+EHG
	ndCIGGktw2bVutgocRs6gW4DnM/scD+ndZ8BjtEkdkicDhxhtUl+MefLvOn3kXiSOTyBdNwVzg6
	fpDT00IQc+2mB++G2JBaqj5or7PzpTxamM9lFgqJPB8TX6vGf5RiBebZuk7xp6P7j3LVfGC2vH+
	crzq3fSgAgZu54E3J51R5dZYcaZx4ygNsIjnk9fUxTkgrmjPfPulgJbgrWfYHKolguZbE9hFKTC
	EXHcUrJTHNXvp9UKAqT2abBD1FGrA=
X-Google-Smtp-Source: AGHT+IHuqreGNtojf4D/slE6f/BmVtTJhwRZOLtKWqJl1DhqyPScaJRDrzVvZbB8n26r7R2Tlc6w9g==
X-Received: by 2002:a05:600c:4686:b0:471:15bb:ad7b with SMTP id 5b1f17b1804b1-47717deeb8cmr23449865e9.6.1761639182678;
        Tue, 28 Oct 2025 01:13:02 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm12830335e9.14.2025.10.28.01.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:13:01 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] gpg-interface: simplify ssh fingerprint parsing
Date: Tue, 28 Oct 2025 09:12:28 +0100
Message-ID: <20251028081232.3068147-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.540.g4ad31e1014
In-Reply-To: <20251028081232.3068147-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "gpg-interface.c", the 'parse_ssh_output()' function takes a
'struct signature_check *sigc' argument and populates many members of
this 'sigc' using information parsed from 'sigc->output' which
contains the ouput of an `ssh-keygen -Y ...` command that was used to
verify an SSH signature.

When it populates 'sigc->fingerprint' though, it uses
`xstrdup(strstr(line, "key ") + 4)` while `strstr(line, "key ")` has
already been computed a few lines above and is already available in
the `key` variable.

Let's simplify this.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2f4f0e32cb..91d1b58cb4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -443,7 +443,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 
 	key = strstr(line, "key ");
 	if (key) {
-		sigc->fingerprint = xstrdup(strstr(line, "key ") + 4);
+		sigc->fingerprint = xstrdup(key + 4);
 		sigc->key = xstrdup(sigc->fingerprint);
 	} else {
 		/*
-- 
2.51.2.540.g4ad31e1014

