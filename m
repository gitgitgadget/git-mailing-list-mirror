Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1ACC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiBAUCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:02:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46944 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiBAUCs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:02:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 464061F37C;
        Tue,  1 Feb 2022 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643745767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/PttuF7DtWqjUYs3FBm0KKmGQxiKcxf6Lj7J1XEyH4=;
        b=jyXShLyobNU/gXKxVjKSdXZegM+FJRx45OoLDBtc4S6XlWITuCF4XKO1hqPD/jp/zWUAXL
        /47SYiPoOqupRMdP/gc/cW1WWl+TouxMRah+Jihy2Fb5huX5h2wiOnbfFKaOLqlZ8l0i+l
        7Zy1fY24xnThj81SsT7QEPbZAoTeV8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643745767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/PttuF7DtWqjUYs3FBm0KKmGQxiKcxf6Lj7J1XEyH4=;
        b=5y9acNZqFz/3DoPq966OtlLsVOZ5UuAXOIwY2zN0v9Ln9DhqJmCDlYENDU19QrNiy8L9v2
        bYTghwfRBFDKyHBQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3C273A3B87;
        Tue,  1 Feb 2022 20:02:47 +0000 (UTC)
Date:   Tue, 1 Feb 2022 21:02:46 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: Getting rid of "hint: Using 'master' as the name for the initial
 branch." when initializing a repository with pygit
Message-ID: <20220201200246.GW3113@kunlun.suse.cz>
References: <20220201184128.GT3113@kunlun.suse.cz>
 <YfmPiZZ/1RGzzfWE@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfmPiZZ/1RGzzfWE@nand.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 02:52:41PM -0500, Taylor Blau wrote:
> On Tue, Feb 01, 2022 at 07:41:28PM +0100, Michal Suchánek wrote:
> > I noticed that in some environments the default branch warning is
> > displayed and not others because the git version varies.
> >
> > The warning is just noise in the test log so I would like to avoid it,
> > and I would like to find a solution that works for git that predates the
> > introduction of this warning and the option to silence it as well as
> > the future git versions in which the default is subject to change.
> >
> > AFAICT there is no clean way to do it. I can set up the global option to
> > whatever but I don't want to do that just to run tests.
> 
> If you have set the init.defaultBranch configuration, we will suppress
> the hint you're talking about.

That's the problem - there is no way to pass the configuration when
using a library to create a repository.

> 
> Alternatively, you can make sure that `git init` is invoked with the
> `-q` (quiet) flag, which suppresses that warning whether or not you have
> set the init.defaultBranch config.

Yes, that is exactly the option that would do it.

Thanks

Michal
