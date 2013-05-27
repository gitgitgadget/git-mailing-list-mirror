From: Ian Kumlien <pomac@vapor.com>
Subject: Re: git hangs on pthread_join
Date: Mon, 27 May 2013 15:58:32 +0200
Message-ID: <20130527135832.GB22308@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 16:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgyKy-0003cW-U1
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 16:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab3E0OXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 10:23:45 -0400
Received: from mail.vapor.com ([83.220.149.2]:45176 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932690Ab3E0OXo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 10:23:44 -0400
Received: from twilight.demius.net (c-297271d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.114.41])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id A371E40C474
	for <git@vger.kernel.org>; Mon, 27 May 2013 16:23:36 +0200 (CEST)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 821198E36CB; Mon, 27 May 2013 15:58:32 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225592>

I forgot to reply to the mailing list and now something went wrong with                                                                                               
the messages in mutt =P                                                                                                                                               
                                                                                                                                                                      
Recap:ing:                                     

On Thursday, May 23, 2013 07:01:43 am you wrote:                                                                                                                      
> I'm running a rather special configuration, basically i                                                                                                             
> have a gerrit server pushing                                                                                                                                        
...                                                                                                                                                                   
> I have found "git receive-pack"s that has been running                                                                                                              
> for days/weeks without terminating....                                                                                                                              
>                                                                                                                                                                     
...                                                                                                                                                                   
> Anyone that has any clues about what could be going                                                                                                                 
> wrong? --                                                                                                                                                           
                                                                                                                                                                      
                                                                                                                                                                      
Have you narrowed down whether this is a git client problem,                                                                                                          
or a server problem (gerrit in your case).  Is this a                                                                                                                 
repeatable issue.  Try the same operation against a clone of                                                                                                          
the repo using just git.  Check on the server side for .noz                                                                                                           
files in you repo (a jgit thing),                                                                                                                                     
                                                                                                                                                                      
---                                                                                                                                                                   
                                                                                                                                                                      
This happens both using gerrit and using git directly...                                                                                                              
                                                                                                                                                                      
My thought is more that git doesn't handle dodgy connections over                                                                                                     
openvpn (udp) that goes over dodgy international vpn links.                                                                                                           
                                                                                                                                                                      
I conclusion has always been that it ends up in a unpredictable state,                                                                                                
like a blocking read or so that just doesn't timeout... If it was a pipe                                                                                              
and not a socket then it'd always return... eventhough even a socket                                                                                                  
should timeout i have seen processes left like this for weeks.                                                                                                        
                                                                                                                                                                      
There was no .noz files on the master or the slave server.                                              
