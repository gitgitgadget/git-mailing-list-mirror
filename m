Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2471BF311
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086216; cv=none; b=inWS5DejZ8/E7zWk2kZqbHkFVeI2GwsCRVhKmDRblQ+2XaEVC8ms3Hpf1wnfzQKeVgWsW1BDBXrt0Teb2MWqSJ4B2TH1DHKw5NpNVpaU/IoIg9mukyaylERFGg/dAjM+TPGeFGhWYRI5ShaFNGpwci3kX7mVhUzUHViZ5d2rvnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086216; c=relaxed/simple;
	bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aW22S4xZvRcUf1UZyuxJsIEO6AbaHuDYTsR02Mb1S2bIBxup6Vyc0kruy/MZaPG72u/cKz55+HdDzNsQGqdc3rtbkzQ7Mii9eJ2DwSgYtu+4fd51Z79LShXyCuaA6wDj0QCGDgkE7JRjZE7CyYRv38ik+3HEHwsgpCRz5IYlmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9fjLkZ1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9fjLkZ1"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so203348466b.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086213; x=1734691013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=f9fjLkZ1qZI79NMpRjZTrOVjjm2M9XG3WQIJ8VOdpRXsb7YOAf4bnnPWutK5dRlPxe
         EBdFnB6UlG5Jg91HvUqbljWEJV9JI1nYvlNnnjjne8nLrfigHlJ9jCiuXbGcAGS5+7Q3
         RgFuw6cR3ZjBnRMwYu4vkYOwg/KfpeykduMnhHWbzsMuWw69JofTEehWqfjscsEGFW5M
         09cQVw+fWMOxUHpmCemosgE9wKbCL1Bac64ZrNL8QsKauhskvomTxLorAJy4ilDJpmct
         wFTonyhBkNvGKFMf7UhWTllRKzpM28KVFys09q9gaO2RRwjcNFhSkJsMOHlUFyYAIogy
         m0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086213; x=1734691013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=exEWFAoXlROAUYYtx2clVQIXUrSAySJUlSxjThFvC8Qb5c3Iu3XPGVIanldIZIajRv
         juAmNfk/OmVHMx1o4vSg0B0ww0mefMPMldqW0jWqTFDOYwYOebKEOJic5KZHtuPu63qW
         chlfGgvmezGnO4E07RedXD2K3gng0t7dc6CHIINEaMLh0n63MnHpMHO26E2RWp219Bae
         dTUcA3r6TN54BdgpkN39tBoWWnGuIW0X3IgBsqB1rFsrZrNzr49Lu729Jg7JdZb+j1te
         HY1z8azH5FMXkb7N+PTBe/eSii/xwMckxETNVrnL01CRVozZgqEVW+mNmZHWhRUyN3hC
         zzMg==
X-Gm-Message-State: AOJu0YyEteftetr6F7bNN/1T3z8QsK2UBwiw1xuUko5MtdQSgbcve+eP
	1OWaDXrBSYhHNAzqUnEF2FJdfX2mxjybJGVYvKchsbBoPlL2ZsRo
X-Gm-Gg: ASbGncudCmVa7epH38pjVeVMBZO2afiAaaSqKu+AAoKrygxH/9QJmIeZtXq4aUdhJvG
	oS7uqxrYiWs0/qteUuxBOMcRiBeDqkbC7SVVPbIowPY+muqkgniMyQknewSrtQaY3vv5+tqBN58
	wnTZIWj5U68RaMqkGD43nzwwpD8KPeUH/UNiRC33SzETlzaTxuXhnzBAszEvCPQTj5USOaqYhET
	0cuQiyEyjzcoDbq87vAjmHwBC3b7J8u17T60jJqoz2hWLoSSa0EOyRlnfrLMgIeS01/7Q==
