Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97F32ABE1
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679046; cv=none; b=SrDTQJiI9SIlW7GHRalowDms8wfjd9NVB0iBqqy11pGThzUCdH/8TkHdeHgD3kzureGwnZXA63/wsBGyO2BDhzJi2Y2gMSRDSuyK62JcUoq2R99g0cuaplGCcZ/RVsHPu5gQRDSnuF1ECeklzuAk0lzLmPSUBOi4ETR9eoo+isE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679046; c=relaxed/simple;
	bh=MbGcfwHVdL4dzsJOXlKYouv6kq5fRZ6SZ2wIwk+JCyQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VN2+Za0fdDWFTXq+TMWED213y1oFCb6kQW/7MmME7Q2xRx4K8QU7DIFNyeiKf7D8fIvKFb5k2B2t7LnsVpbFZQKa3vFY9FsOtv343P12mwj97yf77q7YEcyrnvUp4e/oos17VQDG10GBHTLHeDBfMy5C+iZRF+tKPdU61x/CHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhDqRxKL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhDqRxKL"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5036d7d14easo43759751cf.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770679043; x=1771283843; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G4q4rL17wtR++d+Q8UtgqD30XNkcy1XttO7HKUB/sA=;
        b=RhDqRxKLnRz+A9//bw4W4/njow8tsETWYIFxNTfhorbt5j8ZwLU06IcfjQOQJrIbfE
         E4XFQ7n1ydJJCV6Bkkvus2z+k6UBUnjSriRlDLQgdnlSqLjedX8k+CwU6+tErkL+Gh9u
         CL8IKhQwPqW/Lq0ZRmhhOPYxChopcwk/NjhAodJl7KMuZWiXmMEM3RpLBl9SGxwxuBPE
         KdbLqySvs890o3dP1UdxawIUMM47/AZ80/erBroxuwpx5Iv/aDWriSnZ1XlaadMEjoqr
         JAUqxCbEkSz02eVmJXripdwTfXAqPvuEcaBkzhYFwoe3zsIqLqJe0NaPkRpIdOITW8Al
         Ztgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679043; x=1771283843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9G4q4rL17wtR++d+Q8UtgqD30XNkcy1XttO7HKUB/sA=;
        b=UYHyWXArWvz0DQkLXq/AHxXVche24xiJj64ZLGJcFfwEUvHTJyxL+1ZK5rsLtT25qy
         +lzk/4D48uTwM8n5o7Zu7uDYlfIuNRTwZQdaKmFh89OmNmIlFsAkUl/0S9hgK56nylsY
         xMHWO4eQHprhY/Zzk33AGDtDCOu8d+Qx7rlEpDyI5KuUU06Qy8/LLdz8bqNdbaRvdgm/
         nhkuHTZlaWPS0kg90nO3n2yWOPMqvea/CK/fQsmh64gmWZwQlAgFwdumE8B7HCgHt+5I
         1GDR8j20yS9Z7BNkVBKO9tCkDDG4XHXUlvzYa+Epmx/TZSH34V3dZ7I2QP0lakCOw7DP
         Y6fQ==
X-Gm-Message-State: AOJu0YwMdvd+ove9Z49ypS54oSij9ZdI5YOe77JvK69gd0VR+5aLKFb2
	Wj7f7fUSJC63EKNRYtbVOIQj6ubVSBdosLCaOmwX4nLLBCB12+dv3okqa7/lZg==
X-Gm-Gg: AZuq6aIF7MAhHHyTWOTGm+gjEHTR1JenUHS1IaEFsCaz3GvC7ZNabX1UK4KG+lgcVed
	GdtNKXm/Tc5YQUMNEMSC0+DgNhmQ70i3qdJ1aGYpvo0pb8GLTQsbcJsfKKCJvHSKLYr/jXGpuA2
	FW8PO3e+5gBxAXbqY/q4VYSzpbVKdcOH8uHHtF/1Sz6i0DDc+/3Xn06HePcZvJIuZukI4TEvkvv
	nZ8UGLuTW/8Xyf8btxU7I7ucM0tgfcH66teexGLhWWP7gPrL0pHSogkJqgA6ljz5q0/LEk1V5Q+
	wQlKEqPO2uYoQTy5v7+BEwN7OaJ6QUWj3Q+hkOh706Mm+edpBPYE64f2mLE9BEGjwx2458ZUPnz
	bpjPCE5t4oIBZQVP4BAqGCqZzxgPCZA1vUj2BbEa5jt68Jg3ZuZfbg4KCYwAtsgqI1jmtnJMZo3
	Hup+aUzCn1by7LG7tEen1cNSTt
X-Received: by 2002:ac8:5dc6:0:b0:4ed:ddd9:1402 with SMTP id d75a77b69052e-506398a1d62mr188676331cf.24.1770679043568;
        Mon, 09 Feb 2026 15:17:23 -0800 (PST)
Received: from [127.0.0.1] ([64.236.200.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5064e7825d9sm57958981cf.23.2026.02.09.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:17:23 -0800 (PST)
Message-Id: <bec6b10d500794365581905be41980e53d1f264a.1770679038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 23:17:15 +0000
Subject: [PATCH 2/5] gitweb: prevent project search bar from overflowing on
 mobile
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

On narrow screens, the project search input can exceed the available width
and force page-wide horizontal scrolling.

Add side padding to the search container and cap the input to its container
width with border-box sizing, so the form stays within the viewport.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 48d2e51015..1fe120cd95 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -537,6 +537,13 @@ div.search {
 div.projsearch {
 	text-align: center;
 	margin: 20px 0px;
+	padding: 0 8px;
+	box-sizing: border-box;
+}
+
+div.projsearch input[type="text"] {
+	max-width: 100%;
+	box-sizing: border-box;
 }
 
 div.projsearch form {
-- 
gitgitgadget

