From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Fri, 7 Oct 2005 10:22:06 -0700
Message-ID: <20051007172206.GK15593@reactrix.com>
References: <20051005214447.GF15593@reactrix.com> <Pine.LNX.4.63.0510061550510.23242@iabervon.org> <20051007000041.GH15593@reactrix.com> <Pine.LNX.4.63.0510071149550.23242@iabervon.org> <7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 19:24:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENvvV-0006aD-6w
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 19:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbVJGRW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 13:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbVJGRW3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 13:22:29 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:17977 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030518AbVJGRW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 13:22:28 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j97HMAAJ004055;
	Fri, 7 Oct 2005 10:22:10 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j97HM6qf004052;
	Fri, 7 Oct 2005 10:22:06 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9808>

On Fri, Oct 07, 2005 at 10:01:33AM -0700, Junio C Hamano wrote:

> The check was added in 029f6de377c7e0484f5c4cf070934599580f1784
> because back then calling fetch() on an object that we already
> had had a funny interaction with what http-fetch.c did.  I
> suspect that Nick's curl-multi changes made it unnecessary, but
> you should double check for other transports.

I think the only downside to leaving that check in place is that when
pull() finishes there may be completed requests left behind in the
queue, possibly with unreported transfer errors.  Would it make sense
to just release any requests left in the queue after pull(), and report
if any of them had transfer errors?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
