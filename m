Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0531FCCF7
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087727; cv=none; b=JHFCWhmonYwoVJcVtKzWd+ytmr5pUF3RAThJuQkI+RXI/33ZlGBkRtl8iZZ6/KffGZ5nXwwp3457N70BUixeupFo49Ximc1vg/T/Pvc60dU3lSSGXuQb5ArfOxSKuBzdYTysavaBkrxQAj61gF9wltxMMcIbz5aqpqfYCsO8Zqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087727; c=relaxed/simple;
	bh=hz0XhU6vm9IKGWF15RE4XsyyGvojU6fnbAGLTRc9rDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXYJqpl9MA6Lz5YgEdCaFPCYvLpffElt3UGjHU5Y1YRPuhn8oLReKVuy3KTypFsueEe+BoXMAxfajCEzBN9h46z9+rdSoPAO/ZwTKkTm1vnwNMP+WwDyDOzjDA9qAaS8WJISMnnDvui9Dl/xkxsBr+K80h9Pxmc1vFovTkvpaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9o/WisI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9o/WisI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22349dc31bcso95186965ad.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741087724; x=1741692524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE3NsQr9dC5VPkVU99TPJxSkefXzvA895+0O6Upwl5s=;
        b=X9o/WisIWhdgQNAmWLlfYg8+gN9TnwZ+IGq7w79FUybuWIn8QopvSdOjSoeVzdhcKR
         GRzZV79GaCsSZ8/6iKnJUXwEckiUwG7PhSyPyM1qkfJh4E/kO3W9ckXOIDKH+UffgHr1
         2bf7rQSeSvJpATbSUp1FMwm85kcfxcmug8wGz5UuEk5c0l50w0vq2T3dWpvrd79U8/lc
         ohyFt/y8hqoNJt5Yb8aZp6//yDZZuwGbs5lNxguimbm4rd+q3TlwBeehq5FPl7lZ5zXj
         7NtPSB/E30qBemvBa/H3kZ82bnLba52MPFTLhgTQfJBmHDTJl4lYbTdYfq0ic/fMkWOO
         AtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087724; x=1741692524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE3NsQr9dC5VPkVU99TPJxSkefXzvA895+0O6Upwl5s=;
        b=KRqoJx2enYsUeliRdqaohSXktzMQd5Wux2yZZZQE/bQL9YP6fksuokvZol7qKqi6Ho
         ZheSmIDtCb+fLhvJIEW0lzs8Jd8Iq2JU8n1+AF9Sju4ZuptoWg2oUWlI+kRiqxqP1VjE
         uJGRdJbaqML86KTZaIpQLNrwCuMLUR+KoBoD1YKxpt5lEegVvV8GhN2KPUbKpXPQ+y7c
         tqBOWQO7HNOeBaP+1rVFEyiCEQqBcV9wERKQ4lEh320IKgCvI1UqMa9cFdPxmAspScTo
         jzmj0hEr3Csyt0c8j6Pe9b1FS97OEDtINkV0ibGGf3LbdcqUL8gYN7bA7k2MAwIYgqgC
         Y/mw==
X-Gm-Message-State: AOJu0Yw1S3wwZeFPOU5d7UFvTzYhhZ8KU+/uPQPiSE485SL1DW3t2WFX
	zyvZchxosH4LRoTZQEg6hY/duGh4igE5Esz+lodvSmZEeS5uughYofHB1OvOI7I=
X-Gm-Gg: ASbGncsnRvxo228SSCGJOx5BWXWB+lmNBJzTRDdRS7hF1RCSeJL3EUPkHHDMUXdvcag
	rAAnrbr3MQFOrRCeH8X/4YhXVk45um033MisPwcIgCKXIKbZZQMB+NvrM45TT/vdv0n+kM1nxeu
	+p0sM7j0VOXjz94NoQP9qPCHl6K8KbSjteiH7DJK9AcMIxuhmfQ8PqFcKHP0DFblv33fOmssR+3
	M60TzL3z8yahaUM6ObixOOgOxEi/6enETAtr7mbDrObquSbqesDzFCoiBA3Ti2+E7bMR19HFOR0
	IJKKrstiqlLd/yYUWyeCu7vQxgPazBcO2zAJb18AwiEYFviVgs4dKtkGFA/XxARlSgTaAEkW0Z4
	kmd258+X5DKU=
X-Google-Smtp-Source: AGHT+IGkHP6VOeedh38B9UvMmZSrAet3A0ldU0UyVMcHFYITAW8fde1SFagwJVJ8ZJYgllXkrENBmg==
X-Received: by 2002:a17:90b:3ec4:b0:2fa:1451:2d56 with SMTP id 98e67ed59e1d1-2febabf1990mr25436353a91.25.1741087724601;
        Tue, 04 Mar 2025 03:28:44 -0800 (PST)
Received: from localhost.localdomain ([2409:40c4:179:8d82:34ca:21e5:3fb5:2ef4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c7efcsm93331425ad.154.2025.03.04.03.28.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Mar 2025 03:28:44 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>
Subject: [PATCH v4 1/1] t1403: verify that path exists and is a file
Date: Tue,  4 Mar 2025 16:57:28 +0530
Message-Id: <20250304112728.41228-2-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250304112728.41228-1-danimahendra0904@gmail.com>
References: <20250304094153.28959-1-danimahendra0904@gmail.com>
 <20250304112728.41228-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that if the path exists then it is a file using test_path_is_file().

Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
---
 t/t1403-show-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9d698b3cc3..9da3650e91 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,7 +196,7 @@ test_expect_success 'show-ref --verify with dangling ref' '
 
 	remove_object() {
 		file=$(sha1_file "$*") &&
-		test -e "$file" &&
+		test_path_is_file "$file" &&
 		rm -f "$file"
 	} &&
 
-- 
2.39.2 (Apple Git-143)

