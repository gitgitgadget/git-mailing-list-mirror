From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Fri, 21 Oct 2005 00:43:04 +0000 (UTC)
Message-ID: <loom.20051021T024100-352@post.gmane.org>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de> <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net> <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510201630000.25300@iabervon.org> <Pine.LNX.4.63.0510210114370.10503@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 21 02:46:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESl1z-0000tF-Jb
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVJUApI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVJUApI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:45:08 -0400
Received: from main.gmane.org ([80.91.229.2]:53989 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964828AbVJUApH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:45:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ESl0T-0000Td-7Q
	for git@vger.kernel.org; Fri, 21 Oct 2005 02:43:37 +0200
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Oct 2005 02:43:37 +0200
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Oct 2005 02:43:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10399>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> ... I did not use it originally, because lines 
> 24-25 of commit.h say
> 
> 	/** Internal only **/
> 	struct object *lookup_object(const unsigned char *sha1);
> 
> Is this obsolete?

For this particular application, it should be OK, because:

 - it checks if we already have that object, and returns a pointer to it;
 - if we haven't seen that object, we get a NULL back;

and

 - what we care about is to see if we have checked and verified if it is
   reachable from our refs.  We do not want the check to actively go read
   and parse that object.

-jc
