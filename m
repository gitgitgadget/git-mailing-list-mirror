Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CF1581EF
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757000; cv=none; b=ptlH+r3fWwLfUtt167CFhQ9rSjsCd75xvDpp4deBDZrK8JbKDe6lGWWSELG3cZI6UXFr6YfZuT92YNVInq5zGu2E+q+3lo7BSmiqRqiavz+URQDTmT4pFkGQzkQ8MlbdY7WQQ1mj4atHokAv9bwVL3tP3sDCqA9EIGjh5oXV9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757000; c=relaxed/simple;
	bh=X3c3dB6GrxwCDFFkJUxTJuwutdMW82AgfcOYHt+NSxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvQZmryrrDPUC3vTaXm6IfklVa1htZB+gsbDjec2dypLkEPqy61RK4hcsmrW84AzYdU4vcsfLPzVt158mC27aw1H8qOT/KoFnDRkdMgcy+1ulFUUjCKVWkH8alDsx+k5y9TPpAuH59n2syH0DrKQjYz0ZD9NTnD//W2vdNiAdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ2ma+UN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ2ma+UN"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee3231d95eso1607968a34.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756997; x=1715361797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaYZanCcN/0A5sR/5ZDpxGmHTlj4CGs8Xv0hH4TfpMQ=;
        b=jZ2ma+UNhfrrjGpRuzomcZstC8UO1ID3i7jFmmHMvUZm87pwP6bXVN38BBsp5gI2Qu
         jG840gAShRMfYKAxnwgkzlHEqljm/VmPrQfvDaWcBVsiPnfOV+9jxVEZb11UAdH6/Qd2
         obeKhPrAkiB7h9G0+gJHEqmAmHwmLPEFAeWKqYu208Mm+K/ioJxrB4l2qrqG/SNp7izR
         f3/vs2Bgi4MgxF6Z1c8pfYbj3nYEZSbE9dknFjSl5zEl5yOXxUUac3Ku0usIEfHpKQ6X
         eLM8kJR82puqViydfc6jOAQGQ5T6+8dEtXAf5yonBjVTfPDBpinX2ZHI+eDjJRiKUtdr
         7SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756997; x=1715361797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaYZanCcN/0A5sR/5ZDpxGmHTlj4CGs8Xv0hH4TfpMQ=;
        b=e5vbp64PNLQ9aultcSdtKlJBndyTMF4zn6c3qI/4PxD1mYe/pZtyA/szfpKrZjH+/B
         JxvMNqoua/sNNiEz1DuM+k1alTCKSbS0MZ3cn1uHaq8vD1s6oHzbRwVrVlsxMzgrmyKr
         jI+AljXUZW9wMcbeCbDatEXYdugLYlVo0wYBOtLvoI1gZwItoyakOxWfarrVVIIXYLiw
         asGwxQDLMGZB9zsMdbXe1WAWK2NoTvY+Er7bBF5DVOU6NDCoX0EyuGpDcfHhnLEfLXDx
         qqxusMG7HAEGojo4UyNSqVX4J+gQMJFheAV6y+QxYbHFxIb2WwUrOIm4QPUgFdU36mDD
         6TsQ==
X-Gm-Message-State: AOJu0YxcOKAeSzVZ96XjVEsoKO07cw+ohAHvt2+8W65KZvHApHkHOqP+
	CACC2FzNKxuD/kPanPX7BR/MIO2YbJlhS7be3P+4+Xv/uSegolMx8yh8bYOx
X-Google-Smtp-Source: AGHT+IE7E99QuWnd7KgVmpUWNRU84Ta6am2SzehpsYZ5WHMFucp/N0RMYhTBNwzJX6OdWXAxa2Pc7Q==
X-Received: by 2002:a9d:7d98:0:b0:6ee:2741:d1b0 with SMTP id j24-20020a9d7d98000000b006ee2741d1b0mr1395184otn.0.1714756997650;
        Fri, 03 May 2024 10:23:17 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm705212otb.65.2024.05.03.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:23:17 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/5] ci: separate whitespace check script
Date: Fri,  3 May 2024 12:21:05 -0500
Message-ID: <20240503172110.181326-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503172110.181326-1-jltobler@gmail.com>
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
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
index 0000000000..9cc496da40
--- /dev/null
+++ b/ci/check-whitespace.sh
@@ -0,0 +1,74 @@
+#!/usr/bin/env bash
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

