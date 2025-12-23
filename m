Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64D32ED37
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488304; cv=none; b=WiziZQ8eh2LQnw5soxl1RqbaT9rGPJWK613ibi0g++DDK3hEeugVbbNDT2Oja9XR/+6cjcC4t4XM9Wuem2VeSQ7ZB1/i8z8Wv2jk+ZMIVXh0o++SjaOQy+EpGiVdicaruCOE+spNZEtXH0dMyY675NhEp5o46440gpHcMD5haMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488304; c=relaxed/simple;
	bh=wGtZIyw1DiAiUG1iVox4gCvvTDVROqPFZ5F6ZQZL8Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzuiRd7+ICYtJS63K0p52oLPYGP8f76fdMAuZZEIYlO4uXHZmQvps25clpQxzQP6lcgqiNN/OwMktWXZNxUz+ujTtEuRA0Jkby6xU/xqAqlea8DsqtbLjGcgOZ3zL4tqg2rAnACaD4N4ysUPAzYH1oQG9B0IL4zQ+00P+Gxbl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2NLMYwL; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2NLMYwL"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2357589f8f.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488299; x=1767093099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnzwitSsDpMiuBZM3KQVE/5fEnmfcUlHjn2K5JmS+ic=;
        b=U2NLMYwLn/KohwhkfECQ2TxM/EmtKzS/GTCLchdlhMjZVAahanDWaxskMChWhD4Fcz
         LJyVUxUlO3Spn/C1/NiRiPYs482AnflVHE9PY7a77RHUFfHGb1GnnYyQGYmZiYnkoHX9
         /Ka+aeMXaRKxdnJihxw/2yqzoE1KmG6mKUSUROw5S0D6Blu8FVs5d9byfzN4BXxQraZK
         9V0VHnYZ8DK4MiGRXgCxJzbW4wcSExOc+pb9fgm6LBxawvcwe6juLGSpBMfQjQZKCWPS
         hqWhQ6MJDfoUZlXZWM2HfLwO1dn3VBzimRkDLN3vDjiPkVqwKZxFh0DMCp/2g1bgTVI8
         fA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488299; x=1767093099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnzwitSsDpMiuBZM3KQVE/5fEnmfcUlHjn2K5JmS+ic=;
        b=WjpQq9vB89XVXGRjtfZBUPdEyn41lvfLYqtvyfYbLO2VHdqxtg/1UVmSrbnaXu1l2S
         qCuJkg0saAOi4rvFrMSx3dMZJcIYiqQtyXi+pmSSeQ5i2qarW/tkd5JjNovFVjn52AYP
         KFekJGb3bZ772kh3NhyfTXacNYA9tfnN/I2GKG6aiDTMoce6EBnn5zRrgChZCU0cRH4D
         i+gptVHarZUMzO57AQ9FDtO2vgUnx8nv43UIxY47c668zOropfwB89nLvAzJWpoKquky
         TZkh6SX/qiKefJbFHuITRO+eqaVOQwGkzNhZUO4OCEostJyDJqbkxaf8O0BGsBrozq2x
         W9eQ==
X-Gm-Message-State: AOJu0YwGVLJbQrq5X3RdBSRiV01sio8LKpUCvdbQxwvfGAjRYmgnTV53
	N7oo4aYsLP7Mkc7iM4Si3FIYOhwTy66RyyakI1ap5H9Ycoe4yQvq/LnGnZCVpXuJ
X-Gm-Gg: AY/fxX73BdXqRTU8O60WjRytDNXp3OlxboUR5o07sENd3sOYvRE7aOuEikAmKa+1Kfh
	kP/ZsvS3IpyDE4rXixb1sUaRDPO1LLCumZJg71bTOYezhMdZ/XOCzHPkhOkSjxgeSVMuEx7AKph
	YvmhkTAC+/SHtHY34chDctmbX+cUwrbcGDQvNdm40rWqfJHT4Uji5cNRJ5wc7eYre0uzWNTuLOP
	FgAnVuwb7/gTysrhJ7GhFxLIk/A6g4sfojUDpqYqTvl0lwo39OmIPydJ7JPTZsi1+h3TEC+m0Dc
	Y8fpBoKmW/auy88gx2EVpHZLZJZkBaitmoZD1U092kWDSxG7mqje7/+UVbwsy2uhtJ3DD1qRBXw
	Xujn3N+5Q/HBNRiCV0nNPWyx5WnrOBlWsMDOftAlJ2qrttd6SRdYrPR+SrJdgunFTBGCW9URJ/K
	b/YdSYU31uyy9MZpVQouscsFvILLIpRlkRyifw6a851pE4yJMA171+WcBtgxF38Oc8okCbvSTJi
	PMwLbLJqipxNWtGag5sB/YTR0o=
X-Google-Smtp-Source: AGHT+IHZYqjSxbLRjJSlZ44v1H+kHvq+vxEKYmCuC1x4tb36xTBY3vLplvMtQ4kr2yU0aNzZ8D9fsw==
X-Received: by 2002:a05:6000:2909:b0:42b:55a1:214c with SMTP id ffacd0b85a97d-4324e709a9dmr12540294f8f.55.1766488299362;
        Tue, 23 Dec 2025 03:11:39 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:38 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/9] doc: fetch: document `--filter=<filter-spec>` option
Date: Tue, 23 Dec 2025 12:11:09 +0100
Message-ID: <20251223111113.47473-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--filter=<filter-spec>` option is documented in most commands that
support it except `git fetch`.

Let's fix that and document that option properly in the same way as it
is already documented for `git clone`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/fetch-options.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index fcba46ee9e..70a9818331 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -88,6 +88,16 @@ linkgit:git-config[1].
 This is incompatible with `--recurse-submodules=(yes|on-demand)` and takes
 precedence over the `fetch.output` config option.
 
+--filter=<filter-spec>::
+	Use the partial clone feature and request that the server sends
+	a subset of reachable objects according to a given object filter.
+	When using `--filter`, the supplied _<filter-spec>_ is used for
+	the partial fetch. For example, `--filter=blob:none` will filter
+	out all blobs (file contents) until needed by Git. Also,
+	`--filter=blob:limit=<size>` will filter out all blobs of size
+	at least _<size>_. For more details on filter specifications, see
+	the `--filter` option in linkgit:git-rev-list[1].
+
 ifndef::git-pull[]
 `--write-fetch-head`::
 `--no-write-fetch-head`::
-- 
2.52.0.319.gfcaffa7898

