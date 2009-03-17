From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn: creating tags from a subdirectory of trunk
Date: Tue, 17 Mar 2009 15:43:13 +0100
Message-ID: <49BFB701.3040800@drmicha.warpmail.net>
References: <632a37a0903151418u483ca6cal1582518b9120da8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Tom Huybrechts <tom.huybrechts@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 15:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjaXL-0007LJ-75
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 15:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbZCQOna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 10:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbZCQOna
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 10:43:30 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:57147 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700AbZCQOn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 10:43:29 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 8A4CF2F06A0;
	Tue, 17 Mar 2009 10:43:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 17 Mar 2009 10:43:27 -0400
X-Sasl-enc: N5Age6naztaSmsQM8JfV2gJKjb5d775k+ZPdu1RCKLs3 1237301007
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C42872ACAB;
	Tue, 17 Mar 2009 10:43:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090317 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <632a37a0903151418u483ca6cal1582518b9120da8e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113474>

Tom Huybrechts venit, vidit, dixit 15.03.2009 22:18:
> Hi,
> 
> I'm trying to setup a git mirror of a svn repository.  The tags in
> this repository are not created trunk it self, but from subdirectories
> of trunk. The tags and branches are in the standard places.
> e.g:
> /trunk/main -> tags/main-1
> /trunk/plugins/foo -> tags/foo-1
> /trunk/plugins/bar -> tags/bar-1
> 
> I run 'git svn clone -s svn-url target'. It starts going over the
> history nicely until it reaches the first branch. It calls this branch
> something like tags/tag-name@revision, and starts retrieving the
> entire project history again from r1. This is repeated for every
> branch.

And I thought *I* had produced sick repos by abusing svn...
There are also such niceties as
/trunk/trunk/
in there.

The problem is that svn tags are branches (to the same extent that svn
branches are branches...) and git svn treats them as such, but the
hudson tags contain only subtrees. I think you have two options:

- Convert without tags, and try to assign real git tags later on based
on the output of svn log. (This assumes svn tags have not been abused as
branches.)

- Setup git svn configs for each subproject individually, since the tags
contain only subproject tags.

It seems as though hudson's tags have not been abused as branches,
except for some messing with deletes and recreations. So the first
approach may be worthwhile.

Michael
