From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 13:10:00 -0700
Message-ID: <7vtz3o2293.fsf@alter.siamese.dyndns.org>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
	<1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
	<alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de>
	<200905130724.44634.robin.rosenberg@dewire.com>
	<4A0A91CE.3080905@gmail.com> <7vljp04z6j.fsf@alter.siamese.dyndns.org>
	<4A0B2007.70808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 22:10:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KmT-0006Hs-0X
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 22:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbZEMUKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 16:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755814AbZEMUKA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 16:10:00 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60358 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbZEMUKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 16:10:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513201000.DJEY20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 May 2009 16:10:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id r8A01b00K4aMwMQ048A0wq; Wed, 13 May 2009 16:10:01 -0400
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=LYXcwfC-SxRxe7b3zLAA:9
 a=PJWQaUHDSlS3vJPEEaKvZnkonoEA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A0B2007.70808@gmail.com> (Esko Luontola's message of "Wed\, 13 May 2009 22\:31\:19 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119100>

Esko Luontola <esko.luontola@gmail.com> writes:

> Junio C Hamano wrote on 13.5.2009 21:48:
>> If you allow people to record otherwise exactly the same tree object in
>> different encoding, like you seem to have in mind, subtree comparision
>> based on the object name will not work and you will end up always
>> traversing down to the tip, because you won't know if your subtrees need
>> filename iconv until you recurse into them and actually take a look.
>
> Could you please educate me, that which operations depend on "doing
> subtree comparisons based on the object name",

"diff-tree A B" looks at corresponding subtrees of A and B and does not
recurse into the identical subdirectories; "git log -- dir" uses this fact
to speed up the checking of differences.  When a typical commit touches
only a handful of paths in a project with 20k paths, this really matters.

> files/functions those comparisons are done? Also, do you mean by
> "object name" the SHA1 of the object, the filename of a
> file/directory, or something else?

What is colloquially known as SHA-1 has an official terminology; see
Documentation/glossary.txt.
