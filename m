From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 11:48:04 -0700
Message-ID: <7vljp04z6j.fsf@alter.siamese.dyndns.org>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
	<1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
	<alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de>
	<200905130724.44634.robin.rosenberg@dewire.com>
	<4A0A91CE.3080905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 20:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JV3-00059W-6t
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965AbZEMSsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbZEMSsG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:48:06 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62083 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbZEMSsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:48:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513184804.RTCE25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 May 2009 14:48:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id r6o41b00B4aMwMQ046o4qM; Wed, 13 May 2009 14:48:04 -0400
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=kbIGyAuQ4OLeRwg46TwA:9
 a=gbEmfZ2pjvWrh3oKzbSg30otaKAA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A0A91CE.3080905@gmail.com> (Esko Luontola's message of "Wed\, 13 May 2009 12\:24\:30 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119087>

Esko Luontola <esko.luontola@gmail.com> writes:

> Robin Rosenberg wrote on 13.5.2009 8:24:
>> If the conclusion is that this is a way forward, then I
>> could start working on a completely new set of much cleaner patches.,
>
> That would be great!
>
> I see that in those early patches you took the approach of converting
> the filenames from the local encoding to UTF-8 at the outer edges of
> Git. That obviously was the easiest way to make the changes with
> minimal changes to Git.

Which would be the _only_ sane approach.

If you allow people to record otherwise exactly the same tree object in
different encoding, like you seem to have in mind, subtree comparision
based on the object name will not work and you will end up always
traversing down to the tip, because you won't know if your subtrees need
filename iconv until you recurse into them and actually take a look.

Don't do it.
