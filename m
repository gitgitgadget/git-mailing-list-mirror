Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E21D2F63
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636607; cv=none; b=RguZpHM0GQZ/p9RNXfOU2RO3FTJrZFGVoXXEqHK66J/7C7q55cvX42Cvl/ZzTBEawGGbJd5S+wu5EXKWI39DFLkyqOswLfiwhfTdzf24o4GnJaQcigz5IqQhIJu3JhIdiavatObux3paGzQDvHZrMjBHAWlsNS1anX7z0Y9JCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636607; c=relaxed/simple;
	bh=PGAtprA81MzWcJL9qHf7oVp1A3Tn2IYdNbk1s7knyBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtpC9qp8SuK8x0zjrXLQ0lm1wG/Ph3SB3I+Si5jyg1mosoJrT1yMrk6CxXQEI/WyqHoRLUPh4FutyY7Y+H+GWnvShHHLV4N9xGWOtLxg5ow9ELYDZj7MUjHbLXnJqSVUiRVxCoi8WEkM0rR2iHgdMUWeGZfrjKmNCTmAhXnSO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZYH7lY+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZYH7lY+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-205909afad3so21446825ad.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725636605; x=1726241405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJWStR7G6chzz/5QNNgKNxkrnDV4ty8hAKb4EKMskts=;
        b=DZYH7lY+FHsuqUV5+JTYg+u8h7lvZdM4++dFfmrZ77b8ScBcq3NA+s2lknW0DqIRl6
         LU1LPsGI7fDaUX3AX7VAR9YUGInQTkXJ/Kt9sHOSErI15u2qYG29z1pm+BPLO6oJi9T2
         vU6AgUlA78dLvdumwTW/+xdGpR7P+xuNU8toAcOPLOgNjTtuFEzzhbTvbVXjUYsWH9VG
         AKU4bGFlv4LPuBr11TVZd/I1TZDps3QZSbCyFYum6tz+BcF0cNz3V4qMj/e7lAY12RQ9
         JyW/pLV5jK1XVDz78tuPY2yzOLwvN04M8P5FOifSDzQXfNtZW9IWudh1sZA2keL6lNV0
         JaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636605; x=1726241405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJWStR7G6chzz/5QNNgKNxkrnDV4ty8hAKb4EKMskts=;
        b=kRZDn6dx+FEKMv7fT4atk2OT6nlpKFNcX71OspNn8Q+FNBwgs7KxUuPcllupI5w90B
         81gCcQcGT85P8E+zaPW5DJVGhByk7WwTUNOzraSRztub1y9Yi0Wo8pj1S9in1yHgVr1K
         93YuS8iBjmZVaGZGD0uQ2+pdwV+p7oPLmaS6sOIUlVYfh7spCnx6Sc4ZQtLa0kj2V3IT
         GQks7m+pDLr/mB7LBcvFsVRYE0Z/dGoOi/wzl7xzbr2q2H3yk8/xf4WkZBwe3KkbLnk8
         WvkH1042PA0mmeTw5EWS9cREHhh6Q5BgY0PRxgg975UIU0NX79iom15AUWZdi4NZe4AS
         ezTw==
X-Gm-Message-State: AOJu0Yx2uQ79iqOtrbR5Yi9UMsK4U6p8AkRMWDFgXaIWrMAPEEZM21ln
	BwshfSnGCVVw1mHNIxYTgC8Y0+VEye+N7fcmCTpAXKhqnV1T5NzdajGp0A==
X-Google-Smtp-Source: AGHT+IGxAlGSBqg4+S3fa13WtzOhJkXCBJ7KATOv7ol0gr7TEoNa1eR5Q+sjVp5JORJNSTgY5ZERHg==
X-Received: by 2002:a17:902:cf01:b0:206:b064:ade4 with SMTP id d9443c01a7336-206b064b1b7mr103039675ad.16.1725636605035;
        Fri, 06 Sep 2024 08:30:05 -0700 (PDT)
Received: from thunderbird.smith.home (ip70-162-122-51.ph.ph.cox.net. [70.162.122.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea39300sm44549425ad.172.2024.09.06.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:30:04 -0700 (PDT)
From: "Stephen P. Smith" <ishchis2@gmail.com>
X-Google-Original-From: "Stephen P. Smith" <ischis2@cox.net>
Received: from thunderbird.. (localhost [127.0.0.1])
	by thunderbird.smith.home (Postfix) with ESMTP id EA60B1960174;
	Fri,  6 Sep 2024 08:30:03 -0700 (MST)
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	ishchis2@gmail.com
Subject: [PATCH 1/1] .mailmap document current address.
Date: Fri,  6 Sep 2024 08:30:02 -0700
Message-ID: <20240906153003.110200-2-ischis2@cox.net>
X-Mailer: git-send-email 2.46.0.267.gbb9c16bd4f
In-Reply-To: <20240906153003.110200-1-ischis2@cox.net>
References: <20240906153003.110200-1-ischis2@cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Stephen P. Smith" <ishchis2@gmail.com>

Cox Communications no longer supports email and transfered accounts to
yahoo. I closed the account at yahoo since I use gmail.com.

Signed-off-by: Stephen P. Smith <ishchis2@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 18128a1250..96c2740fbb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -257,6 +257,7 @@ Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
 Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
 Štěpán Němec <stepnem@gmail.com> <stepan.nemec@gmail.com>
 Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
+Stephen P. Smith <ishchis2@gmail.com> <ischis2@cox.net>
 Steven Drake <sdrake@xnet.co.nz> <sdrake@ihug.co.nz>
 Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
 Steven Grimm <koreth@midwinter.com> koreth@midwinter.com
-- 
2.46.0.267.gbb9c16bd4f

