Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091A383C63
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567678; cv=none; b=QWyf+fzuB5nIxX4UiZP7/ffQTxeyprPqxX1Jyx1IbBUt5BPBMLyaPWDgxG2j8ASGvITs54pcEm43UMv1RzSEosZcBnrHaZW1v2Xg7Pi+pbQvtVQRS9P5uA3TmJcU1ImVgEFSlcNVBeMWV512ln2TFPE6zFQYHJlch6HWv20w3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567678; c=relaxed/simple;
	bh=WF3dz+iauiP5tk13RvG+ekwY2IsrPvTK7NsnVugdb3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kI/eD9lGfGJh1Vb26XTS6vea92mJ6wx+dX8DTIELKie80+LbwPuv4TGng7FqsSBaBIpQUcP24uvmmMSa3sCP9xZduzWY05Ax/3xElkwdq5y46isltooVE/zpN9B4CfD8Av/b+C4WwgzkV1pwROkwnd4izPGdGKUZgbG3BPmu21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qrog0qhn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QN6WceCH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qrog0qhn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QN6WceCH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 71D2DEC01B5;
	Thu,  4 Jun 2026 06:07:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 06:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567674;
	 x=1780654074; bh=ar0DSp9nUAoLCWG+Y4b0YWGyqcsMnxlWvpYqcVM4ZRc=; b=
	qrog0qhnevkNLJI/T2p16iddZo/A9XI13mBXz5MnFxNEVCupOV+7Yv5DXBctkFzm
	vGgiayEZT7H5uTYqTFSSEeb4ZJuMpIYBf3czCpN3aGCB6AQSbiWhRQQpmhGJOMTe
	jKGRNESGLRvdAuBFGZcN1SFtldl4fG6UYG1X+0sxNhgMASzqqfQHjqVqTbalyBJL
	cgViJDUqBPw5mq/d+yVddvOqcO1KH62vArqE0/5eWzdaHCAjd7iSsTP/HCF2iE50
	GIXNGdEygDIEak129rhm3bgFGApxLuL0RZjChpDJJpWZISr37iNwpFqS/pJabEq+
	L1pz0Sxvbir8uiHdPMQaKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567674; x=
	1780654074; bh=ar0DSp9nUAoLCWG+Y4b0YWGyqcsMnxlWvpYqcVM4ZRc=; b=Q
	N6WceCHmybYvzxmfaN05BN8L1Q9pbN96DfNmr0Tq4womewpAFk2GiqEnjDev1Ips
	CkDI2Dk0oAK/Ba5Yye8bziWaCW0AnYNm5B0wTj8Ntoiq8Esav7ixERFA7VQJ0XGZ
	5Cu0lDnmEN7cSgLAo++EEOYYPEqHCaHfTZzjOTS2hvF4juEy0HGVomIbxfeGzL68
	WQDlyLRAUHIqIXBKeV+4hIFgVMqZctDjsnnadddmcX2Ftso5fXzy5IQfcCe/kc3s
	lb8o9KqIfMZurZZSUWAsiuK4jrdACfI8LuX1Z++7yTzq195wzag4QpsdituE9hwS
	yUMiDN1+RreIsE/t4QWrw==
X-ME-Sender: <xms:ek4havNkTJBErDpX-vAgoJZCxq1PqKmrKMV9R_qUGw5Cu_RGjO0tZQ>
    <xme:ek4hahZFD4-YJ3udy8KpqRArELiHYaVNWnF8AKEEVZLWrYzEy9ggjrN_dDOoTiysJ
    rLbMkfKRKtChUiKY0pY7zkg0OQH1O7k6xBdV4HL5XKAkePJoXyX>
