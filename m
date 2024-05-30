Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9817FAAF
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070998; cv=none; b=ZoZMAqut3bxIAqO1Tv3OFV/tUXvJe9vEInLzRdbxejBDRcKD1TFIGGrL/Co2tqD5zl51nF5VAlyAPR86GD70Do1PRDPDfPrPXM+bbbPJuoTREkqcN+QiWBF1MRhmx4MO/2C7avMG9YzHSjt3xN9LL7nUL0Hf48hvBdUv+8G/Nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070998; c=relaxed/simple;
	bh=rYUwQGZeQaiOukbGWsbJ9/G7qV08ZfzPl4zJ9PMdCzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/mblHgKRUDXCbTYRa48H9x0dFH5P+ERO3FWv0hAHnx4mtG5X1Y+CpSKr/UThrQqAFVfiL73lDXoFePzycQplZuGPn7HTxuOqVzAxxwnyMZYk6wlTRPBoGu45RxTDDYhKNVy+JKAPIE2BmcMU2IsR3XHdXdHX+6+XZRlxWIpvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRkSDqwD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRkSDqwD"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a673a60f544so820466b.3
        for <git@vger.kernel.org>; Thu, 30 May 2024 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070995; x=1717675795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GEQdxM9Njh1gP8qcvDP5UAPEQbYiNsTYPMZSPqTFJk=;
        b=gRkSDqwDUPw6tSw/F19/kXk8S5QZYwBIrj31uYeogo5lx1eAWKq3Kbm28TULGDn8k2
         PW1t4Zub/GUMx+3TGiwBdia4c/rAa55wmG3yhxswMBMh9UIg0jeHk7W0xrNOYCI9Wmfx
         dvFC9T9Z2L9RtHDNcihWY26ZdKEEbSzUY9V9nQb+8w3AnZQ+eV6KLWRge8SWZFyXY/0l
         PMxQYRgbVu7jJdJ9p4zn6cGLF4GrvRE9B8INdtSXF5Kc91/V3965KweSBstWUMceLUc9
         Xm0MqZ2Cl4aoyidoZTc8bjGZbshcuzzUqrPC2lxKJ5dOIzAAsNx70uxh7fep55Szi7C5
         t4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070995; x=1717675795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GEQdxM9Njh1gP8qcvDP5UAPEQbYiNsTYPMZSPqTFJk=;
        b=il3vVMrEaG39u64UuXjiU3z8496qEXupXO9m5NZPZHoKuEwolQaFDnPE9EmUYtG+Id
         xutjiTxXsnO74b+gl8i+a5STT2lt/dho3QnO7qAmiDY/0b/S85HPYrLvJnyIiEurSdoX
         rL1DZ+oYhWDXYCEUgiwW0/YOJwH0znxRuDeH0JyPhg6aC6NNBnhsqz4WtFn5O6505RFI
         vId7ffKeRQJgcsjU4F+4p3iNUGljBQQg4PUysXqW4JDArua67gD9MItMiywtfRcNLv+h
         LFy+T+DLzSc5f0NskKyG/KIr5Eo3u8N3sryHKVW02uUs5Q4gL3lfzMipBppR6HAybMMu
         37Eg==
X-Gm-Message-State: AOJu0YyEbyWwJ6b64vqgQ0XxUTTq8FXEjGwyAiX5fFNPulWZ2pqQvyp6
	6P6SMflfQqi4M1g0yPj1jSqyNpymQ8v6lYSAtdTFcg70tiKcQ++7TY5/LmAQu2gvIA==
X-Google-Smtp-Source: AGHT+IGnSPAjYSFfPqWpdO05i0Lvokg7aAXoQG8kBJjVDpr799s1Xjzb+5SPBlu7ByT7TnhniVq6kQ==
X-Received: by 2002:a17:906:845:b0:a59:ba2b:590e with SMTP id a640c23a62f3a-a65e9100ea0mr119563266b.48.1717070994845;
        Thu, 30 May 2024 05:09:54 -0700 (PDT)
Received: from laptop.modem.local ([85.100.180.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e105sm831393866b.172.2024.05.30.05.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:09:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 5/6] reftable: pick either 'oid' or 'target' for new updates
Date: Thu, 30 May 2024 15:09:39 +0300
Message-ID: <20240530120940.456817-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
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

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b838cf8f00..3cbf95525f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -895,8 +895,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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

