Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116AE59B7F
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225790; cv=none; b=AIRc+DthLs+Hq+Pe5ZNxJ/32h3dMQvJipHpJklvs6auwtBJQLKnKvXKha1dO0O/Si6kdBcPeu9QJLtXhquUqIneJJxd2HrHBhnB8QfL9xMej0Om2EoA5iyOS5EBJqBnJvZI4e2Uk8jJ2frRs31k35MN4mLeAagjkjRUKRb4De1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225790; c=relaxed/simple;
	bh=EGZgZEFibO0lvvNKDi3DiuB8aKFzW2hy+Y4sUuIGDyE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KZYs65LjgnTFuZEZXIBXi8+c5SLqYt+anzmBCDmnscJL1ZITCHbjz9778ZGL+IIdMLdjqR9Poo2c8uk8OGxCkUTfiamQ+Y64jGQNdidkoLxYyuxqP8QzZz5CVnQjeoVkGYOOOGS0FnWNJEq5O2AWizLgt3eM2hCRgqYaSVbaBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badez.eu; spf=pass smtp.mailfrom=badez.eu; dkim=pass (2048-bit key) header.d=badez.eu header.i=@badez.eu header.b=HwfAlvj2; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badez.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badez.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=badez.eu header.i=@badez.eu header.b="HwfAlvj2"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V9HZs3WDBzTrq
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 12:16:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=badez.eu; s=20230704;
	t=1712225781; bh=EGZgZEFibO0lvvNKDi3DiuB8aKFzW2hy+Y4sUuIGDyE=;
	h=Date:To:From:Subject:From;
	b=HwfAlvj2mveiDlO8W6IQVbv4CNv69BJgoNk+IvQHuDfMUro1WXGwKBGq6VKzNWeik
	 DglnKMEL2oE+ifQhUcaIsOMUwylEPKg7KRz9ai9EtShUE7LafYeHwRAK/X225y4BK7
	 BKlmenipnGaj3YbRFmW+icDjFNP4HxqSjGwH1n/a05MCd/LoZppri/ecvxlqXEk9aq
	 T5/TZco4hxNcETi8y23cbgybHbKRIF+6oLbZFuUbql+eKDMmwJu2Qzc8woWOEQp/Jn
	 rIbf2ratUCoL981n2Z9uIg/WeBGoezXPhXN2dJdsGTOTuBSf7/JzPKN0VgB5MLQ4Ja
	 kJAaQQPBsr3mQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V9HZs0vzjzq2l
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 12:16:21 +0200 (CEST)
Message-ID: <5a16d4e3-6fa4-45f3-ae79-576f3fa80d44@badez.eu>
Date: Thu, 4 Apr 2024 12:16:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: fr
From: Alexandre Badez <alexandre@badez.eu>
Subject: Git log --decorate show prefetch objects
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

# What did you do before the bug happened? (Steps to reproduce your issue)

<on a git repository not fetch from a "long" time so you have missing 
branches and/or objects>

git maintenance run --task=prefetch

git log --oneline --decorate --all --graph

NOTE: here:
     - xxxxxxx commits are local commits,
     - yyyyyyy commits are remote commits fetch previously,
     - zzzzzzz commits are remote commits prefetch.

     * xxxxxxx (HEAD -> current-dev, origin/master, origin/HEAD) feat
     * xxxxxxx feat
     | * yyyyyyy (origin/feature) feat
     |/
     * xxxxxxx feat
     | * yyyyyyy (origin/a-fix) fix
     |/
     * xxxxxxx fix
     | * zzzzzzz feat
     | * zzzzzzz feat
     | * zzzzzzz feat
     |/
     * xxxxxxx feat
     | * zzzzzzz feat
     |/
     * xxxxxxx fix


According to the git-log  documentation (cf: 
https://git-scm.com/docs/git-log#Documentation/git-log.txt---all ):

     --all Pretend as if all the refs in refs/, along with HEAD, are 
listed on the command line as <commit>.

But the --decorate (cf: 
https://git-scm.com/docs/git-log#Documentation/git-log.txt---decorateshortfullautono 
):

     --decorate
     Print out the ref names of any commits that are shown. If short is 
specified,
     the ref name prefixes refs/heads/, refs/tags/ and refs/remotes/ 
will not be printed.
     [...]
     The option --decorate is short-hand for --decorate=short.

Documentation of maintenant prefetch (cf: 
https://git-scm.com/docs/git-maintenance#Documentation/git-maintenance.txt-prefetch 
):

     The prefetch task updates the object directory with the latest 
objects from all registered remotes.
     For each remote, a git fetch command is run.
     The configured refspec is modified to place all requested refs 
within refs/prefetch/.
     Also, tags are not updated.



# What did you expect to happen? (Expected behavior)

I would have prefer this output (prefetch not shown):

     * xxxxxxx (HEAD -> current-dev, origin/master, origin/HEAD) feat
     * xxxxxxx feat
     | * yyyyyyy (origin/feature) feat
     |/
     * xxxxxxx feat
     | * yyyyyyy (origin/a-fix) fix
     |/
     * xxxxxxx fix
     * xxxxxxx feat
     * xxxxxxx fix

Or this output (prefetch properly decorated):

     * xxxxxxx (HEAD -> current-dev, origin/master, origin/HEAD) feat
     * xxxxxxx feat
     | * yyyyyyy (origin/feature) feat
     |/
     * xxxxxxx feat
     | * yyyyyyy (origin/a-fix) fix
     |/
     * xxxxxxx fix
     | * zzzzzzz (refs/prefetch/remotes/origin/anotherfeat) feat
     | * zzzzzzz feat
     | * zzzzzzz feat
     |/
     * xxxxxxx feat
     | * zzzzzzz (refs/prefetch/remotes/origin/anotherotherfeat) feat
     |/
     * xxxxxxx fix


# What happened instead? (Actual behavior)

Prefetch object are return and not properly decorated.



# What's different between what you expected and what actually happened?

I would have preferd prefetched objects not displayed


# Information

[System Info]
git version: git version 2.44.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/bash
bash version: 5.2.26
uname: Linux 6.8.1 #1-NixOS SMP PREEMPT_DYNAMIC Fri Mar 15 18:19:29 UTC 
2024 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/fish

