Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725217BB05
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678893; cv=none; b=V9Ow8Vr9F3Lyt6UtIBE2OO4WqJZjb3DJkFldVQqX0e93F/hUUAJu5l9Ac+Y8uxwg63pDatu3SMRjaPcYrEjPUwyG79tprp2XPLDwdem3gca9xOoDAI1+WLACfzQ9YRSHRuM7glXhLibZMBFXzKZHivbiD5YF79ok3AUtqUrWR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678893; c=relaxed/simple;
	bh=00ONgb0PdtNkah5eUs0S5XOSGpq02u9tIBydTsx1ZZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuQtT2C0/O9v2JyXxS9l2CYp2/mWKV2zxLTnK9ROJp7xNc+7Md4AerJ9P6liPM7PamBFJfut/kSWSzuYP8fcxBnTjrlU6mle6ePHx161SziDJ+BVJ9GsYAxCXCgHu7E6UAfAuwR6LdWt3W2itFxSMjNOxqdXTYoUuvQPP9R7Ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAFpeNvK; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAFpeNvK"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c74ff209f6so5214531b6e.0
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678890; x=1715283690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JORxWVaH9n29n/i0ToVsIZ3I8GSYHYXwX4tEe0AMiU=;
        b=DAFpeNvK7g0c0nbm6Hn9vdtI4Tlw1a1tRqXfSKSe7xk9MFQq2kmSgPaQN3e5T85vp0
         ApkX2fo8x9wdXfN+ze2ZGBXmWO0ITm4I6owM5fkyv9H3vx2ZqDymGzdiZw+JwqQxQDpp
         uN90KmEqVw9Ii9HwYBU+VGUtTDqjlFqPoQK+ztrckKJt6dUxiGttJpK0PFCYIDH8A4Pb
         m5JHJoc++Z7nRH7qt4ljBSEnBbrQjNhaqhRhFtQqGjAD+/s7Gr2Pk/IQFblN37h+pnbb
         4awFzn2c8bsmp945lyV+yKrYIxjCYhY0w6+OpX38C+Q/zdZhnbKGh9EgIMq/wz8caAPN
         59eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678890; x=1715283690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JORxWVaH9n29n/i0ToVsIZ3I8GSYHYXwX4tEe0AMiU=;
        b=pTZnvSrx4wuB2LkCxr5ATLF9SYW+YTMREKZYMS0APHRn0pZMVItOV5ghf790Tg/JUH
         x/H6awv3/wPl+yUahtqgVkrGQ3/i03QOC9bt15Q6Me/FKDxBpvalaKvk4ckbs4SanZIy
         gEUc2Nh89A0yQe1JCtobhDShZCM0mTsRd3YwlJ3rudgtia0kvanX/NZ+ph2oIoLIwUsN
         qz6hRQt1dZTwCSGEakw3tkb+j4EsgrX+dayUgEkkXnVckI2RZ1XAG6AnG+O3N7oWBnrp
         PNdZPpnPoPfZqeuY5d2wlOjzsptOaES32PTc/vcWdwyTDI+AWJ4qEPv3bUYpyXugEx+d
         XpnQ==
X-Gm-Message-State: AOJu0Yxv8jdeJSKZFQ31vQuJhp0cPrlilG8XZ0ul6HR5aG5Q0use5cZA
	JhbWZO/Pc+Gt8f4JY4M8UKiOI938vhqNW2QVdfSj3XMQXQM0ITf2AtouNg==
X-Google-Smtp-Source: AGHT+IFrL5I6WzkfnhG26I6ho095DhJKP20MvFEBqOe+Vw5x7tsYywvi65gbh3W0kdcs03N8TGk/BA==
X-Received: by 2002:a05:6871:69f:b0:22e:c860:9a6a with SMTP id l31-20020a056871069f00b0022ec8609a6amr1071753oao.49.1714678889782;
        Thu, 02 May 2024 12:41:29 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id uj12-20020a0568714e4c00b002390714e903sm297443oab.3.2024.05.02.12.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:41:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/5] ci: make the whitespace report optional
Date: Thu,  2 May 2024 14:38:38 -0500
Message-ID: <20240502193840.105355-5-jltobler@gmail.com>
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

The `check-whitespace` CI job generates a formatted output file
containing whitespace error information. As not all CI providers support
rendering a formatted summary, make its generation optional.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ci/check-whitespace.sh | 45 +++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
index f57d1ff5f0..fabd6ecde5 100755
--- a/ci/check-whitespace.sh
+++ b/ci/check-whitespace.sh
@@ -1,9 +1,20 @@
 #!/bin/bash
+#
+# Check that commits after a specified point do not contain new or modified
+# lines with whitespace errors. An optional formatted summary can be generated
+# by providing an output file path and url as additional arguments.
+#
 
 baseCommit=$1
 outputFile=$2
 url=$3
 
+if test "$#" -eq 0 || test "$#" -gt 3
+then
+	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
+	exit 1
+fi
+
 problems=()
 commit=
 commitText=
@@ -56,19 +67,29 @@ then
 		goodParent=${baseCommit: 0:7}
 	fi
 
-	echo "🛑 Please review the Summary output for further information."
-	echo "### :x: A whitespace issue was found in one or more of the commits." >"$outputFile"
-	echo "" >>"$outputFile"
-	echo "Run these commands to correct the problem:" >>"$outputFile"
-	echo "1. \`git rebase --whitespace=fix ${goodParent}\`" >>"$outputFile"
-	echo "1. \`git push --force\`" >>"$outputFile"
-	echo " " >>"$outputFile"
-	echo "Errors:" >>"$outputFile"
+	echo "A whitespace issue was found in onen of more of the commits."
+	echo "Run the following command to resolve whitespace issues:"
+	echo "git rebase --whitespace=fix ${goodParent}"
+
+	# If target output file is provided, write formatted ouput.
+	if test -n "$outputFile"
+	then
+		echo "🛑 Please review the Summary output for further information."
+		(
+			echo "### :x: A whitespace issue was found in one or more of the commits."
+			echo ""
+			echo "Run these commands to correct the problem:"
+			echo "1. \`git rebase --whitespace=fix ${goodParent}\`"
+			echo "1. \`git push --force\`"
+			echo ""
+			echo "Errors:"
 
-	for i in "${problems[@]}"
-	do
-		echo "${i}" >>"$outputFile"
-	done
+			for i in "${problems[@]}"
+			do
+				echo "${i}"
+			done
+		) >"$outputFile"
+	fi
 
 	exit 2
 fi
-- 
2.45.0

