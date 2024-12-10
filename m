Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E820214210
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856344; cv=none; b=mG0qtfkDX+hJcHu8xH0nnJ0tkbSKkhjBiL54Cao4MMYec8bajrqClZlnfS0Z3m+KGdIxGGaJdBxIDVFGbyslWfVcwsl2xWw7wc6GYUat9njscavGNDScJs6n/QS9jMgl5yyKZUyhwK1DDMByBanKooGCaFCLTya3cGmRK9+y4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856344; c=relaxed/simple;
	bh=V/I7Dvl/5Zke3ph+/P0X+edNcPqmV/qQwgUZEFlBvnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cH/AWVwnINNmqkMu4E+/ulqfzIEqve8gkspXa0WPc6aPh0eK7u5idtoEd9FPKLwZCwhoCRSRffZZrTGHiEMcbs+HnAqFdm4nxj2n/AUvhCSGKAMFNy3CxQ9RjslQZG9BSf6cXIuAZEFwGT6pn80J0ExXSNll/N3Im8oGFhKEjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbjSQHyW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbjSQHyW"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0bf4ec53fso989866a12.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856341; x=1734461141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBbMUzMWawmcW2jowGRZQ6BZLgaxctDNOZUijJGP71g=;
        b=jbjSQHyWb0UQykp8b4o2OdiSdkCxd24CO/yo9jg5g5/vqL0SPWICBulT48FvEvzrxJ
         nn11nfEP0KOoZvOrpoM2A6miHgsKTDFmW5V+qRbkr3/I1xxsYFv7VyNtlM8Od0jfcvCg
         7hrEb8k/KSpPlZ5sB/2ltw0aawq7Mdev8NFFg/dqqZPcQIeQUBEiO43twby/B5ccUCQi
         Fbf8I1ugo7QKUu+7dK301wyzaQy9HlePEB8rNwg9jYUPx4GOKYCUG5b0oLBegO/B7hlg
         QJpDxkxr9i/onegRReggknJVOBtkN8iiZ206FP+6vK1+r0tNHn0cRIQpwrJKgsz2pUFr
         4bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856341; x=1734461141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBbMUzMWawmcW2jowGRZQ6BZLgaxctDNOZUijJGP71g=;
        b=ixf8JiEMcgnVng5jYJIpDvigTrXO83kfUb/Mwz3jbm9duzZmAo/Rx25Gm5Vd6DGwoN
         heMrAnSSwMKHp3sf/f4AqspIKxiPQaAWNUQPQ+g8M5NQTb1Cch4AVPqReQ4BgRv/e2wl
         9TdYI8VTltPHBtyU6VAkpUQcDn3N3OKCYY4F2ynaauhgx7wgr9f513vaiH4ZOZcVFPXh
         F7rbrX7X8A276DtmLXLz28uhD8iLP49g0q3MItwJSFIuPIOfxni7Q6GsttxwNZIhJOFZ
         svFsl5GTNGjD0gctLdJqk7t88CPt5icLnY+tqTeTfuz29vFNkybJSW1yI29uwyYiV2B5
         f5Xg==
X-Gm-Message-State: AOJu0Yxnzx0VtUFZXjQPsickE6c7fcs9UmKKJh0IB2Q3i5KR4HC7hA6b
	9bydOdqMUvWSx36TeMyb1KTNJRfbX+Lv79t1NfmyAA71BvsQE+0Ng43LzSx3
X-Gm-Gg: ASbGncvG+gUTl3WJHKn5KAoUi384oNgrxLRcYUzHHv1OWOdd9h/ioFrTEak3QHccZG0
	uL5fpxzsKmF1nqryaXZ689ojux5TUs8/hcLBcRNZqa9WTVNjodJACQgHDscgyPaa4VaE7RMkm/9
	wjsMyzUkPuEKuwUXhDf2PFa+evcN6pZb54Qmv+eySUsQZzi0fmLlrdwSV0IsX3cwUpdprdbFE7a
	rzSvWn8P+NtfTpTRtWYyw6EmP74CWKBJlkNRYOH0JnLf1T01sZd+HrRz6audNY=
X-Google-Smtp-Source: AGHT+IEc0g0IcJPdj1/2VL8qowSUougwjjXsaHfy0mpqfqMzfSsYD4NFtlg+i0JKvK9MAfOV5rmPGQ==
X-Received: by 2002:a05:6402:348f:b0:5d0:bb73:4947 with SMTP id 4fb4d7f45d1cf-5d41c3255a5mr1846421a12.0.1733856340497;
        Tue, 10 Dec 2024 10:45:40 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48882sm7895896a12.24.2024.12.10.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:45:40 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v3 3/7] git-submodule.sh: get rid of isnumber
Date: Tue, 10 Dec 2024 20:44:38 +0200
Message-Id: <20241210184442.10723-4-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241210184442.10723-1-royeldar0@gmail.com>
References: <20241209165009.40653-1-royeldar0@gmail.com>
 <20241210184442.10723-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's entirely unnecessary to check whether the argument given to an
option (i.e. --summary-limit) is valid in the shell wrapper, since it's
already done when parsing the various options in git-submodule--helper.

Remove this check from the script; this both improves consistency
throughout the script, and the error message shown to the user in case
some invalid non-numeric argument was passed to "--summary-limit" is
more informative as well.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index fd54cb8fa6..3adaa8d9a3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -53,11 +53,6 @@ jobs=
 recommend_shallow=
 filter=
 
-isnumber()
-{
-	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
-}
-
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
@@ -524,17 +519,15 @@ cmd_summary() {
 			for_status="$1"
 			;;
 		-n|--summary-limit)
+			case "$2" in '') usage ;; esac
 			summary_limit="$2"
-			isnumber "$summary_limit" || usage
 			shift
 			;;
 		-n*)
 			summary_limit="${1#-n}"
-			isnumber "$summary_limit" || usage
 			;;
 		--summary-limit=*)
 			summary_limit="${1#--summary-limit=}"
-			isnumber "$summary_limit" || usage
 			;;
 		--)
 			shift
@@ -554,7 +547,7 @@ cmd_summary() {
 		${files:+--files} \
 		${cached:+--cached} \
 		${for_status:+--for-status} \
-		${summary_limit:+-n $summary_limit} \
+		${summary_limit:+-n "$summary_limit"} \
 		-- \
 		"$@"
 }
-- 
2.30.2

