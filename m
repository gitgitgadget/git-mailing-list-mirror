From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something is broken in repack
Date: Sat, 08 Dec 2007 14:18:52 -0800
Message-ID: <7vodd0vnhv.fsf@gitster.siamese.dyndns.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<alpine.LFD.0.99999.0712072032410.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 23:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J181G-0004EC-Uo
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 23:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbXLHWTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 17:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbXLHWTM
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 17:19:12 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:57138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbXLHWTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 17:19:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B0F480F;
	Sat,  8 Dec 2007 17:19:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CED1F480E;
	Sat,  8 Dec 2007 17:18:59 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0712072032410.555@xanadu.home> (Nicolas
	Pitre's message of "Fri, 07 Dec 2007 20:46:25 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67573>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 7 Dec 2007, Jon Smirl wrote:
>
>> Starting with a 2GB pack of the same data my process size only grew to
>> 3GB with 2GB of mmaps.
>
> Which is quite reasonable, even if the same issue might still be there.
>
> So the problem seems to be related to the pack access code and not the 
> repack code.  And it must have something to do with the number of deltas 
> being replayed.  And because the repack is attempting delta compression 
> roughly from newest to oldest, and because old objects are typically in 
> a deeper delta chain, then this might explain the logarithmic slowdown.
>
> So something must be wrong with the delta cache in sha1_file.c somehow.

I was reaching the same conclusion but haven't managed to spot anything
blatantly wrong in that area.  Will need to dig more.
