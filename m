Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE20604AD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572664; cv=none; b=MLmQcnieRd7ut2xzVT1gpoA3MyjGVzaCiJg5ZqHDdc1IIil6HGDU7D3qv6vpVs6NXag9Vyg5qcBsqpEXCbjlhLYXBKbsltwLMLTdvH6CIUWQSaAwxF0Fz7mGaqfs6vNw2bn8GMV6E+RQqkArAj7kQVL/zBDx9iMUoWESdoZdR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572664; c=relaxed/simple;
	bh=ELYvZ3ADfkbeq4EmExbIr7WHYl3Th7av7xJ55bOAaSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TySZO7BV0PKqqZqK8vCfGZhcWoxHusFMaYXWS+DZdDyLG8t/q0C/YdAxBuBwIokuvwJR4nVCr1EAMVtvw3r/BsVKd7k+fTii5wIH4GPkhXETNOmljWV6VbjEuExd6Tk6OubduckriYkm+3HaHrTMGrwOOgD8pEiArvk9VzbqQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA1/SLkl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA1/SLkl"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5131c48055cso4703906e87.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709572660; x=1710177460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckorDQlzBbMeVjoJ8hnRXyBZ3sN+fqyAxk7PevGw8TY=;
        b=iA1/SLkl4sAgY/qDMdGEJIPQxuFNOcqdAW2In5EhursyGLfDyyxbKmG2F0KNzgPKHm
         Wf1mfXAeY21nqJtCw1VRrCdr85F8XTwRg3McXW2rQGKPPj9dm+5NtBRu7rtMp/ph0WeL
         cv1TV1NM8kZEVBa0Gwz/NzcE7NwF/65kk+RiOZuIIml4xQkfSorY/tVLjue5xMKUIniI
         RrtcwSz4lNkSXjA8MbtS7rH4bCaY6uY7oBH5dAJFD1bd4jwr+BLDvS4hw9MQzlxDWS7i
         tSPMb8gVM9q/N36kgYRuO0rWPx5Dnm25F92Ed+9M7wPdx1RAtAmpB69EVZ4jYikOsRLP
         Q+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572660; x=1710177460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckorDQlzBbMeVjoJ8hnRXyBZ3sN+fqyAxk7PevGw8TY=;
        b=HohE544MNC/kRywh1yBPb7u520k8qMjuR/3fjVjXAaf9OowPufXXlTBe9pw5RWXwBZ
         W4/bwy6lKKp9I+6mh89KnKcg4UvA+wYL2KAAsqrGTFnZ0jXndEDtUnvutKtNeW68VQNL
         tQv0fc0wPrFlPKPjVuMConGR5Ddsv/KvkxKaOeB3sPsSwMg0/sPlH7Pnk1m2/H4/zAlo
         JO43wtlmRDzCqNbctZurbXMn6J2Mis09CfoMpRY0YL1RuSZUsrdfjmnENrm3LJMgcCQm
         uItUHOa9hyLMzvwQGD1dzAvfbx5oCRAGQlUy+f2aIITfNF3z8W6h1KeHp6MrsOsKavRN
         2BIA==
X-Gm-Message-State: AOJu0YwU7vDiZXzNlqZ0wySmtcr22LgEJUfvx9XKJiLP7NY43Dpc6HKR
	DKPrjT5BIHSHdb06cpVyIfHRpV52oR1173QHUMM8UJHmUhQEDj9Qq3hq2qT7NEc=
X-Google-Smtp-Source: AGHT+IFZGXLHpS5U+HGpENNfNCHn0ORrQVYBB9fADqW8frehu2f32zrGm1u9EJWr6mgopcqxk7i6Dw==
X-Received: by 2002:ac2:4897:0:b0:513:26e7:43ff with SMTP id x23-20020ac24897000000b0051326e743ffmr5905744lfc.32.1709572660141;
        Mon, 04 Mar 2024 09:17:40 -0800 (PST)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id j10-20020ac253aa000000b0051325475bb1sm1789455lfh.229.2024.03.04.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:17:39 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: git@vger.kernel.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][PATCH v3 0/1] microproject: use test_path_is_* functions in test scripts 
Date: Mon,  4 Mar 2024 18:17:31 +0100
Message-Id: <20240304171732.64457-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
References: <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Following previous discussions[1][2][3], this patch is submitted as a microproject
for the application to the GSOC.

Thanks,
Vincenzo

Changes in V2:
* Fixed commit message[2].
Changes in V3:
* Fixed commit message[3].

[1] https://lore.kernel.org/git/xmqqy1bo5k5h.fsf@gitster.g/
[2] https://lore.kernel.org/git/20240219172214.7644-1-vincenzo.mezzela@gmail.com/
[1] https://lore.kernel.org/git/ZeWVB5uKLONfp6cO@tanuki/

Vincenzo Mezzela (1):
  t7301: use test_path_is_(missing|file)

 t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
 1 file changed, 245 insertions(+), 245 deletions(-)

-- 
2.34.1

