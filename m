Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744D2135C5
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112143; cv=none; b=ct95LUejVuWZ4zeEinRoOZQzCI38xa/Nl0mJ2VOsNcKmGbycyP8002ptzEBIYGMk7To9ctgrUGNeHNGAUcle4GgIy4J0BB0F6spe0qgyGbnkn07EMXz4fcNNpgjV5EAVcG0O7HSVWoWmtAxL519y1G44BwTck9uhqaYyjESUiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112143; c=relaxed/simple;
	bh=P8bEe4k31DojEMIkrewL/0T/EVIbvUWmdOX163zcB1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDR26CKaGJsNuzqP2qnNlmIJsUZ+XMkBFCVkvxomQEPIAEin0cxrydtR4C7Q2VlcrtWrMiYbjyid16Yri0rMIEOc+iAurBY/JjOD6QlYur/rSxSWjWMFmtc7cbAUyCy/LhTMR7q3Iq3MWJW7TWUNcp7G4ypF1oDFVeW1GLTQY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EE79qQU9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EE79qQU9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccae46de39so3178445ad.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785112141; x=1785716941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxVUoZgz56ty5P/bzHnUwvhXnvU/r+nVhUiVG/abaR4=;
        b=EE79qQU98POP34EH4JbH6XbkXuZs95wjL7Fjq9GWGW0mZFkrr/GJUZOtsd1QTTdK4d
         q8A8YgHcOnyweFYpaPK3yeRMWn7aa1AtHJOiUBeEYdn+1JSha6je5G33EALaXe1f1xEF
         gCtKFuNnffyILTi9mw/A8MYlWNKhnkEg5+pmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112141; x=1785716941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxVUoZgz56ty5P/bzHnUwvhXnvU/r+nVhUiVG/abaR4=;
        b=Jvlt7gBisdBLUpQ2bVXFVbgFmPg8e8eAKoUCQjTZ8AC/LLySHLu+yGBMNn11h5rjAi
         N3heTB29BOYRcvF0li+E3DKSQKgjxv931TTAGK7Q+LU1FX0dVqjFKoDAiGfPD067/rr6
         LgU1+W+hdBNYpkyg0h1eQGqnz5P5h6R8wi4wNAyuHByDIkqxRDr2xy3qwoZr1oloftA6
         ss4m32KWRmfcxZkq6MKFBTa4wA7jki2KQEYqCKI/JoZDEjlczxZVCjE0tBIX/xKjQn/H
         RinA0YkEPAm3wet3uONIp2+MwgfOG7ai7TGC9HO4PlTTknvFNNRGzGt2i+0dyUg+CTnD
         pXwA==
X-Gm-Message-State: AOJu0YxKj2eUBeKjbbjItJY6HsZJg1EMxLs0mORIifQsIeld4K7KFrTX
	LnyMPsjk/y8uitZJ32RyrWvKcQZxb2GceSaM64AKWX1t59lzTWlpcnT0GjdVBxcq0Jn2gQrTslp
	KtHcNIOw=
X-Gm-Gg: AR+sD13Ndqj9qV9oL7hOvQOaIjwu5m0dgM4hfgimgehC5C8rq0qRqXHq2t2hLH0ygA3
	4C+o5hux8SYlrTlG404pwLCMGLvnFTDd3faVm7GspMQ+S74GGlMgeGM3WVI7cnCKuBYX5q9PnST
	cxDWcFiyXsYBf5O43h9uAJDwMpKrvdY8CkWLEpz2NU6GqKFxWNEtVVCk9XBrmyQhH/IlU9l17jA
	+GJKjPIgXasNTXLOObviZn2i1xkue2cgah7YQloWkiWP7w3Ohwvod/14mbBzuptmHxEDpUQdzWk
	9z4AbdpgHPb1tgkohFZwRpJ4UEfvbupZgAOcA6Erb8eA/nkIEA4st86DgUuZnZmfL3voQ6sR4nV
	40S+I12752q+bJ8X/RojUsdFmoqbFyH0aq+rcgk+cBnQG2XT7SBftV/lRYjko7TP448qFAFQlzF
	Mq50Twet8sy3wKK2iO+Q9iENo1s+5wYu6BNCFKU9g0CT6EI7+r5pDo/dI47/QSFksdmj6Hc34vS
	oKw7hs=
X-Received: by 2002:a17:90b:56c4:b0:38e:91a8:fb85 with SMTP id 98e67ed59e1d1-38f2961bf3bmr4531747a91.3.1785112141333;
        Sun, 26 Jul 2026 17:29:01 -0700 (PDT)
Received: from com-76773.corp.openai.org ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm19920328c88.8.2026.07.26.17.28.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 17:29:00 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v6 2/6] http: avoid closing index-pack input twice
Date: Sun, 26 Jul 2026 17:28:39 -0700
Message-ID: <28662b0fd892ecf6246be185ccb2d4654fb780a5.1785111375.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785111375.git.tnyman@openai.com>
References: <cover.1785047139.git.tnyman@openai.com> <cover.1785111375.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

finish_http_pack_request() passes its staging-file descriptor to
index-pack through child_process.in. start_command() takes ownership
of a supplied descriptor and closes it, even when starting the child
fails.

Do not close the descriptor again after run_command() returns.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 http.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/http.c b/http.c
index caccf2108e..89a1ccc6d2 100644
--- a/http.c
+++ b/http.c
@@ -2704,13 +2704,8 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	else
 		ip.no_stdout = 1;
 
-	if (run_command(&ip)) {
+	if (run_command(&ip))
 		ret = -1;
-		goto cleanup;
-	}
-
-cleanup:
-	close(tmpfile_fd);
 	unlink(preq->tmpfile.buf);
 	return ret;
 }
-- 
2.55.0.openai.131.g83a728de1eb6

