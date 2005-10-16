From: Blaisorblade <blaisorblade@yahoo.it>
Subject: git-checkout-index, flag ordering and --prefix kludgy handling
Date: Sun, 16 Oct 2005 21:14:26 +0200
Message-ID: <200510162114.27429.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 17 23:16:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERcIp-0006VO-Uo
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 23:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVJQVNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 17:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJQVNr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 17:13:47 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:17045 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932333AbVJQVNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 17:13:46 -0400
Received: (qmail 30522 invoked from network); 17 Oct 2005 21:13:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=4O8V8yvsCmOEj+KIRa8RsiRS49G3kHvZIzJg5MJmYCMmx7n8oD+rbCx9HwGt5Ih0MRtpNuSoOzoIXYfwNaxi8gf+GkLH1EwC9KFOd6xBb/VoHxmxv3OXSgpQNdijiCBaWw3G94yhYkKOrE0W2rAN6i0Wy9bbLgMSI1+jsWB6VME=  ;
Received: from unknown (HELO ?151.97.230.22?) (blaisorblade@151.97.230.22 with login)
  by smtp007.mail.ukl.yahoo.com with SMTP; 17 Oct 2005 21:13:24 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10192>

I already knew that git-checkout-cache -a -f is wrong. But I didn't know that 

git-checkout-index -a --prefix=/home/paolo/Uml/space.mnt/paolo/Linux-2.6.git/

is. It checks out the files in the cwd, then parses --prefix and does nothing 
there, as no name is specified.

Also, the SYNOPSIS of the man page is rather misleading:

git-checkout-index [-u] [-q] [-a] [-f] [-n] [--prefix=<string>] [--] <file>...

seems to suggest that prefix can go after -f, how it's reasonable to do.

At least, this should be documented in the man page; but I think that fixing 
this (via two getopt() invocations rather than one, the first for flags like 
--prefix and the rest for actions) is probably a better thing to do.

Actually, given the audience, saying that "-a" and "filename" are both actions 
(which are executed when seen on the command line) would be a better 
explaination - and a reference to the "find" command (which behaves 
similarly) would be worth.

However, find *does* accept "options" (like -maxdepth) in any cmd line place.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
