From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] rev-parse: add --sq-quote to shell quote arguments
Date: Sat, 25 Apr 2009 06:57:43 +0200
Message-ID: <200904250657.43344.chriscool@tuxfamily.org>
References: <20090424062902.3705.44704.chriscool@tuxfamily.org> <7v8wlqii2y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 07:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxa0M-0000Z0-Tc
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 07:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbZDYE7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2009 00:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbZDYE7F
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 00:59:05 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:60314 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbZDYE7C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 00:59:02 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 2388B4B0069;
	Sat, 25 Apr 2009 06:58:55 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 02B074B002C;
	Sat, 25 Apr 2009 06:58:53 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8wlqii2y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117537>

Le vendredi 24 avril 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > @@ -30,6 +30,9 @@ OPTIONS
> >  	Only meaningful in `--parseopt` mode. Tells the option parser to =
echo
> >  	out the first `--` met instead of skipping it.
> >
> > +--sq-quote::
> > +	Use 'git-rev-parse' in shell quoting mode (see SQ-QUOTE section
> > below). +
>
> Hmph, I wonder how this interacts with the existing --sq option to th=
e
> same command in the mental model of end users.

I just sent a new version where difference between --sq and --sq-quote =
are=20
discussed.

> > +Example
> > +~~~~~~~
> > +
> > +------------
> > +$ git rev-parse --sq-quote "'''" '"""' "arg with space"
> > + ''\'''\'''\''' '"""' 'arg with space'
> > +------------
>
> Yuck --- does asciidoc formats this correctly?
>
>     ... goes and tries ...
>
> Not very readable.  A better example might be to demonstrate somethin=
g
> like this:
>
> 	$ cat >your-git-script.sh <<\EOF
> 	#!/bin/sh
> 	# quote user-supplied arguments
> 	args=3D$(git rev-parse --sq-quote "$@")
>         # and use it inside a handcrafted command line
>         command=3D"git frotz -n24 $args"
>         eval "$command"
> 	EOF
>
> 	$ sh your-git-script.sh "a b'c"
>
> i.e, put stress on how to use it, not on how it works internally.

I agree your example is better. I used it in the v2 I just sent.

Thanks,
Christian.
