Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B847581B
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690663; cv=none; b=ODQiO4AUlKJ0qg58B08ZW19f69YQc19pWjxeoSpyJdTBlT1lPYLm+m3E7cOJX/s8PInwnItVzP3wVMWtzEO2IjCo5ji0CN1swGHf06Kg0XLknDcfLZswat4N7IxpdtcSVCctWUSmzi0xuc/KggB8ltGzffg+rz2ljS0CJcgZQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690663; c=relaxed/simple;
	bh=SkEQ9HR9tbVW1ptGqsuh1ghjU+W2oDsaUg8y6LhSGu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hObqOwQXIhVXCF/nxc0LD5xLaHCDPlnWYjFtoM4+3eUQ/G+m3HD32xXLH8uzz4U1u+F6CDOzHMVcJ6NYpGS18PocvvliboON20BOVCY9Q2shVCwbYAhfgckqiEA5iDiIC8Go7b4QqsF15XUg9NGb6Bb212LFZtgbjCdyjYDuYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G16S5mWY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G16S5mWY"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a0e4b773so28427166b.2
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690660; x=1716295460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEW+dc4mApfe6LsBV6ZFTSwrTa5m3p4OUM7MyP9vR8o=;
        b=G16S5mWYwPlYYGVVeKwr8UJLDMWQ72SB5apsXqUP3IDn45M9wgIwhTefoxd6lxbGkN
         /vINfT9BTZiqHOyHCtShJ0urzE6S1l04gJ9KgBdxsim1YIpTHstDjUH7QKVxHvxJRRtW
         G3MaXj1ZMW7aabBTBHHUb/uwf7zP6y3mJ2XfH5Y2jmY6nvfEE+8TJ+kzWRgIoG3bwFNf
         C0WZSiujpqTUfyv6+4mxX7SumB2NdNAtR5SwbbppE2ZOoLnW+ADILjmA174BHq+n3tAx
         EnwNHRP8pShfVTPalDcgCADD/4RyO4bH1fT8jep5S+2qiGYjNetr9mrx36zo1BeJ1QM2
         aq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690660; x=1716295460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEW+dc4mApfe6LsBV6ZFTSwrTa5m3p4OUM7MyP9vR8o=;
        b=jiewuTjJNVLJQtdwsGvJjWKGzmmb/lkwf0UzHTk8EIzk3A8W/ayxucn54ss8NMVri0
         oXW7TDTD7FUL+auXPrBcYxZoDzC8Bk/ERiv9daUT6JfsaWjGtbOljJqWMObXpUW1xOOH
         nUMVRaJEdDKgMQDhIII7fS9Jx8wyGWWhtwkR2W+MmBGakZH7dz+uLxRnIIysr+zEcC+s
         ThzOAGEGVBeB69wPiDslvRrF4DaEPKZDg8J6u73uYAwkOX68qR9Igd8hSORAANpZZPL+
         GNoAm8mZHfTxbmVwlqPNStET2P86lREY9kPN7d5zMv0SMQI1gMBZK8SkPUxmzCph1cZ8
         hoNQ==
X-Gm-Message-State: AOJu0YyeTBrM1+LzVEF4pZ0rkiaO7utvyw/GIkHj7KiIEymCrdPX74DY
	6uJv7X0E4tSzeEnMxLqfcTLLpTKOUnZaaokzuU8nUwQh+9MlaJFagPjRBQ==
X-Google-Smtp-Source: AGHT+IHbnFiamkkBsj/lnuzevb0AEhx0yM1t/uX9dnFt/z+q6I/L2h3IP3bY/qfCngHbFmWZycgTgQ==
X-Received: by 2002:a17:906:a18f:b0:a5a:234d:98ee with SMTP id a640c23a62f3a-a5a2d5cd8a7mr761593566b.44.1715690659723;
        Tue, 14 May 2024 05:44:19 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b019edsm730530566b.174.2024.05.14.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:44:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH 5/6] reftable: pick either 'oid' or 'target' for new updates
Date: Tue, 14 May 2024 14:44:10 +0200
Message-ID: <20240514124411.1037019-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514124411.1037019-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
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
index 975061d103..c17e68100d 100644
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

