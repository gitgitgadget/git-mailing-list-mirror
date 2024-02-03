Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A21643A
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706962063; cv=none; b=YAOgmpJt6TVMBRLe9fohMrzDs2uOYNQzjYOApx9OfHuTnlg9W/W0ca5E5Jyr3W+mQFF8mcgnsZH6PA+MbS2fBojw4FwqWhfRd2EXj9C0vbMGlN9XVohqJtg29XfOoRtgL8M1LF1Rxf8UaAT//Jyzzig0BHtg+djhrvXGACz88KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706962063; c=relaxed/simple;
	bh=I8AuHhrR/A/SxmG+xSZdWM/UfuJ+kJijtQ0LB/KFONU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5lbS8yTqn8+EXv8lJVEksavshJydRjkrzaQ+p92onueTR+FT4dGsl/G/W92q++YLkYj1PwoRuF4ly+elIjGY+fIQZfc1tuwU+l7VR3F/W6pK6ebBQHpHjShtLPif+yTF7f7JX+FaY/GY4yD75l6BnpKKY4G+KidDYsPd0+KRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9dIcRcb; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9dIcRcb"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1908544a12.0
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706962061; x=1707566861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2TVQfy3puY9jZQi7ZXI0UB8bOg+kfiq0nu8QWWqdvg=;
        b=d9dIcRcbGqbyK7fBsYPMvRgS/eNK/kedPQorx7rJopM2z0iWof6uSBVQzIg9KmDWbZ
         HhNO8Z2R5VBsdaXq79ZoU3EBTnqzRdmAu95DmvFEAe7bZRvWxMWIQDw9s8qTBIfLmmIL
         k3vgQjwpAf4vUswxub99kucwcOGYsY0+vrEBteNat0x3G2w5u3PKfIyqX0sUN2wUYEZb
         YkUsVwrRvJucNLhoa+TBPGrUwx7myUQkiJn3XNCP/nXKMYKqda+HqiiNSgUEPeUddaw2
         ZDH7tMEaVnlc7RlxGAme3kOCZVDejy9foZCLnWgJsvV2DcAhy04FD/f2W2t5GIqqM9Yc
         btyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706962061; x=1707566861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2TVQfy3puY9jZQi7ZXI0UB8bOg+kfiq0nu8QWWqdvg=;
        b=dOYTA7nuNAaiJd89rgk63wyEXXC5vBFmppOd0CorVoHZqtro7riNJQ/N0h2+cE0HRy
         f76kgehaY2dJ4sfVL0ZpkLxa4DQDAR1HsNU8x+oEL++VuxtLk5aWk2213tOnqOg6h3yl
         hPhi8Dk6lia1OpBvKTGAuCcxJ4uh3hsItxG7U/3i6KV4deKKp7BZklyo9TrxTTCgiEHN
         YB0/ZOP/7Yfg6miXhPKOOin0myQ+KxySqBioJE2rTxpQyFTJy2vpTEoUl8t8Ovm5K1zC
         u1xakjCZNNIxoF11dckb+GL6wWq3ZBRTYHGe8pNWO6x7K7ZN3vkPWTKiSEyFNXKUa0M5
         ql5A==
X-Gm-Message-State: AOJu0YzL34mZ08ScZks6VCdvQXSS3YlOOm9M6U/W/BVNgdggBVRbQGod
	A2WGPvcPVh907Dnv7zWmR561EOFvo7gHfCeKsVMGrRFv05ZTtOEmK4eseUDa
X-Google-Smtp-Source: AGHT+IEA4fkGQ6FIgm+pdS+A9KYNQWzCrRhYsadvm6BJHaAU5P2iicC3WluSSelmtnEV54/wnvQ9OQ==
X-Received: by 2002:a17:902:c94b:b0:1d9:8e37:56d6 with SMTP id i11-20020a170902c94b00b001d98e3756d6mr1139598pla.40.1706962061065;
        Sat, 03 Feb 2024 04:07:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVYZWdHXIpnqHKN2kff0Wqez/uuhhE/66hZKGimoYfc5DiurgGKhBGE0t3qTahNgw4h3CKZmo2F0r+zBG1zaUv8u8SwXsyHVqhpBI4HsyY6Ullpw3g=
Received: from localhost.localdomain ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id x63-20020a17090a6c4500b00295fb7e7b87sm1876065pjj.27.2024.02.03.04.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 04:07:40 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 0/2] add-patch: '@' as a synonym for 'HEAD'
Date: Sat,  3 Feb 2024 16:55:46 +0530
Message-ID: <20240203112619.979239-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202150434.11256-1-shyamthakkar001@gmail.com>
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v3 of the series updates the commit message for patch [2/2] and
replaces the function name from is_rev_head() to user_meant_head().

Patch [1/2] remains unchanged.

Ghanshyam Thakkar (2):
  add-patch: remove unnecessary NEEDSWORK comment
  add-patch: classify '@' as a synonym for 'HEAD'

 add-patch.c               | 19 +++++++---------
 builtin/checkout.c        | 11 +++++-----
 t/t2016-checkout-patch.sh | 46 ++++++++++++++++++++++-----------------
 t/t2071-restore-patch.sh  | 18 +++++++++------
 t/t7105-reset-patch.sh    | 10 +++++++++
 5 files changed, 61 insertions(+), 43 deletions(-)

-- 
2.43.0

