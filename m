From: John Freeman <jfreeman@cs.tamu.edu>
Subject: Re: clone fails: Could not get the current working directory
Date: Mon, 22 Sep 2008 13:32:23 -0500
Message-ID: <48D7E4B7.3010109@cs.tamu.edu>
References: <48D59A30.5020403@cs.tamu.edu> <d3a045300809211012l35b1ec2dq39f4174170d8c926@mail.gmail.com> <48D6C822.7050602@cs.tamu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Johnston <pcj127@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 20:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhqDW-0007iy-Pv
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 20:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYIVSby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbYIVSbx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 14:31:53 -0400
Received: from smtp-relay.tamu.edu ([165.91.22.120]:11632 "EHLO
	sr-2-int.cis.tamu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752645AbYIVSbx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 14:31:53 -0400
Received: from localhost (localhost.tamu.edu [127.0.0.1])
	by sr-2-int.cis.tamu.edu (Postfix) with ESMTP id 55C53263A7;
	Mon, 22 Sep 2008 13:31:52 -0500 (CDT)
X-Virus-Scanned: amavisd-new at tamu.edu
Received: from b2.local (vpn-66.cs.tamu.edu [128.194.150.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr-2-int.cis.tamu.edu (Postfix) with ESMTPSA id A789026379;
	Mon, 22 Sep 2008 13:31:50 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48D6C822.7050602@cs.tamu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96505>

I have also tried copying the repo to my home directory on the remote 
Sun machine, and then cloning to my local machine.  This works as expected.

Does anyone know why a call to getcwd() would fail?

I found this in some documentation on getcwd:
http://www.opengroup.org/onlinepubs/009695399/functions/getcwd.html
"If a program is operating in a directory where some (grand)parent 
directory does not permit reading, getcwd() may fail, as in most 
implementations it must read the directory to determine the name of the 
file. This can occur if search, but not read, permission is granted in 
an intermediate directory, or if the program is placed in that directory 
by some more privileged process (for example, login). Including the 
[EACCES] error condition makes the reporting of the error consistent and 
warns the application writer that getcwd() can fail for reasons beyond 
the control of the application writer or user. Some implementations can 
avoid this occurrence (for example, by implementing getcwd() using pwd, 
where pwd is a set-user-root process), thus the error was made optional."

Does anyone know for certain if this is true for Sun machines?  Would it 
be possible to patch / introduce a macro that changes the use of 
getcwd() to a use of pwd, like the above documentation suggests?

- John
