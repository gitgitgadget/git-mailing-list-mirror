Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC53420248
	for <e@80x24.org>; Tue, 16 Apr 2019 15:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfDPPoo (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 11:44:44 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:45172 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPPon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 11:44:43 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 11:44:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1555429056; bh=S6fRXu3pNy81AP8YnJr232ocum7dHhF77qBsEKRLRv4=;
        h=Date:From:To:Subject;
        b=FKqK6GhL0nQ/s2ogXUYlC+1yMOWbGlbaRU5pjcg7xaGa52zeJl4v+2FWM3yH0SdwZ
         UsaedtnkuRwFxMz41FyZaXj1i/ch9+hcOGcIf2y/XL+R97vMRdjiNP06C+n54EYxfv
         I3+ZKCRiQCt7k+++3TkRhsxhigHV10pCULrPj3B0=
Date:   Tue, 16 Apr 2019 11:37:10 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Subject: Generating a todo file for non-interactive rebasing
Message-ID: <20190416153709.GA19000@homura.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hiya!

Whenever I do a particularly long rebase on a branch, sorting out
conflicts from upstream, I find that it's often useful to have the
additional context that you get during an interactive rebase, such as
recent commands run, commands planned to run, and so on, to get a better
idea of where I'm at during the rebase. These show when you run `git
status` during an interactive rebase.

However, the code that generates this report relies on a todo list being
generated in the rebase state directory. A todo list which consists only
of "pick" commands is functionally equivalent to a non-interactive
rebase, the only difference being that the editor isn't shown to the
user.

Is there any reason not to refactor the rebase command to always
generate a todo list? This would simplify the internals and provide more
context to the user during hairy rebases. It might also be useful to run
--edit-todo if you realize your rebase strategy needs to change partway
through a rebase which was initially non-interactive.

Note: I'm a non-subscriber, please Cc me on replies.

-- 
Drew DeVault
