Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073846AB88
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du7mUTea"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc95f1102eso5994441fa.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155690; x=1703760490; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sr0XMxAZYpEfCXsgM7g5aN7XRY/p639pFL1udxXsCJs=;
        b=du7mUTeaQxV55/0b5IBVe6c2QccJ3fKjktynRgmW0e609cRGNKkl4Zi/0uzqwuJ5Ox
         w/GVlv4g4dV6I4dFyf4B56aMKwBW89D+SJIX5LwLdUnx3mH+kbn5OlpMHbSXkT/UK5Gf
         WVn1MVU4Us0UdlxSCj+pBzBELJjwQgPRvGXjk1dVS2UcvhTD2NIn2dWJFg0b54UgPZvE
         s6XdNrDu9TE9vzftS5gwmXAcny0fKyQeaPsDcr8GNIC1/ujS9qXccfTmKAoAukt0hCcE
         fyB1HzTLEjXS1mgoFT0CJfh7qDC+wXTM9nU2pvU4CKMs32mJNMjs6Q+tzDXAXrv0biPz
         +NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155690; x=1703760490;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sr0XMxAZYpEfCXsgM7g5aN7XRY/p639pFL1udxXsCJs=;
        b=SOYb7Jbhz7rxPF9mJu+rTC68lBWhL26MRn0TXy8DxZ0E7jYakYSjlLPsCs/SWPfL4l
         mVWtA/7UN+Nfn51OfGyFEknPXfUGGoaaMeXGk+uDstKrW6PUoc4dykotNjp3eDDUD5kT
         xqQ1D+pGuoAQCFRESkxG9ovgoa8OARs/ENrSp3iCkzHa3hz0gb272Ks9fOKo4KCwIQWO
         VyHeXCtCnYbOKr3sbrahuroURvtAUalQUEK5rd+HESb5X09pgsGakXVKh/wp9tWj3Cvz
         qTNTqOQB4BYJcJ1+vB+WOlGgvjfKBFe+W4BjdLdRLsm6yFUaSNFj6xqocN3TTjTD2yCJ
         lWhw==
X-Gm-Message-State: AOJu0YwMgVO9Y4aIGAw9+ZJ86FCD22Mt+zPVPHPJxKLxtESR3r4a9ICx
	WnKaU5zuHnxnAwtmS0TKoT8qjDThyCRwhAj2ysZT9Wtoxy5L6w==
X-Google-Smtp-Source: AGHT+IFyTi4g6Pg4m44CZw/a3C7m6FQtMLeNbnomwQAtuTCZX7IVo1ftIva9KbBJ2LLb0RV9qRFLg450FESryaUmKDA=
X-Received: by 2002:ac2:598d:0:b0:50b:fdc5:dec5 with SMTP id
 w13-20020ac2598d000000b0050bfdc5dec5mr6142582lfn.75.1703155689470; Thu, 21
 Dec 2023 02:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Thu, 21 Dec 2023 11:47:57 +0100
Message-ID: <CANM0SV3SEF28QJ2V0Q9ydp8yDbL8TDc1m871oxOB=UtwF1TtxQ@mail.gmail.com>
Subject: git bisect stuck - --force flag required for checkout
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
add file Foo.txt to .git and commit
add some commits with any changes to other files, as this is needed
for reproduction
run: git config core.ignorecase false
rename Foo.txt to foo.txt and commit
add some commits with any changes to other files, as this is needed
for reproduction
run: git bisect start && git bisect bad
eventually, when running "git bisect good" (or bad) you will get an error:
>error: The following untracked working tree files would be overwritten by checkout:
>Foo.php

Anything else you want to add:
git bisect good/bad needs to have support for a "--force" flag, which
is passed to the git checkout it runs internally
At the moment git bisect cannot be used on Windows, as there is no way
to continue the bisect from here.
Changing the "git config core.ignorecase true" temporarily is not an
option, as this will introduce a variety of other bugs,
which, on Windows, eventually will require you to completely delete
and reclone the repo, as Windows file paths are case-insensitive

[System Info]
git version:
git version 2.39.1.windows.1
cpu: i686
built from commit: b03dafd9c26b06c92d509a07ab01b01e6d0d85ee
sizeof-long: 4
sizeof-size_t: 4
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0
compiler info: gnuc: 12.2
libc info: no libc information available


[Enabled Hooks]
