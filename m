From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH 2/2] make the ST_{C,M}TIME_NSEC macros more function like
Date: Sun, 15 Mar 2009 22:59:45 +0100
Organization: private
Message-ID: <86tz5u1m7i.fsf@broadpark.no>
References: <cover.1237115791.git.barvik@broadpark.no>
 <cover.1237115791.git.barvik@broadpark.no>
 <0681248ac5c9cedf5f42adeeae89966a89e6d42a.1237115791.git.barvik@broadpark.no>
 <7v4oxu7dyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 23:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiyOV-0004Lr-Dl
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 23:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbZCOV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZCOV7t
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 17:59:49 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:41378 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZCOV7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 17:59:48 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGK001PUIFMK9A0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 22:59:46 +0100 (CET)
Received: from localhost ([80.203.106.191]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGK00IO0IFLPU30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 22:59:46 +0100 (CET)
In-reply-to: <7v4oxu7dyn.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113300>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> Make the macros take a pointer to a 'struct stat'. This is so that it
>> should be easier to understand what is going on, and that the macros
>> can later be implemented as a inline function if we want to.
>>
>> Impact: cosmetic change
>
> Hmm,...
>
> I have to wonder if this cosmetic change is an improvement, though.
>
> I do not have a strong feeling either way, but I think it makes it
> clear that these two macros are not lvalues if you do not pass a
> pointer but instead pass a structure.  An inline function can still
> take a structure passed by value as an argument anyway, no?

  It seems to woork from a small gcc test, but since C has call-by-
  value, and http://en.wikipedia.org/wiki/Call_by_value#Call_by_value
  says:

    [...] in C or Pascal, calling a function with a large structure as
    an argument will cause the entire structure to be copied,
    potentially causing serious performance degradation, and mutations
    to the structure are invisible to the caller. [...]

  So in my eyes it make more sense to be consistent and take the address
  of all struct like objects (&st in this case) for all arguments to
  "function-like" things.

  But, since these 2 are macros, which use textual substitution, I guess
  things will work correctly either way, and the compiled result will be
  the same.  But, I still like the more "function friendly" macros.

  -- kjetil
