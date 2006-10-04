From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: asciidoc 7--8 compatibility (was Re: pull-fetch-param.txt)
Date: Wed, 04 Oct 2006 18:40:33 +0200
Message-ID: <4523E401.5080709@s5r6.in-berlin.de>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de>	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>	<45222B18.1090305@s5r6.in-berlin.de> <7v64f1np8i.fsf@assigned-by-dhcp.cox.net> <4522E66B.4080103@methods.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 18:43:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV9nc-0001hY-F5
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 18:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161544AbWJDQkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 12:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWJDQkn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 12:40:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:15004 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161544AbWJDQkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 12:40:42 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k94GeXZt029521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Oct 2006 18:40:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: Stuart Rackham <srackham@methods.co.nz>
In-Reply-To: <4522E66B.4080103@methods.co.nz>
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28328>

Stuart Rackham wrote:
> From the AsciiDoc User Guide
> (http://www.methods.co.nz/asciidoc/userguide.html#X53):
> 
> If you want to disable unconstrained quotes, the new alternative
> constrained quotes syntax and the new index entry syntax then you can
> define the attribute asciidoc7compatible (for example by using the -a
> asciidoc7compatible command-line option).

Stuart,

the actual issues were:

1.) Input which works with asciidoc 7 fails to build with asciidoc 8
(after the intermediary XML step). This pair of tildes broke (but other
occurences of tilde did not):

| * A suffix '~<n>' to a revision parameter means the commit
|   object that is the <n>th generation grand-parent of the named
|   commit object, following only the first parent.  I.e. rev~3 is

2.) Asciidoc 8 silently swallows characters from input which works with
asciidoc 7. The two pluses in the following line vanished (but instances
of single pluses per input line did not vanish):

| 	`+?<src>:<dst>`; that is, an optional plus `+`, followed

I wonder:

 - Are tilde and plus new special characters in asciidoc 8, or were they
already special characters in asciidoc 7?
       [ A pair of single pluses encloses monospaced text in asciidoc 8.
         A pair of single tildes encloses subscripts. ]

 - If they were already special characters in asciidoc 7, what is the
canonical way to escape them in asciidoc 7, 8, and hopefully 9?
       [ If they weren't special characters in asciidoc 7, then we need
         to use the asciidoc7compatible attribute. ]

 - Does asciidoc 7 accept the asciidoc7compatible attribute?

Thanks.


PS:

Junio, Stuart, here is another inconsistency between asciidoc 7 and 8.
Please have a look at
http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html .
See the ASCII art above "SPECIFYING RANGES". The input
       \  |  / \
        \ | /   |
produced
   \  |  /         \ | /   |
I.e. backslash-newline was interpreted by asciidoc 7 (or whatever you
use to generate what is put online) as an escaped thus swallowed
newline. But the output that I got here from asciidoc 8 (manpage as well
as the html file) still has backslash and newline printed out.
-- 
Stefan Richter
-=====-=-==- =-=- --=--
http://arcgraph.de/sr/
