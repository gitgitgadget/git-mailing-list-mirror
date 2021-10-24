Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2312C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A0860E0C
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 21:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJXVQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 17:16:45 -0400
Received: from mackerel.carobme.de ([195.201.115.197]:59743 "EHLO
        mackerel.carobme.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhJXVQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 17:16:45 -0400
X-Greylist: delayed 5871 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Oct 2021 17:16:45 EDT
Received: from mail.carobme.de (p57a9a54f.dip0.t-ipconnect.de [87.169.165.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: mrelay)
        by mackerel.carobme.de (Postfix) with ESMTPSA id 4HcrSG5R7PzFMNK
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 23:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaddrinuse.net;
        s=thorn; t=1635110062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9swcxr3jBfs1TyPaaBXuG5XU3DaTaFWSK2osk1MWcwY=;
        b=XV4LOuFiV7cb344UsGHyD2Os1HaKCazPzn/FCYTYyPgfow5YHn5kNU9nq7RD80hcLuIz5D
        R9ppeh2ceFrGqDfR57JNUc/WF9pK9JXMSOs6dFPZBgD9bsCaapNUx4nt5WdyLN8ntT1UQ7
        IcL02bYowhmExXLmA6MQAJW1AZD2+PDJOGcMOXAARN7aq49kGUcf7cEeN3rPXahOZTn2ur
        7BYb54unaQtuH5WyEf83kasAB4QsvNRH21yovcW0zwVo3r534wGozV0JzduQeof33Y9Fcd
        FAg6Ez0FwZJPu1xgFxn4Zdt88u02cpyND/J74px5ITRNgl+bO4oab9awHikBLg==
Received: from octopus.int.carobme.de (octopus.int.carobme.de [192.168.78.3])
        by mail.carobme.de (Postfix) with ESMTP id 4HcrSG2SHhzXRVd
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 23:14:22 +0200 (CEST)
Received: from mbeck (uid 1000)
        (envelope-from mbeck@eaddrinuse.net)
        id 7e228a
        by octopus.int.carobme.de (DragonFly Mail Agent v0.11+);
        Sun, 24 Oct 2021 23:14:22 +0200
Date:   Sun, 24 Oct 2021 23:14:22 +0200
From:   Marco Beck <mbeck@eaddrinuse.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
Message-ID: <YXXMroOBvDERXIMP@octopus.int.carobme.de>
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
 <xmqqsfwq40w7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqsfwq40w7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 24, 2021 at 01:35:04PM -0700, Junio C Hamano wrote:

>Can you explain why we want to add another way to specify the key?

Motivation for that patch was that I usually use the same .gitconfig
(all dotfiles actually) with multiple identities (e.g. company and private
email address). It's really convenient to switch to a different identity
for the rest of the session by just setting e.g. $GIT_AUTHOR_EMAIL and not
needing to remember adding --author to every invocation of git-commit(1)
etc. Thought it would be nice to have that convenience for selecting a
signing key as well.
