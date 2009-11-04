From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Automatically remote prune
Date: Wed, 04 Nov 2009 10:04:00 -0800
Message-ID: <7v639qi2un.fsf@alter.siamese.dyndns.org>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kDo-0006A3-TW
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbZKDSEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757540AbZKDSEE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:04:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757447AbZKDSED (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:04:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18EE4732B8;
	Wed,  4 Nov 2009 13:04:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Dj7JIQeTXUi/wQ7KyaSim82ghYI=; b=oyhspWPbQ7kGyAFZ9PUjwWp
	1Y6n0xl2PYZk50GNaxpdKnFJfoccYvMapggLYqjni6NiMQX9M9ks+vxQIHpA0SBI
	ZL+8YXfxqB+NuIbMFRLSV3n0ymQOu7nnnkAsI8wVoedyt9hPmtnm4xbLbdDvMzmq
	3ZQyrTrXlr50ssvwLUkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NrN94ZCL+LypCan97wH8ZfR8KQAI1EtMCHlUlhN6Y5kLirnjy
	UahDScuZDzMpjlAJ+btgYbLL/JI5tJdesKi73g0QelQE3LaqnsIt4RZcTX7t60lU
	IJY9Uz0UWD6mtSIPYQO+/cNWgiSvAETMXJIERcYxseyF3Ve/G0Gq9CKQ0o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74D79732B7;
	Wed,  4 Nov 2009 13:04:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 050D4732B6; Wed,  4 Nov
 2009 13:04:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 716DFCA4-C96C-11DE-A26E-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132104>

John Tapsell <johnflux@gmail.com> writes:

> $> git branch -r
> origin/blah1 [Deleted]
> origin/blah2
>
> (Some branches have been deleted on the remote server.  Use  "git
> remote prune origin" to remove these)

There is no information locally available to do this, unless you are
willing to contact the remote every time somebody says "branch -r" (or
"branch -a").  I tend to think it is not very nice for the branch command
that has long been a "local" command to suddenly start talking to outside
world.

You could store necessary information somewhere else when you contacted
the remote the last time, but we need to consider what the benefits are to
give this information in the first place.a

The [Deleted] mark in your suggestion tells the user:

    This is already removed in the remote, and this tracking copy is the
    only way for you to view it ever again.  Do not run 'remote prune
    origin' blindly otherwise you will lose it.

But that is already possible with "git remote show origin", isn't it?
