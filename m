Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BA39EF12
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186651; cv=none; b=D6uA+2dqXrHq5VEO5QrgMwn8Oq5OZ0FAZniYeQHwXz5DXNvROUBZaE5k9Ra4LxPupihICUhcGF/4YqJyg7bXEhVkaQBHZ3qW6AIj6SzMucvJsYgf0CsG/c7PJ48EATmGE1dLkC6Bi1TOwV94w+z0fVjDPSYi46C1Dmzws8m+wNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186651; c=relaxed/simple;
	bh=hgMZJZT5L6w4MYBgKFo1s4m5nxdztedSQDwRG3wRwrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA7y5AGpTtSEredB04aZ+3hkmXL+gW+Rn65j916GSnXKXv4W5UiJNsXdVCCCCS9ED2QagGc5Mi6+ZAvZtNGGFRm4olY/nRxB1N25b+VffyF1E0spXz7er3Pv4zkfnm28NUpDPWT8e3a7IIK69ieRR9Bs8GGNH4+MbhgCzBT7mGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asDo+Esw; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asDo+Esw"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-825b40f8a26so111067a34.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792186649; x=1792791449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
        b=asDo+EswhLAbbhOmWTiKK8U2h6t7i+ZYAA3llhK+rWgXmeWCR4w2uewy6s0ecwKMzN
         gWJkc7GnUu3zi/6PpNZCWRyOYrPg/TrsOXJ/sS4vj7bFR/1NhoAojRMRZAnEo7SvJ4SP
         Ok9e5oCXfTMvv+IQ6MhlVauBjCj+1EcTcLnK/ldFSOpnjDJ/PBrLqlCT5kodTOoDH5zX
         Sq0WHdc4PByYlWirwGMo27HyWmT6NtJSWXfAhFr6fvEONqhuwoVI40g+5Il2DgHcqgjl
         ZeieW3n8z6BTa8Jrq5WmLJpig+FX6kqwMlr/eWY+F3wIsYAv1+4cIf07cl9tSgofnFA2
         Hr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186649; x=1792791449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
        b=scPCtpzZA1C9lHmXU2clDZSwRuim6m65Dxx3AvGYpc6AGranAkyVRrYpNvwUAiYlCE
         4E785kG4xc4nLW/dqSB9L6e3FyiddaSOSLxNcAaiR8D0mHXQzdfzsQ/90Y8oyqDCrnPR
         T45He2owPQ7+Cxn/Kj1Dzek9PhCU0h5/NHrDgRKSbLr0PXhLkCBpQJeg2BrfIPQxT4Kg
         S1cFNRdBYMroJMteuMePgwzuDqT+dPGT28JarwKAUtc67sUSHBVqA6QeZS9J8bYpGEF8
         XMsraG+d1pQkOWPyPWqjIBCqPyVAAzzlbO/ESj/nEeOQvdVZYDFKYiG4IjH4PA+uChnn
         BdlA==
X-Gm-Message-State: AFq9FYIvhn5mE05C1khqoCRwu/+mYk16Gs3ncjez094AQBT54PXM1vw1
	50yV2W+FOyJVEolUNTLeGHYBYX/G2VSZY/VjsMcjaaYL/5w7VVPmzPUiklyutg==
X-Gm-Gg: AYBFou389Fxiv02zITGysY51esc/5Uq3di+GKAihSg5kn3HVWLvLe/QUTDqEOSHQ1kH
	v0woa8iGrBtkx2C3kXjt7ORH5XZksQJwYeTUI2bMzwCX07M+HVO3HvJLxFXMsMslWz6kxDQ3FWe
	SNoBjmQwDZsDBHXiirRCTW3lC4EJwaob9JBPk7h5CQMlYpnDb6mMUdhQ7IRUefysL3SDSkbU2kw
	zV8PBsR+5OCr8p6ywwKhsENsBEXO03T5nDnXXuGl1kXBd/7FYN0L2O0+UwriWvbidG65C3TeV1q
	09QZnHq/ix178SD3aWq6JtP9ltGSN76uypeuHL7UIRcYArfIjtTnOSwVje3KPtz7o/VeWTzvYYL
	g9699i8riMs9twAJ82EM4saDPSfVTDOCgK7NmVl2jvL9CrnoYLgj0KeMqjo/Vc1iiho1vQS72UF
	t91id6GVfbLF6Qu2E6H7bagTdULvQLQSHx5Bvly2qnk0V0Fy0kqXnfUiDXYq/WUJ9VmTt3PHbCP
	8HJizI4GTmtJL5VE4HTp0DLCF0SogTc/9We5w==
X-Received: by 2002:a05:6830:2643:b0:81b:9d18:75c with SMTP id 46e09a7af769-844ffcdc21emr770964a34.20.1792186648832;
        Fri, 16 Oct 2026 14:37:28 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-844d2ffbf71sm834395a34.4.2026.10.16.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:37:28 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/4] pack-write: make index-pack output comment hash agnostic
Date: Fri, 16 Oct 2026 16:37:13 -0500
Message-ID: <20261016213716.593278-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261016213716.593278-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016213716.593278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code comment in `index_pack_lockfile()` explains the expected format
of output from git-index-pack(1). As written it explicitly mentions
SHA1, but both the git-index-pack(1) output and the parsing are not
specific to SHA1 and also support SHA256.

Update the comment explanation to be hash agnostic accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 pack-write.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 85674e4b72..b1311c9923 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -476,11 +476,15 @@ char *index_pack_lockfile(struct odb_source *source, int ip_out,
 	const int len = source->odb->repo->hash_algo->hexsz + 6;
 
 	/*
-	 * The first thing we expect from index-pack's output
-	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
-	 * %40s is the newly created pack SHA1 name.  In the "keep"
-	 * case, we need it to remove the corresponding .keep file
-	 * later on.  If we don't get that then tough luck with it.
+	 * The first thing we expect from index-pack's output is
+	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
+	 * name of the packfile it has just written. The line is therefore five
+	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
+	 * "keep" prefix tells us that index-pack has also created the
+	 * corresponding ".keep" file.
+	 *
+	 * In the "keep" case, we need it to remove the corresponding ".keep"
+	 * file later on. If we don't get that then tough luck with it.
 	 */
 	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
 		const char *name;
-- 
2.56.0.173.gf57c9a7388

