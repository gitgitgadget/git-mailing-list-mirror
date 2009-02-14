From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 22:43:45 -0500
Message-ID: <20090214034345.GB24545@coredump.intra.peff.net>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com> <1234515275-91263-2-git-send-email-jaysoffian@gmail.com> <1234515275-91263-3-git-send-email-jaysoffian@gmail.com> <1234515275-91263-4-git-send-email-jaysoffian@gmail.com> <1234515275-91263-5-git-send-email-jaysoffian@gmail.com> <7vtz6yabsy.fsf@gitster.siamese.dyndns.org> <20090214002253.GA7769@coredump.intra.peff.net> <7vab8p4w1u.fsf@gitster.siamese.dyndns.org> <76718490902131859u4645dc62h79632cb20ee90d69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 04:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYBSu-0006Dv-8P
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 04:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZBNDns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 22:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbZBNDns
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 22:43:48 -0500
Received: from peff.net ([208.65.91.99]:40746 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbZBNDns (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 22:43:48 -0500
Received: (qmail 28342 invoked by uid 107); 14 Feb 2009 03:44:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 22:44:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 22:43:45 -0500
Content-Disposition: inline
In-Reply-To: <76718490902131859u4645dc62h79632cb20ee90d69@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109814>

On Fri, Feb 13, 2009 at 09:59:06PM -0500, Jay Soffian wrote:

> What should we show in the output of "git remote show origin" next to
> the HEAD line? master, or frotz? If we show master, then user might
> wonder why "git remote set-head origin --auto" leaves
> refs/remotes/origin/HEAD set to frotz. If we show frotz, then user
> might wonder why when they cloned the repo in the first place they
> ended up with HEAD set to master.
> 
> I'm bothered by that inconsistency, which is why I didn't follow-up
> with another patch immediately.

Hrm. Yeah, I think to avoid surprising the user, "--auto" has to use
whatever we showed in "git remote show".

> But I will propose an alternative. In the output of "get remote show
> origin", we show all matching branches. If the user does a set-head
> --auto and we cannot determine HEAD unambiguously, we do something
> like:
> 
> $ git remote set-head origin --auto
> error: Multiple branches match HEAD. Please choose one explicitly with:
>    git remote set-head origin master
>    git remote set-head origin frotz

I like that proposal. It doesn't hide from the user that we are doing a
matching guess, which means we are less likely to surprise them in the
long run.

-Peff
