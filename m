Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB9DC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 07:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJGHPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJGHPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 03:15:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409F303ED
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 00:15:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B909221910;
        Fri,  7 Oct 2022 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665126900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QClERNYZUrxGhD2siKC03fu8YmUV9qXQG0M/jOsOK2c=;
        b=aQfBbc3Db6SE4P3atZlubSglNOf8j7/NSRy+eLSjU+AjZ/vRu1edmwP9kz7cwD0M5+Nbhg
        jyaPyu8qF3QPWTIzbvq2f6DjFUMHEby0nRklcnTLqwTxdYMlKo5/9rP4sVJ/ezSJyCqCVa
        w0ixJOJvjOI12VnI6hV4SW48uOWNbis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665126900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QClERNYZUrxGhD2siKC03fu8YmUV9qXQG0M/jOsOK2c=;
        b=Sb5pnhudz9Nyj0Gr4WlzMyz3fr8+D57DjFjwuyoN5xmEAulXgj+sD5oOlasoUAAop1QTM6
        rTneHkOaoig3BgAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9EC0F2C142;
        Fri,  7 Oct 2022 07:15:00 +0000 (UTC)
Date:   Fri, 7 Oct 2022 09:14:59 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     m <mahg361@gmail.com>, git@vger.kernel.org
Subject: Re: [feature request] resume capability for users in enemies of
 Internet countries
Message-ID: <20221007071459.GM28810@kitsune.suse.cz>
References: <6e4a08d2-5d72-29fd-6917-11f0a74e9314@gmail.com>
 <83814bcb-1d72-07bf-32d1-d05db6cc6481@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83814bcb-1d72-07bf-32d1-d05db6cc6481@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2022 at 08:44:09AM +0700, Bagas Sanjaya wrote:
> On 10/7/22 01:01, m wrote:
> > In my country government make connections unstable on purpose. Please add resume capability for commands like git clone
> > 
> 
> Bandwidth issue?
> 
Bandwidth is one thing but the other thing is that git network
operations require that the whole operation succeeds in one go.

If your connectivity is bad to the point that the TCP connection breaks
you have downloaded a bunch of data that is AFAIK just thrown away when
you retry.

It is difficult to know if that data would be useful in the future, and
you cannot meaningfully 'resume' because the remote state might have
changed in the meantine as well.

Further, this whole fetch operation is using a heuristic to fetch some
data in the hope that it will be enough to reconstruct the history that
is requested, and this has been wrong in some cases, too. Not very
precise and reproducible hence hard to 'resume' as well.

Let's say that the git networking has been developed at and tuned for
the 'first world' Internet, and may be problematic to use in net-wise
backwater areas. And it would require non-trivial effort to change.

Thanks

Michal
