From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 10:37:57 +0200
Message-ID: <20070322083757.GC29341@mellanox.co.il>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
	<7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
	<20070322074051.GA29341@mellanox.co.il>
	<7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 09:37:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUInQ-0002f7-5y
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 09:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965851AbXCVIhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 04:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965856AbXCVIhQ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 04:37:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:22346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965851AbXCVIhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 04:37:14 -0400
Received: by ug-out-1314.google.com with SMTP id 44so620066uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 01:37:12 -0700 (PDT)
Received: by 10.67.106.3 with SMTP id i3mr4520302ugm.1174552632693;
        Thu, 22 Mar 2007 01:37:12 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id g30sm2894082ugd.2007.03.22.01.37.11;
        Thu, 22 Mar 2007 01:37:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42848>

> (2) ... In other
>     words, *users* of git-am are not supposed to figure it out.
>     They will not find *their* project policy from git
>     documentation, unless their project happens to be the git
>     project.

But if they don't use the same formatting as git policy requires,
git-am will produce a mess of a log, until they
discover the only policy that works with git-am by word of mouth.

Specifically, as far as a *user* is concerned:
1. the fact that "---" separates commit message from patch, and
   that text after "---" is ignored seems to be undocumented
2. the fact that message subject is appended to the log,
   the rules for removing [PATCH] etc from subject seem to be undocumented
3. if I want to have some text coming *before* the commit
   message ignored, there's no way to do this
4. there's no way to override the subject from within the message
   (like there is with author/From line)

> (3) However, we are discussing your patch to support "git merge
>     FETCH_HEAD" better, which I took as your contribution to the
>     git project.  I asked you to follow the project policy for
>     your contribution, and pointed at the document that
>     describes the policy.

Amen to that, sorry about the formatting.

> To reiterate the more important points (this is also for my own
> purpose because I do not want the patch lost in this noise we
> are making):
> 
>  - Checking readability of $GIT_DIR/$remote itself is too loose;
>    the name FETCH_HEAD should explicitly be checked, as that is
>    the file that has the specific format that is understood by
>    fmt-merge-msg.
> 
>  - "echo -n" is to be avoided for portability.
> 
>  - "git fetch $URL foo bar" would leave two lines in FETCH_HEAD;
>    subsequent "git merge FETCH_HEAD" would merge only foo.  Pick
>    the first line, stripping out not-for-merge marker and let it
>    processed by fmt-merge-msg.

Thanks, I'll try to address these.

-- 
MST
