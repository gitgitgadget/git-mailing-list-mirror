From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's going on here?  Bad repo, no error locally?
Date: Wed, 22 Apr 2009 11:30:55 -0500
Message-ID: <E0D2gLN_Jf9hLR8B78bVz8eX4lf5i3HBnK3k4LcAakE@cipher.nrlssc.navy.mil>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com> <7vws9d46q9.fsf@gitster.siamese.dyndns.org> <450196A1AAAE4B42A00A8B27A59278E70ACE06C1@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 18:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwfNy-0005Wi-NV
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 18:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbZDVQbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 12:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZDVQbE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 12:31:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38572 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZDVQbD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 12:31:03 -0400
Received: by mail.nrlssc.navy.mil id n3MGUvl0020670; Wed, 22 Apr 2009 11:30:58 -0500
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE06C1@EXCHANGE.trad.tradestation.com>
X-OriginalArrivalTime: 22 Apr 2009 16:30:55.0881 (UTC) FILETIME=[B5F8F790:01C9C367]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117214>

John Dlugosz wrote:
>> The dangling objects can happen if you push over dumb transport and
>> interrupt in the middle, or you force a push of a rewound branch, so
> it
>> does not necessarily indicate any errors, but a missing object is
>> always an error.
> 
> 
> Thanks.
> 
> That's what I thought danglings were.  But why doesn't gc get rid of
> them?

Jeff already explained why in his email to you about "dangling commits ...".

What you may not realize (and Jeff hinted at) is that unreferenced objects
are created often.  This is because the object must be created _before_
the reference to the object is created.  The existence of a reference to an
object is what differentiates a dangling,unreferenced object from one that is
not dangling,unreferenced.  Usually, an unreferenced object exists in the
repository for a very short time before becoming referenced by the creation
of a commit which references it.  But, there is always some period of time
that an object exists in the repository as a dangling,unreferenced object.
That is why gc does not delete all dangling,unreferenced objects that it
encounters immediately.  As Jeff pointed out, it only deletes those that are
two weeks old by default.

-brandon
