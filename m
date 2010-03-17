From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Tue, 16 Mar 2010 23:13:08 -0500
Message-ID: <20100317041307.GA26641@progeny.tock>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com>
 <7v634v27vf.fsf@alter.siamese.dyndns.org>
 <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 05:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrkcu-0002AP-FQ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 05:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab0CQEMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 00:12:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43682 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab0CQEMu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 00:12:50 -0400
Received: by gwaa12 with SMTP id a12so163126gwa.19
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 21:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=c5hkKbfczM877IVXdBdEIJxb+eVmDwE4gzh0VFqM+VM=;
        b=PuNVt9WFyXYs+l+n67r3k4uw1FELX0JWAflBcJP2UArl+7FGdLsHZPFVnYS/iVKRUj
         hykAzvEmVXqUuHFPaC1JWTzfzhbjLQDT5jXZS7R8sT9DZOqzfXkSlM4bklfZHwVPSHN5
         JaQgcDecdmD7WNsI6Mnbbeoh85JhrkzrHm4dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mQ6DV7wI/gf8G6VT4iRg88c/1TQXLzAImPeSBgzs52tvw+xr7v/YpMtUY8FgRwg9DK
         Tmgo4yBuwwxRTKpPGfZDkZDKyYMV/PepPJ1DF68BSdQw3rZgpEU/usU8u9X3TJqQ0ipP
         gl7DLn2ItmetF00K/XLBXfrmjNEZDEp1FKot0=
Received: by 10.90.246.19 with SMTP id t19mr156917agh.119.1268799169070;
        Tue, 16 Mar 2010 21:12:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5997777iwn.1.2010.03.16.21.12.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Mar 2010 21:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142363>

Hi,

Erick Mattos wrote:

> I am just trying to make you satisfied so gitsters, I mean git users,
> will have this feature as soon as possible.

Well, hopefully everyone wants it to make sense, too. :)

> I do prefer my first design mainly because it mimics the state of an
> initial commit.  I think that is subjectively better.
>=20
> You have been asking me to make one of the two possible work flow use=
s
> you pictured as favored so things will be already set to them.  No
> further commands to them.
>=20
> I did it!  As a matter of fact the "mostly common paths" people were
> favored as you have noticed your inclination to it before.

I guess I am confused because I am not sure what you are trying to do:

 A. on one hand, you might want a command to use as a building block.
    In practice, people would use scripts or refer to known recipes to
    make use of this building block in one of a few known combinations
    with other commands.

 B. on the other hand, you might be trying to make it easier to get
    some particular task done.

Junio was discussing the case B.  Whoever has the itch is in a good
position to say what interface would be convenient.  Usually one comman=
d
invocation can be enough to accomplish most of what is needed on its
own.  There were two examples of such commands he gave:

 1.                                                    * [public]
                                                        \
     * --- * --- * [private]   =3D=3D=3D>    * --- * --- * --- * [priva=
te]

   for the =E2=80=9Cwe cannot publish the whole history=E2=80=9D use,

and

 2.                                                 * [doc]

    * --- * --- * [master]  =3D=3D=3D>  * --- * --- * --- * [master]

   for the =E2=80=9Cstarting unrelated development but restrictive disk=
 quotas
   mean I have to use the same working directory=E2=80=9D use.

In these examples (which are just examples for illustration of what a
well supported use case looks like), the content in the index and work
tree after the command is run is tailored to what is expected to be
needed.

I suspect you are aiming for case A instead.  For scripts and special
case recipes, it might be a good idea to have a command to use as an
ingredient in tasks like (1) and (2) above.  The recipe people
currently use is usually something like the following:

  git symbolic-ref HEAD refs/heads/newbranch
  rm .git/index

but that indeed is not perfect: it does not check for a dirty index
in case 1, it does not keep track of what files were not registered
in the index so as not to delete them in case 2, and so on.

Also one might object to the knowledge of repository layout required;
gitrepository-layout(5) is probably not the first place a person would
look in trying to figure out how to carry out this task.  That misses
the point, though, in my opinion, since

 git symbolic-ref HEAD refs/heads/newbranch
 git rm --cached '*'

accomplishes the same thing.  Anyway, if your goal is to create
plumbing, I would suggest modifying a plumbing command instead of
=E2=80=98git checkout=E2=80=99. =20

Thank you for your efforts.  As hinted above, I would not mind seeing
improvement in this area at all.  Anyway, I hope this has provided some
food for thought (if not, don=E2=80=99t mind me; please carry on).

Kind regards,
Jonathan
