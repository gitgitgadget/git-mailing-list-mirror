Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6421E98E3
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220680; cv=none; b=bGNyIn7xzPM/+CIFugGhqhzsIL7UyLg/dHr1iumAeAHLDt9evL2cvBN7V6G2FL8O5P1gKBIPsgK6dk/+ZpS7lCSmOsfV2rajrBF+0ycRCqmOj9V5hdDu/d3jqox7YUTTVCPd3OtbKixYOYRibdJb0lTTA12pjQ4C28vwBOOEk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220680; c=relaxed/simple;
	bh=Q3h/HqBqLECUx24qTN9s/nPgvlGzN/rM7+vxgDoFxk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M2WWTyDuJRfIz3DLjX68ApckGtRhPzkFqVy62oezot1TqWxs5xRck9NYXgqJXavOYhrBN1FV/G6GwpSlFcTwRR53rYR8ZrGQMJ0Y2X+nnQ/paO4+WMd+0cHJ/v2yq1KuN7Z5ec8Q59LevMehlxb5FioazW/qm67qnKuCjgkZdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQzvFd37; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQzvFd37"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47798089d30so5016425e9.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765220676; x=1765825476; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSJqd6eotKeNjylTBXvCl2ZhMX1hDkXwoZTqC+x8m0U=;
        b=BQzvFd37OLa+hQeRECfIpA5xO65xbLof/4ZqXI5Hx0oTqQYo2jsDThEw7/SPf9Y3i+
         c4qDcKUJmtcwiCYZYt2lbRYYaQCzs1W/hCh9PtJA7odMnku9bjUmvrpiHsce0ItKpAkn
         EBmi86uk1/eeqd0FHaY+UniQTOjCxngKCYLQ9fDevYL1GaoKJY8PcwbWoGdNtd+COPim
         5utSqnsULuybrJwYOXEg0fv4LhE0dOGCRdKAZo9ra1+4n7dTFirEc5QrU1DeSzWQ4LTr
         gaXlcWdpw7EYfkLCO6Md7OeSa9szac1OmUzFM671ldYKA1EM49XWiIWa7FlVVZ3rCt0d
         RIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765220676; x=1765825476;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSJqd6eotKeNjylTBXvCl2ZhMX1hDkXwoZTqC+x8m0U=;
        b=aiu47+ZC8XvlSqoTHg/44HF0pqO5n3U4BY0TLY6hQe2yZu4UcN4EE9vSyNXCG2JlWy
         M9Q8At0FcsdqSxn4hvJ8d0Er4uu1BHI74q1fE5ZiCH0KEvhoBfa8B3tStGgr7uZ430iC
         OAnN/z6OAsLn51RCUcnud70admggiTKnC83Eetlxz0nJGLumkrguwTa2dZn3ahYoEP34
         qn40+HxwkvR9veZB0JOs/4qd5gb3KG2fnVR3611UHDFsfLp+hcYh9c8mMLsgzPjSR71f
         DUUa6WnfWUn8+3++3aXc7uXxfr5fJkw97EduGCgvR7Xl8plbrQCjx+T6b2yV6plfgbEI
         Ma2g==
X-Gm-Message-State: AOJu0YzOeo1sXkZcAqntlgl5ugpsHBj+gv3g9j5lF+DVWzqe2dvwUK4C
	eCNePaS60ar7EN4NS0jjQT5FpyyIvNpgJr9V1tb3G0V3lKh1BfTmUffAFjrdHfJc5IE=
X-Gm-Gg: ASbGncvkmPleqp5nrxEK5pRi8ZCYs34FYDIX/oZhiGOiErafleEEvh//HkFgUzAPcq+
	30ZkzO86yJ+v8qaPxl1PfepVEXrMOpituSryfcBp5Ml1NDIFACS7irgMATXhkZoahH/53cOk6YO
	H7ToeFj2HfsBGBMzT6gMwjyGeWMwumW2NYDkZ2gMB3Tes2MPlaKr4gVbMUmwyp8efm7XPdPZ7PV
	RAqaEnBhGlmUUTKRMcI/9o13aeaXBMudwu3jkVqxWYBr5RIMyBgJipwr1MyRFpooK0Md6mAghBt
	arQkkvfy1rdSdYUbPb+ZQnnkt4Gq95DNDE97Qoj8xP1tI49KxOCe4Hvn3mpGpTbiT60t73HQcKm
	anFLkEDE/9cQJUCoW9lFJQNhUnewQU51MvrXQJ3bLeQz8MfIVhVQdR8/XYm1qgxTG5v33ILGNHX
	tfE1Jj02qBJATf1A==
X-Google-Smtp-Source: AGHT+IHoKEg81mIMxKKg9KeMhQ0AKgprFIFJc2vu9TRk7Uyi0+7RGv/N9/fnYGc7Mu7oMBmlA75oQA==
X-Received: by 2002:a05:600c:524a:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-47939e4609dmr51718815e9.6.1765220676340;
        Mon, 08 Dec 2025 11:04:36 -0800 (PST)
Received: from desktop ([194.127.199.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe8a7bsm27215710f8f.4.2025.12.08.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:04:36 -0800 (PST)
Date: Mon, 8 Dec 2025 19:04:35 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [PATCH] config: document 'gui.GCWarning'
Message-ID: <20251208190400.64920-1-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While investigating the config options set by 'scalar' I noticed this
one wasn't documented.

Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
---
 Documentation/config/gui.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config/gui.adoc b/Documentation/config/gui.adoc
index 171be774d2..1565c0af19 100644
--- a/Documentation/config/gui.adoc
+++ b/Documentation/config/gui.adoc
@@ -55,3 +55,8 @@ gui.blamehistoryctx::
 	linkgit:gitk[1] for the selected commit, when the `Show History
 	Context` menu item is invoked from 'git gui blame'. If this
 	variable is set to zero, the whole history is shown.
+
+gui.GCWarning::
+	Determines whether linkgit:git-gui[1] should prompt for garbage
+	collection when git detects a large number of loose objects in
+	the repository. The default value is "true".
-- 
2.52.0

