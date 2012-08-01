From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 23:09:25 -0700
Message-ID: <7v4nongn3e.fsf@alter.siamese.dyndns.org>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net>
 <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 08:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwS7h-0005wz-QL
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 08:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab2HAGJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 02:09:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab2HAGJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 02:09:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1988B9B19;
	Wed,  1 Aug 2012 02:09:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UqiXM1e2dlt2etOqpf6jKiAFWHQ=; b=kNqIFV
	lWWvfWgZMYGg2dqAppfXGmHkwZdZJueSS1lTFpgeJFwCDuy2aUp2ETOwXa8COKt0
	4ASJOVpRmYen3vxmnEo05913yIR0AVPt19NvMXlImEhxti2qqx7rJdmmOfSRRRrP
	il0uIYe/sSR7zQJ4S1nkj8rtTtwUps4OHVuKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GdKo42nqE21ubTFsc0nh42KqxCUftJwj
	bgAzt0hECGvj0KWefzM98/Ob6qapYZW1m6ubGreEJCQyLP9zn8oqwKmf2W0mstWg
	Udph3CBaau4AM63jKhZwUCbShe5c2XMAfH9ykO2dSbmmzY/nrq9+r24XmhGiTvzX
	zZSd+LSji4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 083BE9B18;
	Wed,  1 Aug 2012 02:09:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E0E09B16; Wed,  1 Aug 2012
 02:09:27 -0400 (EDT)
In-Reply-To: <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 1 Aug 2012 11:36:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7306BD7E-DB9F-11E1-9071-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202704>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Yes. This is probably cosmetics only, but without path information, we
> leave it to chance to decide which A to pair with B and C (in the
> A->B, A->C case above). Wrong path might lead to funny effects (i'm
> thinking of git log --follow).

Isn't that why <A,B> and <A,C> can have different scores per object
name pair?  And if you mean by B and C the paths not object names,
and the blob at B and C are indeed identical, why would it matter?

>>> There's also the problem with transferring this information. With
>>> git-notes I think I can transfer it (though not automatically). How do
>>> we transfer sha1 map (that you mentioned in the commit generation mail
>>> in this thread)?
>
> I wasn't clear. This is about transferring info across repositories.

It is simple to define a portable format to record Jeff's rename
cache database (it could be a text blob full of "x40 x40 score"
lines), point such a blob with a special ref, and write a Porcelain
to transfer and merge across repositories, e.g.

	git fetch $there refs/rename-cache
	new=$(
	(
            git cat-file blob refs/rename-cache
            git cat-file blob FETCH_HEAD
	) | sort | uniq | git hash-object -w --stdin)
	git update-ref refs/rename-cache $new

And as Jeff said, that is orthogonal to the issue of what is being
stored.  The contents of refs/rename-cache blob could be compiled
into a binary form for quicker access at runtime in the Porcelain.
