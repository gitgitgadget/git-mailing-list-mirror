From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 13:42:55 -0700
Message-ID: <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:52:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAod-0007lo-4b
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759795AbZJNUnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759748AbZJNUnw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:43:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759526AbZJNUnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:43:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9680D580EE;
	Wed, 14 Oct 2009 16:43:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BRICQo69JfGGaq1eGFEMXCKKUoQ=; b=mO5PI3
	UX0iTVM8US4iiFFyOcv59HVbC8tSmebLcGLr3Lxw8mLjuYTVC54qCeuMdqPXv3NV
	c+bZFKtfwjA/j9CSWiDMhQl0sZwtGs0sCN4+9c4EKx0QyhWeea12x2Cm6S9sq6WO
	rhxtZAFW5rCGKJRIqI0YHx1i5z6T5KcKkoWR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XTj6B+y3ZwrloxRTuLzxC23OgZQInPGe
	5LR/CdowWqmeX8VvVLUuOnr458LY4g6BcVaO/7m56zUpBYHLUAqRc0Emym2NLDjC
	/Mrec5c+hbnzAj0C2bhS4vl3c9WoOL1tc1W8fhA10QYOYSfqJS4PcMPL2TPxTizR
	x0hsRK/tZME=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D999580ED;
	Wed, 14 Oct 2009 16:43:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85553580E8; Wed, 14 Oct
 2009 16:42:56 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910141616530.20122@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 14 Oct 2009 16\:18\:03 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A997558-B902-11DE-8046-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130338>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 14 Oct 2009, Daniel Barkalow wrote:
>
>> On Wed, 14 Oct 2009, Jay Soffian wrote:
>> 
>> > $ git commit -m "blah"
>> > Cannot commit while not on any branch. Please use git commit -b <branch> to
>> > specify the name of a new branch to commit to, or use git commit -f to
>> > force a detached commit.
>> 
>> The difference is that some experienced users depend on being able to 
>> commit while not on a branch, and want to not get a warning for every 
>> commit while not on a branch.
>
> I assume that the -f would silence any warning?

It won't help to alleviate my irritation if I need to give -f to each and
every invocation of "git commit" while detached, though.
