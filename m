Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A74A20970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdDKRdY (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:33:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33531 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdDKRdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:33:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id c198so632501pfc.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UFsQOoLNqsTuyrimQz3cci5BBfQt4kOD5jLIHpi0s5c=;
        b=A+NWb7MJLRsGK1CFHoz0Gdverya4BzQevvroFAV+YTAsLhgmQGZ/nr4fMADUadgOh7
         7lbahefyLu1NFLrBWATlXA+Apb4tQwx7JfYhzlvn2wh3q6iG8uSnXmiOhyX35YEYXk9m
         c+6HEZ0wiKwPPqeHIPXRmiXH9D4Brg+Qy9rdXhI/9oHdThL+1tggY7OXSJEqFGgcdhGP
         dbQRrJie4K+JoPE8KOQYop4uK2kIJpxG2QpwkR8A+jSv0qca1G2RSYyegTCCUhbnyDDY
         bDt1qxJrVnBecU3IkBWEqQM+5Ok4jo9NCht5WuS1GQc+7ijw4n2cxOrfgv7BI1deooI2
         Y7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UFsQOoLNqsTuyrimQz3cci5BBfQt4kOD5jLIHpi0s5c=;
        b=QBUBq6wXSMfnDef6FpCmWit5W+Ed0JJ16bVDhktanWP3v9mKSORxs09YH3tf5Phf+4
         tpipOrog6CxQlKvAewj08B7P2/KiQxFB6JQm7KkiSGsvpz99B1fYIPRdJvO/0m8lQUog
         Te+2iJwdfebPImrCOBt26t+s3rK/lVKllDAvyVkNaJWfr7j3ts1YOFkTxtK44N0OVSjU
         MU1ZlG0BUWz8/biF5pHJHcdFq/6ZCPH4efXoavpniAKV8C8SVyhNciqOTIY/BSwAcfqT
         VpH3uHjwvJ3gcmm8B2s1xxs9TviZ8yJwaJR9DMMGtgHEmHQZTt/oITt3sVWuW7Ydntbw
         4Y1A==
X-Gm-Message-State: AN3rC/4Wmury6spga8DPIoVFQ628WlaisyBhOvDzUa7UIDplpm6s8In/Z9k9Lx8LL1NsQQ==
X-Received: by 10.84.254.4 with SMTP id b4mr1258419plm.64.1491932002936;
        Tue, 11 Apr 2017 10:33:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c434:5e79:6b7e:ed6b])
        by smtp.gmail.com with ESMTPSA id d82sm9331788pfl.124.2017.04.11.10.33.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:33:22 -0700 (PDT)
Date:   Tue, 11 Apr 2017 10:33:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] run-command: add note about forking and threading
Message-ID: <20170411173320.GM8741@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-6-bmwill@google.com>
 <20170411002606.GJ8741@aiede.mtv.corp.google.com>
 <20170411005348.GA30913@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411005348.GA30913@starla>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Why can't git use e.g. posix_spawn to avoid this?
>
> posix_spawn does not support chdir, and it seems we run non-git
> commands so no using "git -C" for those.

On the other hand, a number of the non-git commands we run are in a
shell.  At the cost of a wasted shell process, other commands can
be spawned using posix_spawn by passing the chosen directory and
command to

	sh -c 'cd "$1" && shift && exec "$@"' -

[...]
> I posted some notes about it last year:
>
>   https://public-inbox.org/git/20160629200142.GA17878@dcvr.yhbt.net/

Thanks for these notes.

Sincerely,
Jonathan
