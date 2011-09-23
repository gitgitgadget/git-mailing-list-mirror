From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] A handful of "branch description" patches
Date: Fri, 23 Sep 2011 13:52:10 -0700
Message-ID: <7vk48zt211.fsf@alter.siamese.dyndns.org>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <4E7C49CF.60508@drmicha.warpmail.net>
 <20110923201824.GA27999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 23 22:52:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7CjM-000723-8s
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 22:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab1IWUwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 16:52:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461Ab1IWUwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 16:52:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269F8614B;
	Fri, 23 Sep 2011 16:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vo9iKO5o1+Hrij7Yq6zFP7NmxLY=; b=vfJmZA
	U1Wn1LCWxZyJNhbSxOZ5NuvuxVfu9uWMRgfRcx/g3xZUoyKMx7MJIXTPZUrvuNg1
	OOEHn9ZE4/cmzfPmevVvJ3hrqHvb8a3CHKLLFDNbzTSkNuJeC/QU1Xw1ffbO6RM+
	ol1vrsSaIgwoXbOORgcEE1EfFUEoPw1yoJaGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WIn64UiQeNql3c3wuZEP8iWJiQNWV3gO
	Pek2J4shfBgpNqECm6oLM6FGhwwOAftN1H+0+kLOmfI4QMryEg7lxFnIc9EN7W/m
	NePntQ2ukV0sPD1Zw6bWxnZJKfDqSUgxkBDpaIr1f6OKfCi+IORSlYUs+n04KrCy
	fWj1CM9parA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E42A614A;
	Fri, 23 Sep 2011 16:52:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EFBE6148; Fri, 23 Sep 2011
 16:52:11 -0400 (EDT)
In-Reply-To: <20110923201824.GA27999@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 23 Sep 2011 16:18:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8E50D7C-E625-11E0-A75D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182000>

Jeff King <peff@peff.net> writes:

> Eww. :)
>
> This seems like a clever solution to making git-notes store a ref as a
> key instead of an arbitrary sha1. But I wonder if the end result is
> really waht the user wants.

A more fundamental issue I have with this is that names of the refs are
local by nature (what I call "master" branch is not "master" to you, but
rather it is "origin/master" or "jch/master") while notes is meant to be
the mechanism to share. The following shares the same issue, but at least
it does not abuse "notes", so in that sense it may be cleaner at the
design level...

> Wouldn't it be much more friendly to have a separate tree of refnames
> that stores:
>
>   refs/heads/foo -> (some blob with the "foo" description)
>   refs/heads/bar -> (some blob with the "bar" description)
>
> Yeah, you have to build another git-notes-like interface around it. But
> the data structure is pleasant and flexible. You could even "git
> checkout" the whole tree and edit the notes with your editor, without
> having to deal with some obfuscated name.
