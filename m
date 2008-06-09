From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problems reverting (includes reverting a merge)
Date: Mon, 09 Jun 2008 10:05:12 +0200
Message-ID: <484CE438.6040703@op5.se>
References: <b1d95faa0806051045t67ea0f46r55cdaeb794dc2f5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jenny w <veganjenny@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 10:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5cON-0004kQ-EW
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 10:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYFIIFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 04:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755027AbYFIIFU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 04:05:20 -0400
Received: from mail.op5.se ([193.201.96.20]:47278 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769AbYFIIFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 04:05:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8CAF01B800AF;
	Mon,  9 Jun 2008 10:01:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNBeJdAfc-jF; Mon,  9 Jun 2008 10:01:24 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id C26B11B800A6;
	Mon,  9 Jun 2008 10:01:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <b1d95faa0806051045t67ea0f46r55cdaeb794dc2f5c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84371>

jenny w wrote:
> Someone made a few commits that I'm trying to revert. There are three
> commits in a row, the middle of which is a merge. There are presently
> no commits following the ones that we want to revert.
> 
> I tried git revert on the latest commit and that worked fine.
> 
> The second latest commit was a merge, so I had to use the -m switch.
> I'm not exactly sure what the parent-number refers to, so I created a
> separate branch to try things out. Since it expects I a number, I
> started from 1. That was kind of a disaster, so I deleted my branch
> and made another off of master, and then tried doing the same command
> with -m 2. This worked fine.  However ...
> 
> I then tried to revert the next commit. This said there's a conflict.
> Since there are no other commits after the ones I'm trying to revert,
> this makes me think I'm doing something wrong ... shouldn't it just be
> able to roll back?
> 
> What I'd really like to do is just zap the last 3 commits ... is there
> another way to just make things the way they were before these patches
> were applied?
> 

git diff HEAD~3 | git apply -R && git commit <relevant files>

Although that will revert all 3 of them in one go, but perhaps that's
ok? Oh, and it won't work unless the merge-parent you want to revert
is the "first" parent (a straight line to the left when viewed in gitk
or qgit).

If you haven't published the commits anywhere yet, you can do

	git reset --hard HEAD~3

Note that this will clobber your worktree though, so use with caution.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
