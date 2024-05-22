Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB061811E7
	for <git@vger.kernel.org>; Wed, 22 May 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368618; cv=none; b=a+8xCMIPsKg+u99kQI768qWq80ks2ZaZUQE4uSwY6cJE4HH3QoNPJcpbpPJyMu32BBgTRXH/f4PFtUpbWNUu3IpWcLA2h2AxVuDLSgxX0eXCAXw5GEiBmxuHQUS6/NdtKzSWMAXLUaFdrCc1B4W46YNoLRGriM8tWxfry4ozYsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368618; c=relaxed/simple;
	bh=c1Oid00CoSwXCs/n/GjZ6ci/v/6IVphE8POmTwHT6oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiV6DV1bXVwBymBmceRFZ2LAFj9RXqaOvjV9Dn272t+TKMlMECb3SkP0UYAWS0Pk7K74AHrC547cq6S/TPhdou6ltuegcp8ef+Rl8tHMvte1PkA2G3GRmVJkOjtJWxjnmdgFtu6XXfTSl4I99R/4cd9ECeRM6nZjgijrssfRgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3alPgf8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3alPgf8"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so3476679a12.3
        for <git@vger.kernel.org>; Wed, 22 May 2024 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368615; x=1716973415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feVuXyzGPcv09ZUakSF4dmzDmzPnLB7k34ooDplfizU=;
        b=D3alPgf8K1stKEx/dJaagCxKEBDabLiEW+Azy3iame8qH2q5OIv77S/b+Xf6Bwl9t0
         jfOyDANf/LW1MdjbZqiZxjfPpWq38Fn00CtRLsQKnT29E9GPLq6SSN2dLai7hKolIA+Q
         FkNNOLlR6CCgaWTv3kFT3GbVFwM/XkXd/krQjUJ3trqIIEEJzOgwe4sQiMDWNpqgdZIV
         jq1F3epHtoHGww3kXIbWEHXxnx6eu3wiE54PsjS+Ld1fwvZxp01NHl8ZSe6ZkHugYHTB
         71eRn5uEwm+JTHTWXMWUvSmUdSGgZ2z6UdqBfUBduco0jl4OHdzZaRt+U+i5jFpT3xTC
         OCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368615; x=1716973415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feVuXyzGPcv09ZUakSF4dmzDmzPnLB7k34ooDplfizU=;
        b=CUPQyvNV9l02MvpVi8r8NahqrCHLNSTJYOrEEQEPUnCD3W7B0wdm06VW9W+wh/kQmn
         E49ItToQBfbsoAt+S3GXUrm6Ki+aSfZ6FTdXpomZhWW8sWHfTXPJn+4KJxBoqwSeji7T
         BHIcc5BA8UAYXmkKApWfqjkIlzCIefmgsa3AwBRhYk+7bnZ+9Wy/jr1Mnd2WauTXKu01
         lGJBnRo7KtpzKPO2GGBXr96Rm0YVUkyjwuPw87jBcRU/Y7ugsUI/PBPsKd7UAridGvBR
         +QXKVDxfa2RxvDeXTpuFSFjB7hHE5S8MSPpZXtFhPLMTiGkpxP1FPtOKE/IJCYtRqrhG
         xboQ==
X-Gm-Message-State: AOJu0Yxe/Wwqp9pG710aUhjWQRZ4yEansSt92a4GiGoZ5NlxFhAxtaLn
	PvUqfZGJzrUmzHLMzvRot6rTXIisdCXBXWIXsCxouvuCSIONec2f
X-Google-Smtp-Source: AGHT+IG8S2Jk97enke++jofIjjDN2xqfrGjsg93VYtNP0xsF+sV2lr1cV022nQnoX/xCpZg4+WqlPw==
X-Received: by 2002:a50:a6ce:0:b0:56e:10d3:85e3 with SMTP id 4fb4d7f45d1cf-57832a4a1fcmr1103255a12.13.1716368615183;
        Wed, 22 May 2024 02:03:35 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:414d:df4b:1d67:e754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm8281354a12.61.2024.05.22.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:03:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 5/6] reftable: pick either 'oid' or 'target' for new updates
Date: Wed, 22 May 2024 11:03:25 +0200
Message-ID: <20240522090326.1268326-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522090326.1268326-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240522090326.1268326-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

When creating a reference transaction update, we can provide the old/new
oid/target for the update. We have checks in place to ensure that for
each old/new, either oid or target is set and not both.

In the reftable backend, when dealing with updates without the
`REF_NO_DEREF` flag, we don't selectively propagate data as needed.
Since there are no active users of the path, this is not caught. As we
want to introduce the 'symref-update' command in the upcoming commit,
which would use this flow, correct it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index dc7aa7f274..8582f2ff2f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -896,8 +896,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 					transaction, referent.buf, new_flags,
-					&u->new_oid, &u->old_oid, u->new_target,
-					u->old_target, u->msg);
+					u->new_target ? NULL : &u->new_oid,
+					u->old_target ? NULL : &u->old_oid,
+					u->new_target, u->old_target, u->msg);
 
 				new_update->parent_update = u;
 
-- 
2.43.GIT

