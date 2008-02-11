From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 10 Feb 2008 18:49:11 -0800
Message-ID: <7v4pcgcimw.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
	<20080211015342.GA26205@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Feb 11 03:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOOkD-0006c8-7v
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbYBKCt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYBKCt3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:49:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbYBKCt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:49:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D17271C;
	Sun, 10 Feb 2008 21:49:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A3D6C2717;
	Sun, 10 Feb 2008 21:49:23 -0500 (EST)
In-Reply-To: <20080211015342.GA26205@mit.edu> (Theodore Tso's message of "Sun,
	10 Feb 2008 20:53:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73461>

Theodore Tso <tytso@MIT.EDU> writes:

> On Sun, Feb 10, 2008 at 08:07:38PM -0500, Len Brown wrote:
>> A couple of hours ago I pulled my reference copy of Linux tree,
>> which brought the tip here:
>> 
>> commit 7cf712db6087342e5e7e259d3883a7b5ac3212d1
>> Merge: 58a14ee... 30ddb15...
>> Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
>> Date:   Sun Feb 10 12:03:57 2008 -0800
>> 
>>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
>> 
>> Then, 10 minutes ago I did a pull to bring the head here:
>> 
>> commit 19af35546de68c872dcb687613e0902a602cb20e
>> Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
>> Date:   Sun Feb 10 14:18:14 2008 -0800
>> 
>>     Linux 2.6.25-rc1
>> 
>> But this second pull seems to have re-downloaded 172MB,
>> when it should have only needed the last few commits.
>
> Yeah, I have this problem very often when I push to the ext4 tree on
> master.kernel.org.  Apparently the push/pull logic isn't smart about
> objects are found via objects/info/alterntaes, so it will needlessly
> transfer objects that it doesn't need to.

I am aware of that "push" side thing (basically it does not do
the negotiation and unless you are always doing fast-forward
pushes it tends to send needless stuff), but I had an impression
that the issue Len is raising is different.  Namely if you pull
from Linus twice into the same tree you should never see that
"No common commits".
