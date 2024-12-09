Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783EB1487C8
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763091; cv=none; b=t6d3liK40uAV75ce1KT2CfTevq3nnYddX2nZqK9OjlKYbhUzA+tku4+MolQe6Hwd2NZ0v+Mn1udSiqCI70iaXVP0VWh5kBP5RD8Dq6AXhMwoM+pj4ZxxpaXkD0hOrtusZUFQh/qg1VfQemexFufa+T06290zPiwrm6N7ZAdVo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763091; c=relaxed/simple;
	bh=Ekh5+ly0SnahaNDFmi4ejBFFSwqYkjdzv6IjL1nrdog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6w6wj1gwHPJ3gKZ5fy9YZAerin/rEY01IQESDO0aSIeBSVi7mDm8/61EQ+G5Afl+JFPChQASMWRQwv4k9kt1fFRj3dZ6xiXferFEkXW+xVXWV7NuW/Y4bHPFwwf3RCg4+VwDMsIiTaRn6hrpbEZDm3q1GCXKDmjTb6dU+K3UMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGjLxMjj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGjLxMjj"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa551d5dd72so84088066b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763087; x=1734367887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXAQUzgKtdyMTiCCqrxRFUALbDjFkDNH4h90BasbJHQ=;
        b=QGjLxMjjg377O1WAxqm2y7YgbanKJfRiuEt/HXCFDIK/qmAeofLvu9MkML9MlbByVy
         EpYQEqc6QW4BSiMl3slqW48tvw3JDDbaVNcmqNjO6uuEmLBJ178cmMrE+lOJRxwG5zWz
         XUPEb+E8fjL0Gxc9TF0Mvr5hbI28GVYMYzlaz6uJAi4n6KOXQQDId9zNwDdDoQ3A9nqQ
         ZJVrvSjBn/sJC5qOOuxZVr2NUHoAC1sdxVf0o76lZmvMbxSqoqF2VhrhvkuRBUrzHQK/
         NrbAiVbTx2CpjQ1/jnYfP1Owy3jmqAhPIGN9UNb0h32IwMGwtMQmR/c5y9R4Js1I2n1K
         jN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763087; x=1734367887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXAQUzgKtdyMTiCCqrxRFUALbDjFkDNH4h90BasbJHQ=;
        b=h1cR8nYtUS33zu65d8V8s53D3OW4//uv3wlWZuzsKbT0aSjoRDrgqcFpRLF4UBMNoP
         OvOQVjSfJZdGIEblhudtaVk3o5v5ICYfT4Zq+uxBBJjPeOJFpgTD7yOyuFqTB9E6vl+9
         7cf+VUvJa9BrNLHz1AmkrRIDA+0SkvSTYWqRPp+VYqTU3w44Db/Rk1ceG1/gveG4gMfF
         b5KqEYVghD/NKWGzbBey/rrNW0KrsOucq4rt/CJYs8u8UGjWshp5PxYjPGRa/puZroK2
         A8aTXXOqAC8gMCmgsIfduVzH10dgpdYXRrnkeMEEhfdkhhgdQP9160Y56rAQ9WnKiXzl
         FTsA==
X-Gm-Message-State: AOJu0Yy/QGaNxR6Dilb0Dg8Z/Rr1Oc6obwJX51mCKcNr52QTlFvTbl3g
	Qfk2rn7DO81keFjRTcZk4khgNnJb+osxxU10b6aOE0mf7FkUKmi7u/wPB7jZ
X-Gm-Gg: ASbGncuWyEHzZuV+oLakmhg0h3FyOcC4cmM4LrhRSu7V4ei40yv0q5pnIj91OE5eGY+
	/EvgmWVE7LIRXWvzur8C9nZMpJ2dZOVteuRm4BvoGGkkUMtupjwNo5ShMZ6GEEkgQCbMTP2alo0
	jldI9KAlXhKDo3IxfUOm5lWnDaXI3nW0PQ/964Ogyx5qBEgwW9UfcGYNCPVDmtylCZvYYslW8br
	ocBEBfHvjPvRixh+Osa9/IXfi0iJpAKkwMQMMnDwVvsO/7Ey3YSyl/vIyI=
X-Google-Smtp-Source: AGHT+IG3WpsWxTaeI/qQQXBgRxC+5Mnp/YAbfksuXEyTJg+vW+ExCl/Y20cmthvqcPFm/SkPNX/ToQ==
X-Received: by 2002:a17:906:dc8c:b0:aa6:35b1:5c02 with SMTP id a640c23a62f3a-aa69f26408fmr14227966b.9.1733763087526;
        Mon, 09 Dec 2024 08:51:27 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:27 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 5/8] git-submodule.sh: get rid of unused variable
Date: Mon,  9 Dec 2024 18:50:06 +0200
Message-Id: <20241209165009.40653-6-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
 <20241209165009.40653-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the variable "$diff_cmd" which is no longer used.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 833ac8362b..67cdea331b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -503,7 +503,6 @@ cmd_set_url() {
 cmd_summary() {
 	summary_limit=-1
 	for_status=
-	diff_cmd=diff-index
 
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
-- 
2.30.2

