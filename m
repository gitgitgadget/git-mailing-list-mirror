Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC887381AA
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710087983; cv=none; b=NOHdwv5mUOj1FnEZPQVbOWzxVLrZSIS1USW+5xSO4vv2Ju2f3d6V4McATNpxZ0mUy2CHziRiZLpPGZLrU24Fe0wBwQrvxFtHdrAg7R1uE9bVUm90gPCY5j2SU+0T2NyT+GEE83a31KlWCs2ibNAm8sl1vgDr84yIUIfI2wvAJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710087983; c=relaxed/simple;
	bh=zUXe1w8NAwfYSiT1CvjpKOOdPUDi3B0nUUOYtPnT02s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6aIzfZd148lR5OdUWtBsEISnNy0zVHeJFECcjJUhCDeHJvdcs9F7JsRFxVmP5J0HS3n7UTW4WkoODXAWY2eHns7fG0M4jFv6paoE31aHAI8AK6T3RdVajlRJ3tCdhwtfbK1ZOtS5WvJ1pm985ajLraf1Wz2ZUXdQDXFYZAzfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vyrw5v0V; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vyrw5v0V"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41312232c7aso17305325e9.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710087979; x=1710692779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+NdgHfpt9gSebBp103LpD0Cj741iTXZae504yMMWqU=;
        b=Vyrw5v0VjgApzJsglkSt+H8u/Z5WVdjRbYsDdtSM4v+nlQHJhEQiV+6tVpbka2udOU
         DV/oJefjuAhfwEs2SibN7R35iWFhJKdtdLanwqwX+rQGnQ3QiX2d9HQUD/+uB5v7hQnE
         MTpervPEw3Fl6MAqi34edc2eS2BD/2bVcE6ETamJFuLOKGrOCHBmKkvaQARWuH+1YdiE
         6cPvUBXLADn/cckrKkoUh1bLp4qmbHuHqtP813RKDQNZCloSn0QLFLUY89KFZQBFtDLX
         ZQq3G/ozpQYmTA0rQhgCZaSjfnKiSQ280Ri4ryB4HoJQDnTGnbcJ48iGx2rZta/NETbv
         ZXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710087979; x=1710692779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+NdgHfpt9gSebBp103LpD0Cj741iTXZae504yMMWqU=;
        b=v8cEFGNpadgMBbFoUtIbk8tnUOCMpesqbf5s4TNe62Yu5z9uGJ3IdmUq7SC4ZtRcMn
         XAdyPSye7PV8VIhl4Qp9nOVia2fdmS01l1YgKtfZrF8QDWagESP+WEcgdbBawMuYJh0e
         P6t8l55lLrjqggfX0UEY6ayN8rRT1m0HE3r9cZkHWhIZo4PvfYX3rrmNRhzeJ8E9d4XG
         w+KdgaBk+8m7+o72mjDr8QkRXYytW/JGks763VmuDHpot/ryWp384uPFFBbho1Fl9XbS
         gtRuWu0eTaapyh+WgzdaVIRTtEYiEhLnsP6YUb2GKkoR1EGnIa4Rh7AISDNAiGKXvK+9
         jXxw==
X-Gm-Message-State: AOJu0Yzdz+yYeA7OB0Dn+UJZWamtBY7pf2UPO8pVodqxNgJnQQ8CffTf
	LavdRLjPMTIOnEpolXBPnwo6lIJSzGgE6juSfMQ5QkemCJjZMOTC9dMSfrcys2guN0CD
X-Google-Smtp-Source: AGHT+IF8nAF9eRqJUnwxLi+MZ12oS/6RYb0L6vrZcPg7zRQ2vMs4p3vxtPNKeWT5gK0WOqwkp8/Z3g==
X-Received: by 2002:a05:600c:4fce:b0:412:dda8:fbc2 with SMTP id o14-20020a05600c4fce00b00412dda8fbc2mr4008491wmq.16.1710087978682;
        Sun, 10 Mar 2024 09:26:18 -0700 (PDT)
Received: from localhost.localdomain (cust-west-par-46-193-56-47.cust.wifirst.net. [46.193.56.47])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b004131f8b622bsm5712067wmg.14.2024.03.10.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 09:26:18 -0700 (PDT)
From: Aryan Gupta <garyan447@gmail.com>
To: git@vger.kernel.org
Cc: Aryan Gupta <garyan447@gmail.com>
Subject: [GSoC][PATCH 1/1] add zero count optimization in ewah_bitmap.c
Date: Sun, 10 Mar 2024 17:26:14 +0100
Message-Id: <20240310162614.62691-2-garyan447@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240310162614.62691-1-garyan447@gmail.com>
References: <20240310162614.62691-1-garyan447@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Aryan Gupta <garyan447@gmail.com>
---
 ewah/ewah_bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 8785cbc54a..9056829572 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -257,10 +257,11 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
 		for (k = 0; k < rlw_get_literal_words(word); ++k) {
 			int c;
 
-			/* todo: zero count optimization */
-			for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
-				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
-					callback(pos, payload);
+			if(self->buffer[pointer]) {
+				for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
+					if (((eword_t)1 << c) != 0)
+						callback(pos, payload);
+				}
 			}
 
 			++pointer;
-- 
2.25.1

