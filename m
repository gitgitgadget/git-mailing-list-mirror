From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 10:43:01 -0700
Message-ID: <7vljj97w7u.fsf@alter.siamese.dyndns.org>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
 <7vk4yvt7kp.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910171617580.6644@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzDJQ-0000E7-9L
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbZJQRnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 13:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZJQRnS
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:43:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbZJQRnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 13:43:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A8025C037;
	Sat, 17 Oct 2009 13:43:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=wOWyFyAS9DPZ0CJq+jAc3dgVMy4=; b=lZknaSq0A0MWpXOXJ9net5s
	TCQdh4ah3iHKkqY+i8rAVBSQqZuLOINzKIe6/S+yVvNa5+LNy7r1Do1aM5PKQOkA
	m7GpM/JR7DTndExjYs0cj5u44R8raoj3gW5NfoC9C8FTLgAx5lGmUqcAuAfBWFda
	037RmdxWmWdcQOuPFFac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cprVWVfTNYQewZoSOVtj2cdnYzcOxWqbRU1G3Pda9WJ4s62W0
	GupOx8fBJQv1bHlp+6QNyk2Ng5gDNqgrpXM7b21RdeBSpv6U6gD7Jtc0aLITAvdn
	RfHgYBWvC9J5VISbu5UpEvHyb24r40GqOks8hJVqmSFZWQPiVE4ua+U0lA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FFBD5C032;
	Sat, 17 Oct 2009 13:43:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 026705C02F; Sat, 17 Oct
 2009 13:43:02 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A5A5734-BB44-11DE-9F3D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130572>

Julian Phillips <julian@quantumfyre.co.uk> writes:

>>> My interest in this thread is solely that it might provide a mechanism
>>> to find out which tag was checked out.
>>
>> Hmm, what is lacking in "git describe HEAD" for that?  I am not
>> complaining that you might be asking for something that exists, but I _do_
>> want to know if something that exists is not a satisfactory solution and
>> if so how it can be improved.
>
> What is lacking is the "checked out" part.  "git describe HEAD" will
> tell me _a_ tag that matches the currently checked out state.
> However, it makes no guarantee that it was the one I checked out.  If
> I tag the code with "v1.0.0", and a colleague later tags it with
> "this_version_sucks", then when I check out and build the code for the
> customer the version it reports could well be "this_version_sucks"
> instead of "v1.0.0" ...

I think I understand why you think showing what you gave to your last "git
checkout" (e.g. "checkout origin/master" or "checkout v1.0.0") and using
that as a build identification token is a good idea.  But "origin/master"
is a moving target---it depends on when you checked it out.  describe uses
tags and does not use branch heads for a good reason.

"v1.0.0" also is to a lessor degree, as you may have tagged v1.0.0 locally
and somebody else also has used the tag for a different version, but a tag
is far less likely to move due to social convention.  "describe --long"
would make sure this won't be an issue anyway, though.
