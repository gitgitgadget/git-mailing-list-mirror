Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75321256B
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850984; cv=none; b=meNDP6d0j0cVkQS0FLg6jeQRP5fcZIni1K6TalSZy6YiMQfJzNeMRR/WkjqeC+Ddco+njjp9evcxp7zySmge/xgOy3gtqWbBB4E28Pe+fC2rKIuL70mQYcjUcqEcuu8bP64ZtYVa/3E/+zf0FCBlscKqJv85pHAE5T3zSgBC33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850984; c=relaxed/simple;
	bh=gnokO4I1l0J2P7NhObxtrlsBDdErOU2RXyKdsg6Ybgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe1/8FxROnaEj9gSsLLo0+gLKk5Q504lIeX+GJvQYvxWaTZL3dEh3VOngQFvf6SgezOiaOkMnlT62aYVrDE1cBMaP/KbvFM00ZBKaolDyh0PEg0SYZo/FuluQWr/8T9B0V6ofcrAPL77RP5UvrXRybPCQ5j4jZ0DuDXoMpBT/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sxft0J8z; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxft0J8z"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2461864f7f8so12068645ad.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755850982; x=1756455782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfArscDV86tdNAQeK76d1K6LVL7eobsjqgHQjwd0oQ4=;
        b=Sxft0J8zsgWL/gcQ54x7fO0FktifYHdQIIdc6CogHPay3pUL9558ru1CQX6f/i5Ipa
         Vz005TuKOixhGzbdfq3YIgF9cFv9kiXH8gMno405OfL33nkUTLv9P85VsTCOmTPB5por
         3nD2jPvCbXWYFn6XlXmxJUrhePFu1vykdxXBpJCnz3FxRfEeU1FEptcpJmub2UnUuNn6
         7NWzncZsuaEi1Q+ixxP5iw+QD00yLB4wNz0oKewwcpjbEEtAv3Hm5Kd5MHEA03aw/aGu
         lOCAPfYfLArh3UR6OZQeKZhIiCy8cXuKQ5dIKXat8Jrcdhd5hpeDvoCCzvhb0ND7ORS0
         XpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850982; x=1756455782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfArscDV86tdNAQeK76d1K6LVL7eobsjqgHQjwd0oQ4=;
        b=j5ONAw5n63sTWgMxQdTf7j4PdcsU2Gmui3GmA/hftlvU+wZGzU21FMPH5Yf3izCX4N
         MkC437a5I5GWS5TorSpzGjBt4CRf7f/2p7ajRoQjlQZirXsjIbmNP/reVKHyK6n1BUTA
         swqGA2jjiS1iW8PFOFBa9I86CZlgWIgxwxAj+3dFwDo97prUn0l1o5q/dUDpoZBE7Yzq
         HsdWKSVD73CBv9vSlsM7TRftkghX7jocDN8gQYqpyt+4ak0Z9RX/rnwIORCkYAcYT2Lv
         Q/ttTro5IoDLuubf7uPCTIQl7yREhMblS7pOXv614YJVitteMItRRYg+6I0YJiCaHLQb
         TwfA==
X-Gm-Message-State: AOJu0YyclZ+BpnNeG+UrfmO2MAGL7OQpk3CFJhOVw56DYebkMC5biq3N
	xlIUmZhqHj5OKd4mNk7mvfB4sYu2ZYhza0zubRxIDCOkjhXVI6irmQJBL9ZPNydb
X-Gm-Gg: ASbGncsHDU4lxe1G+1k/b37PldJBjPOT+liijdcprCdDYVUGNieaqf/Dtwxo74umznD
	LC1/6Fh9TN4eo+kUZbbL7b/GFj52j+cUpjnEoXJYPCvCulbWGy0doAy71j+bjA/si3VFaVDnVul
	9yVgRBsvqh5k4lQVzpPxGpW3qLVgyQ0kYdJ4ivxluvvcQ1frfoXbG9KUv0W9X/J+Y7tt4sOJBKy
	XiR9n0AtOiRrlKFlQwLxdI3bAOFIfrJuMjhG9DKgS/lnBJTqjw5vof4d9QuzpvNb7qW9LF0zy/k
	+4MPGxh8rt8yjoIOSGoUmwfmA1+Iz8UWgFkKFkljiS2/JSEC4UaMw8fUvoEJiRBEqxY61pwvoOr
	iOprK74PDQOHUb3RohuBskIcm9cPlH8viFg==
