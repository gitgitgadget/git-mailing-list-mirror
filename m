Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52B9C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 04:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9722F619A3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 04:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCWEB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 00:01:58 -0400
Received: from smtp6.ctinetworks.com ([205.166.61.199]:34494 "EHLO
        smtp6.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhCWEBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 00:01:52 -0400
Received: from localhost (unknown [117.193.1.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp6.ctinetworks.com (Postfix) with ESMTPSA id 50AD2842C1;
        Tue, 23 Mar 2021 00:01:40 -0400 (EDT)
Date:   Tue, 23 Mar 2021 09:27:48 +0530 (IST)
Message-Id: <20210323.092748.1559327071188512317.enometh@meer.net>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
From:   Madhu <enometh@meer.net>
In-Reply-To: <xmqqr1k76p8d.fsf@gitster.g>
References: <xmqq7dlz94by.fsf@gitster.g>
        <20210322.143437.212295420302618690.enometh@meer.net>
        <xmqqr1k76p8d.fsf@gitster.g>
X-Mailer: Mew version 6.8 on Emacs 28.0
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: 50AD2842C1.A50D2
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1617336106.68432@W1IoJdPlqcdPvqADD/p2eg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*  Junio C Hamano <gitster@pobox.com> <xmqqr1k76p8d.fsf@gitster.g>
Wrote on Mon, 22 Mar 2021 11:02:42 -0700
>> I don't think the posted patch (snipped) would work as reinit is
>> always 1 and we are always a candidate for reiniting - I may be
>> missing something.
>
> In other words, yes, the illustration patch you are responding to
> assumes that the "reinit" variable is set correctly (i.e. the HEAD
> exists and sensibly readable if you run "git init" in an already
> functioning working tree) and we can use it to avoid the filemode
> check.

Ah yes indeed.

>> Using a new file for the filemode test would be a natural
>> improvement.
>
> That becomes necessary only if we want to futz with core.filemode
> while doing "reinit", as .git/config can be a symlink.  When we are
> creating a repository from scratch, we always create a regular file
> to prepare .git/config, and there is no need to do that, if we are
> happy to set core.filemode the same way as core.symlinks, i.e. only
> check once when the repository is created.  No?

Avoiding the filemode check completely during reinit is ok with me
because it gave me wrong results.  I can't speak for the original
author of the code - if his intention was to do it explicitly as part
of "reinitialization".

[In the latter case personally I'd want to edit the config file by hand
in response to a message from git - and I certainly do not want git to
change the config file behind my back without informing me.]

Thanks again.



