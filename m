Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298014A4F14
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161690; cv=none; b=j0McnFaA8vCr/y4BL+o3UIpedoF5f6qYovtWdKE2+SJaZyM5M92q7VOaJsPstTXM5e77IAN03iXiPeUbdTMZY9r5Umth9T16glD4J2v/O0ji+2xi69qij6RTJcIvobZj+iXLGCl/lAZtp10hmsUT9pGIWl1fmMKFO4wpOk9P/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161690; c=relaxed/simple;
	bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYoxmqIoPpsWcz2VRVilevkTmTCsRwLQk8RCo7K3he/eglBdtwVb5yW/1FAoIzyp+Fv2JDYgIJ36Qh0sNQoWIPcy+PpjUcz7k8WdLkVa7JKtIgmBlMrabPPZ92o3THN9XEkPqiRCiVW61jYRzG4UjODbp+5Qat058O0iK7WkirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMb81cko; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMb81cko"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso152562f8f.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789161687; x=1789766487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=cMb81ckovdsRt2yGMQBtOKKsZ/Q9Rit6DvhsvD/koFMKb6CgIyTbDg5W+ZcUqGj76y
         WX/YDLulVeYDWGysxWL3zwaVcmQwQB+nF7Dvl/3SSiwlO2lw+85T87ec2Ss5rbvbi1ik
         taiZUZXTc3b7bzwmnWNfKL9tituS/s3cW99W9vzpggQIOjDQoa7cwKComG6+ubahHbog
         2C5hKLmnj8rVPrRh+xh6J0LJqyR24Wx4qyJYkluBH0WL8fWiHNARIbNXQtOT2Gd6LC8c
         g4e8g3B3/pqT/NTD5O2g1n8DVAunR+hIPRDdR7NOXMz/sG1C+lAG5ZHPhOqnGxpo58Pu
         e8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161687; x=1789766487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=p3A5TjDV7cGNjF1QijAZ8Z9ii9KUTgP5Cepk+5iof+yqrw7698y1giltVcNkOb1qLN
         J0WK4uoxTl6wgSt5yTbu7OoD92k2ZyiSPKikXJ8x3SWWlsz2YiOHwq39ZqvIeao5ljqQ
         a6KEGaOpEblylLAgj+Gbm7xyqKhhL/g/nVgMv+aAESJgagLxZ9H5VPQpPIBeF66tiuYC
         gQLkgBIwgXdNH4msXILgyTXzp5plDptmtG6a29oFyojqZjZ6BL7gI/mK+BH4rhC6OwCs
         ai0q6fKr+/QYFn8oCS+agq6n+SMmty1EBX9IPB33SKsgte3eXDte4enfypwM/8nr819F
         xnRg==
X-Gm-Message-State: AFuF++kvf4pg3LzC8aPa9djcBl/Gr2YxRSqNSjRoBzr6y6XSD8fA+UDP
	q/LTgjDzQ+T2sOXMpjI2EEai73YfQLFjjEGQhPP6xSVc029WIrBmci7hbP4emQ==
X-Gm-Gg: AYBFou3UQ57Gs/vuLPEJQd+kGOYmII4tS9SJjYJbFFJSGpiabS03zkkevNQHhpw/TU+
	3B5jPiiuhnm77ptSST5uvjDcEmwYKmgou5NW/WWL3c0pajk/7hW+BvZZjsH1MZwGLIZ61a4MyHq
	h8ZqfZEzSqBje2llz+9v4aRHMHlfGmY/685Qlxtqb6OBwI+RPVYYLQYZT+mubh/Du89vexAUU1p
	bMUK06gfLnfiTbwkFM2Z4LVVEE5EFcZ8aMtnDxmbw053Cynj1AhuwsAgM9Hxe8JNRXvEbkNyy2Y
	RuOiju5cIoxlNiu7kc8TffRERgV8EXYZn8dJsDFZTnqmZjE88b3bnAZRRNbR+JavZrx2mQsGX/l
	kkg177whgM8wSYf/v1kuA5mChJlTx40v+0NJi6DkyjWMi+QykoK6+pxe7/gXrDu3w4Q/bUkBqz8
	I6xLmYL1q8t6NxxAqZqE71/anNUPIxjqdsWbsZA37YP+Xo9c4tx7gStB5DqncztfclGAc/DeDwp
	h46/i/Wxzwojj1R60sABoJ3fXUicgcTaqgWSA==
X-Received: by 2002:a05:6000:2086:b0:486:f46c:682a with SMTP id ffacd0b85a97d-486f46c68demr5643804f8f.0.1789161687233;
        Fri, 11 Sep 2026 14:21:27 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:3cb1:ed0d:e325:5fc9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm9435939f8f.2.2026.09.11.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:21:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 10 Sep 2026 23:54:06 +0200
Subject: [PATCH v10 1/4] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-758-introduce-hook-v10-1-06f9c506631c@gmail.com>
References: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
In-Reply-To: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqkcM51+WOrfNfRTYrXDXwHNub/PUe40Btaz
 lQ8SoiQJ7M6uokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqpHDOAAoJED7VnySO
 Rox/b8ML/jHZHQvfBDQjAk4GLltHHZYIVbVqdlFJaZnURLguhGlWhlFO65WpX10vG6Y6ERYSpFv
 qeowEBNS7o/S8WJcCz5w3i4/0C/UPgetsADuKMPOBNKg7Ie0FHCt+dyxOsP5+jyDmD7XVDlT9dQ
 AzBMX5nJg2oI6LjjnFY9tGYhEj/TLRdGgGkfsMG8x473LGym089LV2ZC8A9qEq3hbinmNz9fIyS
 XtfkEEpp+02+9LFq++vTAt2h2XXFrD+bJAK1Q7c/UPhUkAjYpyDmINDi+3kijixTX3Tdsm0XQ2F
 mTvEbaHAXgV2SAiPOE/HPues3lmV7Xy9Q9J4mlj055dgQpQ4kp5eQSbqWOGH7OMGbSg1+yoDSLl
 A9EUbYjkPP7KtGqumAZJ2y3+Oob2U7mmLirT+IM5pfHElUa8sBiWeXSFs1/b/XNw2Yf9tTi6HHx
 mob0pdYTAxf+gxKHPIotJTu0m5Kdna26q0Z6rL/SHzOS1Sjvoz8xskQKlCszcuqGGOZy+wPmp+4
 gU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The manpage of git-receive-pack(1) documents hooks invoked when
receiving a push. The manpage does not mention the 'proc-receive' hook
though, which is also invoked as part of that process. Add a paragraph
about this hook to plug that gap.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..5806792ba7 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,14 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

