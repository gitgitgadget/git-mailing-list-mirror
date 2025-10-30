Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123E19E7F7
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827632; cv=none; b=LQL4AiJq9Vd974tmyKXTI+5VDcw8+STzhR7NJxX7aHA71+ZPVKXrPItqs188Sd83CNyhFRRYiwgaoMIpqkjbVWkLg09utpyTIxnEG5zp/1aE3BX4JLoKxXhMc7JX0w/Gj4V+FIupdvkrXOe+WdAdIQezmGUAwnCEPegshKzEHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827632; c=relaxed/simple;
	bh=aCxa4Sgomj+GpoBRTTUPG6hkeK8tHrk9YwEHiptNIOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG2UtIqyNOtLFF538NwijwtOgTsR03Q1PPk5tH1f2g+N1pJAFO8RxfJ7tcSf9i/VaHRQZea5WNL3cJhIsyX7JSAuMJncsvw7vk/FQTIOau4EE2fu3c/YzUNiKhUZwrdlPWa4HKg8OCBmcmk5Xgo9mvl3V733Di6k8t0olQWo6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrfnNKmI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrfnNKmI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42421b1514fso616503f8f.2
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827628; x=1762432428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvGWZQDD+gwMAnyvqX2C+WF8Q2yRFU/eYJeWfGjwprY=;
        b=PrfnNKmIbivVaH2j5fC1yH6GjqkSXqzlar8uzVeFyexGiv8y5S6byhfR37sw11226w
         b+CJbPWsgHGaSSJ9C5wxYFnr6BXLs3cCVw09TTdGWugNA2E9KMnoAd5xT9kj4jpKQ+a+
         lt/06yIsN+Vxc9LwPOUwEnMYHzec+KV3Qhl26u4aDAAANICt5OiIvnH4DNcJlH4oLUrF
         aADdJTz77/YjLepOP5LJrajYSP6d4FIj79eJGWOlEVaatP185Y3p85mMWFJxen3LtXG0
         Y3AuNM5nRogWe0DEp8oJXaTnVlBgNsJ1oq79zkpA++Ks+UEXhxN4oiDEEXT0ff+Vk98e
         6yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827628; x=1762432428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvGWZQDD+gwMAnyvqX2C+WF8Q2yRFU/eYJeWfGjwprY=;
        b=wd9dDGJe4VV8xQFvqLb0zc1s/z/lYGIlFhovHVx1ctp+yrsYQvDwVByDg6+0ypfo2v
         xiLoarAJpSyfMdKM1wnvfQvwKVd0iBhqjhIRAvckSnRQosou3zujKGSSX3Lfhv0NChDi
         2G9AgDGIX5wCNrBYjA3SxPUzoBsaLoI5vvwnDPQwDR6/sobmA3/ZJXk7kM9H3kxekokF
         Gl1hs+KriiylLbD+ZxbL+n305D5XuX6NwMrGonz1/N/xKqIZsJqpv3AAWYqkkHwdTFYi
         NN93Xl3ukteXdA0fBIeSf54yoZYAYm3/VbjKkQvn95FWUmNnGHEyNQspIketIoUoNv4o
         ZJ7g==
X-Gm-Message-State: AOJu0YxBuTDvOjyZJMB79B6Ro+co7FuNT/D+jlt8c2jxLH4JkfaEtZu7
	8nu7BR1jr8vKUxPGyjCCwrUILEuatK7QSL5/x00dNBmsITzmbaPFHBdYYVfpSg==
X-Gm-Gg: ASbGncvK64PuMvhjvsNsjM6z9+YH4X2JyvOcxopkNoA2kPuCIK3/ytSPh++myG9evSo
	V24627ubEMLN6pNU/LfG53839JXkDtISkm/R2eNbywSAASv4edXZ5MU09euZ8RikGl6sHrqivN8
	+471H+qTH7WIA/nEv20NpffwxZ9cCBdU5hiqEZ6C3Fk/RmoPZk38Ju1XhU3ylisJPItYww2bU29
	nXfVdxsxaMYx0WcZ5ar1/HWlHIbcl+pjAsJ/Gyn7ix1HEzQwjUnA2l4umjQcv8rLqAepJb9PJz9
	7xOoZckccO0/64P3YY3subRWS1AqhUJ61kLiNY0jGbKzAFRJcIzKNFHR58qA7XuPOQ52toRyR5C
	18zhs3XAY1xAhUbLY7MDz9LXczKDx/OljbUtAp3GugzPvkP49vG/AkumRbueFL8Bb82Qvc06b+i
	GZN8ZPeJbBSkMxURG69ahP+J1oE1X30rVrwpI4I6M7pMVhniw=
X-Google-Smtp-Source: AGHT+IEmYToSmrIqjc5wC4mdO7RqPFAHX0GIp5zBCPMWLnmjSThWg8cwWDoYnnwIydK2PVQwG41adw==
X-Received: by 2002:a05:6000:1786:b0:427:a05:2ff with SMTP id ffacd0b85a97d-429aefbb8e4mr5392468f8f.33.1761827628173;
        Thu, 30 Oct 2025 05:33:48 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:2074:39a0:8aa2:a86f:99be:b78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba3574a2sm2364595f8f.44.2025.10.30.05.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:33:47 -0700 (PDT)
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
Subject: [PATCH v2 1/5] gpg-interface: simplify ssh fingerprint parsing
Date: Thu, 30 Oct 2025 13:33:28 +0100
Message-ID: <20251030123332.3337684-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.617.g2aaa867cd1
In-Reply-To: <20251030123332.3337684-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251030123332.3337684-1-christian.couder@gmail.com>
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
2.51.2.617.g2aaa867cd1