X-ME-Received: <xmr:ek4haro2WJpSERvs7BueEmiXFqTfZwTHiQiT6vosg7ZbQ4DC9M6ZLqP8dK4yKMe36yK0nMc8mTQu8jy1XKB7SOlLs2IsW9ImrT324llkbYk>
X-ME-Proxy-Cause: dmFkZTGMbu7/w/ZaywpulTbV6q029k+4CRvBefE38zDB+oDDpe7/ZuzFboKkGddDMpC6H8
    Q65cMH2hqNVIApiwywAi1d3oCMuupua5C6XrHnnITffKfmMRVwTdI5GHkudmJ7ZKEZrrYX
    CKOmv9t1NwRbtoOICGlQGTcGJ1FFYgaEdOYRqLfZqhIlP1ZWNMKv3dVVS2jOfp6CH85ck+
    X+GJZjSuAt4gnXgZR2jlgA8pvi0autxCCmFsaQ4hwO4cz1AmajGgQcBQ3nWLBS5d6EXh4c
    RYSw2h7nb13kcCW4tZMqTZU+tBdbJ81eaW33xVcSzp0LPE+7+IuXs8Di5knqCnrNht8gcc
    sXFm7xl/JRe38IjUC48jsM2bPh3OTcDFDCQ4JsLvKkGHQM6NrKa0i9YnMlmvCXgqX8r+sJ
    q9aTzuX31C+tmUZQ850tLytRPhXm4Q9KmBibeb8nSrKsPeXq9L4ijSOm71u4iWYDCEo/j6
    TfhqyCwv5XdNtwTnCoGRkcji5smzXEg/L1q92EkZ1IMxBn6B9NkEhYV3OMhkL9mpALWdrA
    ZrDfb6Fxp06XEEHePnTfPvMqYOSYZuswSrbowM8wS4oku4BOALcxOqhmjAKLPMFxq8i8c0
    lhoPIVGKBVhJWx0SGI0mReqq0LB70W8lcaKZyRwTaIbgyrpGWejr4+Ntqh5g
X-ME-Proxy: <xmx:ek4hatbs_KDSBFB3ea8r8mAPqTz0jk6WkutQrpzxP0VMnLZQtdLDDg>
    <xmx:ek4harSWIhzmiiBpAqWu6yKvzsebpmQmwonf8am9K8BCrAR2UeRGWg>
    <xmx:ek4has5joR76GACHkEC6RN-GjRLLZZN1kxTlSPRTnMZC2rOg8YH6Lg>
    <xmx:ek4haoycHR6ne_FjTDdDwxZIs6Rq-n6ZgelyCnftwjqfE4mjwKMmiA>
    <xmx:ek4haiL10HyDahrGgMm6fBkt24U0ElQFwhE-tapfnE7W-LlDqGQdPLLp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3fd5447f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:37 +0200
Subject: [PATCH v3 7/8] t/lib-git-p4: silence output when killing p4d and
 its watchdog
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-7-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

When stopping the p4d watchdog process via "kill -9", the shell may
print a job-control notification like:

  ./test-lib.sh: line 1269: 57960 Killed: 9               while true; do
      if test $nr_tries_left -eq 0; then
          kill -9 $p4d_pid; exit 1;
      fi; sleep 1; nr_tries_left=$(($nr_tries_left - 1));
  done 2> /dev/null 4>&2  (wd: ~)

This message is printed asynchronously by the shell when it reaps the
process. While harmless right now, this will cause breakage once we
enable strict parsing of the TAP protocol in a subsequent commit.

Fix this by using `wait` so that we can synchronously reap the watchdog
process and swallow the diagnostic.

While at it, deduplicate the logic we have in `stop_p4d_and_watchdog ()`
and `stop_and_cleanup_p4d ()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-p4.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index d22e9c684a..9108868187 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -65,6 +65,7 @@ pidfile="$TRASH_DIRECTORY/p4d.pid"
 
 stop_p4d_and_watchdog () {
 	kill -9 $p4d_pid $watchdog_pid
+	wait $p4d_pid $watchdog_pid 2>/dev/null
 }
 
 # git p4 submit generates a temp file, which will
@@ -174,8 +175,7 @@ retry_until_success () {
 }
 
 stop_and_cleanup_p4d () {
-	kill -9 $p4d_pid $watchdog_pid
-	wait $p4d_pid
+	stop_p4d_and_watchdog
 	rm -rf "$db" "$cli" "$pidfile"
 }
 

-- 
2.54.0.1064.gd145956f57.dirty

