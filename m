Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF613666C
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676452; cv=none; b=cu/Xd60LZz16VxJTt1RoK5e63hiX4GPazU6KPkiBKGoYjA1hzWWKrH1ozzmkpEvzDymMern2IwO2k3B4ceQtp031Y0CFFiJY8ALOxSRDNMTfr6NQG8ez/svBOlGDyl+7ma4qoU7EWEApQpg0CFs7fY3ubSFUppei+n5TPcioE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676452; c=relaxed/simple;
	bh=bVlNJ1upc4nkSJLc7LiPjDdnQCJTCb+XcJxAe0jtdCA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p4CNjXf1axhJCP3GqPSooVg7C5d8Nky9pp9815oLMGrecA7q7n0l5Ve+qjsgfRg0OHvfj7gxJ7a1bOq0caYz7WU7U9JIkpcjG+BLGWlzqX+K+x5cUqXyC6Ip3IFhQIlSkyi4hQ087W0WknA+tL2TTqwbGQPMcx532Tay2bj2w8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJcWALET; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJcWALET"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3455ff1339dso2041765f8f.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676448; x=1713281248; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KcOBl2WV1JSS54lzJoJy+oNGcpVou5d+bWNc95IFz0=;
        b=lJcWALETHpuZaBRMyDBgXGW0S3kDwtjCHWKFbpVIyFanpcKVIgk1lSPnmUXw7LI8UG
         1kgOW1AZGAvTfQZqtKOpye6kBw6QEnDkP6igJsLGyD8AZDdgfaulRad4qjUcLmvT42vn
         AV5o3jK6E7o75MTUpcjV2jwLctls521MqNGIp3DZhnUk7QJEQav2ou5qtWssDZTd3Nef
         nsU1Msn910dsyHqWtN1Y4KcSss6PhJYPNNNIC2JiA2PjNhwafosvNejLysr9upqkvYNC
         X78oOFTpcMzTWztX0TopfaPZhmG3CamKoYMmpGTMKMNEtkuondEXV2q+EFNlhJowZDWB
         m/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676448; x=1713281248;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KcOBl2WV1JSS54lzJoJy+oNGcpVou5d+bWNc95IFz0=;
        b=uSvU3p+9InvgQOP3apwgiao9a60OaeaEYIdfyyEBXCtUozz64WkloajiayQxgyzSdw
         VpI6b9v7mftnOYkA72TSA4VDCuuJ+Ctu+xEA2gtoA5WUIwB+CGTXGhGW7h/rBb/jkNxw
         Ioi4UIcUr1GFu/CgG1zoS7Z/9R6auSk8skwkSiU7laNoJwZcnGietkoDD4V1ir7GAnnM
         toK/vhMcn0JK2i5+/ybtEqZfEgpoUjxY1zCM4ryB/+hv42AtLCTNzjxEPbL3B/8iAVGy
         bjV9t5FPj/iErDTPP5mnvucfzDmMCsk240G6B5LzXgZ6ZZ4xeQy1Y2pVJdpzYPzFTEjD
         fSmg==
X-Gm-Message-State: AOJu0YzZilB12Z0B12Al8y+gzkkSOitVAZTnq3G9LhxbXKvcdPOst4h9
	SDy8w+S4lXQyc/rwMR373p+HM/YOjOTynlXuRgQHvlLtYomeps/PBm0VxCJc
X-Google-Smtp-Source: AGHT+IFT0nhCDEoizUte26ftNCmLVHe0tGnOc/LF5IsVABA1RH9Xt8r2UTdJp8KWsEDMGf+PtiVvqA==
X-Received: by 2002:adf:f3d0:0:b0:341:8412:a6e7 with SMTP id g16-20020adff3d0000000b003418412a6e7mr45978wrp.18.1712676448196;
        Tue, 09 Apr 2024 08:27:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d44c6000000b003438f4eef2dsm11715741wrr.63.2024.04.09.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:27:27 -0700 (PDT)
Message-Id: <b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 15:27:24 +0000
Subject: [PATCH 3/3] t3428: restore coverage for "apply" backend
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This test file assumes the "apply" backend is the default which is not
the case since 2ac0d6273f (rebase: change the default backend from "am"
to "merge", 2020-02-15). Make sure the "apply" backend is tested by
specifying it explicitly.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3428-rebase-signoff.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 133e54114f6..1bebd1ce74a 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -38,8 +38,8 @@ test_expect_success 'setup' '
 
 # We configure an alias to do the rebase --signoff so that
 # on the next subtest we can show that --no-signoff overrides the alias
-test_expect_success 'rebase --signoff adds a sign-off line' '
-	git rbs HEAD^ &&
+test_expect_success 'rebase --apply --signoff adds a sign-off line' '
+	git rbs --apply HEAD^ &&
 	test_commit_message HEAD expected-signed
 '
 
-- 
gitgitgadget
