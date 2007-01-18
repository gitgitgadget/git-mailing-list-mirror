From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not 
 .txt
Date: Thu, 18 Jan 2007 17:09:56 +0100
Organization: eudaptics software gmbh
Message-ID: <45AF9BD4.B0E44CB6@eudaptics.com>
References: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com> <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net> <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net> <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com> <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com> <45AF7FE8.5060003@op5.se> <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com> <20070118152620.GB15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 18 17:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZpL-0005H7-4G
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 17:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbXARQJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 11:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXARQJV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 11:09:21 -0500
Received: from main.gmane.org ([80.91.229.2]:54012 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbXARQJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 11:09:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H7Zp7-000767-MD
	for git@vger.kernel.org; Thu, 18 Jan 2007 17:09:10 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 17:09:09 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 17:09:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37117>

"Shawn O. Pearce" wrote:
> AFAIK there's not a strong reason to keep fork() in Git.
> 
> Currently anytime we fork a process its to perform a small amount
> of file descriptor redirection and then immediately exec some other
> executable, or a hook script.  In other words we probably could
> convert all current uses of fork to something like in run-command.c,
> which a Windows port could then easily replace using CreateProcess().
> 
> But removing fork isn't worth doing until someone is seriously
> trying to port Git onto Windows without Cygwin.  The current code
> works on sane OSes and isn't broken, so why fix it?

I'm doing just that (MinGW port).

I've come up with a function spawnvpe_pipe(), which hides all the scary
details of fork+exec with dup2's and close's. It could probably easily
be merged into run_command(), but I haven't tried that, yet.

I'll try to push out what I have to repo.or.cz over the weekend. 

-- Hannes
