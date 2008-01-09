From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 09 Jan 2008 00:03:32 -0800
Message-ID: <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<20080108172957.GG22155@fieldses.org>
	<CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de>
	<7vmyrgry20.fsf@gitster.siamese.dyndns.org>
	<02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
	<20080108190952.GK22155@fieldses.org>
	<7vir24rtfp.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCVvR-00008S-RL
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbYAIID4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 03:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbYAIID4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:03:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYAIIDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:03:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A7F2C3EEB;
	Wed,  9 Jan 2008 03:03:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BD8B3EE8;
	Wed,  9 Jan 2008 03:03:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69961>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 8 Jan 2008, Junio C Hamano wrote:
>>
>> I think the project can mark text files as text with attributes
>> and if the port to the platform initialized core.autocrlf
>> appropriately for the platform everything should work as you
>> described. 
>
> Yes, I think core.autocrlf should default to "true" on Windows, since 
> that is what it's about. The alternative is to have "fail"/"warn", to just 
> make sure that nobody can do the wrong thing by mistake.
>
> We could just do something like this, although that probably does mean 
> that the whole test-suite needs to be double-checked (ie now we really do 
> behave differently on windows outside of any config options!))
>
> People who really dislike it can always do the
>
> 	git config --global core.autocrlf false
>
> thing.
>
> (And no, I don't know if "#ifdef __WINDOWS__" is the right thing to do, 
> it's almost certainly not. This is just a draft.)

Perhaps we can do something similar to core.filemode?  Create a
file that we would need to create anyway in "text" mode, and
read it back in "binary" mode to see what stdio did?
