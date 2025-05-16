Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF872601
	for <git@vger.kernel.org>; Fri, 16 May 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403757; cv=none; b=UtESfI8Gi10u8ajOgDnJTYMb4YiI7sLiHs73X9oGvMku59dC7ySTqpwClPewiyqpymvXNHjjp/N/esBPDR1ON6aKNj6wH5xHYfStDcgkHx5Tzv6h/RWQTVHN25c0FCkT3nRI8jgRFGwut6+2hiLm91X9JYBVLo9vrvwZbE7syjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403757; c=relaxed/simple;
	bh=0RVHW0lQB50SA+mSpi5ZRiCieRJz+0KBu5Fes9lQwDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWFo5CHQMJWIG7tADDFNc5RuYrkVSBBA/h0G6Cx27gRJCy6lcHXMCZVXrf5/hdokEy+EaC/H6g7xErudTYvAjsZDvMP1D/VrMiaFDajwWpn6xatLCsHKdBk4MMIs3Q1JBQoNcNydE6K55JT6w8L2nYsyq9IjLrXYDdkLAyxtpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLuuK4Je; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLuuK4Je"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442fda876a6so7954375e9.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747403753; x=1748008553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUzN7t0yFhOfNHSElXvU8SOFCA+WqxAFvF4FwITa4HQ=;
        b=HLuuK4JeWivHRRnpWVCa6s0KlS+d8Ul6QxmEPSkBBAe4U38Z52Tp+nDKgLB1qrPqm6
         0T3iJq4hpQwKH+aGItOBFnyyH1p859zMyUnXQo9aEeUEFpK5WFK5EtaBeU7hRYcxT8pj
         OHWAqqo+WmNAGTtyJyoUWXp9j0wve2Mx1qm0UtkxOqVaMAbBjaXaQhyC2VPW1u58inZL
         9nX9VxJx0Pmi+rSwMGQQV5QZf4TeeH7eQQbW6nkBoqOKOto7bnjp55PCi1MNUJUkvPz1
         0FrKax4a7Akv+U0VG+EElpx63AEayV3YPyDYXCzs9E/yNkZLNvc34VfKd7bbpc+xEubo
         MA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747403753; x=1748008553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUzN7t0yFhOfNHSElXvU8SOFCA+WqxAFvF4FwITa4HQ=;
        b=JvEJadrG0hZjuesmiqThGmPPyJVc5xpxtYiZWmFr3JkoJR+TNpf8/9tp/Dc8aK6qhn
         UAYOvd0mT26XzujgcZcDerdNUb765iN+Lhi0QyfvkHYEo4rAwDChvs0yktFn6hyz617i
         ccRuV3INO2b7ROSRcHZxcbkc8mBRCaggcDNMq4PUIl++1kAPv0ySahBNTnqK57NdKgoq
         ILhGPPcXzlKeI8BENrgLujNCTX1HuPNBZj+MLOwVrbr90pzcYZf0zz0sXqww1trEK98X
         6W7YhozZ8NiY8G/59RnDmnvdJl0rL43qFhDwWRxlUnvM6W6V9yJIRdulGJUW5u68ZOxQ
         ZIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8QYEApC77l1A6j3U5Za1bo7r6ZWuLLM/XOkmGje7ot+4nVqShBgOAk+0GvFgAwj8nIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlX75Lgo0JLxLpt24CNgBoczA/JgNcozLE3dIILnBv/OkfKfW
	Lpgo6Qi2CzAsM7ZUMrcqKB++5jYUVjzTFAA6/KFkbdAU3dMJcikw6h+5
X-Gm-Gg: ASbGnctNFedrDQ5ERkkK0sbbyT3Le3UgZVluyjtEo8eNYhsOu/GN/y0OUTH7NB1izh5
	1ys9v6Bni3GDhDrJkwwKG0BVCEFdpHf8uY/SA2MPdBoTbLzxRLZsTgxPBf9u9ErO+sGv0RemAPS
	l33sj9jTo17R/6WGDclcYct/ZZQEZSgdGtcQ4E+AmD8623xDYv9sDOwv2xb0WSNRl/r23MAR5J1
	PkQbdIUhLNspCR4W6f/CoAnalgBAHsL86as7XHMkK7h/dSPRAYP8/CeLsQL2r2RPtRikxtKPuFB
	hJdEEE6l2T6DljCvWeJAzq9o1SE90oqmcVm+Ept1Xv8HeJFeDrCOIwl01cj1MmaIYDI=
