Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4FC31B824
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278958; cv=none; b=aKFEvXq/4f2wRw00WaBBRboVWQ9GMx6M557cwcFyGR2aU6QYZb4csheDC42rz/gKb/qIaFLv0IZpv52U2i8fDqPI8+QJvQyM5TGnNLiu2cjuNb+CGp7Fenpt6kaxEsSL2al7fuhKHuEop+zA1YasekPA+0d3/sjiaifOgAdDz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278958; c=relaxed/simple;
	bh=nEa0DPfgqiqALi8rfL2i9yr7V7Hrmp80AIIAVIv6q/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajiN7xxbwJ6FdreK5qCFgez6PjnybbFyJOKk3mC1sl83HIydsSuJGxeYZqiYn4Jdnd0zMlRx7GDTlsJ2F8L2F3UIBfgn+58XX27RHlD/iAfdf6UfmBniehIxs2p3Fu4HfOQIHvVxKShFMwJR9up0n1E0EGHYQraus3o19o+TkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPZbBhyk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPZbBhyk"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f5381d168so789640b3a.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 00:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278957; x=1770883757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcEg1B8RIp7H+k8tMvvL3Rjd1nYIMDUZkWYoNJUEByI=;
        b=FPZbBhyka3sOFP8t1UtAkD3u5d6JD+HW0z0evFGshNleO1YDFxpLMOYJHQ9rldoI6e
         JE7lV/MaeaLhwndCmrIT2hDPF9VZKqas8/Jmj7tEaIijFaryOtyig+KsrpgrF4aK/sUB
         iOFy03yatq1AeRkTw9/Ouig4MIV9Id/wvawuJ6c344flBZ6JNQGQneLPAqMGUGl+5A2Y
         XFdCD6LBwtSsvm0012g1/D/39X7ZyUKwPNS+8U/glzfdy7XOZbwQA0rO2uOeoYV37jq9
         59FKbAIZNUetVl7pDM99vwhrk0oZ+bLllfQd5JY+y+RmkSdFjdOIrC3yb1Vhc6lkslct
         BQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278957; x=1770883757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcEg1B8RIp7H+k8tMvvL3Rjd1nYIMDUZkWYoNJUEByI=;
        b=aseCqslgzqWteTL/TSusWER989e5bN22NftdgZieCFh2K5XpujYPeZjXg/f8bdcppN
         Zb//6XZdrA1wmrqit2ZoOVJYa4xol/JkjwInHxlLzDsattP7HYTM7FSWPQh2WD4PWHQN
         Zckwz5coVZYBDXbsVm3n4iOBN/LmvN7V4Or0EW+e11kPD3yhY05eJQuSPK0GcsGh5yFB
         T6zJ5mZqoUHvCno4I0jNZcmcJaDUMteYGl2LUb5E7GtqjhaFDCYtKnzT+VQAskwUqqU0
         Kl/hgEeNW4XxSZA5/Q2aFxnUn8ApI/Q3Te8BJPMKONCrAF3PM1TZM3Mi+6CFMfaMue3h
         /T6Q==
X-Gm-Message-State: AOJu0Yz8oHZcVNLnXkhujHXLH7eRRFFUqfjkDqjpP2UUwQdqbx0auMEP
	0VoqzgBH+JtsHaq/rFFnGUSq4OBZZ2UJ1zGcS9dSgIiaRp+KSyDedjbe+DJI/P1k
X-Gm-Gg: AZuq6aItfjjeXcf7VrM2k7nWZW3SAGsqe0dQ33Sa4PJ0GDXGijLKrOOnrC/4+7yZ2E+
	8Dlf69YyEo54q1nt1a8D+BklAHT9PYUhZWYqQWOUJwWBbhgCHXhpadmSqD8t8Bg1JBhbrSknXIK
	N874VHdKBgu4oqHKn2YKQxmn3Xu9PywmL9PjFpbpuDvdeJdBCn5SdR4cECuQ4urjHmWVRvCTva/
	hZRVG555qhLQQLiV59VTHFLgUEK6RPXup8xHPx1yDdopdrtf2jKk2gneZNnxXsrwna3+xy1XvH7
	hk8TiLrl8ZG0R5uAMxxGHIHDsWa5EAQ8Sa6i43lPpy4aw9YW0Xy8iiwg8CJK89i/JlPWbdtYEY/
	iYjOrXPKAPE8XO/8PxvTlig7tHc+iWeKNCNbAqdzkxgqwHTXxi18O8nLR1R69hv62G4b5qo1cEw
	U2QyoTSh9PiPZu7mzmv6MMziTk
X-Received: by 2002:a05:6a00:2195:b0:81e:2bca:d133 with SMTP id d2e1a72fcca58-8241c1de444mr5535081b3a.24.1770278957082;
        Thu, 05 Feb 2026 00:09:17 -0800 (PST)
Received: from AyushJha ([2409:40e4:1234:cb55:d0d6:d9e0:3b14:24c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1aed12sm5547958b3a.18.2026.02.05.00.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:09:16 -0800 (PST)
From: Ayush Jha <kumarayushjha123@gmail.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,
	Ayush Jha <kumarayushjha123@gmail.com>
Subject: [GSoC PATCH] doc: fix typo in tree-walk.h comment
Date: Thu,  5 Feb 2026 13:38:52 +0530
Message-ID: <20260205080853.2034-1-kumarayushjha123@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a duplicated word in a comment describing the return value.

No code or behavior change.

Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
---
 tree-walk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-walk.h b/tree-walk.h
index 29a55328bd..9646c47ac5 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -177,7 +177,7 @@ struct traverse_info {
 
 /**
  * Walk trees starting with "tree_oid" to find the entry for "name", and
- * return the the object name and the mode of the found entry via the
+ * return the object name and the mode of the found entry via the
  * "oid" and "mode" parameters.  Return 0 if the entry is found, and -1
  * otherwise.
  */
-- 
2.53.0.windows.1

