Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A711C1F24
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898834; cv=none; b=Vfny20mn2QgFDMrPSxbCZqL+nJHLcBYjHJWmKLE6yaUaZnZrhJYWxD9Fua0Hk0U2XatoEDcp522YAmYa4jNTWxt6c3gRfUEJr/Rn/JNvj96P0MN2k4fr54arMPzU6oCwNCg/vQM/vtHPqPJOqQVuYdlsq+upTxkvDRbe/rzziXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898834; c=relaxed/simple;
	bh=s+FdjAYhpdB1k4KIYUhTwSQn3ybiSNrVZ6lw5awsLrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWbyA5IUPMKC+1+6majZSgVgsq4HI/c9M2Kdh/W26//WrOgXZZ3xEhifgQw744GlhQLkQZhf3srR7JS6igZezidZiUPo+3NeqePrvN0ZMKpOOXeWVy12bB8EUnAHJP82ogAmUyE3i3UCpKO0KDSYF6WbXfT2TU1PN+cV0rClnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqizt398; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqizt398"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3ce64e7e5so597116a12.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898830; x=1734503630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuXCx1rN4/hrvtLTL6QZ9QDEFcnUddFGKuajpTRwkVk=;
        b=Jqizt3984ohx1ZL09+pmFfdYQ66+EykOLOJe1AIhdtUiPb6uAY2edOWvlzs0J5Oc1p
         3WpGzTnkDz/iw8M+emD5QynHSd5g6IVfrMyLw+B0FbemeS9xDv9+WmTQVmkGGzYR49Yu
         wasVA2WCAMn+EwIVpjIJM1bLAVbcpn31+NyQ+sS4wTGZb2r6A65bOn7G3Qf1EeXEp13X
         +GVDdQLfbUBpAXKG+/ISxsGhj/j1nObkUe6MUoMOJe9PjAQZk7FdwH7oUT/1l0Zt3YLR
         ahm+WVMGcVrKIKij1pShu+RWpa1tkV+K6jWiiCedxDknDJuOosqtG5tMC4OVQBE06iqI
         8g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898830; x=1734503630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuXCx1rN4/hrvtLTL6QZ9QDEFcnUddFGKuajpTRwkVk=;
        b=bNnAHkQKVJATQmI/RNTlSqXv4njNSfwBj8RMz+C0zkUMYFQIQ6mWspDF/T0LbQnQH+
         wlmuxRCaPm5ctFCh9svI1J7BxhxBBavbpMjl2dMQ2Vvzj7wELbQmVhvyIM80cVxvBPBZ
         kjxwpXdJ4jOYikvc4PjkRFz30hUWbGp6JvK9HLFOPlTVw4J5jKXPHG5RZx/045sg08kt
         N8qXZruqYfrVqa/2LNwlNffShejqMRXZxXxjWhj1N3Ptlq014qG9TkCBWSdcb6h10s9l
         fR8bTB242w0JBZGVvGi35hVvIyzhWjMlr17agUnVUjHjOm1j1PI1z08PbswbIwrfKkGP
         2QSw==
X-Gm-Message-State: AOJu0YwOjtWuNm5dE0FVDH/RrnPtAVygxCTyns9W1eGgtEPh/S6gb4Cx
	i0Cp2+TlKhVXG60Et8tL1gQrfGSLN/KwrXbS0KLZTYFrE6BFKfVvE80WkFTp
X-Gm-Gg: ASbGncsqlOy352/r+wKmT4AtWNoEO+IygzLF1E4f9HBVZlwaK+m74OOGuE1GhYFuZu+
	pDHi9+tpFi6ej5tuQhzCqqzfOl5MWRF+WGNa+cVf190BMTgdHHYm0ytEBwI/Otu12K+5HoXYp1L
	Xa3oO0r9ezo0tyOiOj+0lJxOMJzcNx2KH3CBq/yXmjkLqL2cN778AU4PRVQIOysyWsuqTOvVib3
	GNCKeri81OdCaVF+ALDM0J8UUgYaFGCg7XwsiJjHYKT3wOBnH4ETwDlMAcxrK8=
X-Google-Smtp-Source: AGHT+IFsnbJuFDqB8GQht+kYiHhX4h8Yo1XHJCVqq7UPrPd2p+39Y2BaBvHowhp3xLmUdupwGXPBUw==
X-Received: by 2002:a05:6402:270b:b0:5d3:ba42:e9f8 with SMTP id 4fb4d7f45d1cf-5d43315d529mr407899a12.7.1733898830121;
        Tue, 10 Dec 2024 22:33:50 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:49 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 4/7] git-submodule.sh: get rid of unused variable
Date: Wed, 11 Dec 2024 08:32:31 +0200
Message-Id: <20241211063234.7610-5-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241211063234.7610-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
 <20241211063234.7610-1-royeldar0@gmail.com>
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
index 3adaa8d9a3..ba3bef8821 100755
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

