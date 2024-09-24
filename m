Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2580043
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214768; cv=none; b=mWFb5FEaz2grnvXcXPXVoS/+CNiOtrxYk2KMFX4ELpQglXCL2jd4IN7wQ3Vr2T3558uGaF4W2+k5lrxpzgvvvM7ZOyHvIlu1wDDvrIv4zp8qImCnTKXI6jKj+alcSHoIYIJciIWZUamw0U8KArzLk1h2bjnboP0vb/1l6/OQYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214768; c=relaxed/simple;
	bh=NN2ywbkATOmVuPA8urBHu5nfDgNOcYO3S/YJx6noS4M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DQ4VkZ0zMxJU5Q1q5JoiIaslH8f1Os+8crIvrlDRnEE0WHSDH9fNDTscq4TKshWZKH7CQ8cHtkcXEpV8t9iUsuLQJYd3GV6l3ZA2XZSVL2EJqYafuYPqNsLslCm/AwFqZLUre5rLBj21CKCLYnFTCUVPJ+LW/T2H6ei0y8/iay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C56DTDsJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C56DTDsJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c35618056aso38325116d6.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727214765; x=1727819565; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Zz+7jVJwljC2JOh0P8EPJ6mSPtgQocnf0bBN5clGfY=;
        b=C56DTDsJntZClw9TIs46hkt7FEIuCWR1Tg1xWk0DYzDmzzJpclGmQ6jczZT+/oAykf
         JISgVMXNSIpeGgbuNHN0I3lZI7sTIUHDiZ67ldBw06yMRZw30Dxk3sjwxTp3d934yreo
         EgCYEP4Eo3t65xUWU/sVGcz5ZaXmdqO00qO6Rai0Za3QGvdh+FpbM+qz6+0P2tS5f0ZE
         dprpBqso0KXwtrRY9Npg3QZpbPk/DwnAh0iCFdR7R6GkpgMMFCV/2hgLovT5MMCoRQol
         JRlvsXpVCzEhHVvR26Dc+f/+AFfMgdO+Bih7VTsh9VrtGyEJSEJqMuScDMM4LBdfRUz8
         qqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727214765; x=1727819565;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Zz+7jVJwljC2JOh0P8EPJ6mSPtgQocnf0bBN5clGfY=;
        b=m1sDVvWiuPYs/agB3i9DQFrLuULdEiccFR42hqEHvVMGWLbQc65J/AUb6bhdyQyO8F
         BEIrdv9okKd16EFLCWtIQjHM8NNbY9Duh2it+qOnipUqlgd/Rs8iJUwanzgmf1CnPdqP
         pRT5oLsKDB9L1OD4x8XMwS/4eAo5Uwk/sgW1usYs+NoUV+g7dJGxmfA6JQUGZ9NViRKV
         5GY4EwsEgcuA/F29HcOXRD4wZs5i0ltwiqwR8iSCUIsQ2z3sdS1+/JLIbKug0cwpO7VT
         jy7VAFG3vH/HRTQjuXL98FY/X20aUHC2WL4QYVBr+3/BjHHRtKrimIrBvnEB/8JOWFPK
         Y1Jw==
X-Gm-Message-State: AOJu0YyGSfQgMBwL0B3BKlKv3EVeEduZKRY1yHD35TED7tEoNJbOiWPa
	B8PuLzKgwv96k8FQ0XCr3beol0Z9CwOld9KncUXUK+jcMi+s2McX4aDZZHV81Mqchkff5ufJL60
	rp8T5lSUhAFVtVJTTFGFkcoCgcYExIeLq
X-Google-Smtp-Source: AGHT+IEPwWLGtfMh2ovHaW8TlZoFlGcoH4Ihyg8D/i+h2LuktaNPUAMc6UCaDA2zG506jTB9B4Z5OoHg4Q7006D0h8s=
X-Received: by 2002:a05:6214:3186:b0:6c1:6cb0:72b7 with SMTP id
 6a1803df08f44-6cb1ddcb7fbmr7429246d6.39.1727214765652; Tue, 24 Sep 2024
 14:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ron Ziroby Romero <ziroby@gmail.com>
Date: Tue, 24 Sep 2024 22:52:35 +0100
Message-ID: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
Subject: Pretty output in JSON format
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Howdy git folk,

I want to revive the discussion on JSON output. I see a discussion in
2021 about it, but it didnt come to a resolution. That discussion was
talking about adding a --json flag. I have a slightly different
approach.

I see online that many people have tried to make various hacks to
convert git output into JSON, but they all lack completeness,
especially with log messages with arbitrary text. I believe the best
and most correct way to get JSON output from git is to add it as a new
format to the pretty option. Then, it would be easy to pipe the output
into something like jq to parse the JSON.  Trying to convert git's
output into JSON is a losing proposition. You've already lost some of
the context of the output by getting it out of the git program itself.
A pretty option would provide a standard way to get correct JSON
output, with git's code handling the weird corner cases.

What do y'all think?

Cheers,
Ron Ziroby Romero
