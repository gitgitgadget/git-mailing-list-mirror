Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598059167
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770898; cv=none; b=BO2ESSQHr+pCxUjEf/xdB8aODjqOYRq43+ETQSFBouEeQdSAjIG7C//IGMywi3J+PViBLXIlDpWvFBqxvJjb9zoruIM7tE0h1IYI/zt9ES1Tv02loBhmdymWrcw9vUk3Tbhk2YL0E2LpKptxc48wZFI86rnPq8rq82ekV2Imn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770898; c=relaxed/simple;
	bh=+RrlaqN7wAGB6mdqjLNMV4gfNLLSJVJiHHQpAtd+hrg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L+Vf9rh6GnNyRnLWb+U13ZoDpBmyXafVo3pwuHXiNaQUhKv1YPITF0PvyT1WQv8bfkoI9yqYdfD5HH7QfuXZyAxEk9Y8eXpUeSt7Q1ECA/HbTe/ywK0/zFh1sxpWywC6Z4nauV2952R+8TVp/7O3Ut8RdYMVOBIOX69Yu1AHqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4cvWIpR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4cvWIpR"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso1987726a12.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770895; x=1727375695; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMFKHaWZ/HVaM35SWCUoM0/Sczw0540yPd7r+ymSUrk=;
        b=D4cvWIpR93AgHlEVykUfk8Sh9Il4tjS349OnhxmGrg/0sJeUXe6GJgYIPuDUa4Gr/V
         RxTczb3ZFnjx2rDf6Il9QjGu6vWrP4e28V1pCBMmUG0M7M4Kufo9SAVXBvCqlkcBDiit
         wzEVmfHqGGfLewbod9ebMtHO3cC6P/ugg3qTAi+Z9qukNnHsklvOQLRpKlzz+DxPL6k5
         Ocq+9qyFAjeJBhIQ7+ezavGVKOJEyVLrdiD3Wp72H+y7wBHeGKQp3X/hVeguvr8cOTUm
         PrKi0IWjVklZeXRz224rFPf+gID2dhiuzNj5kLeh0pDBO04GZ5Jaz7f341op6dO8x9du
         dTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770895; x=1727375695;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMFKHaWZ/HVaM35SWCUoM0/Sczw0540yPd7r+ymSUrk=;
        b=Chl7WLuqT782sgtyZZNZU1Fxj1KWgcdN3TAdwld1r490we723Ze6aHXSAUMECXbOW6
         1LpqvDEgA5j0FV85kMYlHOcxqaU7mEC+jo6J2++uLda8Hz/V1RxIjtuoleJ9DyTA2/N4
         KG6LOepQfG/dr077xKJzIoLhZCndYzmeISGbAKRS61scEzuC1hTYoRCPIituiRNAwvIf
         Jy4ZypH8TZ3Ri/ybk65KeL9wRn+04qiNmJGQbtjfYlgZCApOZv1VWCf2nbxUpsCcJ4pz
         F1WZCPiN6k1KucCiJQOIX/W5i3QHqEw44aqzVKO1WVAX0OY5biiW9Y9HvsQV1tNr0F6Q
         Wsow==
X-Gm-Message-State: AOJu0Yz0mnQTo8Sp7yjsBIlI/XqPAFLaf0yBNJlSxiDR6PUUwH9M0WFW
	DBgUvXQ7BaILd5mixvX8C+sJM7/ftiaRig7BQWc97CxG+F+T3c957N68mQ==
X-Google-Smtp-Source: AGHT+IG8TlE1IG717MKcDkBcmieaFtm9oHznz6lB7Jr9GClBXNe0yhjFYa0aIsuyeUA0yo+nBWp/uw==
X-Received: by 2002:a05:6402:4342:b0:5c4:20fc:7b39 with SMTP id 4fb4d7f45d1cf-5c4592208fdmr4281199a12.9.1726770894669;
        Thu, 19 Sep 2024 11:34:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb4959dsm6361379a12.6.2024.09.19.11.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:54 -0700 (PDT)
Message-Id: <2fb8ed2f4a963c8aea366948fb315d1cff4d4d0b.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:32 +0000
Subject: [PATCH 12/20] read-cache-ll: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 read-cache-ll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index e0e39607ef3..b5d11d07a86 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -151,7 +151,7 @@ enum sparse_index_mode {
 
 	/*
 	 * The index has already been collapsed to sparse directories
-	 * whereever possible.
+	 * wherever possible.
 	 */
 	INDEX_COLLAPSED,
 
-- 
gitgitgadget

