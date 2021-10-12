Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEFCC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C4D6108F
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhJLO13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:27:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36387 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230195AbhJLO12 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 10:27:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 985065C00DB
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:25:26 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute6.internal (MEProxy); Tue, 12 Oct 2021 10:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waite.eu; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=N79GHBEHK5dMe+eLPzDSpGbN1EmpQC1Ksu8JOHdvQno=; b=rAp/RBp0
        5vR2aDb8BcvDQZ/veeI4tQ+tC7oddMRkc8J9j7jT1MiFjCb+1BoF1RsJatZu8582
        9MGrw68hv2LZCdfSTqbHlx/NSD5eXxzbrgdovhEKpjF438/jXEBw36uWcLKNTB3c
        lXN43YnBV5pTMK7bah0u9VFBdQPTql7XxfAA+f9dLhZqSHP6GLnBbs2To3LYY9gF
        cGh8+I44Eg/uJH1uon4MAtrmSN2I/NTfpdAoM2TeSrz/Oegf4q5SAmw6iCydNWPJ
        a5+QWCIgYyGwgZDYzDpvVZHujLmfUwnoG237LORjFq/A+S3BARY2ipHhYDAauz2v
        3GEwErjeYGdUtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=N79GHBEHK5dMe+eLPzDSpGbN1EmpQ
        C1Ksu8JOHdvQno=; b=Uw7NQZ5Y8XrDyKp0dkza17E5Hc5coRBKI1T0z+rXHhNOX
        d2TI0dNn/7GZ+gmbigSmirfVrzOmrTATkN0qefsR9NkfiXrmx7mbsGg8eDCLTyI1
        g5y8HUJhQBWjqgVyJ/938t50aR/lNtsOf4IIU0kSHHPzjAzgQqNSJKQc2UQB0lKa
        gflqiThp2WG5v7xcmqadkZj9uDVpBtGoCF1xYuMitLYgObbLX+bTm/Re9VeprDdR
        COSjlLTrzIscRQ93LypE9g9oGYHb4oafTHhaCYbTTzgfuJO2BGDOuar8CEYcB3Bk
        kD0nk1mCE/pNEcKRmTlpYr9buMjwW0KM9NrDmF6xQ==
X-ME-Sender: <xms:1pplYU_cO8V_ppuNd7HSabq7p6iAdAFAR_1xoCx3h6-Eoy78PfcpNw>
    <xme:1pplYcvjNaVl5MVVrURp7OUJlfrffkVH6co79wQ4sr71myIgLWiBly__AW7av1nld
    7YvmqK7HXNth_G3CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedftehlvgigucghrghithgvfdcuoegrlhgvgiesfigrihhtvgdr
    vghuqeenucggtffrrghtthgvrhhnpedvjefffeeiffefhfdvtdfhkeeileduveehjeefle
    ekjeefteffleelhffgudetgfenucffohhmrghinhepghhithdqshgtmhdrtghomhdpvgig
    rghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrlhgvgiesfigrihhtvgdrvghu
X-ME-Proxy: <xmx:1pplYaC3HsNypcTZyIBAuGcBITmKRebaftS00H58GVLCXKyj8phk4w>
    <xmx:1pplYUdbcfm2w9xgwj02AxHoIzpe3nvr5OFuaRnrWQYDk9YNsgy9aw>
    <xmx:1pplYZNr_QAJtXXqBav8U0F02kc_AamUJKJ30YScyqS9b6lUKfgUWg>
    <xmx:1pplYfbhRw_Ca-BIYn0HFz-yDsG-YNvuZzangNKZVZkuglv7iIYuJA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 72AD82180075; Tue, 12 Oct 2021 10:25:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
Date:   Tue, 12 Oct 2021 16:25:04 +0200
From:   "Alex Waite" <alex@waite.eu>
To:     git@vger.kernel.org
Subject: [BUG] credential wildcard does not match hostnames containing an underscore
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone,

This is my first time reporting a bug to this list. I attempted to follow the direction on the git website [1], and have followed the template provided by "git bugreport".

If my report should be formatted differently, or reported elsewhere, please let me know. :-)

---Alex

[1] https://git-scm.com/community

-------

What did you do before the bug happened? (Steps to reproduce your issue)

  I configured my ~/.gitconfig so that git credentials invoke a helper for a
  subdomain using wildcards. For example:

  [credential "https://*.example.com"]
          helper = "/usr/local/bin/custom_helper"

  This works for all tested subdomains /except/ for those which contain an
  underscore.

  authenticates without prompting:
    git clone https://testA.example.com
    git clone https://test-b.example.com

  prompts for authentication:
    git clone https://test_c.example.com


What did you expect to happen? (Expected behavior)

  I expected the pattern matching to work for all resolved URLs.


What happened instead? (Actual behavior)

  It does not match URLs which contain an underscore.


What's different between what you expected and what actually happened?

  It only matches URLs which do not contain an underscore.


Anything else you want to add:

  If I don't use pattern matching, and instead state the URL explicitly in
  ~/.gitconfig, it works as expected. For example, the following works:

  [credential "https://test_c.example.com"]
          helper = "/usr/local/bin/custom_helper"

  As part of writing this bug report, I learned that underscores are not valid
  DNS characters for hostnames (but are valid for other record types, which are
  largely irrelevant to git).

  What is notable is that git pattern matching enforces the spec more strictly
  than without pattern matching (and more strictly than the OS and every DNS
  server between my system and the authoritative DNS server).

  At minimum, git should be consistent with itself.

  As for which behavior is "correct", the question is whether git wishes to
  follow/enforce the spec tightly, or not get in the way of a real-world oddity
  that everything else seems to tolerate.

  This also likely affects patterns for http.<url>.*
  https://git-scm.com/docs/git-config#Documentation/git-config.txt-httplturlgt

