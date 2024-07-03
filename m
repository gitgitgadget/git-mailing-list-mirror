Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992851849CA
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026744; cv=none; b=K2AaKsXwB7PqxhKIpEaTIYgIUZ/3MPG5e2cQBdz6SaYeeUXkA6m9xorFbWL44qYkt3CFVP0yn/4tCW6Ldxw2DBaccjo2Txm0MZVKNbc0R3EFz5tGE/4gl16PLfA27zrT59G33/Awvqv/Vb/ARyUGCTe9wrSYiBmWIr6NR/DcHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026744; c=relaxed/simple;
	bh=CFysl9S4LaB00+WmaDMBwCLPw2zOrBQ+Zwwgx7opBqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk7guJH8SzV9TsbESpaEvWyxAk/aPIFQNhe8bbikSwF5X+it6PVqlSxc/yebOlqVlL26pot0nvCTKFe5pzar2yk7Vu1xTVQbEFE5uLi4/T/mnuRRL+g/MEbgMOjkhBsIbg3PtTMSApuaZ5/Y/OEsQ7j6R4a1MQ5ESTW0Dd4awek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1Bdh4+H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1Bdh4+H"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7067435d376so715613b3a.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026742; x=1720631542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTCzcLSdm+0p5Wx7+tPpfWYCI1X3CqLkTJG7M6ia+s0=;
        b=J1Bdh4+HaRaEFEtNtwIPslVgUqZx3cU3MqA02MDVOTMiKZXSu9f8RsuzfxhRR/tOTr
         jXvlK14RlmSpTnd8xD9FKHaUNuS4WUavWK/aSqJyZ96+dQPyA0sTriEwTGeTivcaslJu
         aFsAZxGv9eustk27hDSxMHgIUY1Bx8mnYjnj4nEUeYtv+zI8k9XTfco03ktrfqnzqv8p
         uGyQ5N1HH4jtapQjkgN0Njw09mFDLBY+xX8QJFxcdcPJl2zcKJcJMLB60+19f3vrpMEc
         yaflcrvdvmiA14j5cKoCxfeb7pqT9fu6xy+Z4VkwrfH3+VKl2e64pUfaa/mxnARakW+F
         gCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026742; x=1720631542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTCzcLSdm+0p5Wx7+tPpfWYCI1X3CqLkTJG7M6ia+s0=;
        b=GKum1HCblTJTS3kiqCK8Z3jL7HZhefphC5myy1Yk17tfv0mpyxw63Wky4IAQai40Fu
         hw2VqtPjtSTXoH+3P8wK/7C1RwDR+43s4M47hEzTafiuHZKPIdPJBsKsGNNDLUfTMSSt
         gHYnWucYKfUaNyjg3tBk44NfrDIR9w0ZUI0yGz3k8TpYPniaRw3On1smtc1oAP97PzHs
         AGv8Y9c114KiyJlhESLrdz4nIPkishJUU4nMzkoW+gbAhPVQzLq+L1Ro1vUoghX7JrsV
         ckSeEEg+a3M9teguNn9Hkl6BRdLMnEHKAn56ewnHxIOe5WMFbK7Uh7gpMnE7Pd1tcMFH
         HSRA==
X-Gm-Message-State: AOJu0YwrKrCEaOys6BEA4HIr/Rv7PRdXsZuY3vKQIyQBeZksIiprHDZX
	+V6dLnKrJsFVN1VEwBzwBRcUap6nVStYtnvQgYb5mSmFqoajrg4chS1l+Q==
X-Google-Smtp-Source: AGHT+IG4HFLZEJqhNwhFFqATFNpKH4uPtQihlhJGyd4EZuhWFcVp0pqPkthJk755xSfXW7wXcuD8iw==
X-Received: by 2002:a05:6a00:1a90:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-70aeb58c08amr3225335b3a.8.1720026742026;
        Wed, 03 Jul 2024 10:12:22 -0700 (PDT)
Received: from Ubuntu.. ([223.176.57.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70803ecf966sm10678860b3a.124.2024.07.03.10.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:12:21 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 4/5] t-reftable-merged: use reftable_ref_record_equal to compare ref records
Date: Wed,  3 Jul 2024 22:31:44 +0530
Message-ID: <20240703171131.3929-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240703171131.3929-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the test test_merged_between() defined in t-reftable-merged.c,
the 'input' and 'expected' ref records are checked for equality
by comparing their update indices. It is very much possible for
two different ref records to have the same update indices. Use
reftable_ref_record_equal() as well for a stronger check.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 543113f3d4..656193550d 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -155,6 +155,7 @@ static void t_merged_between(void)
 	err = reftable_iterator_next_ref(&it, &ref);
 	check(!err);
 	check_int(ref.update_index, ==, 2);
+	check(reftable_ref_record_equal(&r2[0], &ref, GIT_SHA1_RAWSZ));
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 2);
-- 
2.45.2.404.g9eaef5822c

