Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14C31F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeAESsd (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 13:48:33 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:39041 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeAESsc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 13:48:32 -0500
Received: by mail-pf0-f181.google.com with SMTP id l24so2516359pfj.6
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 10:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D7cLwsxqQxD34pri8FE4Gtgk5kktiK/O1zE8rKDA5YQ=;
        b=s/Ee+5CN0AL0gjWKuJRqoeVti0dXVNCi9ndgFjf8yxOlv4E2E89p8QHeZBh+QJHjtK
         cbE7KmEXjXMv2sw45M3lKjToRIA4FgDgfvWItr5zdJJihFfUCN75FxKjQfwhc7mPblZ7
         HKGGuh0AewOl1z4cOwP0Q8H//0rsb/pDT776pPxIk9iZjebNJ6EkHHZLtEFJDULxgDBy
         1gIVbCIe2dqKs+y4Ha/AgLIpumjY4A63FFv2LWsDiUUj5yL0eUPdvtWalgyDaok8R0Ed
         mBR03ld29rjc2sFq5dME3toXfeoDZ+6m7LZ412teiN8JBzcst7KTVN6bCq7PzqHbbZro
         jj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D7cLwsxqQxD34pri8FE4Gtgk5kktiK/O1zE8rKDA5YQ=;
        b=U0RwdhgeHf/ZPnuYp6kWeX4qDrrPArlUNWU16v8gPka/ppFVimy/odEwi+Dwj9PJdl
         UbZxbv78Hf2/p5BKOtEPahXQGWg9EXkQaMjj6lnkWuGXL5KBLbL93xBNNKymrIifRHEQ
         SEIp1z/dxAA06i5TMKJ0zVQmhrxvcoEmQZfJjddzscFyK9j0U6d1HMEDdV6QEvkyTRJN
         Wou3PymBeGvZk74nTe1cXzJ7u9l++WlonNLoT6469Rt6lrMMiZ2HNzEObdVoiRNWuys+
         gz2V28X3qZ8FqmDYVlLDtowpF/Y59+EfVEXBdcEd4NzhKwr50dGwOy94i83zaryh8slO
         Dt+A==
X-Gm-Message-State: AKGB3mIM9Rczf3uPluNrbS7i1ZgymqzhqLZJyO4C4q6ouP6wWJxlRyEM
        dVBQkkV8l29+Q2InZSVEbl47yBwg
X-Google-Smtp-Source: ACJfBotUCdy6nVO3wdaUXLjjHV0wfoZNW2s6R1HsRYCvi7Q6wrDxKbAWdnXNdxJGnjMCi0rahywCgg==
X-Received: by 10.101.80.139 with SMTP id r11mr3166593pgp.383.1515178111636;
        Fri, 05 Jan 2018 10:48:31 -0800 (PST)
Received: from dtor-ws ([2620:0:1000:1611:da80:8749:c06f:9515])
        by smtp.gmail.com with ESMTPSA id h192sm14616243pfc.139.2018.01.05.10.48.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 10:48:31 -0800 (PST)
Date:   Fri, 5 Jan 2018 10:48:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     git@vger.kernel.org
Subject: prepare-commit-msg hook no longer run for cherry-pick?
Message-ID: <CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufaS_zs+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received: by 10.176.11.153 with HTTP; Fri, 5 Jan 2018 10:44:23 -0800 (PST)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I had prepare-commit-msg hook that would scrub "Patchwork-ID: NNNN" tags
form commit messages and would update input mailing list patchwork to
mark corresponding patches as "accepted" when I cherry pick form
WIP/review queue into branches that I publish, but that recently stopped
working if I do a simple cherry-pick. If I specify that I want to edit
the message, then the hook is executed:

dtor@dtor-ws:~/kernel/master (for-linus)$ GIT_TRACE=2 git cherry-pick ff162c1554efe951ba6c7a19a228fc76a91fe1ed    
10:43:12.832426 git.c:344               trace: built-in: git 'cherry-pick' 'ff162c1554efe951ba6c7a19a228fc76a91fe1ed'
[for-linus 48bc600a3659] Input: raydium_i2c_ts - include hardware version in firmware name
Author: Jeffrey Lin <jeffrey.lin@rad-ic.com>
Date: Thu Jan 4 21:35:23 2018 -0800
1 file changed, 12 insertions(+), 2 deletions(-)
dtor@dtor-ws:~/kernel/master (for-linus)$ gti reset --hard HEAD^            
HEAD is now at 02a0d9216d4d Input: xen-kbdfront - do not advertise multi-touch pressure support
dtor@dtor-ws:~/kernel/master (for-linus)$ GIT_TRACE=2 git cherry-pick -e ff162c1554efe951ba6c7a19a228fc76a91fe1ed
10:43:24.433162 git.c:344               trace: built-in: git 'cherry-pick' '-e' 'ff162c1554efe951ba6c7a19a228fc76a91fe1ed'
10:43:24.782355 run-command.c:627       trace: run_command: 'commit' '-n' '-e'
10:43:24.786460 git.c:344               trace: built-in: git 'commit' '-n' '-e'
10:43:25.082164 run-command.c:627       trace: run_command: '.git/hooks/prepare-commit-msg' '.git/COMMIT_EDITMSG' 'merge'
hint: Waiting for your editor to close the file...
10:43:31.491551 run-command.c:627       trace: run_command: 'vim' '/usr/local/goo gle/home/dtor/kernel/master/.git/COMMIT_EDITMSG'
[for-linus 039c57df0ec8] Input: raydium_i2c_ts - include hardware version in firmware name
Author: Jeffrey Lin <jeffrey.lin@rad-ic.com>
Date: Thu Jan 4 21:35:23 2018 -0800
1 file changed, 12 insertions(+), 2 deletions(-)
dtor@dtor-ws:~/kernel/master (for-linus)$

Also note that the argument to the hook is "merge" whereas I think it
used to be "cherry-pick" earlier.

Is this behavior intentional? dpkg reports version as 2.16.0~rc0+next.

Thanks!

-- 
Dmitry
