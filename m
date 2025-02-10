Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749281B4F21
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173620; cv=none; b=K8D7BDGLNUy58GDsRYxwF7vIP+mp3aU6KNreYKUPkHoU5Xoa8CAu/0vDuDqf7XQdZ15sdCbXAzxGpUbUYNiOuIHehkisQkHgF3+ZVgGiGkNbQQGgFPs0kTFv6s42uaYi1cUnWzq1LjbSgVYpJ1J6m1iZ8mGU6tkqOjUJvs8n3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173620; c=relaxed/simple;
	bh=oLUcdkucVqyxubZXfYH9knvcDpsuh0ZYi6+902619uU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXmGmELdc1fP4PbRdw/cpxynLoSTG20sOTYAtnICStDHFiQnqjVGwoUxVwNWprYa17YkKjrBJs4rKFNi7NPB4Blp2jb0vQ3swVTRnepZfbGj9Nc96k6LxQ+VVDlNp/CoGSOgMnkS1uS2B4WkF65dECJ6oK9qclnhVI37D44C+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWZVJti8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWZVJti8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa1fb3c445so4563729a91.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739173619; x=1739778419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdD5glBaRV8Wv9bVLkzPtszVLGZossiCzvKNoYOfjFs=;
        b=bWZVJti8E3ntCJywIUs2AmQV0Lp0Go3E68yc+IRJfESFkaa0lNECepefywN/Xe5VQ/
         2CNfxhkV/2dhWpl+zHMVM5m2gxmuPO9RGU4Vcr4hX4EnQzKtiyFXgXI7TggZskv+IwRg
         N1du0wBbqHsoo9t5+UhgeGjbe2906Y94CEwoMkTolgaBf0hcIL9gAC/QMgB6VAxP31tL
         HxOpVO14XkL1TmuboxE0UDmghM0BZS0EdEo1u+uvEnxiGgzo2cv9vl97dTIiv2fTtjSU
         4DEKDEme6Vz5HBVmBE1RBpF5t/gzjekYg63T0Aolzg3kI3N0n+eYoip+NK2sA7RGA4/e
         kKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173619; x=1739778419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdD5glBaRV8Wv9bVLkzPtszVLGZossiCzvKNoYOfjFs=;
        b=i+EUBi8Pj650u9pD8zqo9YC2UyuyDuTEHUixgMVVBLeh+BcGhthR/44Mq9N6Kqwy28
         wmStaMeVNj3u8Pci70l2mGSnvQj/jt/sZFGEqPe9okp1lvzh+7if3gYJnpvl/aDiTWy7
         7WCN/DhTI6OmhvKbXTp2odH8cIUgorSwPUAayYIBZ5tgeVGNnPpMYOQJBmYIll0/T7EQ
         UEt9v88JosAqXFz6oBvxIgNawWMoB9Gnlr01x0S+D7EHcGc7xlTUOrTxiz3fFay/Q0wL
         1j2l8W6FsKUFEkPuBf5jotj1I9qwbpytgrdIUvIWZrla0ap/g16DbeQOnFf6phtpXSev
         6pww==
X-Gm-Message-State: AOJu0YxOz/Et1v7bj3FBL6Htx3mZ1llsw0IjYaaZmanjniXJ8IB/Q/jy
	sCj5nZUvbmPhSGORj8+ghxQi8+rsMqZJT5NdWy7+xziHofGZMPK0BU6/fndhFyE=
X-Gm-Gg: ASbGncvW9kOKzsvOXURLGXxHuZe93Uob83Ybf/aoVtLHBsBicKz7QhjBDgRjIF7i3/D
	wEGNHAG5XqKp/I6EMEsoEg9EPXC/phYDtwpj13MGsJqMOBFejGx35/EH0qxb+KMvd91ZPnJ58QP
	AAkAqkzE1un6jRzHJQJGIPCxWDURZxWU6e2EbDyzRtrDbQ3ajrj/ev+hwCSvgjh6eUxosgE/nUx
	Dv+MjO5HvexLa2TkM6NL+5vQynUXR5nyQJUs3cqLtehAlvIamBPklWMZ+Ffxbv4I4iGW6ye+eLD
	OcWe8Ci6RLJT4hMGcZIewPOGAcyWfArX
X-Google-Smtp-Source: AGHT+IF5RhB5PMG2DCps7Rp+/TADNCcush1/AoP3TrH8y2XRqyqFw/g4nvKEtqEYeJAKUSKWE07gdg==
X-Received: by 2002:a17:90b:2243:b0:2f4:49d8:e6f6 with SMTP id 98e67ed59e1d1-2fa23f5ec10mr17919698a91.3.1739173618620;
        Sun, 09 Feb 2025 23:46:58 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e239eesm10187721a91.30.2025.02.09.23.46.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:46:58 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] t5319: add test for MIDX QSORT progress reporting
Date: Mon, 10 Feb 2025 13:16:23 +0530
Message-ID: <20250210074623.136599-3-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <20250210074623.136599-1-ayu.chandekar@gmail.com>
References: <20250210074623.136599-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to verify that the multi-pack-index verify command shows
progress during the QSORT operation. Create 100 test objects, repack
them, and verify the progress reaches 100% during sorting 

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---

This test makes sure the progress reaches 100%, but I couldn't find a way 
which could verify that the progress went from 0% to 100% with intermediates.
I would like if someone can suggest a method for this.

Thanks,
Ayush

 t/t5319-multi-pack-index.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 0f215ad2e8..d368e22e3a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -658,6 +658,20 @@ test_expect_success 'verify incorrect 64-bit offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'verify shows QSORT progress' '
+	# Create test objects
+	for i in $(test_seq 1 100)
+	do
+		echo "content $i" | \
+			git hash-object -w --stdin \
+			|| return 1
+	done &&
+	git repack -ad &&
+	git multi-pack-index write &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index verify --progress 2>actual &&
+	grep "Sorting objects by packfile: *100%" actual
+'
+
 test_expect_success 'setup expire tests' '
 	mkdir dup &&
 	(
-- 
2.48.GIT

