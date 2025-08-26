Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213D2F7444
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193824; cv=none; b=RwKUhLBv/Mg0U342V0f74dB84KPXqAmUi7MxpVavfRvygIMa39JVwIRh3uggMrbO5NiJyR1vCSBJVEg9dsmnvHHlh+oHIlZtUXVa6WWCbrgNfuZs0UXLbDnSboVLEuqHHsuiOtm5QP5g3stfTBY0iLfrOM0z8+HdGxwVtRgbk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193824; c=relaxed/simple;
	bh=H9JvrtrWLPMxXbNDV+3zmZUNzxsxpLaumrynUF+tpSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L63mSqr4Wb+Q4+9dsARjXjy1eo7/9tHO649Q0vePAhPfYudYl63Ay+P6ypmUB7VbRNY6W08AmhxtjNJ4fv2pA1GMzAx42lu0Bk6eW9xm1SsNlzlX0kstYDvjdykYz5fclIxPWHj8k49T/Dp9zdi4pnZlwxEfODaQazmlbKF6zVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo7clVOw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo7clVOw"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771e987b4e6so1324316b3a.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756193822; x=1756798622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PELAp4sikEbY2gTmMLfwfsGo/ARzKbpsS/L7V6sY4mQ=;
        b=Eo7clVOwxdor4wdLMagM/+0eHKpVF9mYG8iFo77q4kg2i31phWbh/fuCR8DzfbEqib
         t3Sm1qatDhh1za5hA/lhilqStXzPTT7kpHTiSuHGjYyIVIpBmjscTjzWFpoiI3f3j6LL
         jKQy2FpyalHzq1LeFSOdP+MDSnInqJroKgrAx/O+6r9CyEIaFIyy8JeEKEQOSk4sOK07
         EfyfGGZMZfA0IjNOxZxIqfhefQrhhXn9yMelvV/jLmmlUZdgW2yNyOroCLZqIgofV4rD
         oer+KES0tKX3PE5oQvXtiGgpJaU8cVwaDiZoUBQv3x8KhwpgUlM86VyFEZ4qFEucTRHH
         jekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193822; x=1756798622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PELAp4sikEbY2gTmMLfwfsGo/ARzKbpsS/L7V6sY4mQ=;
        b=Hq5JyXo49YCmLL4wsmNroTnlEUnMyYz+XIpqrGE+V0CAWAtjE4BTxhL6OGEcuUHJkh
         qktdYC8VoU65VfiJNFav+bk1pOnm5tuAWBsvbc3rD2bsuJsMI2N1zVnuxmqNGxHxUUfT
         HU9weBBQMAA/qRhX1K57byOEgGWWUo1ZgMemgmaovQZSbHCadCHv1tqQaDwTvMVPolvm
         L535EdhMc2q/Ya2iVQrEtUIu7FQFGXn+R2tsMDy0eO5lk43hnSwj2NVDoevj7st9UiLd
         ts1n686m2gVndeTQC002+oRT8YMaNJTAaD5n/EfWShew/2DU4EV1Gi+c6i72O+6StjLl
         qW4w==
X-Gm-Message-State: AOJu0YxKRSbarPuUp9P3m7m9jeBFg0fpO5fheVRyFj6zPYUuhWoYzVyU
	O5kzHpUy06e4ZSEcklc1dlM4ZZgfjzbdRI6H6WBG5g7PGSpQ6cMhQuQPpKMinw==
X-Gm-Gg: ASbGncufbyK4Cw46FjAJq/lTaMiYVz460pEsqLJXlncL2S8XEvdd1YRwCO8A0nITOB3
	KCrKxYGGns14hpjbJbcw3RSFHImZlmV9vxIZS/oIkdrAxWK9ve0WU3RtQ7QQyu35n45YszBkIXn
	1iLDkjDVH8n787he1VVxOXaKNnzBE9PMLZe40wFk9M/uzVYFZVX6DmF32akM5oi9utV/hgfjSf0
	5u0BCn4U7BZ1+tH4/2Ay4+eT0saEp95F2iaOotw56hqBbLz4qInTTNjTn8jRE85dBnzSwQ8dwJw
	pQcnAyI72xXQPM825aTTZ8RisTNVunCcIMhu2xpiA6H9/QX3cTWlVZ4eeGeUzkVj6lfd0apKzmm
	tMj/wAwFOv53EmnzUZe4IR/N8mWRL3w==
X-Google-Smtp-Source: AGHT+IEQqIQNst0/mG5sKCIjntPkeqPLsiTZTkEWV3OFi984w2gi+m1xQOV50EPwjyX1Hiq8OWBazw==
X-Received: by 2002:a05:6a20:6a06:b0:23d:7b87:2c88 with SMTP id adf61e73a8af0-24340b7c7dbmr18560600637.9.1756193821992;
        Tue, 26 Aug 2025 00:37:01 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbe1sm4046216b3a.27.2025.08.26.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:37:01 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 5/5] t: add test for git refs optimize subcommand
Date: Tue, 26 Aug 2025 13:06:45 +0530
Message-Id: <20250826073645.1074397-6-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826073645.1074397-1-meetsoni3017@gmail.com>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1463-refs-optimize.sh`, for the new `git refs
optimize` command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$pack_refs` variable to "refs optimize" and then sourcing the
shared library (`t/pack-refs-tests.sh`).

This approach ensures that `git refs optimize` is tested against the
entire comprehensive test suite of `git pack-refs`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build            |  3 ++-
 t/t1463-refs-optimize.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100755 t/t1463-refs-optimize.sh

diff --git a/t/meson.build b/t/meson.build
index daf01fb5d0..48f83e12a7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -210,6 +210,7 @@ integration_tests = [
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
+  't1463-refs-optimize.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
@@ -1216,4 +1217,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
new file mode 100755
index 0000000000..c11c905d79
--- /dev/null
+++ b/t/t1463-refs-optimize.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='git refs optimize should not change the branch semantic
+
+This test runs git refs optimize and git show-ref and checks that the branch
+semantic is still the same.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+pack_refs='refs optimize'
+. "$TEST_DIRECTORY"/pack-refs-tests.sh
-- 
2.34.1

