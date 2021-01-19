Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C01C43603
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C8A22AAA
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhASSXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 13:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392490AbhASSXD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 13:23:03 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB8C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 10:22:23 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4DKxp34dRFzQkKN;
        Tue, 19 Jan 2021 19:22:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maddes.net; s=MBO0001;
        t=1611080537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXHq6voZRKiKKBPncUgIK9GgVTVCCfJFIi5BDuv83E8=;
        b=S+aqo+rGyT/dgUR4gprczNVWxlccZ8iGRbTGGasgTL6OMnKWrI1VIJbDbsoq06C26RMLKP
        5Q2lDs+Sb5il9N2wTf7UqJ+x+Op7u0eTCMjTqBuLB7O0JkIvVCfCtRS/4kum2m6VQS347P
        1ddmUfbxIa6SUxiUFz3IphROdkxCeRzCCH7SjQiptUFz5bFgytgIA1kmbAEUPEp77GSXn4
        ryv5PUWUM84I1Cmg9YpIJOeSmHDvcNpSYbaM+2rzxzpuuEad70LlKvXiprgPZCJx0Akx6I
        AmKA3p+bICk76xLvyLYZ5rTluXsXP+qVoRggDHRJ6xN/RWxQUprh8SvilAs/Ag==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id pdWTOV8kXd2q; Tue, 19 Jan 2021 19:22:15 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jan 2021 19:22:14 +0100
From:   "M. Buecher" <maddes+git@maddes.net>
To:     Harley Paterson <harley.paterson@hotmail.co.nz>
Cc:     git@vger.kernel.org
Subject: Re: False negative authentication with multiple accounts on a SSH-GIT
 server
In-Reply-To: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
References: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
Message-ID: <ddf34d963a57971c13d12d8f0c04a0fc@mailbox.org>
X-Sender: maddes+git@maddes.net
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.99 / 15.00 / 15.00
X-Rspamd-Queue-Id: 561721848
X-Rspamd-UID: 99c255
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

you can use GIT_SSH_COMMAND or config 'core.sshCommand'.
For more flexibility use wrappers like ssh-ident.

Recommended read: https://superuser.com/a/1616186/557798

Hope this helps
Kind regards
Maddes


On 2021-01-19 07:17, Harley Paterson wrote:
> Hello,
> 
> I've noticed an edge case in Git when a user has two Git accounts on a
> single server - as might be common for a personal account and a work
> account on a Git forge (Github, GitLab, Bitbucket...)
> 
> When attempting SSH login, `ssh` and Git will eagerly connect with the
> first matching key. This may or may not be the key right key for the
> repository the user needs. As a result, Git clones, pulls, and pushes
> will fail with the `Repository not found` if the wrong key is tried
> first.
> 
> For example, the user `alice` has two accounts on the host
> `git-server.com`. `alice`'s accounts are `alice-work`, and
> `alice-personal`. `alice-work` has access to the `foo` repository, and
> `alice-personal` has access to the `bar` repository.
> 
> `alice` attempts to clone `foo` with both her `alice-work` and
> `alice-personal` keys in her SSH Agent. SSH Agent does not define
> which key it will attempt first, so SSH may connect successfully to
> `git-server.com` with her `alice-personal` keys, which do not have
> access to the `foo` repository.
> 
> I'd be interested in your opinions for fixes to this. I am willing to
> make a patch, although my knowledge of the Git codebase isn't perfect.
> 
> - Should Git servers provide distinctly different error messages for
> `access denied`, and `repository does not exist`? Currently the server
> immediately closes the connection in this case, so
> `transport.c:handshake()` with fail when attempting to
> `discover_version()` because the reader hits the EOF. Perhaps the
> server could send a hypothetical access denied packet here, and a more
> appropriate error generated?
> 
> Can anyone point me to where in the Git codebase the daemon receives
> and responds to these requests? I haven't found it yet, if I wanted to
> patch this.
> 
> - Should Git provide a `-i` option to allow the user to choose an SSH
> key, which could be added to the SSH subprocess's command line?
> 
> - Should Git attempt to iterate over all keys in the SSH Agent when
> the connection is setup, testing the connection to check if each
> connected key has access to the target repository, before giving up
> and reporting an error? This may be difficult looking at the current
> behavior of `ssh` and `ssh-agent`. `ssh-add -l` no longer lists paths
> to files (which could be plugged into `ssh -i`), just the key
> signature. Does anyone know of any SSH/SSH-Agent tricks which might
> help with this?
> 
> All the best,
> 
> 
> 
> H Paterson.
