Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CBAC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 08:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D408206B9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 08:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgEDIgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 04:36:24 -0400
Received: from mailgw2.jyu.fi ([130.234.6.65]:42030 "EHLO mailgw2.jyu.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgEDIgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 04:36:24 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2020 04:36:23 EDT
Received: from smtpauth2.jyu.fi (smtpauth2.jyu.fi [130.234.6.133])
        by mailgw2.jyu.fi  with ESMTP id 0448QIWC026791-0448QIWE026791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 4 May 2020 11:26:19 +0300
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
        (authenticated bits=0)
        by smtpauth2.jyu.fi (8.14.7/8.14.7) with ESMTP id 0448QIa0072720
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 May 2020 11:26:18 +0300
To:     git@vger.kernel.org
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: RFE: teach gitk to automatically mark .git/rebase-merge/stopped-sha
Message-ID: <1dbc41e9-b2e5-0b77-26c4-c912c82f9069@peda.net>
Date:   Mon, 4 May 2020 11:26:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While doing long rebases (I'm currently rebasing a feature branch with
166 patches) and rebase stopping in the middle of rebase, locating the
old patch in gitk is sometimes hard.

Could gitk automatically mark the original patch that failed to rebase
after I press F5?

The failing original commit SHA-1 can be found in file
.git/rebase-merge/stopped-sha but as far as I know, git does have
logical commit name similar to HEAD, ORIG_HEAD or anything else for this
case so there's no easy way to get already running gitk to mark this patch.

Of course, doing the same thing for failed cherry-picks would be nice,
too but in that case it's pretty clear where the source patch is.

As a workaround I currently have to do something like
  git tag -f FAILED_HEAD $(cat .git/rebase-merge/stopped-sha)
after seeing rebase failure. Then I can hit F5 in gitk to easily locate
the source commit.

PS. Is there a way to automatically run git tag -f FAILED_HEAD $(cat
.git/rebase-merge/stopped-sha) if rebase fails in the middle of branch?

-- 
Mikko
