From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Fri, 21 Dec 2007 08:59:35 +0100
Message-ID: <56CA16B8-705C-45E5-8BBA-18E7072F2EC6@wincent.com>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218154211.GB12549@alea.gnuu.de> <7vabo7y762.fsf@gitster.siamese.dyndns.org> <200712202145.lBKLj7Fu015050@mi0.bluebottle.com> <7v4pedov6c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org,
	=?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 09:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5co5-0003BE-JV
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 09:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbXLUIAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 03:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbXLUIAI
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 03:00:08 -0500
Received: from wincent.com ([72.3.236.74]:41076 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbXLUIAG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 03:00:06 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBL7xa3L014513;
	Fri, 21 Dec 2007 01:59:37 -0600
In-Reply-To: <7v4pedov6c.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69045>

El 20/12/2007, a las 23:31, Junio C Hamano escribi=C3=B3:

> =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nan=
ako3@bluebottle.com> writes:
>
>> How about making this behavior configurable?
>
> First, as a general principle, I'd like to avoid having commands that
> changes their behaviour drastically depending on who the user is.  It
> makes it harder for people experienced a bit more than totally new to
> help others.  If they are truly experts and are familiar about the
> configuration stash.quick, then they will be fine, but others would =20
> say
> "Well, it works for me -- 'git stash' itself won't stash but list.  =20
> Why
> isn't it working for you, I don't know" and scratch head.

Although the patch is well-intentioned, I totally agree with Junio on =20
this point.

The solution here isn't configuration, but education. Some people have =
=20
already told how they've been burnt by doing an accidental stash, but =20
how many times does this have to happen to you before you learn your =20
lesson? Once? Twice if you are very unlucky?

And this is not a very painful lesson to learn, seeing as "git stash" =20
is not an inherently destructive operation. In 99% of cases there is =20
no risk of hard-to-reverse "damage". If you accidentally stash, you =20
can just unstash with "git stash apply". I already posted a two-line =20
patch which tells the user how to do this:

http://marc.info/?l=3Dgit&m=3D119799257404542&w=3D2

The 1% of cases in which "git stash apply" won't work is where the =20
user has unsaved changes in running editors at the time they do the =20
accidental stash. IMO, this is no justification to change the =20
behaviour of stash. Exactly the same is true of other commands that =20
alter the working tree; for example, what happens if you use "git =20
checkout" to switch to another branch when you have unsaved changes in =
=20
running editors? Are people suggesting that we should change the =20
behaviour of "git checkout" to warn the user that they should save any =
=20
unsaved changes before continuing and then hit "y"? I think that such =20
a thing would be absurd.

Cheers,
Wincent
