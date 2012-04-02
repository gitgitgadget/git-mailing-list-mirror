From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Mon, 02 Apr 2012 15:19:35 -0700
Message-ID: <7vvclhdbew.fsf@alter.siamese.dyndns.org>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net> <4F77209A.8050607@gmail.com>
 <20120402214049.GB28926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Bo Chen <chen@chenirvine.org>,
	Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 00:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEpbD-0002TQ-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 00:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab2DBWTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 18:19:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534Ab2DBWTi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 18:19:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5B706631;
	Mon,  2 Apr 2012 18:19:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u8eakzTlBwf1z0bnoyzStAOeILo=; b=NqiMKS
	fdU6TpN93OnonZ9Qvb5gvPgJoFC5dXltBip2Bu/jy+cjFahaV746X1J7ca53cR7k
	N1OHTmA8wdjGrz4wod9j/09ljbMI03KcKctnYwP8iP/p0TTRz46rYST0S1ivj3x8
	GkZHnU1VUrB4/yp1aw5UfX3+q6LvtD1GWxM5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lXECGqztYWTDkP49B6/28uqpCRP5cy2M
	T6FuYQ7lKAWTRPp1BEtDkW6/ZYyqU2G1S3nOf1mwq4xbJj+xzgqOuKGYO0uKwhhr
	8TkXANMcmiNTR60ZUcN4RoBjuyHP6v713ELg0QV5qQg5la5eWfF04rrQqRrcz7TK
	5oNKxZsVvJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D2D96630;
	Mon,  2 Apr 2012 18:19:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14844662F; Mon,  2 Apr 2012
 18:19:36 -0400 (EDT)
In-Reply-To: <20120402214049.GB28926@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 2 Apr 2012 17:40:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEBAD370-7D11-11E1-88F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194571>

Jeff King <peff@peff.net> writes:

>   1. You really have 100G of data in the current version that doesn't
>      compress well (e.g., you are storing your music collection). You
>      can't afford to store two copies on your laptop (because you have a
>      fancy SSD, and 100G is expensive again).  You need the working tree
>      version, but it's OK to stream the repo version of a blob from the
>      network when you actually need it (mostly "checkout", assuming you
>      have marked the file as "-diff").

This feels like a good candidate for an independent project that allows
you fuse-mount from a remote repository to give you an illusion that you
have a checkout of a specific version.  Such a remote fuse-server would be
an application that is built using Git, but I do not think we are in any
business on the client end in such a setup.

So I'll write it off as a "non-Git" issue for now.

The other parts of your message is much more interesting.

> Right. This is the same concept, except over the network. So people's
> working repositories are on their own workstations instead of a central
> server. You could even do it today by network-mounting a filesystem and
> pointing your alternates file at it. However, I think it's worth making
> git aware that the objects are on the network for a few reasons:
>
>   1. Git can be more careful about how it handles the objects, including
>      when to fetch, when to stream, and when to cache. For example,
>      you'd want to fetch the manifest of objects and cache it in your
>      local repository, because you want fast lookups of "do I have this
>      object".
>
>   2. Providing remote filesystems on an Internet scale is a management
>      pain (and it's a pain for the user, too). My thought was that this
>      would be implemented on top of http (the connection setup cost is
>      negligible, since these objects would generally be large).
>
>   3. Usually alternate repositories are full repositories that meet the
>      connectivity requirements (so you could run "git fsck" in them).
>      But this is explicitly about taking just a few disconnected large
>      blobs out of the repository and putting them elsewhere. So it needs
>      a new set of tools for managing the upstream repository.

Or you can split out the really large write-only blobs out of SCM control.
Every time you introduce a new blob, throw it verbatim in an append-only
directory on a networked filesystem under some unique ID as its filename,
and maintain a symlink into that networked filesystem under SCM control.

I think git-annex already does something like that...
