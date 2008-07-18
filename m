From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Fri, 18 Jul 2008 19:20:01 +1000
Message-ID: <20080718092001.GD16102@mail.local.tull.net>
References: <20080718040459.13073.76896.stgit@marcab.local.tull.net> <7v8wvzeojm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJm9A-000158-Ug
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYGRJUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbYGRJUF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:20:05 -0400
Received: from vps1.tull.net ([66.180.172.116]:57227 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753479AbYGRJUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:20:04 -0400
Received: (qmail 3288 invoked by uid 1015); 18 Jul 2008 19:20:03 +1000
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Fri, 18 Jul 2008 19:20:03 +1000
Received: (qmail 19220 invoked by uid 1000); 18 Jul 2008 19:20:01 +1000
Content-Disposition: inline
In-Reply-To: <7v8wvzeojm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89018>

On Thu, Jul 17, 2008 at 10:42:21PM -0700, Junio C Hamano wrote:
> Thanks for noticing, but this replaces one breakage with another.
> 
> Your new behaviour is a new "tell me if it is an empty set" option, and it
> means quite different thing from what --quiet does.

Fair enough. Yes, I want to find out if it is an empty set. The
manpage does say "fully connected" which I interpreted to mean
that one set of commits is a subset of the other..

I want to automatically (e.g. in crontab) update a git repo to the latest
HEAD from a remote branch ... but with the possibility that the local
repo has local changes, and I want no chance of merge failure. In other
words, "git fetch remote; git merge origin/master" and only do the
merge if it's a fast-forward. If there are any local commits, or local
uncommitted changes, then leave the local working tree alone.

So my idea was to use "git rev-list --quiet master ^origin/master"
and check the exit code; if zero do "git merge origin/master". Without
a working "--quiet" nor exit code I can pipe the output to "wc -l"
but is there a more efficient/reliable way to implement the requirement?

Nick.
