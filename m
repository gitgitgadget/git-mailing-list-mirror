Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968E3BA237
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975415; cv=none; b=ZAmapE2R7B+Yog9aAKQEoEXau3HrGQkWEUIlfQz9ApQGxvvJhokY3jikUsCUsj55DlJw+Hh4NMbms80jxdRNyKnibugsVennVA0tj+KdfXvBxm/X5C4Hbv5cTEwOQwN6z9eAMqeFeGW5wYgAS/Rjkgqhj9tosBGuEDmQzCfcgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975415; c=relaxed/simple;
	bh=DtRc5hRcUWOmFZXZopID/kFFz4f2r1LmNdqTA9ITEPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyvxmtpT6VomCrGjD9N2rX4LQL2b2Ac2sFjgfO0s1xtrfaDRdRb9uU1eMVhT6LwQzKhWzjwul0/WiPYUBi3r/Q55xZ/DgIKIstQ4i0jPVnU1IwzO53aUpdCfmmnzeQNaKf500DzaZqaANUlDQJ8hdWMd7X36uWkrmgBSasFi0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4pQtwi3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4pQtwi3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so6019397a12.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975413; x=1792580213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJ/UVym1WpUCcY6u5p55ynI7ZyWJA09yEnOn2tVRk8U=;
        b=I4pQtwi3q/X9kkBgoW/eDeG8P9hXxhkQ4lQAr1lZa4pOi/27ThBlq81E1q16Ut/e0n
         tKZ20AYF/F1rqMRvSElxA97r3UqWM+VzJaB8wGpKdKcKMwq1lTUQzWmMKuAbNGzqKJYQ
         8D7wDrWlu8xrcYgCInl8tnEUv5mjkXo5blniQvXZ9KhkRTw0v8BDuX/aUyVnluNfmBz1
         B/SJiYVP+WPSKUm6942L0w0rtdXsfLq4GGcWqcN0itOnV0RgLfWCmiCpVhJ9GsjVUq9C
         c3XgbOGS0e7eMFPWmR0qZV2UBYXFNqVXLyn2su0cXELEB3kJj4ubtvEBjlQEdIv7W6W2
         B30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975413; x=1792580213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJ/UVym1WpUCcY6u5p55ynI7ZyWJA09yEnOn2tVRk8U=;
        b=gmglZaRSL/fzTOG6kYfQY6MiilbeNdXbThFldxRbkrRshyy/m4g82d+p4SNGGQh+8r
         +1/+zq/+OScSP8kmlbtlMW/miONzxQsTjEFF1XtvaUGo7TP10Vc8MqvSc8TiWRXBSFaF
         rvUm9KLIn7VLVtvFcIZklzgv1d0Mwrth+MloIu/jbCfKC/j0xwBOHmI6W0u3ZL3X53pc
         TBNT6MLmXr78OooDvOY58JX1Ogesm94dOK3JrH6yWEjDhBB1jcFsYWe/vFohgwZoCW6K
         hj9Xp+8YKxYnvtzOLXr4a28QcJ16HsBY8kVFPRaHIkgXqhRm7erSiyK0soWNcLFCma9E
         C4Sw==
X-Gm-Message-State: AFq9FYJKe8OBaGMVODdPSzGiZwKBY+leDvZ9j7hsNsUCVKjbYopvhMCM
	yOx4NxB33z2ipTkfxM2428W2Jt3S7DJGnCxbyWiy2JQUP8BHncDGMqjLClbMPnMzic8=
X-Gm-Gg: AYBFou3kOi5thgNRw0mrQDRFWtcQ/JvCwE6Rdwy2tQbAPK3WtI/a7b8CE5GQuXjhios
	aeRC7Rul306PABGiLFJDt3UlniKohqEYD2bqOwAN6/+6kQkoRQMH1dwJ77AsIGnHwZ+jyguFgVR
	LLRK4cSJUjmPRdzAgX4qP9t107LDEmHRefhIlLVQBewl777YHZTc1rdUutaJr+mvFcunQ10jhgN
	bZPLDz2GRlUikYG4bDWbM7ZTeH/lh6HadKY4zk6b++omrptXh0lePIH21C9IeeLbzKkXRb0fcQ+
	EAUCrq5IVsPJkKyXWt2kwvZa3Yv6X6RMhguqoI64hYU5kbQZI7EamAlx3WgND17J7Vvtv0KFd2e
	yfUiQRcqyrW5eaxgWdMAkWumdMYY14kHM91y4sNnCMIUX+U/gqdncS7jHI12QJgkKSI+1Ev8xgs
	h6jy21ujwRsDsibdA9l7RR3febTUe93hOo9IGm35djpMsdT1NCJEsskh0=
X-Received: by 2002:a17:907:7ba2:b0:c2a:34fe:ea4d with SMTP id a640c23a62f3a-c31aa069fe2mr1536013366b.25.1791975411385;
        Wed, 14 Oct 2026 03:56:51 -0700 (PDT)
Received: from localhost.localdomain ([105.112.203.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a9f776sm690291066b.48.2026.10.14.03.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 03:56:51 -0700 (PDT)
From: Victor Okafor <vua.okafor@gmail.com>
To: git@vger.kernel.org
Cc: Victor Okafor <vua.okafor@gmail.com>
Subject: [PATCH] t0200: use path checking helpers
Date: Wed, 14 Oct 2026 11:56:13 +0100
Message-ID: <20261014105613.49334-1-vua.okafor@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct directory and file checks with the corresponding
test helpers in t/t0200-gettext-basic.sh.

Instances were located using:
git grep -n -E 'test -[efds]' -- 't/t[0-9]*.sh'

Signed-off-by: Victor Okafor <vua.okafor@gmail.com>
---
 t/t0200-gettext-basic.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8db26c1ada..177cf658fd 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -31,12 +31,12 @@ test_expect_success 'xgettext sanity: Comment extraction with --add-comments sto
 '
 
 test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease' '
-    test -d "$TEXTDOMAINDIR" &&
+    test_path_is_dir "$TEXTDOMAINDIR" &&
     test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
 '
 
 test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
-    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+    test_path_is_file "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
 '
 
 # TODO: When we have more locales, generalize this to test them
-- 
2.55.0

