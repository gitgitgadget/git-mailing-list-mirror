From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 28 Apr 2007 14:15:25 -0700
Message-ID: <m2k5vwfbf6.fsf@ziti.fhcrc.org>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
	<m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
	<7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 23:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhuGv-00067a-8R
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 23:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXD1VPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbXD1VPw
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 17:15:52 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:63965 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030824AbXD1VP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 17:15:29 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1554071nzf
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 14:15:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Vd1xfxY5/s/EyYa1g1mLHvRZVD4xJdbnx4ZQH/GQyRFnXnf2j5f5GesewyoplOMgSobFUJn9nF34bi/tMSm8CllACTMv0/Wae9udBqPvdEOoMqy0dXRvDZSITuq7Znp6HaLfqK8iTLqEbvRwfKj8aRoWxjEIGuMq2hSMyDoMEIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=mAt7My/FUVb/vK/6TWFxJ2dpuhD7zOAGttr5vI7QeawiLxFNmMgdU5bvessAXqIYJAfC2e+ovbDYvTP7onSRlaH7xyVta5iEDsrEk3ZGzz20fFW5zKhbjLB8cF46eRIHILvU+F6Zc4xSyfZOVfBmu/+K5doF5f6h6/VSWSiF/p4=
Received: by 10.114.124.1 with SMTP id w1mr1467268wac.1177794928490;
        Sat, 28 Apr 2007 14:15:28 -0700 (PDT)
Received: from ziti.fhcrc.org ( [24.19.44.95])
        by mx.google.com with ESMTP id q18sm6063234pog.2007.04.28.14.15.27;
        Sat, 28 Apr 2007 14:15:27 -0700 (PDT)
In-Reply-To: <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 28 Apr 2007 11:34:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45796>

Junio C Hamano <junkio@cox.net> writes:

> Seth Falcon <sethfalcon@gmail.com> writes:
>
>> On OS X, I get:
>>
>>     ziti:~/temp seth$ ./perltest1.pl 
>>     read[5]: link 
>>     child says: child: at 5
>
> Ah, so the previous read($fh, $buf, 5) lets stdio absorb the
> whole (short) input, and the underlying seek pointer is not
> adjusted back across fork, and the child does not have anything
> to read.
>
>> And uncommenting the sysseek call, I get:
>>
>>     ziti:~/temp seth$ ./perltest1.pl 
>>     read[5]: link 
>>     child says: child: at 5
>>     child says: >>12345
>
> Then I suspect the following could be less invasive and more
> efficient fix for the problem.  I do not have an access to MacOS
> box, and I do not have a working sync with any SVN repository,
> so I cannot test it myself, though...

This also works as a fix for me on OS X and obviously is nicer than
resorting to temp files.  Again, with this patch against git master
the test case that Eric posted passes as does one of my own examples.

+ seth
