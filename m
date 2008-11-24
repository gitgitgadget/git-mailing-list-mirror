From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] bisect: teach "skip" to accept special arguments
   like "A..B"
Date: Mon, 24 Nov 2008 08:09:58 +0100
Message-ID: <492A5346.1040405@viscovery.net>
References: <20081123220249.2e7f30a5.chriscool@tuxfamily.org> <alpine.DEB.1.00.0811240126430.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 24 08:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4VbT-0001vC-BG
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 08:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbYKXHKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 02:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYKXHKL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 02:10:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2941 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYKXHKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 02:10:09 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L4Va3-0007Sd-0b; Mon, 24 Nov 2008 08:09:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 95E344E4; Mon, 24 Nov 2008 08:09:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0811240126430.30769@pacific.mpi-cbg.de>
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Johannes Schindelin schrieb: > On Sun, 23 Nov 2008, Christian
	Couder wrote: >> Dscho wrote: >> > Would it not be more intuitive to have
	support for >> > >> > git bisect skip A..B >> > >> > ? >> >> Here is a patch
	to do that. I am not sure it's worth it >> because this is a special case
	in many ways. > > Why not have something like > > skip) > for arg in $(git
	rev-list "$@") > do > bisect_state skip $arg > done [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101593>

Johannes Schindelin schrieb:
> On Sun, 23 Nov 2008, Christian Couder wrote:
>> 	Dscho wrote:
>> 	> Would it not be more intuitive to have support for
>> 	>
>>         > git bisect skip A..B
>> 	>
>> 	> ?
>>
>> 	Here is a patch to do that. I am not sure it's worth it
>> 	because this is a special case in many ways.
> 
> Why not have something like
> 
> 	skip)
> 		for arg in $(git rev-list "$@")
> 		do
> 			bisect_state skip $arg
> 		done

Because if you say

	$ git bisect skip

this would be incorrectly calling rev-list; but more importantly, if you say

	$ git bisect skip A

then this would skip A *and all its ancestors*. Not quite what you intended.

-- Hannes
