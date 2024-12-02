Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05F1F8AFE
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733122612; cv=none; b=HPnJ1uHV4XHi2DnxqW940g/hmwc3CeWBUuKVK2Ll1f/GCe5VZV+PyHL2RUlp8xQDnXFXNByU82Qg7jvWqVPDWjzcRofMMRienB7VGAcROg3+n/SUh55S+zE0X1B86ByW+E+ZEkRjA/iujNtJKnzGIriDEPZLyZdjKmiOJEYtSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733122612; c=relaxed/simple;
	bh=GZQupDKVIQYi259/Mvobh1vmlRvirHlA78s/AkvwKtA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iO9K/8k68OkgPWkoJYm+pBVFyiRA9seHFskjQrr2tz+pewWicyZBnaWGfVzWCFhkottqPUaBCbPOg+RmiqI6ty5cXglpa7uLVJtbY4k4otau9KiKXEfr07j/Sbf5jUgh3ZsoTOJNedYGQWym6h73dPezibMMPn+HxK9HLfjR7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thegates.biz; spf=pass smtp.mailfrom=thegates.biz; dkim=pass (2048-bit key) header.d=thegates.biz header.i=@thegates.biz header.b=IaoQwaqn; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thegates.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegates.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegates.biz header.i=@thegates.biz header.b="IaoQwaqn"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ea60f074c3so2079406b6e.1
        for <git@vger.kernel.org>; Sun, 01 Dec 2024 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegates.biz; s=google; t=1733122609; x=1733727409; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lprkt1Pekl+3Z53t3ksJWnIh17mdY6AlNd8IXfNTvxY=;
        b=IaoQwaqnZPY6e8GZMWIncKKlz18DI3tPEp7e7vajeBD9A4BySeh1litJEt+u8knTg/
         xxIUDVpBgFjVPvsn6uRlQsslyYs7wbQNOQj9Wn1QZnMV5A7jsyM3ACcHc+WIVn42vvwP
         /2hTsqealEiJcqa+yUrkrjEFmxnOOA55gqT9F2KBWnQo0JCz5qc2jj3W7m/v98CaJdXn
         aJ2CX2AFwqjIjH5LCxwbPQXpbQz7XSM5EZQnpf7TS0O2CWl5ofE+CtHw9ZGfakEWgsbR
         bF5iFgzYhZ//5+1q+rc+7bMjNnhFnn7ba1ovkFfcLm2C5yO3aw+o2UXzD3vFCkr4J/sg
         W7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733122609; x=1733727409;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lprkt1Pekl+3Z53t3ksJWnIh17mdY6AlNd8IXfNTvxY=;
        b=xSwFmY25772REJEr5aiN6kcf2DH6aDuHZflt3rj80ggeX/OEUdVqNMiGgZOTdIs865
         KIV9z5puMYOoksf98whKVqfXSMBIg5Jf42pvpas66vvSfoBDndGzuzRE5ZWGt8gSYNXY
         MIG1yvktQd9hqavt+dJp/hLmHZ6/ck5I90xFY3mOg/jTgu13DX4wNe56XtzmoMKATZET
         8PEZlfYfPFG+u/LthjoHGyz4ZjqQx7qB/P/eXKs2S2ZMRa5kPvZ5NHKimU6J8BXMzmQu
         8DRrPm+jbyFrGVgTfIgolqEUVU7qB/4OrRrG2WxKYjYyZjNh9wjdPRHLyenvOwVRJr4M
         TCNw==
X-Gm-Message-State: AOJu0YzPPtOXJuYZEpzMlYaBBCJbY9YjAobZwnqkq1sGDkm8x/UMfguG
	bTHrpgBTw36YYE74c/EwU6/ZHmfNAK0dMG6EqUuEnwXmenT0Kz2CiaZsTusSZL3u3hY6ZNVPV+U
	lO+bsHiQYfhdy8MefjsYHTIh41j6EMKII2UGk5it2g17s4JznLqg=
X-Gm-Gg: ASbGncuQavxY9exZLgKpXMh6+UE0nfPjgI0s6VlyF9ro0TUONsctyyoHLPwda7lQZDP
	v3xThn+14NznVQcGPtkECgLUduqtj6mhkOs5XilgS3/uq0d4ZAXB9tRZKi+rtgJ48
X-Google-Smtp-Source: AGHT+IE7veBDGJZPTUUtRP4pYISxb1f0vOJr03hbZVYqfQ5ZyJRIN5JXzdbVpp4CBrapzOpOJZ3AAQQT7Gq/Yze+XhE=
X-Received: by 2002:a05:6808:198e:b0:3ea:6149:d6ef with SMTP id
 5614622812f47-3ea6db62534mr17666053b6e.1.1733122609469; Sun, 01 Dec 2024
 22:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Surajit Koly <surajitk@thegates.biz>
Date: Mon, 2 Dec 2024 12:26:37 +0530
Message-ID: <CANzu-cdunr+NF+uZf_2Gqd26NCU_e+gQizHcmk3FSN_FG6Yquw@mail.gmail.com>
Subject: Issue on git revert. Git is not reverting code completely
To: git@vger.kernel.org, sg@thegates.biz
Content-Type: text/plain; charset="UTF-8"

Hi,
I am getting an issue while reverting a commit. After reverting, I can
see that the changes that I made are not reverted completely. I am
sharing the details below

GIT version: git version 2.42.0.windows.2

Original git commit on 29th July 2024
----------------
commit added79cb5aaa60ffced49ee4d3f6c9b3131abde
Author: Surajit Koley <surajitk@thegates.biz>
Date:   Mon Jul 29 15:00:24 2024 +0530

    Implement Parameterize sql at user models

    Implement parameterized sql at
    models/user.js
    models/userV2.js

Commit link: https://gitlab.com/gatesapac/forum/-/commit/added79cb5aaa60ffced49ee4d3f6c9b3131abde
Git revert commit on 13th Nov 2024
--------------
commit 582797adad70d3bfe6c6d74aeed2f795013ca41f
Author: Surajit Koley <surajitk@thegates.biz>
Date:   Wed Nov 13 14:29:11 2024 +0530

    Revert "Implement Parameterize sql at user models"

    This reverts commit added79cb5aaa60ffced49ee4d3f6c9b3131abde.

Commit link: https://gitlab.com/gatesapac/forum/-/commit/582797adad70d3bfe6c6d74aeed2f795013ca41f

I am sharing screenshots of commit
added79cb5aaa60ffced49ee4d3f6c9b3131abde and revert commit
582797adad70d3bfe6c6d74aeed2f795013ca41f
