From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] refs.c: drop duplicate entries in sort_ref_list
Date: Thu, 19 Apr 2007 10:19:54 +0200
Organization: eudaptics software gmbh
Message-ID: <4627262A.463AA87D@eudaptics.com>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
		<Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
		<7vslaymzk3.fsf@assigned-by-dhcp.cox.net>
		<Pine.LNX.4.64.0704172304380.16435@beast.quantumfyre.co.uk>
		<7vodllfpaj.fsf@assigned-by-dhcp.cox.net> <20070418212749.4842.62822.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 10:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeRtm-00045z-LN
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbXDSIVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbXDSIUU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:20:20 -0400
Received: from main.gmane.org ([80.91.229.2]:53308 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161309AbXDSIUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 04:20:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HeRs3-0002Vn-2r
	for git@vger.kernel.org; Thu, 19 Apr 2007 10:20:03 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 10:20:03 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 10:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44991>

Julian Phillips wrote:
> 
> It shouldn't happen that we read duplicate entries into the same list,
> but just in case make sort_ref_list drop them.  If the SHA1s don't
> match then die instead, as we have no way of knowing which one is the
> correct one.

Clone a random repository that has tags, then

$ rm .git/refs/tags/*
$ git fetch origin

now lists each tag twice: for the tag object itself and the commit it
points to. Is this related to the problem you are solving here? If so,
dying is probably not the best in this situation since the tags are
still unique.

(rm .git/refs/tags/* may be insane, but just the other day I wanted to
clean up my repo from a number of unneeded branches as well as the tags
that they contained - to find out that it is not enough to remove the
refs: the objects must go away too, otherwise git fetch auto-follows
them and the tags come back even though the branch heads are not there
anymore.)

$ git version
git version 1.5.1.1.27.g91776

-- Hannes
