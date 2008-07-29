From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 18:16:24 -0700
Message-ID: <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
 <20080723164614.GB5283@blimp.local>
 <alpine.DEB.1.00.0807231757550.8986@racer>
 <20080723191647.GF5283@blimp.local>
 <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org>
 <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
 <20080726153802.GA16868@blimp.local>
 <7v1w1f155p.fsf@gitster.siamese.dyndns.org>
 <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org>
 <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 03:17:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNdqM-00032A-MB
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 03:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbYG2BQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 21:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbYG2BQh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 21:16:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYG2BQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 21:16:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0750640E3D;
	Mon, 28 Jul 2008 21:16:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D05640E3B; Mon, 28 Jul 2008 21:16:26 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Mon, 28 Jul 2008 09:09:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBB8BED6-5D0B-11DD-8F55-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90543>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 28 Jul 2008, David Brown wrote:
>
>> On Mon, Jul 28, 2008 at 08:31:28AM +0200, Alex Riesen wrote:
>> 
>> > because there are situations where it produces too much false
>> > positives. Like when file system crawlers keep changing it when
>> > scanning and using the ctime for marking scanned files.
>> 
>> That's interesting, since most backup software uses the ctime to determine
>> file changes.
>
> It really is just Beagle that is (was? I can dream) a piece of 
> unbelievable crap.
>
> Anybody who uses extended attributes as part of a indexing scheme is just 
> insane. Modifying the file you are indexing is not just fundamentally 
> wrong to begin with, but it will then also be incredibly inefficient to 
> read those entries one at a time.

It's a typo and you are saying it _is_ fundamentally wrong, aren't you?

If you are prepared to pick up new files, you need to crawl everywhere
anyway, so if the xattr is used to leave a mark "The last time I looked at
this file was this" in the file itself, it does not sound too bad to me.
It would be irritating that it touches ctime, though, but I do not use it
so it is not my problem ;-)

http://beagle-project.org/FAQ "Do I really need extended attributes?"
talks about BEAGLE_DISABLE_XATTR environment variable and interestingly
it says disabling use of xattr would slow you down.
