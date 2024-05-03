Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00995158865
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757001; cv=none; b=onOkLgFhIDXePGm5Ne6ZimZes1NcJb8ZmrVejYyRKzh7qTQI1YCMO2WleHouJsft1kFzxWFhi3z00qyM9jEmtArMfw3W3rUdYJBDt3kuaaaUSCyLJI90BmHzKxGXFqEOba2i8mJUi/y9FPvE2WqxvTF5WQ37fs3q1ET1psNPzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757001; c=relaxed/simple;
	bh=XDdWxTKd+UMMDl+BreB28KsbvnKhxUAO8xphMvT6aSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXRYfNRW8PdzWcAoj6r6CSBtaZoesMf6HhkQh1QDukViH7joK6ddRnq4iA11cy3NgmmvVrVDxt1DmkuqJL3BbGYMShUBPlXyLpXl9Mwu94ZnYq7MAwdwJ1q4cKzX2upXye2J0uh1CaadBmRnr0GlEEtq082qYF2IvqMwwkhz0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5INiKv8; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5INiKv8"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23dd94111cfso1078784fac.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756999; x=1715361799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF7fDwS9X2wTNKNZGlOinf4i33Kfaf/XEL7Tt0bmcL4=;
        b=G5INiKv8EwLtIKCYBiD2UWScUEZKji6z+IhBIKFLSlQN5VgrB2ioWX7JdDHCvRgVdQ
         5TWhhbugmRLQ++2eZ7Lugt5+8S1ZqE+U0CRq8kuEL/IIi2kdIL7kIJV9H2KVSbfnzlU/
         98tp65Qe8n8IkMm/msAkerWuM1UKA4onktEHun8sqPIoG2b3Zi84Bmt8USr564SfY5EK
         OkZvaXaMsArOEOVp1vgdSzXHkkrMHMxpNbNet/sAche0gnt1fuSknfUv+rdcesnAIzvQ
         k4wn/XSBTbQkixRejdnYTsl6V2gsAxUyKYd+NFqjcqyhdYu7hewQ3efapDKUY6V5Fo0m
         qA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756999; x=1715361799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BF7fDwS9X2wTNKNZGlOinf4i33Kfaf/XEL7Tt0bmcL4=;
        b=QGnid7oBqJVrLJmMY9ysfhIBWQ1xlDlAMdv+HcYeRY/JSnN2SCB5xQ1vtrS+RYxONa
         2d7gve0QwztjRdf+9CARlb0gbElBEUe9CfXfzMJC94ScUN5kvFNrFX5R5VSmBH0Np3Fs
         A8Eh3AVXh53b30i1NZg3bY8JatRsCCm5qzfELHOCRXsKDnEeHcTM0qU6owXVrnJCl+lj
         xfOhswTKGCfpHDYiRURA65+XdQOZOezRp3IWD9Awn1uWFP8oaenNK0rJG6lPJm9VoJgI
         wrMWid2nZ4PY3BLC2Q3hGcWH1Y91OMMcWHP4emaBhFRg3TyLMdQ0fD2Kd8SyC6B6pUMd
         Qjcw==
X-Gm-Message-State: AOJu0Yx2kuJ8rxjr1gFoMgYrCaKqwmIIPOMMvwEjULGexSDmD5eDgSWQ
	S3rCFjelyDBCh4OrnE3LhRmkVrR6FwTqO02+NueaxUKtVZiao7CpKWd4iQ==
X-Google-Smtp-Source: AGHT+IHa/5M4OLDkPQAGheBQfncqDL6XEexhh44tZaULeuKl0lisLI6Fja0dreDwvXN8T34qdrovGg==
X-Received: by 2002:a05:6871:a58d:b0:23c:6c62:9cd6 with SMTP id wd13-20020a056871a58d00b0023c6c629cd6mr3644368oab.23.1714756998689;
        Fri, 03 May 2024 10:23:18 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm705212otb.65.2024.05.03.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:23:18 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/5] ci: make the whitespace report optional
Date: Fri,  3 May 2024 12:21:06 -0500
Message-ID: <20240503172110.181326-5-jltobler@gmail.com>
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

The `check-whitespace` CI job generates a formatted output file
containing whitespace error information. As not all CI providers support
rendering a formatted summary, make its generation optional.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ci/check-whitespace.sh | 45 +++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
index 9cc496da40..db399097a5 100755
--- a/ci/check-whitespace.sh
+++ b/ci/check-whitespace.sh
@@ -1,9 +1,20 @@
 #!/usr/bin/env bash
+#
+# Check that commits after a specified point do not contain new or modified
+# lines with whitespace errors. An optional formatted summary can be generated
+# by providing an output file path and url as additional arguments.
+#
 
 baseCommit=$1
 outputFile=$2
 url=$3
 
+if test "$#" -ne 1 && test "$#" -ne 3
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
+	# If target output file is provided, write formatted output.
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

