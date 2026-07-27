Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AD379991
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146227; cv=none; b=SGKrC18h/eVeNzhV6vd/ZEnIgdfBnbIVjkTWVMsOleB78eXIA4zwCwiMqou3uopk29N6REPxxH3VoGMFZFaAKlmj6vqf7tm8lVCCV0WYcAYfZ5J6j2NNSGAXHjPeYObj6/0e8x2uOr1BJ4Fjl3YDhd1In57/yLnO3B/VpvXSmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146227; c=relaxed/simple;
	bh=+ta0IxaIltXoccw14TX4ePlxlIdXILcDALA9Cnm5ZVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkGiDOR+HCChW0MUSwH2Tr/hA8lAiS1Iio8l3suCXIESNwryffHNWDK0/diwULZY+xzEET4Wy2CMxOoiXagSHN9bQM2t7ArF7hKtrlsudH0glPs3Nk4nF2r2/CJ7S9JoKdQjOwohSbc53yfycPW6kU73Fch4pBqD8k5CtEUxErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzSQgtpB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzSQgtpB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cfff5f88dbso4985295ad.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146225; x=1785751025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yI30jV6K1oCHUZFWKauuHHWsgVBbWRzFhUf2N/zWNjo=;
        b=UzSQgtpBVFVOBbXAhwBWshIniQ1BseadUwbIF5QXIoIjkQtXpk4AcOqb5yug6ws9J6
         xMQdt9rIBj+fmU4E/Q2DitwBOFy1kJLfS5p+O5VIJPft4PqsGuq7lYJPAUBT/g2evraL
         eC5gbpftNi2h1zFDQFnObZU37viYUBImTYCAcPXAa9rCuXly1kvQpTjJYJJgXR3VhXcL
         EEC7B+DwKojOwzwPlkvcPb7aUKrnZQxWUqJZOI+mggxEQ4udeAOezoiCWp+xC7adS+y6
         kfKMjl9jBuQY85x7guEi/IVxhncrVvxckhfRYSYryD1ODPxEpZjQq/rLCJ9w2jWq1Fi3
         nhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146225; x=1785751025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yI30jV6K1oCHUZFWKauuHHWsgVBbWRzFhUf2N/zWNjo=;
        b=ZYG19CmkAvAZgzAirH5/3+MTEroMrKJN6qzSakgMswBJIhp/KUDnbnZ2/Bm+eD3hQb
         BpvbBUJt1Hjz/xSjT+XpNtMn8TyZoBWOm5k5Acsvdhc6GbIt8Tg6+gHMshnnDlCwJIp8
         CmQPxBMriC1+B4TrReHm6UlAWCxHFQGNfKlDwZUMjO0RrZKvK931jTQy5ilyMsCG7Mf6
         ruvyjN7Pz3jtFDOyU31k0PnFFWsdI3cxOaRr84110hzNUrJWggAt8ApXTK0w9H3zdv+2
         0Py5D4WXp9QCxjknDqQXTmpKWSogLOeq7cTBMQT2Yk02enY1GlFV6fETSHLzbgk1RuO1
         vb/w==
X-Gm-Message-State: AOJu0YzhzDYlDDf9EKFpnQDOz0pBbJunglVcS2Esqg/wBgob6NcA7CR5
	3LSbqzb1wEuSK+pwMgKuCmsDp5Gvj95z9cFPVV3PUMJoFkY+yh7xugngrwipnA==
X-Gm-Gg: AR+sD10NSiaw06azmGFR7PlUA1pDz1e/gMxOS/UeW0leT3kBzG/S8CDlIOSBEFVVxbd
	7kRWXekSyVyS0r1g15ayVOsUQJWQqNNdHzS+IENpF/1A7AdC9QtAgwBozT1940gNfGmQKZfO7FV
	d93J0z7QutU913RZsUz0B5+ELl0hSTYiEvG0lI7OxLp5BJu/KtLL8zw8QHq8XkKBt3698PORX5s
	vpLYPa+A5hmOYiXOhxnMkzpoSdhwXVGIukWKamJ40syV8PE9UOHB/7Wh41rfg2N87rp/OtmG776
	swTLXOFBrdvto3RGtdeUP/mZFsHsWsp0VaQBFustU9bDQHEdZwFYh/xeNTYm6tePP+L2AZZq9GC
	Rwq42NQXBYMguj2hgSWnd4puDwWLE0qQ0rAbCkSJ0md1T2414WLPQ4JnLlAU8jULjkxFAePnhD4
	3kzMrqAPQ0aPxWxhhYTlhO9fq7npU=
X-Received: by 2002:a17:903:948:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2cfde79fc06mr71872405ad.17.1785146225088;
        Mon, 27 Jul 2026 02:57:05 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm49203193eec.2.2026.07.27.02.57.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 02:57:04 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2 1/2] test-lib-functions: add commit_body helper
Date: Mon, 27 Jul 2026 15:26:55 +0530
Message-ID: <20260727095656.75496-2-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727095656.75496-1-diy2903@gmail.com>
References: <20260726224803.45131-1-diy2903@gmail.com> <xmqqldawq24y.fsf@gitster.g>
 <20260727095656.75496-1-diy2903@gmail.com>
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