X-Google-Smtp-Source: AGHT+IFeeaq4djOc0LVP1tEL46pnS9vSqsJFVF14s17bGrjPS3ohedaM/aXzFfLr4ltn1Sqo+EX9mA==
X-Received: by 2002:a17:902:ef01:b0:240:8ec:fe2 with SMTP id d9443c01a7336-2462ee0bcb8mr30633925ad.4.1755850981584;
        Fri, 22 Aug 2025 01:23:01 -0700 (PDT)
Received: from ayush-sharma.. ([103.196.213.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c749fsm76547925ad.91.2025.08.22.01.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:23:01 -0700 (PDT)
From: monarch <ayusharmagsoccontri@gmail.com>
X-Google-Original-From: monarch <ayushoffinfo17@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Start 2.52 cycle, the first batch
Date: Fri, 22 Aug 2025 13:52:49 +0530
Message-ID: <20250822082249.93127-2-ayushoffinfo17@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822082249.93127-1-ayushoffinfo17@gmail.com>
References: <20250822082249.93127-1-ayushoffinfo17@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.52.0.adoc | 58 ++++++++++++++++++++++++++++++
 GIT-VERSION-GEN                    |  2 +-
 RelNotes                           |  2 +-
 3 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/RelNotes/2.52.0.adoc

diff --git a/Documentation/RelNotes/2.52.0.adoc b/Documentation/RelNotes/2.52.0.adoc
new file mode 100644
index 0000000000..1919e039bd
--- /dev/null
+++ b/Documentation/RelNotes/2.52.0.adoc
@@ -0,0 +1,58 @@
+Git v2.52 Release Notes
+=======================
+
+UI, Workflows & Features
+------------------------
+
+
+Performance, Internal Implementation, Development Support etc.
+--------------------------------------------------------------
+
+ * string_list_split*() family of functions have been extended to
+   simplify common use cases.
+
+ * Arrays of strbuf is often a wrong data structure to use, and
+   strbuf_split*() family of functions that create them often have
+   better alternatives.  Update several code paths and replace
+   strbuf_split*().
+
+ * Revision traversal limited with pathspec, like "git log dir/*",
+   used to ignore changed-paths Bloom filter when the pathspec
+   contained wildcards; now they take advantage of the filter when
+   they can.
+
+Fixes since v2.51
+-----------------
+
+Unless otherwise noted, all the changes in 2.51.X maintenance track,
+including security updates, are included in this release.
+
+ * During interactive rebase, using 'drop' on a merge commit lead to
+   an error, which was incorrect.
+   (merge 4d491ade8f js/rebase-i-allow-drop-on-a-merge later to maint).
+
+ * "git refs migrate" to migrate the reflog entries from a refs
+   backend to another had a handful of bugs squashed.
+   (merge 465eff81de ps/reflog-migrate-fixes later to maint).
+
+ * "git remote rename origin upstream" failed to move origin/HEAD to
+   upstream/HEAD when origin/HEAD is unborn and performed other
+   renames extremely inefficiently, which has been corrected.
+   (merge 16c4fa26b9 ps/remote-rename-fix later to maint).
+
+ * "git describe" has been optimized by using better data structure.
+   (merge 08bb69d70f rs/describe-with-prio-queue later to maint).
+
+ * "git push" had a code path that led to BUG() but it should have
+   been a die(), as it is a response to a usual but invalid end-user
+   action to attempt pushing an object that does not exist.
+   (merge dfbfc2221b dl/push-missing-object-error later to maint).
+
+ * Various bugs about rename handling in "ort" merge strategy have
+   been fixed.
+   (merge f6ecb603ff en/ort-rename-fixes later to maint).
+
+ * Other code cleanup, docfix, build fix, etc.
+   (merge 823d537fa7 kh/doc-git-log-markup-fix later to maint).
+   (merge cf7efa4f33 rj/t6137-cygwin-fix later to maint).
+   (merge 529a60a885 ua/t1517-short-help-tests later to maint).
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 64cbc58335..b16db85e77 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-DEF_VER=v2.51.0
+DEF_VER=v2.51.GIT
 
 LF='
 '
diff --git a/RelNotes b/RelNotes
index 48f15770a4..6d16c0077a 120000
--- a/RelNotes
+++ b/RelNotes
@@ -1 +1 @@
-Documentation/RelNotes/2.51.0.adoc
\ No newline at end of file
+Documentation/RelNotes/2.52.0.adoc
\ No newline at end of file
-- 
2.43.0

