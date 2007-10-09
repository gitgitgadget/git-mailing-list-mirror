From: Thomas Pasch <thomas.pasch@jentro.com>
Subject: Re: git-http-push / webDAV
Date: Tue, 09 Oct 2007 11:37:27 +0200
Organization: Jentro Technologies GmbH
Message-ID: <470B4BD7.8090603@jentro.com>
References: <4700F6BC.2070701@jentro.com> <20071001155454.GU975@void.codelabs.ru> <47020603.3080000@jentro.com> <20071002085416.GW975@void.codelabs.ru> <470215F6.2060105@jentro.com> <20071002104646.GY975@void.codelabs.ru> <47022857.806@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Oct 09 11:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfBX6-0001vH-BZ
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 11:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbXJIJhf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 05:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbXJIJhf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 05:37:35 -0400
Received: from mail2.infra.net ([212.89.96.7]:4523 "EHLO gamma.m.infra.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752385AbXJIJhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 05:37:34 -0400
Received: from epsilon.m.infra.net (epsilon.m.infra.net [212.89.96.8])
	by gamma.m.infra.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l999bTGi027014;
	Tue, 9 Oct 2007 11:37:29 +0200
Received: from [192.1.1.184] (u19-17.dsl.vianetworks.de [194.231.42.17])
	(authenticated bits=0)
	by epsilon.m.infra.net (8.13.4/8.13.4/Debian-3) with ESMTP id l999bSkx023330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Oct 2007 11:37:29 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <47022857.806@jentro.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60376>

Dear Eygene,

I tried all this on a Gentoo x86_64 machine. No problems!
Git on http/webDAV is just working fine.

I also retried all this on a SuSE 10.3 system. Same
problems as before. Thus it could have to do with
the (general) configuration of the SuSE system.

I still feel that the behaviour of git-push /
git-http-push is *not* approbiate. It should
indicate a problem if it was not able to upload
a new object to the remote server. Just saying

>>>     sending 3 objects
>>>     done

instead of indicating a problem is not what a
user expects. This particulary true if the
objects are not created on the server as it
seems to be in my case.

Cheers,

Thomas

Thomas Pasch wrote:
> Dear Eygene,
>=20
> I used a rather small test repo with only 2 or 3
> commits.
>=20
> The last tests I did with the a (current) git repo clone:
>=20
>> git clone --bare git://git.kernel.org/pub/scm/git/git.git
>=20
> e147e54b14828fa2e88e88907e0ca4dc3d694448 has indeed *not*
> found its way into the http push repo. For me it looks
> like that the push *first* updates refs/heads/master
> (successfully) but fails to transfer the object itself.
>=20
> Perhaps it would be more graceful that the object is
> transfered *first* and then the remote tip is updated...
>=20
> What version of git do you use?
>=20
> Cheers,
>=20
> Thomas
>=20
> Eygene Ryabinkin wrote:
>> Thomas,
>>
>> Tue, Oct 02, 2007 at 11:57:10AM +0200, Thomas Pasch wrote:
>>> well, *somewhat* better with the trailing slash:
>>>
>>>> echo "modified" >>grep.c
>>>> git commit -a
>>> Created commit e147e54: mod
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>> git push -v
>>> Pushing to http://test@x.x.x.x/git/git.git/
>>> Fetching remote heads...
>>>   refs/
>>>   refs/heads/
>>>   refs/tags/
>>> updating 'refs/heads/master'
>>>   from 34c6dbdef439f7cd93d3fe22493a3c1496ce96f7
>>>   to   e147e54b14828fa2e88e88907e0ca4dc3d694448
>>>     sending 3 objects
>>>     done
>>> Updating remote server info
>>>
>>> There's no more error message.
>> OK, that's fine: the previous error was tied to the fact that
>> when you're getting /git/git.git from the Web-server, it notices
>> that it is a directory and redirects you to the /git/git.git/.
>> But (IIRC) curl does not follow such redirections.
>>
>>> However, push has still
>>> not worked. If I try to check out the new HEAD:
>>>
>>>> git clone http://test@x.x.x.x/git/git.git/
>>> Initialized empty Git repository in /home/tpasch/tmp/git/.git/
>>> Getting alternates list for http://test@x.x.x.x/git/git.git
>>> Getting pack list for http://test@x.x.x.x/git/git.git
>>> Getting index for pack 563e2090185692c7d765775569a0ce986840fd17
>>> Getting pack 563e2090185692c7d765775569a0ce986840fd17
>>>  which contains 3af9d3e08da868c3a7687ab38d72f4296a99005d
>>> [...]
>>> walk 24778e335a6450e34257a311d0bf4a12bdb3006c
>>> walk 19b2860cba5742ab31fd682b80fefefac19be141
>>> walk bf0c6e839c692142784caf07b523cd69442e57a5
>>> walk e497ea2a9b6c378f01d092c210af20cbee762475
>>> walk 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
>>> walk e83c5163316f89bfbde7d9ab23ca2e25604af290
>>> Getting alternates list for http://test@x.x.x.x/git/git.git
>>> Getting pack list for http://test@x.x.x.x/git/git.git
>>> error: Unable to find e147e54b14828fa2e88e88907e0ca4dc3d694448 unde=
r
>>> http://test@x.x.x.x/git/git.git
>>> Cannot obtain needed object e147e54b14828fa2e88e88907e0ca4dc3d69444=
8
>> OK, I will try to do this on my server with 2.2.6.  How big
>> is your repository?  Both size and commit number.
>>
>> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
Thomas Pasch

--------------------------------------------------------------------
Jentro Technologies GmbH
Thomas Pasch
Entwicklung
--------------------------------------------------------------------
Rosenheimer Strasse 145e, D-81671 Munich, Germany
N 48=C2=B007'19", E 11=C2=B036'18"
http://www.jentro.com
Managing Directors: Dr. Hans-Hendrik Puvogel, Erno Hempel
Trade register Munich HRB 148653
--------------------------------------------------------------------
Tel. +49 89 189 169 80
=46ax +49 89 189 169 99
thomas.pasch@jentro.com
--------------------------------------------------------------------
NOTICE: The information contained in this e-mail is confidential or
may otherwise be legally privileged. It is intended for the named
recipient only. If you have received it in error, please notify us
immediately by reply or by calling the telephone number above and
delete this message and all its attachments without any use or
further distribution of its contents. Please note that any
unauthorised review, copying, disclosing or otherwise making use of
the information is strictly prohibited. Thank you.
--------------------------------------------------------------------
