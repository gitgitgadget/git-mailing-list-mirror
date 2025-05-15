Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0029AB02
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313154; cv=none; b=SZjduZdVaFffuWqAr33wjShNJPDGZuWgURUAS/82wDsl3Mz1vSVq6gLiqk/F//vBvYLbw4esdahxstk6pr99gyu3UxGr8w0AikIKU6RlUxlawjGHOe22vUx23xCW6edvy8GP0ImDrYcAyMD4zfB2yWzIyj99jojRUumzhZKwsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313154; c=relaxed/simple;
	bh=+tQ+KWpVn36bo875jmPse9JwIly6VDJkwbLKPSBSE8Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KLaLEWVLDDhdJA7fgDX8PTNQhmtQHEryb3Tl0ClgQMh6GbOedJHbp8/v+k3kxYEyJddbpfCaNmqrVAQuEgc5aLlDdC7wyAK9YYuTbQ2Ajq0GgqKPU5ttZSf/u3DJR4RAwZXI4OvU+eyI6ECGQPOJkQa6O+QbouVpQHEUtIBgNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX3fcDMH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX3fcDMH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0be321968so521809f8f.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313151; x=1747917951; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtfLBqXe8vdyLxj0vz1g+I/ZJIUUpUKI9oxpMxA4w9Q=;
        b=UX3fcDMHRwUuHAzOseaar4GXTdl0nfGpRMd31GuqG5QlIGldJ69V2Ja7i58J94lyRU
         TETi8DBZnJvnj5YcRFB1QzpckzKyh4Is4OBA8b6fuvJbBpQOZaBwnVU7aYhcyHUCscbl
         fhjcRvkKfI4mPFi1i8Ih2ogaylPc6OBZrMSCCiUCbtKnn/bpgj4JIrm65mE7/NKhYHz1
         6GQa2OGSlo9EZ27kiUnR+k9NJkm/+Ywy0Tf7pigNpls2Tb7Irwv8dPpns9cA6fuM3AG0
         MZN0IhXZFAxGcj9M/3peteN2PCOWNCemI/+2icu/1slLi6oZ+IP1lolAiUWu1fFeeCeQ
         +XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313151; x=1747917951;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtfLBqXe8vdyLxj0vz1g+I/ZJIUUpUKI9oxpMxA4w9Q=;
        b=gaNub3coHIkU0zDANVGmHEHRFDllUYFsK64GK9QKrJXHU8vYs8JX6IFL7D0VnbGpWo
         KDg9df7qcRMpUVL3SuOsqNzs91+jcY38+zkaZc754sWAWlAcCV+42L5KoqihCxnIMWgP
         HZkkzLUA9uovIG2r1kfGmKzPOsHh2DniO2kciN2JofS8MnvFxT0vkx0EPHuQLRExaUsZ
         4JNkQo8A6jzAcM3P42utAsdrUUZS4hlGGG/3OAh8l61Ddcm3Q5exo4FwR+WIjGYF8m6T
         LLE1ybqDSjDu6onZxExZrxns4sVntSktnrnsMTegWDLTHg3UdyZ305cNuc/GIyZEfbqf
         9VmA==
X-Gm-Message-State: AOJu0YzRcfIuCTyqPXchPBSFF+mQ7kMEVwf4T7SYbxwNcWZLcZFQCgo5
	lVoIYIpEkxW7QvJWyAWhduN+97chgTBs+64S2raateyB9Lz6XkVOZP3RuA==
X-Gm-Gg: ASbGncsMYKuLjgY+vZnoZ/E1Fv1KdiixL8iDgNsQN0AtVJs9QLwK+XEw9iyDvZVwbDc
	OmjQtjkBrGjwU1t7h/ig7qhxek9lZ7jUUak7oWtPM1jGvdDone9PufHOKaG9IwrCPqVjYTGVKTl
	KKbPUXHaNQJ2lAYo38Z5/xN+qg0I12hmX7SOqRoo/qbmoC/RFVFToiCrFmFGAc7MQfl3FV7fFKz
	MPsbp6fKqyFVnQYNvrSmOdsT9M+yqaPbfkqHJos3cuU+0fzqOa0PaEg4xGTkJhaDt3Esja+AJG0
	vtoxfLWLHWP30fdBnfJ+RhKKWvugug0APn9wWfG9Myknj5GpFxeG
X-Google-Smtp-Source: AGHT+IGV7Y+C/zCj+rTQKguKqZ2cIBLN9K2h0rfpih+E3XqS6x5qJPRxm7bi+KN+Zba4yjnKefdiOA==
X-Received: by 2002:a05:6000:200d:b0:3a2:45f:7c3 with SMTP id ffacd0b85a97d-3a3499502bamr6065609f8f.57.1747313151124;
        Thu, 15 May 2025 05:45:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2f4sm22595230f8f.78.2025.05.15.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:50 -0700 (PDT)
Message-Id: <10393c2f951e30e6b8529ff4fafb4394c3840485.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:35 +0000
Subject: [PATCH 10/14] describe: defensive programming
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `lookup_commit_reference()` can return NULL
values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/describe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e2e73f3d757c..455ca193ebd3 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -324,6 +324,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	unsigned int unannotated_cnt = 0;
 
 	cmit = lookup_commit_reference(the_repository, oid);
+	if (!cmit)
+		die(_("could not look up commit '%s'"), oid_to_hex(oid));
 
 	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
-- 
gitgitgadget

