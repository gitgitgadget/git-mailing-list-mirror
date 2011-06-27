From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 23:45:54 +0200
Message-ID: <1309211154.2497.391.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>
	 <1309200051.2497.288.camel@Naugrim.eriador.com>  <4E08D3B9.401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 27 23:48:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbJfW-0003wF-Tj
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 23:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836Ab1F0Vo6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 17:44:58 -0400
Received: from mail11.surf-town.net ([212.97.132.51]:57921 "EHLO
	mailgw14.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754739Ab1F0VnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 17:43:24 -0400
Received: by mailgw14.surf-town.net (Postfix, from userid 65534)
	id 9DB983E1EC; Mon, 27 Jun 2011 23:43:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw14.surf-town.net (Postfix) with ESMTP id 4FC613E1EA;
	Mon, 27 Jun 2011 23:43:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw14.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw14.surf-town.net ([127.0.0.1])
	by localhost (mailgw14.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LKovbRPIRl2o; Mon, 27 Jun 2011 23:43:16 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw14.surf-town.net (Postfix) with ESMTPSA id 776FF3E0C2;
	Mon, 27 Jun 2011 23:43:14 +0200 (CEST)
In-Reply-To: <4E08D3B9.401@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176372>

Le lundi 27 juin 2011 =C3=A0 21:02 +0200, Jens Lehmann a =C3=A9crit :
> Am 27.06.2011 20:40, schrieb henri GEIST:
> > what I really need is to do :
> >=20
> > cd project_1
> > git add ../library_1
> >=20
> > then in case of modification in library_1
> >=20
> > A git status in project_1 directory will say me :
> >=20
> > modified:   ../library_1 (modified content)
> > or
> > modified:   ../library_1 (new commits)
> > or even
> > modified:   ../library_1 (new commits, modified content)
> >=20
> > Just like it do for submodules with out "../" in the path.
> >=20
> > And I really think the metadata to do so should be stored in projec=
t_1
> > since it is him which depend on library_1 version "abcd1234..." and=
 this
> > information need to be self contained.
> > May be in project_1/.git or project_1/.gitmodules
> >=20
> > I do not see the point of having a third party project "Anything" J=
ust
> > to say to project_1 hey you need library_1.
> > If it need it, it should already know it.
>=20
> The point is it avoids ambiguity and cross-dependencies. If you have
> project_1 requesting the version "123456" of library_1 and project_2
> wants "abcdef", you'll always have one project disagreeing (=3D being
> dirty).

Yes that is exactly what I want.

> But "abcdef" might be a direct descendant of "123456" and is
> just fixing a bug that affects only project_2.

Yes but you can not make a rule of this the difference can have any
reason.
And mare often the bug has a chance to affect both project.
In any case both will be improved with a version more correct.

> So it would be ok for
> both to have "abcdef", but you'll have to add an extra commit to
> project_1 saying "updating library_1 because of bug in project_2" to
> make it clean again.

Yes that is also exactly what I want.

> That would make the projects not so modular and
> independent anymore and won't scale well.
>=20

It is sufficiently independent for me.
  - If some one pull only project1 from me he will have a consistent
    library_1 at "123456"

  - If some one pull only project2 from me he will have a consistent
    library_1 at "abcdef"

  - The conflicting version dependency is only in my working directory
    to be solved. And in my work flow updating project_1 to reflect the
    correction in library_1 is the thing to do.

  - If some one decide tu pull from me both project_1 and project_2 in
    the same working tree he will effectively inherit my conflict.
    But that also mean he is working on both project and decide to take
    account of the relation between them like me.
    Then the first one who upgrade project1 will be pulled by the other
    one.

  - In any case if you have no time to update a project an need to
    immediately work on it you always can :

      - Go in the library one directory and checkout the right version
        for the project.

      - Or clone project alone with its libraries in a completely
        separate directory.

> If the superproject records these dependencies you just update
> library_1, run all tests (including those in project_1 & project_2)
> and commit that in the superproject.
>=20
In this case you could not commit anything until every thing has been
done without breaking something.

When committing library_1 to "abcdef" nothing wrong happen in both case
all project still point to "123456"

when committing project_2 it will need to point to "abcdef" but in your
work flow the super project still say him it point to "123456" and
project_2 is broken.

If you immediately commit the superproject to repair project_2 you will
brake project_1 until it is also upgraded and superproject is reupgrade=
d
to reflect it.



In my work flow when committing project it will immediately point to
"abcdef" and not been broken.

project_1 still point to "123456" and is still not broken

superproject which is not needed still point on all old versions and is
not broken.

On commit of project1 it will immediately point to "abcdef" an is not
broken

superproject will till point on all old versions and is not broken.

On commit of super project if we have one every thing is up to date.

	Henri GEIST
