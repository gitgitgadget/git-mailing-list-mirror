From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] git-clone should create packed refs
Date: Fri, 15 Feb 2008 02:13:38 +0100
Message-ID: <200802150213.38532.johan@herland.net>
References: <200802150133.19247.johan@herland.net>
 <alpine.LSU.1.00.0802150051320.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 02:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPp9j-0005nT-62
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 02:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268AbYBOBNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 20:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759222AbYBOBNs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 20:13:48 -0500
Received: from smtp.getmail.no ([84.208.20.33]:46574 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758896AbYBOBNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 20:13:47 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JW900401A2WR100@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 15 Feb 2008 02:13:44 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW900DBOA2QTG10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 15 Feb 2008 02:13:38 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW900DSOA2QMQ50@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 15 Feb 2008 02:13:38 +0100 (CET)
In-reply-to: <alpine.LSU.1.00.0802150051320.30505@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73936>

On Friday 15 February 2008, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 15 Feb 2008, Johan Herland wrote:
> 
> > when git-clone is cloning repos with thousands of refs, it makes sense 
> > to create a packed-refs file directly in the clone, instead of having to 
> > run "git pack-refs" (or "git gc") afterwards to (re)pack the refs.
> 
> Sure, and it's easy, too.  The format of the packed-refs file is exactly 
> the same as the output of "git ls-remote <origin>".

As I said in my first email: similar, but not identical.

Contrast:

$ git ls-remote origin
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd        HEAD
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd        refs/heads/another_branch
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd        refs/heads/master
d6f7eacba9f07aa382a113e129866266c8d60642        refs/tags/complex_tag
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd        refs/tags/complex_tag^{}
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd        refs/tags/simple_tag
$ cat .git/packed-refs
# pack-refs with: peeled
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd refs/heads/master
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd refs/remotes/origin/another_branch
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd refs/remotes/origin/master
d6f7eacba9f07aa382a113e129866266c8d60642 refs/tags/complex_tag
^ec09f49905e94f3bbf04bf3521f1fc59b1345cbd
ec09f49905e94f3bbf04bf3521f1fc59b1345cbd refs/tags/simple_tag
$


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
