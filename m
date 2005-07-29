From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Dump http servers still slow?
Date: Fri, 29 Jul 2005 09:03:41 -0500
Message-ID: <1122645821.4263.6.camel@localhost.localdomain>
References: <1122584423.12374.11.camel@localhost.localdomain>
	 <7vy87qpcwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 16:03:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyVSn-0006m5-4L
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 16:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVG2ODn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 10:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVG2ODn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 10:03:43 -0400
Received: from zealot.progeny.com ([216.37.46.162]:3969 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S262597AbVG2ODm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 10:03:42 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 8C0FD636AB; Fri, 29 Jul 2005 09:03:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy87qpcwg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-07-28 at 19:24 -0700, Junio C Hamano wrote:
> The thing is, the base pack for the git repository is 1.8MB
> currently containing 4500+ objects, while we accumulated 600+
> unpacked objects since then which is about ~5MB.  The commit
> walker needs to fetched the latter one by one in the old way.
> 
> When packed incrementally on top of the base pack, these 600+
> unpacked objects compress down to something like 400KB, and I
> was hoping we could wait until we accumulate enough to produce
> an incremental about a meg or so ...

Ok... so lets check my assumptions:

1. Pack files should reduce the number of http round trips.
2. What I'm seeing when I check out mainline git is the acquisition of a
single large pack, then 600+ more recent objects. Better than before,
but still hundreds of round trips.
3. If I wanted to further speed up the initial checkout on my own
repositories I could frequently repack my most recent few hundred
objects.
4. If curl had pipelining then less pack management would be needed.

Where is the code for gitweb? (i.e. http://kernel.org/git ) Seems like
it could benefit from some git-send-pack superpowers.

--
Darrin
