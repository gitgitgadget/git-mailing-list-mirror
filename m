Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FD248F73
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480090; cv=none; b=UNa5/LifB4dSXURgp6OOl36nJOkb/cCcXkBHkJE/n4mspRjbhPvfTp5ij4+zxYK/JEnJGdrJwuJ1uwGU0Bt2uicYPUmYrd36ZB0VrbhAf+0KdXpCl6FGZt6x0rB4hWdJtdZS7dpqINoiOnFkUdMexgl8CbF3oHwedwpnoDQqPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480090; c=relaxed/simple;
	bh=UMUlwBxYRMIB18QhP3lQ/CE6j5luh52LkXIw0aJRg64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGUsjhJ6ydPI/yKBaaHqun8C0pIBI2jejCO5Ofbo9OfzZNrDMRFl511vQJrfYdNminaZqIKBVN3EByzrpeKnN2HGyzGp8q1KLbCZPzOMGczDkqcExIvph/rfqH8+a+QsiWMPFn8svibIEexHEaW1z6ibD46Lu2t0fhe5tQehhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGW3xJKq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGW3xJKq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0f3f74587so5849955ad.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768480088; x=1769084888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNhKVgrw3UCab+1NYsIntqMUqFhJ5weJA1b7pgpsHK8=;
        b=UGW3xJKqNyaf+iwO1R5lS9PCg+DC6hhXCllQyEe0GghIDekefVbJPZy+FTq3Q0O9V8
         7hO3PJZ/2BvjmmJ7hWGdV5V+0R5w1YJqR12F9ORYmh/32ulcQOqgbNlHHb5WI/Vdw7lU
         16QagRzRZNqimEF/Wmfy2Y9aQXXLVVrA5GFH04ZtT1m5dkl2TOe3QVXj4RjuikkoGSGd
         7ZPcdYo+wWIMkVEdYWA4KhleJQgO0JfwCjOTM+3KLkPgbNsVFlP664GehwTBE8J1sO30
         ZIgq1Smq/1ZJxDuESm9AKoroUwJI5P7DH4wesNio4xFkirMUDvxndBPYfAikY+0YKXh7
         6p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480088; x=1769084888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNhKVgrw3UCab+1NYsIntqMUqFhJ5weJA1b7pgpsHK8=;
        b=wpIVA+chORm4eKTpUJnfNDo2HiF+m3XZFVK0UxJ9eG3pIO+1Cuj75Vex/UKgXdfvZ1
         uiIE29IkvvVI34bIE8uvzWOIHU3lEB20M86oeD1Tix9bZc89XvlYOV/9gChAcbHt8rAO
         nCxdBbFz47q4vShrc+exCjIZSzYJYL54Czc7zWegMxb7KFp1OSTnyfhY5qmNTtmffzIR
         xTx1Hk/BmrooPulPq9Mp55AehNkSmaBrw6EGFkq0mAQ6RFm6VfS/aC/XcuGLA3OFphMm
         t97AHka7aLDQ4AqtDQAPEB5rWZLhOgVPDuOvieYczeerrsQ8Avt/ItzBiSV6wXnlnaOr
         rJDw==
X-Gm-Message-State: AOJu0Ywz/Nj3v6ibt4gmruSK5GnOL9CnOPtZLeOoE5PAxZqT8oUVldog
	PFjxhIqQzVoeu0uuXTXVpNW3/2coieWVLeA4qfL+pBbZ3n3S+bM1k+tUsne0TA==
X-Gm-Gg: AY/fxX49eABiJLq2nvIb423Zwc8cPxTCE46P7o+l7bW88oSTlMW6w+eI8qIgTtwl0sN
	B+CNd14yZh7H4DIG2hjCgDFjfn87MEl15iK1VQzsk4feaWBJJ4VKGYh2ivu3i1wXeHrvWwqbKCi
	ArzIzAkk3DJaLgWc83UEW9WpvqybjubW0CrVgDSJ4vPVfMS3M3Pdf6Wwjcy0Ib1gf/58j/rH3sO
	9n8bcYga58NbZ9nQNPtErc7TjKh4RG7M7IK8tqqL0Os+EPOLv8kQ1CsbqPnL+gP5JkjY0s5Sx2T
	NZAFXLUyZnTxnGVyUwaZLTvfO9QHxiRl5c3ABV3GHE3sSqUoAOilqJdeDhv4Zi6lyz1eYc8TGWO
	rwFVIPOvsDodxAcrCGfD8kJsqCtagnsOEmm0mHIfXnpczDHIpjkA+swDkngV81gr84syogj6Z2y
	n+eo/ujbZYpgAy96ibOKwybEFf4Ib4wHXF
X-Received: by 2002:a17:903:1aa8:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a599dd5b1fmr59893105ad.26.1768480088212;
        Thu, 15 Jan 2026 04:28:08 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2e1bsm254707155ad.60.2026.01.15.04.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:28:07 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v2] subtree: validate --prefix against commit in split
Date: Thu, 15 Jan 2026 12:24:35 +0000
Message-ID: <20260115122652.18673-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115120936.18491-1-pushkarkumarsingh1970@gmail.com>
References: <20260115120936.18491-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git subtree split currently validates --prefix against the working tree.
This breaks when splitting an older commit or when the working tree does
not contain the subtree, even though the commit does.

For example:

  git subtree split --prefix=pkg <commit>

fails if pkg was removed later, even though it exists in <commit>.

Fix this by validating the prefix against the specified commit using
git ls-tree instead of the working tree.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 contrib/subtree/git-subtree.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..a5822b66d5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -257,6 +257,9 @@ main () {
 		test -e "$arg_prefix" &&
 			die "fatal: prefix '$arg_prefix' already exists."
 		;;
+	split)
+        # checked later against the commit, not the working tree
+        ;;
 	*)
 		test -e "$arg_prefix" ||
 			die "fatal: '$arg_prefix' does not exist; use 'git subtree add'"
@@ -966,6 +969,12 @@ cmd_split () {
 	else
 		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
 	fi
+
+	# Now validate prefix against the commit, not the working tree
+	if ! git ls-tree -d "$rev" -- "$dir" >/dev/null
+	then
+		die "fatal: '$dir' does not exist in commit $rev"
+	fi
 	repository=""
 	if test "$#" = 2
 	then
-- 
2.43.0

