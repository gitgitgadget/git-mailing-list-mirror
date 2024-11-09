Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E0C8FF
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731152482; cv=none; b=IXvPDwMylfNX37GHdIqKjMEqVZyyAXK1XxVHdGlxf8nkFBLy5xTaiPjKnMqey4EVdaSvYzqXEPw5IbJORYRSrJRiAhr3iNPZXH6MUeIo7XmybqJghJGE88RlHF8H06RzWzAdvIVoIyOVQeDirGM/CYrt0g5RKBPo7PjSxjOEjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731152482; c=relaxed/simple;
	bh=ebEmuWSv29ZRkDbQBwdAbp4Sqt01AP4ur6NcIjlvqBw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dlRIyeKz3ypj1asr/N0tQZdT339QpvYEj40jgVeVYK6XTC76FpDy3LvBTeFSmoZUn1qUM54jnCrYDG9PgxnmYd4ByXV7IEWAEnM7BT5h8d9hP2TISy2rWIml8YPiH7cCtzzOIOaZkZ4grqoaRO7I8GpIURlq8fNJwqYcjCKL68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFoXjveo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFoXjveo"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso2475915a91.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 03:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731152480; x=1731757280; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ebEmuWSv29ZRkDbQBwdAbp4Sqt01AP4ur6NcIjlvqBw=;
        b=MFoXjveo05Ip1+3EyrFeeZ/jY5z5LmoX7AcHWFW7NPpg33e7t48frur15eznzKQ1uq
         MJZJGDK9nP43mMCfXfQA1TqBVloB8SS5zj3bbJRSPXBiXjr2C4XgKwrw1O+L9Wg9pxNB
         AcoZRrqcWG0Scq/zeQvkm5SL86+igjFmrVN7PnKRgtxAxZF/H1X5W4F2gXb2HzDesdWb
         Pp92O+LeoIAJpDoz5fshoJipTS8M4FPOntI2iED/R8l9k0SuMwbPm3Fasj6zQeC3qzVD
         m2WL8P3B8EDeL2ISKu/ejSIOeOomXUYeKINm6ojceF3SSsYxQnLxI3RQGqyZv55FJZ/v
         vimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731152480; x=1731757280;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebEmuWSv29ZRkDbQBwdAbp4Sqt01AP4ur6NcIjlvqBw=;
        b=JiEW5lqcUmt6ctRGY9dJJ9x6tlEJi1GHv2YCNOc8p1sXe4NLG42227k9B/tQ84c9RJ
         RcmZfM0INH3UBsQ9GqwH0IcROUH4Hj3enaLdLECINKbd5cby6Axgyglq9wy6+RnwPvU2
         dmclwg9Ot+lK7tYfbbBQE2saHgGBKl0xbCxXWG02yYFqC/riIIhjGxqcNrbU1qtfcEAO
         gHDfSzgVX7Wz+PRyEs/EUzkmuzceflePtIdn5eOEl2QlTJ0JeNKJxrU0IjygcGC6weBM
         D4hDcPwsQ3oM2btPHbf9yfkHWnXqgo7TYlSlcJyOG6s/1A0/CFO9x5gkKl8olUfoVui9
         /kRQ==
X-Gm-Message-State: AOJu0Yx1ecMzlPhal4CrDqZOL/BDShnFZ8GX08+kksBRga+sHX3tvxVg
	mgWEwvBLjk0ftANoHVA9n5Z/8zSM09PhjOzVNX9wLnIYFgrJFWwwsRauEFRcbM1QG5AgeCaJuwU
	+5wWvwWa36dXT07as8r5qrMVC+an0JN7h
X-Google-Smtp-Source: AGHT+IFEH9A71Mk5zcNCFJ6+9ZeP/TMPV8MgB+s9Dg8jV9A343ir7R6CEwxEO1WZlY3F0FLacrZsOD/u+7JkNigd26A=
X-Received: by 2002:a17:90b:1c92:b0:2e2:e743:7501 with SMTP id
 98e67ed59e1d1-2e9b166bbe8mr8084786a91.8.1731152480226; Sat, 09 Nov 2024
 03:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Imre <martinimre25@gmail.com>
Date: Sat, 9 Nov 2024 12:41:08 +0100
Message-ID: <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
Subject: Feature Request: Interactively pick fixup revision
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

first email to this list, so please forgive me if I'm doing something wrong.

My usual workflow is using `git commit --fixup <revision>` quite
frequently, as it eases the code reviewing process and allows for a
clean history later on.

One thing that is always cumbersome is to first find the SHA of the
revision that I plan to commit a fixup to.
I usually use git log and then copy the revision.
I even wrote a script that eases this process using fzf:
```
#!/bin/bash

res=$(git log --oneline | fzf)
ref=$(echo $res | cut -d ' ' -f1)

git commit --fixup ${ref}
```

I don't think fzf is really necessary here, but it speeds things up.

Anyhow, I'm really surprised that this isn't a feature of git.
I could see a `git commit --fixup` (without a revision) or `git commit
--fixup --interactive` open up the git log and let one pick the
revision they want to commit a fixup to.

Cheers,
Martin
