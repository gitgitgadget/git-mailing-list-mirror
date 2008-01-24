From: Sam Vilain <sam@vilain.net>
Subject: Re: Stripping 'git-svn-id' from commit messages, and switching to
 svn.noMetadata
Date: Fri, 25 Jan 2008 10:14:17 +1300
Message-ID: <4798FFA9.7010601@vilain.net>
References: <877ii0p89b.fsf@adler.orangeandbronze.com>	<4797D6C6.207@vilain.net> <87wspzobnq.fsf@adler.orangeandbronze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: JM Ibanez <jm@orangeandbronze.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:15:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI9PU-0000ZP-7r
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 22:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbYAXVOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 16:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756427AbYAXVOY
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 16:14:24 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:34355 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756255AbYAXVOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 16:14:23 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 52BDB21D12B; Fri, 25 Jan 2008 10:14:21 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 153ED21C7F9;
	Fri, 25 Jan 2008 10:14:18 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <87wspzobnq.fsf@adler.orangeandbronze.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71662>

JM Ibanez wrote:
> Actually, I forgot to mention that I already have grafts between the two
> to track merges I performed previously. So, in fact, the history looks
> like something this:
> 
>      A -- B -- C -- D -- E -- a -- b -- c -- d -- e -- f -- m3
>                          \         \          \             /
>                           \         \          \   /-------+
>      A'-- B'-- C'-- D'-- E'-- x -- y -- m1-- z -- m2
> 
> 
> where x, m1, m2, and m3 are squashed merge commits + grafts.
> 
> After git filter-branch with a graft of x to E, I get x having two
> parents as what is needed *but* because the parent IDs are part of the
> commit object, I now get x' y', etc, something like this:
> 
> 
> 
>      A -- B -- C -- D -- E -- a -- b -- c -- ...
>                          |         |
>                          |         |
>                          |         +--- m1'- z'-- m2' -- ...
>                          \         \
>                           \         \
>                            -- x -- y -- m1-- z -- ...
> 
> 
> sort of. In any case, I get duplicate commits of m1, z, etc. after the
> primary graft point. Is this expected?

I think you need to use a parent filter that looks up the old commit ID
in the grafts, and adjusts the parents accordingly.  I don't think I'd
be able to nail it down any further than that without actually trying.

I think the intent of git filter-branch's grafting support is that this
shouldn't happen, so if you can produce a test case then the bug can
likely be fixed.

Sam.
