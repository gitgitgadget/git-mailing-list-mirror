Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BD4949E0
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816804; cv=none; b=XN8VMUMhk4tkHqq5/nOP1pXDgruy8MWIUOc8ePJYtv85LRUWc/c6MJ8U8nimh0eyVA9sa9jHaEffgo+7kDfGZQ9qR8Lvlklf5juUVv88bBaqRBY323saMO6B8mgKXSytZroo0EZiAqQKDOAviM684FFH0t7VlUmm3oQuE8F8aEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816804; c=relaxed/simple;
	bh=6XpRiLRNwIX+45YBxvamTEwKKgWnd4E8O9wmlGpB1ro=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WSqMR86bR+S+4Km2kq4mEpgHw6xVPSOGauLquqgtfdHXMYT+tSuPt58PYr0IiMPZHs2QRasuzd23ocwERdf0kXDlaE22aEaqECaXn94VyjGLWfvPIS2rXav4y5fbPngc8ELvsvOg1nXXd1oBATgYFqGSj9ctVdTevzt0T6lirvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRcE950+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRcE950+"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b834592afso9483076d6.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816801; x=1792421601; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nFq++2NM8JbapLvlaGQyopnE9hUDUHbljSElOFoTlTI=;
        b=XRcE950+9mPCc2PIwcJc6oJxp5UcbiQ/VpOjgdTMUfH/GJ6uq37WJ551XIycvD+LAk
         LMK1NRrJGiAIzZQYTtrvKMZ9JMiC77RTyEwse2E2dTYvICo18XD2KZeiVYE9RPxV0Sef
         ES89LbzLMJ46VFCJcibQwOwpY2xqf5j005DBGtHCyNrS9+dGWQzLSTK3NrqSdR9syNCU
         oOaUkwJd30iDiQoFC0SriasmTareUHcBkYmb/Bmb1DrRHK8lG/XyhQX+xefOYWka4+Lg
         4lLTPAAhQAv75kk//frXkGfgvTmXUKZbhK20ZzWHwqIFRArShcbXicp4o83/M+oLL7lK
         7miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816801; x=1792421601;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFq++2NM8JbapLvlaGQyopnE9hUDUHbljSElOFoTlTI=;
        b=km1lo19kO5iAJdSKAjpFv5LsrmEB8Bp25Rioiu05QRtf/b1jy8wkZ/wQgUT0v2VIpT
         O45gsksfDGoxSsiHum8foekJFhJrhrFGpKHmdFJMoL7r02k8v4K1RMmw4uaQnuqkSNo2
         UNkkxGSy5eUSrF9fCcD/165LuWJEHne3tU/zLSVQ+3MXzQqOL4ksi0X8bpC1cPntMOqy
         0N2lQqWQ1MHDFwjWEUDSlKlVfYD6JnW7FMLSGJGi6ckM9u3uHAXlddy6guofk+/mIgMl
         jr7fqEfWUXzn1Cvl/D0xMF4RD63oDgJ9lV+CX8y0Yjv67sffW3WxKVQnOt3ID1TtMNE6
         MaVg==
X-Gm-Message-State: AFq9FYKXZuLzw3/k0/rB7tlL9CeP8cEMxwfTjsavv8imbT/bL8Jk3bFx
	deugt0/FjEUJBUOTIjX9Pw1sjZu/9GriOULzrheGokPtsfRUuYo6QuEHUNLEWXD7
X-Gm-Gg: AYBFou1XwJ+nQGyJOOOapnWDn22si7LG7J9ROGMKHsTP5eKpOG8yslMK/n4MnyuZsVT
	cIzedFZtGcirMqRHb48z9mx/GahToraokCcuF12XIyw4OV1X5jJ3DIKKEZdPUWGfO2J8KH6ivZE
	6254QtfGprD6txTUkEe0Z3aFldro9bZZyMpy7All1c2XJ3BO2qWOdZnB1kFxAMDz7bOGORRTZRp
	kDUJKC+6pZmrlGXFGz9357FP/lu69qwJksxP3mvUmugvy9h7UpAAyg6ddwtyeURhh/Ucz08ZZfn
	EQH5BbzqwimaQX+uRm65cNEFSZgUBfFd6yKotXfBKqMX6msD7AIclRe1npBqh0eInyMCpeheZQV
	aOGn648okLXrDkwcg1eq9nyAosAawo8sAiwHYcy1385ZbmBU2X35K2Skj1W8psFxec+o/tbSeGG
	wwEOUNMjIYYa4tZ6mFWRSqKZemQdWWYtDkUWrXh6HCDfGVqGnd3FvoTbh6MgDOmN3segIv8ju/
X-Received: by 2002:ad4:4ea9:0:b0:91b:8457:7930 with SMTP id 6a1803df08f44-91b84579477mr42993636d6.19.1791816801485;
        Mon, 12 Oct 2026 07:53:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.84.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b95fdf385sm1612276d6.12.2026.10.12.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:53:20 -0700 (PDT)
Message-Id: <f99c99f955a101d1aa8c55c0689e3c1230e3d303.1791816795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:53:14 +0000
Subject: [PATCH v3 5/6] doc: git-cherry-pick: link to new merge conflicts
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
 Documentation/git-cherry-pick.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index f4cd8b9db7..069e434961 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -19,8 +19,7 @@ Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
 working tree to be clean (no modifications from the HEAD commit).
 
-When it is not obvious how to apply a change, the following
-happens:
+When a merge conflict happens:
 
 1. The current branch and `HEAD` pointer stay at the last commit
    successfully made.
@@ -36,8 +35,8 @@ happens:
    conflict markers `<<<<<<<` and `>>>>>>>`.
 5. No other modifications are made.
 
-See linkgit:git-merge[1] for some hints on resolving such
-conflicts.
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a guide to handling merge conflicts.
 
 OPTIONS
 -------
@@ -259,6 +258,7 @@ $ git cherry-pick -Xpatience topic^  <4>
 SEE ALSO
 --------
 linkgit:git-revert[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

