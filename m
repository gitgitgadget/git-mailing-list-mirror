From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Fri, 22 Aug 2008 14:17:46 -0700
Message-ID: <7v7ia892bp.fsf@gitster.siamese.dyndns.org>
References: <20080820185028.GA16626@blimp.local>
 <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080820200440.GF16626@blimp.local>
 <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080820202952.GH16626@blimp.local>
 <7vd4k3nx7m.fsf@gitster.siamese.dyndns.org>
 <20080821172320.GA5119@blimp.local>
 <7vy72pd278.fsf@gitster.siamese.dyndns.org>
 <81b0412b0808220208i5de03604rec37081f0bc1cdd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:19:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWe2T-00006f-Fy
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758977AbYHVVR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758963AbYHVVR5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:17:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758945AbYHVVRy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:17:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BD41663DC5;
	Fri, 22 Aug 2008 17:17:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6AC8A63DC3; Fri, 22 Aug 2008 17:17:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C882F95E-708F-11DD-B635-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93371>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> 2008/8/22 Junio C Hamano <gitster@pobox.com>:
>> I however wonder if this is clearer.
>
> It is :)
>
>>  * "enum branch_track" was unsigned; comparing equality with -1 was Ok but
>>   we couldn't say 0 < opts.track;
>>
>>  * argv[] is an array of constant strings; cannot point into it with
>>   opts.newbranch without making the latter also a constant string.
>
> Cleanup, but it is unrelated, isn't it?

The code did not compile without it for me as I sometimes use -Werror.

>>  * the logic is to strip "refs/" if there is one, "remotes/" if there is
>>   one after that, and then strip one level after that unconditionally.
>>   No need to look explicitly for a slash while doing the first two steps.
>
> Maybe that should go in documentation instead of the piece I wrote

Oh I think what you wrote is fine.  I tried to be more descriptive than
simply saying "No need to look explicitly for a slash" while explaining
the changes.
