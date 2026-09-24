Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA647F76C
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255369; cv=none; b=q04pbNNxrw6qT0LLgXX0voCQCdcqDo5xbN7CmOVSPu1KYh/+1wjIZzbc12JkQsuE+pkMdudw9MTlrdSr+GefNPVv6B2yaAyRdRMA/8Tjdm1B5Ejt8jSoY5Ibu9I3zmcTu/28c1rsr+StajAXfz92qH+3FCWnGSG1yCmoxjW06tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255369; c=relaxed/simple;
	bh=Ldooleid5IWXXcWEA9Lah3JYZQTqJ2QeFjjwVChQ1TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XJaJx0U7SvmqQESx2rkShUQQrNagVqhxxq8TsCOU4OKsgHcesX+NQszUL1YkgiUAbxmBQa08gWaJKdO6d07ifIRjn9Sto9n1pkPGqH5I58VewVSmImm4eFIPX/yKmbJYcn15lhCTeEShjTK0aO9X5NYf5UD4uIOFAWdh0t/vdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFBaDx4v; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFBaDx4v"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so12527655e9.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790255366; x=1790860166; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7eS3PlgexcQUJyO5Gq/JOXs5PfeaVBSnUq4uzhFp2t4=;
        b=GFBaDx4veRXw/ZpC7u4NH8E6TPQKj9N8fxy6FvSTqoZovSLknFUNISVDkGH/TDoh8h
         jnbsSvccYQvCvDUy11zzB0+yYzBCGSf+RIeHmTB9D6/Ki7Phkktn4F45dE3sJlxzBBLD
         at9KgueVxB9vm+TmPsM5/PUUjqO8sJZ9x403jHclOFdmuiCBywCmXwYs+vEMlFaaMvCX
         xPcwIWmjEYD6nAcimHJsHY4BK5QRcx0yb4JrXnxQgXOKWPnydgKoOR8YGlS30FXr9JG8
         gMQNcZcAZfsC5HwxFGYV43tS+yMjfQoiZmozOuC7SNQV/qT4jmCYciWvgjnJjtnluGSa
         tfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255366; x=1790860166;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7eS3PlgexcQUJyO5Gq/JOXs5PfeaVBSnUq4uzhFp2t4=;
        b=h1Q/o1VptOgy4BaqxS1F9RJQbQo3VTPvVJU5OnfBzdD6v2x8SGBpaz4o8C7/noCRwI
         yDX6TUxu4beyUKltCGr5dQCyO9ZF0x8w/hhxET7Yj1cGQzCVAVVzdz9qAoQWJO2bBqY0
         uB8fe0Nnglhg/mBqo6jR5HWN9xoivfsy+W+k5PdNf6FtCLlNcf1jQgX5xgHsE4rcRGjM
         uBkwIHnp6bqEsGLYPlT+3df3/U+669XPJwbWIZjKJi2kQEkXV6/WK2Wx/oF8IY2CsFUJ
         F5JwT+c5eu65XIhfwtX+GvyX43JgsDT8v/4aJyXjH+y68YbnRCUKu4b0di+cwKlcC5QW
         RNnw==
X-Gm-Message-State: AFuF++l/QJuU5WTsSnn7zcaUwag9fmBNnLhHdTuPmjq1oMEv/mYlHkq8
	LfL2FLK72KouUUUHRAC/7w0AI7E9J6v5+a95OYwc3ofAL1GyttyYKNZvqGjCdw==
X-Gm-Gg: AYBFou3xY1F8Ltp3XdnRJqOXVfpctjtBKYVEuPowQg8B6wvX5+Oncga9CVyjxUKBAxD
	G+NH+pY4THoAOWrU9o3gljeH1GID5aPAvqaud/eQeMOkg26OH5ENDCYVvn1JLfQLMf/97qjIcc0
	ZjMNFYYlrhA4Cvf4IFb5f1OPNR+Wywd+KWDQLakTMytRiSmoaJ3XuyMDYSXfWQ5117QEkGtqcMz
	bfL12lOpO0ji2WzXLojnIu8HaALI0LqrgxXW719eRIldOLEFVfEr+BZpfuZXofFUA/ws8byZ7HQ
	kaCpQzlg4EGJvOvOa//Ue5PEZSwTfgbm3b+egiVWrC25BNrZAhG0q5OIBgiM0ebDeJDEZIzUI/l
	HvHvW320+sQWLLWOVgrcydCfmQkQY+mGLr9nDqRGoC2r6tygeHuO9CwaFT7sy/U5PbUvmkAubRw
	yu5xsuuMsKELXuLW0Ee38P8QvXC9wrdgWlObN3OqUUuu6W/LTbbd80pHsDnIhAS39obqnIIoiZj
	1ra7aWaPF+HzRhtm8sXowCLYgg6o2lagAEpOQ==
