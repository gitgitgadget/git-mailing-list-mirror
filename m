Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506D1ABC25
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101391; cv=none; b=rx0Ka9tYDqUPY1G9wZ9VaPidpFLq5h9K5/7fxNYM5iiRWJ+6brzmwv3KAifVSrCKvPL0JI+ZslN3JFyYhb9NcZ8xAk/y5+1zADXhauP4froE/NG0cUY7bl6waBSHTX/b/VECjzYd0efyfHRPhnGTWGcfuHSQz8HtMf17icqOeO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101391; c=relaxed/simple;
	bh=AqhYgqxxvRMq4h6Rn/8UsPSY6x70ahPDg/7eAD4QqQo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QwahmsY0OxUrPksz7E+TAUivFhePfVbh93lG18QfznL77Ntn451z/rUPYnCZNBVSpbxjBwuNEWJGR/QQgT8nUYCI1DnfqOKgWTrWdv767DAvpG8uJjwqlD+odikcaEGEkbwtD3RspxIhfU4dqX9b3SwOrCxFKfsWX1k/v8D9opQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI/VoGoV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI/VoGoV"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e98087e32so719940e87.2
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720101388; x=1720706188; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AqhYgqxxvRMq4h6Rn/8UsPSY6x70ahPDg/7eAD4QqQo=;
        b=bI/VoGoVDmf/2t+cvU7PbpmwRAdxTxBB2KYjX7OtRQdvlTMDNqgyrEtQBAFdaXqMhk
         9r6VJwRKufNvJPYCX0txwL+/qot0ub6LJIPsXGLWBF1IoJ5+jfuV9XHwgEf3X0Kcd2QK
         tQ5Wqm92WLLgsc7GVYzwQBRaO/hCY6QKrAVd4qQCazRCGWljEDgT0DEOsnN8CVZAqxzX
         M1H0NlOqgwI+bGSdLvCl1n4iWqLbndzFpI0EWZzguBN1j5k4Ixx3qsLeCdKPnvKh/lRX
         oA4zS7fDit0Ma9McItOta5OfqCgkixIxRaOTzXiLm9kYs2HJVQGm2o57EdoW3E+ZAkw9
         Wpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101388; x=1720706188;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqhYgqxxvRMq4h6Rn/8UsPSY6x70ahPDg/7eAD4QqQo=;
        b=wQ3CqsMT9Ioxl54rS3G2x8FXRKIC8sVQ1mPmEtvz5MCftSpPLrguVcGf8/Aa4opkQ1
         M6SFWK+MB2J+8xLXEuZV44tROy090qNr6SFqFkRZll98VPm/7aV8TP5zmlx3/+TXHsy5
         kYLAGi0mxCJCcXnt5aXiN8Bk6Zmu2mFJZhA4tVlso+9m3fEbctOlGDZ9s74p/Du/GB/N
         wnE52Zlzi8JUeU6g2ucu7mjgFE/XA2DcTn6gfEF0tBapH9exEoC5FHuQDm1pny+9SHn0
         YdXoFsHfC4nQI26GON5bE6H+CJ7642WpFxTvpoXFJUM6LXo3sSnf9FAT9HyCrBs/v1fi
         RfhQ==
X-Gm-Message-State: AOJu0YxIC92DpIgukBB96B+Gg/nOKykmBTJcMFMWiMuk13M+3cy/YhCr
	/17NZfLIi3amz0fRIaAKSEBq9Lqg65WocWsqEZRK7KgQvz0XouWmsTLsUr20HjV93mk02eOwSNK
	hCaVkT1Nv2M0yIh8FnzRuAzY3GpdX2Bv6+BIfNA==
X-Google-Smtp-Source: AGHT+IHu1jpkgzzXBdEuhiwsfQx3LxEUKJONhGdjQxwJaZuxMtJ7N37b836D7osXXq2+kwywiemHWSiJLQoTU5V4xU8=
X-Received: by 2002:a19:ca13:0:b0:52c:dbe2:69ba with SMTP id
 2adb3069b0e04-52ea0637929mr1104055e87.33.1720101387739; Thu, 04 Jul 2024
 06:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abraham Zsombor Nagy <abrahamzsombornagy@gmail.com>
Date: Thu, 4 Jul 2024 15:56:15 +0200
Message-ID: <CANoqcKYwgA5sT0fAgSp4atpuPOaUSDALRVcf9XoajOe0g6xibQ@mail.gmail.com>
Subject: Unable to push to git server
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git Team,

I hope you can help me.

I'm trying to push my code to GitHub, however I'm unable to do so:

abris@dell:~/Projects/maradandohalo/server$ git push --set-upstream origin main
Username for 'https://github.com': nazsombor
Password for 'https://nazsombor@github.com':
fatal: protocol error: bad line length 175
send-pack: unexpected disconnect while reading sideband packet
error: failed to push some refs to
'https://github.com/nazsombor/maradandohalo.git'
Enumerating objects: 31, done.
Counting objects: 100% (31/31), done.
Delta compression using up to 16 threads
Compressing objects: 100% (22/22), done.

I use Debian 12. I tried this with the git installed via apt as well
with the git compiled from source code. Git version: 2.45.GIT

I also asked this question first on StackOverflow:
https://stackoverflow.com/questions/78670914/git-fatal-protocol-error-bad-line-length-173

Thank you for your help.

Sincerely,
Abraham
