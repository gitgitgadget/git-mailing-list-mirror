Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EEA927
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361669; cv=none; b=FJwivkHIWaYsJrwFU4j9jD+tgv6aATx4rLMSA9h9IKhWe//v8XjN261MQTfEu6FQsaGXVr0eMOvE/rnrqR+SV+VKqDutDna2NUkIu6BWyox69Om0EKImgsHrw8zVaMVbqL4v5T0Gvn1zYRhC0FhXNAPNCdluttXy4Exb4rYtUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361669; c=relaxed/simple;
	bh=DdKRoHYa6+KhPfZoRH89Tar2Lh+Kpn64gJz9JpCKJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtDsoElvbDfkm1k6iPCXpbJdqXRPi9VZyFnvy6M+ajLTgPlHen+fEY771SbtzPiCHuwiYS71vsM/xDRjaRQJArBXjY9RlLEIZvk9vTZD8hu5bE1zmh4SXVH39Dxwvb0OU+HBKTp8XEiDedRqOqYrYKvq6FY0VNxxQg3pzhJ2dOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bymr+1vd; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bymr+1vd"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-708d90aa8f9so54815187b3.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754361665; x=1754966465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwtsrYsgZcLjiYYXKY72hRS1IPr6KiHrr/5oCF/IBz8=;
        b=Bymr+1vdSME+e86BmQC4+i5SbHzwfmpDI7dtzpslzM8Sgldaf5L2E5GyaPqGT+rVqT
         A/wxCuIsC/qaRsSP0srOyCa3lITK3hO0f9yUwh3ptN/tYRaIEsk9EE65g0+UOvDCVbWP
         sDc1gYvaUpgtB8edFfIc9VAqauYM+ZcLwdXDquLKgPBavKs4Nny5tWO4FF04E5FM9AAW
         Xbv+08gOOzoqfJT6Vm0tW7VWFFo4JN8ipRBpBoNjjeGUWQ4yyAYtjIDwTj8yJ0W+Mn4x
         KgbOvxT4f8qUmdZ/5ZIuzszVYqjNfNH2bf9rOQgD/8GGqeT4OevCWQNopQCH9rLFdpf/
         pZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754361665; x=1754966465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwtsrYsgZcLjiYYXKY72hRS1IPr6KiHrr/5oCF/IBz8=;
        b=Sfn1uOocSy0WoqpsEeZa+GzfX0VZ9Br/+PhvP5LIw2aKuF+WMn/1WiODino0z+S1UJ
         gNp9I6eC8jnbz/CJdmRyStREIBAXboLR64ms/oJO0KcvYTX63dnIbkZcBJFl9HgZJVkf
         5Zg40bAl8A/7hP4Y+OQMK0HXjsp5YfuHaZt00/Lo7hBVxYvikCaIdAjktN069LB/TdIs
         KEW9LnSnLKOl9Y/DS0tW7X1aCyvtLQvwFjDLIStfzC23/xux1UYKzstNYGSJCM/C6ewI
         IWx+WSJNqZlo6GqVfY3EsuSDnDs3XJpv2gBffulfVD0jcMwWqXHI3eAPcoYoL4juzvmV
         r3MQ==
X-Gm-Message-State: AOJu0YxeM6tZ00/XevsPRjeXsMYjG093nSHoWnlTZuxaXU2wHIWNOO1E
	FyGkBW+ro5rN+yfx2zJvTmompZtBF0p+bWytvbv+3w9T+jY5o4BiS9ylwqtGrQ==
X-Gm-Gg: ASbGncuKi/BJHlTfZ4MACrZwg5b/T9U4IFrnnIY7IJYgyOrWPXX477VYXpuw83HAs2g
	kueUI11e7r95m9Q0ijOlnMuTtbUxYH2fl1dZ6FBccHPPtBIVE1s/RCvRxXLbuGXnGaLZaUwduUh
	J5PugvtNgIB6qRyYYZT1qcYrzvyrxP/3ZWKmoeHrw1ogvdSXcQcILE2Ro5OXxqa1tJdUR4dkoFf
	xUBgKK6iLmLCJ17bXNBoZ4saai7LQCwPa16VqhyjxEWCYd4h80SXQIwqxKR6/uQDKSbh5S3wF7e
	o/dAGHWifszD1AHTyvTYT39ufon5/V1Sk8Of2CUOrzFKYONQByqF6ZMGfoT/+js9bNRGLrvWmpu
	V4VxKsuX52QagOhoGgb5q/hWZ5X53nTJ+9tODnWIhlmzDssAzjvCirGxcDswOWcX2ctAHIJjU
X-Google-Smtp-Source: AGHT+IHJ2b8Nw9RdJNhJwj2MnBiAGiWV4YmJeb9JCdZZ7pbnLHUYrC79JmiaT71KbkCzfQF6UXwRwg==
X-Received: by 2002:a05:690c:ece:b0:71a:20e2:8958 with SMTP id 00721157ae682-71b7f0afbb4mr161700557b3.36.1754361665177;
        Mon, 04 Aug 2025 19:41:05 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:f9db:16d6:17d4:7ce7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5ce7b5sm29895707b3.71.2025.08.04.19.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 19:41:04 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t7005: sanitize test environment for subsequent tests
Date: Mon,  4 Aug 2025 22:40:40 -0400
Message-ID: <20250805024044.30024-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the editor tests manipulate the environment or config in ways
that affect future tests (because they test a sequence of overrides),
but those modifications are visible to future tests and create a footgun
for them.

We can't make the environment-munging override tests undo their
modifications because they rely on editor variables overriding other
previously-set editor variables.

Use test_config and undo environment modifications once finished.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 5fcf281dfb..06fa1ecd91 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -111,6 +111,8 @@
 	'
 done
 
+unset EDITOR VISUAL GIT_EDITOR
+git config --unset-all core.editor
 test_expect_success 'editor with a space' '
 	echo "echo space >\"\$1\"" >"e space.sh" &&
 	chmod a+x "e space.sh" &&
@@ -119,13 +121,10 @@
 
 '
 
-unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
-
-	git config core.editor \"./e\ space.sh\" &&
+	test_config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
 	test space = "$(git show -s --pretty=format:%s)"
-
 '
 
 test_done
-- 
2.48.1

