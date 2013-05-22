From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Wed, 22 May 2013 10:58:49 -0700
Message-ID: <7v8v36kiau.fsf@alter.siamese.dyndns.org>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
	<x2ip2b6udr.fsf@bacon.lysator.liu.se>
	<20130522134212.GB13731@poseidon.cudanet.local>
	<20130522144531.GB2777@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 19:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfDJc-0005lB-T6
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 19:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab3EVR6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 13:58:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58683 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692Ab3EVR6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 13:58:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2A9B2005B;
	Wed, 22 May 2013 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3onpnhnYEv+x9zc7RLaYJD53rs=; b=KB1WgD
	mqkbsS4CHiTXx+KIT8LdbpaRSZ8+yurOqZS+C2RC9uySMtOR9vvIsrTvU84xqfs1
	dnK0ktMGLxrg2+ysVn+8TYhpplKFZV4Sb1Nn80HaaguElgvGkdN+eOWQDJXIqFUH
	0d0r3YBd6DtjUuI2Cb+quXD4jZrumX/gA8UyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+msJXHoBkwiLbCZxUsNsswv8mGkK2wZ
	dE97LOjX4uLbWJvoxWOXZCe8cmVbNdVmo1roDMWSrdkOszftCtr2uZBHnsw+USON
	TkikyhFbEUnM+fNEqI+HzOsYtwoCfbi5xpvtYPKy6tlNtZ54lNuPTnMbVNCqnmjm
	B1Jn3EW9pkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA24C2005A;
	Wed, 22 May 2013 17:58:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24B1220057;
	Wed, 22 May 2013 17:58:51 +0000 (UTC)
In-Reply-To: <20130522144531.GB2777@thunk.org> (Theodore Ts'o's message of
	"Wed, 22 May 2013 10:45:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42746C54-C309-11E2-AFAE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225180>

Theodore Ts'o <tytso@mit.edu> writes:

> I was actually thinking that it might be interesting to have a
> branch.<branch>.rewindable, which would change the guilt defaults, and
> could also key changes in key git behavior which makes it less likely
> that a user shoots him or herself in the foot --- i.e., give warnings
> if he or she has modified the branch in such a way that
> remotes.origin.<branch> is no longer contained within the branch head.

At least "rebase" can pay attention to it and might make the world a
better place.

Your final "git push" needs to be forced if you rewound beyond
remotes.origin.<branch> so in that sense, there already is a sefety,
but it is better to give the user a chance to notice that before the
user spends more time to polish the rewound topic to perfection,
only to see the push rejected.
