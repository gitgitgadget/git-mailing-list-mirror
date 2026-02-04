Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D623E8C7C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203323; cv=none; b=WOMU7KaMZxxuNZvXF1ux4Gpi3e1dtT+k+hZMO6qZ5FxaQw/+LcpTMovtE21xlBRL0cwqPRF+SelcDzA8/Cl43oK8gTbDFVRYH7uugoRH0ChrH2dlFvmJK8FtmUKECeARzZ61t+PxeLX28cWGglAczx8jeWVXvEFoxdfFJG+gweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203323; c=relaxed/simple;
	bh=vzSFe5BrZQg+xi27NlBECo7QLYMwpGopQnu17T1sWLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr552n0P9APEFBQZsbmYn9ZBRN6i5MGJ6YzYhQYFxN2mbk/sBEajeDasTniQznsQDjtBN/8yXi626lA6WubTWtykqaEkwHpvWYKq9ePWX4AI3Gdynoik/uBiLoseCGo9MlxVKNEMikN11bQHvbx0rs1m+V2vY0YeZDFXMqwPxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSMMq1h9; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSMMq1h9"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-432da746749so398895f8f.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203321; x=1770808121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDibGjnl/uK9Voq7XM/q0/E3jz455PhyF5jo+/5DXyE=;
        b=SSMMq1h9SoLrr+BLtk0ii4ZpSLw5HktrTf/H9L7zVCzBq34z1qzDGp/exQ5sM43nXC
         yFlnRYtCJjQ7i7ttMj9WNkcOiO//7NbFeawX2kEYGjJ5RI2VoPrInys5ZBtxe80VefTo
         AMAfNUA/a093WCU6Jn0bhHlSst06Mg4yFvsINR9KHpxS52ZP1WGNIJlnvOKGxgutsqxD
         BQt/AerI9sKp3KclzW25nyOH8oY9hj/gwRegkSVTQZZW1ZlxulpgY3PEttzwbemNxNlj
         hHO0MFKU/M+JCEbV3wWlZECpHcKVUVtUDCyvIMr9G25f/x57mFolzaj4r4zxdw8AbMC0
         Z29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203321; x=1770808121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDibGjnl/uK9Voq7XM/q0/E3jz455PhyF5jo+/5DXyE=;
        b=BRxYyQZJLUlmzV4BopFvnUPlsq3fqX1+DTsBExO5p7hZp+dQZ2a2mJrErkVjWsJFNg
         06mB/hU+TVYR/0UnxalUa8h9tqoKU8vQs9JxD5cG2cskXrM1+Tzn2Is//+BKrVLax46A
         lvWTsreiqeH+U8a/TXTf1dVW+nP1Q1i76Hs8G3cKyJAHVgQ38eC6Y9fqSzRiirmU9Q1E
         IX9afZchuvXHz+Xmd4WUKwsOabFdPND8+6fHeuGAcWW30oODX3Nqz4U1YXHXKP+tN+5q
         dONcZT0ziAXXlboX+tzuxzQGM36elRDfjn8jxYMenoPgrcrrmaOZ4WdvNtkmbk3uYGgu
         AiPg==
X-Gm-Message-State: AOJu0YyKMUDShvaw6h+aw0uH+AYu2lZKrFlzBjg2hy9KGHfYHbWGb4kj
	cizTcDP/gd09uMCt6QygLLjyTN5Ab/BLb+06l1Rc2avT++y5ov6wwt1X8llChb/n
X-Gm-Gg: AZuq6aIBkbby7p2UU7zsKbK7r2B1SgP8M/nZctgQ/bnKSLzqmsNsuNWQE5KaIno1PJU
	DmajvQmbes6bddxEZr+Qfw5DhD4HVvy8IeLqadiMWdHFlQ+8uCxpp9AYEFkXi0KL3cs0Ug6E6OL
	5gBoIoy8czWR3fpXczFZdAkJijxegk9mIurcv1weyTVXlEJ8dgXTDUuzVmjZ12Omph4vbVBctPv
	Y6VXqrXsHDKSMOrV/awXnQb8vEmlweHGRwBaTI+L0S+38aw1p3NJKWls/txwPFJDPeoriJ+uhPS
	XHzPA8k6YXop0z32SI1Ur+xiNNOAFWmX2LHKPVw1ILzb4Y/HPLlkdoZv5uADbL/TpIG+QpH+n07
	u+hVEeTaO2WPglJs4VnlZl8BTTvv1YBS7icv4ldzZ5KXya+4BH90Q/qIRvoYVNXbTVJ7aVLx4/Z
	2QU5NJUDAbOnPg5Hrf75IhXeSso1Ihd8v2SrsSPaq3qTffhaoiL7FgozRRJYXs35S7PH86LGEeJ
	2vm9Ukmeemdo2Ge1tow2KVuQLM=
X-Received: by 2002:a05:6000:2505:b0:435:95dc:b8ca with SMTP id ffacd0b85a97d-43618052805mr3439380f8f.40.1770203321044;
        Wed, 04 Feb 2026 03:08:41 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:40 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/8] doc: fetch: document `--filter=<filter-spec>` option
Date: Wed,  4 Feb 2026 12:08:10 +0100
Message-ID: <20260204110818.2919273-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--filter=<filter-spec>` option is documented in most commands that
support it except `git fetch`.

Let's fix that and document that option using the same words already
used to document it for `git clone`.

Those words could probably be improved, but they are not wrong, so
let's just use them for now and leave improving them for future work.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/fetch-options.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index fcba46ee9e..1ef9807d00 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -88,6 +88,16 @@ linkgit:git-config[1].
 This is incompatible with `--recurse-submodules=(yes|on-demand)` and takes
 precedence over the `fetch.output` config option.
 
+`--filter=<filter-spec>`::
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
2.53.0.rc2.10.g12663a1c75.dirty

