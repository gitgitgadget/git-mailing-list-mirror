From: David Greaves <david@dgreaves.com>
Subject: [BUG] in asciidoc was Re: [FILES] core-git documentation update
Date: Sun, 08 May 2005 22:25:36 +0100
Message-ID: <427E83D0.5040607@dgreaves.com>
References: <427E4AED.9050702@dgreaves.com>	<20050508173109.GZ9495@pasky.ji.cz> <427E4F6C.6090302@dgreaves.com> <7vpsw15xdf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 23:19:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUtAw-0007CA-VP
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVEHV0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVEHV0A
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:26:00 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:38311 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262966AbVEHVZt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 17:25:49 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 13AB9E6D4F; Sun,  8 May 2005 22:24:51 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26870-04; Sun,  8 May 2005 22:24:50 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.145.157])
	by mail.ukfsn.org (Postfix) with ESMTP
	id D4035E6A8B; Sun,  8 May 2005 22:24:49 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DUtHM-00062l-RK; Sun, 08 May 2005 22:25:36 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsw15xdf.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>>>>>>"DG" == David Greaves <david@dgreaves.com> writes:
>>>>>>            
>>>>>>
>
>DG> it just makes across the board changes easier and at the minute the
>DG> stuff I've been doing is systemic.
>DG> I have no problems with breaking it up - hence the script...
>
>Monolithic version is easier to work with when there is only one
>or very few people working on it but when the document matures
>enough to describe the current state of affairs accurately
>enough, further changes would come almost solely from changing
>the programs the document describes.  At that point having
>separate files describing each program is easier to work with,
>and I think that point is now.
>  
>
I was waiting for comments on this set in case there were comments like:
every document should have 'x' or change all 'y' to 'z'
I fully intend to split it out...

I will send patches next time.

One thing I failed to mention.
There's a minor bug in asciidoc for which I've submitted a patch to the
author. IIRC the bug causes problems with the -man option and is
cosmetically wrong with the html.

>From the asciidoc docs:
The first manpage section is mandatory and must be called /NAME/ and
contain a single paragraph (usually a single line) consisting of a list
of one or more comma separated command name(s) separated from the
command purpose by a dash character. **The dash must have at least one
white space character on either side.**

However this is not enforced (or indeed possible) at the moment - the
NAME section seems to split on the first hyphen.

This patch fixes that for me.

--- /usr/bin/asciidoc.orig      2005-05-08 17:03:42.666249974 +0100
+++ /usr/bin/asciidoc   2005-05-08 16:56:00.518923960 +0100
@@ -1067,7 +1067,7 @@
                     error('malformed NAME section body')
                 lines = reader.read_until(r'^$')
                 s = string.join(lines)
-                mo = re.match(r'^(?P<manname>.*?)-(?P<manpurpose>.*)$',s)
+                mo =
re.match(r'^(?P<manname>.*?)\s+-\s+(?P<manpurpose>.*)$',s)
                 if not mo:
                     error('malformed NAME section body')
                 attrs['manname'] = string.strip(mo.group('manname'))


