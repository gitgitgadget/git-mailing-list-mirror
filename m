From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 14:57:15 -0500
Message-ID: <76718490903031157o2938d46cl6c33e78cf64ad9d1@mail.gmail.com>
References: <1235865822-14625-2-git-send-email-gitster@pobox.com>
	 <20090301031609.GA30384@coredump.intra.peff.net>
	 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
	 <20090301100039.GD4146@coredump.intra.peff.net>
	 <20090301170436.GA14365@spearce.org>
	 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
	 <20090303070937.GB30609@coredump.intra.peff.net>
	 <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com>
	 <7vtz6bf392.fsf@gitster.siamese.dyndns.org>
	 <20090303082318.GB3158@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LealL-00023v-Tz
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbZCCT5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 14:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbZCCT5S
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:57:18 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:15813 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbZCCT5R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 14:57:17 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2933246rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VNsQiS74KnYFHt5BksItnI5lYgNaKGGXfj6ou5Vbvr4=;
        b=PY2nwfue4hvLxZMAZZ+BOx/0wd9npOQqklstIHMBp68/DTGDR7oTMF0TZ8fr3xyd4e
         0Kp7GKy5UJODF0wOLc3OQkoTVLdDHqPk9l2+f5AUUDhWOWIhOaV5taA8jG7/D6sk+510
         zqhWrI2tOKICxFhgunZlRhBW2232+PsREaT9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F/yI11eHtfxLlqFJu1iLSoQt3odKeXDpxRoUyZuCMGwN6nmaoBRCwAodvJ1sI6GPnE
         xtEOh84SaKgzFOu/clUCAiq+Ud6ClTWaAs4NePIMkFxmYJ6VPAh/rGYMvLqXXTPJCnFP
         dAK9tlJVKp7j4wzVW/cnFAT1h8yvnvRZWy1gc=
Received: by 10.140.158.4 with SMTP id g4mr3698980rve.160.1236110235246; Tue, 
	03 Mar 2009 11:57:15 -0800 (PST)
In-Reply-To: <20090303082318.GB3158@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112162>

On Tue, Mar 3, 2009 at 3:23 AM, Jeff King <peff@peff.net> wrote:
>
> What about the client just calling init-serve on the server as a prog=
ram
> which does whatever it wants to create a repo? The shipped default wo=
uld
> be:
>
> =C2=A0#!/bin/sh
> =C2=A0echo >&2 Sorry, repo creation not allowed.
> =C2=A0exit 1
>
> Sites who want to give their users full creation access would do (and
> obviously the --mkdir option would need to be added):
>
> =C2=A0#!/bin/sh
> =C2=A0exec git init --mkdir "$@"
>
> Sites which want to restrict can do:
>
> =C2=A0#!/bin/sh
> =C2=A0for i in "$@"; do
> =C2=A0 =C2=A0case "$i" in
> =C2=A0 =C2=A0--bare) ;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 *) echo >&2 Forbidden argument: $i; exit =
1 ;;
> =C2=A0 =C2=A0esac
> =C2=A0done
> =C2=A0exec git init --mkdir "$@"
>
> Sites like GitHub or Gerrit can munge the arguments as appropriate. T=
hey
> could even allow site-specific options if they wanted as long as they
> were syntactically correct (i.e., "git init --gerrit-base=3Dfoo remot=
e"
> would pass the argument through to the remote unharmed).

=46WIW, I like this proposal. The only issue I have which I think simpl=
y
cannot be reconciled is this: it doesn't do anything to help a user
that expects "git push --init ssh://..." to "just work". (And here I'm
assuming push --init just calls init --remote under the covers.) The
reason is that such a user is probably just using the git supplied by
their vendor, and thus remote creation is likely disabled by default.
The best I can come up with is a different error message:

"Sorry, remote repo creation not allowed. To enable it, blah blah blah"

So at least the user has a clue that git can help them here, but there
are security reasons it does not do so by default.

j.
