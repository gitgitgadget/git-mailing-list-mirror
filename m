From: Dan Nicholson <dbn.lists@gmail.com>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 20:52:15 +0000 (UTC)
Message-ID: <loom.20070510T224750-851@post.gmane.org>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net> 	<20070509.150256.59469756.davem@davemloft.net> 	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net> 	<20070509.162301.48802460.davem@davemloft.net> 	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net> 	<7vd519r10c.fsf@assigned-by-dhcp.cox.net> <vpqtzul3xzm.fsf@bauges.imag.fr> <4642DE52.F9F0A5B2@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 23:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGNN-00005I-PM
	for gcvg-git@gmane.org; Thu, 10 May 2007 23:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760182AbXEJVkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 17:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761234AbXEJVkM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 17:40:12 -0400
Received: from main.gmane.org ([80.91.229.2]:38068 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761248AbXEJVkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 17:40:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HmGMk-0002Ua-Ng
	for git@vger.kernel.org; Thu, 10 May 2007 23:40:03 +0200
Received: from blv-proxy-08.boeing.com ([130.76.32.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 23:40:02 +0200
Received: from dbn.lists by blv-proxy-08.boeing.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 23:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 130.76.32.167 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070309 Firefox/2.0.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46902>

Johannes Sixt <J.Sixt <at> eudaptics.com> writes:
> 
> Matthieu Moy wrote:
> > 
> > Junio C Hamano <junkio <at> cox.net> writes:
> > 
> > >  get_repo_base() {
> > > -     (cd "$1" && (cd .git ; pwd)) 2> /dev/null
> > > +     (
> > > +             cd "`/bin/pwd`" &&
> > > +             cd "$1" &&
> > > +             (
> > > +                     cd .git
> > > +                     pwd
> > > +             )
> > > +     ) 2>/dev/null
> > >  }
> > 
> > Will this work on windows?
> 
> Yes. As does the alternative that uses cd -P. MinGW uses bash (3.1
> here).

In fact, all POSIX shells should support `cd -P' according to the spec, so it
should probably just be used directly instead of hoping that /bin/pwd exists.

(cd -P "$1" && (cd .git ; pwd)) 2>/dev/null

http://www.opengroup.org/onlinepubs/009695399/utilities/cd.html

--
Dan
