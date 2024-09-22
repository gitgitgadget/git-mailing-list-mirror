Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B30632
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012449; cv=none; b=EJ8c50BlLsGPJTLKC6PDa2AK0nbesIx3oy1iBEkMjszykZcZE92XvM9PBGJjoXUBi1Z8hW0JUUSI25XKge9upm7xdcpOFBEfllN7rkDdi/JSVSgp9PZ2Cfd8igP6RtRrGRjJDZd+J02xsZmRJWulGaI+ClYPR9hkeUDOaUoD0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012449; c=relaxed/simple;
	bh=zWtHFu1b2Wijk+OFXllYES1SuO7+BPgAerwg12ErQgs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fIZmJBI7+ca09WhsZX4XkqOXKCPrSe7BxAy1P1G6tCG/MWa4dX+dzC0agYoZhHP8x+WQHzd/GUK5fR089lz/jjTzE7dFQ/lBmJjBKp72fSyxhehrRrTxL/JBhiIVG/Hpeywx1+dtpPXDeT3NrN7PfRA/I7i/m0XHmWnxuIjmu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=qLO8vlIU; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qLO8vlIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727012443; x=1727617243; i=l.s.r@web.de;
	bh=40sBYCYjtTBMgGg1LSbLAqi7AQ1TxCAjOu82PT3zUWA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qLO8vlIUWYyinPGRFGZDf/ZV2YE2CFUPi4+9FTTR2cKJ8zuWmWPApZljmCFjq4TW
	 774/KkUZLU5CJObBFdBV2ILdTTHJ54mriAw67Yev9qTelKIsmvm06gUjGfjysgUKY
	 LpssKb0UTvkUNp/zz2NU+ug0zSk1U0VnT28wpNfkbqQIx04JxTyuduvOLvR2pxV0z
	 6dBpc8BHAF+u1ymsR5ulvu+MsCo7+S1eVCc9P4Qma4IDFnRwZRNwguEsa93LjefP+
	 GD2ud4JVbwTZoaaoOCqdAfk0+2JDWbcOUDiMXxgos8KJF6Eq6hZGcm+BIr+5HQuip
	 +M6SF0LpdB0KdGBsDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.77]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ell-1srVsU1TB7-00ASHf; Sun, 22
 Sep 2024 15:40:43 +0200
Message-ID: <c3a712d5-8e50-453d-be90-f5bf34de744c@web.de>
Date: Sun, 22 Sep 2024 15:40:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Derrick Stolee <stolee@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit-graph: remove unnecessary UNLEAK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zgt6wXIuPTo0gjDomYbqHny5YVFxIqm520aTWMk+onAKHYDiKyn
 mM9nm9rhEEBDz0A1fYlyBLoYm8wQZ74MfMS0xJEuAeSdAOpmhybyCVYtmks+mwLHwlI1JXi
 QE9bnzHQNB2oQP7vxl4/zrwAevSP/4EccfX0QC5zIm2hOrvobpF6HmLMJN0rIf+7NWuYxi8
 +9i3MlgXrJg0QrRGOLqcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dAa22x6bAd4=;a48xDmowvgqcmTvZ6BPUehRJN5M
 1e6n83adLl+VM/dcNMRgHNK+hfbMTafAUvrlsZ+Ks/TigfXTYVksLdbBqdRT2OSFFWxdP1+LB
 aYt7T7WQY/yfCdzZ7U7mL7GWFMET5V32C/Nn5Ci4jbt87Ing7uowMr0Hl4Gb2NnsSzFL1SH18
 WNCx3srqXRKkSC0SIVhIbE5Ou+tmhQgUYYeeJ3DqPhGWXzPv2ILh3uNEqBQx4/G+CJva78LdR
 E4EHn/yKqMoJGIUD7mVDRmG+50RC+Ee4mm+ILCeYScWN9d9obECCCXQlAp6ySGOnFh7XnN9IJ
 fDY4bOCU1J19mRpBRfCSRQMT8IKuLPIgmBFGj3989zFERs7wS7ZxD5MJ59aIMw6xqQQrMk2mc
 HV5wK+iPFG5fA+/ScEKxNpixBBdzKPGToxPyaI3tMpkzD+T8ZFGS+79ES8KiS9Hc3Foe/sDO3
 iBHRbBAvYPSIiLCP6O55POI4Avqv0gnXDtFg9MOKUNlkvWYwqgJOYCCv0DAtzkR46S0zBpW6L
 mCIT9evu2j8kARFCeJtalTrf6EaapyByURZpNkt5G2V6TsCOztF11Z3bl/iLqCZviyU102aly
 Ec7mUUNvIRDdPdlUxxL1hDgeUXCYKiRXKOiL/46AV/eeWiEF4MDRylwor5HkB0euWQARPveI2
 VXuHd5r4wFVpQVxFySMW6+jzcSPUxXm2GRyCRLmE6PTDGFIj26JTyFXPWoJQQeudj1DCM92sx
 DvDjfSUGKbh6dT29vvN3uETf2yZPz7JqUmH7fYrGwAVYzKc94wTBEfbSRFLOZwOHiwNoypK1/
 +LFoaLYgRE5FTqJUzdspJoWA==

When f4dbdfc4d5 (commit-graph: clean up leaked memory during write,
2018-10-03) added the UNLEAK, it was right before a call to die_errno().
e103f7276f (commit-graph: return with errors during write, 2019-06-12)
made it unnecessary, as it was then followed by a free() call for the
allocated string.

The code moved to write_commit_graph_file() in the meantime and the
string pointer is now part of a struct, but the function's only caller
still cleans up the allocation.  Drop the superfluous UNLEAK.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-graph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index aa6e08eb39..5bd89c0acd 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -2055,7 +2055,6 @@ static int write_commit_graph_file(struct write_comm=
it_graph_context *ctx)
 	}

 	if (safe_create_leading_directories(ctx->graph_name)) {
-		UNLEAK(ctx->graph_name);
 		error(_("unable to create leading directories of %s"),
 			ctx->graph_name);
 		return -1;
=2D-
2.46.0
