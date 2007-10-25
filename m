From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 1/7] "git" calls help_unknown_cmd(""); "git help" and
	"git help -a" return 0
Date: Wed, 24 Oct 2007 21:52:29 -0700
Message-ID: <20071025045228.GE759@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net> <7vd4v33iy0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:52:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikui1-0002FA-KS
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 06:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbXJYEwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 00:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbXJYEwc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 00:52:32 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:59621 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbXJYEwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 00:52:31 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1Ikuho-0002g6-Vw; Wed, 24 Oct 2007 23:52:29 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Wed, 24 Oct 2007 21:52:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd4v33iy0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62272>

On Wed, Oct 24, 2007 at 09:40:55PM -0700, Junio C Hamano wrote:

> Sorry, but I fail to see why this is an improvement.
> 
> However, with the current implementation, these changes to
> help.c also make "git<Enter>" to exit with 0 after it gives
> help, which is not so nice (both "cvs" and "svn" without
> parameter seem to exit with 1 and it sort of makes sense,
> although I do not think it matters much).  As a few datapoints,
> "cvs -H" exits with 1 and "svn help" exits with 0.

That's strange because when i run that patch on my system:

  % ./git; echo $?
  git: '' is not a git-command
 
  <list of common commands>
  1
  % ./git help; echo $?
  <list of common commands>
  0
  % ./git help -a; echo $?
  <list of all commands>
  0

> So in short,
> 
>  - "git" should retain the current behaviour (both output and
>    exit code).
> 
>  - "git help" should retain the current output but probably
>    should exit with 0.
> 
>  - Ditto for "git help -a".

That's what i was hoping this patch did. I'm not entirely sure how
its wrong as it seems to work for me.

Regarding "git: '' is not a git-command" the way i was seeing that
is that git is usually only called with commands, and '' isn't a
valid command, hence the reason to exit 1, the help is just a nice
user experience.

sRp

-- 
Scott Parish
http://srparish.net/
