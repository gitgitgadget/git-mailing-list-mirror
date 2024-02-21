Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28225232
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556291; cv=none; b=NG2ExjqHkLekxM+zYPgQfxoSrqHq3w/1q5XmYVks96kovHER9rz5EsPkZZ/zufFAjLBVKykdNd/bwSyk2S/4e0maRCSHBmlaiEg79aGZPaiLC8eoiBB3BlLjliuRVXxuJD/6CNhaTC3ysJl0+iTp7XnlZJ9bXE77e15k2o4wsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556291; c=relaxed/simple;
	bh=s8D0YQhBIOZDDdNu2ZG9PR1pz5U7pamzS2LgLKkXeMk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VpIpAzbyU9TBNK3Cb98UwGlltLzUP7Og+kR0veyV2/vpLlbc/54Vp5WLIcbYIxUbjcpH33Z88v1qmbkejuBik5P9c4RJAwuLGhfhtYi6bniMdTtaFvLscxwy83qc9YS9/Sjnph84g+s+kpJxAFUJC1ztONY4vOxJbEB5mo/0G1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnJ3saLq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnJ3saLq"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a34c5ca2537so153143066b.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 14:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708556287; x=1709161087; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JRhLanQriJxLvKus3UJjztxrB88EhAdRkUBvMSPxnGE=;
        b=OnJ3saLqr73OvEnw4ecjMwIcykx9A0ehmPF8Eby5x2yfvCrHUxPcOQR+Ity2c70hQt
         JxCwfPP+JtrRHzrxevVFNt4Cscokx5GiFUtxoU7WY4Oc/YRZNONDGTEdQvmUn711imUj
         pisceuqTnEBql3FLvetBJcMKoAKzDoNoJyZhbqUX1/Hf37TRRf4CbRZXKh+GlUfdFU9n
         1OT+Pb7YCmKEn+O3PrzmvsAK8sL+3iVqyHU9eKiu/sFq0ZWP2yrA41htYZStiGSwuzGL
         FsSdhBFzT9ItaFs2bQdkTEwp7/yt9fL7eg1cKnUuHmE+CO4TPXLodKMjFicS1C1C3XMW
         Ig3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556287; x=1709161087;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRhLanQriJxLvKus3UJjztxrB88EhAdRkUBvMSPxnGE=;
        b=mIfinfzb1oKwahzGBU5DhnKBRLoFeCEDQgVRhvGLRX/AfIhAu727GI8mIzqfmUbKVj
         LsKygwovJWA3b9KpSOXDYdVqHRIMZFANq5BXO1pIG3zizk/y08E/4IFhLcP8CEDTpsrZ
         haf7hI7oPswobdNoX//QpIPvFFZNcjupo6qEGZqg4YuDKnk0z9Bt46owb4ZMz60tOvWW
         EKWTvit/GC9TNZqkOACLEWoJaPOS6gkvvPtNwYmfFlKU6Hfwv8PXfE76LmadHFpkw36t
         hXxe18Nk4u6K9g7+j+pWOC38Fi5VQkq/VEXldhxeLcsh26BqU1tji2c8D/PF60Gnlose
         +aEw==
X-Gm-Message-State: AOJu0YxXKkdlVS/QK3vw8vHsAHYfj75yPijDCS+yb1KjBOBXxe9X/Vp9
	w91MgO4H7IGgdBF4XdeOvLsZ9ltvmJ5LUvBXUPbmarMdjPSCIyVRzdSTVQ8X6AQ4n76xPRDW7mq
	GdZR1I7Y9Sg7Z327lBFJmQQMgTXGDBBTHq1A=
X-Google-Smtp-Source: AGHT+IEVkvW9x8LX2AK+7Oej2IHzbE23L2uD6YshAOQPrVeuGY7yvVSHYgMg4WxBVqyS5n/n8RUQqhQzCSvv57Ppip4=
X-Received: by 2002:a17:906:1197:b0:a3e:3f42:11a1 with SMTP id
 n23-20020a170906119700b00a3e3f4211a1mr8280965eja.66.1708556287166; Wed, 21
 Feb 2024 14:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Wed, 21 Feb 2024 13:57:55 -0900
Message-ID: <CAC4O8c-tgDQ42upWorMi3Cw+KdPoHT2YxvZEirt_dtjQXreXAw@mail.gmail.com>
Subject: script to pre-build all commits in a git-bisect, and use them during testing
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Problem: it's annoying to have to build each commit when
git-bisect'ing for something that isn't being tested automatically (so
no git bisect run).

Solution: https://github.com/bkerin/git-batch-bisect

It has an interface almost exactly like native git-bisect so it's
super easy to learn but it handles a couple additional commands to
create worktrees for all the commits, parallel build, and test in
them.

From the README:

     git batch-bisect start bad_commit good_commit
     git batch-bisect runinall 'autoreconf --install && ./configure && make'
     git batch-bisect runincurrent ./test_program
     git batch-bisect good
     git batch-bisect runincurrent ./test_program
     git batch-bisect bad
     # etc.

I'd be grateful for any feedback on this script.  I don't actually
bisect all that often, so it's only tested on one real-world project
so far.  I thought it might live in contrib someday if it's useful to
anyone else.

Britton
