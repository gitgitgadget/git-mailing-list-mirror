Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB8136320
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770902; cv=none; b=aZ1FmDxf9iRqECdzXcWRPHQGuNy2kqwy9Jtxx9Szyk0ezf2bTSrxu+AosP0ttFyJ6uizYxcDF333er/mNa9h58fpO9WfbL+T/l6+sWMZkJI5baeXtMDaxeT00+gPSZFnM6Lon8lOskQ21TupGlOfCLLX7rpTFTE/TAcuHoImTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770902; c=relaxed/simple;
	bh=22RpsFk/csJ1DtOsU2AjKY/YLqYodDBik+AhGrthers=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q92onHzHm+0QpJaqFkysMHoZNSET8J46HSOVfEqET2zpPH3TlT/li4vmtKJN8qJ8aIhhgcDoYortYiqMG3IFzE6SstddJ6Mne4hi9hoBNaY5qV4inFptJ8NgIrJXw9xuh0DKQLmgYKKOSk3YoF8L6KhUSKqJ4PQOi5pa6qWY5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq8shAFH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq8shAFH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so155540266b.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770899; x=1727375699; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKK/eaKF6seEJRo/6gDP5CwCkL0L/I6RrpnXiL3R1fI=;
        b=Eq8shAFHIJWlRKXbAw7mYbRh+BQfTS0UmG1sPsR2tuM+cGvppkJ3zZoZgnpA0COfAu
         Ablia7s3dACthtzf7pSpPIA5KZYYZaNC5f6M+9gylEgYbPoYOiGl3Jvefepxx+ZahR0F
         0+iph+oU1xeeG+fAQjxIIsduoLOq5cbxq5yMT7eCyTSdYl9aTzWPdPs6i/q3s18qUy+H
         JZ6v7eyb9EZAsJ3xqRXZdCyFpAS7DHLdbyL3OaRLznAGOnDOjrDZd0KoDSvgxDv3P6Uj
         oE8CBF6EmxSsyGt6b8+0a4sWqMBrtb7TmDbom1s5VssZPSkORflVb3pvHeWLAQDXT2Ar
         By+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770899; x=1727375699;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKK/eaKF6seEJRo/6gDP5CwCkL0L/I6RrpnXiL3R1fI=;
        b=HUIKlqFaINjYhK1qg1fYJ1QJSLdjS8Af2W2m9MogXs5aexTkibLoutyhMpHG59ffhY
         9pwrcNmWbO0UWmC6laVM6RHjUyBk7TsXiwlfQcC8BwsTVMYboSkXSgcg8N6RTtMLKmW9
         fOMOYQ9v7lhv6H21epSttBbzqOPgwCvOyEuy+iWBclyPVKV+qyifxj93tZMAKwLjY/qf
         FbDILOFoM03/oYYbu2nRSaQFtU0fpzYNti+Fi8sVkyBNgFWFy7bjozRHdnyIILqq25be
         qFpBOd52N0ytPG9o87x8DYahGpCE0ROV+y+tucfyVr+JYpzDjk2d+tMNdG50jfSbDZ16
         W75g==
X-Gm-Message-State: AOJu0Ywc5WPCY0rkDIrlexHDrWiowlWnUPdVjSVVSUnmBoJyysMsthqp
	1WLAcE+hE947XMVon//0+6bx4Zzl4AIbKTEuPMmLGKizjkzgAsZFzZrM6w==
X-Google-Smtp-Source: AGHT+IEhvmXFzrUdzDHno68kHdfsnjhU6jpZkIxDQR1+oblr3CPRXMEdSgRfSm/Pv6/NpGn2No2iFw==
X-Received: by 2002:a17:907:e655:b0:a8d:5472:b56c with SMTP id a640c23a62f3a-a90d4ffdc5dmr13006866b.22.1726770899297;
        Thu, 19 Sep 2024 11:34:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b389asm741598866b.122.2024.09.19.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:58 -0700 (PDT)
Message-Id: <d341face8530c4db1fbebf83b3eed053d089fca9.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:37 +0000
Subject: [PATCH 17/20] run-command: fix a typo
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
 run-command.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.h b/run-command.h
index 03e7222d8b5..0df25e445f0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -535,7 +535,7 @@ enum start_bg_result {
 	/* timeout expired waiting for child to become "ready" */
 	SBGR_TIMEOUT,
 
-	/* child process exited or was signalled before becomming "ready" */
+	/* child process exited or was signalled before becoming "ready" */
 	SBGR_DIED,
 };
 
-- 
gitgitgadget

