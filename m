From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering from a bad object
Date: Sun, 22 May 2011 13:42:41 -0700
Message-ID: <7vy61ywjpa.fsf@alter.siamese.dyndns.org>
References: <BANLkTindTWzeTFKYA3if4HYG3mj+NZX8oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "jonsmirl\@gmail.com" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 22:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOFUE-0007uL-UN
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 22:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab1EVUmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 16:42:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1EVUmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 16:42:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55C324C20;
	Sun, 22 May 2011 16:44:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGR0EbDqc9Si5cnoQ2IsPnrU/EU=; b=rRYdEe
	FHMOVTCCj4w5ffGPhA4Mw7ju0kbhCbIGhAGYWMIYUbkgtg5L42V1U2t9kjcYMtjb
	xbbnHpN9cJ/IbBfqazYFTQNL0qaZme34KbxSa64+u+8uUykzLzhyWjJpf9uxi6iW
	yqSmvIBJV5yxjKI1MuKR654z7MxPZOHzuE83M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1pUg569x4uRjJs0v7UDSblf4HAlL5nu
	ntgcgeYRKuIsgDbnk8tfNCKLGLD/QzCEz42oPvCQCmt+URzZxOvBY7heNWkagjsY
	LQWSDCqfCCXHla+uvgZkDtMMK9JiS1A9SLE4Izh0UnOYiMc+3sgA8H6MKkP2/tdr
	M+iHZw7jVg0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33D6B4C1D;
	Sun, 22 May 2011 16:44:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 29F164C1B; Sun, 22 May 2011
 16:44:49 -0400 (EDT)
In-Reply-To: <BANLkTindTWzeTFKYA3if4HYG3mj+NZX8oQ@mail.gmail.com>
 (jonsmirl@gmail.com's message of "Sat, 21 May 2011 19:03:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5849C28A-84B4-11E0-8EE1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174201>

"jonsmirl@gmail.com" <jonsmirl@gmail.com> writes:

> I just ran git repack on my kernel tree and got these results....
>
> I have all of my work saved in patches so this doesn't really need to
> get fixed, I can just whack the tree and start over.  I'm just
> wondering if there is a way to recover from this in case I actually
> had something irrecoverable in the tree.  I've probably been using
> this same tree for about six years so it has seen a lot of git
> revisions.
>
> jonsmirl@terra:/home/linus$ git repack -ad
> Counting objects: 2065160, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (462609/462609), done.
> error: inflate: data stream error (invalid distance too far back)
> error: corrupt packed object for 392ad4a422913ecc0eb76caaa6d2d10de0ea1505
> error: inflate: data stream error (invalid distance too far back)
> error: failed to unpack compressed delta at offset 131682613 from
> .git/objects/pack/pack-93e2de1939a33ce0b64fb5bd2c9d9897167ae820.pack
> error: failed to read object 392ad4a422913ecc0eb76caaa6d2d10de0ea1505
> at offset 131682590 from
> .git/objects/pack/pack-93e2de1939a33ce0b64fb5bd2c9d9897167ae820.pack
> Writing objects: 100% (2065160/2065160), done.
> Total 2065160 (delta 1724066), reused 1921643 (delta 1584095)
> jonsmirl@terra:/home/linus$
>
> The corrupt object is probably an ancient object in the kernel tree
> that I don't care about and it is unlikely that I will bump into it.
> But, how do you recover from this?

A delta compressed is so tightly packed that a single-bit error on disk
will propagate through all of the objects that are represented as a delta
against that object. So it won't be very pretty.

> The object is likely at kernel.org.
> Can git go fetch it somehow?

The protocol is designed specifically to disallow "I guessed that the
trade secret is contained within an object whose object name is this,
please feed me that object" kind of requests, so in general no.

If you know a tagged version that is newer than the tree that contained
the problematic object, you could "git fetch $remote_repo $that_tag" into
an empty repository, "git cat-file blob $that_object_name" into a
temporary file, then use "git hash-object -t blob -w $that_temporary_file"
in the repository with the problematic object (it may be a tree, but you
get the idea).

But seeing that your repack succeeded, it may be the case that you already
have the object in a healthy state available from elsewhere to the
repository with this problem. So "git fetch it somehow" is probably not
necessary to begin with. When there is a corrupt object in a pack, but a
good copy of it is available elsewhere (e.g. in a loose form, in another
pack, or available via your .git/objects/info/alternates, we will use the
good copy, ignoring the corrupt one.

One thing I can think of is to do this (assuming /home/linus is the
problematic repository):

        $ cd /var/tmp && rm -fr gomi && git init --bare gomi.git
        $ cd gomi.git
	$ git fetch file:///home/linus 'refs/*:refs/*'
        $ cd /home/linus
        $ mv .git/objects .git-objects-saved
        $ mv /var/tmp/gomi.git/objects .git/objects
        $ cp -r .git-objects-saved/info .git/objects/

But note that this will lose objects that are not reachable from the
refs in your original /home/linus repository.

> git fsck isn't happy....

That is not unexpected, but notice that they are all "dangling" and not
corrupt.
