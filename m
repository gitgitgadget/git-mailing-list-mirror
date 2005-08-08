From: Junio C Hamano <junkio@cox.net>
Subject: Re: use of temporary refs in resolve
Date: Mon, 08 Aug 2005 02:06:49 -0700
Message-ID: <7vfytkdcgm.fsf@assigned-by-dhcp.cox.net>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
	<tnxk6iwx161.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 11:07:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E23b6-0002QA-09
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVHHJGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVHHJGy
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:06:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31434 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750780AbVHHJGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:06:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808090649.XOQF17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 05:06:49 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxk6iwx161.fsf@arm.com> (Catalin Marinas's message of "Mon, 08
	Aug 2005 09:50:30 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

>   gitk ORIG_HEAD..FETCH_HEAD

Yeah, Linus immediately corrected me when I said ORIG_HEAD
seemed useless.

> Is FETCH_HEAD going to be preserved by the git-fetch-script operation?
> It should be, unless, git-pull-script removes it or it is changed to
> do the fetch as well.

I am not quite sure what is being asked (especially "operation";
I take it you meant "surgery" or "butchering"), so my answer may
be missing the point.

I would like to update fetch to deal with multiple references,
and if the user tells it to fetch N references, the FETCH_HEAD
file would contain N lines, one line for each SHA1 object name.
Initially I will not allow pull to take more than one reference
because I will need to make resolve capable of resolving more
than two parents (i.e. octopus merge) before that happens.  But
once that is done, then pull will accept N references and call
fetch with these N references, then fetch leaves N lines in
FETCH_HEAD, and those N SHA1 object names along with the current
head would be given to resolve to create an (N+1)-head king
ghidorah.  I do not know how well this would go, but at least
that is the current plan.
