Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F68C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiKHMAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 07:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiKHMA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 07:00:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7301E701
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 04:00:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 280F81F38C;
        Tue,  8 Nov 2022 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667908826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gM0VVQzcvGxYzObYaeXL8ATUh2CiE+6sfYw+Ew9xE3g=;
        b=1LdlCtImoqGU/19fhVn19ZGALhuvLQx8Jc3CCuZql7fc4tVeA/DOTmOBaxS1tbQGNDh/mK
        ZJwOqiPSUhwXYzK7DQ7xre96gPIFi2li/HDYsSn9c0b4H2JpZLOM2SmF88VPV8v62/pcXu
        3A1QDyWWRbduIDB7lj6NQZLz4KWS/T4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667908826;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gM0VVQzcvGxYzObYaeXL8ATUh2CiE+6sfYw+Ew9xE3g=;
        b=j7OC9UflAINAmaCpxCvCTZkz/FoSsngqE/1wYypsGQGIwFqMtjVr5JgAGnGXSDEzymUIr6
        mumOF92WsgVq7fBQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EEF1F2C141;
        Tue,  8 Nov 2022 12:00:25 +0000 (UTC)
Date:   Tue, 8 Nov 2022 13:00:24 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     git@vger.kernel.org, "peff@peff.net" <peff@peff.net>
Subject: Re: The enduring popularity of git-credential-store
Message-ID: <20221108120024.GN28810@kitsune.suse.cz>
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Nov 08, 2022 at 10:50:33AM +0000, M Hickford wrote:
> Among StackOverflow users [1], git-credential-store appears several
> times more popular than any other credential helper. Does this make
> anyone else uneasy? The docs warn that git-credential-store "stores
> your passwords unencrypted on disk" [2]. Are users sacrificing
> security for convenience?
> 
> Firstly, how grave is storing credentials in plaintext? Software
> development guidelines such as CWE discourage storing credentials in
> plaintext [3]. Password managers in desktop environments, mobile
> operating systems and web browsers typically encrypt passwords on disk
> and guard them behind a master password.
> 
> Secondly, the docs recommend git-credential-cache [2] which ships with
> Git and is equally easy to configure. So why isn't it more popular? My
> hypothesis: while caching works great for passwords typed from memory,
> the combination of caching with personal access tokens has poor
> usability. The unmemorised token is lost when the cache expires, so
> the user has to generate a new token every session. I suspect GitHub's
> 2021 decision to stop accepting passwords [4] may have inadvertently
> pushed users from 'cache' to 'store'.
> 
> Thirdly, why doesn't everyone use SSH keys? Unlike HTTP remotes,
> upfront set-up is necessary to clone a public repo. For users
> unfamiliar with SSH, this set-up may be intimidating. Introducing
> users new to Git to SSH at the same time is a significant cognitive
> load.

I think that basically there is very small user base that could make use
of the provided authentication options in a more secure manner.

The novice users use the simplest option. Using any king of passsword
manager with git is difficult to set up and platform-specific.

The advanced users need automation which in the end means storing the
access credentials in plaitext in one way or another.

If github provides access tokens that can be assigned per-application,
managed, and individually revoked this is probably as good as it gets.
How well the users make use of this feature depends on their security
awareness and requirements.

Thanks

Michal
