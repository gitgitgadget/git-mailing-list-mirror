From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Multiple checkouts active for the same repository
Date: Fri, 24 Sep 2010 10:32:50 -0600
Message-ID: <4C9CD2B2.3030106@workspacewhiz.com>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com> <14b089955184bbb677b6434993682403@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gustavo Narea <gnarea@tech.2degreesnetwork.com>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 24 18:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzBDW-0007ii-SX
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974Ab0IXQcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:32:54 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:46672 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756965Ab0IXQcy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:32:54 -0400
Received: (qmail 15922 invoked by uid 399); 24 Sep 2010 10:32:53 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.230.186)
  by hsmail.qwknetllc.com with ESMTPAM; 24 Sep 2010 10:32:53 -0600
X-Originating-IP: 75.196.230.186
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <14b089955184bbb677b6434993682403@212.159.54.234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157020>

  ----- Original Message -----
From: Julian Phillips
Date: 9/24/2010 9:33 AM
> The git-new-workdir script to be found in contrib/workdir allows multiple
> working copies to share the same repository - though there are some
> caveats:
>
>   1) uses symbolic links, so doesn't work on Windows
Windows Vista and Windows 7 both support proper file and directory 
symbolic links.  According to my experimentation the other day with 
git-new-workdir on Windows 7:

* Windows - mklink /D creates a directory symbolic link.  mklink creates 
a file symbolic link.  The file system traverses into the symbolic link 
and back out of it just like Unix.  rmdir /S deletes just the directory 
symbolic link.  Windows Explorer's delete does the same.
* Cygwin - 'ln -s' does not create a true directory symbolic link.  
Cygwin seems to understand the symbolic link, but Windows itself 
doesn't.  'rm -f' properly deletes a directory symbolic link.
* Bash included with msysGit - 'ln -s' performs a file/directory copy.  
'rm -f' whacks the directory contents of the linked directory and then 
deletes the symbolic link.  Ick.  :(

Josh
