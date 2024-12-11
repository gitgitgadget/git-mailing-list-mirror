Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DD1C4A34
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898831; cv=none; b=gnw0OG86lu6ezzxVJEqrsA7LFRtl/unL58qeIXeC91cJIjSierPXuzij5V/XgGs9H2zKY2EZ/mOgsq0pIgSLQ+qfikXzRkiUUEqs+IPXHfRf+F0w8DhMGyPjIHV90xBBDAOm82ldT2k9AxsQzfysphL0VqP2yfTgN7vPypkAAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898831; c=relaxed/simple;
	bh=V/I7Dvl/5Zke3ph+/P0X+edNcPqmV/qQwgUZEFlBvnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4TVWykcLJh5lM2dO72UIdsJZjFZE+Wpc1nanEmyDknmOrhrnrzPZnzTQkjLeHTsjBYbD6ygGQcsAsAJgh7uymcQyRwDh7kJVLKPa65+6wvq1yDqaI1HoX4QLp6zJ6yFpKjEdNntVh5Fsy4G4K5DGMsLs0GzMLIWdARuX6WfQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSXkojl2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSXkojl2"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3cd821c60so517567a12.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898827; x=1734503627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBbMUzMWawmcW2jowGRZQ6BZLgaxctDNOZUijJGP71g=;
        b=mSXkojl2r7vGAywiLR2rlnP055PXSzGtyM4wsZ3Qd30XVIxjN3JSor9Kn7ZVyLIQ5u
         Y89sMTLIHHbJwA3Xm0cu6GkPAlrkqD5ugARt6gt8kj58himurRmTDfJYTA5z35GFNsMf
         sFs1aoVQ/o5t2fUTjU5IhI+iaB8mhly8B6EsE4FGK3zXg/TxptUam5jrkl+9CQZMOJLj
         3WKjujVRx6ZyBUALkeSc57AYrStc/LobcIkQF/YmKnkem7qmAlzqI9yUF6CEUKWJacx6
         9vzLDWo4CirYIwSlRjI+yLsS7nFmZSGT69hc1+R7US4u0igP5w+ls4HVnZTotpB42Dro
         CJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898827; x=1734503627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBbMUzMWawmcW2jowGRZQ6BZLgaxctDNOZUijJGP71g=;
        b=QuFwK4O/UBDAoDUea2w2ffQv7Q6xODkNiE4PrNA32LEWaajshmQ7SzRBmtL0mz+Gwj
         ggNlp9XMGSr9nJEK4uQOl3Q4plpRxIkF5S7ALgH6+Dg8AM1fBnZIbPuouB9Io2W7sThJ
         Y8xemtkFtBRHj07z8vxzLzWAlv7tMkaiPpGm/00e5+wEFXF+bLNF8yzqw4o5JtJDtBYk
         bT6QJcoX6ED1e39NhxquEY1MZrLJiZ0te9DhoTwAN76ilENwGT6YzWDVhDr9lEMikG3u
         yZY1H2KOhlAe4tYcva3QZVlFvaFBFcWpdiK5ahpB0HNpaZZlh4LnRkGUHDFYyhmDuvI0
         GAGw==
X-Gm-Message-State: AOJu0YxcVRPnX22PK+4SeHKWiCp3l0GHT1wdu/ykOk2OqX8TW23ORHPT
	NyCz8ktaNnq6QlDhXPfdcP5tJSUkaaOlx20QznwsuCUNFM6vFnUN1UEGE2GJ
X-Gm-Gg: ASbGnctStxpTV7PVb3nk5IKPWj9433nCckwkgs1q/7+3bWv0VrbwLpb2fMHKAqvn0Id
	yUCC7TstshXn4Y3oGFBpXOuC0BEXI9yxFW6acfwvAumB8KlIEDzkjNAYUDJiHlxcLdQJbEydPfR
	wuMKHBft2Re7VWvQF1p9PYPVb9OVk8h0mVhs+Ky1DBjXhASSiDbQSgU9F3FjpaXYcSGHCMJ95Ub
	b9ULPMuV2rt9SPbzBl+Ktl6hPd/xxb0WQshyr8JCJZtYSjwn610cgXBrQjf4xA=
X-Google-Smtp-Source: AGHT+IH8zdYPcPWQgFwV0RNekgasPFKjiZVp0T9ZL46oFCeJu1KlOz3zLuc2BcmZItaZNhfB2R3xuA==
X-Received: by 2002:a05:6402:5193:b0:5d0:bf79:e925 with SMTP id 4fb4d7f45d1cf-5d43314d34cmr465991a12.6.1733898826634;
        Tue, 10 Dec 2024 22:33:46 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:45 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 3/7] git-submodule.sh: get rid of isnumber
Date: Wed, 11 Dec 2024 08:32:30 +0200
Message-Id: <20241211063234.7610-4-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241211063234.7610-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
 <20241211063234.7610-1-royeldar0@gmail.com>
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

