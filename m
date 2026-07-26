Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B053DA7FF
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785106104; cv=none; b=Uv1NbKHomIFu0rA9nP7DOkq58xJlnuNzuA4f/RrD95TJqvFjeoeYyJ1AkglbVMc4tcLQZfbR4jwGmfdBigZITEq06x7lpkbyoEKhkMfpZlBBtkmDdcNIPK9XeUjV7RMEwcUpNWEMdBwcPLcG962uzqo3b2o3qGCBzwCsxTnJspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785106104; c=relaxed/simple;
	bh=+ta0IxaIltXoccw14TX4ePlxlIdXILcDALA9Cnm5ZVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTxeLvqXxxrIqsSnTvzIP52wxqPrc5bpDW3oSxWwdMvnt6NCRYGUON44vFthZhG0rX/eMki4pB4t33VbKkt9SWqdp/GQnAZe6VEiLbjYNMEA2cGZEMW+uqAP3e2wpHfobM9d616QYvO6Ar84uoD0XP+raEOexlpRl/hxQB3uQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqR8Hd6D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqR8Hd6D"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so1920929a91.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785106102; x=1785710902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yI30jV6K1oCHUZFWKauuHHWsgVBbWRzFhUf2N/zWNjo=;
        b=MqR8Hd6DuvnGMvmN9Qi6lGdIp0DtXlwEZai5IhWhk96BFdp+YAYAANtimXRIISOwAF
         ocxdXtEPSBT15cvS4i6Dnd7okL7xNHWBmdnYBqNubJsSlzS1oYBaWdBW67EnJP89nhha
         kMQ5uUlpnwNSYt0E/6d/JjDOWxyaMrxVgjTq70PLr4ViPMOJCp5hDOTpkdNHPl13pdFS
         e66ldNOUhvhDRW4kC7hLqPCsMzf2TZXk4mQFHrOHpaakRIj86uP8euHtEhWyay2dk4Cr
         NmKhVQ4ZXWeGzC+Yj5+hccI4HJpFi4Vj06wnBaYl4edzdTY0tPw2Odutllb6SaUhIQR7
         2hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785106102; x=1785710902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yI30jV6K1oCHUZFWKauuHHWsgVBbWRzFhUf2N/zWNjo=;
        b=eTq9d2b+9ld2Z2uZOU7aWywJLmAAazkbs2dNYXwWQywvScKUh3SI/8FfpQBHeg5YBu
         m8T/yCIWsSie6HAk0oqalaIxZ/OgwYR4V2oDlZm3WfFQ1hCxH1EGOjJoDUYGkVfCa8xS
         fCm4fBQVPOATmgoMNG8W1erdZjnyljoWbw/ngTIlma+jGB8dp+BmFRGsWITJNb11WdA0
         xocRS+Q5mYlS8v8KAZyT4QruCnqi7cZMH/ZM2ZFxGm4InvQ9Q0esHiWNhXM0hIyeqR6/
         0u6xpMlGQTKXBrgm8LEcpx107wfxrodfntnkVJhRt2eiPR3o71Rftan2FxeiEkOWxfY0
         udAw==
X-Gm-Message-State: AOJu0YzbDZsX7auk3YG9L4U8IhwOyCH5DogkEB92wqe+R2Q/GheXvo5z
	Szg4VazWx1KLRq4npfEMGYQrNwCt0DTIp7xFJR53cwbAshI6aXwevEJwkuhhwg==
X-Gm-Gg: AR+sD12xlEbC5Jai8D/tAL9r4XMVICtHsFP2U2NXJFUAlRPRW2DrOXPrU+dB8TQHbqO
	d7YbVhaiFdaqHm12Sz8nu8DmiMzNf0JxVJKh8uaFke/f6l3dZ8P/7BgED9VZs9PgDnF88oCGvxv
	Meppe80kLjS/VF7u3OyKH42y/NAMABsFjKphrhEH9tun9oK1jxolnPsy/XJfDVDfjxrYLlaNSEd
	ekbIr30JezEY2+Fvo53FHZ7LzjzOIibQP2eCFF6ARWgYH67KJ1R+W2mKJqGdJyY6E339nJlubTr
	SRN5ZUxROsabCcw3e0vSZK0k2oazCWFlQIR18Uyd3S73pGlRNrICLXQvTbYcplujf5SNp3HGdA5
	8b+8cA7rJSxUmOUTQ8DOEST77muYJT/wG6ket5Ue0P/Bx6jNNjNsoEBZFRDE23ePW4w5GAHvVCO
	IdWecz2AgV/7dqGOnBt3I1OPpnpXmdzPKPN8nURXGC2xdYzEc=
X-Received: by 2002:a17:90b:4a08:b0:37f:ad36:8fc5 with SMTP id 98e67ed59e1d1-38f2960812emr6325391a91.23.1785106102265;
        Sun, 26 Jul 2026 15:48:22 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:81fc:d9f6:d0c0:5850:ae0a:7e6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm24847928c88.0.2026.07.26.15.48.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 15:48:20 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH 1/2] test-lib-functions: add commit_body helper
Date: Mon, 27 Jul 2026 04:18:02 +0530
Message-ID: <20260726224803.45131-2-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726224803.45131-1-diy2903@gmail.com>
References: <20260726224803.45131-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extracting the message body of a commit -- running "git cat-file commit"
and stripping everything up to and including the first blank line with
"sed" -- is spelled out in about 60 places across the test suite.

Add a helper for it, so that the operation is written once instead of
being copied around.

The commit object goes to a temporary file rather than into a pipe,
because a pipeline reports only its last command's exit status, so a
failure of "git cat-file" would go unnoticed.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/README                | 11 +++++++++++
 t/test-lib-functions.sh |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/t/README b/t/README
index 4252774f86..9a9daaf2af 100644
--- a/t/README
+++ b/t/README
@@ -945,6 +945,17 @@ see test-lib-functions.sh for the full list and their options.
    Merges the given rev using the given message.  Like test_commit,
    creates a tag and calls test_tick before committing.
 
+ - commit_body <rev>
+
+   Print the message body of <rev>, i.e. the contents of its commit
+   object with the header removed.  Use this instead of piping
+   "git cat-file commit" into "sed", which would hide a failure of
+   the git command.
+
+   Example:
+
+	commit_body HEAD >actual
+
  - test_set_prereq <prereq>
 
    Set a test prerequisite to be used later with test_have_prereq. The
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 809c662124..03bf31d8ef 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1433,6 +1433,14 @@ test_commit_message () {
 	test_cmp "$msg_file" actual.msg
 }
 
+# Print the message body of a commit
+# Usage: commit_body <rev>
+commit_body () {
+	git cat-file commit "$1" >.commit &&
+	sed -e "1,/^$/d" .commit &&
+	rm -f .commit
+}
+
 # Compare paths respecting core.ignoreCase
 test_cmp_fspath () {
 	if test "x$1" = "x$2"
-- 
2.52.0

