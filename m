Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A42172BD5
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291301; cv=none; b=V98kzRVzefxTmuIqyyr+9RZ5Bcv5uwuUzLClW0TCVLDtrPeRGROKpCm8a7rF0BFQhlPjI6BPvzBgdWHH45DDurgDrltCIax5ernkzWRhakggVOQHJ9VLgBWwWw7c5rwpnrOoMssUC8BVM7hn8Du2OKEwLY63BqRENDXKI16bPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291301; c=relaxed/simple;
	bh=eSZU5nR3sLYZzZSbKST/+kA48V9WAKcibca8IPSAWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bq+Njgx9NZlrVDKPl3TUOnoJCVMYz4AAraKYVdvESHabAihlEzilk2FRr/mr4gn8djXm0RLtZIW1uncN4l4MHkOPlOwKhzzr92E444yVkcM8EGFIdSOfub9RqpX60VXZJoGP0fO159wHuBQs1qQFynLkp/g2ygd+f0/Za4Nh5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quadrature.ai; spf=pass smtp.mailfrom=quadrature.ai; dkim=pass (2048-bit key) header.d=quadrature-ai.20230601.gappssmtp.com header.i=@quadrature-ai.20230601.gappssmtp.com header.b=BOLfzIZD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quadrature.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quadrature.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quadrature-ai.20230601.gappssmtp.com header.i=@quadrature-ai.20230601.gappssmtp.com header.b="BOLfzIZD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edb40f357so7172505e9.0
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quadrature-ai.20230601.gappssmtp.com; s=20230601; t=1744291297; x=1744896097; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Xm1A3JVtls8V9U94cT45fdVGLVTf/x1VhuW2m+S33U=;
        b=BOLfzIZDnenOS2FdquHbH94PsKpEoJ8Fs4gCgDgX53e6dhY9/kF2coCcA4aaLKP/eT
         WauOy2cqfvNBeOvVqsJx5kccV4XRfZAR/DGUO5r+AUziKhlLKRLsGsCKj/+cT4THHy8I
         IRGWsjkXXKxcgdownBxeUlFWIMyxhWQZlA8p+Lb6Mkc1KvF7M+ac1tJVDjBnKkbh2oWi
         IY4pQA/My377yNUy+UEDK7h3e9rgRamqwvy47jCXB27F6wdsbS1gI7WMEa/PjMnOTgx4
         V348pRh7/U1ceWaf7Mj0HR5TqQv7llq/P/8J5KthqCC1CeY2Z1ez8FJoQ01x7UoQDO+y
         jGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291297; x=1744896097;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xm1A3JVtls8V9U94cT45fdVGLVTf/x1VhuW2m+S33U=;
        b=vVp7WQokkKnqTAUd+bjdaK0f+UUg9exKI5QlWCAU5hyqDPUGAaGRcUP+9I4cyBOIBE
         zW5oYI9hXBtdwdXPoS18vRWg/XkFlvDVGK8xEbiJNBUSko5aYVUSS29PmrM25DlwdNa0
         OIdOZd8ZSsJcJeS0r3nWL0i/B6h1SzntM5lL2nXbdQDbWL53VS64KcgY6VGokwpZl050
         LoJE9J8pMwRRmsFkz6tg9Ob/8MW3oE1np3hveB8vyRK50/gSnUzNJEMiOedwlklFKifO
         TT9y2pYx9kEvEclZVQRfEBd3tqjOjN5bdSn1lsoPu5Lz+wqxhRGB2wRgIvqf4PLWgDvY
         Dqkw==
X-Gm-Message-State: AOJu0Yx9YDie/uOtBq3yM4uxJrkViNWLQfMdqw43qwwt+tjceD/ay9eT
	xLbr+cG9voF9fMBC8JVyljvSL2EpM9RjITF9XQ0bYWv7bg4CvH5B/8TqaXcB58UbEufu7Dz+d3G
	DAVTsz4WPVxE3yphe8G+npY8mweQzLMdQgag+EjyGrE0txeFkagAx
X-Gm-Gg: ASbGncv2KWiDT63sj5qjYYAD+/BH1aQW45+HAe/Es6+ihMpqN2NjHEsO+oRyzBegryx
	fANrtYeB43pSYdkF9dKIUVZrjYY+CIbcdgmjSzTYa4AzoXS9xJIuOkY/IW9aX+a/2VgJwxZnA80
	/nGzKh93t/bV2TtbGY5ZAue1nQzF31Lg==
X-Google-Smtp-Source: AGHT+IE9cKrZurwbTEeHfmJRCWZ8hZgjOHpgLeKOM2Juxv1ngLkOWJNmQnxiQC/4TbABAx7WR+SkUHgYgY86ztU5NaE=
X-Received: by 2002:a5d:64ae:0:b0:391:3bba:7f18 with SMTP id
 ffacd0b85a97d-39d8f27358cmr2232599f8f.12.1744291297286; Thu, 10 Apr 2025
 06:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPzgaL2Q4v0LMSek=osugTDCDww9D-Tg+tDsFhFvRSVXFR8g6Q@mail.gmail.com>
In-Reply-To: <CAPzgaL2Q4v0LMSek=osugTDCDww9D-Tg+tDsFhFvRSVXFR8g6Q@mail.gmail.com>
From: Nikolaus Rath <nikolaus@quadrature.ai>
Date: Thu, 10 Apr 2025 14:21:01 +0100
X-Gm-Features: ATxdqUEFYZxVi-BCanmKQ4cE9hAgv8yZdPcFOBzyD0gA0ypGycN2HrNJtzrmPDw
Message-ID: <CAPzgaL1NH_GofMko6f2Auz4e1TjTJNH0w4-ph8np04QRfT_R7A@mail.gmail.com>
Subject: 'safe.directory' setting ignored for some operations?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

It seems to me that the 'safe.directory = *' option is ignored for
some operations:

---snip--
$ git --version
git version 2.43.0

$ git config --get-all --show-scope safe.directory
command *

$ git status -v --untracked=all --ignored
HEAD detached at e116555
[...]
nothing to commit, working tree clean

$ git clone -v --no-checkout --
/builds/coreinfra/grafana_terraform/.git
/builds/coreinfra/grafana_terraform/tmpus18hzbs
Cloning into '/builds/coreinfra/grafana_terraform/tmpus18hzbs'...
fatal: detected dubious ownership in repository at
'/builds/coreinfra/grafana_terraform/.git'
To add an exception for this directory, call:

git config --global --add safe.directory
/builds/coreinfra/grafana_terraform/.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
---snip--


Is this a known issue, or working as intended?

(Without setting safe.directory, both `git status` and `git clone`
fail as expected).

Best,
-Nikolaus

-- 
nikolaus@quadrature.ai
https://quadrature.ai
Dir: +44-20-8145-4726 Main: +44-20-3743-0400
The Leadenhall Building, 122 Leadenhall Street, London, EC3V 4AB
