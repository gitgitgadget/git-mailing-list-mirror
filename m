Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31E820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 22:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLKWH4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 17:07:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33465 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKWH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 17:07:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so9998098wmh.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MgztPZ6CFj2bKrD/L8Qv3Idr4g2L9viM/NaHw1N0/8c=;
        b=shkaFpLbsyxmfaesylFOC+n8XSgAW5w/ynAELBidzDUPSYXXWfQ6VPVhdlFVorUEkA
         t/GqXv7az87sRsNSU7a6e5JnVyWV3UUoxSdLixjYTxO9CEOtBfs3FjuD/nklOAGNhiK8
         okUBThBTtmIvT5LMyEU+vaK3rg4gN6+KeuKVC6265bOMxBS0zMRaCNMJihKKHrZpAX3w
         1WtuVtLssZPARcNztAzueUU8awUYYoi58RPTKCpo3ZDs5IyrCUaeHorsU1GuBg19JldL
         2JWSkPcv4cRenS1IN3U5j7wuamZV6FC4KqcsrGFsol2a8E14Q/XEd8Qxcc2dhnXjni7y
         GK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgztPZ6CFj2bKrD/L8Qv3Idr4g2L9viM/NaHw1N0/8c=;
        b=Ce/k/oorwRKtcl/WefsK/excw6adw86CCVTbJ3kaGLNQm0kw2prlvqs6U4lfppkU0D
         RpkZXKvcch31nu3oKwyo15zdknc+1Z7BD3ZuAYwCUcze1VcaNxNl8Nr+QbLuKe4oSagK
         hCnIx8bUo4HHXFysJURWSFmJokgFhs1OYwTXG5NGj47Jmja1DNZyrsZctgJBw0XGOAin
         XDYUW4O1Z5YbuW/ETqspfEPRqQWdMmyTmEt5//GI30DdrE9cBAM6Zd5fH+7qleUPu+qT
         RKLfJhAFBfTgpeOeXoFkZFdG1L4CiUobqVkeel0nZMxf02fgq7/zEYdSbTv06ONFNj6A
         IgZw==
X-Gm-Message-State: AA+aEWa1zOWc2IMcpn3dmYmdDUDLoYp66Hza3Z5VfJvh4SEEWN36SxC7
        bgdUyvk7qdGJliNeqsrcBZzkSKTh
X-Google-Smtp-Source: AFSGD/VIGgs1MwF1lf6nOtBNI6x7qcoFf0KNY8EqVGt5Z6f5lEwmIhgv/e6LQfVDw96g/FbVd6CrFQ==
X-Received: by 2002:a1c:8f95:: with SMTP id r143mr3841316wmd.65.1544566074475;
        Tue, 11 Dec 2018 14:07:54 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id z12sm14947823wrh.35.2018.12.11.14.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:07:53 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:07:52 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [PATCH 5/8] checkout: introduce --{,no-}overlay option
Message-ID: <20181211220752.GR4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-6-t.gummerer@gmail.com>
 <CABPp-BEk+7n2wcbjETishqnMBs5DGrTEvD7gahLtEj5bZ2AYvA@mail.gmail.com>
 <xmqqzhtclq22.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhtclq22.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> >> Note that 'git checkout -p <tree-ish> -- [<pathspec>]' already works
> >> this way, so no changes are needed for the patch mode.  We disallow
> >> 'git checkout --overlay -p' to avoid confusing users who would expect
> >> to be able to force overlay mode in 'git checkout -p' this way.
> >
> > Whoa...that's interesting.  To me, that argues even further that the
> > traditional checkout behavior was wrong all along and the choice of
> > --overlay vs. --no-overlay in the original implementation was a total
> > oversight.  I'm really tempted to say that --no-overlay should just be
> > the default in checkout too...but maybe that's too high a hill to
> > climb, at least for now.
> 
> You are exhibiting a typical reaction to a shiny new toy.

I wonder whether it's worth introducing a config option for this, so
people could use this new mode by default if they wanted to, without
having to type the extra argument?

'git checkout' is a plumbing command, but I see that some of the shell
scripts in git.git are using it.  Though they are only using it in the
checkout branch mode, rather than the checkout paths mode.

> The original "checkout paths out of the trees and/or the index to
> recover what was lost" is modeled after "cp -R .../else/where .",
> which is an overlay operation, and you wouldn't imagine complaining
> that "cp -R" is wrong not to remove things in the target, to be
> equivalent to "rm -fr where && cp -R .../else/where .".
> 
> Each has its own uses.  We just didn't have the other half of the
> pair.
> 
> If anything, I would consider "checkout -p" that does not do overlay
> is a bug that needs to be fixed.
> 
