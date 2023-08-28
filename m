Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB1C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 23:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjH1X7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjH1X6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 19:58:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0180132
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:58:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FBB45C0193
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 19:58:30 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute4.internal (MEProxy); Mon, 28 Aug 2023 19:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tannewt.org; h=
        cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1693267110; x=1693353510; bh=RMNDqlE8yXp6KKsqjaaP13oNx
        hClyT7eX0MH6Y8iyw8=; b=m/M7H+foR2j2iiDOrhhsvE9fce6v4haH0p/WVRp25
        9KbCAQDEqhzAysnH1q6U/XifI8sYCzhr5O8mIDrZR1NtEIj73Y16VboNTltcw/0i
        sevzSLwsUSyu469tZB8WyCopJiKJPGts03rC48ixUDkPIf/slrqENC5+MA7saOg5
        o2OlQHc0C7EJsBo9vkNKIgyueEhqaMyQP6niyvbLyuh0rz5UOW6RG4W5+L7KXftV
        8Vjec6zir2YxX/BmhItRCuc3qkBWq3nM3R9G1AjX89UFiFFDZZ1sbviEWGBFdgHm
        Op4CHJ+fz71HzitSJOFIJKI3X/qWo2zKMzaZX3Hhp8nKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693267110; x=1693353510; bh=RMNDqlE8yXp6KKsqjaaP13oNxhClyT7eX0M
        H6Y8iyw8=; b=LZzcshilDk6GLxcCiYKM1VJ0i/Cy5WRKzvhVnLnD42ke4vLRBeI
        oJwhyReGtTL3MAhyJ9+q2E+3bq8V3ZmUUcnfbkkrjz/jroKYTqYboF/pRmfk4uYL
        v2jhbOHJE2H+12z/4nEUs42zYPd14YbOqOAUWf7TSOW+Z/3P0Pzxyx3uuWfFe4L6
        gbVYJrHq4SJAV1GuKng9zwK84Gh5t4tbJxbm474c2UbE/LJfWVX2bqWrkttVD3i4
        eN6koHBGVzfhGof6TQErQVz6e32iXFguerCG6hOWEtFEHFIDa5AqZPOiIMFX3LqY
        yPgnSFP3mo2IDRYW5oGAoi/P+LC0JzLj5bQ==
X-ME-Sender: <xms:pjTtZG9wLXe6olveEpBQDz3Zq6S2WRFBwjthHCydRniyWhVIo_nhxg>
    <xme:pjTtZGu1psEFea4Tu2J898i_HsoFF5p9OgSKwKBCCMOHHXewVvmooCLXXvAcWFlBm
    TTd9qdf5Qo0N_PcPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefhedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfufgtohhtthcuufhhrgiftghrohhfthdfuceoshgtohhtthes
    thgrnhhnvgifthdrohhrgheqnecuggftrfgrthhtvghrnhepuedukefgveegtdejhfejue
    etffegffefieegudejuddvteelveelueehffdukedunecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehstghothhtsehtrghnnhgvfihtrdhorhhg
X-ME-Proxy: <xmx:pjTtZMC4_TrhxiWwe4BATwh4khutodtyfyeL_LVYDJkt7csKxlVuYw>
    <xmx:pjTtZOeV5ye-OasacXS7Z67CvpPJ9YZRFCIDc8nQ_Biv0hJpfq7rjQ>
    <xmx:pjTtZLMhgM1NPiRfKy342BTY1JzvUWrme7kRo0j1cIwO6PevVjjJvg>
    <xmx:pjTtZBbaC1NQQn83cYn_W4S2j0MDD2P5b4gdx6xJwL1l5MhFI-Xllg>
