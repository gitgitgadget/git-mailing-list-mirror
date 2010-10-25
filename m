From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] Add tests to demonstrate update-index bug with core.symlinks/core.filemode
Date: Mon, 25 Oct 2010 10:59:11 +0200
Message-ID: <1jqwy91.df4hcq1wxhklzM%lists@haller-berlin.de>
References: <m37hh7jh17.fsf@localhost.localdomain>
Cc: git@vger.kernel.org
To: jnareb@gmail.com (Jakub Narebski)
X-From: git-owner@vger.kernel.org Mon Oct 25 10:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAItq-00074W-O3
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 10:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab0JYI7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 04:59:19 -0400
Received: from mail.ableton.net ([62.96.12.115]:56518 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab0JYI7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 04:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=vKY1oU0m2VHb56qUFjR8xnl2HSIvzd5uCoeTPyL/ycM=;
	b=XHBmic1Oy3jsjduPTZRvCWGseCA4EjXY4coCYo5LgKUu9L+3Bcz31m+c5BGeuIiT/fB+RyAgRfb3IxTAG7DZGTvV9OxFfAEIJWXGHm4/P2HSez/mliKBnvrJzs1NBNYhfrfX62izBfTogENWe3+pe7WQJdSEzuovAsx8Ou8GMY0=;
Received: from macbook-stk.office.ableton.com ([10.1.12.43])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PAIte-0004Tf-UT; Mon, 25 Oct 2010 10:59:14 +0200
In-Reply-To: <m37hh7jh17.fsf@localhost.localdomain>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159935>

Jakub Narebski <jnareb@gmail.com> wrote:

> > +test_expect_success \
> > +'preparation' '
> > +git config core.filemode false &&
> > +touch foo &&
> > +git add foo &&
> > +git update-index --chmod=+x foo &&
> > +git commit -m "Create"'
> 
> The suggested way of coding in test script looks like the following:
> 
>   +test_expect_success 'preparation' '
>   +   git config core.filemode false &&
>   +   >foo &&
>   +   git add foo &&
>   +   git update-index --chmod=+x foo &&
>   +   git commit -m "Create"
>   +'

OK, will use that style next time, thanks.  I copied the style from
t2102...

> BTW. does it matter that 'foo' is empty?

No, it doesn't make a difference.

> [...]
> > +test_expect_failure \
> > +'check that filemode is still 100755' '
> > +case "`git ls-files --stage --cached -- foo`" in
> > +"100755 "*foo) echo pass;;
> > +*) echo fail; git ls-files --stage --cached -- foo; (exit 1);;
> > +esac'
> 
> Wouldn't it be better to simply prepare expected output (perhaps with
> stubs for hashes), and compare actual with expected output?

Maybe; again, I just copied that from t2102.  (That's also why I felt
uncomfortable putting that copyright notice at the top of my files...)

> Also, weren't you able to use test_tick, test_commit, test_merge
> functions from test-lib.sh?

I used test_commit where possible; for the initial commit I couldn't.
As for test_merge and test_tick, I could have used them, yes; what's the
benefit though?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
