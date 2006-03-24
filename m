From: Andreas Ericsson <ae@op5.se>
Subject: Re: Bug encountered while comitting
Date: Fri, 24 Mar 2006 20:34:57 +0100
Message-ID: <442449E1.5060007@op5.se>
References: <20060324183951.GA23193@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 20:35:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMs3z-0007qs-Jt
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 20:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWCXTfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 14:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWCXTfA
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 14:35:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:45800 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932629AbWCXTe7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 14:34:59 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E2A5A6BD4E; Fri, 24 Mar 2006 20:34:57 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Matthias Kestenholz <lists@irregular.ch>
In-Reply-To: <20060324183951.GA23193@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17940>

Matthias Kestenholz wrote:
> Hello list,
> 
> I don't know if this is the right place to report a bug, but I'll
> just try and see what comes back.
> 
> I am trying to build a Wiki [1] using PHP, a hacked version of Markdown,
> and git for content tracking. I use the git core plumbing to do the
> history work.
> 
> The PHP script created directories under .git/objects


Ouch... You're not really supposed to do that. The proper thing to do is 
to do things in the working tree and commit them to git later.


> which were
> only writable by www-data. There were other directories which were
> owned by user mk and group www-data, and they were group writable.
> 
> So, I had write access to only a part of the .git directory.
> 

Unless you're using the git tools (or things hooking in to the git core 
C functions somehow), don't touch the .git directory.

(this merits an exclamation marks, so brace yourselves) !


> When I tried to commit, I got a message saying "Unable to write sha1
> filename".
> 

What file were you trying to write?

> The result was, that only part of the commit was recorded and that I
> experienced repository corruption. refs/heads/master pointed to a
> non-existant object.
> 

Did you use git tools to update .git/refs/heads/master ?


> The expected behavior would have been an error message telling me I
> had insufficient write privileges and surely no repository
> corruption.
> 

Didn't you get the strerror(3) message from that? If so, I'd consider it 
a bug.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
