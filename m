Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3833BBD0
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032510; cv=pass; b=dXB04KKE6IKxeY3jpL90x9aqWCYblvc6KHeZb1ZUMugTB0PGbWsNl356mj96JgYu6KPZgXadrDOoNY1AabVtcUVoFl2h0UIBcC6op3BNl+qXWqzrjThr/6BGOWHhsf5CTxlB+Ogh4H0B7tsJvSrFk3VYD2lyiTuzMWQYN5LnDLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032510; c=relaxed/simple;
	bh=6O6xcuuG0dOsPzOpTtXjBsijW0u6hUGDLaPNSzuz1/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8FtQ29PYz1fxfN4alfEISQfkdMdAqIRxTPh9Mpbqbn56t/06k2gFW0qlSdKGlG92W0+vfTOaC9Z8uGxoTUjGb9+9vIB3AWdkkhFFP+3T3YkfG6JGodvsBykkd32vW/kGpHwaHv89NfOtbF5YWejNQWnmsyWq8Lxn2YOwspUADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cbznrwBL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cbznrwBL"
ARC-Seal: i=1; a=rsa-sha256; t=1769032495; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k8XSh5RT01A2hA2TTxSdNPtRPzaIFRWqDsll3NPD2GOPFl4laa//rdoVEipXtQ6JijB25IeAcCYw+b4L9ae9lzPs+pEIuOJR6rCxdrK4CVO47fIwG59Wx6X14OUH/jIA9+a7VNQxnrMPz92NzKntnvZkFhY6SyprkWJ9SFPSQGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032495; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4wizJ4C2dfJpzWPFX3+lpQUJ2avCv0HDTmVw/WOWAVw=; 
	b=YA5jielzvOUSKLle4CwMt7W9Y6a9cAEM0BjJPQKdAWIDn/IH5iDPRCitgcc6A1BBpDV+9Cj5+I5MhAlyCXI+3KNMTbxvcVaQ7gO2LEYZ4C1DhddhEBCIOSfcDAbD9/iWpBBUdd+VHBvKfr3I+MUxdeBlGZh3kp+IOPdjjiwBk8c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032495;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4wizJ4C2dfJpzWPFX3+lpQUJ2avCv0HDTmVw/WOWAVw=;
	b=cbznrwBLADYlwtKmLJ/NOb6naXAzDyYMiHI5Lbe3pthNX0aUjI48yro2AnDyNXop
	m2QwV/1RoLzL8PnljC7xllsj2sIYf8C1SsImfBgS3xOR9QCv9QU28L3gj6Ca8tmIm9J
	ZJSat9Z0P5Dat5jHACaHKp3hhgC4UOixlt2gBh1E=
Received: by mx.zohomail.com with SMTPS id 1769032493910351.5583692254545;
	Wed, 21 Jan 2026 13:54:53 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 02/12] run-command: add first helper for pp child states
Date: Wed, 21 Jan 2026 23:54:26 +0200
Message-ID: <20260121215436.1473800-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260121215436.1473800-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

There is a recurring pattern of testing parallel process child states
and file descriptors to determine if a child is running, receiving any
input or if it's ready for cleanup.

Name the pp_child structure and introduce a first helper to make these
checks more readable. Next commits will add more helpers and checks.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 run-command.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..3989673569 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1478,15 +1478,22 @@ enum child_state {
 	GIT_CP_WAIT_CLEANUP,
 };
 
+struct parallel_child {
+	enum child_state state;
+	struct child_process process;
+	struct strbuf err;
+	void *data;
+};
+
+static int child_is_working(const struct parallel_child *pp_child)
+{
+	return pp_child->state == GIT_CP_WORKING;
+}
+
 struct parallel_processes {
 	size_t nr_processes;
 
-	struct {
-		enum child_state state;
-		struct child_process process;
-		struct strbuf err;
-		void *data;
-	} *children;
+	struct parallel_child *children;
 	/*
 	 * The struct pollfd is logically part of *children,
 	 * but the system call expects it as its own array.
@@ -1509,7 +1516,7 @@ static void kill_children(const struct parallel_processes *pp,
 			  int signo)
 {
 	for (size_t i = 0; i < opts->processes; i++)
-		if (pp->children[i].state == GIT_CP_WORKING)
+		if (child_is_working(&pp->children[i]))
 			kill(pp->children[i].process.pid, signo);
 }
 
@@ -1665,7 +1672,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 
 	/* Buffer output from all pipes. */
 	for (size_t i = 0; i < opts->processes; i++) {
-		if (pp->children[i].state == GIT_CP_WORKING &&
+		if (child_is_working(&pp->children[i]) &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
 			int n = strbuf_read_once(&pp->children[i].err,
 						 pp->children[i].process.err, 0);
@@ -1683,7 +1690,7 @@ static void pp_output(const struct parallel_processes *pp)
 {
 	size_t i = pp->output_owner;
 
-	if (pp->children[i].state == GIT_CP_WORKING &&
+	if (child_is_working(&pp->children[i]) &&
 	    pp->children[i].err.len) {
 		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
@@ -1748,7 +1755,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			 * running process time.
 			 */
 			for (i = 0; i < n; i++)
-				if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
+				if (child_is_working(&pp->children[(pp->output_owner + i) % n]))
 					break;
 			pp->output_owner = (pp->output_owner + i) % n;
 		}
-- 
2.52.0.732.gb351b5166d.dirty

