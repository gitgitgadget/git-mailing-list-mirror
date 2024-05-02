Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF121802D7
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678883; cv=none; b=nJb7NMuK1AlkUIYglgJb/z5x7sK+1JTaqrj06WtMChEGhusBdgil5gn7xFoyx3qb4AQucwIKAb7JbUZg0j+cXeLAbJagw7TdL4wTlR1MKClTvsqU0bIbzi3slNkj9GUdhI5BXgwvJwC69Pt/69PPvm/No5CbNaJOG2xW/5FNQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678883; c=relaxed/simple;
	bh=u/ob5vAmGBDDAIau2u+gbxsA79iK8gerioBTjSPyivM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9mR9FCUZNLb84ceKlFrXb18lhYNUevmA1/vxWgV9vJaYcFSNvM/hXjMD5Fra0lmhj6qAoR0DlCCYbhF05hMgKmxxbxNHWBY9F0/XHoD/70eVrR0t2OFkBG89wTPN4J9E7+85ShMbRqTp2Cl53RbnHgUNk29WfEAPRZmhomSjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj5/CHOg; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj5/CHOg"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23d38cd0df6so1645390fac.2
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678881; x=1715283681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKYoPQITMQuAedN0mdur/i0P7Uf2CERjQNG1Fx0WYJg=;
        b=Aj5/CHOgpA5LqO03kTLZIbnAi6Lhi+xHyGauonNoNG7gxIvR/mD5A9/SG1dgv91uLC
         6ker67296J+DB1+vWPQBuE/25+BtXvbwocLmR90jmUK47g3pCnzKdh7LSaXKdr/0eFyN
         ShqxlTBIXkWTCMYDd6TFIi5C/x+sEzWgiBKrfvYljmSnCn2M48AqFi3txVtXp+EtRPoj
         6ZNCLOeSR/n6oklNFf6T2z/S5UZCkwCSWv8UBdojHcl5zJU1/yc1xbr+uC7oEmyMk8S5
         2CZYm1B7b2l0fY1Zom+tj2pmo/RIO0cHHW48SWDgDtkCZ4kXWqcLEoq6Fwfj6qanizCM
         1WwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678881; x=1715283681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKYoPQITMQuAedN0mdur/i0P7Uf2CERjQNG1Fx0WYJg=;
        b=aJXYVBE1Gh5EiRTqed/4HmNqMmVlzcbT20LoPpCLqosS1DZ3ixRx1pZJl9q5xMRjGV
         454gOTbJDRyzH/iz582+pYFEz8m/eH3PZSbTFrMYcbig+t2WVtbHG8O/RWk5NV5KDv5W
         5r/guBbiuLhJh/XY+kXHaw0ZRHczb8d2KLBPKYHTLkoqD/fggHne+o0gAEYnpRkDYzZd
         bZJPOL7wlbtE54fqBHyS1aZnmDLAWo8F/CmhqLgXQjD8c8vN7GFLRA6bABt+81W1BDpe
         DL6paQMiDkrrTpXYkF471P3POKiM8Wl/jVgMARonQeFlnRpvUHUJkHhAAE2UFMztQmwf
         k4EA==
X-Gm-Message-State: AOJu0YyW/8vQYYvw2aRtJfS3T6stQ7Nq4fEMyblSq7XUsPcJS1Z3T5PS
	848enEQWDb3vUq9W4up1e7tORO02qZfVcl1g4xtrjnnbWP/KbMmFjJgY7w==
X-Google-Smtp-Source: AGHT+IHW7PGtEewr4GOhuxeeHRMlGQIEE/ccsN5j+UqcMUgoMQu1X1ocY+QWbNrhymmj+I+hF5gZsw==
X-Received: by 2002:a05:6871:b1a1:b0:22e:bc50:3492 with SMTP id an33-20020a056871b1a100b0022ebc503492mr760771oac.47.1714678880899;
        Thu, 02 May 2024 12:41:20 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id uj12-20020a0568714e4c00b002390714e903sm297443oab.3.2024.05.02.12.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:41:20 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/5] ci: separate whitespace check script
Date: Thu,  2 May 2024 14:38:37 -0500
Message-ID: <20240502193840.105355-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502193840.105355-1-jltobler@gmail.com>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `check-whitespace` CI job is only available as a GitHub action. To
help enable this job with other CI providers, first separate the logic
performing the whitespace check into its own script. In subsequent
commits, this script is further generalized allowing its reuse.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .github/workflows/check-whitespace.yml | 68 ++---------------------
 ci/check-whitespace.sh                 | 74 ++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 64 deletions(-)
 create mode 100755 ci/check-whitespace.sh

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index a3a6913ecc..d0a78fc426 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -26,67 +26,7 @@ jobs:
     - name: git log --check
       id: check_out
       run: |
