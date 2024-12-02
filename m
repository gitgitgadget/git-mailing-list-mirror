Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5F1DE3B7
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161010; cv=none; b=uEiS0dhE5L8thQLYR7XkfjFcgXVjSuPHTn2G5kvkfIMAmDXFO48JIhYmHjOwya4u9hV+lRjXCKmxR4M7MDYn4Hg3nRQOnhuc/ugfZ8CAjqqXBmSzu8BQFnjv6rWsZLepL3FhpbgvdkL+QWqK5K5XomKYuVCrNT+fETOA9rnBPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161010; c=relaxed/simple;
	bh=xWrXKAjaE6h4i4IDMA3OA9+MUvEIQxDIanVreIn4gEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YSnnLiIHipf9xeOAps6wNoUhVXiYnInwiHIu/5rtrcvmcLBeuPDbAZYjz84/aTwwpPJpaZUgNsxuIeI5bDzO04Xq5O6NOwHA8Vwr9fGo+GQEJ1cI4+b8LfhfZwGW4i3/7EyoyQXD+y6fs+Th67TW2d31456BniTm+AtPJK3iax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=instadeep.com; spf=pass smtp.mailfrom=instadeep.com; dkim=pass (2048-bit key) header.d=instadeep.com header.i=@instadeep.com header.b=ZzSSo9LK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=instadeep.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=instadeep.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=instadeep.com header.i=@instadeep.com header.b="ZzSSo9LK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434aa222d96so57578405e9.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=instadeep.com; s=google; t=1733161005; x=1733765805; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xWrXKAjaE6h4i4IDMA3OA9+MUvEIQxDIanVreIn4gEg=;
        b=ZzSSo9LKUPxBvFcyWPIKvnwYftBWnybdl7ABALHqkqdY68Cknf/vFJG2hD2L8o6Wlb
         g+3PT2M2QuK70rdMYZfeEL8jbtqCgWb3BvrCoxhB1pjPnsDXduafBWue5El8WCJQk3B9
         87NvbsLVDsXTfNLi77PF+zR7aSeMDqfLqgJX43BTcEJEZ5aOW49v6sjVmUnXlc+FQLI2
         a0bpa05QI7M/Tq9AGAec0uKsMuTS4Z7g5LtZp5hOE2a15TZqKuFzY3ml07ah0BAv7ggr
         HNeHvOfgpWtalYx8oVBN9gwvtym/iV+wZppcsj096V6so8oFkDx/apFnPJnV8T3Jb1Tm
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161005; x=1733765805;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWrXKAjaE6h4i4IDMA3OA9+MUvEIQxDIanVreIn4gEg=;
        b=k3qMdqOCYl2l7QfM3TSOb6QZRj3qr7+A6Dhgs776KE9wnaiW/cfbAlIpvbzpr8TNlM
         2h8P+q1hWbBhe083ZfALvl3W1krMiJShAqf245eWpMJtsqL2iOJVR+hKWOjrrhdJzNAX
         T7UqBY8ips2lU94TESeY2Ar3dup656N0M/G/dMfsWTqKn5D1o+zc3wIDwckyS0oNDhby
         7g0BrznyZQMeh5q5wo7bdPPHkdw06eObdGCuurFJ1LaOz+hI7mSk36TYUPjxOAOGY7y2
         AeC7PH3HMY3y8SzQuV+N71COg9cSWYPg9UKOilocURWa92wqeBGvGKC3svKRodNu+61u
         N+Nw==
X-Gm-Message-State: AOJu0YwRBxhilWvLsJK/nBT3wxNoIkAYD2WNye53w11FeOG9IXjP/mcv
	9xBn/ItEeeW/EfhJSQXuKYV68GjKAjWYW6KmzGK5edd0WsiPB+0Ft8d4AcViNsildUoY8OijM2M
	7+MkkKQbtc4KBozNBWX1fOp7U1YusK6yVd80RDlh5kkdMNebBIlk=
X-Gm-Gg: ASbGncus2HANtg8yOiTugNWYe40yFYSGcIBqYR2stRwfjGOErWbeEcQF5JyZGFATtIA
	+KNt/Tk0/DsqGZUzaKfgjOR5ornE45A==
X-Google-Smtp-Source: AGHT+IF4i1sQbMlbeMmdFd1m4L8ncWRC+kuMnQXvq2xNa04RfKhfqGJOGHLxbCwzlOMZCpQEbbxJjUksJxy0jz1tuOQ=
X-Received: by 2002:a05:600c:190d:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-434a9de9444mr247767545e9.24.1733161005381; Mon, 02 Dec 2024
 09:36:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?R=C3=A9mi_Debette?= <r.debette@instadeep.com>
Date: Mon, 2 Dec 2024 18:36:34 +0100
Message-ID: <CAGinwDzTDexiXpwR0BGTTgX_9BcQ9N2RSea2UBTnyurCM0QRfg@mail.gmail.com>
Subject: Support of NETRC environment variable
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This email follows discussions on this issue in the uv project:
https://github.com/astral-sh/uv/issues/9576

The uv project supports setting an environment variable called NETRC
that allows setting a path to a .netrc file if this one is not in the
expected home path ~/.netrc
Their documentation describes it here:
https://docs.astral.sh/uv/configuration/environment/#netrc

git supports authenticating through the .netrc home file, but it seems
it does not recognize this NETRC environment variable.
Would there be an alternative way to set an alternate path?

Thank you
R=C3=A9mi DEBETTE
