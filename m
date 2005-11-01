From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 09:23:55 +0000
Message-ID: <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	 <20051031195010.GM11488@ca-server1.us.oracle.com>
	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <20051031213616.GO11488@ca-server1.us.oracle.com>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, mason@suse.com,
	git@vger.kernel.org, Chuck Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Nov 01 10:25:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWsN5-0002S9-Lq
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 10:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKAJX4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 04:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKAJX4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 04:23:56 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:40697 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750713AbVKAJXz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 04:23:55 -0500
Received: by xproxy.gmail.com with SMTP id i30so1240574wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 01:23:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q2IHrq5+qwmLNyGOxhMzYJHCGpNvN/ORtN64kthCmEr7sxj36M/zyMJHl8p78fTPrDMClZn/I7AtAT24DY/3BeD2HQu3dxVYoibNVtyE1d6BpB/oVbSSlU6/w1IZivxMwdU4KRtDSgOqHtIVfyMkXuv8w8TBaWERM+/244acr2o=
Received: by 10.70.66.8 with SMTP id o8mr2378373wxa;
        Tue, 01 Nov 2005 01:23:55 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Tue, 1 Nov 2005 01:23:55 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051101090804.GA11618@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10929>

On 01/11/05, Petr Baudis <pasky@suse.cz> wrote:
> Did anyone do any current detailed comparison between hg mq and StGIT?

Not AFAIK. I looked a bit at mq but didn't have time to play with it.

> I'm very happy with StGIT, modulo few UI gripes I'm still not getting
> around to fix, and the fact that I cannot version my changes to patches
> - this is one advantage of having quilt stuff tracked by GIT, I think,
> but that feels ugly.

That's not too far away. Chuck Lever has a patch (and there were some
other discussions in the past) for tracking the history of a patch.
Basically, there would be another commit object, not reachable from
HEAD but only via an StGIT command, which would chain all the versions
of a patch. You would be able to view them with gitk for example.

My main issue was whether we should store every state resulted from a
refresh  or use a separate command (somebody suggested 'freeze') to
mark the states that should be preserved in the history. Chuck's patch
implements the first. The drawback is that a future 'stg prune'
command would not be able to remove the history and some states of the
patch might not be useful (there are times when I do a refresh only to
pop the patch and modify a different one, without any logical meaning
for the state of the patch).

I'm open to other suggestions as well. Otherwise, Chuck's patch should
do the job.

--
Catalin
