Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4241687B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001518; cv=none; b=jY8fTF3yVmiAOV872F0RdTy8MDYMGY4+w6N5bZ6XEtTkzuEkiXBQSte3lGtSpauOgPwSaegsi7bqdbtv6oZONSovzR3JPlwKL3E6e+kwtU7AsD/Hk01TOV2ks/qPJLVx+y4HpJ/IuMpSKUIGuWgAtyeph+9C8nIxhyQ92tS5O84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001518; c=relaxed/simple;
	bh=XVQ5HCaLmATIg0gJrUMwUjUXBwxLQ1XLkwUtC+SWSUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA7TCzVUT5RDi45DsI+TWT6VUGlmZy8BbBn6hf3jhynoixl26QaRUUyGHp4JCvr6ZW4SRAP8tCQDD3qCf0soD18n239iA5vV5jhhvIJFWHKBJggxbrmJA7xxbV50AtqpsvmGPeVdnTsIej8t3y6sG7G48tAIxwYT8pWNCZVdO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=ERvnNoPT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="ERvnNoPT"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4207ac26so4135205f8f.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792001515; x=1792606315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYSBry29su6VZGUAvQhPaWO8ym4PtWDDOPxtoml6/dM=;
        b=ERvnNoPTVAFapEcVZcMeIzT3+4gzDZmtnfOcNp7+o6SszcwdP2LTmRBxbciCTqYw3r
         1WuxEegqIaUQX91f2n4qOi7dqoYX9K+9vfkBrBJUQkW8vE7QT4q/wQVkksynLDBEPQIc
         BA+fOiBT4oSxh86eXHFOonfT+1zONb+TxUdns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001515; x=1792606315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bYSBry29su6VZGUAvQhPaWO8ym4PtWDDOPxtoml6/dM=;
        b=WRMLc2Lv5C9D1BTSHUd6Os0zVFp2x7kBlsXBgmXggDgNdxo7jg32UaHlIL3eJA+T6n
         XyzoRl33D11bbHE/gInqAbwYNoFGfXYOJDGJx6S4rtN1+o1RDD6/emMA6CEoUfDpU8s6
         j1cADiSJa4adL4MfPRrQIEE1n56JU36Yw0bVga3lv1rZjHC4odlB9s3kiqjHL+z7z7Lt
         U+/qp6M7lYTxp8V5hzkm2TWUiLlKBVQq/k7dMMkxyqHdiLEzYxT6EPu3vlyveMrNPDgh
         Yv7xpqq3FKKP5quZLlBHu5IEeHvepUb0I4gn2eU+5PBoLASN+54J6V7CKWcRjEcJPc1T
         ptyw==
X-Gm-Message-State: AFq9FYLAkgOzsJoe02Q5iY8SNLDpKJzVQMrhaoap2OZ251l30oQZ34th
	ClSpwdXoxIO4fhp16ByxSBGQlln5XHVX5CtQDvZPfq9XOX1QYysfa3gNjrNQzm3OzOhe9RIABJu
	OdylZRI+OZA==
X-Gm-Gg: AYBFou1a7NdPKBWGVvUYZ+SCBmIm3+RRBEbIg1RL+a0ZQlzTF1ahMVFaKksUKrBK049
	RYO0ONjA4iD5PH01iUaW6p0KSq8uceB2l1MPeretZbDhycQO9G7NuoYJ6Qa1tvBB2ANOpTZEOGi
	Vfdi/NknOiKQni+PHy9Cmvj490XyDaYF0BJtz7muaARDzYqgUKKL5vdwbK8cPTjqQ7tq8rHwOle
	YXbc/UN0XluIt0f06sedFTUJlzD/ZjfO9eZaREt7VSPHZlbOnBanhGUFTZtQMzR8bJEpK2cdh9p
	+BgS0fy+ed9vtGRHcAYnEX4+GTwEe4ftfDiMdmoeyeRtCmgz25tAry2xF1CInsGgPYT/yxzt/m4
	IXXNVhQBYC6gCQGvUPFhqvPxPU4crNHA3lhPHmPaz3rCoYRSzvNjd7lAHdvQBbU7GlePKgwKgJe
	ynh+FNKmlLwQS+hJcQ8/HxNmWStctpvX8TWkXT2Al9pZGzmDNhiq5OYQFNcCUllWfwD9Gd0xGIN
	FwjOmGDtmjzeNKuu3jBQJJ59WojZr7vb7e0skCcSaGO8GSG
X-Received: by 2002:a05:6000:611:b0:48d:f1b3:c02e with SMTP id ffacd0b85a97d-48df1b3c101mr2065883f8f.25.1792001514816;
        Wed, 14 Oct 2026 11:11:54 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a86:1382:f12e:5410:6774:61fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4f34sm13806721f8f.28.2026.10.14.11.11.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 11:11:54 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: [PATCH v2 0/2] connected: fix the connectivity check with alternates in deepening fetches
Date: Wed, 14 Oct 2026 20:11:32 +0200
Message-ID: <20261014181134.56220-1-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014103507.35317-1-iwiedler@gitlab.com>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a deepening fetch the connectivity check runs rev-list with
"--alternate-refs" as a positive revision, so it walks the alternate's
whole history. With a 7M-object alternate the check takes 227s after
a fetch that received an empty pack.

Changes since v1:

 * The connectivity check negates "--alternate-refs" in both cases,
   as Junio suggested, instead of dropping it for deepening fetches.
   The alternate's refs are a boundary like our own refs. Compared to
   Junio's diff, "--alternate-refs" moved up next to "--all" so that
   the comment above "--not" covers all of the boundary arguments.

 * New second patch: odb_for_each_alternate_ref() ignores the refs of
   shallow and grafted alternates, so that neither the connectivity
   check, nor fetch-pack's "have"s, nor receive-pack's ".have"s treat
   history that the alternate does not have as present. Partial
   clones are not detected, see the commit message.

v1: https://lore.kernel.org/git/20261014103507.35317-1-iwiedler@gitlab.com/

Igor Wiedler (2):
  connected: negate alternate refs in deepening fetches too
  odb: ignore refs of shallow and grafted alternates

 Documentation/rev-list-options.adoc |  7 ++++---
 connected.c                         |  6 ++++--
 odb.c                               | 11 +++++++++++
 t/t5618-alternate-refs.sh           | 25 +++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 5 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0

