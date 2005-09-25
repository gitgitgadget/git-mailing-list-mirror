From: Robin Farine <robin.farine@terminus.org>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 20:46:10 +0000 (UTC)
Message-ID: <loom.20050925T222758-893@post.gmane.org>
References: <20050925070719.67119.qmail@web26309.mail.ukl.yahoo.com> <200509252056.04403.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 25 23:03:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJdd8-0003qQ-57
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 23:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVIYVBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVIYVBn
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 17:01:43 -0400
Received: from main.gmane.org ([80.91.229.2]:37296 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932292AbVIYVBm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 17:01:42 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EJdcH-0003gY-7o
	for git@vger.kernel.org; Sun, 25 Sep 2005 23:00:57 +0200
Received: from dsl-du-83-173-254-97.cybernet.ch ([83.173.254.97])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2005 23:00:57 +0200
Received: from robin.farine by dsl-du-83-173-254-97.cybernet.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2005 23:00:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.173.254.97 (Mozilla/5.0 (compatible; Konqueror/3.4; Linux) KHTML/3.4.1 (like Gecko) (Debian package 4:3.4.1-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9286>

Josef Weidendorfer <Josef.Weidendorfer <at> gmx.de> writes:    
  
> On Sunday 25 September 2005 09:07, Marco Costalba wrote:    
> > >> src/rangeselectbase.h QSettings: error creating /.qt    
> > >>QSettings: error creating /.qt    
> > ...    
> > QSettings are there from day one :-<    
> > I am not able to let them disappear.....very bad. In any case should be    
> > harmless.    
>     
> These errors seam to appear because scons does NOT pass through the $HOME    
> environment variable to subprocesses. "moc", which is producing these    
> errors, obviously wants to access some config options in $HOME/.qt/.    
>     
> Somebody knows how to change this?    
    
With SCons, key-value pairs that are meant to appear in process    
environment need to be added to the env['ENV'] mapping. In this  
case:  
   
    env = Environment(...)  
    env['ENV']['HOME'] = os.environ['HOME']   
   
Environment() creates an SCons build environment which is unrelated  
to subprocess environments (even though the same word is used :)).  
As a special case, SCons handles the mapping assigned to env['ENV']  
as process environment for subprocesses.  
  
Hope this helps,  
  
Robin    
 
    
