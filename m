Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF314C5BE
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722882; cv=none; b=m85wlGNDz39TMkej7lKc3EUhnLK5OlNNdVMyeLVIjCKuvyuSUSFKT7TJ6ymj7u2mFnodXER+WEaPklxP3JKwZKESo5gLz1G5t5IcnjGjiO6UXUcX4yqxFcWzOS/nEmZQ9Sgu9kfy2Yf+nI7vHs54vwyG3Z0SW5CeLhpfd2uFA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722882; c=relaxed/simple;
	bh=Nq2gQHOt3+iv/onpyhuqMUsh0pzFBJgBgB9/8GhItd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWhpWtYswQdCDLuEsf0hCCEwXdnbHoiZ+5C45YIizbR0i/mKf6GeoWNOkqHZNhEZR4fe3cPFNDfzf7crXFSMMPN/6hBVH4uSZ06HW5C6cn3sedkkH6x+BZROkM3buGoplqAQzzZT/5Igbzf5oKa9OQ5BgemVztAXffsKiXPzeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP/X1IyC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP/X1IyC"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efdf02d13so3806170e87.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722879; x=1722327679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mdyhr1kzlIaak5G6Svq4JUsNhcAc9DMgdapf/v/PS4I=;
        b=XP/X1IyCmpyY8mbXktl4xsubKb4c3L/GHoWzyyuJIxQW4MhyAFQzbvz3mAJdv/2hQA
         J8mIWAnLFKrYe+hYJlggupI6HyIFdWTcwedmRamRQbJ7WDGs0T8Ni2OwexPxIl8WlOPp
         W9rAFrn2V8ocG2sOs9SfmxlH9xhMRzi1N7Zy4sCuh+z+c5G59CoBwJXMjXHEh9sebQIg
         jQEZO7DfJUfUTJmAV4Y2+j4wwIuD8OddfkxaF9/Ep6C4sHAhHeG6TMJ1UuKtMVTsEK/h
         QPrGKaMA4C/Obe6/OuBv2QUPQtA+lajDFXCPEMgS/dG1e4Ae57OrqMTuIyl0eqqeEViJ
         o4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722879; x=1722327679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdyhr1kzlIaak5G6Svq4JUsNhcAc9DMgdapf/v/PS4I=;
        b=mH1TTf6gnVPOIt5Dx9X6jcOYmQBOPctKburHEmFFj5zGCK8Y1f/LfITKUe2YYDeGmT
         UKhfPgRl+ngRxijZw8AfEfZ9yItwlFvamMhxamr7XJvaSb5BrEMLrRBQArMvmXE42QeK
         KaxcgEMALGgpDNQjoLS60oq5UycTP4rMPKTB34k7LKj/UA8Irjh10sVO2ltIzPI2Bl4G
         DTHnAd5x1OFqLK8zspjrNKOWXkeirAjTGx8zeGwaWpOwpHXWTuFSdI7B3ZecMSAeVSi8
         R7OV6NNSpgduBz/i6w89Ys3yFs9FA+gsPOXs+9fCcN9zALpQY4rjZQyJ/vQXCejhACWI
         aPDA==
X-Forwarded-Encrypted: i=1; AJvYcCVXLwqAtXUMTCh0CU3Un/fO/NR9LsFq2o2Lgu3TB9XvzNdM3+qQWY6J989Ze7B4cGp4bmNyfbLRAdhLxd2ljHz16XqF
X-Gm-Message-State: AOJu0YzVEbMV1+N6akIbtQo6NiuE0T81iMszqfIzLsehWguNUm/KT8Ov
	tIPSgjimNcvMZdLSC+PtPBG4IGyRSmTmXRvrxEuMHDw+Hu+7cjhBOHNE7Wwq
X-Google-Smtp-Source: AGHT+IFymH2VT1R+On9bfWfWUO2Mi4tyfIyxxk/ingkS4m05v717dyUnXnpvRYKSpqLtDXAZAr5pdw==
X-Received: by 2002:a05:6512:1317:b0:52c:d628:c77c with SMTP id 2adb3069b0e04-52efb7ae1b9mr7395973e87.43.1721722879089;
        Tue, 23 Jul 2024 01:21:19 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:45ae:72d0:1982:e034])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm24026266b.112.2024.07.23.01.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:21:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v6 5/6] check-whitespace: detect if no base_commit is provided
Date: Tue, 23 Jul 2024 10:21:10 +0200
Message-ID: <20240723082111.874382-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723082111.874382-1-karthik.188@gmail.com>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'check-whitespace' CI script exits gracefully if no base commit is
provided or if an invalid revision is provided. This is not good because
if a particular CI provides an incorrect base_commit, it would fail
successfully.

This is exactly the case with the GitLab CI. The CI is using the
"$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" variable to get the base commit
SHA, but variable is only defined for _merged_ pipelines. So it is empty
for regular pipelines [1]. This should've failed the check-whitespace
job.

Let's fallback to 'CI_MERGE_REQUEST_DIFF_BASE_SHA' if
"CI_MERGE_REQUEST_TARGET_BRANCH_SHA" isn't available in GitLab CI,
similar to the previous commit. Let's also add a check for incorrect
base_commit in the 'check-whitespace.sh' script. While here, fix a small
typo too.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .gitlab-ci.yml         |  7 ++++++-
 ci/check-whitespace.sh | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2886f6e182..2589098eff 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -118,8 +118,13 @@ check-whitespace:
   image: ubuntu:latest
   before_script:
     - ./ci/install-dependencies.sh
+  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
+  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
+  # be defined in all pipelines.
   script:
-    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+    - |
+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
+      ./ci/check-whitespace.sh "$R"
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
index db399097a5..c40804394c 100755
--- a/ci/check-whitespace.sh
+++ b/ci/check-whitespace.sh
@@ -9,7 +9,7 @@ baseCommit=$1
 outputFile=$2
 url=$3
 
-if test "$#" -ne 1 && test "$#" -ne 3
+if test "$#" -ne 1 && test "$#" -ne 3 || test -z "$1"
 then
 	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
 	exit 1
@@ -21,6 +21,12 @@ commitText=
 commitTextmd=
 goodParent=
 
+if ! git rev-parse --quiet --verify "${baseCommit}"
+then
+    echo "Invalid <BASE_COMMIT> '${baseCommit}'"
+    exit 1
+fi
+
 while read dash sha etc
 do
 	case "${dash}" in
@@ -67,7 +73,7 @@ then
 		goodParent=${baseCommit: 0:7}
 	fi
 
-	echo "A whitespace issue was found in onen of more of the commits."
+	echo "A whitespace issue was found in one or more of the commits."
 	echo "Run the following command to resolve whitespace issues:"
 	echo "git rebase --whitespace=fix ${goodParent}"
 
-- 
2.45.2

