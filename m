Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56729A33B
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313149; cv=none; b=h8MDqCsObo0RXj1q/GFYAvW1BVO2+x1x2vNKBkGrb786gVUSats9tGv5gZFSgvMUF+nl7xbXqJ2ZWyIIHK0qp8kxIC52ENp1y3O9v0AaYb01UmMysYNk8bZclceXRRmdVK9SN4mvMMtAGkIog+Lr1bzOk3BzOmL403Ic5xlGck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313149; c=relaxed/simple;
	bh=lxd25noQuImu+PeRxHp997Put0K3Enj5Sbh+4m1DKTU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vnab3oAIZP1+480q4jVd1ggzBqEyK0RmOE/rURmtZ9McZi9619fwmzn/97oOxCeU3KpJxL9XcPa2BcCVmSfAXFpSAlfPz6Fai0gG+SQB+NGoATmlw5InXZ5B9bIOS4yV3VQS9vpNFjjgWT3EdGwp+2vxFNBzzYOf6vMPMnKubNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je6z2caD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je6z2caD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so5884745e9.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313146; x=1747917946; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYFvukn6/CK7N6FsT2D/2crlVYw2lGs4T8aZP77qfNM=;
        b=je6z2caDUkmzkQ2gNrAAGWWfOqXPGvk48iyYsumfHBtr+deYf6FBO71kUJP2dZ4eoE
         AuSrR3nz+HPI4d7Ojc6LYv6m99Nhr2dOdVg+DQYV1N13XBNTUYf+7/ikpfiNkGjkPuLG
         jGmO1G60/jSv00+vpbKymI64pgaB48+cC2rXHflmXV27snK6sEBPa/coDoADQKMDhlwj
         9QcDT0L4uuhVn1wVfX7H09ILw8kFrbwRtnON2X8SOf+rdAIClV2QnNdwwAvNwR56slYf
         vwVrZUlASWe2odcMxmYr7vrTrHVeUBxiybLOsoVD+PfCgChf/CWuvz9mIvPCgHfZJQlf
         ITkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313146; x=1747917946;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYFvukn6/CK7N6FsT2D/2crlVYw2lGs4T8aZP77qfNM=;
        b=gdo6yuwj1kpRFlZsCHehQddLbKgJmV/KKd6V0fmYm4BZiUrA3qArei3gQmobuSoIGV
         63pocM6Bk25t6mDLiDhQh1CZPfvKnHj1YCBvqkjNiz2XpnImUa09drx6/Fnkwk6356Gp
         I4LiDaoxFSuCIWdItKm0xza/fcRIrb0OYI1pgcYkwNEwxC/qhKsOwUgJmCU/khipT9T0
         OsMRt46eF0ZzQG7ZwpoiyYwa6WE+LAXEAtoeMqAmk5fbA2Fnh82Zqg9iOgLtYtpolJ8k
         RxpYQ3grly7JQr/uDel3Uh9tgJeOV31jl/IfU28SVRPXGemVR/t3Ek23twXKOzRxSi0s
         CoUg==
X-Gm-Message-State: AOJu0Yx3pa2Pan3Sf4f452VHHgu9c7+uwT+VwDgssJn2Xlwhs/zgOr1W
	qJJe1Z1OFIqCeFG3bJ7LhVdCpTcvvJdJtE3+m8Vw4LZI/V5+ZvAZiaCdwrXJEQ==
X-Gm-Gg: ASbGnctsFl4bLTWX94L8XGo+0F5i1eRJe+v9sNhLVbkC1R92nLLEIS011vbnXFRNbhc
	om4Az+U/x4n7EDCr6xjLLQWHotSU6HcmLDNSgMbN0Igv0aradADHw/DUO6D4PeRSxSvwHIVeP/A
	6fPKjWLHMoGzmYPZxA6CH+LgrvlSMuzfHmMmL9n6K/nOLDd0I59gCBAbcJXwzGQq35ATrzUFa5A
	FbkVO9kOqAlTZB8YJ+MM06BqA87LdfpFu3EpMAUdhdQaH0T60gLg5VMAOAib6fqgXGY6fRILei0
	CIMf09ppw2Fk0GC4MvbKJAuBpskTUw4zbYOOSnV6P9lLajybgvTe
X-Google-Smtp-Source: AGHT+IHaNnM9O2Qvu9HIx5/b9E55j4gV/dR1jiUMSqt2KS3mKP1kHrfP7hcNKXCPH71xPet3xM91Pg==
X-Received: by 2002:a05:600c:46c9:b0:442:f8f6:48e5 with SMTP id 5b1f17b1804b1-442f8f6494fmr26928535e9.8.1747313145932;
        Thu, 15 May 2025 05:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337db8asm70606005e9.9.2025.05.15.05.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:45 -0700 (PDT)
Message-Id: <721402d9d8a76d3564aee0403ee046a2bd035dc9.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:30 +0000
Subject: [PATCH 05/14] verify_commit_graph(): defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `lookup_commit()` can return NULL values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-graph.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 1021ccb983d4..b3696736d248 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2786,6 +2786,11 @@ static int verify_one_commit_graph(struct repository *r,
 			the_repository->hash_algo);
 
 		graph_commit = lookup_commit(r, &cur_oid);
+		if (!graph_commit) {
+			graph_report(_("failed to look up commit %s for commit-graph"),
+				     oid_to_hex(&cur_oid));
+			continue;
+		}
 		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
 		if (repo_parse_commit_internal(r, odb_commit, 0, 0)) {
 			graph_report(_("failed to parse commit %s from object database for commit-graph"),
-- 
gitgitgadget

