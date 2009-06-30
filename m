From: Jeff King <peff@peff.net>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Tue, 30 Jun 2009 00:03:37 -0400
Message-ID: <20090630040337.GA23741@sigio.peff.net>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 06:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLUXf-0006va-MO
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 06:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbZF3EBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 00:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbZF3EBo
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 00:01:44 -0400
Received: from peff.net ([208.65.91.99]:57032 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbZF3EBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 00:01:44 -0400
Received: (qmail 23755 invoked by uid 1000); 30 Jun 2009 04:03:37 -0000
Content-Disposition: inline
In-Reply-To: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122483>

On Mon, Jun 29, 2009 at 05:08:47PM -0700, Eric Raible wrote:

> [Surely this has been address before,  but I wasn't able to find it...]

There is some discussion here:

  http://article.gmane.org/gmane.comp.version-control.git/112077

> The documentation for git-log -S includes:
> 
> "Look for differences that introduce or remove an instance of <string>.
>  Note that this is different than the string simply appearing in diff output"
> 
> But I want to do that "different" thing (IOW I want search the diff output).
> 
> So must I loop through git-rev-list, grepping git-diff output on each commit?

Currently, yes. There is no way to do it internally. A patch to
implement it would probably be accepted, though (see the thread I
mentioned above for more details).

You can at least combine rev-list and diff into one command, and grep
like this (for 'foo'):

  git log -z -p | perl -0ne 'print if /^[-+].*foo/m' | tr '\0' '\n'

-Peff
