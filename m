From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field separator
Date: Tue, 27 Oct 2015 10:46:38 -0700
Message-ID: <xmqqsi4wcigx.fsf@gitster.mtv.corp.google.com>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
	<cover.1445782122.git.johannes.schindelin@gmx.de>
	<2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de>
	<vpqlhaqas8g.fsf@grenoble-inp.fr>
	<xmqq8u6piir8.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510270950230.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:46:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8Kd-0004ps-9S
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 18:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965522AbbJ0Rqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 13:46:42 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964836AbbJ0Rqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 13:46:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C66E2267A2;
	Tue, 27 Oct 2015 13:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=e3QcoHeXvff1SE8zn5zruD7LlCg=; b=i4F6MhzN2TwkMt5+dOYQ
	dj2eqztORLPqjO7acq1jygX/6p+mpTWlOnwmA0Nf5agOjkP3d98dSp8UxbnLa+qV
	GREYL+xbdnzSm1P5pWYGJuY8uVa44rhzhxl6IECo1UgHDKHjydJ4d3l65pvArcdM
	9vzQ/Wkdk1ZjVa2HhKVDK68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SSnJxx7x4YdliRUxHe14y63VYdhqtI/UfM2mlm2uPntt+r
	r4jvmt6e31k0gdf0xJYEc3rukeDVK0R7JKaTNSjirjrY4yxuBZINS7iHsxGAjlpk
	9GQRaAoK6ApvPKy3sXzHimAPe8CJFD3XyGJAhDGBmmk7G7mJ1eZMOsC5OD6l8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEA97267A1;
	Tue, 27 Oct 2015 13:46:39 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 42990267A0;
	Tue, 27 Oct 2015 13:46:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD157370-7CD2-11E5-8683-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280271>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This assumes that the platform is either CR/LF or LF. That is incorrect.
> Windows does *not* dictate the line endings to be CR/LF. Certain
> applications do.
>
> The shell is an MSys2 shell, and MSys2 convention is to use LF. Hence the
> shell is done correctly for the platform.
>
> Yet on Windows (and in cross-platform projects also on Linux and MacOSX),
> you have to deal with the fact that text files produced outside the cozy
> little shell can have different line endings.

I know that.  That is why I said this is platform specific.  When
somebody on Ubuntu comes and says "XYZ does not work when I saved my
text file with CRLF", I can say "don't do that then".  I've been
assuming that you cannot say the same to your users, in order to be
nicer to Windows.  You say MSys2 convention is to use LF, but what
do you exactly mean by that?

I am hoping that you do not mean "we treat a file created by a DOS
editor as a text file with CR appended at the end of each line".
I'd instead expect that a file the user wrote ABC on the first line
will give you ABC in $word if the user did this:

	#!/bin/sh
        read word <file

and not "ABC^M".  That is, "we may produce only LF files, we consume
LF files just fine, but we also treat CRLF files as text as their
users intended."

> As I said, I am uninterested in arguing for arguing's sake.

I already explained why this particular thing does not have anything
to do with IFS but comes from the way your "read" behaves, which is
not in line with the way users on your platform expects.  Is that so
hard to understand?

An argument you make to support adding stuff to IFS _is_ an argument
for arguing's sake.

> What I really needed you to do indicate the way forward.

Yes, and I already did, didn't I?

I already said that mucking with IFS is a wrong thing to do, and
indicated that that is not the way forward.

I also already said that fixing your read is the only sensible thing
to do in the longer term iff you claim to support those who use
"certain applications" that leave CRLF line terminator.

 * http://pubs.opengroup.org/onlinepubs/9699919799/utilities/read.html
   defines the operation as a two-step process.  It is supposed to read
   an input line and then "The terminating <newline> (if any) shall
   be removed from the input".  And then "the result shall be split into
   fields" (at IFS boundaries).

   As POSIX does not say <newline> has to be a single octet with
   value 10 (the same way you are allowed to show CRLF when you call
   printf("\n"), and you do not see CR left at the end when you use
   gets(3)).

   So on a platform that (optionally) accepts CRLF as a line
   terminator, "read" should read up to LF for a line, and if there
   is a CR immediately before that LF, remove that CR, too.  Now you
   got the result of "terminating <newline> (if any) shall be
   removed".  Then look at "the result" and split into fields using
   IFS.  That way, you still process LF terminated files correctly,
   and you would never show a single ^M for an empty line, which
   triggered this thread.

 * Optionally, you may want to implement the "field splitting" (at
   IFS boundaries) with a small twist.  When the script/user
   included LF in IFS, split at LF but remove CR if there is one
   that immediately precedes the LF.

And also I gave you a more localized (i.e. less likely to negatively
affect unrelated parts of the system) workaround that we could use,
until your "read" is fixed.

Mind you, I am not happy with that "$cr may appear at the end of the
last token on the line" workaround.  Other places in the code (both
inside and outside Git scripted porcelains) that calls "read" to
read from text files can suffer from the same issue, until it is
fixed.  Covering up the bug in "read" by throwing extra characters
to IFS, especially when read is not the only user of IFS, is not a
fix.