X-Received: by 2002:a05:600c:1d29:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49fe66eeeaamr46833675e9.24.1790255365496;
        Thu, 24 Sep 2026 06:09:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:e947:b7c4:a433:156c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b44db6sm73903325e9.0.2026.09.24.06.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:09:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 24 Sep 2026 15:09:18 +0200
Subject: [PATCH] ci: fix unit tests not running on windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-785-unit-tests-don-t-run-on-windows-v1-1-223cd2e4df43@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ7CMAwEv1L5jKWmEQT4CuJAGwPm4KDYoUhV/
 46B2460mllAqTIpHLsFKr1YuYhD2HQw3S9yI+TsDEM/7PpDSJj2W2zChkZqirkIGtYm6GNmyWV
 W/8RANMYYUwA3PStd+f2rnM5/1jY+aLKvGtb1A4IkKxOHAAAA
X-Change-ID: 20260917-785-unit-tests-don-t-run-on-windows-7831eeb33371
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Ldooleid5IWXXcWEA9Lah3JYZQTqJ2QeFjjwVChQ1TM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGq1IQQer29QO3IK9VL7ywYBSy/iWo8PDJN3g
 XK2RLPkl5ZCY4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqtSEEAAoJED7VnySO
 Rox/AkYMAKDUDVl6jx/Q1xDNhFUIR3pjHY7mOa0iSoPV+ieDjPQz42SrZXC/QVdglmjJA9ZtbVV
 w0P1EE6+zEU6kC+TF2l+ggaIjQVcmLydfC1uRz1dLZptkcjNiW6Uf3v7qP1obpua3R2zm6yKeHD
 HltXcRlFw9IaNHQCUtEH9JkfiyO4JEKlLcJVGys5SZmt3bqJHBTWqG7gkjZjxofcZDJk4M9H4bc
 lW6lZsZm+N4CEQHZkjcyhrG/YUdK8OtgoY6YQLuWlZcz5HXkozCjJdIS0g6e2diVV82qI0Tvvyj
 82EJJHmb3dr1BttH44OjhHhNkaxABfwoPDQXZKxaWHf+Bg8GnIDdEvinFBvQ+VVyMpKyUsvnelP
 1rYuqYhZ6puZf7BAmC1U6ugWA/paIhn+0a4q8zltgzoNeulKTGIX96IQmbXBonmixCNhDcogVwS
 Vfmg0bpHA5e/HYIuXsNO8okT1StTaOOeqyxqsUeTAyDPxCVx/FRorlHpkZSx4C0y2VXR3i/M1/2
 kY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Since 3141df7ec4 (ci: don't skip smallest test slice in GitLab,
2026-02-19) both our CI workflows at GitLab and GitHub use one-indexed
slices to run windows tests. Modify the check for running unit tests on
Windows to also be one-indexed as otherwise, the unit tests are never
run.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
This is based on top of 2d486439fe (ci: fix unit tests not running on
windows, 2026-09-17), with Johannes's cargo fixes [1] merged in.

[1]: pull.2233.git.1789819933.gitgitgadget@gmail.com
---
 ci/run-test-slice.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index ff948e397f..d0063efc42 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -10,8 +10,8 @@ TESTS=$(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh)
 group "Run tests" make --quiet -C t T="$(echo "$TESTS" | tr '\n' ' ')" ||
 handle_failed_tests
 
-# We only have one unit test at the moment, so run it in the first slice
-if [ "$1" == "0" ] ; then
+# We only have one unit test at the moment, so run it in the first slice.
+if [ "$1" == "1" ] ; then
 	group "Run unit tests" make --quiet -C t unit-tests-test-tool
 fi
 

---
base-commit: 42f706c773b555dd34b9b913e9acb0cac617b1f0
change-id: 20260917-785-unit-tests-don-t-run-on-windows-7831eeb33371


Thanks
- Karthik

