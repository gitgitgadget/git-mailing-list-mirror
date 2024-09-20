Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4979C2
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726807206; cv=none; b=ePrkKH1N9w6G9fxwwuvtJkncpOyy1L/Isf/Ib89jihKFwcTMLcUmyaEUP13tJjqi+7RdRFBNT0iBz4FUMuxOclGitEZdzuxWfbhrz3tFrkguBCDbFnshzOSj0xqhGCkILlwp829RiiTDAxc4GI/mrywpfTPXx4SdIxdxUdC9xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726807206; c=relaxed/simple;
	bh=MMtBz/NdwpniqP6KDH3ttif+amMjkw7kDF/jtcFMi2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HSjApbzCDI9BfiPxWWXa0r1QxBxI+4lW17g9VIR5BBgK2Mimk3thUwA4GwzGB9uml/7MBsBSvnHm4izpDA2e2dYl0Nu0FhIIpa2jKUSKE9ZATRzhfprdl05EFGEI8tQ7WFiFSSQRk5HpIket/oFQNshfmWDU2H20SikaIYcz6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjTEiJS2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjTEiJS2"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7197970e2aeso1174266b3a.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 21:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726807203; x=1727412003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xq489XAyo5J+43N5vowHoc6RqiOBodI8eV0TltLh6Ek=;
        b=QjTEiJS2sfVpWj11lzUdT+lL3jpowBG41clLlgzUnAUzCGxhqNvm61Q2qd0TH3HgaA
         Zg5AMakiS7QmLhB8MYh8KT9cddyk/bX7TgMj3NPE4wKFASi4fvNyd55fqNRsb0IlrjJw
         ruVXr0AxZPIpHCL7j+qCDJ90pPHEa9ta3ukZ/dYuvNyJIoGH1sjsfYjFELqJT/J48cjP
         X+6KYBbqKt5lbq8In3crH2ZGIjxDBZPDNo4gEHbX10+fHcfW+uvDaCfs8HMRZr9Mi7w3
         2uMhn5e6DTiUWHljbFyA7tLQzCIXsB+2UNJmcbMgcPA6UXBvfOV4sJxiYb4BTw06VGgz
         GwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726807203; x=1727412003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xq489XAyo5J+43N5vowHoc6RqiOBodI8eV0TltLh6Ek=;
        b=tZPZbJScJ/MVpOKQpJOejVQ6cFhkVWkaquz4ldcnvp4+nFDAuhYodsYLBmtmXHT/+z
         Lt2etVEO0kvD/zS2/osfWqegakn204Az55RnOfqQKCXn5JqFa8+fmPim2omFRIStjADe
         MTFJUDbEsZEleHW0ekyg3dkw53/MEmEdNi5Sd+eMKqR3UVSTHwjlCVqkhIpakQcmQ6yt
         prnmMZTvQv7O+EJE5rCQffBfWXqPxjspFgcqUHrMH5DPYXaY8fL7AMGicJhwcIDcWH/1
         dy9GcY0aYtBmD+W0Wyr6kWrA58o2d3nHKRwH8gmSoD89HZFPMtnSqClXnbMofqGACuOc
         6u/w==
X-Gm-Message-State: AOJu0YwQyLF/cAiT9WGQDf8r7ij3FNBwcLu+uM10SEdUwIpjXJkF2eNv
	jkjqUyFfuHkCbUnttS4TZN7zzworpua1fdIiSyLj9aWCV6BYD9VkUqHxjw==
X-Google-Smtp-Source: AGHT+IHyfUQlKgljp2Spdplf4eIAjZd7WUvTUWZ2VApKsfolwRRDWiqflKaqnz37lyGiOuCuELoQyg==
X-Received: by 2002:a05:6a20:9d92:b0:1d1:17c6:7a34 with SMTP id adf61e73a8af0-1d30a9d0368mr2989632637.45.1726807203567;
        Thu, 19 Sep 2024 21:40:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:29f4:7daa:d86f:fa2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b97608sm9029693b3a.153.2024.09.19.21.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 21:40:03 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] ci: update FreeBSD image to 13.4
Date: Thu, 19 Sep 2024 21:39:35 -0700
Message-Id: <20240920043935.56805-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FreeBSD 13.4 was recently released, and that means the version
of the image used by this job (13.2) will be out of support soon.

Update it before the job starts failing because packages are no
longer compatible or the image gets retired by the provider since
it is now EOL.
---
 .cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 77346a4929..1fbdc2652b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -9,7 +9,7 @@ freebsd_task:
     DEFAULT_TEST_TARGET: prove
     DEVELOPER: 1
   freebsd_instance:
-    image_family: freebsd-13-2
+    image_family: freebsd-13-4
     memory: 2G
   install_script:
     pkg install -y gettext gmake perl5
-- 
2.39.5 (Apple Git-154)

