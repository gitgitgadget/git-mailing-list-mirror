From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Re: How to commit incomplete changes?
Date: Thu, 15 Dec 2011 10:44:44 +0400
Message-ID: <20111215104444.783303cf@ashu.dyn1.rarus.ru>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu Dec 15 07:44:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb53m-0001QJ-Lv
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 07:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab1LOGou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 01:44:50 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53273 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab1LOGot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 01:44:49 -0500
Received: by eekc4 with SMTP id c4so1726290eek.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 22:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=vgmKGBS0GG90dCjmbpn4kJ7m6sHNcLkIczI0I/6fV4Q=;
        b=CRRv+5YPOgUZFAke0G96axMP5Df9wQCNZmCFUpa08M88Lz7A2o+eTjjGBt2xbisNVM
         RLZBkNji9jrY2hk/sWt2dhsN3vvMBmdezlLoHxiJYFD+Apy7ZIT22B3Ip58iTSD5ce6F
         3K5itOG45If78VwO1ZwmuLaeqNesNMM7vKpOQ=
Received: by 10.213.15.203 with SMTP id l11mr136708eba.126.1323931487952;
        Wed, 14 Dec 2011 22:44:47 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id 58sm20245977eet.11.2011.12.14.22.44.46
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 22:44:46 -0800 (PST)
In-Reply-To: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187190>

>  Do people have any feelings or conventions for how and when to
> publish a series of commits where the first one(s) break something
> and the next ones clear it up?
I'm curiuos, why to you want to commit changes that break something
separately from fixup?

Many conventions (as I know) use ideology that every commit must NOT
BREAK existing code or tests. Every SHARED commit. Git design (as you
must be already know) allows you to make/change/reorder as many commits
as you want (before you share them or push to a "central" repository).
So, you have not to be afraid to commit every your change, because you
can always change/fixup/split your commits.

Usually, you introduce a feature in a branch. Also, your project must
have (?) (mine do have) unit-tests, at least. And most changes must be
tested. So, breakage must be discovered early, even after some other
commits in that feature branch. In that case you can just make a fixup
commit and then rebase it on a breakage commit with a "squash".

And only after all features made and all tests passed you can share
them (push to another repo).

>I've found some discussion, but with vague results.
> 
>  I'm about to commit some small edits which go together with bigger
>  generated changes.  It seems both more readable and more cherry-pick-
>  friendly to me to keep these in separate commits.
> 
>  What I've found is I can use a line in the commit message like
>      "Incomplete change, requires next commit (update foo/ dir)."
>  and, if there is any point, do a no-ff merge past the breakage.
> 
