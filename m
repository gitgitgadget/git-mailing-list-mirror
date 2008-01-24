From: Sam Vilain <sam@vilain.net>
Subject: Re: Stripping 'git-svn-id' from commit messages, and switching to
 svn.noMetadata
Date: Thu, 24 Jan 2008 13:07:34 +1300
Message-ID: <4797D6C6.207@vilain.net>
References: <877ii0p89b.fsf@adler.orangeandbronze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: JM Ibanez <jm@orangeandbronze.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 01:08:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHpdu-0007o1-RL
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 01:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbYAXAHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 19:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbYAXAHn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 19:07:43 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:59710 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbYAXAHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 19:07:42 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id F264C21D114; Thu, 24 Jan 2008 13:07:39 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 9545C21D10B;
	Thu, 24 Jan 2008 13:07:34 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <877ii0p89b.fsf@adler.orangeandbronze.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71577>

JM Ibanez wrote:
> Hi,
> 
> I've been trying to convert an existing git-svn clone to noMetadata
> (i.e. get rid of git-svn-id in the commit messages), primarily because
> I've been using it to track two SVN repos which were originally just a
> single repo-- they have the same UUID but are located on different
> machines, and have branched significantly, so content-wise are no longer
> the same repo.
> 
> Because the two repos have a single line of commits which they share, it
> would be best if I could store that history in my git repo (as I need to
> use it for merging between the two trees). Graphically, my current
> history looks something like this:
> 
> 
>     A -- B -- C -- D -- E -- a -- b -- c
> 
>     A'-- B'-- C'-- D'-- E'-- x -- y -- z
> 
> where, in reality, this should be represented as:
> 
>     A -- B -- C -- D -- E -- a -- b -- c
>                          \
>                           +- x -- y -- z

Stop.

Use a graft.  in .git/info/grafts, put (expanding to the full SHA1s):

x E

Then just run something like 'git filter-branch E..z'

That will at least stitch them together.

To figure out what git-svn is expecting, make a new repository, use
git-svn init, and then git-svn fetch -rNNN (where NNN is a revision near
the most recent).  That will at least show you what git-svn expects the
metadata to look like, if you really want to go down the path you are
going down...

Sam.
