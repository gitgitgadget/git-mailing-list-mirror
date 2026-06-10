Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B841C2EF
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103456; cv=none; b=frEiyIsABI5Rtfjnlt05XqTmYj8VVxSEytAzy8yljAqfu7hHWyP3H5lJMRf1qMhJN5GqPoIz97DE/pGH+aIYnFC+8BUoXy65X0oRMhh4E9gn35l2p/pMK77g+KlCOT/jsJs0bMCZ3dvfE0B4GflonCMdoFVG2Z0eJPIpq8nJzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103456; c=relaxed/simple;
	bh=JD3z1Cnkrtwttdtcb0eo0DRkg9bsl9QpwSsNfK4OYUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYYnGvQsoWZksnjcQ8o4WpTG/D91jE4geAQYKFzgkbWzXTWPhGArwF07NFZGodJ7rQmFBL+T7f+cGKE239xq9IU4wWWl0ZwwQipcL8Te3DxwW2OqmPCg6xwdU8RpoELh2NLcYcPjdZb9fU/7O1hY/F++NWB3hYkd1BNLdvaJHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hIefDVP3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pe2RUPt2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hIefDVP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pe2RUPt2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 96451EC0073;
	Wed, 10 Jun 2026 10:57:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 10 Jun 2026 10:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103454;
	 x=1781189854; bh=8OhOA+KytC9P3ftRMl4aeat8ifa5SgL69Q8DXDBS1t8=; b=
	hIefDVP3sbNJl+PVTZTh/QZcYDVz/Y7EiZzkoxSP79bG5xJE/KrCSPoM18Rxfrsv
	w6OGjtLePRY4lFEQT6aIM1covYjx5/pezrBUKSWUXuK9gNiOIpvmtRImiIyWr0yA
	UoeV2MTQhoqC8UnV3oqWAT1dMlzr6FsdnvgsuISxBwtNMvBpi6MFYi9YcmMjFHmX
	LzvPRiN/VgDgBk7vFv4XbZkBkYxcZH1uD3Evt3oaYH8CAKqlQBXTMlS+jF6lDv1D
	XVGvYrMMdBn9EdRG/6fe44gi1EFXQRTNOFmwlDxR9BRTHTFQaN63V64lChkHq+L0
	KFVHlRHr3lhhCQUIA0gNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103454; x=
	1781189854; bh=8OhOA+KytC9P3ftRMl4aeat8ifa5SgL69Q8DXDBS1t8=; b=P
	e2RUPt2RpKsfuWjo/VjuueJhRhqwbn49fubO0lkrlTdpO+semRlNBgkCx5iYtC92
	ycTyRpKLLR+hezF0fHzouQUjyMY+yM0N0Mz5MYJzqrryh0Q8M+X4UuzofIBXui+6
	RVccsbHIWDyNQO6eCo/rbYBJujlHg8FED3q3Cd/lHYDXhijT3ARjU7rSN0gbI0ex
	4zY39jqO/sm//vCBjzLVawZMfqcnENpk3w5iNmh+9H5T267MiiEkiWx6wFIvin1/
	RdrVlzIi612Z3T9YJIKHEiOuvQUmguG2HBik1T6qR/cBku0JpuJu2sm4eoeC9c+w
	2KcuHFOH8RFMfO8Ecso0g==
X-ME-Sender: <xms:Xnspai3rbpyO1YWRUbq5IK26rfrAu7JZTEc6PjrC5fujIObyp7bylg>
    <xme:XnsparEvlO59NFJ357gcAARThvp2-7fiMIRRvr4TH6g4374EL7h2o0G8XuqFZsFVU
    18AJUJqH-2yRzZLTDpTlck1YnlyWUEz2EoW0ey1fmzkU8bMiTqXDw>