Feedback-ID: i46114244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EDED0BC007C; Mon, 28 Aug 2023 19:58:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <111c2777-6fd4-45ab-8418-9d064999661c@app.fastmail.com>
Date:   Mon, 28 Aug 2023 16:57:55 -0700
From:   "Scott Shawcroft" <scott@tannewt.org>
To:     git@vger.kernel.org
Subject: Submodule update fetching with outer repo's default branch
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I have a repo (https://github.com/adafruit/circuitpython) with a large number
of submodules. When switching branches we have a `make fetch-all-submodules`
command that runs `git submodule update --init` under the hood.

What did you expect to happen? (Expected behavior)
The data/nvm.toml submodule should update to the commit set by the state of the outer repo.

What happened instead? (Actual behavior)

env GIT_TRACE=1 git submodule update --init data/nvm.toml/
16:33:38.062849 git.c:749               trace: exec: git-submodule update --init data/nvm.toml/
16:33:38.062882 run-command.c:659       trace: run_command: git-submodule update --init data/nvm.toml/
16:33:38.077269 git.c:463               trace: built-in: git rev-parse --git-dir
16:33:38.079447 git.c:463               trace: built-in: git rev-parse --git-path objects
16:33:38.083204 git.c:463               trace: built-in: git rev-parse --show-prefix
16:33:38.085057 git.c:463               trace: built-in: git rev-parse --show-toplevel
16:33:38.089671 git.c:463               trace: built-in: git submodule--helper update --init -- data/nvm.toml/
16:33:38.091052 run-command.c:1523      run_processes_parallel: preparing to run up to 1 tasks
16:33:38.091061 run-command.c:1551      run_processes_parallel: done
16:33:38.091934 run-command.c:659       trace: run_command: cd data/nvm.toml; unset GIT_PREFIX; GIT_DIR=.git git rev-list -n 1 427cc923976229bcb981ca6f218ebe8efd636df6 --not --all
16:33:38.093709 run-command.c:659       trace: run_command: cd data/nvm.toml; unset GIT_PREFIX; GIT_DIR=.git git fetch
16:33:38.094641 git.c:463               trace: built-in: git fetch
16:33:38.094933 run-command.c:659       trace: run_command: git remote-https origin https://github.com/adafruit/nvm.toml.git
16:33:38.095835 git.c:749               trace: exec: git-remote-https origin https://github.com/adafruit/nvm.toml.git
16:33:38.095861 run-command.c:659       trace: run_command: git-remote-https origin https://github.com/adafruit/nvm.toml.git
16:33:38.352385 run-command.c:1523      run_processes_parallel: preparing to run up to 1 tasks
16:33:38.352401 run-command.c:1551      run_processes_parallel: done
16:33:38.352407 run-command.c:659       trace: run_command: git maintenance run --auto --no-quiet
16:33:38.353616 git.c:463               trace: built-in: git maintenance run --auto --no-quiet
16:33:38.354265 run-command.c:659       trace: run_command: cd data/nvm.toml; unset GIT_PREFIX; GIT_DIR=.git git rev-list -n 1 427cc923976229bcb981ca6f218ebe8efd636df6 --not --all
16:33:38.356060 run-command.c:659       trace: run_command: cd data/nvm.toml; unset GIT_PREFIX; GIT_DIR=.git git fetch adafruit321 427cc923976229bcb981ca6f218ebe8efd636df6
16:33:38.357177 git.c:463               trace: built-in: git fetch adafruit321 427cc923976229bcb981ca6f218ebe8efd636df6
fatal: transport 'file' not allowed
fatal: Fetched in submodule path 'data/nvm.toml', but it did not contain 427cc923976229bcb981ca6f218ebe8efd636df6. Direct fetching of that commit failed.


What's different between what you expected and what actually happened?
The submodule update is unable to find the target commit even though it is present in the submodule's repo.

Anything else you want to add:
Looking at the trace I noticed it's doing `git fetch adafruit321 ...` instead of the correct `git fetch origin ...`. (The `git remote-https origin` command is correct.) adafruit321 is the default branch in `.git/config` for my outer repo's branch (not the submodule). It looks like `fetch_in_submodules` is using the wrong default branch: https://github.com/git/git/blob/next/builtin/submodule--helper.c#L2241C31-L2241C31

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.4.12-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 24 Aug 2023 00:38:14 +0000 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
pre-commit
