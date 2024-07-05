Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C51474A8
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175318; cv=none; b=qeP9KoUjwnfcrq+JWal2hSKfkwH3+SVsAslCn4OTshk4z0qNoUWRb969G/fuE4HBKsTak33tRw9Dad/UySBovB2XPSAR1VDMWROptjnVONl80CmMexANbDQhWDnhvKJYTrKkulGGfcdUM+j5NKy+tKY1q3CMi3Qt0bwvLoahf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175318; c=relaxed/simple;
	bh=pitMDZ4sEy6Dv2CY+YiacJ7IbQhB0Ah5aWxVT3G7PFQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Or4m/sMggga5N7ZBDRB8nc9GedRyTaY7hZeddY7hB3v6u0HmCjG5fMuzv/UFcASZyR0N0lNHWRNzU0SMpaOL066qdarjrYqTVTtGGGvVa+KkUWtVFno8Dn4GWTnUoN7h7SE0mojRk0fji6ERZmdQpfcJs6LRQBLdA16Qhq9p4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kewRDWb7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kewRDWb7"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso1842396a12.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720175315; x=1720780115; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OYzAropKXlN2SVt+6IDZSDJuSwl2SixQ0w9D2lmUE1o=;
        b=kewRDWb7UluSKvRIDv+uXBGrSHZGIZlDaZqR6hkNRk5lTJNlqUkS4MX9Zwo2lDUaGn
         RS/jQxlatO2z6uhcgtC0cbvmAheViMGo4e/JVa6qzTeTACpvygNfRET0DTQO/F2zLsXE
         p7CyxzLQvmTEmPSRfag4WEVeQHEcJXg+UeNqd67di3BY0UJnHpYvKWgwRqaNBpEKaOgf
         XTUg+ncMhip0IzETiyrZ8+2zSx3Iv4kF4yK+m0WbO+B1mQidyGDcJEK2rYU2Vi3Fz8Bd
         MRwrJfcW9O9Mq0dFMLk8PvspWJWHWs4fvL2Xg2QYH1H0atSrUb6AuEIOGsmIIVmsCmgB
         etZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175315; x=1720780115;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYzAropKXlN2SVt+6IDZSDJuSwl2SixQ0w9D2lmUE1o=;
        b=LOzEgF2upAIxK7OEldy5LQ/IJPaP/toz3IJUwE7iCuZjgnJzrZ4WOvCS5WMAZIje5N
         J9V4GEBfVRGCgb1DGZi+d3RnbiI37xcH4BlolgiE5eMn6buG+lJrzyM+O6O3penVsZK3
         Id6x+WfnIV9LE4QFyEH+85JEscjGyXZWLjq4JL4Rry3LaoyEy7k1oFMgzABhjKElIu7P
         AgAvBwdPptXF6HuZGmDJu568fHsxZBZnEAYM9i3b7zrtZ8+rhMZGE+fQovqaxXwIUC3m
         5e8LP0AW5IMuksyxFG39eHoydzkpWV4NDp20XwFHh21zlGTdaePkhdvIEwcUCBowlHUA
         st8A==
X-Gm-Message-State: AOJu0Yx4baGPldFf26OpV/WuhiC+XIbG97MplHIbGdedPNEhNvhUBaBf
	3eguDMNyvIKpZ4yy/EKktxKA3lfmq4ayYAviRO17E1NKJwCcDRS6UaWIpcYGVLc8354v04iO6MO
	5r6xMLiW2FUvJpaUXn1R64RekWmvtZQpS
X-Google-Smtp-Source: AGHT+IHZxDfSi0zRDHN2IETm6KeM7iwt4N1GHIYbzraQis7njuXj9CGuX0abpZjYsWyWqeG5WUIuFZ7kzOrFmVX7reg=
X-Received: by 2002:a05:6402:2106:b0:57c:6188:875a with SMTP id
 4fb4d7f45d1cf-58e5c73066emr3154264a12.26.1720175315036; Fri, 05 Jul 2024
 03:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tiago de Bem Natel de Moura <t.nateldemoura@gmail.com>
Date: Fri, 5 Jul 2024 11:28:23 +0100
Message-ID: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>
Subject: git diff-tree do not honor diff.orderfile config
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
The config `diff.orderfile` is not being honored in the `git diff-tree` command
as stated by the documentation.

What did you expect to happen? (Expected behavior)
The output ordered by the pattern file.

What happened instead? (Actual behavior)
Output has normal order.

What's different between what you expected and what actually happened?

The order.

Anything else you want to add:

The complete command that I'm running is:
git diff-tree -r --relative --name-only HEAD main

if I provide -O ~/ordefile it works but if I add it to my config it does not.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.44.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:14:38
PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T6020 arm64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
