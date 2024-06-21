Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995C13D615
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971063; cv=none; b=BS2WGeYbKn9Do4S2G+P3Z8xYGm0iVe14dR6Jb4DQB9eizyyTrQxMUgQUnrOr/HeIFz/9keQFW6t4vm7dDmUXobtJx4DG6cwhcFXkVRUPo8amURxsUttPpSJmelDGsnnGjRHffXG3OitNvZttiaabwCbR02EhgKArrIgzK5HSMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971063; c=relaxed/simple;
	bh=jBinizWQCCoeYv2HFZSDGnb1j4pbhFBRnZpbx3pg/PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOe0ZFy4ZKSpaVvPXynR/AJYWdAJFCICFosCO3Fd22q8W2EDt742xVTxnWbv9CNKcahI6WP5jYwGZyKO6QIcqLdwA1EEhUlDl5F0i8B17s8pDgp4HniFwYqAKpPlB3x+qE7FAGZMNTw/seziI7sqYuylFjG0ZjME6tCdy7GCc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcyN5uji; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcyN5uji"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9b52ef481so17248365ad.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971061; x=1719575861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqBRy5XwONuPr2SPndIO+2Gw/tQq/mBfot0XyFy5JLk=;
        b=RcyN5ujiF1yn0gN7RCPVsbIaiZGYkEXmnLL/r4AUmFTaNnL1WeEwiuYIZU2EobavXw
         gXgSjTS9xud3YS5pV8yhX3LT8FKaTpuUwDTWI5DotinIxm9g2FNrKrgcSn9Y0X2Jec98
         SvpbbwxbYzPVp3Ju22jD+2xw5Vpgbzx+bDbaOSzOC+0J8zWgeWrbBiHXaVhBOKg85yXW
         7c2FGlxTLlszxTwk4D7pONNDvWcOgs66mAOPMZeFQ7sTcBge5z54BSpffdMHJSnVa0zH
         JSp/QdNSz0ogJfgcZVsxNALyIzwSbRwklyg52se3W2WIXGkohE2/nn4nkYlWLkZx0+/7
         GJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971061; x=1719575861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqBRy5XwONuPr2SPndIO+2Gw/tQq/mBfot0XyFy5JLk=;
        b=j2qj7UUfH/LSudTsRYNdWn5c8wWG+3KGtySFyZOo6dJg6tIZEq7HW0Wd1Tp63j6yrp
         oXMd++Pkz5+fiB7773XCHBKSIz0rOJET19MaiZeSu2A2AYdyiiu8CJ6aH9GuD76eWdcL
         XFYTUgAAZoZVTPSJrFdIFCWp4DRZOCC6BaDa7cGQvFkyv90OjFl3/4ep2385K99uuLpy
         L+wbQ5MuKnnau+0isxU1oEJK7vuHjgVFBDZ45lx95/n8EAZ4DdB0q/djcZJr/jI6p0Zx
         DMs+Irp1Lq4aT3tAf8jfd4UDlgwdFOK4yQomFREcHkcnh19qsu/uSIw3hiSWEeMtR1NM
         BTng==
X-Gm-Message-State: AOJu0YwvAQkXTR0qnlG4QTvvfUKIuF9Rt+XNDrx6Gphb1o8ic40d6SBz
	qmFXiBWXTh49faYgGWwmNrDw2FaGac91Hk2qymHGZ2J5sVf+nrjAgVN12A==
X-Google-Smtp-Source: AGHT+IG1n0WNFdGH9wRnRFwu6vXF8Zb6Monmw6PSMS9rv/Ry18Taj7VW+KrodChLoMXAtHTbexHVMA==
X-Received: by 2002:a17:902:6805:b0:1f9:c8cc:9e0f with SMTP id d9443c01a7336-1f9c8cca23cmr38412015ad.18.1718971060731;
        Fri, 21 Jun 2024 04:57:40 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:57:39 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH 0/11] t: port reftable/record_test.c to the unit testing framework
Date: Fri, 21 Jun 2024 17:20:55 +0530
Message-ID: <20240621115708.3626-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/record_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series moves the test to the unit testing framework,
and the rest of the patches improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
CI/PR: https://github.com/gitgitgadget/git/pull/1750

Chandra Pratap (11):
t: move reftable/record_test.c to the unit testing framework
t-reftable-record: add reftable_record_cmp() tests for log records
t-reftable-record: add comparison tests for ref records
t-reftable-record: add comparison tests for index records
t-reftable-record: add comparison tests for obj records
t-reftable-record: add reftable_record_is_deletion() test for ref records
t-reftable-record: add reftable_record_is_deletion() test for log records
t-reftable-record: add reftable_record_is_deletion() test for obj records
t-reftable-record: add reftable_record_is_deletion() test for index records
t-reftable-record: add tests for reftable_ref_record_compare_name()
t-reftable-record: add tests for reftable_log_record_compare_key()

Makefile                         |   2 +-
reftable/record_test.c           | 382 -------------------------
t/helper/test-reftable.c         |   1 -
t/unit-tests/t-reftable-record.c | 554 +++++++++++++++++++++++++++++++++++++++++++++
