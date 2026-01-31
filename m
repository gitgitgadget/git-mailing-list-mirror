Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1B37B40C
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895817; cv=none; b=U2IYw1HzBH2xOihOWAPmB6IKvA0IDbLIw8SKmOtk7MldIZsqpCJ3XQg84z5xacRm18JeXU4FfHQF8ExtD1yB5uzkK0v89zh2qQJJ1tyoNzPhfhLgB/ufMEdgsUHGkzKorxBT7+kC2epklAiwoQn/nYeiFD7tfymSYiTsjanXwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895817; c=relaxed/simple;
	bh=PTTUwF1l1WaNwiVBXzbTSDLEUl5EoBC/RxDHf7alyH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UW1M1HMmIblVP2X9SCY/mqNEVL9Aws56Ud73t4oXZdOYD9/VmH7t9gjR+yY8BwQHOe1t2yjflk2Z7oR4GU5mFnjgTVHLdP6gFEgRlqs4rQmmj5BIphsgc9tC+dcmdxrmU/NMQ4yHyWBKvPhtjHpUIscxlCkVPtODvKI/eSh2210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBEt9tjP; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBEt9tjP"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c52c67f64cso306197085a.0
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769895809; x=1770500609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE8bE+F8bRhd8v6osw3mzc25ltJ9Bvcv7090rCflie4=;
        b=iBEt9tjPg5Mj+XJNvbrNKv7VfPHbGHMInkmGAa61tV1Vbb89BZLEghWKq9sYUdnYTp
         ycnUua+z5j/MC0IVvnPAuzZWbsB4SS2qDSTihcJ3Q62yypnxZ12IaLZqn/8AROuge0gQ
         MW0LDf+SFv0Yg7PDeHFL2NE6TwVkaO7lFeUQV30csomI9GOPOjkCa5Z6Z3cYVKzUFthS
         WRqW0hh8uKFKrpznwKYYOBDcRTuI/PgznBS0UFqsxl1pF92l1jGpZcuKaep8EePF4wJK
         eg60npLD0RD3bnmPYIYq8yqhHhULfiIxnmSF91elwOiDMicxyePQc83jwwx3iVTh5JWF
         ac1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769895809; x=1770500609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UE8bE+F8bRhd8v6osw3mzc25ltJ9Bvcv7090rCflie4=;
        b=dPw8pIZczdHVXZ0g9QPrUxjTAL160GyKyq7pLGQ3yEUwqUcmOTwSupIdnK6BEShRXU
         KbGp8gS6GHhdFUVq/FjTYO4a91JoNApC2FH53s2E+tBKLDB3dXipscThEszCjumO1IhO
         8+WG02e6tUVvlMFkmXAh6eUlwE6vNKKFSKIPJCUA3LIesw6zrmG4U1hterxJlhv9GUFx
         xQzMs3jiUHOcV1/fGtVj4cB6EuYO/MFEVGqMRAlHZPScY48slFwkKhje5sHWTkg2DMLD
         K01WXgI8KkFoY6TLWs2h2LqLn5XJ6KUqeo317KBbJo1j0g+61+LznX9W6+abGq6kd3/l
         zyQg==
X-Gm-Message-State: AOJu0Yyu7XU30POUD3HKbcrIgkcPTmd5FXTGSb1fe8mtbTgWtX4JgPX2
	j0qWkwu3P8cWr6FbYPEMT1MMG+Zyh4E148ZrhD2LoGlRIME2voOBIfkHjFHPkzF6Zd0=
X-Gm-Gg: AZuq6aLs/Z54EU2CygYepm5VL0ONTWC+UMYcr+heZPNyHI0S9a996bGN9VbvtDj27uC
	KC8pAsVces8Fg95/TiyuUp1lukjzibGzG+eQ/NXxrbu/UW0dI9xtalhand4VMTtuj1QztrvgNkm
	GWBVN0j2lBK77GL4S/gokNeP/URmeVFO5ak93bbXAsx+DDEKlAntHkmlyz66iuBnKJdfSLKGngp
	RJc7hqrk4aHgFaFDX8nnV31lDLvfQuh7L+lNuMo5TPr2/KqO3AOGVAv+jorTtiKWzp8efCHq0sQ
	L2X/AFC2cKYqAHAwZ7ZWCvnWPshQt1qpm/ohLnJNRAblAln6kt85CmRXVIugJde0MIQYcHSzVxO
	LmOe3qybe66Lbs5hON6WYHUGVD2vmnVvIXdA6eWQ7qv7BwbiWB1UeAMpNXgwH76Dk6vCnKZkn1+
	F9CYZXRLZBXHI=
X-Received: by 2002:a05:620a:290f:b0:8b6:134e:22f8 with SMTP id af79cd13be357-8c9eb30f8e9mr895724685a.60.1769895809281;
        Sat, 31 Jan 2026 13:43:29 -0800 (PST)
Received: from development.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm965368785a.18.2026.01.31.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 13:43:27 -0800 (PST)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: glencbz@gmail.com,
	avarab@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH 5/5] doc: document reversive traversal and related modes
Date: Sat, 31 Jan 2026 16:43:09 -0500
Message-ID: <20260131214309.1899376-6-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.53.0-rc0
In-Reply-To: <20260131214309.1899376-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the new --reverse-traversal, --append-superproject,
and --reversive flags to git-submodule.adoc. These flags enable post-order
traversal through nested submodule hierarchies, which is useful for
cleanup operations and dependency-ordered processing.

The flags only take effect when used with --recursive.

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 Documentation/git-submodule.adoc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 95beaee561..2be477952d 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -437,6 +437,26 @@ options carefully.
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
 
+--reverse-traversal::
+	This option is only valid for the foreach command and requires
+	`--recursive`.  Process nested submodules in post-order (deepest
+	first) rather than the default pre-order.  This is useful for
+	cleanup operations where nested submodules must be processed
+	before their parents.
+
+--append-superproject::
+	This option is only valid for the foreach command and requires
+	`--recursive`.  After processing all submodules, also run the
+	command in the superproject (top-level repository).  The
+	superproject is displayed as `../<name>` to mirror submodule
+	output style.
+
+--reversive::
+	This option is only valid for the foreach command and is
+	shorthand for `--recursive --reverse-traversal --append-superproject`.
+	It provides a complete "reverse" traversal: deepest submodules
+	first, then their parents, and finally the superproject.
+
 --depth::
 	This option is valid for add and update commands. Create a 'shallow'
 	clone with a history truncated to the specified number of revisions.
-- 
2.53.0-rc0

