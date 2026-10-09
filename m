Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10864E2F2F
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547241; cv=none; b=bq96Q9XLEoo1pNDOmFBUy+Dtr+NiMZzRH6MXSCCItJYteHrMEKQtis0Fz4dRM7gkeTMXwpDoVMkyYHWVSi1fTrrw+Dm/wSipS6WaNSRBU2sJc9PXS2g2cgoTZa78DY0Ung0MldZjCTBK0ngpIdvo8BxqWLJuQZjf0Ww+lgJlm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547241; c=relaxed/simple;
	bh=RfYww5kE8p0W8gHoDK7ByBtndV9V7t3sz2LFsXPDU7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bx9Pi3Cbal6fSDK+BfRf1LxQ3fAUrDs91gbjc+d1dlv084xDIl/597l2aE5DGXXhbO0RYzfECzzKx5xVGRfi2AY9QsmuLiYFIjV5exJPPP7c7nXKjfjAl1flo88A1xadNMlhCY2MBnIdKiMlFJjNXcrFl1EHP3xzhLoYukwEqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL555093; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL555093"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4af173320f9so3522397b6e.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547232; x=1792152032; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r5UOp2ql122VPqc1DGvlaSTlLYjPFW8uRMuGDyRlj2Y=;
        b=kL5550937lTLQnjy2iiN+kIjahRp6VAd+N1JBDrf4d/zPA+ODksPteX1lt9qEN+oJl
         igzRlhydcshiAXqkU84g4ZzcoAiVuic2NB3gB0rjz4QEhrcZVmUMCW+4dt5ZngNhh5qa
         QJ5sXCuy8e7qKFZYm7E/9Yeyjolj+q6f18H4h3dAzWn6iRS83Z6jTBCWiLAciPvEeGsA
         Cnl4JM4to5PqvsXo79SY20m/Dm+DEdjRiSDQ9XPgDcvL03d4oItvw5cDnskz2MCboqe1
         KaZm5AwowiJXLGGANTvjO2ugjBjnORXBlhqVA4/eXkCxa1NFP3KQhkNn1gPD0W/hKB+n
         hwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547232; x=1792152032;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5UOp2ql122VPqc1DGvlaSTlLYjPFW8uRMuGDyRlj2Y=;
        b=paPbKB/owwNdPud2ZveQvcVj7GKSxez+4W+WFl2agu6bVPGgPOCvodwFPXbRXAP9O/
         IDdiyDIXy0qPE6sZmyl0Bvbz2n7m598zUfVukpEPI6xrghumn4ykWM9h+uCfOJ8k3m+O
         zXZlnA9ZQkD5PRKRsjzLDtC7Gk4/VlIKb5Z9vGtzHm93PeclnQ/b0IJ516CecAkoQuA2
         KJH8bUyxyoRDlVSy7mLUioN/puodfsuKKxkl2jX+o4T4RhpCraNqNufpAXxfG7kifoFp
         /9ycb/xUaf0xBH5mkE7doqVtlPI8xR641WZn3NS0emOGQNFAEe4N80K7HAZLVD8/9cyp
         C1jg==
X-Gm-Message-State: AFuF++nMv2m7wCy55Lq/IclXO6lZg27Kl4eMMhwsMPoyH8clgqRz64uB
	6DphwVOwit4YcRNSYVFS2hKiaWYThD6HSGGia7RfvMAcKwIp6dgXHqGyo5lgDg==
X-Gm-Gg: AYBFou0fhDl3k+tZ9ToekmI7DKCIW4CK99YOAtpy2LWZX3Qi1topgI5YyxXSjmvnUbu
	omZ6sGwsEZaoypeibWcDF5a38S1EA2I7eUDl41k1iq3fEhoBazUTwbOs8uJW4a4PwgC/ct7wdH2
	mqKq6y2KXiKseHX192CuzOu2b8SSs0sMby95iHMhy66cVVcJtWdsiE16CMz9L4JGMBSBq8/WOlB
	C5+g6Ai1TNr6o1uLqWypf0B9bnVIR++GW1lwhSp+tjCe+HGnJORe94iBLT6zFcTlB3S6L7B3tCy
	IM+CJrShyZgLe056JosKa53R+faHOi0h+O/H+GyIcipFGC78JO1GyIUtnk9qSXKCTsydw4x9WcI
	YmUnADjckjDNVwB726jFxeyLP9MmCO/MYsuPgCAfWmL8NwEYnxqWUNsa7duWdkcI+7u4wBsGKbk
	KdaD3qZe2n7+Ldmu+GwcTRh3r2pxd/gGPleQjsHNgZSZKUlAu9qJgQOx7+jXjSWoITlGCpeaEbo
	DU=
X-Received: by 2002:a05:6808:2206:b0:4c4:c7cc:f8ee with SMTP id 5614622812f47-50c4e681abamr1251299b6e.13.1791547232397;
        Fri, 09 Oct 2026 05:00:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.148])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c17d84e77sm1677058b6e.7.2026.10.09.05.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:00:31 -0700 (PDT)
Message-Id: <62b70e9a02dfc9c5b5c980b71bb0507fa20cc0b9.1791547213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:00:12 +0000
Subject: [PATCH v2 5/6] doc: git-cherry-pick: link to new merge conflicts
 guide
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove the discussion of merge conflicts and replace it with a link to
the guide.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-cherry-pick.adoc | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index f4cd8b9db7..1834167287 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -19,8 +19,11 @@ Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
 working tree to be clean (no modifications from the HEAD commit).
 
-When it is not obvious how to apply a change, the following
-happens:
+When it is not obvious how to apply a change, there may
+be a merge conflict. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
+
+When a merge conflict happens:
 
 1. The current branch and `HEAD` pointer stay at the last commit
    successfully made.
@@ -36,9 +39,6 @@ happens:
    conflict markers `<<<<<<<` and `>>>>>>>`.
 5. No other modifications are made.
 
-See linkgit:git-merge[1] for some hints on resolving such
-conflicts.
-
 OPTIONS
 -------
 <commit>...::
@@ -259,6 +259,7 @@ $ git cherry-pick -Xpatience topic^  <4>
 SEE ALSO
 --------
 linkgit:git-revert[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

