From: Jason Felice <jason.m.felice@gmail.com>
Subject: Re: error: git-svn died of signal 13
Date: Wed, 16 Dec 2009 14:56:48 +0000 (UTC)
Message-ID: <loom.20091216T154525-417@post.gmane.org>
References: <20091209053602.GA2739@progeny.tock> <20091209055824.GA22941@dcvr.yhbt.net> <20091209075319.GA4201@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:00:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKvMa-0007zy-Kv
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 16:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758588AbZLPPAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 10:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758383AbZLPPAV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 10:00:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:32813 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758102AbZLPPAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 10:00:19 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NKvMM-0007s0-4o
	for git@vger.kernel.org; Wed, 16 Dec 2009 16:00:14 +0100
Received: from 205.242.72.5 ([205.242.72.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 16:00:14 +0100
Received: from jason.m.felice by 205.242.72.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 16:00:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 205.242.72.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135330>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

> 
> CCing those who reported the problem.  There is some debugging advice below,
> for anyone who wants to take a further stab at tracking this down.
> 
> Eric Wong wrote:
> > Can somebody get an strace or core dump for the "git update-index"
> > call?  Or even an strace -f of the entire git svn invocation as well...
> 

I am having the same issue, pulling a HTTPS repo being served with Subversion
1.4.5.  Other info: The repo has many, many tags (~300?), and ~5000 revisions,
and I've been pulling it since Saturday!  Each iteration of git svn fetch takes
longer and longer before producing output.  It "feels" like  It The tags seem to
be what's slowing it down.)  I can't make this repo or shell access available
(sorry).

I got an strace:

jfelice@lx-cclamp:~/xpay-core$ strace -f -o /tmp/strace git svn fetch
r3176 = 816a8e7ffd28a2224a75037cf6a983883532c76e (refs/remotes/tags/v01_01_87)
error: git-svn died of signal 13

The strace output is at:

http://eraserhead.net/files/strace.bz2

I originally suspected that our crufty HTTPS server was closing the connection
on us due to some kind of timeout.
