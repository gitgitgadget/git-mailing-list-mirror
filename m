Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA41CBEAB
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573168; cv=none; b=KOVbAhDbVHEf+G+lBY0cko0GokjxweNZpQoH0Roa2mK0xukM39+yVS0NXTA3Umxm3OWFy0j/fEDpFBE4PW94cylr6AT20BKDg/resyGvLLCVjRlv8wgvdaA+yvqUkPFfvdtMujEsqySCT9v8Uuw5VZ+ErSv3Jqr9FeHeHsZbRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573168; c=relaxed/simple;
	bh=nYNFf1+yexQ01E5pf1eLmH46SMgCf+eO+n4GApAikxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8TYbmcfzumKKA4ivWCVdIOGMMJ7cXy2llD0NRn4wz2Tn1R4dsZ3hIL7fiZ7HJfAapH9nE+N9GwBPBkZSzzmfjxdA7MFIViI6+UUIJb4OSjjIaWQ/uM6FjJb9rUior0jlJBpMHnz+UtO/F1WnGZFwW9CiIZYTOciRaaI/evXFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9ngUp8H; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9ngUp8H"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a998a5ca499so150694966b.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573165; x=1729177965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyA2ItYZ5/ks64B0/AFRg/yB3xFA5sMwFnBxGfi1FUQ=;
        b=V9ngUp8HphWBtjZv3TXXzGJ+eePR31/NpXG9rTeecbD69MlhdCwBkr2TGPh8KBVdY8
         0mAHu04iK4atirEWa8pAkr9Cc5Vmjt7h12Q1HJ58iTmMV6kZm055RRdGS/D9GW28fimD
         /batGIu9w1kgURa/D5/muU84SYRIchoqkNvXITneSzik7y+qCUe01yq4JoPOKV0SwoK/
         VOcD2GPp2KVHln2/X0jLaA8BAB3QJ4O6YuVI95CpH+5biXj4PIY2tHgjEE7fsqyOaVVy
         sRngq4p9YjPn3WOE3T53FHgnA+ahH2JQVn0Xf2HVHcRySdPtXzqZX0TmtS8F5iruz692
         3GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573165; x=1729177965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyA2ItYZ5/ks64B0/AFRg/yB3xFA5sMwFnBxGfi1FUQ=;
        b=YqiQzB5g4F7M8LQnBDzevTjYaiknKd22yaawyVeWvg+dyYTWc7EJvTS4G0VZyBdy8F
         DT/y9y9WVSUbXo2RYjA1sf27oUR8ycXZuh2IeJI2m4yibVVtmAiewlKx2nTN0e6DJKON
         i9qLrwrHzyLNVvembAQw5up4B24+DbAA8ktSNPYW4zd8pJwZGwW4pyirYio7mcLa81L2
         5KKHDkw9BEHg9j447Qu4kkr7vNGhqelTUT2yHfJo1pF8BNcnlBmM83in++G3T13A2KcV
         qPfiubvJTnOCrpNH7Q90kUjrVEP7gCjPK5PaFpnIqV8MOBfiW9sJAuoHxTkBkBLw7zR0
         dQJg==
X-Gm-Message-State: AOJu0YygPK5NX1E+4qzqbPeGrFbAlncLqnwCpRrgJxsehI3LdfMVkeZL
	5Ombq4ZRNBYGsQEVBoKjA/uhZBINYtRn3W2z0jzWlEg22aHPNXFmk6enCWMJQR0=
X-Google-Smtp-Source: AGHT+IHdLF3YPRGPoViWI0yzOfZApZeMmmYbH9gkEiYPtyglYwPX5z+lfpwZv9XWVRyd2gtD9ejwLQ==
X-Received: by 2002:a17:907:962a:b0:a99:8a5c:a357 with SMTP id a640c23a62f3a-a998d3418abmr548953766b.58.1728573164670;
        Thu, 10 Oct 2024 08:12:44 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:44 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 4/7] t: fix typos
Date: Thu, 10 Oct 2024 18:11:22 +0300
Message-ID: <20241010151223.311719-5-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/lib-bundle.sh          | 2 +-
 t/lib-rebase.sh          | 2 +-
 t/lib-sudo.sh            | 2 +-
 t/lib-unicode-nfc-nfd.sh | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/lib-bundle.sh b/t/lib-bundle.sh
index cf7ed818b2..62b7bb13c8 100644
--- a/t/lib-bundle.sh
+++ b/t/lib-bundle.sh
@@ -11,7 +11,7 @@ convert_bundle_to_pack () {
 }
 
 # Check count of objects in a bundle file.
-# We can use "--thin" opiton to check thin pack, which must be fixed by
+# We can use "--thin" option to check thin pack, which must be fixed by
 # command `git-index-pack --fix-thin --stdin`.
 test_bundle_object_count () {
 	thin=
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 11d2dc9fe3..0dd764310d 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -187,7 +187,7 @@ set_reword_editor () {
 			exit 1
 		fi
 	fi &&
-	# There should be no uncommited changes
+	# There should be no uncommitted changes
 	git diff --exit-code HEAD &&
 	# The todo-list should be re-read after a reword
 	GIT_SEQUENCE_EDITOR="\"$PWD/reword-sequence-editor.sh\"" \
diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
index b4d7788f4e..477e0fdc04 100644
--- a/t/lib-sudo.sh
+++ b/t/lib-sudo.sh
@@ -6,7 +6,7 @@ run_with_sudo () {
 	local RUN="$TEST_DIRECTORY/$$.sh"
 	write_script "$RUN" "$TEST_SHELL_PATH"
 	# avoid calling "$RUN" directly so sudo doesn't get a chance to
-	# override the shell, add aditional restrictions or even reject
+	# override the shell, add additional restrictions or even reject
 	# running the script because its security policy deem it unsafe
 	sudo "$TEST_SHELL_PATH" -c "\"$RUN\""
 	ret=$?
diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
index 22232247ef..aed0a4dd44 100755
--- a/t/lib-unicode-nfc-nfd.sh
+++ b/t/lib-unicode-nfc-nfd.sh
@@ -74,7 +74,7 @@ test_lazy_prereq UNICODE_NFD_PRESERVED '
 # Yielding:   \xcf \x89  +  \xcc \x94  +  \xcd \x82
 #
 # Note that I've used the canonical ordering of the
-# combinining characters.  It is also possible to
+# combining characters.  It is also possible to
 # swap them.  My testing shows that that non-standard
 # ordering also causes a collision in mkdir.  However,
 # the resulting names don't draw correctly on the
-- 
2.43.0

