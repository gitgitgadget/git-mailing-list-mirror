From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Build configuration to skip ctime for modification test
Date: Tue, 22 Jul 2008 17:12:50 -0700
Message-ID: <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
References: <20080721173511.GB5387@steel.home>
 <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org>
 <20080722193901.GA5113@blimp.local>
 <alpine.DEB.1.00.0807222115440.8986@racer>
 <20080722203128.GB5113@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRzb-0005EL-28
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbYGWANG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbYGWANG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:13:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbYGWANE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:13:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A49B8374F8;
	Tue, 22 Jul 2008 20:13:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 22BAB374F7; Tue, 22 Jul 2008 20:12:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E174B88-584C-11DD-9ED7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89575>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Tue, Jul 22, 2008 22:17:21 +0200:
>> Hi,
>> 
>> On Tue, 22 Jul 2008, Alex Riesen wrote:
>> 
>> > +#ifndef NO_TRUSTABLE_FILEMODE
>> >  	if (ce->ce_ctime != (unsigned int) st->st_ctime)
>> >  		changed |= CTIME_CHANGED;
>> > +#endif
>> 
>> Surely you meant trust_executable_bit instead, right?
>
> No. Just what I said: we don't have filemode (like "at all") - so no
> ctime as well. But maybe you're right, and trust_executable_bit is
> more flexible. Or maybe both (the #ifdef _and_ trust_executable_bit)
> and must be used...
>
>> Otherwise, if you really want to tell at compile time,I think for clarity 
>> you have to introduce another #define, since NO_TRUSTABLE_FILEMODE 
>> definitely says something different than CTIME_IS_USELESS.
>
> I had that at first (NO_DEPENDABLE_CTIME, than IGNORE_CTIME), than
> deemed it excessive.

Why is it excessive?  My initial reaction was "what does trustable
filemode nor trust_executable_bit has anything to do with ctime".  Please
explain.
