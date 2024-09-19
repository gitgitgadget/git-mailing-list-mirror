Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA22745D
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770888; cv=none; b=e9YSzhK/Def/JSlQM3AGo8g6mPZvY0HL9waSZ4+YJ4A2YxnEx12swnWN4ALyGSO4+lyUweTafumX76DWl0VVFSjeUdnjJgiQNoRHk/+q045zmIXa2gMQGXApO12f6TtZWjZ1fuA9tsj839sWb/gc9dvuB7KSA0xgIbOT7bcDu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770888; c=relaxed/simple;
	bh=JH6y/w3gRf2bym3a/old8rWguuuCWoM514JAu8c2Ucg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eAzJTuyTqjMqelmBmPi+lif20RnUNeTS8zXKfY9E1LrULk5GAFrQYAgJoKuWPadZ2nrBz4U76p4mAbIJ4D7g3ohNeBKEPGx7xv2gJwq0Eq5mkGvMfSVkB6jAyzUro6myPKzq0G0KlA0uoAAlgcJBgwJmim/Cbpo8YSbuVRpXx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNFnkXY5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNFnkXY5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so1662446a12.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770885; x=1727375685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fYISSZBmZWdrmJpdVrW3J2jpLTOaMfkItsZgxl9KtE=;
        b=UNFnkXY50WT7YnS06ODghkVqnV2ztzjn9np7TmDWyVTxB8PSskzknuV+UJo6fbV/aC
         MSXlxgclXcdinCWivXcBIHe0sx1vcM0iXKlBxsy/baIdOQ2n5jDRoDTRXheGmxDk6ua8
         +LEpacl/CWmHbh1A0kHLDNq++FgQfJTyaFh1nQ7Zy8ju1YeOZo6KXk58gB6Leu6Hj4wW
         9InuFtgn6c9LX5Ug0iPXB2u7r4LUNwOYIiVnGHccpjYJYYWAm9setIyy/8wTaWnMgE18
         YC8sL2Q++Q26IvDMWISaogcfB2xTiML1BYDdKBz2McGs4ugzSApF0dja9/km+u3yFJQl
         7fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770885; x=1727375685;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fYISSZBmZWdrmJpdVrW3J2jpLTOaMfkItsZgxl9KtE=;
        b=u4x2WshHtmLMucvTcVOpgli9+1/I44foErCyc4cHDXZNB9UrENKRexHa0q755Doz7U
         nJ67J8QV0pUd5SDus2unm8plpL23DBWbkILzlDVe57E88bi5g4agj2TSxVM5yleyZ2I+
         gaYtorhPDBJ0WEJ8jiW4cqoTsuVRqXuLHgTznUV8z6AOB3S+ZiTWl4draYyC8jzlP6BB
         DDdRqxPoN/zjHAWrnpoL178cSxLXf5onmKZa/gknFi8VV2NQpw78fIqEB2RPPr/lM7D2
         cOEbfUGFjvZX5f+wHDnMLGohSkHH7/lhzKLlnE8F24+Amd0eysbhm2oCWonqXvYCRDZI
         Jy1A==
X-Gm-Message-State: AOJu0Ywu8hzlaP+0Nrjyep6ZWLV36jewK8fNz1SCaN4/Dwzw+6MnE5Wo
	pHO0YAZOrClYr5hU8gy3RP1fjFTx8WQYmA+We2vWj+JkMaog2W/CgM9mJA==
X-Google-Smtp-Source: AGHT+IFDNqK7IcuN8s6rPwnaMah6SVqpRChVkMC0b48DKdKcWYr0AVEyKdSxaD2/OjRfnF0ogonn2Q==
X-Received: by 2002:a05:6402:e06:b0:5c0:c10c:7c1d with SMTP id 4fb4d7f45d1cf-5c464a587bdmr115433a12.23.1726770885181;
        Thu, 19 Sep 2024 11:34:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb8a218sm6342742a12.62.2024.09.19.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:44 -0700 (PDT)
Message-Id: <9056dc6773d77422ab7b7f044275c500dc5327b9.1726770880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:23 +0000
Subject: [PATCH 03/20] fsmonitor-settings: fix a typo
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
 fsmonitor-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index e818583420a..a6587a8972b 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -7,7 +7,7 @@
 #include "fsmonitor-path-utils.h"
 
 /*
- * We keep this structure defintion private and have getters
+ * We keep this structure definition private and have getters
  * for all fields so that we can lazy load it as needed.
  */
 struct fsmonitor_settings {
-- 
gitgitgadget

