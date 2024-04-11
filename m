Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D6013E88A
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822229; cv=none; b=kfGGw0TF2IHT3RAzAkeEG1TK1AjIRYM5LCeo/uZliIOJZj0HNmxLtJEqLGjZPL1MQZ2hm7pOFBLwipDky2ypBri39NVx4v1MYBOoLPLSCRCqz1jynSQBKlbil6Ga4G+jJaAlzceP7f1YqX76HxzbFv9zl3yc3Ygaz+D2qzuesg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822229; c=relaxed/simple;
	bh=otWVU7psCiCfnYmmMxrrV+2sfDdzt3rE+KjvHc5uTLU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=tfuJWmaYHbcNCq0i8CEXjICIbPoHMhbhWJl8cGJXqNdZDESimGw+T1PlCGDF25HgzvWMjDYrDmT0ccqIvH86QyYtw8YrG3/sNeyUCO4v2qYE49mAxHCPo0h5te9GnynLypBk3bp7x4prHkxVK8j9RdRGSIbXvfNZw4GuwKtRWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiohFG1n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiohFG1n"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343e096965bso4152823f8f.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712822225; x=1713427025; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROSsNgEyFWkIbbSwOLysoF3FzobNYqRXJlDC3CNBtGU=;
        b=DiohFG1nq37YYwItPi6OU5NJ5nvouQisyyZUV5xewOq5yc4mepwI3W1UOM0bJzlD+Y
         zneGdUQx/UBZkcH/6yQY0uJiCqgTQTK7bw1p4/HdOaIJIMbJo3vpKpt2DW6Sc5iAhn5f
         StTJCNND3gUq+/pXSnKM9S9W9APLhzmaHouP4C/iiwNMVZXaWBLTO/thSRJS2JFt8+VN
         RjFvr8jlRjYPB0xXRurRFMj+UTAZ6hxzgrc9oOwekJ7RVVBf6awFHQjj6jTyCjVdE0ED
         m9R+2d/lYyygVGFOgNTyWcnrHA3t0x8iOInuI+u/QQvmVDp4t648XGS6NXJz4n4B/0xW
         cdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712822225; x=1713427025;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROSsNgEyFWkIbbSwOLysoF3FzobNYqRXJlDC3CNBtGU=;
        b=trgGAFe5bjdZCldFqnEx6qmRZBgLWumz4MgufoGEMEj6kezOLykYm31ucNYW75lqnF
         CfdRwhXa9o/SI9Mf9CD9Hd/s8pFjIFRLKGfElIRyLbOUmvwfSsf7nVW9aGf8BHwS8K0t
         D6t9nIF7HMK3iPdf351YVs9Q+mR1LGLpzHCb5NQNIit5XzqnJ0VuWKlYCYhWNoL3bLBZ
         p2G4XhV82QBOttROkGZcZrBoNeVchQ0oSHqPByQXDdab4hyToUi6SZIUXEmoHLnjH91R
         RZfw2r1Ea1cNpbQ0FzTYm7xY5GdXLI5Uu3IpQ+H/+xO9d4l79RP5SwhEI5DF49h/7slf
         +WNA==
X-Gm-Message-State: AOJu0YwAUUprsau4mb37+BeaSEwADfGcTazbSuHVkmKRDAzr9kzP94Te
	rCTMRra3Y6zqi++XjRrU91GsmP+jHNYzTVupu2oCaxngWpLv6IHFK0EopQ==
X-Google-Smtp-Source: AGHT+IFQlB7JRyB8nNLzPKdlIBmkInVBtsYhFzpQ68LlmF2VGR/WLdbiTGoL/3oY8w/b9+lwB1+YWA==
X-Received: by 2002:a5d:6c65:0:b0:343:e152:4c43 with SMTP id r5-20020a5d6c65000000b00343e1524c43mr4651583wrz.2.1712822225005;
        Thu, 11 Apr 2024 00:57:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dp4-20020a0560000c8400b00343ca138924sm1137843wrb.39.2024.04.11.00.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:57:04 -0700 (PDT)
Message-Id: <af548abd00485e161c2e409b0b9fa80a3a061cc8.1712822221.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
	<pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
From: "=?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 07:57:01 +0000
Subject: [PATCH v2 2/2] doc: git.txt-Change "--user-formats" to
 "--user-interfaces"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?= <ttdlyu@163.com>,
    =?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 <ttdlyu@163.com>

From: =?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 <ttdlyu@163.com>

Signed-off-by: 秃头灯笼鱼 <ttdlyu@163.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index eee277495bd..2bd4b9f06ca 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -342,7 +342,7 @@ Repository, command and file interfaces
 ---------------------------------------
 
 This documentation discusses repository and command interfaces which
-users are expected to interact with directly. See `--user-formats` in
+users are expected to interact with directly. See `--user-interfaces` in
 linkgit:git-help[1] for more details on the criteria.
 
 include::cmds-userinterfaces.txt[]
-- 
gitgitgadget
