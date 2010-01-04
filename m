From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 07:06:46 +0100
Message-ID: <20100104060646.GA14520@glandium.org>
References: <7v637nzky0.fsf@alter.siamese.dyndns.org>
 <7vzl4zy5z3.fsf@alter.siamese.dyndns.org>
 <20100102115041.GA32381@do>
 <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 07:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRg5t-0007B4-Ki
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 07:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab0ADGHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 01:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341Ab0ADGHF
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 01:07:05 -0500
Received: from vuizook.err.no ([85.19.221.46]:43011 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325Ab0ADGHD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 01:07:03 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NRg5X-0002ZB-8Y; Mon, 04 Jan 2010 07:06:49 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1NRg5W-0003mg-CG; Mon, 04 Jan 2010 07:06:46 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136094>

On Sun, Jan 03, 2010 at 11:32:24AM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 3 Jan 2010, Miles Bader wrote:
> > 
> > Since it's a general attribute of solaris that the default (/usr/bin)
> > tools are horrible sysv things and the actual useful tools are in
> > e.g. /usr/xpg4/bin, maybe it would be better to just try and add that
> > directory to the path...?
> 
> There is no generic way to make solaris sane, I'm afraid.
> 
> Everybody agrees that the "normal" Solaris tools are so horrible that they 
> all set up some alternative. However, qutie often the preferred 
> alternative is the GNU versions, mostly installed in /usr/local, and then 
> they put that first in the path.

Or /usr/sfw, where Sun themselves ship some GNU tools

> Which means that if you put /usr/xpg4/bin before other paths in your PATH, 
> you'll totally break such systems, because now you get the (inferior) 
> tools in xpg4 before the preferred tools in /usr/local. Or - this also 
> happens - people end up installing their own versions in $HOME/bin, 
> because the system admin is uncaring or incompetent.
> 
> In other words, there is no single normal or default Solaris installation 
> that we can work around. The normal/default installation is so horrible 
> that it's virtually never used in any environment where people actually 
> have shell access and do development.
> 
> Don't ask me why. EVERYBODY knows that the default /usr/bin is total crap. 
> Even Sun people know. But there's apparently some very deep-seated reason 
> (probably not technical, but mental/historical) why they can't be fixed or 
> replaced, probably relating to "make world" and the whole build system.

There is simply no explanation for these tools to be that crappy at all.
The most common reason that is given for these tools to stay as crappy as
they always have been is for backwards compatibility. But how does that
prevent from adding features is beyond me. And on the other hand, they
*do* add features to their /usr/bin tools, such as -h in (at least) df
and ls.

Anyways, why not generate the hash-bang lines of the shell scripts from a
Makefile variable that would be set to /usr/xpg4/bin/sh on Solaris and
/bin/sh on others ?

Mike
