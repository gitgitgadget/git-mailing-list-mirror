Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976E317701
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679048; cv=none; b=Mo0NzlASBEJkBI6T0/az283rwTxtChnikqOJIbfo8Nxr7PCh+BxATUqAwf/CRqWT9w+Tv1BLdSzBNFr+TAzOw6o8flTqbTq0Bv805ZytMzjyrQmTLwLEGJWuyP/dqL8dEjuTFoEtepGlyjU1C9Fvuxs5Sz0IqHoDuYXErSHw8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679048; c=relaxed/simple;
	bh=ndr3xHkqBez4kwxy2WSQ4O1om0sSEiT0h6WNvdJMcPY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C/JACPSSeOIdhuWgywlxske1WTZl+NK845keN91EbRHeeWDH3paWzcQX3tPDsEhVShlcH1BB9CdaQ0QwEa3+93CiZJf83uz2HjdNO6Rc3PBZeLNHMqGu+8M9uc/Z2HrW5fM5l/a8dzP6faYdSe6QKOAI+FDXmXVVl2xu0CyNToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP492F2U; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP492F2U"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8954c181830so29300496d6.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770679046; x=1771283846; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9rI8igKX+WZoEeKkUIonFKMmUgzHFdeD4LVEzLlsbU=;
        b=QP492F2UNfNzOQKDAGpe4ZWHFszrljmz0RobSOC2oabR2anPPiOySWjZSV48JCiuxa
         PK6m34s1JPO8RiPXIydVVTmKXTq5mRekNONW1RfW3beUWEEh8GmrxpxgJQ+p14ssFYEK
         D30oBCRTCh83GXofqqr5BTazAW0mi9PjDZRQg6ma3rEtFKxZPiHXYZku7N8IVYs1atFT
         5RfW4P3YZVocZu2iiq79ubs4F8gdMqVXEr2Jm45hYcXew6pgD5VrYf1Ixm94E7EX0o2V
         ZKqhltamYbp16evDV/DXavNopoyQBFV+krQus24b9rDwe6OjkrN81JYUkUvbgIIdUaUK
         lbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679046; x=1771283846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9rI8igKX+WZoEeKkUIonFKMmUgzHFdeD4LVEzLlsbU=;
        b=WNQ8cM7ziVgDVtP7U3I77lr5NT+LqQP4lT2kSah7WwDqFLKR957XrNFxYX4lRF5mxJ
         NAB5A+1MSNVScVHr8nKE1hYE5mh792Q2mlc/FFzlyNQtp9vRqkTjqYY+A1VJ9ceygLh1
         ZFIn9+am9wJj4UF3HpSx7ZJpLVEITcJKxAo33cRNF4KDTQlPuyZVxXAKmMsGxmbGl4nq
         omxPnkE9WTyiDQbRc79LG9W14AiBCFh8KG+3Owa7e6zZt1TBF+EN0eyHrevIi6kBAyMe
         qJnvn0h4NxsNiDhFxb+fzuaLLhIyI+UbU+L8lCgYr2nc34844OL5R0BNRVqEZqkMDFbH
         bwSQ==
X-Gm-Message-State: AOJu0YyHl+/a/S1NX6PtliLm43YfIp9+xj1YPlq3wlf897wPVK3yXQLz
	BiHhBgG2IJQ9pnAm3HgtDi45v/9hPSJOiSVkehCkCT3k+U70KBdsA2NWvzVVeQ==
X-Gm-Gg: AZuq6aLircOrkt81VNgDZ+KlejUKBYDoN2pyza/ruqMzZu82BV8eKa9oOJygbW4CkkT
	EOKeIs0Qkx6En0lHJebZfdpKq/aI8R+dBtpS3UDmoQH2O7i0oqABZgQKwH+IfTYXAJq/c9wwXcJ
	QBXTEw0VJw9Vk36PtPJGVCxFGUiF437kxAyF8Nxv+G9WsWjiSJqyyvc5DhgFW/T1R+Z5kC9KsUI
	zMea58G8ZHIS4HbGCtAycux5ksDG/HYK4S1ldOjigwdB8XkWkZJ3Gk43lh4pxXU0pYLQLE69E/D
	14dxvPghS+NAPp5Y8GqHgTaLJRZZHhHMhCm3eQ3lHnPxa//7nZkq/98iVOM+RW2q6IRkT+GmNyb
	OOR0t57TpGHTRe7tlEOUQjBlimsk2x0++5zh+dShg6VYEw0KOUkIH2aMc6VkOVbv3s5a2b5XxU8
	sNH9PN2ibn2opvgWYVuRN99Kzd
X-Received: by 2002:a05:6214:406:b0:894:6cb6:b270 with SMTP id 6a1803df08f44-8953cb81279mr196898636d6.45.1770679046033;
        Mon, 09 Feb 2026 15:17:26 -0800 (PST)
Received: from [127.0.0.1] ([64.236.200.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89651161382sm53678666d6.51.2026.02.09.15.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:17:25 -0800 (PST)
Message-Id: <87cfeb81fe0016bd401b7223ba274d8f59e0a65e.1770679038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 23:17:17 +0000
Subject: [PATCH 4/5] gitweb: fix mobile footer overflow by wrapping text and
 clearing floats
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
Cc: Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

On narrow screens, footer text can wrap, but the fixed 22px footer height
and floated footer blocks can cause overflow.

Switch to min-height and add a clearfix on the footer container so it grows
to contain wrapped float content cleanly.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 135590b64c..8247646063 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -73,11 +73,17 @@ div.page_path {
 }
 
 div.page_footer {
-	height: 22px;
+	min-height: 22px;
 	padding: 4px 8px;
 	background-color: #d9d8d1;
 }
 
+div.page_footer::after {
+	content: "";
+	display: table;
+	clear: both;
+}
+
 div.page_footer_text {
 	line-height: 22px;
 	float: left;
-- 
gitgitgadget

