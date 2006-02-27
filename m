From: Andreas Ericsson <ae@op5.se>
Subject: Re: cg-status and empty directories
Date: Mon, 27 Feb 2006 16:22:41 +0100
Message-ID: <44031941.1020806@op5.se>
References: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 16:27:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDkCz-0006fK-Pc
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 16:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWB0PWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 10:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWB0PWn
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 10:22:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:12722 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751403AbWB0PWm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 10:22:42 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C04956BD10; Mon, 27 Feb 2006 16:22:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jim MacBaine <jmacbaine@gmail.com>
In-Reply-To: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16851>

Jim MacBaine wrote:
> Hello,
> 
> Short story: Recently I noticed a change in the way, cogito handles
> empty directories.  Before, empty directories have been silently
> ignored. Now cg-status always lists the status of empty directories as
> unknown, but it still refuses to add them. If there is a good reason
> for this behaviour, can someone enlighten me?
> 
> Long story: I'm using cogito to track and distribute changes on the
> /etc directories of a few (almost) identical machines.  Whenever I
> install a package which modifies somthing in /etc, I commit those
> changes.  But with cg-status reporting all the empty directories as
> "unknown", my brain needs a long time to parse the list and find the
> really unknown files which shall be put under version control.
> 
> Many packages put empty directories under /etc, and although only a
> few of those directories are actually needed, the automatic removal of
> those packages will fail if I remove the empty directories manually.  
> Equally, the removal will fail, if I put a .placeholder file into
> those direrectories and cg-add it.  Is there a simple way out?
> 

I'm afraid not.

You should also note that git doesn't track permissions exactly. It just 
notices an execution bit and uses it to determine if it should write the 
working tree using (0666 ^ umask) or (0777 ^ umask). This makes it 
fairly unsuitable for /etc tracking unless you add some sort of 
permission restoring thing to it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
