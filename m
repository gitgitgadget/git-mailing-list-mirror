From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn Rewrites Some Commits, but not All
Date: Wed, 30 Apr 2014 06:59:51 +0000
Message-ID: <20140430065951.GA30265@dcvr.yhbt.net>
References: <CADu-kvcXWXAd2iBt+oQOVt5znxLmU0fmJ-tgOaogyfGjS5R0vA@mail.gmail.com>
 <CAA01CsoWw2OxuO7e09u18b9-g8c2aavDNWPDE_TvG33-79nwMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Laws <dartme18@gmail.com>, git <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 08:59:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfOUl-0004b6-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 08:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbaD3G7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 02:59:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57354 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaD3G7v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 02:59:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F63144C009;
	Wed, 30 Apr 2014 06:59:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAA01CsoWw2OxuO7e09u18b9-g8c2aavDNWPDE_TvG33-79nwMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247680>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> wrote:
> On Mon, Apr 28, 2014 at 9:26 PM, Aaron Laws <dartme18@gmail.com> wrote:
> > The way I understand it, when `git svn dcommit` is run, new commits
> > are created (A' is created from A adding SVN information), then the
> > current branch is moved to point to A'. Why don't we move any other
> > refs that were pointing to A over to A' ? What would be the point of
> > continuing to point to A? I'm interested in looking into coding this
> > change to git-svn, but I would like to hear some feedback first.
> 
> I think A' might not always be simply (A + SVN info). I think you can
> dcommit when you're not up to date.  So A' will have a different
> parent than A (will be automatically rebased on top of current branch
> tip). Other refs pointing to A might be used as bookmarks, and moving
> them from A to A' would be a significant change.

Right, I would not want "git rebase" (what dcommit uses internally)
to scan all the branches in my repository and try to update them
behind my back.  It's far too surprising and potentially dangerous.