X-Google-Smtp-Source: AGHT+IEN+dREHKqPS35kHu+8IjyhBAZWX+6Dy3uAujderjC6DYdhs8d5zz/2HdQ3Vdjnp1Xq33XJ/Q==
X-Received: by 2002:a05:6402:4499:b0:5d4:55e:f99e with SMTP id 4fb4d7f45d1cf-5d63c3405bfmr4964903a12.18.1734086212576;
        Fri, 13 Dec 2024 02:36:52 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:52 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:47 +0100
Subject: [PATCH v2 2/8] refs: add `index` field to `struct ref_udpate`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-2-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5Aa7BSAc/6jK6ehBVCRTe5kV2//CGuMkz6/
 azqAygE6WyJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQAAKCRA+1Z8kjkaM
 fxbBC/43I91fM4b/7lZG7of6mQBZJ26I06P/12OrtGJIdWjywc8a3u7/GAGco+iUTJZh5PQ7OWa
 04sS880sR4LhdLTUYf03VyCklKegm/ULYmAAtYlpb1SdNoa2ECnc4LgAAnYmUlQPPhdmpqgAqpT
 5+48LIgoteGvwOfi4spuV2HRyJjB3IQMT894D9zggA6VoVJhiw+pGUXL+0SvcTvlbP8ihcm8lKK
 8i0Zy5MkvKPHGWvylAlmV9T8RDL9ehFSOBEWDmt9OoHJsOZAr15juvbOZAFH9HcmSwBN3YAD8sY
 yWM7LRHkiu5jQJ/8QeMsMyhoAr7hkNt8PArVln5fiCZRyCi08sUsEC8uJ0kTBnbGhKbToR8IQcp
 7wcE04n/BCR+UWUdClT5SOyZfM31/e8t5126qJntUiIsCICva+dN0f7ErKkDQI+iolyHLykSZNR
 iFQYAizgYtRHVfuAJuKCVqGehDsoD4j0TlVIWRCQzQ0p+DhpX3m/+EWSwe+R1IeKKXGT8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reftable backend, sorts its updates by refname before applying them,
this ensures that the references are stored sorted. When migrating
reflogs from one backend to another, the order of the reflogs must be
maintained. Add a new `index` field to the `ref_update` struct to
facilitate this.

This field is used in the reftable backend's sort comparison function
`transaction_update_cmp`, to ensure that indexed fields maintain their
order.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/refs-internal.h    |  7 +++++++
 refs/reftable-backend.c | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0fd95cdacd99e4a728c22f5286f6b3f0f360c110..f5c733d099f0c6f1076a25f4f77d9d5eb345ec87 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -115,6 +115,13 @@ struct ref_update {
 	char *msg;
 	char *committer_info;
 
+	/*
+	 * The index overrides the default sort algorithm. This is needed
+	 * when migrating reflogs and we want to ensure we carry over the
+	 * same order.
+	 */
+	unsigned int index;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e882602487c66261d586a94101bb1b4e9a2ed60e..c008f20be719fec3af6a8f81c821cb9c263764d7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1279,8 +1279,17 @@ static int reftable_be_transaction_abort(struct ref_store *ref_store UNUSED,
 
 static int transaction_update_cmp(const void *a, const void *b)
 {
-	return strcmp(((struct reftable_transaction_update *)a)->update->refname,
-		      ((struct reftable_transaction_update *)b)->update->refname);
+	struct reftable_transaction_update *update_a = (struct reftable_transaction_update *)a;
+	struct reftable_transaction_update *update_b = (struct reftable_transaction_update *)b;
+
+	/*
+	 * If there is an index set, it should take preference (default is 0).
+	 * This ensures that updates with indexes are sorted amongst themselves.
+	 */
+	if (update_a->update->index || update_b->update->index)
+		return update_a->update->index - update_b->update->index;
+
+	return strcmp(update_a->update->refname, update_b->update->refname);
 }
 
 static int write_transaction_table(struct reftable_writer *writer, void *cb_data)

-- 
2.47.1

