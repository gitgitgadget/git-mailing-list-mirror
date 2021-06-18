Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D61C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 04:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27498611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 04:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFRE1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 00:27:44 -0400
Received: from smtp6.ctinetworks.com ([205.166.61.199]:42432 "EHLO
        smtp6.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFRE1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 00:27:43 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 00:27:43 EDT
Received: from localhost (unknown [117.193.1.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp6.ctinetworks.com (Postfix) with ESMTPSA id A1F8C84BC5;
        Fri, 18 Jun 2021 00:17:47 -0400 (EDT)
Date:   Fri, 18 Jun 2021 09:48:06 +0530 (IST)
Message-Id: <20210618.094806.1369340605245207462.enometh@meer.net>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
From:   Madhu <enometh@meer.net>
In-Reply-To: <xmqqr1k64bmk.fsf@gitster.g>
References: <xmqqr1k76p8d.fsf@gitster.g>
        <20210323.092748.1559327071188512317.enometh@meer.net>
        <xmqqr1k64bmk.fsf@gitster.g>
X-Mailer: Mew version 6.8 on Emacs 28.0
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: A1F8C84BC5.ABD74
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1624853872.49105@V7CAGrQDfc7XMHEOMYUnBg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't think this got any further attention?  I notice git-2.32 still
has the problem - in which case I re-commend my original patch.
Regards ---Madhu

*  Junio C Hamano <gitster@pobox.com> <xmqqr1k64bmk.fsf@gitster.g>
Wrote on Mon, 22 Mar 2021 23:39:31 -0700

> Madhu <enometh@meer.net> writes:
>> Avoiding the filemode check completely during reinit is ok with me
>> because it gave me wrong results.  I can't speak for the original
>> author of the code - if his intention was to do it explicitly as part
>> of "reinitialization".
>
> As the original author of the code, I know I meant filemode check to
> be done and redone upon reinitialization in 4f629539 (init-db: check
> template and repository format., 2005-11-25).
>
> But then when 75d24499 (git-init: autodetect core.symlinks,
> 2007-08-31) started to autodetect symbolic link support, I somehow
> ended up doing it only upon the repository creation.  Later,
> 2455406a (git-init: autodetect core.ignorecase, 2008-05-11) imitated
> to check case sensitivity in the same block, doing it only once.
>
> Either of these two commits would have been a good chance for us to
> realize that filemode check should be done the same way, but somehow
> nobody noticed X-<.
>
