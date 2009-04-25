From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] rev-parse: add --sq-quote to shell quote arguments
Date: Sat, 25 Apr 2009 07:06:40 +0200
Message-ID: <200904250706.40533.chriscool@tuxfamily.org>
References: <20090424062902.3705.44704.chriscool@tuxfamily.org> <7v8wlqii2y.fsf@gitster.siamese.dyndns.org> <49F17945.8000004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 07:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxa8t-0001xr-RO
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 07:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbZDYFIB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2009 01:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZDYFIA
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 01:08:00 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:59115 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbZDYFIA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 01:08:00 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 2D05B4C805B;
	Sat, 25 Apr 2009 07:07:52 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 30A204C803D;
	Sat, 25 Apr 2009 07:07:50 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <49F17945.8000004@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117538>

Le vendredi 24 avril 2009, Johannes Sixt a =E9crit :
> Junio C Hamano schrieb:
> > Not very readable.  A better example might be to demonstrate someth=
ing
> > like this:
> >
> > 	$ cat >your-git-script.sh <<\EOF
> > 	#!/bin/sh
> > 	# quote user-supplied arguments
> > 	args=3D$(git rev-parse --sq-quote "$@")
> >         # and use it inside a handcrafted command line
> >         command=3D"git frotz -n24 $args"
> >         eval "$command"
> > 	EOF
> >
> > 	$ sh your-git-script.sh "a b'c"
> >
> > i.e, put stress on how to use it, not on how it works internally.
>
> Hmm, that makes me wonder why we special-case shell-quoting and imple=
ment
> it in an executable. Why don't we have perl-quoting, C-quoting,
> PHP-quoting, $language-of-your-choice quoting, etc, too?

Because there are a lot of shell scripts in the Git source code and it'=
s an=20
important problem for shell scripts to properly handle arguments.

> I think we should simply move sq() from git-am to git-sh-setup and us=
e
> that in git-bisect.

We already have an implementation of shell quoting in C, why not use it=
=20
everywhere instead of having 2 implementations?

And what happens if someone want to port to C a shell script that uses =
sq()?
The implementation used will have to be the one in C, so why not use it=
=20
right now?

Regards,
Christian.
