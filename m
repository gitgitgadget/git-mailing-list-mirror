From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 17:30:31 -0800
Message-ID: <7vprw7zv7s.fsf@gitster.siamese.dyndns.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
	<200801120026.01930.robin.rosenberg@dewire.com>
	<1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org>
	<200801120115.41274.robin.rosenberg@dewire.com>
	<191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org>
	<7v7iif28i2.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801120139170.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<B2968E86-D43E-4F5E-921F-DF8A15886C98@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:31:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVDG-000152-Ic
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579AbYALBai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 20:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760225AbYALBai
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:30:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757069AbYALBah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 20:30:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 783E63C31;
	Fri, 11 Jan 2008 20:30:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D283E3C30;
	Fri, 11 Jan 2008 20:30:33 -0500 (EST)
In-Reply-To: <B2968E86-D43E-4F5E-921F-DF8A15886C98@sb.org> (Kevin Ballard's
	message of "Fri, 11 Jan 2008 20:16:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70244>

Kevin Ballard <kevin@sb.org> writes:

> On Jan 11, 2008, at 7:40 PM, Johannes Schindelin wrote:
>
>> On Fri, 11 Jan 2008, Junio C Hamano wrote:
>>
>>> Kevin Ballard <kevin@sb.org> writes:
>>>
>>>> Is there a reason for this? It seems like it would be trivial to end
>>>> up with misdiagnosed "untracked" files when using any language other
>>>> than English given this behaviuor.
>>>
>>> No.  The assumption of the code has always been that sane filesystems
>>> would return from readdir() the names you gave from creat().
>>
>> We do not really have to rehash that whole discussion for the Nth
>> time, do
>> we?
>
> Apparently so. By Junio's definition, HFS+ is not a sane filesystem,
> and as git grows more popular with OS X users, this issue is going to
> crop up more frequently.

It's not "my" definition, but you asked the reason and I gave
the answer.  We can close this issue of "is HFS+ sane" now.
HFS+ is insane, period.  And as Linus said, you cannot forgive
its insanity using the historical baggage argument, like MS-DOS.

HOWEVER.

It is a totally different issue if we want to refuse supporting
insane filesystems.  And the answer is no.  It was not my
intention to say that we do not intend to support them, when I
explained the reason why the things are as they are, which was
the original question by you.

See Robin's proposal to let us translate random names we get
back from readdir() from the filesystem using an additional
look-up table in the index extension section that stores mapping
from canonicalized form to the form that the user registered to
the index.  I think that is a sane approach to tackle this issue
on insane filesystems like HFS+.
