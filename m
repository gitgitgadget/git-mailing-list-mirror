Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FD225A3B
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767496126; cv=none; b=Xv2xbTTrCk5FcONUE/9h1Eg0YxKuc9lkJA3fU3v+7QA0XFwfUKvDo2LWaOjEGpJp3PLbZ2MoWQnE/eISev1Wx1x8cq14/ns6+JsRo8F/vCChFXuTHZKIjJlV8h0clul7rwxTGbLl2eICxHi+1rU16zzFOmE0T9VAr5+J4eBofmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767496126; c=relaxed/simple;
	bh=Qhm5C2jFt36lRHSBnG3Sdnv+LbyUsA4uUrHKE3zK9r0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=s+bvd3wGo1fj7QOSDDx72rnPaYVuMHI+w5FyvggCBFID8Pogw1ZMrqgOglCoybkJ4d1jWkGvW2jy6mAi5J1YkvF47oYIzJYo4b4kFWv0b9sBDg7QuCfW5N8NgSfT2yRt7pN6sPt7hGLZCSKdvYjTNa/Dq3NLuM/vomfU+oHuIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSVhS6ui; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSVhS6ui"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45392215f74so4542503b6e.3
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 19:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767496124; x=1768100924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6H7Esj2bFpZMO2OHNn3xV58vk0Xsn8FOFT8B49xSemY=;
        b=DSVhS6uihKWjb89KpNGpDIhdhNTh7flIkps9F7eX17/C4Cip0ZGtjqKXm/vJW+b3/U
         sVGSvc57NXPwpt5w7Vnr2ZjCGjUrmauvsbcxJo0IIQ2KAl/j2N2+hmfR6V0vBk/AQyXv
         FBhPDiMP/xyUBCDD4gdk8Rzc3Nn7avIIt/pTJaPrWSt8IR54R2DEHaiUNk4rhPdFs6Vm
         6Qetmr4fQob6vfb4qgC3zflF4kr2B3Y2NTIvGSm+1J8eifXCPCzgDGv29Dh+cjy7a+Ph
         BxLOAbfZeQcmN/jCXks+uQvXqYYAErrH5FxczGIzVX1J6ZJYCfRgASrxru3WxYsHeyIw
         MVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767496124; x=1768100924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H7Esj2bFpZMO2OHNn3xV58vk0Xsn8FOFT8B49xSemY=;
        b=nFxmJx7zwbOAzrviWCns30/7Nke3GhIat2ojUeZPKNoVF0nuWTTdvtNhPLyvik+RhO
         /KvNo6m86sSpgsifuzoFQKSmFqppctx5QGUbs0TLSPNhaMKFfCE2SwNlfsDXL1TDE83s
         zyeFj8SGPxi7ZYQXRjBrzlvUofkcEKaNbwaLWw43g3ST2NRqw7AFgXIb1Ebrfc1eAuFm
         +vD96b9RqASttJqROt251TMsHCiooCeXi6Wigo/B26VPskWGCJDt/+1tLY9ZGyY4Dabd
         gbJUzJnAgOdADTLloY9QAXBGyC7lfPAJ2hQbfYbYlNjHeYXnCXxZ1EwAHhUdGWR3cS4u
         0YAA==
X-Gm-Message-State: AOJu0YyDX4sarw5Ocz70n/SB8sFdX7vKj7JUgwhe+j/3oiPQgBU54Zvx
	RzA0cebc5BG5QU5UpjiA9KLVk7uQwoKrS8FCSYGl5MEKOqMdGZK0372IGGIJCw==
X-Gm-Gg: AY/fxX74jciJma1g3Te/Yxm9FR5mem+beXJaqvdGdX8K/wix62tt+2z4dOjIyhi2eZF
	rGHUBh16W4t/x//8vVg8nlI9OOMZPqPLgSjMLsHXmxM2GcpzAcvHdL+pzHmB/95PTyO5pmrtHix
	BmlpJRlILvnk+55mv+TsGsKSZE1gNdO9CW9E+IJ4vWSifKfXyXOuAqQ+e7DWca9HZcP6WxY//sA
	wEbR0UKZJXEoKxpZyyv+Slv22xFbZiubMjpSt6wDcfrAcVGd8+HvjQzcy0orWkem0A1OlsoVo0M
	xQ35wSS1gNfV/HYSPcCUcKiL2UwK9v3jTAQlJBefn9bYe6o/TZ3uDCT6a3AtNKIHZyE7BYA17V/
	TjiNZ9wpLOFHim8Zfb8ylFWkDJb0f1DiNtGqdg5xBm53nNWDQxlQZhS2kPP3sTYQ9tMu/zlW15q
	RBsPp2LnbY7grMNQ==
X-Google-Smtp-Source: AGHT+IEGcaV9h3uP/xorwf0ONjuzNYc0XUtllKMYHmCq9sG/1eAFjwByoNLOCMvCqpvRbbYmEhZWGw==
X-Received: by 2002:a05:6830:4492:b0:7ca:c842:fe0 with SMTP id 46e09a7af769-7cc668e94b4mr30152484a34.8.1767496123722;
        Sat, 03 Jan 2026 19:08:43 -0800 (PST)
Received: from [127.0.0.1] ([52.173.237.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66727e37sm31602062a34.1.2026.01.03.19.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 19:08:42 -0800 (PST)
Message-Id: <pull.2154.git.git.1767496120852.gitgitgadget@gmail.com>
From: "Heath =?UTF-8?Q?Dutton=F0=9F=95=B4=EF=B8=8F?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 03:08:40 +0000
Subject: [PATCH] doc: define timestamp in pack protocol grammar
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: jrnieder@gmail.com,
    Heath =?UTF-8?Q?Dutton=F0=9F=95=B4=EF=B8=8F?= <heathdutton@gmail.com>,
    =?UTF-8?q?Heath=20Dutton=F0=9F=95=B4=EF=B8=8F?=
 <heathdutton@gmail.com>

From: =?UTF-8?q?Heath=20Dutton=F0=9F=95=B4=EF=B8=8F?=
 <heathdutton@gmail.com>

The grammar for depth-request uses 'timestamp' but never defines it,
unlike 'depth' which is properly defined as '1*DIGIT'. Add the missing
definition.

Signed-off-by: Heath Dutton <heathdutton@gmail.com>
---
    doc: define timestamp in pack protocol grammar
    
    Fixes https://git.issues.gerritcodereview.com/issues/40000018

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2154%2Fheathdutton%2Fhd%2Fdoc-protocol-timestamp-40000018-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2154/heathdutton/hd/doc-protocol-timestamp-40000018-v1
Pull-Request: https://github.com/git/git/pull/2154

 Documentation/gitprotocol-pack.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index 837b691c89..7ad63322c2 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -273,6 +273,7 @@ out of what the server said it could do with the first 'want' line.
   additional-want   =  PKT-LINE("want" SP obj-id)
 
   depth             =  1*DIGIT
+  timestamp         =  1*DIGIT
 
   filter-request    =  PKT-LINE("filter" SP filter-spec)
 ----

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
