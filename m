Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6251FCA9
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168359; cv=none; b=EEhhJjbVLvaAIPTo4ceU1wHex/QvKt+G7+TCBlD6qumClKcrnHMzxlgXK6rZLlK1O1DmbvYSvhRyJqFFkJjPoXkBBUvYnxcGgbI6u2qBUL29fl6PhAOvzzjM3h6PD3w4IalOzdw0NJ+yLfyvOJe5C85RrCOFwCs+VQqUCr3NFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168359; c=relaxed/simple;
	bh=Rzxxujsu7MbwHTMjq9my51K76bc3O2xHtYr/jyCk37s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUAFRhpAwx4BnCr62c9ZdVMF/TsoiW6HDTgPSkS0H6WeMFVzOfMY8lMk3wBfH44YzsA5ZNHxvXlIB8lt/ACj8X330Wv7dREAEALe+uPPWHn/Ime8j7RrPUOGscwaS5EcqFbC0CYIiRaQoatuE21QFNOWf+V+W8lPXSNN4N8KFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9OdUiS+; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9OdUiS+"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso811228d50.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790168357; x=1790773157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44zFv45LXhqSzd/QLx0LA9djt1f1c3V0EvABUQ6gAsc=;
        b=j9OdUiS+mA0q9X9GTdhl+3HTlwQLaJwY0+IDMEUrMLoeFlXFe5xWfEer4PUms4HMpT
         dABFs42hvp3BQIgUnRkdniVinYPxgO48X5XKbH9/3IJy+AqKYl1m6C23lfue2GVnaem+
         OXUMh/UYBrEH/uAG0fr4daQjqDFLXQsXWTUy/U7j7M9QakKMT5l8Wb1E3Ce0Nbs22rfM
         KaNTqru59wj2Y1d18ZULkVPHAapFJxZhKsoZ+dXOPqQIKQhEZ0PEPEEIGLLqxXFpafOc
         5FJyrsIXFfCv8f0jBvrDv4uu0aPZFSN9nabFXiJQ2NW6lbjyp4LJw5Kq0GA1r/EtI4C4
         0i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168357; x=1790773157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44zFv45LXhqSzd/QLx0LA9djt1f1c3V0EvABUQ6gAsc=;
        b=ltoWid1t4wl/Ugubfk8Xrhz6AcmLbGFhBzzGkjWpuEawN29FS7BapXcSVHOOkx1XkB
         arPu35f3tswLHxQeh5xha0SCWCR+Lzol9ITnsq5xt6kU+0ZYA+XRpHgt/8KA23M2fV0q
         s6JKSTHRd6xq7f1ZfuFKGsvGTj3XAtJ/fjQBKmluRIzj/eRSw45KZa4H+JEhK6GDr4LP
         J1T+4jXcNGvVDYCW6NUL+RvvxBYpq+f1CjijUkXMPAcxR/fvCY9uv1iwrWqf1QoI1XBc
         pnDig0rG5Fk+VJcx0OXltql1H9EBCuwXiwEaLLNH8QnJZYRAtPsWb8aV4HE+YwIElggr
         oNxw==
X-Gm-Message-State: AFuF++lsMndsrxwoSzwX6l5WlUMuyxkHkp/mMsHkiFXdXbJjFc2smgpC
	kNTHysJE92W4sJPFfNF1NgtP0zOYM7m5Ke7gEpoeNu0wx31knMDONRO3VLQrCqnC
X-Gm-Gg: AYBFou3HGx4xasqtr/RaD7bHP/e0+iYGYRvOtYflhLZlraXtKAWFrWDRWcER6FHUKee
	MwI90dJLGmMnlwvvd2YIfNEYE0nkroDiTs5euxhU+UhL5odYTpg6GN6LXjsScIePGOAoxf44tSy
	bm6Y/oJbpS2AY5hFWDPgCCV8yvuo34DtqnlTmcJNDjk6nGP7TsFR4Zn5r9ujUjbjAKnTA5o4gxl
	YH9llFV+xuXMDWB6Cxtazp/VpzjWeEw74M4mEL00Cgpxjs3ePJYvNvIi4vXPcg22ZfYBL7Ayf1f
	KO1CtbSg0BCqN1mjgBrFbg1jb0mr6gMvNVlOQNqESyYnxEwDcuazT6beuay5RbIMZvMH3DJKhiY
	BjdaCYVRvzG/0z7eM3AOn/vBZjozRgW5zNxoqDaisvLl8haXoq5UnhAdvVmYpSLtr30hk6sAz0F
	Q3GtNmjUgxzt5oAlzOVIvGTzbc20Kfl2fezgKa6uBP2BBtMxMMKITyZ1dMAaDkbkD75PhVhcUz6
	PX0esv2kK56px/ZLuYy53cHw9pDsn8a+gkknJelur1AYK3B0Qz8Wx7YCwZqsuoBCdzCv91Px2km
	/NgfSGJhWK2uBdvniAllyw==
X-Received: by 2002:a53:ac82:0:b0:671:505a:9d94 with SMTP id 956f58d0204a3-672d5728a0cmr1380385d50.19.1790168356799;
        Wed, 23 Sep 2026 05:59:16 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d81ce7dcsm833063d50.18.2026.09.23.05.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:59:16 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Victoria Dye <vdye@github.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/4] t: test failed "stash apply --index"
Date: Wed, 23 Sep 2026 08:58:06 -0400
Message-ID: <5bd4b78cace8ba8c8887c78f739bde3513dfda28.1790168285.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790168285.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will refactor index handling for applied stashes, so
let's make sure we cover conflicted index merging, too.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 t/t3903-stash.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 721158606f..3958ab3c8d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -374,6 +374,24 @@ setup_stash() {
 	test_cmp expect actual
 '
 
+test_expect_success 'stash apply --index leaves everything untouched on failure' '
+	git reset --hard &&
+	echo test >other-file &&
+	git add other-file &&
+	git stash &&
+	echo unrelated >file &&
+	echo unrelated >another-file &&
+	git add another-file &&
+	git diff-files >expect &&
+
+	echo conflict >other-file &&
+	git add other-file &&
+	test_must_fail git stash apply --index 2>err &&
+	test_grep "conflicts in index. Try without --index" err &&
+	git diff-files >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stash -k' '
 	echo bar3 >file &&
 	echo bar4 >file2 &&
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

