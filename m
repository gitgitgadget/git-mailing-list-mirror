From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 00:33:36 +0300
Message-ID: <20080108213336.GO6951@dpotapov.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <20080107224204.55539c31@jaiman> <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se> <eaa105840801080507j1b748fy6fdff8b240cf8c33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Peter Harris <peter@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 22:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCM5H-0007Kl-3j
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 22:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbYAHVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYAHVdj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 16:33:39 -0500
Received: from smtp01.mtu.ru ([62.5.255.48]:49930 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbYAHVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 16:33:38 -0500
Received: from smtp01.mtu.ru (localhost [127.0.0.1])
	by smtp01.mtu.ru (Postfix) with ESMTP id A5874ADDEAB;
	Wed,  9 Jan 2008 00:33:32 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-189-183.pppoe.mtu-net.ru [85.141.189.183])
	by smtp01.mtu.ru (Postfix) with ESMTP id 5EEDDADDB14;
	Wed,  9 Jan 2008 00:33:32 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JCM4m-0005zJ-7B; Wed, 09 Jan 2008 00:33:36 +0300
Content-Disposition: inline
In-Reply-To: <eaa105840801080507j1b748fy6fdff8b240cf8c33@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp01.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69925>

On Tue, Jan 08, 2008 at 08:07:15AM -0500, Peter Harris wrote:
> 
> Actually, Subversion does the Right Thing, and treats everything as a
> binary file until and unless you explicitly set the svn:eol-style
> property on each file that you want it to mangle.

Not exactly. Actually, Subversion detects binary or text file based
on heuristic. http://subversion.tigris.org/faq.html#binary-files
But the status of a file as binary or text has no effect whatsoever
on on CRLF conversation, which is controlled by another property.
By default, most of your text files will be detected as text (unless
you use non-ASCII character like Cyrillic), but they will not have
CRLF conversation. Now, you have to set svn:eol-style=native for
each new file, which of course can be done automatically based on
file extension, but that should be configured by each user in his
or her global config file. Obviously, it does not work well for
cross-platform projects, because many users forget to set
svn:eol-style=native for some extensions. Moreover, the issue tends
to repeat itself for every newly introduced file extension...

IMHO, having the binary or text status completely independent from
CRLF conversation is insanity...

Dmitry
