Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803012E4A
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726623681; cv=none; b=WuScIYXp6JymN/rUlTc667r15S/SNXhuquer5dsrfnXLgIZVLdOh6oxtphtwiQO752Clvq3TP0/eyFv9EejE0/SZIfnDvwYPtFRzDGPyanXBCRcu9Fww1Xo7SLe6jE01JnpL0FFtSmYQ2c6THGO3evdJ4M+q8deSCaXN9lWRyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726623681; c=relaxed/simple;
	bh=EjSWM27AYhIrb0m3xYXGBxVnR+Pxax3meBPmFbsEaWE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=DoKou5Cl7ZWg1Wyw9gpQJSJjFeNplKd2mlrOum0mYPZFpx56cyo8k4KbKL9gW8cJoZF5ye4OnabpM+A0LcJRrIrrHXkTydljjwUJl8WcK49y/7IM/SvNAxC8U1+JqPdqk6FRDl8HnGf7765edxZ3KiaGPJ38AmEPksARCb7bpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXNKgyEV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXNKgyEV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so48864165e9.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726623678; x=1727228478; darn=vger.kernel.org;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgQlS2isxb0GX6j78joCoY/DHhx0X1mV8AwMz9U4g0E=;
        b=OXNKgyEV5UIvEHEoKTaLNzu8DkySs6qa31ITz2J3VbwbBlZRl3DlN3ZC/RbmFgLSe+
         eMFlfPCUuxeaUKpd2TJ1UfEpcccLTG5X+uKKdtBnUCvwyxsNTgDT7IbGPw53fMjMKHOe
         ncOkgVduTnpm8zk2jZOfiNeWwIVnkuAVZXhRPumduFcxWInRNOy+MDzRfFqXcn0Vtgk5
         vxSW9oEfuWQrjjKh2hsYNKshXI9QOl82S4fkhxDChCSQ50ZJt4JGb8WalzjVrsOO0i2c
         X1Nr0DG7nRCmuogP46ESeUKzUrK3l2y+3PuGv0BGsa5fW1jDlw8Rg2qdRaYU0NNGfjtg
         cLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726623678; x=1727228478;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rgQlS2isxb0GX6j78joCoY/DHhx0X1mV8AwMz9U4g0E=;
        b=YnF/h9/Q6V5Efr9KzxMdrYvB4IRXrYYVAEuBHOm05MBozn5aLdvTJ5ST9dW2ZwUxXe
         JICohqxUGeRU3Vp9IChAJViSVBIQOWVPloi6fB1IUv1+fva0JG9pUoyji11b/80QATj5
         6jvRMWDf/Pk1oRsa73j8KdZfZCfLovUsUJDB5KV9aefktbUbVQq8XZCYkOhSYaPXu6MR
         dELaLZbqOe14SXqU4N2yfL0N6W4k4wsKiXwQEZvFya4gE3KoKmkxuFoyOP47JG58ZJ/w
         iF63pJvq/X7jJRW6zqnu67C27cUdE4LOLLGBZECObFWU5LQSBL0c5kC0+o1wGxyN0s8+
         L3Cg==
X-Gm-Message-State: AOJu0Yw+As/Y0z+1w5ROGbtfZ6gyrKQt7WuTFDdGHRg34z6+n93gqz9b
	hEDMuiYgfiJZ+993AygUZIowhGi0XThsTuaIyempV2Qf7fbfK9a7HBH3wRR+0sjxww==
X-Google-Smtp-Source: AGHT+IHrBPMKglNbKXUtNcwJ8rBsHoklgOFTXCjeBCxlBV1/4/yfLft4rvbNrNdqiy7SuPdD/lNihA==
X-Received: by 2002:a05:600c:548e:b0:42c:a802:a8cd with SMTP id 5b1f17b1804b1-42cdb529fbamr137183765e9.11.1726623677179;
        Tue, 17 Sep 2024 18:41:17 -0700 (PDT)
