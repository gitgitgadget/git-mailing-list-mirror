Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493C21D3CA
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951731; cv=none; b=YdHyULfK+EaYPlfmuUTiSWsSjdOvM4Mm7KTJdaCs2CLfR3ql/vUTa73G1lxEdJRfr068Bd2qjkDT4Tdsrtd2b2m/tiwKKm8qTQcqL5yjCeQRbHLebE3cCTD59q1aZ/TPfm5E7xGri369F4ziWey1gQdVAjJ5PFF7d1IL1aZlOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951731; c=relaxed/simple;
	bh=w38nZm/egWdCKo95/DwD/1ig37T/lKSBSh5uKDYCnso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uTFFzNlmHTvNB4dqPga5GiChw+H9CqB8/Wfmik9jLuo1mwILMxivmIZ2usR9RgOkCgYcuf/wsVSpnahkGPCIfb+xbRxw1RZtY8FCkFwVF8q/jJXOKsA8ZAWnwQtkdjt7xEemK08FdVwlPyf0n75S225pkkrVmJ+VlIDiqSAJVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeroeyes.com; spf=pass smtp.mailfrom=zeroeyes.com; dkim=pass (1024-bit key) header.d=zeroeyes.com header.i=@zeroeyes.com header.b=Ytkbb92Y; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeroeyes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeroeyes.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zeroeyes.com header.i=@zeroeyes.com header.b="Ytkbb92Y"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso1657426e87.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zeroeyes.com; s=google; t=1759951724; x=1760556524; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w38nZm/egWdCKo95/DwD/1ig37T/lKSBSh5uKDYCnso=;
        b=Ytkbb92YIHFw27GD4BaADoqCuUE2ONCNNq4XRpHZJBHApJsAFs/l3/nsU7LjrOaxXZ
         icQZ5lIZ+vPd3bBHMQX/LFt7i/yc04HvS0jxcysgSdvIayAYPhqWz3+dSBJ8iwCAuKXc
         WZu1ot9R2h5iWYnVETCQoxxr/gLV1yeIf77pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759951724; x=1760556524;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w38nZm/egWdCKo95/DwD/1ig37T/lKSBSh5uKDYCnso=;
        b=iGQeupoBcFw/bYuFWgwol5FWronMBpsurFW8zOEBwEBT8xRPLp2Zju+mFQIX8j4O3b
         o18cW3uVnJU6qxonsEJCIHf76Vqn4uAM0/ERQiWrsRSeBk7Rf9RrLj7ZqcXJTArImswT
         qTgleUiVUoQfpXV727mrHYLmSfVK4ijWvDxNbwZph118qNkEJ3EvGqqf5xK/KO9xUdgq
         v3UxGn7+0Yy6SMioJXowjSbBKmsp3SHkK7lvPiM7EazXt222cYx2vIDAptWyLNA5kFoe
         XJiyCXj2L2hkwGOhjCfH0JFKXNc6Y8OIbnIXxe0wvAVKUR4vJZnMb6Y3Igq3K21khPFR
         MCxw==
X-Gm-Message-State: AOJu0Yz3tHqOQ36E5QmnA26iOuCmdCcroyfO6MAoOKvATsQjf5g0N0cM
	LPd3U99Sm/ViWKTflQ06o7Us1Tr7OJMM8nr8W8MoQ20sVt25XDtyjYVzWFhKo611SFzIdbT9+TW
	RtU/BnN64VR5GDHjH8/2qG9y9qyRSdT4I5Ixb65v3mUyoTTcMP0Y1cCs=
X-Gm-Gg: ASbGnctl0r9DcMuUWQFP1r4zUOLIBbFtsfVzraJ4ayhwQBbsQ3nBQ4qdWQIwSnLu8CI
	I6KuzpckvfqaH793v0ZyuQK2LKg9PDWRgQwD229TKEE6/xs7mHbmw1clHJN4DvJS7oil3SCyqDY
	XLFon5GDesHxXr1wAg9Y6gMnXZ/t6XoVG8HQlFJgy4jocCKvlE0dipT7ojQzJo1BsAPK4XQTu8X
	zdc5P44OSJf12trOtEX35Y3iyNwrYLZ7enbr7BGY+J/zW+K7FOHkUgkWi8eXe37moDMA0FuSwpT
	cIWFidkWF+Qcp04pAz4b
X-Google-Smtp-Source: AGHT+IEomyENA8DxU1cDmMh63535u+05UJxEm/SOcaKt3bVvG0b/PopmzuUlTmAum3Sl88Sho5qEKkI2NHBYPWDx4jk=
X-Received: by 2002:a05:6512:3d26:b0:586:a95f:cac1 with SMTP id
 2adb3069b0e04-5906f3107bbmr1423821e87.12.1759951723849; Wed, 08 Oct 2025
 12:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick Giampietro <nickgiampietro@zeroeyes.com>
Date: Thu, 9 Oct 2025 04:28:17 +0900
X-Gm-Features: AS18NWBBJgbQfKDL8XfP4mUqCvKKiTn_Qe0Uau8QKKDFKPFqbQ-oDuW545F-0YI
Message-ID: <CAEVYKFcj8kGRAxawwCLLTNiewNUMuFQnZt3-sGPG=kA-AY-6nQ@mail.gmail.com>
Subject: Subject: Git console output told me to email you about "git
 whatchanged" so I am.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is not a spammy message I promise. I'm trying to do what you requested.

I use git whatchanged regularly, please do not remove it.

...Nick Giampietro
...Sr. Software Engineer
