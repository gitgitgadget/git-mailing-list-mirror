From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Mon, 14 Nov 2005 09:57:12 +0100
Message-ID: <43785168.7050808@op5.se>
References: <4376C797.3050600@matysik.co.nz>	<Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>	<437788A0.6030103@op5.se> <7vr79j1wfl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 09:57:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eba9P-0003wi-UT
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 09:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVKNI5O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 03:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKNI5O
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 03:57:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:32192 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750917AbVKNI5O
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 03:57:14 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D3E6A6BCBE; Mon, 14 Nov 2005 09:57:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr79j1wfl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11774>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>git-email; This one only uses Email::Valid->address(), so I'll import 
>>that function from the perl module so this dependency can be dropped and 
>>git-send-email can be in the 'git' package.
> 
> 
> Hmph.  This should have occurred to somebody when we did the same
> with subprocess.py, but obviously it went unnoticed.
> 

Apparently it's not so easy. The Email::Valid thing contains a regex 
some 5000 chars long. I personally think it's a fair bit overkill for 
the purpose of send-email so we could well do with a much simpler 
verification.

> 
>>Programs introducing obscene or plain weird dependencies (cvsimport, 
>>svnimport) can be put into their own package, but we should really try 
>>to keep those extra packages to a minimum and simply force users who 
>>want all the fluffy niceties of the 'git' package to install whatever's 
>>required (or install with --nodeps, or from source, or...).
> 
> 
> I am not so sure about that.  Why should the number of packages
> matter?


Because it's a nuisance to keep track of them.


>  We could argue that the current splitting of RPM
> packages is half-done in that sense --- we lack the "tying
> together" package which itself is empty but depends on
> subpackages that implements common client-side.  Call that
> git-scm (or "git") and have the end users install it, then it
> would pull what it depends on along with it.  No?
> 

Isn't this exactly what I suggested (apart from git-scm)? client-side 
stuff goes in "git", basic functionality (server side stuff) in git-core 
and git-* for special functionality introducing odd dependencies (cvs, 
svn, http).

Since all packages would require git-core we can tack everything that 
doesn't require anything special in there and server-side installs will 
be smooth as you please.

This change should be done before 1.0 though, since people will probably 
expect some sort of package naming stability later.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
