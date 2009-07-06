From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Mon, 06 Jul 2009 14:38:06 -0700
Message-ID: <7vk52l1oht.fsf@alter.siamese.dyndns.org>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
	<200907062229.11763.mcamen@mcamen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus Camen <mcamen@mcamen.de>
X-From: git-owner@vger.kernel.org Mon Jul 06 23:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNvtH-0003PU-6H
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 23:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbZGFViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 17:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbZGFViF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 17:38:05 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37133 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbZGFViE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 17:38:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090706213807.FSJL17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 6 Jul 2009 17:38:07 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id Cle61c00A4aMwMQ03le6bJ; Mon, 06 Jul 2009 17:38:06 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=avqLpYhvPjQA:10 a=vRn9FcIqemG-jW9jx-0A:9
 a=A615lvF3sdN6LruXxYJa01DkHYUA:4 a=eX9e5yNMjhIA:10
X-CM-Score: 0.00
In-Reply-To: <200907062229.11763.mcamen@mcamen.de> (Marcus Camen's message of "Mon\, 6 Jul 2009 22\:29\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122798>

Marcus Camen <mcamen@mcamen.de> writes:

> On Montag 06 Juli 2009, Junio C Hamano wrote:
>> * ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
>>  - http.c: add http.sslCertPasswordProtected option
>>  - http.c: prompt for SSL client certificate password
>>
>> I've rewritten these two to (1) move the #ifdef out of the main
>> codepath, and (2) use configuration/environment to make the misfeature
>> of always asking for a passphrase even a key/cert is unencrypted
>> optional.  I tried to be careful but extra sets of eyeballs would be
>> nice to check the result.
>>
>> Nobody seems to be jumping up-and-down asking for this or helping to
>> push this forward.  Perhaps it's time to drop it?
>
> /me jumping up-and-down
>
> This fix is crucial for corporate environments where HTTPS is the only way 
> to access GIT repositories outside the firewall.
>
> I verified the patch and everything works as expected.

Thanks.

What did you exactly mean by "everything"?

 - On a protected key/cert, with configuration, it asks the question once.

 - On an unprotected key/cert, without configuration, it never asks the
   question.

 - On an unprotected key/cert, with configuration, it asks an useless
   question but it does so only once.

You tested all of the above?  I am not demanding you to test all of these,
but we need to make sure at least somebody did.  Especially because it
would be a regression if the second one does not.
