From: Shantanu Pavgi <pavgi@uab.edu>
Subject: Re: removing files from history but not filesystem
Date: Wed, 29 Jun 2011 16:45:04 -0500
Message-ID: <9ACDCDFD-6A29-4F1E-AE9C-BA9C5143840D@uab.edu>
References: <CFCCFA00-B4BF-4A88-88A5-2F588630F7BB@uab.edu>
 <218bf1d3b2bf197a5f56d542c6a91960.squirrel@mail.localhost.li>
 <D56E9579-BD93-42AC-BA45-E0DC20F4BB48@uab.edu>
 <1309327707.2417.49.camel@oxylap>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Christof_Kr=FCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Wed Jun 29 23:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc2ZQ-00076B-Ht
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 23:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1F2VpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jun 2011 17:45:12 -0400
Received: from uabexht1.ad.uab.edu ([138.26.5.101]:54180 "EHLO
	UABEXHT1.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab1F2VpK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2011 17:45:10 -0400
Received: from UABEXMBS5.ad.uab.edu ([138.26.5.38]) by UABEXHT1.ad.uab.edu
 ([138.26.5.101]) with mapi; Wed, 29 Jun 2011 16:45:05 -0500
Thread-Topic: removing files from history but not filesystem
Thread-Index: Acw2pc4bWw5PJtm0QLSDW2THyhIZNg==
In-Reply-To: <1309327707.2417.49.camel@oxylap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176461>


On Jun 29, 2011, at 1:08 AM, Christof Kr=FCger wrote:

> Hi
>=20
>> Thanks for the reply Chris. It worked for me. I am not following las=
t
>> command "git reset <branch-name>" though. I have used SHA1 commit
>> object names in 'git reset' command, but I am not sure how <commit> =
is
>> using branch name here. Is  it because branch is a commit pointer in
>> the git history?=20
> While being on the master branch, issuing "git reset temp" tells git =
to
> "let the master branch point to wherever the symbolic reference temp
> points now". =20
> You did something very similar with git filter-branch already. There =
you
> specified HEAD~1, which is the same as telling git to dereference the
> symbolic ref "HEAD" and take its first parent. I don't know any place
> where git wouldn't accept symbolic references instead of raw sha1 sum=
s.
>=20
>> Also, how do I specify rev-list HEAD-1 so that 'git rm' will be run =
on
>> all commits excepts latest commit? Following didn't work for me, so =
I
>> guess I am not following syntax here.
>> {{{ $ git filter-branch
>> --index-filter 'git rm --cached --ignore-unmatch apple' HEAD~1
>> Which ref do you want to rewrite?
>> }}}
> git filter-branch expects a symbolic reference within the rev-list. I=
t
> would be pointless to filter the commits without a symbolic reference
> being bent over to point to the rewritten branch once done.
>=20
> What you can do is the following:
>=20
> git filter-branch --index-filter 'test $GIT_COMMIT =3D
> 35644cb5fa34e033593f6f0d27c332443b6867d8 || git rm --cached
> --ignore-unmatch foo' HEAD
>=20
> If "test $GIT_COMMIT =3D <sha1>" is true, the following git rm comman=
d
> won't be executed for that commit.=20
> Choose the hash to be the one you want to skip (HEAD).
>=20
> Another possible way would be to create a temporary branch to point a=
t
> HEAD^, filter-branch it, then add a graft to stitch the remaining com=
mit
> on top of it, then filter-branch HEAD and then remove the branch. But
> this is a bit advanced for the case where you just want to omit one
> commit.
>=20
> Regards,
>  Chris
>=20
> --


Thanks for explaining it in detail Chris. That's really helpful.=20

--
Shantanu.=20
