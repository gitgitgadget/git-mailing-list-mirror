From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] git-web--browse: Fix open HTML help pages from iTerm
Date: Thu, 27 Sep 2012 21:31:51 +0200
Message-ID: <0D4FA057-D2C1-4235-961F-166FD9DCA4F4@zib.de>
References: <1348597003-28403-1-git-send-email-prohaska@zib.de> <7v3923qo0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:32:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THJpF-00073a-Du
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 21:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab2I0TcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 15:32:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:48188 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab2I0TcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 15:32:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id q8RJVwJw023831;
	Thu, 27 Sep 2012 21:32:03 +0200 (CEST)
Received: from [192.168.0.10] (91-64-48-32-dynip.superkabel.de [91.64.48.32])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id q8RJVuf6000537
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 27 Sep 2012 21:31:57 +0200 (MEST)
In-Reply-To: <7v3923qo0n.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206511>


On Sep 27, 2012, at 9:11 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
>> iTerm is an alternative to the default terminal emulation program on Mac
>> OS X.  git-web--browse wasn't aware of iTerm and failed to open HTML
>> help pages when used in a shell session running in iTerm, reporting "No
>> known browser available."  Now it works as expected.
>> 
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>> ---
>> git-web--browse.sh | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/git-web--browse.sh b/git-web--browse.sh
>> index 1e82726..95ecf65 100755
>> --- a/git-web--browse.sh
>> +++ b/git-web--browse.sh
>> @@ -120,7 +120,8 @@ if test -z "$browser" ; then
>> 	fi
>> 	# SECURITYSESSIONID indicates an OS X GUI login session
>> 	if test -n "$SECURITYSESSIONID" \
>> -		-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
>> +		-o "$TERM_PROGRAM" = "Apple_Terminal" \
>> +		-o "$TERM_PROGRAM" = "iTerm.app" ; then
>> 		browser_candidates="open $browser_candidates"
>> 	fi
> 
> I do not have anything against iTerm, but could we have a solution
> that does not force us to keep adding 47 different terminal program
> names to the list over the longer term (no pun intended)?  For
> example, "If on OS-X (which by the way does not seem to be checked
> with the current logic) and environment TERM_PROGRAM is set to any
> value", or something.

I googled a bit and it seems that TERM_PROGRAM is specific to OS X.
So simply testing whether TERM_PROGRAM is set to any value (without
additional check for OS X) might be good enough.

I am wondering whether anyone knows if TERM_PROGRAM is used on other
operating systems besides OS X.

	Steffen
