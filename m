From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 23:22:10 +0200
Organization: At home
Message-ID: <ee9spf$h98$1@sea.gmane.org>
References: <20060913210817.GA30782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 23:23:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNcC5-0002LY-4I
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWIMVWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWIMVWd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:22:33 -0400
Received: from main.gmane.org ([80.91.229.2]:14042 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751210AbWIMVWc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 17:22:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNcBN-0002As-IS
	for git@vger.kernel.org; Wed, 13 Sep 2006 23:22:09 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:22:09 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:22:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26951>

Shawn Pearce wrote:

> -- >8 --
> Create merge strategy 'applyreject'.
> 
> The applyreject merge strategy is a two head merge strategy which performs
> the merge by obtaining the diff between the common base and the branch
> being merged and applies it to the current branch using git-apply --reject.
> Consequently any failures are written to .rej files, rather than using
> the RCS <<<<<<< ======= >>>>>>> format.

Nice.

> ---
>  .gitignore               |    1 +
>  Makefile                 |    1 +
>  git-merge-applyreject.sh |   26 ++++++++++++++++++++++++++
>  git-merge.sh             |    2 +-
>  4 files changed, 29 insertions(+), 1 deletions(-)

But where documentation (Documentation/merge-strategies.txt)? 

> +#!/bin/sh
> +#
> +# Simple merge strategy which produces reject files on failed merges.
> +# Only handles two heads and one merge base, thus the command line
> +# parameters must be:  base -- head1 head2

We can always get the base using git-merge-base, so the arguments could
be either "base -- head1 head2", or just "head1 head2".

Does "git pull -s applyreject . head2" works (when on head1) with
this patch? Does the unified driver git-merge works correctly?

> +git-diff --binary -M $base $incoming \
> +     | git-apply --index --reject --verbose

--index or --cached?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
