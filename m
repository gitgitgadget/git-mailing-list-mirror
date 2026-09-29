Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9DE50E58E
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677533; cv=none; b=g3X1ARbOA5bJSpSqJNKLE/zc5Mu9DdlPxls3NaoQGwuw2QlsSH+SqyQZBRmkA8WJKzxhJd3F47fVVDpGiNxzKiXBFtBb6M4Qm3uHKhyv7YjYyOq1Des0FVVOB7e7ZQGJ5DW+CAOCSwzLPJmn8Ecg9VtptuaWLnbnsJJSeUtgal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677533; c=relaxed/simple;
	bh=7pdqhKMNMHtKqxlM+ZVXeVeZe+q8pMGAFvP4FqqF06w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AraYv+u2UCcfhyZXtxlfpgAvFaW1BdXSito9Ng6xqY20/HvYoMeJMhjqoRz9FbhXcG3T9DGPAv47wziYtX3RSyc1hBire1ll+ruwoB2qRjWGSuyMzFyH1jRl1oPnARDx9LliWIsak6LHOJE3lAXRj/Qq0rwz7AUGlPn3Fsy1eOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRT51sfw; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRT51sfw"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148b5c829e8so2207106c88.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790677523; x=1791282323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKnLqjoUlw+aDy8GG1WAzAw7KvA39e2+9Vj0qBj+CM4=;
        b=KRT51sfweEM7apgIK9Ll6i/oIbS54531D4q5UIM9omow5USNS4t3aDYSVM8tIbmH3f
         3R+P3FOljALdNixXsD6cVxGIOC6OplTi5FX9qI1U5iZpfi7A3ZojUoyHEWXA3vKdkD/2
         IGdy9uMaj1OXKaM77kLkNwW3tah0qApb0cQoaXfIHNONy8sCJn8YW+ZFSRHLS5aF+7xr
         5OMLscbWkXsGKE9WCP6ZByJrjvyOGl1b0trCi6pluVBbipBfwE+AY5r3q06W7ino0fX7
         oXteYo18DYeNcwa780LvNX17jqSqh3LPBBhCRnALX1IZaKvgNCLS4SFKzYVhVVaO0ta9
         QAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677523; x=1791282323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKnLqjoUlw+aDy8GG1WAzAw7KvA39e2+9Vj0qBj+CM4=;
        b=eTIJHY7MMY3JskHUZanWIQwOIdcJizIUaFKbcw5HvjubFyWQFIvxmNfrOaHjM68zeh
         0LuOib3MCC9XUvCfz3mDhkZunaRQKtyNFEJY6Cf3wisvxWuXL/octYt4jYaCzqUei66b
         /hCvNIXzmWOGxi4Q5v/iJcbKmyNd13RTWTRunXA3CtUYoioljPulmoM1YSfdMipKmSo8
         L0jXXfqFeR/89FcxGXmNUazE8ffuTasav9pMv1IM6tzDXO2MjVClG5kyaOpkVFMJC7CM
         z9PlOVxj/q5DeSRDOSiXC4Umzi2bDkSKdNJ1KNL0jlH7zXcl2lv35j0642jvuRjcxo8L
         5+Mg==
X-Gm-Message-State: AFuF++kj6C3YOu0u2hDeT5ebqlaH51kcKVdckbK/AeetpSDdqX933Woj
	SRICWfkaV+U4tAw0x1EIDgOalIgjJphfP8CJWfY31dOCx0nHbB7ge6E3OSKjEA==
X-Gm-Gg: AYBFou0WsVlONJhygOZyqNn6Xbcsu8AcN3asZHyJ4xMRsxOH/PsTKAq0OV6tjspijGn
	6n2/qOHQ2Cj0lHyHvirq9rVuKyMQXrlt1T8O/ft58+toQ633ebvnmkx4RjsLGj2oCvzQU4lOFpJ
	dezfBjWU8W69t3Z609mPJwNjGBNDPUWLU3JXosYFwVv8EK3ihFYNrdZK90aXo9RVEVakOL03rrj
	YUipLdUyurVQ3T9KiapNxURJ19DxcK9Ee/Vym3oEDvxv1mL9Srs09VkHL4ygPrD/LVKcI/mjO7B
	REZOPr89zaRzQZ4n8bmYqVyqi5b1wNiIDoqy+y4MySBXgiBnME1EGUGtfom1WCDC7q2XJa9UOsE
	0o/XEyS7mlqIRZHgnvWGprB+WlWXHkDWBQjKbUVruJ/fRAYSA9Kj3WySPByHCsAAYu90EBGv5Dn
	AhLdE67FGhJreBmo0OcGisfDEhThY2BxegHSFTreISkJBaXpdEi3rPokPUhcGrIQZGyfNdJ6bum
	WskjgUxq39fsW5u6f9wiBvpvYdLSw==
X-Received: by 2002:a05:7022:b04b:20b0:144:c127:dd19 with SMTP id a92af1059eb24-146d01afcb2mr13675622c88.37.1790677522975;
        Tue, 29 Sep 2026 03:25:22 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2401:4900:884c:d167:a737:cb55:b3cc:523e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm30417589c88.7.2026.09.29.03.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:25:22 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 2/4] t0009: add tests to cover more error reporting scenarios
Date: Tue, 29 Sep 2026 15:55:08 +0530
Message-ID: <20260929102513.712181-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce few more tests to t0009 to cover error reporting scenarios
when --git-dir is used.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/t0009-git-dir-validation.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index 4cba478e50..6c40925aa4 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -74,4 +74,38 @@ test_expect_success 'setup: .git as an empty directory is ignored' '
 	)
 '
 
+test_expect_success 'setup: custom git directory with missing HEAD is rejected' '
+	test_when_finished "rm -rf parent/empty-dir" &&
+	mkdir -p parent/empty-dir &&
+	test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
+	test_grep "not a git repository" stderr
+'
+
+test_expect_success 'setup: custom git directory with HEAD as a symlink outside refs/ is rejected' '
+	test_when_finished "rm -rf parent/head-as-link-to-garbage" &&
+	mkdir -p parent/head-as-link-to-garbage &&
+	(
+		cd parent/head-as-link-to-garbage &&
+		git init --bare real-repo &&
+		touch garbage &&
+		rm real-repo/HEAD &&
+		ln -s ../garbage real-repo/HEAD &&
+		test_must_fail git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
+		test_grep "not a git repository" stderr
+	)
+'
+
+test_expect_success 'setup: custom git directory with invalid GIT_OBJECT_DIRECTORY configuration is rejected' '
+	test_when_finished "rm -rf parent/invalid-git-object-directory-config" &&
+	mkdir -p parent/invalid-git-object-directory-config &&
+	(
+		cd parent/invalid-git-object-directory-config &&
+		git init --bare real-repo &&
+		test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/does-not-exist" \
+			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
+		test_grep "not a git repository" stderr
+	)
+'
+
+
 test_done
-- 
2.56.0.rc1.12.g2c9c8d64bb

