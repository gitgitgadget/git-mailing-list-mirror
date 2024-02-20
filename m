Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597E152E1A
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468381; cv=none; b=Skc/hRoAkcLHGPzYlCGbG/h7a2Uie1+AtOVjUdEc4qWb3KDSJyWRAohVRKzfyqh8Ypux9547ndKU9eNnXbk2G8aoJXPtnotuG7gx7kokS0TTBJdKqihCLCtxnH/QtJdl7FEMxVfgtwSYKGIOR1RCSJ4M1I+O+S6D7Z5vIuc9ekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468381; c=relaxed/simple;
	bh=GPmdI8GQMksJtN9xAj1hvq0qQ63UuCruXdkE1a6IYBo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=UxQD/FFdeGx7tECr0VNn+MSOt/JRj10fhRa8wTC/zkYIl43KFopQPkWXDtO5n67tAH7DYfIZ4qbAGK5ryrWuj1eh9+q6EqhH/jGOOTCTLsWqEn/c8KjgRpe5XpTsjqj9M9IlRraAxN/H1fDG0mzs6FGw8Gqs14LfvpBpsZkG7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTfHhl5N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTfHhl5N"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412730e5b95so2814445e9.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 14:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468377; x=1709073177; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVpYuck5ebn459P5ZI15PfJlppvDRSpec4FEGrkFBdg=;
        b=kTfHhl5NcrPuEXS2pVrnlDlQ1NFxCTJn28X/g9u+NFVNqUIGTd4QHx1ASi5IQIsboT
         uO1goPh+d7SRwE05LqfGBQBb7KhO0pcR1M3xRusQOjAIG1Wyq2kJQHucsvNqCcaGEtcx
         H8tdAx7rU9Vx5Z6hf2is2c0jPRRJmx3VVaG+hXld/YTxJ9eTGTbp1NPOX4FpwJ0KSzh6
         9Ju+s/45eROnUqN0G4cxcMFKVfyr0TKm33IuGu4ePQ9dD6PQqqBjAprFoUC8szwucB+Q
         su/j4iNSEHgti7cZE5qrp8NAKo20Vbl0dUFI+nWbxPS9OnwBPcqhEWU0Udy2ySNoiVeL
         iqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468377; x=1709073177;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVpYuck5ebn459P5ZI15PfJlppvDRSpec4FEGrkFBdg=;
        b=crvH4WBVqUDuTjLiY2W4K4DLH4TClezynmpXewc/EC9yeQQ1FTW5Tq4tRApFs8lSqT
         lI3k0s69eG02uK6ba0FvSRciJXN4QMntGx0RC46xw65xkYainhduUwZp619kV//EIuUC
         DlCmdoQqcSBeojEWp/UWGgT0jvuTgHepEq//cEOxbHWQaDPygJwDn8wyGD0+HkTlOHZx
         AjhhBwn6Ljq+04X8oGwVqobFt6+/i/Nop7QMTNhBEMBpfy1YEQ1H/wQXqxUc8JGG0mT7
         8Wn9czsW5T3fxpZgLNooRCv4qWgY8sTIpvmLADadwEIECRH8RBWzzHGkldVkR6RAu5iR
         nVaQ==
X-Gm-Message-State: AOJu0YwXz+F9qn14Vy9qrL6darkrliaCdim2ludX8Ql1xswSgOSxSoYi
	a9kWjJIjZVo5WtYPG3Jg7fLV3c/EDt8kAQZu1DAHf/nqYWl9HAScqKI8l3mo
X-Google-Smtp-Source: AGHT+IGSVtQ+tYi7DaIt/mo6APtzwE+GW9VrINEuI147tPVxasU79vKaa+/9uVAlYOkjsCAQ4VpgLw==
X-Received: by 2002:a05:600c:548b:b0:412:5890:60e6 with SMTP id iv11-20020a05600c548b00b00412589060e6mr6433198wmb.4.1708468377109;
        Tue, 20 Feb 2024 14:32:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00411fb769583sm16138979wmq.27.2024.02.20.14.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:32:56 -0800 (PST)
Message-ID: <7d85bfe6c5511d3918dd84365249797abe6fa04b.1708468374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 22:32:53 +0000
Subject: [PATCH 2/3] doc: git-clone fix missing placeholder end carret
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6e43eb9c205..0c07720c6f4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -311,7 +311,7 @@ or `--mirror` is given)
 	The result is Git repository can be separated from working
 	tree.
 
---ref-format=<ref-format::
+--ref-format=<ref-format>::
 
 Specify the given ref storage format for the repository. The valid values are:
 +
-- 
gitgitgadget

