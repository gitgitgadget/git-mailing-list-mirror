From: Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 12:49:38 -0700
Message-ID: <7vsj40760d.fsf@alter.siamese.dyndns.org>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
 <alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
 <20130312041641.GE18595@thunk.org>
 <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 12 20:50:16 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UFVDD-0004VK-RO
	for glk-linux-kernel-3@plane.gmane.org; Tue, 12 Mar 2013 20:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333Ab3CLTtn (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 12 Mar 2013 15:49:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572Ab3CLTtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Mar 2013 15:49:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDFC7A477;
	Tue, 12 Mar 2013 15:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFaexKjXFY31QkZBqLP8Lh8FFu4=; b=ifAEE0
	FiXEmw4wq8YkVwQuWqUL2H8/H6J7R93GdUD4793ScuDyD9vfXlG/bzzsWSDpn888
	/Gh6r8K28KItrHPtxLPoL6YzEjPVL6kSqy87EDT6PKTv0xm2XJMrjCL3sUn+Y5dq
	dspOYVbGA62ZtFn2FZfdd4x8zjD+w1nKZ5V/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BT1j88wpJuk2s+Vv4ceBzt+NDrMX+ws/
	5cbcZr1Ygv+4oVstdO2cg6jV61cxzc2HPUmYgEf7jEnyiSItMUhpdU+/f8QkCokk
	3lrmFfquDm1GM6xJFScmeLXMBmsqW9v1IODS9NxBmJtTDRldtlVgw2hd2Fh2Kilv
	XZ2+4eebS3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1E64A476;
	Tue, 12 Mar 2013 15:49:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26BBAA472; Tue, 12 Mar 2013
 15:49:40 -0400 (EDT)
In-Reply-To: <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 12 Mar 2013 10:13:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA420A1A-8B4D-11E2-A082-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217989>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> One is simple:
>
>     git config alias.sync="pull --ff-only"

Heh, I just wrote that myself after reading the early part of this
message ;-)

> which works fine, but forces submaintainers to be careful when doing
> things like this, and using a special command to do back-merges.

> And maybe that's the right thing to do? Back-merges *are* special,

Yes.

> after all. But the above alias is particularly fragile, in that
> there's both "pull" and "merge" that people want to use this for, and
> it doesn't really handle both. And --ff-only will obviously fail if
> you actually have some work in your tree, and want to do a real merge,
> so then you have to do that differently. So I'm mentioning this as a
> better model than "git reset", but not really a *solution*.

> That said, the fact that "--ff-only" errors out if you have local
> development may actually be a big bonus - because you really shouldn't
> do merges at all if you have local development, but syncing up to my
> tree if you don't have it (and are going to start it) may be something
> reasonable.

Yes, that's the reasoning behind all the behaviours you described
above.

> Now, the other approach - and perhaps preferable, but requiring actual
> changes to git itself - is to do the non-fast-forward merge *only* for
> FETCH_HEAD, which already has magic semantics in other ways. So if
> somebody does
>
>     git fetch linus
>     git merge v3.8
>
> to sync with me, they would *not* get a merge commit with a signature,
> just a fast-forward. But if you do
>
>     git pull linus v3.8
>
> or a
>
>     git fetch linus v3.8
>     git merge FETCH_HEAD
>
> it would look like a "maintainer merge"....

I am not sure I follow.  Are you solving the real problem, the
pointeless merge in the "security tree" that started this thread?

I would imagine it was made by somebody thinking that pulling a
tagged stable point from you is a good idea, like this:

	git pull linus v3.9-rc2

which under your FETCH_HEAD rule would look like a maintainer merge,
no?

An alternative may be to activate the magic "mergetag" thing only
when you give "--no-ff" explicitly; otherwise merge would unwrap the
tag, whether it comes from FETCH_HEAD.

The following examples all assume that your HEAD is somewhere
behind v3.9-rc2, perhaps done by

	git checkout -b test v3.8^0

Then under the "--no-ff activates the magic" rule:

	git merge v3.9-rc2

will fast-forward, but this

	git merge --no-ff v3.9-rc2

creates a real merge with the "mergetag" signature block.  The one
that caused trouble in the "security tree", i.e.

        git pull linus v3.9-rc2

or its equivalent

        git fetch linus v3.9-rc2
        git merge FETCH_HEAD

would still fast-forward under this rule.  The maintainer needs to
do

	git pull --no-ff git://git.kernel.org/... for-linus

if the pull could fast-forward under this rule, though.

Having thought this up to this point, I am not sure it generally is
a good change.  It feels that "pull --ff-only" that prevents people
from creating pointless back-merges may still be a better mechanism.

I dunno.