X-Google-Smtp-Source: AGHT+IECQEifXLrBtKutPRApdqg6PLHzd6W84vjDkdkwRyd/zOc+25otb62o7gG/DMaNW20Z7pYxAA==
X-Received: by 2002:a05:600c:3e0d:b0:442:dc6f:4a07 with SMTP id 5b1f17b1804b1-442fd60873bmr37999725e9.4.1747403753179;
        Fri, 16 May 2025 06:55:53 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44300160fd0sm20812055e9.4.2025.05.16.06.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 06:55:52 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: phillip.wood123@gmail.com
Cc: collin.funk1@gmail.com,
	git@matthieu-moy.fr,
	git@vger.kernel.org,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	sunshine@sunshineco.com,
	tmz@pobox.com
Subject: [PATCH v2] contrib: update thunderbird-patch-inline
Date: Fri, 16 May 2025 14:53:55 +0100
Message-ID: <20250516135540.218937-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
References: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This script uses an extension to run an external editor from
thunderbird that is no-longer maintained. Replace it with a different
extension that is maintained[1]. The new extension uses a different
separator between the mail headers and message body so update the
script to accommodate that.

Signed-Off-By: Phillip Wood <phillip.wood@dunelm.org.uk>

[1] https://github.com/Frederick888/external-editor-revived
---
Changes since V1:

  - removed the original definition of SEP (thanks to Junio for
    pointing that out)

contrib/thunderbird-patch-inline/README  | 10 +++++-----
 contrib/thunderbird-patch-inline/appp.sh | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/README b/contrib/thunderbird-patch-inline/README
index 000147bbe4a..aa00b379a60 100644
--- a/contrib/thunderbird-patch-inline/README
+++ b/contrib/thunderbird-patch-inline/README
@@ -1,6 +1,6 @@
-appp.sh is a script that is supposed to be used together with ExternalEditor
-for Mozilla Thunderbird. It will let you include patches inline in e-mails
-in an easy way.
+appp.sh is a script that is supposed to be used together with
+ExternalEditorRevived for Mozilla Thunderbird. It will let you include
+patches inline in e-mails in an easy way.
 
 Usage:
 - Generate the patch with git format-patch.
@@ -14,7 +14,7 @@ will be moved to the section between the --- and the diffstat.
 
 All S-O-B:s and Cc:s in the patch will be added to the CC list.
 
-To set it up, just install External Editor and tell it to use appp.sh as the
-editor.
+To set it up, just install External Editor Revived and tell it to use
+appp.sh as the editor.
 
 Zenity is a required dependency.
diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index fdcc9483520..c4dd88024bd 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -1,14 +1,15 @@
 #!/bin/sh
 # Copyright 2008 Lukas Sandström <luksan@gmail.com>
 #
-# AppendPatch - A script to be used together with ExternalEditor
+# AppendPatch - A script to be used together with ExternalEditorRevived
 # for Mozilla Thunderbird to properly include patches inline in e-mails.
 
-# ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
+# ExternalEditorRevived extension can be installed using the Add-ons
+# manager in thunderbird, the source is available at
+# https://github.com/Frederick888/external-editor-revived
 
 CONFFILE=~/.appprc
 
-SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
 if [ -e "$CONFFILE" ] ; then
 	LAST_DIR=$(grep -m 1 "^LAST_DIR=" "${CONFFILE}"|sed -e 's/^LAST_DIR=//')
 	cd "${LAST_DIR}"
@@ -25,8 +26,12 @@ fi
 
 cd - > /dev/null
 
+# The headers are separated from the message body by a blanks
+# line. However the message uses CR LF line ending so on platforms
+# where the native line ending is LF we see a line with a single CR.
+SEP="$(printf '^\r\\{0,1\\}$')"
 SUBJECT=$(sed -n -e '/^Subject: /p' "${PATCH}")
-HEADERS=$(sed -e '/^'"${SEP}"'$/,$d' $1)
+HEADERS=$(sed -e "/${SEP}/"',$d' $1)
 BODY=$(sed -e "1,/${SEP}/d" $1)
 CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
 DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
@@ -37,7 +42,7 @@ CCS=$(printf '%s\n%s\n' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp
 echo "$SUBJECT" > $1
 echo "Cc: $CCS" >> $1
 echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
-echo "$SEP" >> $1
+echo >> $1
 
 echo "$CMT_MSG" >> $1
 echo "---" >> $1
-- 
2.49.0.897.gfad3eb7d210

