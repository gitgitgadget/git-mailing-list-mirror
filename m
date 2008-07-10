From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] apply: fix copy/rename breakage
Date: Thu, 10 Jul 2008 11:43:48 -0400
Message-ID: <20080710154348.GC22201@redhat.com>
References: <7vy74aqvr1.fsf@gitster.siamese.dyndns.org> <20080710140154.GN26957@redhat.com> <48762919.6070902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 18:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGych-00029x-M7
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 18:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYGJQCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 12:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbYGJQCS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 12:02:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45791 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbYGJQCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 12:02:17 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6AFhnGa016041;
	Thu, 10 Jul 2008 11:43:49 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6AFhnZl017538;
	Thu, 10 Jul 2008 11:43:49 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m6AFhmHm026280;
	Thu, 10 Jul 2008 11:43:48 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m6AFhn54023566;
	Thu, 10 Jul 2008 11:43:49 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m6AFhm63023565;
	Thu, 10 Jul 2008 11:43:48 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <48762919.6070902@viscovery.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87988>

On Thu, Jul 10, 2008 at 05:22:01PM +0200, Johannes Sixt wrote:
> >> With this patch, we disable the postimage record 'fn_table' when applying
> >> a patch to produce new files out of existing file by copying to fix this
> >> issue.
> > 
> > Odd.  I guess the way I read this workflow is
> > 
> > apply change X to A, copy A' to B, apply change Y to B => B' now has changes X+Y
> > 
> > But instead you are saying B' only has change Y because A is copied to B
> > not A'.
> > 
> > Regardless, it doesn't affect my workflow.
> 
> Oh, it does. It's a normal git diff where a copy was detected!
> 
> Don't let you distract by the word "incremental" and by the names A and B.
> In the example above, the change X comes first because 'A' is sorted
> before 'B'. If the roles of A and B were swapped, then you have this patch:
> 
>  	diff --git a/A b/A
>  	copy from B
>  	copy to A
>  	--- a/A
>  	+++ b/A
>  	... change text Y here ...
>  	diff --git a/A b/B
>  	--- a/A
>  	+++ b/B
>  	... change text X here ...
> 
> See?

Yes, thank you!

Cheers,
Don