X-ME-Received: <xmr:XnspaohKZmGM-u_LaY6lLZMraQYOFoh7Zc0Zh9G18CiY6oRX_fDOCI5tfbvm9_K6gu_ljOeqscOLXDVreXuOdTzCf4nGXtH0BxKt44g5Rg>
X-ME-Proxy-Cause: dmFkZTEJn+HOU7rfleF8wtEqd8n463JF/vFO1XgyixYBoTlaS7cpi00RU70QgROPWwUdI8
    Y2g43EXoqSDarANLeg/qY2LquMRGd0tg55WNrjpoPOxekNmdm0CiNmfLlAe8VSeyDVX037
    1j6uyoB+HxekonkoUDl50g7yk3LRnYScK6sStb5pBzwl/bteJm6VFNzksB07RoD4dmcJZY
    VdiIKVbEs3XzVwXK7AqTzvu/5bPY1eoMkecDU5MTuqJ0bbzDKf6zfqc/3gVc1Tt/VrPF+4
    ykKleLBBcmf2l0TF3giI6aolK2tMnS7lvcFPqLcY2GjwARLogkLqndIPr0EeRum5dexwEu
    cTMjOHkPRefJAGwgaWnqA7l1ZkNf0yeNgiJJfKDPy+ZHC51bVcVJmdYm3LmC32LvtNC9aq
    GPAbm/arxE8Ouq0OFIxFUzGPi2IbZZ2NmkV74uWI3VOgR5Sbg7bzHNdJy0t1XL5Mh12O7O
    +WuoVcGkY9yU6Le1Yx4Wf+WVYLe168sYQQG29IIu5vtGdfrt0xFUxUKsK8UGmlCUOWRio0
    oPSRnI3WqiyrYwGg+n3vF6QeYP7SdFwpiYr0czT3d4cVuLr9/2tcABVx9/CoTYk7DI0sPj
    xIClW8hI9xo96u7tIEPO5HH3bLXuVgYU1btcPUP2SGooSqOafFXC6KxuCd4A
X-ME-Proxy: <xmx:Xnspau80viwIGFTe1kY7NYMF8-7q-Ey5W1AlIm_Jlyc_-Cgd2xQs5w>
    <xmx:XnspanrBpehLTGjFFbax7HU4G2g_NzfQbLu1dklaMvNoPTQlkM_njg>
    <xmx:Xnspal_odsBPtUbw-RVbilfksWMPD2ulCu15rqz8GrhY-P8Lpz7rQQ>
    <xmx:XnspajX9jjwtMIfjKOMM_iv2ue8AkP1ycHHJYFRi-DuybN2SPSCAMw>
    <xmx:XnspavkQND-qVJnHdL8xaXcDQV8KBvnTXGCgfGljw6XLnz07zw4_VOBk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80381252 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:11 +0200
Subject: [PATCH 5/9] chdir-notify: drop unused `chdir_notify_reparent()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-5-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the preceding commit we've removed all callers of
`chdir_notify_reparent()`, so the function is unused now. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 chdir-notify.c | 26 --------------------------
 chdir-notify.h |  6 +-----
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/chdir-notify.c b/chdir-notify.c
index f8bfe3cbef..1237a45e2e 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -43,32 +43,6 @@ void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 	}
 }
 
-static void reparent_cb(const char *name,
-			const char *old_cwd,
-			const char *new_cwd,
-			void *data)
-{
-	char **path = data;
-	char *tmp = *path;
-
-	if (!tmp)
-		return;
-
-	*path = reparent_relative_path(old_cwd, new_cwd, tmp);
-	free(tmp);
-
-	if (name) {
-		trace_printf_key(&trace_setup_key,
-				 "setup: reparent %s to '%s'",
-				 name, *path);
-	}
-}
-
-void chdir_notify_reparent(const char *name, char **path)
-{
-	chdir_notify_register(name, reparent_cb, path);
-}
-
 int chdir_notify(const char *new_cwd)
 {
 	struct strbuf old_cwd = STRBUF_INIT;
diff --git a/chdir-notify.h b/chdir-notify.h
index 81eb69d846..36b4114472 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -19,10 +19,7 @@
  *   chdir_notify_register("description", foo, data);
  *
  * In practice most callers will want to move a relative path to the new root;
- * they can use the reparent_relative_path() helper for that. If that's all
- * you're doing, you can also use the convenience function:
- *
- *   chdir_notify_reparent("description", &my_path);
+ * they can use the reparent_relative_path() helper for that.
  *
  * Whenever a chdir event occurs, that will update my_path (if it's relative)
  * to adjust for the new cwd by freeing any existing string and allocating a
@@ -43,7 +40,6 @@ typedef void (*chdir_notify_callback)(const char *name,
 void chdir_notify_register(const char *name, chdir_notify_callback cb, void *data);
 void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 			     void *data);
-void chdir_notify_reparent(const char *name, char **path);
 
 /*
  *

-- 
2.54.0.1189.g8c84645362.dirty

