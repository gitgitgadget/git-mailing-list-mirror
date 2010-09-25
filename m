From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Re*: [PATCH] t1503: Fix arithmetic expansion syntax error when
 using dash
Date: Sat, 25 Sep 2010 18:08:54 +0100
Message-ID: <4C9E2CA6.2070805@ramsay1.demon.co.uk>
References: <4C98EF25.4070700@ramsay1.demon.co.uk> <7viq1xsi7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, jon.seymour@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 19:16:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzYM2-0003kJ-RZ
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 19:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab0IYRPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 13:15:49 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:50963 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753597Ab0IYRPs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 13:15:48 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1OzYLj-0005zx-hK; Sat, 25 Sep 2010 17:15:48 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7viq1xsi7a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157168>

Junio C Hamano wrote:
> POSIX wants shells to support both "N" and "$N" and requires them to yield
> the same answer to $((N)) and $(($N)), but we should aim for portability
> in a case like this, especially when the price we pay to do so is so
> small, i.e. a few extra dollars.

Indeed

> By the way, on my box, I get this:
> 
>     $ ls l /bin/dash
>     -rwxr-xr-x 1 root root 104024 2008-08-26 02:36 /bin/dash*
>     $ dpkg -l dash | grep '^ii'
>     ii  dash              0.5.4-12          POSIX-compliant shell
>     $ /bin/dash -c 'N=20 ; echo $(( N + 3 ))'
>     23

Ah, yes, I should have checked for this... particularly since I now
vaguely remember reading that this had been "fixed"... *blush*
Sorry about that.

For the record, on my system I get:

    $ ls -l /bin/dash
    -rwxr-xr-x 1 root root 80500 2007-03-05 06:00 /bin/dash*
    $ dpkg -l dash | grep '^ii'
    ii  dash           0.5.3-5ubuntu2 The Debian Almquist Shell
    $ /bin/dash -c 'N=20; echo $(( N + 3 ))'
    /bin/dash: arith: syntax error: " N + 3 "

> I just left it vague by saying "e.g. older dash" in below, but we may want
> to be more precise in the documentation.

I found a bug report:

    http://bugs.launchpad.net/ubuntu/+source/dash/+bug/92189

which had a post against it which implied that this was fixed in
version 0.5.4-3. I went over to packages.debian.org to read the
ChangeLog for this version, but I could not conclude anything
from that text. :(

Do we need to be more precise?

Should I re-work the commit message and re-submit?

ATB,
Ramsay Jones
