Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113B91FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 16:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbcFPQzk (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 12:55:40 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37560 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbcFPQzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 12:55:39 -0400
Received: by mail-wm0-f54.google.com with SMTP id a66so66796169wme.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 09:55:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f9nEqkhNRFZ3yUDwJuuxufD+Q+VpGCoBcbk+httJUmY=;
        b=m7yovF+bOyFiaN9942J2Ux4g4rErEYYTB/SMrzRgyVbG55UUPAiWmQ+e4G6xQHoOjJ
         WEZ739tYnofi1ZsgMtoTosRJUoDYaMwCkakPpMl883EbmxKEiP+c569v/64ULYIF0tfr
         SiR821DjhyrTr9QvHkwrwV/YvrF/bO3NDeYKjJrgT56CpTDHIebvho50tbQ6t97QzDtw
         tCJoAE6fHDNKH9vnlBvWSFvWgP3E+zonOwg7H2sSfX3B4t1bFhDR57j3CnKenuASptKf
         I4KDEdSPA5w6gBqRc/EAWIbh/+jQ52DUhe3VkEP6uixH3fSVxTox6NlX97VolprwLOLy
         i5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9nEqkhNRFZ3yUDwJuuxufD+Q+VpGCoBcbk+httJUmY=;
        b=GTHlzx7weYMIBGUIuW0vbRAX0YgAVp8cAPcIqZxUf3rh7nRlH3dMRNpDIfFtfxMmxs
         QmC0WuffXcZPDPWfSj+xuZGbBtZQglaDBPxQlakBuu4p2/vOZrTT2CdFwI3MWLY8AHp8
         +PEdpTZR1UU8xUsiRB05meNU4EhoGFLzf44fDbsuUYP2avYPckf94rjGuRDzvwv8YIhX
         am2meSJ/l7zNLAHDSuACPQyuEdmGvmW2nE4NgSrsT2lMITXK/FnFIE6p4iRP3faAm7p/
         uzo/tyEAuoDGQPvna0SL8hY9VqAWMdNzhGl8NxRQ4qhu51RFg6NA0h8e6VRp6fW7E5du
         DSrA==
X-Gm-Message-State: ALyK8tLYQGGBSXecztIRlaxcrmXXCutC473vH/kxd4DbW0+e7bR/6mHh3NEkcWDN4TNSGg==
X-Received: by 10.194.133.135 with SMTP id pc7mr612762wjb.49.1466096137558;
        Thu, 16 Jun 2016 09:55:37 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id wo3sm44517708wjb.12.2016.06.16.09.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 09:55:36 -0700 (PDT)
Message-ID: <1466096135.28161.9.camel@kaarsemaker.net>
Subject: Re: [bug] assertion in 2.8.4 triggering on old-ish worktree
From:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:	Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Date:	Thu, 16 Jun 2016 18:55:35 +0200
In-Reply-To: <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
References: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
	 <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On do, 2016-06-16 at 17:02 +1200, Chris Packham wrote:
> On Thu, Jun 16, 2016 at 4:59 PM, Chris Packham <judge.packham@gmail.c
> om> wrote:
> > 
> > Hi All,
> > 
> > I have the git-sh-prompt configured in my .bashrc today I visited
> > an
> > old worktree that I haven't really touched in a few years (sorry
> > can't
> > remember the git version I was using back then). I received the
> > following output when changing to the directory
> > 
> > git: pathspec.c:317: prefix_pathspec: Assertion `item-
> > >nowildcard_len
> > <= item->len && item->prefix <= item->len' failed.
> > 
> > I assume it's one of the git invocations in git-sh-prompt that's
> > hitting the assertion. Any thoughts on what might be triggering it?
> > Any debug I can gather?
> A bit more info. The directory in question is a uninitialised
> submodule. It doesn't trigger in the root of the parent project.

That very much smells like a class of bugs we've seen before, with git
getting confused around submodules. See also for example

https://www.mail-archive.com/git@vger.kernel.org/msg68447.html

I don't think an accepted fix exists yet.

D.
