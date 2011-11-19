From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: Stack overflow at write_one()
Date: Sat, 19 Nov 2011 19:46:08 -0200
Message-ID: <4EC823A0.3010603@cesarb.net>
References: <4EC81131.2010704@cesarb.net> <7vty5zizwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 22:46:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRsjz-0007n9-UB
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 22:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab1KSVqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 16:46:14 -0500
Received: from smtp-03.mandic.com.br ([200.225.81.143]:51069 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab1KSVqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 16:46:13 -0500
Received: (qmail 9225 invoked from network); 19 Nov 2011 21:46:10 -0000
Received: from unknown (HELO cesarb-inspiron.home.cesarb.net) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-03.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <gitster@pobox.com>; 19 Nov 2011 21:46:10 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
In-Reply-To: <7vty5zizwn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185711>

Em 19-11-2011 19:08, Junio C Hamano escreveu:
> Already found the real cause (jGit bug) and workaround posted, I think.

I presume the cause then is what was fixed by 
http://egit.eclipse.org/w/?p=jgit.git;a=commit;h=2fbf296fda205446eac11a13abd4fcdb182f28d9 
?

> See $gmane/185573

That did it, thanks! The patch had an offset, a fuzz, and a reject, but 
it was easy to fix by hand.

$ ../git/git gc
Counting objects: 30254, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (6614/6614), done.
warning: recursive delta detected for object 
fac71dfa0fe8c70cc852099e061c334e2a548eab
warning: recursive delta detected for object 
1b730f5b2e0bdb2a2206af8ed30170509e75a2f5
warning: recursive delta detected for object 
2f25a87e67fa3a226e367b9e080f11aa90c9f953
warning: recursive delta detected for object 
d5e5eefac91788da9a94efe9a15e0b928a77489e
Writing objects: 100% (30254/30254), done.
Total 30254 (delta 24008), reused 28803 (delta 23266)

And after that the repack does not break anymore:

$ ../git/git gc
Counting objects: 30254, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (5876/5876), done.
Writing objects: 100% (30254/30254), done.
Total 30254 (delta 24008), reused 30254 (delta 24008)

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
