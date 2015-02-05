From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s" as for "ln" / "cp"
Date: Thu, 05 Feb 2015 12:59:35 -0800
Message-ID: <xmqqvbjgjcqw.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
	<D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
	<xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com>
	<20150205195143.GB15326@peff.net>
	<4CF52072-713F-4456-B894-B874B0EFFC6B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:59:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTWY-00059S-P8
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbbBEU7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 15:59:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077AbbBEU7h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:59:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB8C23647D;
	Thu,  5 Feb 2015 15:59:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qj3gk7Z5ImwEmcHFw2ynI5Vqifo=; b=LFlafF
	5y3S6PhgC17TmuEXbO/UIUR6wZpFeOQz1GnEgxyfbKIxrtveL5sNQrIvoLnljt7t
	QjjYbeNCj6hHPYQx0JsMARBZL6UH0/Bc05xKS3IqbAf7nu1oxmfuKEfZ6MlXK/N9
	gWskrBQ80F+GLt7Bvk8DZpuSq9tNOF+Up9PzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xz+iIyzKCSXCDPQL9vJPxfPYznsMHn7D
	CvHbz3XWox/qeLr96Rb/gpTlC4JZzAUv1brILTpAZyBYsKXakHO+7Y3ftRvg7C1g
	EYehMn9mLEuPbQ9ArmML7INBNp1sNa1Bx4XXwySwSm/M/cu1zHLBLM/iiDE3PxAf
	tM0auyzWAuY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D26D53647C;
	Thu,  5 Feb 2015 15:59:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A4A83647A;
	Thu,  5 Feb 2015 15:59:36 -0500 (EST)
In-Reply-To: <4CF52072-713F-4456-B894-B874B0EFFC6B@gmail.com> (Kyle J. McKay's
	message of "Thu, 5 Feb 2015 12:41:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E479E284-AD79-11E4-B45E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263404>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Now, can you do that easily in a Makefile? ;)

Or is it worth doing it?

I do not mind a full symbolic link as long as it points at the
correct place (Sebastian's version did not under DESTDIR which was
the only issue I had against it), but is there a good reason why we
would prefer a relative one (or we would want to avoid a full one)?

> I'm not sure exactly why, but I think:
>
> On Jan 30, 2015, at 13:10, Junio C Hamano wrote:
>> That would make me feel dirty.

That is a confusing style of quoting.  I suspect that I said the
above in a totally different context.

> Having a user-facing binary that is actually a symlink can potentially
> cause problems on OS X if the binary it refers to locates its
> libraries using a relative path.

I am not sure what problem you are trying to single out by repeating
"user-facing" here.

As doing this is still fully supported:

    $ PATH=$(git --exec-path):$PATH
    $ export PATH
    $ git-cat-file -t HEAD

You can arrange things in different ways:

 - /usr/libexec/git-core/git-cat-file can a symbolic link to
   /usr/bin/git (cross directory)

 - /usr/libexec/git-core/git-cat-file can a symbolic link to "git"
   (in the same directory) and then /usr/bin/git may be a symbolic
   link to /usr/libexec/git-core/git (cross directory)

No matter what, as long as you have these two directories, you would
have the issue that a symbolic link that is given to execv(2) might
misbehave somewhere anyway, no?

I do not know (and I am not quite sure if I want to know) how
serious your "potential" problems would be, and I do not doubt you
know OS X quirks much better than I do and do not intend to argue
there aren't such problems.  I am just curious how "user-facing"
comes into the picture.
