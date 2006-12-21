From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t5000-tar-tree.sh failing
Date: Thu, 21 Dec 2006 09:17:51 -0500
Message-ID: <9A725DAA-FAA8-4779-A73D-ED117CC068C1@silverinsanity.com>
References: <20061221133746.GA13751@cepheus> <Pine.LNX.4.63.0612211458360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 15:18:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxOkB-0005Wv-0E
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 15:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbWLUOR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 09:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbWLUOR4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 09:17:56 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:51707 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbWLUORz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 09:17:55 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B5FEE1FFC02B;
	Thu, 21 Dec 2006 14:17:54 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.63.0612211458360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35071>


On Dec 21, 2006, at 9:00 AM, Johannes Schindelin wrote:

>
> Why not enclose the tests in a
>
> 	if unzip -h >/dev/null 2>/dev/null; then
>
> 		# all these tests
>
> 	fi
>
> Hmm?

Several other test frameworks provide a "skip" method to indicate why  
we've skipped something.  We could do something similar...

if skip 'unzip -h' 'tests need unzip'; then
    # unzip tests
fi

skip() {
   # Have not checked to see if this is anything resembling working code
   if eval $1 > /dev/null 2>&1; then
     true
   else
     echo "* skipping tests: $2" 1>&2
     false
   fi
}

Mostly so that skipped tests are obvious, provide a reason, and have  
a standardized display format.  Again, too busy in actual work to try  
to do this myself right now, but might hack at it this afternoon if  
nobody else (hopefully someone more fluent in shell than I am) does.

~~ Brian
