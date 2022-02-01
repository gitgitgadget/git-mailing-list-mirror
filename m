Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B3BC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 18:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbiBASlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:41:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49768 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiBASla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 13:41:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 64A5821126
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643740889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=10uEYTAWi70Z5YVSYzOcamnsdmrUeAgO47WwAKPmMPw=;
        b=qBaR59dIh/JNkl1HhWBFLod2i5UbvMK9FASoi9P4gL2yLWt+jpAYbkhGPGqzWL/dF/EpzW
        BPQDOu2HzLaQhj8DBeg3KS2gqLZQF0g5uRfvVLRCJeyYSqdb10uajoEFyPQtRyixyUobpD
        NIdU4Gz9QwOuFiv34usfr5iuPHE9GlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643740889;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=10uEYTAWi70Z5YVSYzOcamnsdmrUeAgO47WwAKPmMPw=;
        b=SdhxjK+7k7YT34YOinOEIwS/iDTzV5C2HEz8Jo5yKGDtl4zyVFAlVFgd+02i7ujc0Ojoam
        vk8LZDc5g1n7WjAQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5BCB4A3B85
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:41:29 +0000 (UTC)
Date:   Tue, 1 Feb 2022 19:41:28 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     git@vger.kernel.org
Subject: Getting rid of "hint: Using 'master' as the name for the initial
 branch." when initializing a repository with pygit
Message-ID: <20220201184128.GT3113@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am running some tests of a project that uses pygit, and the test
creates a test repository .. using pygit.

I noticed that in some environments the default branch warning is
displayed and not others because the git version varies.

The warning is just noise in the test log so I would like to avoid it,
and I would like to find a solution that works for git that predates the
introduction of this warning and the option to silence it as well as
the future git versions in which the default is subject to change.

AFAICT there is no clean way to do it. I can set up the global option to
whatever but I don't want to do that just to run tests.

I could set the repo local option but before calling
pygit2.init_repository() there is no repository to configure, and after
it is too late because I expect the message to be printed by this call.

Also I cannot rely on pygit to have some latest bells and whistles
because like git it varies across environments and the whole point of
running the test in different environments is to verify that it works
with whatever tool versions are avaialble there.

Any ideas?

Thanks

Michal