Received: from [10.19.11.42] ([191.101.157.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704ec8bfsm2886365e9.17.2024.09.17.18.41.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 18:41:16 -0700 (PDT)
Message-ID: <8f581759-34d2-45e4-bace-45669dbdb875@gmail.com>
Date: Wed, 18 Sep 2024 03:41:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andrei Rybak <rybak.a.v@gmail.com>
Subject: [ANNOUNCE] Button "Copy commit reference" for Git hosting sites
Content-Language: en-US
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I am pleased to announce "Git: copy commit reference" -- a collection of
userscripts, which make it easy to copy-paste commit references from
web UIs of the Git hosting providers.  Example of a commit reference:

	1f0fc1d (pretty: implement 'reference' format, 2019-11-20)

Such references are a good way of providing context in commit
messages.[1]  The main goal of the project is to allow users of Git
hosting sites to produce better commit messages by giving them an easy,
one-click way of creating commit references using websites of the
hosting providers.  Here's a screenshot of how the button looks on
GitHub, for example:

	https://raw.githubusercontent.com/rybak/copy-commit-reference-userscript/main/Documentation/GitHub.png


How to install?
===============

Try the userscripts out by installing them via Greasy Fork:

	https://greasyfork.org/en/scripts?set=588773

If you are not familiar with userscripts for browsers, they are like
extensions inside another browser extension, called a user script
manager.[2]


What do the userscripts do?
===========================

The userscripts add a button "Copy commit reference" to commit pages of
Git hosting sites.  Clicking the button puts both plain text and HTML
into the clipboard.  The HTML content has clickable links to the
website.  This is useful in rich text editors, e.g. in HTML emails,
Slack, MS Teams, Confluence, visual mode of Jira, etc.


Which sites are supported?
==========================

The following hosting providers are supported at the time of writing:

   - GitHub
   - GitLab
   - Bitbucket Cloud and Bitbucket Server
   - Gitea and Forgejo
   - Phorge (fork of Phabricator)
   - Gitiles
   - Sourcehut
   - Cgit
   - GitWeb
   - Gogs


Development notes
=================

Adding support for following Git hosting providers is planned [3]:

   - RhodeCode
   - Pagure
   - GitBucket

If your favorite hosting is missing from the list you can leave feedback
at the issue trackers.[3]

During development I found that compatibility with a wide range of
versions of the websites can be tricky.  Examples:

   - The latest version of GitWeb is easily available to anyone with
     `git instaweb`, but one of the well-known public instances --
     https://repo.or.cz/ -- runs version 2.11.4 with custom patches.
     Thankfully, the differences relevant to the userscript don't make
     it too hard to support both versions.

   - Public instances of Gitea/Forgejo have a very wide range of
     versions, with slightly different HTML layout, and often with custom
     patches.

   - As far as I know, there are no public (even read-only) instances of
     Bitbucket Server.  I did manage to test the userscript on several
     private instances with versions in the range v7.21.* -- v8.9.*.

If you know publicly available instances of any of the Git hostings
listed above (especially Bitbucket Server), please let me know.

I originally planned to post this to git-users mailing list, but it's
gone now. See <https://github.com/git/git-scm.com/pull/1829> for
details.


Footnotes
=========

[1] 
https://lore.kernel.org/git/5264c44fab5d64cdfea8ef9fe2c1088af3d41014.1574211027.git.liu.denton@gmail.com/#
[2] https://greasyfork.org/en/help/installing-user-scripts
[3] Issues are tracked mostly on GitHub:
       https://github.com/rybak/copy-commit-reference-userscript/issues
     but other sites are also available:
       https://gitlab.com/andrybak/copy-commit-reference-userscript/-/issues
       https://gitea.com/andrybak/copy-commit-reference-userscript/issues
       https://codeberg.org/andrybak/copy-commit-reference-userscript/issues
