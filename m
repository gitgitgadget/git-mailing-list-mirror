Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA40436BEB
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362140; cv=none; b=IFuV29Jjwqbq9rsW1AW5WaT7HB8hUjWwuRZlFm//BJl7p8SV7+rqTY0YQd2tz/b5uxMUU5h/zI43DehLBiCC0hbptKQfTotd9rq4wVqwD2euefpCpT5Rl+Nvc6F2ci1D74OugatIro4B+8sZ7g6KffbmabZfM8oY+FPKeRrSTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362140; c=relaxed/simple;
	bh=rC00VUjQbt5bvCqqFS4UWjM5vRwgNx+FhwvfHgeQ2Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAkT4XgNQxz7nzSL1E6knmc5Ofl+BYtREbo5WP2Z18g54Fs9GYg1DZAfpp5W9lC84wHthXwr9aaO5eCoQgOBSrQqcjvKo6g2I1M2+qnQiq/gdFxr46RM85NPIyRdzBNqLpggohhqanKU4BlP4Gj/PLIzZTy7vVRQp185kUsn8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ5fZKgR; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ5fZKgR"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so1451015ad.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783362139; x=1783966939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lv2Ek3IZ6SsHiPROMUnFjfvG/s8qB8M59kmHd0qnhRc=;
        b=aJ5fZKgRXisP7lFy6MG4kN5kO64pivigs6IY8lEQuyji4Zg3cpNampUJ/vmVmDEYJL
         /ZTBCIWor99Kbd/U/ATnh0fmmvNGljXkmXhy8QaEFIH+41cEMuVVt7wfSPuqAkaZGiVl
         fANkocOeCQwFAAozbc6Y3g//R5FW3yIGYlSE95JhVRUvSmBLn1tc9Ws+LCdlwR8iyjbF
         aTzlSoi0LPvyqXn0tTDiArNtoX4nXNGfvTVvklbczwLSupNwj36FM99Rm6nMtbCuOIHw
         5X8l10w0iFYgY4smErSCEbBDNTqsGgq5nh0PjC3vg4tTKnOghA0wpY9CwWxbWgXe8WA0
         laBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362139; x=1783966939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv2Ek3IZ6SsHiPROMUnFjfvG/s8qB8M59kmHd0qnhRc=;
        b=DiWGsSYarDvtXQXU7lFlj6OJ2b8/MeaibBq5UmYNPCzeu2Z4UuJqztZ8jV6IGccJvR
         3r7kySM6eiyQZR7BT10fjx24uBjo2+tNhZk0DQT2nPSVQCiHKjr2TLifoNvJYMlOpIWA
         VcKkyq9WZm4KgqbWcsrmB93PtoABceR1cjaslGKvbPdYmvOeWGyXHHdcRkDjin4RGucS
         jTGIUK1+0w5XNT1yvbCZyPz06cLQSQwg8mdiNwz4IDeETNcgstLrBL74TIV56SOoVd5I
         CoI2t2qVGBshm6rp/QFjx3sTV6G0WR3a1hD5gg98Q+GH3ABkjtkDk6FUM7rIE7M5WY+y
         1+uw==
X-Gm-Message-State: AOJu0Yy0lIvru8xrg7CMiR7Oc33bC3TRy++5cu1akIfzwB0P9yGkfo6G
	UjnmzLL1s1s1SLZnBOmccz5n/jUbk/8aG4/ZkXe9k2PhkYseVD8H4AimFJgIkr5OJPY=
X-Gm-Gg: AfdE7clk2fa37vXHRzt5GSNqtLM0+nTVCIX3pAMKyc19qBuKYiFFAKtTtaTAsSQlRo2
	4dziuqALECo5fcPPZm2+fyCmkTbaqrfVQ+paRCrHz7Ol3DsGAQkFhB8Dlkdqdbznlnaenl8zGar
	P2Z+JHB4D61LCAj6Jn2iAC6wCmrKs7MIHnooIpCUrbIW7xMQEbFzCj5KRZBbwhUOstHtvtAyqmf
	PHJ+6YlHFjifxoENrdJ5xqSlGSKnchamlL50VxvL5xVTUvwMHQsqqmGv6JpYt297l947Ptebut1
	Ie/PdmrGxj53lxfLVuZDx+TukcT5VEz+num6QheUzsOPolZxBjUer79uHkogcXYBpF5+tkBJhj7
	HgKd9+i4j3e20Ltp7pziI81/I+QZEY1qzR36hlbP+BTJGOhZmELJ2d7HkcLZvdTGWs+EdDZnTiW
	TYzSBmtbQYq4f5kaZTLiJ+lzJNlx2qU5XUYvL6Yar3EWemTyWx3bLk0LoccQ==
X-Received: by 2002:a17:90b:2652:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-38755573a58mr1771860a91.7.1783362138786;
        Mon, 06 Jul 2026 11:22:18 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f38ee1333sm40790669eec.24.2026.07.06.11.22.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 11:22:18 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH] builtin/rm.c: use die_errno() when system call fails
Date: Mon,  6 Jul 2026 23:51:32 +0530
Message-ID: <20260706182132.85014-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 081d0bc375..3f5e6e232d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -396,7 +396,7 @@ int cmd_rm(int argc,
 			printf("rm '%s'\n", path);
 
 		if (remove_file_from_index(the_repository->index, path))
-			die(_("git rm: unable to remove %s"), path);
+			die_errno(_("git rm: unable to remove %s"), path);
 	}
 
 	if (show_only)
-- 
2.54.0

