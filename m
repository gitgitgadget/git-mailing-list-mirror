From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Wed, 03 Jun 2009 10:23:52 -0700
Message-ID: <7vprdl9qon.fsf@alter.siamese.dyndns.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
	<1243786525-4493-2-git-send-email-prohaska@zib.de>
	<1243786525-4493-3-git-send-email-prohaska@zib.de>
	<1243786525-4493-4-git-send-email-prohaska@zib.de>
	<1243786525-4493-5-git-send-email-prohaska@zib.de>
	<1243786525-4493-6-git-send-email-prohaska@zib.de>
	<1243786525-4493-7-git-send-email-prohaska@zib.de>
	<1243786525-4493-8-git-send-email-prohaska@zib.de>
	<1243786525-4493-9-git-send-email-prohaska@zib.de>
	<1243786525-4493-10-git-send-email-prohaska@zib.de>
	<1243786525-4493-11-git-send-email-prohaska@zib.de>
	<7vhbz0mmai.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de>
	<7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302>
	<7viqjefxcv.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBuC4-00017u-Vo
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 19:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbZFCRXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 13:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbZFCRXw
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 13:23:52 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37509 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbZFCRXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 13:23:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603172354.PTGQ17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jun 2009 13:23:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id zVPt1b0064aMwMQ04VPtdA; Wed, 03 Jun 2009 13:23:53 -0400
X-Authority-Analysis: v=1.0 c=1 a=pJQHuwW63eoA:10 a=O6WTdPAIJOYA:10
 a=mwWM4DfP1Wc-RYVxjOgA:9 a=A4wQWIuvUq1Nf7Fxxr4A:7
 a=r8ZlMp8ppJ4jFQ-_eERoOXorJdwA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302> (Johannes Schindelin's message of "Wed\, 3 Jun 2009 14\:57\:02 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120625>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As to the second one, I think you lost "even if we happen to" part (that
>> logically corresponds to "... that is why we do not want to limit the
>> inclusion to !__MINGW32__ case") from the description, making it less
>> readable...
>
> You mean "even if we happen to be on Windows"?

I meant this part from your earlier message.

> It helps in that malloc.h is included even if we happen to compile the 
> stuff as a MinGW program.  Otherwise necessary function declarations are 
> missing.

compared with the newer "how about" version, which is

>> > Also, with the version of MinGW's headers in msysGit, we need to include 
>> > malloc.h lest the compiler complain about an "incompatible implicit 
>> > declaration of built-in function 'alloca'".

I thought the former explains the change in question

>> > -#if defined(WIN32) && !defined(__MINGW32__)
>> > +#if defined(WIN32)

much more clearly: "If you are compiling for Windows, regardless of
MINGW32, you would want this section to apply".

> ...  Want me to resend a fixed patch?

Surely.  I think I could come up with something based on the discussion
here, but I'd rather not.  A patch signed off by either you or Steffen, or
both is very much appreciated.
