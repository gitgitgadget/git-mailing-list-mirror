Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E407205E23
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351509; cv=none; b=eDyL5E4+ArVXeFeOl6C8jOguF5a079+0NraO4wzmvJ1v4vP3/MPOo+OId0J1Z3Bevs45abRs8slEWs1n2lkBETQ3Zurjz1bkVIhTK4vT5G2dBSVY8ArKbw1i5fHHEu5Tsy0JPR4DJBWyKcYjYISKv2IqW+PyrOEBIFFpzB3gjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351509; c=relaxed/simple;
	bh=yzQiYI8IvBFqzj+ReNu8wT8Wi9NWRvSxSe3RHoPp51s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rJ2nWheimf9UJPCTVJomZpqCNNxgw6eFBvHFV6e9EGuhitXkHnO1BDXdX65UGDcs72OA3LN6p4EUAWxmvmd8XLHEpEVCOXZ6qFhZdF2neg7La5FT7OY0xc5VcoM7Pgsq/NHOHGLL32o8bf6TrmV9gkwxcelPPeBWTj4h58ueEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LavFRutE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LavFRutE"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so3328779a12.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725351508; x=1725956308; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzQiYI8IvBFqzj+ReNu8wT8Wi9NWRvSxSe3RHoPp51s=;
        b=LavFRutEwHdEIVOwTyFs0JGVg9O+7JpoCjXRUK41QK6t14skqSlwGxaW9hV9BBL6Vb
         36btB3XA586tjGC3ZvXFESOwV5Xi8kxC3RB/ru9mnTjtWmDeoaO4x2ZmNGF0YUbsq9UU
         ouwgpb/wykxdHnEuMoK7IxRSwMlEnqh3vakHNwr4VD0h9pNhLMaI+ZK5yoM7A7DXRjzk
         Jvk6asFbUVJljQ3MjHM2OjXJjaesUCsVmlZIGycUWrvswIhM7e91PJ+fC3AZyJ1z54pd
         TnMqnRZFv00lpAqVa7f5ojpV0TowmbiJ/4EW6FbqKTdTW2kF1VG83L5pPGd0GDdDjhC5
         HzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351508; x=1725956308;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzQiYI8IvBFqzj+ReNu8wT8Wi9NWRvSxSe3RHoPp51s=;
        b=WVMhZoNjdKo0hmDacffmpdWmTs1UA0ckhzcdb9DjD8/YsPXqRp61CSPvaPePXLWTj1
         vXRmhsl3jFkY4Neynku+Y2sekfJLN9B0VGhRCqI/GcM4uGLaReUVdfwRxJ8MVb0qfZHo
         u4nQcHw9jnX2N8cSk7m0StTtQgwJeCFPGdlKIZadY6edTZsfwZxflirh7SPBat71fdeL
         JiHG7a4S7g3dTGm290ejoEryjlAwFYQd2kGtYK/83n3gZ/4qAHMWRhIZb3AnoesRbtnU
         yu5adQ26zcRTVjvdZjHLI/bVdcxRXZtRs4hpLAHBnexpx/n0L6+U6w8Jok2dF99r0WSM
         D7iQ==
X-Gm-Message-State: AOJu0YyTSjpJcsJxP+gvy51Q5KvULer2YksqJU913HME71V3b/090H7U
	EhEn1PwzKxGx+ZWMP+mZOoLCucp2bGFkrBTWWEAzIeNYw0OuOd0xkyGtivGVkY0vz8wpulVFZXo
	ZYdM9nrbYtSS7UGMT0yVackfW3oJjZjXhDJw=
X-Google-Smtp-Source: AGHT+IH08dAjD1B+zmlv55aX2bZyzceg+n2JpunjEu63qwo13Jp9CZUZ6m7s3IzIEMarv9klJF1WgsqPWQQME1yLohA=
X-Received: by 2002:a05:6a21:999c:b0:1ce:e6ff:df29 with SMTP id
 adf61e73a8af0-1cee6ffdf67mr6668404637.14.1725351507561; Tue, 03 Sep 2024
 01:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Loredana Tralli <loredana.tralli@gmail.com>
Date: Tue, 3 Sep 2024 10:18:16 +0200
Message-ID: <CAEO06G+SLu-LAe0mkR3ZbaL0MZpBm9PhntQjF-YwVPMtnuH=rQ@mail.gmail.com>
Subject: Ask for feature on git
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I'm a developer and I really use and love git. I'd really want to
thank you for your big work

I'd like to ask if exists or if it's possible to implement a feature.
Is it possible to have a git command to find out which is the parent branch?

Thanks and Best Regards,
Loredana Tralli
