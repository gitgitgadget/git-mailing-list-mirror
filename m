From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Tue, 27 Mar 2007 09:15:12 +0200
Message-ID: <200703270915.12408.chriscool@tuxfamily.org>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org> <7vzm5zs1aq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 09:07:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW5ls-00077X-3Z
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 09:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbXC0HHD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 03:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbXC0HHD
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 03:07:03 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51069 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965275AbXC0HHB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 03:07:01 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 989E6B5ADD;
	Tue, 27 Mar 2007 09:06:59 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vzm5zs1aq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43238>

Le mardi 27 mars 2007 07:28, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> >
> >  bisect_run () {
> > +    # Check that we have everything to run correctly.
> > +    test -d "$GIT_DIR/refs/bisect" || {
> > +	echo >&2 'You need to start by "git bisect start".'
> > +	echo >&2 'And then by "git bisect bad" and "git bisect good".'
> > +	exit 1
> > +    }
> > +    bisect_next_check fail
> > +
>
> I think you shouldn't need the first "test -d blah"; doesn't
> "bisect_next_check fail" already give that message?

Without the first "test -d blah", if "bisect start" was not already use=
d,=20
then the user will only see :

'You need to give me at least one good and one bad revisions.'

And then when using "git bisect good" or "git bisect bad" to give good =
or=20
bad revision:

'You need to start by "git bisect start"
Do you want me to do it for you [Y/n]?'

So I thought that it would be better to tell the user upfront everythin=
g=20
that should be done.

But it's up to you.

Thanks,
Christian.
