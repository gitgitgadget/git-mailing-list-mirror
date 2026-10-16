Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D80212564
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186546; cv=none; b=MeSAvEHGFMJqE+jhMaTW8rO/nLXVlJFiX1mTt8wxI4SiZCNKOOVV26FZrzjRCtCH9wFxypU2dMS3ODel1+b0tc6ame2rhxYIj6er7di28//Ulv3h/6BixN5+JmXbq1daVA/ebcaKJPH3+vaw49ej/cmVvFG8e3hLnLS/cSpJNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186546; c=relaxed/simple;
	bh=/mHrGUhX+ry+uVi/n65Go7I434Ovtq3wqFzArpyj3jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fx9ZRCf5T9Nio/uZwhmvFsvKGlQg2BnaOu8f54M6U90V0qdonmoam2YpzIPQU/ilPfdBkuq68b3NXhs75+ypzhjxi+d1mmHxC0Klss0+Od7baKUcEOgRWLApuRoXbYS2I7+5hGQlXDlFa+pptidUSJiYcrusfWKCI/CBSFeFDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an6Bjl7I; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an6Bjl7I"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-486e8faff03so111961f8f.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792186543; x=1792791343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJZ+H8PaVuwIaWIdzYPzmc1qLr0tOahe7aZsIJS9z8w=;
        b=an6Bjl7Iv90DcbimBKn7szGWTYX/TcRvOSqNTHpMuzjYGCGB+OlQHlOz0izsKLrOIu
         BoivuKABPwMztX1cW0juX/JNlEoCFwRZTGDwUUrhlU8V7gl/60Y5eXWNEXVTD8/Q5mNh
         Pep6sjWM5tkORfMJKNmSRYSvvPi5zZAGa/2PetnJr3Y3g0LifUTA8Aa9xfianMEzK4Tz
         sW3Lg16XqFaawBP3EWjdw0djBIcUsS264P/MGRgFOyHHwKVxHVMVXne7D2D0zTQwuwFb
         F29DnW6ja7Vv2m6XuQdyenkdR5obG8LU9tOXKixViRRjM79c1K2Z1UVm1tHtXPozUazL
         g7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186543; x=1792791343;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJZ+H8PaVuwIaWIdzYPzmc1qLr0tOahe7aZsIJS9z8w=;
        b=FE/MQ8yLXqVyyWJfTOECpB0qrpF/9MXAjl5Azk3z5eHyCb2eBhLm5Z3iu/EnFpOOBz
         i6sLK20qUJ1vEfVBEpZrvjG40lH17bvu/vJAHPNw+CaAT9JhlwBm+szXNVmm8edmyNf0
         +PUD1UgaZyW6CWFP2deZ/9xU9pOP5XM+kgQH7jwO3+sfLHDL7mJKawWwwEevSXAVOV7L
         R+g1ImNPMQ6LiQ7FtZlscxD+wgGPIGfkyDDXbFzfABaHQUMUxzIJgobbBrXOyXu/DxFc
         q4OndEejp8NYLaP6ixAjvUrwqF/Po6tVs/PXgW+jNCggSiMUUF1JMfWvJCzEq2Rio5mW
         P6Lw==
X-Gm-Message-State: AFq9FYJJD4jZv0GGbLfIiWvwCzwtm9JtOGAVtvRip+yReKwlyitj9DQu
	81icjXcGOpKk9YCarvLrggTGCqhq4x6uIXOgvKi2BZnSkyjRQ0JLXzV9RAqOwqQB
X-Gm-Gg: AYBFou0FKi/cou1CodVAK08pIIeGMbG7rIKddIAG6Moa25850KK5vr3CL1qxbfDEC/o
	pGpyuv4cINAvuH/4I2rTqk+gGTs256EMppnFnhiRCeCr1zR+1Pd7CyYd+pey8IOI5Mxiqw72rEE
	Rbcj2ysbGt7UhTFU9hz+crY6Y1Tko4kpHWOYen1r2g9sfwE4QQTrQ1/WJ5srznMHfEOAxRF3fHm
	a7K8HF5lFDWDFdw7cadjsPPkfCkOlGkhfVMT/t2VKH1CMFUVFoAUea8IisZ1uZ7PpXZCbWb+9qr
	eBjP5+6gxuC9lSJoiHgeb/CLPN6thE0PeV4yDoUEbkHKVYsxFwAuYSQE4GF5rRojg13Cp4XrJi6
	e0lZEixOnpKS+UTmu57akJaXoX2quSE43AKFr8GdfE9szdSOURo2btQh/75H4jQBO0GYs2O4gNI
	BQ7Oyw7MWpEsWY/+m94gJkO9bUGh94ehxjdJZOzJZR0R1trgAZK0zDJPnML4Ig0wcB8XgZpZCee
	LgKgR9l4vTd8YVJM8tS5nE=
X-Received: by 2002:a05:6000:b48:b0:48d:f491:3517 with SMTP id ffacd0b85a97d-48e07fe394emr1116061f8f.52.1792186542757;
        Fri, 16 Oct 2026 14:35:42 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4978sm6826664f8f.21.2026.10.16.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:35:41 -0700 (PDT)
From: kerylefondji7@gmail.com
To: irungujane613@gmail.com
Cc: git@vger.kernel.org,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kerylefondji7@gmail.com
Subject: Re: [Outreachy] - Jane Introduction
Date: Fri, 16 Oct 2026 22:35:05 +0100
Message-ID: <20261016213506.4534-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jane,

Welcome to the Git community and welcome to Outreachy! 

It's great to see your introduction here. Going through "My First Contribution" is a wonderful way to start. Don't worry if the codebase feels new or overwhelming at first—take it step by step, and you will get the hang of it very quickly. 

Wishing you the best of luck with your first microproject and your contribution journey!

Kind regards,

Keryle
