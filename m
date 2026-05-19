Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF5DDC5
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153544; cv=none; b=a1a4j8ujul5f/2MlxN3j+NAImV9qbn5XLSgveVcOLrdR92CBx+NamhUz9JwQUZAuxwxn/0Qyvj7xIofTQTY8lwIrvyD9RnSVCTo9c2+V8awtzLskcVxu0f9BW2831t9WM070nQkXUsq3tRhF6XZQnq23TGcgp0UJ51l/lyYYnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153544; c=relaxed/simple;
	bh=gCo55Aj3MbTWAD+hA0tL0+mQNRTTxv7t9hazLauR5Nk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e85e6OHMAzTMTsbgOfivdAGBr7i26lz7i/DLV59c8fcHJGWunUXG6idfppaVSZR/kDa53dMd3IEZPfz9Nb69AqdqROK542QMYlcpHUTY3nDXMuAnZ2GbDZZd4Cqs+dOY1QInFt8LhvXub04Gbt+IEYc689kMq9C8oXUg9Ookobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q0IKtR//; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q0IKtR//"
Received: (qmail 15817 invoked by uid 106); 19 May 2026 01:19:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gCo55Aj3MbTWAD+hA0tL0+mQNRTTxv7t9hazLauR5Nk=; b=Q0IKtR//j3QGT7ZkUeOnBThVOV1D8MVTrbrebA7NQg5mzUiwBUf/dtI2WB2b1tDuwyhQipMYg1aoMbgsGBxkkQbawFDdHB4lcTSfueEmZAQhi/M0bpVXwVDrpJczpx5l+iDCVVLtk38ttqhFX1GeAvuPcMeV/k7vLdpKCJ2/zaNXi9iBBRzpYvFSTNIEVPhqfpoMtKDx2/zZuKXKDXfNhD3lGKhuJmxa48bPyp42uwBi6thmB8aNMwQ9HMqxQkJZPuw4RL/+qSww3lamftvHpqIv9lokQ7T3XfAjuurwaEQFFsFNXbRnkOs+6jhuV53f3/phabzwrnZuwNIkxN6iBg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 01:19:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38813 invoked by uid 111); 19 May 2026 01:19:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 21:19:05 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 21:19:01 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/3] quote.h: bump strvec forward declaration to the top
Message-ID: <20260519011901.GA1615870@coredump.intra.peff.net>
References: <20260519011837.GA1615637@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519011837.GA1615637@coredump.intra.peff.net>

We usually put forward declarations at the top of header files, rather
than next to the functions that need them. In theory placing it next to
the function has some explanatory value, but it's also just as likely to
become stale if other uses are added.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/quote.h b/quote.h
index 0300c29104..400397b11a 100644
--- a/quote.h
+++ b/quote.h
@@ -2,6 +2,7 @@
 #define QUOTE_H
 
 struct strbuf;
+struct strvec;
 
 extern int quote_path_fully;
 
@@ -77,7 +78,6 @@ int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
  * still modify arg in place, but unlike sq_dequote_to_argv, the strvec
  * will duplicate and take ownership of the strings.
  */
-struct strvec;
 int sq_dequote_to_strvec(char *arg, struct strvec *);
 
 int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
-- 
2.54.0.524.g198262df96

