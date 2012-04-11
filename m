From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: stash refuses to pop
Date: Tue, 10 Apr 2012 22:59:39 -0400
Message-ID: <4F84F39B.6070907@ubuntu.com>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org> <4F84827B.80104@ubuntu.com> <CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 04:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHnmc-0004Oe-90
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 04:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757161Ab2DKC7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 22:59:41 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:22853 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab2DKC7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 22:59:41 -0400
X-Authority-Analysis: v=2.0 cv=TvJkdUrh c=1 sm=0 a=QETZmXXmyubuBiJjAgCHWw==:17 a=zF0nvurNEAYA:10 a=2TzjGJVPWd4A:10 a=S1A5HrydsesA:10 a=IkcTkHD0fZMA:10 a=xe8BsctaAAAA:8 a=Xs3jXSoMbGT5akP88aIA:9 a=QEXdDO2ut3YA:10 a=QETZmXXmyubuBiJjAgCHWw==:117
X-Cloudmark-Score: 0
X-Originating-IP: 97.103.252.48
Received: from [97.103.252.48] ([97.103.252.48:43549] helo=[192.168.1.4])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 6F/FD-17039-B93F48F4; Wed, 11 Apr 2012 02:59:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120402 Thunderbird/11.0.1
In-Reply-To: <CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195144>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/10/2012 10:47 PM, Andrew Ardill wrote:
> The first question, it would seem, is what should git do when there
> are modified files present, and the user tries to pop a stash which
> touches those files. The current behaviour is to reject the pop,
> reasonable enough, though for what exact reason I am not sure
> (potential merge issues, I assume).

Since pop is the inverse of push, and merge is the inverse of a partial push, I would expect pop to perform a merge.

> The method you have described is just one way of coming on this
> situation. The user could have
> * stashed their work, modified some files and tried to pop
> * partially stashed their work, and tried to pop
> * partially stashed their work, modified some files and then tried to pop.

Yes, there are a number of ways you can get to the situation where you can not pop the stash.  How to resolve this is unclear from the results of the failed pop.  I finally ended up resolving it by committing the remaining changes, then popping the stash ( which performed the merge successfully ), and finally doing a git reset HEAD~1 to remove the temporary commit, but preserve the merged results.  This seemed like a good deal of unnecessary trouble.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPhPObAAoJEJrBOlT6nu75qwkH/jlWpu+yRIx9l8qsp4+MWB/I
FPfKku+LnUpRoegsmKMer1J59kriw8zJF8hujHUUp1RcCdfQBUJwCDZnNGEa/LRn
PNrceRHc3V92ImBBJHwLsOqr4IQa7O+PDG8Tuht6q6NwIxEu2ZycoxnThx7JoF/G
wsD5KA9yZmJKb+lptCNVVfgez4k6ESqnekx4Tsl8C5UOUXbra61SC6vG+igRnU2P
6V+QaYbHEmNNq3pLmebCty/wmzwHJc9oTA+wDawJwV5BhcgsKnUY0RhVMT86t1Qu
IbwqkFUJV9je1GZKEwklvbLnBx2js80yvEnPWpC3jt9j6gxRGAfaq/5NQnl7vQE=
=UEM3
-----END PGP SIGNATURE-----