-        baseSha=${{github.event.pull_request.base.sha}}
-        problems=()
-        commit=
-        commitText=
-        commitTextmd=
-        goodParent=
-        while read dash sha etc
-        do
-          case "${dash}" in
-          "---") # Line contains commit information.
-            if test -z "${goodParent}"
-            then
-              # Assume the commit has no whitespace errors until detected otherwise.
-              goodParent=${sha}
-            fi
-            commit="${sha}"
-            commitText="${sha} ${etc}"
-            commitTextmd="[${sha}](https://github.com/${{ github.repository }}/commit/${sha}) ${etc}"
-            ;;
-          "")
-            ;;
-          *) # Line contains whitespace error information for current commit.
-            if test -n "${goodParent}"
-            then
-              problems+=("1) --- ${commitTextmd}")
-              echo ""
-              echo "--- ${commitText}"
-              goodParent=
-            fi
-            case "${dash}" in
-            *:[1-9]*:) # contains file and line number information
-              dashend=${dash#*:}
-              problems+=("[${dash}](https://github.com/${{ github.repository }}/blob/${commit}/${dash%%:*}#L${dashend%:}) ${sha} ${etc}")
-              ;;
-            *)
-              problems+=("\`${dash} ${sha} ${etc}\`")
-              ;;
-            esac
-            echo "${dash} ${sha} ${etc}"
-            ;;
-          esac
-        done <<< $(git log --check --pretty=format:"---% h% s" ${baseSha}..)
-
-        if test ${#problems[*]} -gt 0
-        then
-          if test -z "${goodParent}"
-          then
-            goodParent=${baseSha: 0:7}
-          fi
-          echo "🛑 Please review the Summary output for further information."
-          echo "### :x: A whitespace issue was found in one or more of the commits." >$GITHUB_STEP_SUMMARY
-          echo "" >>$GITHUB_STEP_SUMMARY
-          echo "Run these commands to correct the problem:" >>$GITHUB_STEP_SUMMARY
-          echo "1. \`git rebase --whitespace=fix ${goodParent}\`" >>$GITHUB_STEP_SUMMARY
-          echo "1. \`git push --force\`" >>$GITHUB_STEP_SUMMARY
-          echo " " >>$GITHUB_STEP_SUMMARY
-          echo "Errors:" >>$GITHUB_STEP_SUMMARY
-          for i in "${problems[@]}"
-          do
-            echo "${i}" >>$GITHUB_STEP_SUMMARY
-          done
-
-          exit 2
-        fi
+        ./ci/check-whitespace.sh \
+          "${{github.event.pull_request.base.sha}}" \
+          "$GITHUB_STEP_SUMMARY" \
+          "https://github.com/${{github.repository}}"
diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
new file mode 100755
index 0000000000..f57d1ff5f0
--- /dev/null
+++ b/ci/check-whitespace.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+
+baseCommit=$1
+outputFile=$2
+url=$3
+
+problems=()
+commit=
+commitText=
+commitTextmd=
+goodParent=
+
+while read dash sha etc
+do
+	case "${dash}" in
+	"---") # Line contains commit information.
+		if test -z "${goodParent}"
+		then
+			# Assume the commit has no whitespace errors until detected otherwise.
+			goodParent=${sha}
+		fi
+
+		commit="${sha}"
+		commitText="${sha} ${etc}"
+		commitTextmd="[${sha}](${url}/commit/${sha}) ${etc}"
+		;;
+	"")
+		;;
+	*) # Line contains whitespace error information for current commit.
+		if test -n "${goodParent}"
+		then
+			problems+=("1) --- ${commitTextmd}")
+			echo ""
+			echo "--- ${commitText}"
+			goodParent=
+		fi
+
+		case "${dash}" in
+		*:[1-9]*:) # contains file and line number information
+			dashend=${dash#*:}
+			problems+=("[${dash}](${url}/blob/${commit}/${dash%%:*}#L${dashend%:}) ${sha} ${etc}")
+			;;
+		*)
+			problems+=("\`${dash} ${sha} ${etc}\`")
+			;;
+		esac
+		echo "${dash} ${sha} ${etc}"
+		;;
+	esac
+done <<< "$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)"
+
+if test ${#problems[*]} -gt 0
+then
+	if test -z "${goodParent}"
+	then
+		goodParent=${baseCommit: 0:7}
+	fi
+
+	echo "🛑 Please review the Summary output for further information."
+	echo "### :x: A whitespace issue was found in one or more of the commits." >"$outputFile"
+	echo "" >>"$outputFile"
+	echo "Run these commands to correct the problem:" >>"$outputFile"
+	echo "1. \`git rebase --whitespace=fix ${goodParent}\`" >>"$outputFile"
+	echo "1. \`git push --force\`" >>"$outputFile"
+	echo " " >>"$outputFile"
+	echo "Errors:" >>"$outputFile"
+
+	for i in "${problems[@]}"
+	do
+		echo "${i}" >>"$outputFile"
+	done
+
+	exit 2
+fi
-- 
2.45.0

