From: =?UTF-8?B?R3LDqWdvcnkgUm9tw6k=?= <gregory.rome@maxim-ic.com>
Subject: Re: git bisect Vs branch
Date: Fri, 23 Oct 2009 11:24:21 +0200
Organization: Maxim Integrated Products
Message-ID: <4AE17645.2000408@maxim-ic.com>
References: <4AE07EEB.2010101@maxim-ic.com> <adf1fd3d0910220950s50ccf8efwda891374e6480a30@mail.gmail.com> <4AE156A9.9060809@maxim-ic.com> <4AE16A82.1010103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?B?U2FudGkgQsOpamE=?= =?UTF-8?B?cg==?= <santi@agolina.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 23 11:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1GNt-0008Mb-GP
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 11:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbZJWJYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 05:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZJWJYX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 05:24:23 -0400
Received: from smtp06.msg.oleane.net ([62.161.4.6]:43234 "EHLO
	smtp06.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbZJWJYX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 05:24:23 -0400
X-Greylist: delayed 63325 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2009 05:24:22 EDT
Received: from zebulon.innova-card.com (6-61.252-81.static-ip.oleane.fr [81.252.61.6]) (authenticated)
	by smtp06.msg.oleane.net (MTA) with ESMTP id n9N9ONH1013177;
	Fri, 23 Oct 2009 11:24:23 +0200
X-Oleane-Rep: REPA
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 23 Oct 2009 11:24:21 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4AE16A82.1010103@viscovery.net>
X-Spam-Flag: NO
X-PMX-Spam: Probability=8%
X-PFSI-Info: PMX 5.5.5.374460, Antispam-Engine: 2.7.1.369594, Antispam-Data: 2009.10.23.91218 (no antivirus check)
X-Orange-Auth: dG9zbXRwQGZyLm9sZWFuZS5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131103>

Thanks even if that's what scared me :)
The draw is very simple comparing to the reality (much more merge point=
s) and=20
rebase will require lot of conflicts resolutions but now I'm sure that'=
s what I=20
have to do.

Gr=C3=A9gory

Johannes Sixt wrote:
> Gr=C3=A9gory Rom=C3=A9 schrieb:
>> Thanks Santi but I have a problem, due to the fact that the commit w=
hich
>> has an impact on my code is in origin/master or first-origin/master
>>
>> When bisect checkout a commit from those branch I have none of my ow=
n
>> modifications... So I can' test if my code is good or bad excepted i=
f I
>> can merge my commits in the bisect branch...
>>                                                    =E1=90=81
>> first-origin/master  *---A---------B----------------o------C-
>>                           \         \                       \
>> origin/master              ----------B'----------U-----------C'-
>>                                       \           \           \
>> master                                 ------------U'----------C''-
>=20
> C" is the commit that merges upstream changes into your changes. You =
are
> saying that your changes alone (before the merge) are good, and that
> upstream before the merge is also good (since it doesn't contain your
> changes, it is good by definition, more or less). That indeed means t=
hat
> the merge commit is the first bad one; i.e., this is exactly the situ=
ation
> that the user manual describes.
>=20
> You should do:
>=20
>   $ git checkout -b tmp master   # master is at C"
>   $ git rebase origin/master
>   $ git bisect start tmp orgin/master
>=20
> That is, you rebuild your history on top of origin/master in a linear
> fashion. (If you had merge conflicts in U', then you will see them ag=
ain.)
> Then you bisect the linearized history. This will point you to the ba=
d
> commit and you will understand what is going wrong.
>=20
> With this new knowledge, go back to master (C") and fix the problem.
>=20
> -- Hannes
>=20
