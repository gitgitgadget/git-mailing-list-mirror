From: Junio C Hamano <junkio@cox.net>
Subject: Re: Kernel headers git tree
Date: Thu, 13 Jul 2006 19:37:11 -0700
Message-ID: <7vwtagsyi0.fsf@assigned-by-dhcp.cox.net>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	<7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
	<1152838562.31372.58.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 04:37:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1DYQ-0006Ey-8H
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 04:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWGNChT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 22:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWGNChT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 22:37:19 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1214 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161179AbWGNChR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 22:37:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714023717.HVRU8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 22:37:17 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152838562.31372.58.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Fri, 14 Jul 2006 01:56:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23868>

David Woodhouse <dwmw2@infradead.org> writes:

> On Thu, 2006-07-13 at 17:39 -0700, Junio C Hamano wrote:
>> With modern enough git, you can rewrite
>>         KBUILDSHA=`git ls-tree $TREE -- Kbuild | cut -f3 -d\  | cut -f1`
>> with
>>         KBUILDSHA1=`git rev-parse $TREE:Kbuild`
>
>
> Aha. Thanks.
>
>> I am not sure what function incparent() is trying to do with
>> this:
>> 
>>         git rev-list --max-count=1 --topo-order $1 -- . 
>
> Find the latest ancestor commit which actually changed any files. The
> first script has a similar line, except that it finds the latest
> ancestor which changed anything in include/
>
> Consider a kernel tree with commits A-->B-->C-->D, of which only A and C
> change anything in include/ and in fact only C actually changes the
> _exported_ headers after the unifdef and sed bits. 
>
> The first script (extract-khdrs-git.sh) creates a 'stage1' branch which
> only contains commits A'-->C', with the _exported_ header tree for each.
>
> The second script (extract-khdrs-stage2.sh) then creates the master
> branch with the same tree objects, but omitting the commits which don't
> change anything. So it contains only commit C''

I guess what I was getting at was if you can avoid creating
commits that do not change anything from previous in stage1
branch, you do not have to do this, but I haven't studied stage1
script deeply enough.
