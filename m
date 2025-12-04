Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5F34888A
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857783; cv=pass; b=TpwZfNwy+NCoeLT+4Lu+DRkMX71l4FSW4JGa8CjmE07DfQRfwyqOi4OSpts02pNvBV+UDIRHP52j63Nfl5QYNwBFcQ2KRB3G2KhHrIZSz/OZQE+U8A6PyXcc+e5rsOagljpOcKSSpwNKz0QZa11O7t+YpyUGkT9S2j1xnmnPI18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857783; c=relaxed/simple;
	bh=nZFgsEwBi2bydqKeJZmGZKj612wawnp3SXAM1zuEsOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdDh90t/iwYVe+9htJZPfZdAys5O0wb3bq1OL6hC6nfAiuPge8m2KLgXBrpfN1nFmIMV+l8L6M5yOt/W2wJYZ7ZLkErY/QRWG+MqUTk61YuT7P/7ch13R9XN1SYc/7ccWwzfGl7EN22p5rGzsnqV7qeRZrIE/hODGblmdkMGFeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=LgtDfgrd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="LgtDfgrd"
ARC-Seal: i=1; a=rsa-sha256; t=1764857773; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h/zBAxE4w0t/HCf2lswvnbcjYF4BbEJMhMCtOCurhBIOw2bNPWzk8k9d8OwEUfY8JeNrYEi2hsbiYLGPH2Kw8q2QvnnxbFcDb1zZTMl/rJFWv2ZzqxnqPGMz7RiELjWoqvUGTq5JwrYbsltkjGUO6WvdmD+ucbyqjARdiq+Ni5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857773; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lJ96ZdNoqZ7oq1a/ML88A4Zz3ySqBysIZFuHEk/AjqI=; 
	b=j2NHnGRLhmmxPDQ5OzwGSj2tx5rBjJRj71LVSTJy2pQmN1Dx1MFmQefkgPxmyKs7IrNxiz5PlvhSSS+5w3EuqVuL6QHK9eUzn9uq7nltO8KhLsXrIFC99Az8JWqbWnyo+KAAmG8rwYYrjKJuAiG6AtH4ahHX99MKFanYDEPLnjc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857773;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lJ96ZdNoqZ7oq1a/ML88A4Zz3ySqBysIZFuHEk/AjqI=;
	b=LgtDfgrdVw2HtD1NXjNMcTJJmhoaEwghfmQJx615f80YDTuRAqR4gC4cByNXToLd
	B/L0LHY40iDgJ4A8Lmm26r/Nv/EMbPtOHC5ovxlp5JGm0OplbMWG67ePtC39xgEV+Wk
	Yg5gGnBuHD6MebGTa3TG8EZU3OstJw/Rt255IGMU=
Received: by mx.zohomail.com with SMTPS id 1764857771117796.9230234039165;
	Thu, 4 Dec 2025 06:16:11 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v4 09/11] hooks: allow callers to capture output
Date: Thu,  4 Dec 2025 16:15:33 +0200
Message-ID: <20251204141535.1986263-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 1 +
 hook.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hook.c b/hook.c
index 00a1e2ad22..35211e5ed7 100644
--- a/hook.c
+++ b/hook.c
@@ -158,6 +158,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
 		.feed_pipe = options->feed_pipe,
+		.consume_output = options->consume_output,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
diff --git a/hook.h b/hook.h
index 01f91feab8..6b0cb69a7c 100644
--- a/hook.h
+++ b/hook.h
@@ -80,6 +80,14 @@ struct run_hooks_opt
 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
+
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_output_fn consume_output;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.51.0

