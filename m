Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2F1A0BD0
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896036; cv=none; b=Vd9o5jS7jTHal6C+cU2iduB93YLq2gCn9obZqTwb0uW2aVCYJvkDOwp/hMnWoZsB2fgAa6LcqTb60jO1r9J/yJunoOvIAWJBdsVOhw89SELnLAHLmeq/4U2J3A6KUK6R6FBy7OG/GMf6Ql1jYlTJHYTQlaMWdSpOcTDdSwwf138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896036; c=relaxed/simple;
	bh=mlCHDovMIs/uFtXHTFOqg2FPHvPWQo8Dnk1vvBoXmMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k6rWBzt+DmcORn8YWt4cNVG71ClrV2le7/wTiTL4iMXENfOlakaKjTUVGj3zuG0EhQIzsK0QGLJIAOGNG07hUUkgbN8aj3j/TWBg4Rx7fZ5/qQsBxOAk/H6FQP3vmnxBtk6eFx17Lb+ABFQQTb3sMvwKrORBaRUYfr6DaN6znQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoRsu9Hv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoRsu9Hv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837907f535so44161385e9.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896033; x=1772500833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBLfeieepCvL70ZmE27Xb/yz9IBdYo3ha4PeF8Da+lk=;
        b=HoRsu9HvC2c42DulGMmoO4FjU2eYqsKD8tM3FwMEcH/QYglN6faWZdp+ExRNLokop+
         KcMt1jP1iiCZU9t4yZzlvyW2JWanE3ot6LAgzvbhdc9Ts330Kxy7jFXDy3Q/z5TKwlyz
         XOm0iLIELhH5woRN7ZHMNxgwmkcZTw5YuDPSRgwDygoEamR3z/cTfZxrEtz+5RuXoeq/
         hk7yZ7KZ7bMJlVxfuvhZViYbiZ9wlJ0FXiQ/4EnnsA5G1Y3ImVHecDAoo6eIKxwZVkei
         1qve6uwZhofv4St8VLVliioIsK8Ox0cTxHjeBWta6lBt23YjxuEF7L8taf2uoeUM6BFq
         zDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896033; x=1772500833;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBLfeieepCvL70ZmE27Xb/yz9IBdYo3ha4PeF8Da+lk=;
        b=LuqedMaX7aq4Y95WWrJ4pxBQynCIbsAI/kviMhCAQwfLG1Jj0fKWRR7bz4yCJQ5zCC
         uh7yFNTjMbKAmP/Zej6V4B9OyZuSXZXqXi/tIKwqczpO0ZBUYIG0W2gadwR6vZtdrTKE
         Ak3i5n2US27Ah8py/QjTq/lhCghm5rG9c0yiJhuxWHcLCAArrp64JUX/C1IShJw5ennP
         RR12NNcg8XJktQDaRGWQUwtivkzHVm7XZ4nRv+OpMaCpLJVPc6I5FTko+nyWYj70lpbq
         rp2C2HwEMj6tNqiB5gCCjOEtAPiKoWHtnyYw/V6BvvIoXfNCX1PL8fdjTwdOaNTcTmli
         4mSw==
X-Gm-Message-State: AOJu0YycEBMb/8qLSTDhuYhAz/6KNn75DKwlQaEXdYImNJaRCKgJdYe2
	UJuV20jvGkCSuCnKlL4xJ5UCTjqziHzcTN9oIIulKcvDti6K59rf03mavWxJSg==
X-Gm-Gg: AZuq6aKZqaz2otPrGi6PaTZ+MJZdppMq+74g9Ge6Lw2AQe/UFCJBFE1Mc8yxQcpe7MO
	TnhFq5lpEg7lKOBi9z9ZkUsoyTszEFg7D/zyZTazdPp3YxOqzlAxLT3FAFcuX/oax+ApMEaETeO
	LvBA2b3xU/JzuApIJJ1c13VQIn/TfqzlAmHyTHtY8R9HcICbZ8dzqxN1FXcy/T882JDDQvaMS7y
	wJlL9vVCxBeMT+5sY6kJVTQ55GsbkEktZHCc4Qq/mzTh0TZKwcSCl0aLFnRVp31rsTdqUkKxscj
	dvOCNiAPLYzplkjtia+WUeIYvfihbqCAJ0j8ChNdtnwEdlIOcWN96RC4mzScBqViL9isTYpz48q
	vGc1+GElUA++FQczhSXkEGBHFVWqZjhGOzZaUS8J2JoGf5OPkKFjM9oOe6AML82HegWDmI2kTTL
	tQekSU/PTQWL9cxb1h03MeWvhfBnhWNLz749s=
X-Received: by 2002:a05:600c:4f94:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-483a95eb365mr156806145e9.19.1771896033001;
        Mon, 23 Feb 2026 17:20:33 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm20941250f8f.24.2026.02.23.17.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:20:32 -0800 (PST)
Date: Tue, 24 Feb 2026 02:20:30 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 2/2] t4074: add test for diffstat width when prefix
 contains ANSI chars
Message-ID: <ce251505932712839dcaabffcd1762760439edff.1771895921.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>

Add test checking the calculation of the diffstat display width when
the line_prefix contains ANSI characters.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/meson.build                               |  1 +
 t/t4074-diff-stat-width-with-line-prefix.sh | 42 +++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100755 t/t4074-diff-stat-width-with-line-prefix.sh

diff --git a/t/meson.build b/t/meson.build
index f80e366cff..2867ba8a77 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -502,6 +502,7 @@ integration_tests = [
   't4071-diff-minimal.sh',
   't4072-diff-max-depth.sh',
   't4073-diff-stat-name-width.sh',
+  't4074-diff-stat-width-with-line-prefix.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4074-diff-stat-width-with-line-prefix.sh b/t/t4074-diff-stat-width-with-line-prefix.sh
new file mode 100755
index 0000000000..69ab85bf25
--- /dev/null
+++ b/t/t4074-diff-stat-width-with-line-prefix.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='git-diff check diffstat width when line_prefix is not empty'
+
+. ./test-lib.sh
+
+
+# The terminal, during a test, should default to a width of 80 columns
+FILE_MAX="filename-with-exact-length-to-take-the-max-amount-of-space-in-diffstat"
+FILE_LONGER="...name-with-exact-length-to-take-the-max-amount-of-space-in-diffstat+"
+
+setup () {
+	rm -rf * ".git" &&
+	git init &&
+	git config color.diff always
+}
+
+test_expect_success 'check width with max name-width' '
+	setup &&
+	touch "${FILE_MAX}" &&
+	git add . &&
+	git commit -m "init" &&
+	echo "text" >"${FILE_MAX}" &&
+	git add . &&
+	git commit -m "text" &&
+	git log --graph --stat >out &&
+	grep "${FILE} | 1" out
+'
+
+test_expect_success 'check width with longer name-width' '
+	setup &&
+	touch "${FILE_MAX}+" &&
+	git add . &&
+	git commit -m "init" &&
+	echo "text" >"${FILE_MAX}+" &&
+	git add . &&
+	git commit -m "text" &&
+	git log --graph --stat >out &&
+	grep "${FILE_LONGER} | 1" out
+'
+
+test_done
-- 
2.43.0

