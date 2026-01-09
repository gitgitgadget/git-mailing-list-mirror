Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A0366DC9
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989132; cv=none; b=LuGA8UVWWiYMDqBSd+i+fQMdsgBJ6fe0Msrc7haLBw3GNq+7gZHKPt1KYX5ObBeV13H3sXFM5cUUa4XKB8UX0YdB19QYfZBQts20kv35YO66g6y96Zha9R4l/opc2Czo8XNKBCRyuoLvILu8in9X7gzCsWDbfeRTIZhKO8mDqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989132; c=relaxed/simple;
	bh=+P/tvqmeB21rrMXaiM1c9PjZfMh50wP1floO7t2RNPM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T6UQoBpbYhZFuIdZkTVv+M/KzlVIjz0pr2R1mcj56WQB1Y5copiReQ+8YmQ8YOd+EtEdmQaHXVWpJ0xGU5gJofTAJzZFVWiXIO6D0iPDkloW2UsD4Nmr4NvrdLPVjUu2oaNlJ17LAPgDVh8uzqTsPhfrUvh6k6VIyNj+5BPvaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apDEhncn; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apDEhncn"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121b14d0089so4817917c88.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989126; x=1768593926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cxntcKurikVOIk7hlDAbP3gD0EG7hjw6SYTRtkYDmY=;
        b=apDEhncnRHp9tu4nfmw15bHza3WQMKdV0Tm5eQIMHgwOLddh0ZkkjHK6lnwva2wDrH
         jsLNA8clIB5vj/tIqK8yccZSuGkpiDIG4SS70HdUuJV2nZS+uK8HPqucr3GCv0N+ZAN9
         eClloLGBcb3Glpd4hV1+YSuRhNuLvu1isytJUWsxmtyQhnRiu6yn9as9huhWROXKeUOM
         7X1XTycjdrKUx5NrwqrNXHD2oUxDIU6tJ9UsmxXPwv1TkOl2INpl56dg5ECwPqCenpVw
         NCAF3ah9h4pQnMgiZFlsdTMCE3mKU65mQsVPIBoQm+A70d6sd+zzCUu7GS8DS8+a1+zA
         J3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989126; x=1768593926;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2cxntcKurikVOIk7hlDAbP3gD0EG7hjw6SYTRtkYDmY=;
        b=iivETjuXah8MG+bs1FhpSNPyhIlqm0LQQsoC+CU0PP0KCCAzfed58vCF4TiMkJ8Jy7
         DoqecbhlRI3y5nxsbHvF5b9LRD8pKIYX05NIVYVW623gSkUPSCzH8u9dYh8SWc1+DwAg
         qhki0aSkQiMhJBzSkcODVBRclFZEvz7oYBNlRIGs2OFN7tfib41HP8seZgCgiuLYT7rK
         Gl5rXBPA5h+NY5uwy6jnjRTpTHxedgIzpnfjFlX4Go0Iy13WDWv2fDyK6ucXDkUJAcP8
         bkqRgRN0j93QGhYFFCYPGfdlZqa1MeZ87cmZa9lxre0G4KUJny5DWv502TOhFKrjJKZ6
         J3VQ==
X-Gm-Message-State: AOJu0YwvTCXtXsAr3QVqIds9oOqlOmKSb/ma1pFC4vSVn49qeMhPy0V/
	3XQC5B+fV12UZ0ga0PVdcg5M6PpKR/nd6V+zhOX2aWmDtSIUzF6d5nOV7Agm+Q==
X-Gm-Gg: AY/fxX4hwBqY/ANdDnDj4ohjkhmBtl5DmrhxYvJPQ/v1Scfz+kug1oJOMkuKzXW8DSU
	UlgT0mPgQVY1v3hFdbZm+oDVcz2i4batEBRZHmhWH/fBjuIQCRoiBgV/157DQJU4wFxR5F3LAWN
	+CSi3v4Ra6qh3ApRZb67CyprZJJ48yopzmqfa0FR4/VPDv5VveAFdMEbo7rIsFjUyBLF/HOHS6u
	fAxp/YoKz4+Gd/eLzguKpO91CicjCr6C7o7hTHovDR8uTiVJlVOQBibgjvFP6Fx5nnfJNnt8n5+
	qHl2bO0kLKruiV5uf9KEiwLK+WtzD+U7h2jp6MOo/Xe4I4UOYHP6h1Xa65qMyuhNX/sYj913O7/
	tSmFYheZAWyQid3DehnG6hwuaQWqMHPkblRrYD3/Xo8AVtLxisjAnI1jCEEx5bvX/YDDsvwy/QB
	g/VDB+Oj3KHqSYDN0=
X-Google-Smtp-Source: AGHT+IE7tmzn7BViP7xC/sb5Hn7RxOFhQFTKvfEzqx/OMS718m9kZAvI/+rdFIUPAk+cNZykAec3Dw==
X-Received: by 2002:a05:7022:69f:b0:119:e56b:98ba with SMTP id a92af1059eb24-121f8b8ba79mr10683060c88.33.1767989126117;
        Fri, 09 Jan 2026 12:05:26 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707da231sm12895565eec.34.2026.01.09.12.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:25 -0800 (PST)
Message-Id: <7fe463d68aa58fd563053ee1cb87b2a8c1152957.1767989109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:07 +0000
Subject: [PATCH v2 3/5] strbuf_readlink(): avoid calling `readlink()` twice in
 corner-cases
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

The `strbuf_readlink()` function calls `readlink()`` twice if the hint
argument specifies the exact size of the link target (e.g. by passing
stat.st_size as returned by `lstat()`). This is necessary because
`readlink(..., hint) == hint` could mean that the buffer was too small.

Use `hint + 1` as buffer size to prevent this.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..44a8f6a554 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -578,12 +578,12 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 	while (hint < STRBUF_MAXLINK) {
 		ssize_t len;
 
-		strbuf_grow(sb, hint);
-		len = readlink(path, sb->buf, hint);
+		strbuf_grow(sb, hint + 1);
+		len = readlink(path, sb->buf, hint + 1);
 		if (len < 0) {
 			if (errno != ERANGE)
 				break;
-		} else if (len < hint) {
+		} else if (len <= hint) {
 			strbuf_setlen(sb, len);
 			return 0;
 		}
-- 
gitgitgadget

