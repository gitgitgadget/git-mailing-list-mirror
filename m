From: Santi <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] Per branch properties for pull
Date: Mon, 24 Jul 2006 14:58:52 +0200
Message-ID: <8aa486160607240558n2b22c918v40cfcb26ed046472@mail.gmail.com>
References: <87hd1b9fjq.fsf@gmail.com>
	 <7vmzaze9xj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 14:59:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G501Y-0003hl-IP
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 14:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWGXM6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 24 Jul 2006 08:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWGXM6y
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 08:58:54 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:19207 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932141AbWGXM6y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jul 2006 08:58:54 -0400
Received: by wx-out-0102.google.com with SMTP id s13so766987wxc
        for <git@vger.kernel.org>; Mon, 24 Jul 2006 05:58:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZThpeQ8dA/I7XRpyRfZGnR7gvxQjBg5WfNn64l0CjW35sE3sKIEaQPFBvwc4at3MntlRkCA33Qs9Eh972WSM/Kqold7s2Ib9GCd7x9WF9x2fXqqqHfMAcHxDimW+25sPGFnwEgk9KUuoGRRzzQV1kNykWiZ56VUPOxv5Bx0Ah20=
Received: by 10.70.99.20 with SMTP id w20mr4891182wxb;
        Mon, 24 Jul 2006 05:58:52 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Mon, 24 Jul 2006 05:58:52 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vmzaze9xj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24143>

2006/7/24, Junio C Hamano <junkio@cox.net>:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > It extracts all the information for pull from the config file.
> >
> > If you have a config file as:
> >
> > [branch "master"]
> >         remote=3Dorigin
> >         merge=3Dnext          #the remote name
> >         octopus=3Doctopus
> >         twohead=3Drecursive
> >

[...]

> I am in general in agreement with this line of thought and had
> an impression that many on the list wanted to have per-branch
> configuration.  I am a bit too tired now so I'd just let you
> know I am interested but would not apply it tonight.
>
> Opinions?  Comments?  Anything missing or objectionable on
> Santi's patch from the list?

Actually my patch is a RFC to agree on the config semantics, (although
I do not mind if committed to "pu" :) :

=2E- are remote/merge good names?
=2E- the merge key is the name of the remote branch.
=2E- are the octopus and twohead OK?
=2E- for a local merge, is remote=3D. OK?
=2E- "git pull ." to mean: do not fetch anything but merge the default =
branch?
=2E- for the integrator case:
   * is the "merge=3D rembranch from remote" OK?
   * "git pull remotename" should read the branch properties if
branch.$curr_branch.remote=3Dremotename?
   * It could be usefull to have a git-merge-seq that performs a
twohead merge sequentially instead of an octopus.

The patch as is works for me and it currently depends on the remote
config being in .git/config.

It only touchs git-pull, just to have a working prototype of the
semantics and to minimize the breakage, but it could be that it should
be integrated in the git-parse-remote.

Santi
