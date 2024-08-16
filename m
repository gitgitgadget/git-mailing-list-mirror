Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C61C3780
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830903; cv=none; b=M/+5AxXqinUV3pZhAIoQJfoeqqFy56MWaXEUvJN3v/S3PjrqZmZAKbaA4mhVNNtv1LWlQWU42u27+8fLXqqNTjxZeMrjZUI22j2dZNTwJfXgId2UKHP68RwNEB0831zeoKYTUKQNbiB591Izmvsqv4UaeF82CB7kZwgcxJkWoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830903; c=relaxed/simple;
	bh=kuNMT+Mz/B48UOGZINSIcyE+FXrNDfjXrncrh0vdxZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4DBrmt4TWahB4DrahvVJsK2Z7c4KTPsQ1FVJskHjEDkCDeGBv0fR5+anH17M2bcGCz/2TgfEXgKRetSyUjMAuyETMcKLwoUzCQpm5iCQ2qSqPjECkeWgvterbUIgx3vc+nsPHrV/D1GW5rzA8uRMegtHbkxC87ZhA+WKmprgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhNsA7xg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhNsA7xg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1433961a12.3
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830901; x=1724435701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIhWqQC8cOCl9rCuLpzbSL3YED3IjToOqwNVrWzcNB4=;
        b=hhNsA7xgONv7oyiqVHc2hTMr4EZd+alqFN3ymldFJixXDEtRzmrO7bpozC/6BRP1oH
         lCuh3AbXf1dMeCmOBXzgWPX+e2pLkXws5/YM93qtOiczY1dHQIdmRBw5PHX/if94EMx1
         jRgnrXWDzjGHaahw0E7ijXjJR9odQ/+aon2rXl79pvNLGSE/ZuWd8nIVZhcyAheA2iKm
         H49tlVyaR1vXeRSP5EwmPJTQWQeV9tq/80WEgKWx++ugw946T6qi3vy6a5/v86zBC4uj
         KxokfoGbXD7XSy+XmGDeul62BIO4md3VmjBCf3msBnlZ76HHwrwBMkFYtWhhkio1XTwN
         YKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830901; x=1724435701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIhWqQC8cOCl9rCuLpzbSL3YED3IjToOqwNVrWzcNB4=;
        b=fG4NoYJdiAr0ErZo5ZJqtga7/oqCTITpRpFB+dWV3ukdS09+ssb7MpWtoJVrC7rvZq
         HkLRqFBB0mTiZ+8imYOAjhqdANtoizDLe6Pzo5iV8V5kD9LQaH+Xf6OY+klbg89ZsnWI
         cOJLbrEmQRtxZPTyG/Pz081k9ghX6AvYJguOZ+QoJcwA6xo/V2tC21hDUiYEN1vrvBZ8
         2yX34seLp9ZQLmXd/LmG3MPN9UAkDtCt0IMCzpdMxJ2o3OpA/MKuKm1UKPKTW8yxSiXQ
         4Dez+s1A4okR7vzo4BCCLKfqR1L0Ev1fU7CjmHObGo4gfujwnxo+7dAh9hpZ/RQQwFh+
         qlZA==
X-Gm-Message-State: AOJu0YxUA+deE/C6Ie2GYX+h8TZDHrnKQ7Nwb2E1hiJ6cUK4etO3O6MO
	UkNn5KtwvU5+WEknhjscO9f+jp+vjM8XZ6blG2LRnPfwzbTYcBKU0HM+Vw==
X-Google-Smtp-Source: AGHT+IGPjRnbo04QVvnz+FbzB9gYfEm+DkmrsyIjL2CVldU96g6ej4kpzx8Bz//vJ7x701ZmcyUTiA==
X-Received: by 2002:a05:6a20:6f08:b0:1c2:9070:90ce with SMTP id adf61e73a8af0-1c905025edfmr4625568637.43.1723830900819;
        Fri, 16 Aug 2024 10:55:00 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 03/11] t-reftable-block: release used block reader
Date: Fri, 16 Aug 2024 22:55:26 +0530
Message-ID: <20240816175414.5169-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Used block readers must be released using block_reader_release() to
prevent the occurence of a memory leak. Make test_block_read_write()
conform to this statement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index b1b238ac2a..eafe1fdee9 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -105,6 +105,7 @@ static void t_block_read_write(void)
 		block_iter_close(&it);
 	}
 
+	block_reader_release(&br);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-- 
2.45.GIT

