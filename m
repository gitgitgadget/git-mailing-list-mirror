Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449B720970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbdDKRSC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:18:02 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35758 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdDKRSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:18:00 -0400
Received: by mail-pg0-f49.google.com with SMTP id 81so1626353pgh.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I70JQxxETDzFJ/+C/cCzHkwLne2NaG7Li0nq/Asrd80=;
        b=gM4F9AtUogjQiWpH9NxDbw+g3RO8vEoSjKwtPSUYHLx6NZ4UQdbkM6HdHYhn0tDOaa
         ztMo3jXOYytD1YbO4vPWr5JKSQcXbBNrKQ92sAS8+9LvQqbWgRZ5Qn08vkxh12MN/S/3
         Z9esN5JAy+GEbJn3zxhAJelgT8rsSJuf0e1te9azIcBJeBoqawUiwyDAveOFkDX5Bt/j
         TmtAAn8HH56rtUtHxKZywjnPF30KliJ8uIL2vrlnvayauXlJ0n55sB9+01rC3wNyGVFF
         45Yvr/avbUYviD3jgbq+3gPNBkFMf5xsDJUG/GlRH2NQkbvDnX59bJ9mUBHuZdodQsca
         TgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I70JQxxETDzFJ/+C/cCzHkwLne2NaG7Li0nq/Asrd80=;
        b=EJDhxePSu+B2MurEVEmC9PYIR/TqFcoiAgtBI2uNO++HyV6Zvy4vo0l9/ho4zP7vZ/
         e590ww0txFVbuKv3Mt3x5mY22f2EteJN0g5Dq16z1CmpjSy4fbKRPP2RTi31k6P5qIwI
         22+QffJJWA6UTIRFFoSUld4F5+G/j3GQCOhuoINm5P5OauHez2DYwhDQFJTaLjxM36k9
         mTe3JrIJX/7LxIdEJsQ0ET49KlAxGOCgsnNVuKYOunvwcct0kgQq8/C1YQbrUERKRoEC
         NfevzOZ1na4+2+yAR+udn4WfMBHTLuQ/2bEHmJQlosAISvWsb+di20vII7ZuDPnNN9Ih
         28lQ==
X-Gm-Message-State: AFeK/H0BDPfEKuFVwj4kwl30nO74Tc0aPZVj8ejcV3+1V3cm8B6bRq6dJK2PX4zx9kEzNa8L
X-Received: by 10.98.4.195 with SMTP id 186mr42554396pfe.233.1491931079726;
        Tue, 11 Apr 2017 10:17:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9591:6d62:26a:6d59])
        by smtp.gmail.com with ESMTPSA id c7sm21443548pgn.24.2017.04.11.10.17.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:17:58 -0700 (PDT)
Date:   Tue, 11 Apr 2017 10:17:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/5] run-command: avoid potential dangers in forked child
Message-ID: <20170411171757.GD36152@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170411070534.GA10552@whir>
 <20170411162920.GA36152@google.com>
 <20170411165911.GA15566@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411165911.GA15566@starla>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Eric Wong wrote:
> Brandon Williams <bmwill@google.com> wrote:
> > On 04/11, Eric Wong wrote:
> > > Hi Brandon, this series tickles an old itch of mine, so I
> > > started working off of it.  I'm only somewhat concerned
> > > with the path resolution in execvp(e) pontentially calling
> > > malloc on some libcs; but I suppose that's a separate patch
> > > for another time.
> > > 
> > > Only lightly-tested at the moment, but things seem to work...
> > 
> > Thanks Eric! I'll spend some time looking at this patch later today.  As
> > for the path resolution in execvp(e), I guess we could completely avoid
> > that if we did the path resolution ourselves, prior to forking, and then
> > just use execv(e) since it shouldn't have any calls to malloc in them
> > correct?
> 
> Yeah.  I spent some time looking at it last night, but emulating
> the existing ENOENT / EACCESS / ENOTDIR mapping made my head
> hurt.
> 
> And I'm not sure if I introduced any off-by-one errors in
> exists_in_PATH when removing strbuf usage; string manipulation
> in plain C scares me :x   Since memcpy/strcpy/getenv in there
> are not specified as async-signal safe, they could
> theoretically take locks and cause breakage inside a child.

Well if we move away from the (p) variant of exec, and do that
resolution ourselves, then we can use the existing
exists_in_PATH/locate_in_PATH logic (using strbufs!) and avoid needing
to do that string manipulation in plain C.  Of course we would then need
to adjust some of the errno handling (e.g. if it doesn't exist in the
path, we would then know that prior to forking so really no need to
handle that in the child anymore).

-- 
Brandon Williams
