Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016137179
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842947; cv=none; b=B7mXXCki9gYMJfjyqb02Mm+xw5aRvLASBFB/9S46Edr4kDIyUxxp4PP+z2QGkWodzpw6NI3ijY275HefNAAj/MSDFyF0vCx2kyD95BmdfHoH1aZAfjtmAV4xVQyHFBwa+SmNuBgvb6CcOfVz9yk5I+WXNLOM8aUHXr3Tw/5R1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842947; c=relaxed/simple;
	bh=8mP5ZeO2XE4oNIaM9n6ADLDfJX4CmdtXPQVo35MR/uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEksxnniB6GPJXfCLMZ9f4VpXXb4Yna7Fb1dqSF37wrdPc2YIPasU49lbdj3gTMxAKruu3k6Bl0niyHewn1nruWYxLTfJL2ByKRBtWTh7Yf5ubEsqTJ7HyxBREBMi1rWg2KNbC7QKWFvCnFTywdp1owfQy0n6bZevfJssFv2KPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V26T2Vhu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V26T2Vhu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dbdbddc180so274150b3a.2
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 05:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705842945; x=1706447745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDf09HtepJJO4llaPqDFOSwRIGq0nxfm5RqIR+biF70=;
        b=V26T2Vhuw8/0X+52BqeOsofexBaIJcsMwud8U86zP2h5hkDFQqhkYpdWk5QKFd6KTF
         8o0bMTZytfBL9vtawrZiyMqHqL+52mxE2V5WLeeX7qIECX22Zi2BWF8/ljodF1n6CZ0T
         T7aMqwj7IrWe1iC6MviR0ObkMT0DcGJOtNQmxO9WEUtdlVzrHLbJteBMJ3HXDEh8TLua
         u/wahyKzhcx9viT1YqRr0+W4GPq3hXqtkCf/xu0IJzItAC0f2Mw6WZVtVamLvycuzJ08
         OOOADCOhuQuXuieYW9Y8QH6FsHuouwZ5SPjpcWAjJONIfogjnNB87w0F9PX7hz9mo6sW
         oD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705842945; x=1706447745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDf09HtepJJO4llaPqDFOSwRIGq0nxfm5RqIR+biF70=;
        b=b1lFs+H7/HOzU07bzY393QHaLBE9UVo9yzsMqluvGqeXdzHzYJ5X0amOVH+eWIicaE
         3u/J6osJXAmfj2Q9BDaw6f14dHzo78nFrkafIJ3VAnDKplZklHAb8x6H68yFVnf5uGDg
         nAJvhO4WlYCSIfJv7nTUNRd9WZmvCf/5A72K0JRNkR9DRiXHsPtsbmCUT8L/Nx6kkuxz
         DGdRsrHwKxAT2Pao1eBG4e4Hob05TW5RqcO6iBM0zj3wpI4lCkd0b2wXUnLJenfEcJRu
         rW9mTFJNb3XmnczPG/6pkgu80TXBlYEL52shMl90JSDQnvNQtMBYQSq7/G9bKiwfycFu
         4sMg==
X-Gm-Message-State: AOJu0YyCTf6kw+J19UkrdhVswvAA1stj7GWqYcI3O/wqSy8QjsJfVdNG
	g+EhWAn9ZlHE+PAx+Al8zK2ou71e1Lr5hESbehEiqmJQNYkhPmDN2CZq14wh
X-Google-Smtp-Source: AGHT+IGh91ZPVQIwbZ46UJgx7OSKKZ3Q85sjrEYFEDPnbTiEyHs/snClIrKZbdadqnvbKKvizzUbew==
X-Received: by 2002:a05:6a20:6594:b0:199:87dc:4f0a with SMTP id p20-20020a056a20659400b0019987dc4f0amr2938663pzh.95.1705842945000;
        Sun, 21 Jan 2024 05:15:45 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm6619005pgc.29.2024.01.21.05.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 05:15:44 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 3/6] transport-helper: protocol v2 supports upload-archive
Date: Sun, 21 Jan 2024 21:15:35 +0800
Message-Id: <e7f63482606c23e31f9a26fd890dd28c1952a599.1705841443.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We used to support only git-upload-pack service for protocol v2. In
order to support remote archive over HTTP/HTTPS protocols, add new
service support for git-upload-archive in protocol v2.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 2e127d24a5..6fe9f4f208 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -628,7 +628,8 @@ static int process_connect_service(struct transport *transport,
 		ret = run_connect(transport, &cmdbuf);
 	} else if (data->stateless_connect &&
 		   (get_protocol_version_config() == protocol_v2) &&
-		   !strcmp("git-upload-pack", name)) {
+		   (!strcmp("git-upload-pack", name) ||
+		    !strcmp("git-upload-archive", name))) {
 		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
 		if (ret)
-- 
2.43.0

