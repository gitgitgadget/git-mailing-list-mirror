From: martinvz <martin.von.zweigbergk@gmail.com>
Subject: Re: Difference between pull --rebase and fetch+rebase
Date: Thu, 7 Jan 2010 10:44:24 -0800 (PST)
Message-ID: <1262889864880-4268064.post@n2.nabble.com>
References: <27059158.post@talk.nabble.com> <adf1fd3d1001070800k6fa501fej39b84f849b7e5b50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 19:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSxLT-0001LY-Rl
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab0AGSo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 13:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113Ab0AGSoZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:44:25 -0500
Received: from kuber.nabble.com ([216.139.236.158]:40176 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0AGSoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 13:44:25 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NSxLM-0004C7-Sb
	for git@vger.kernel.org; Thu, 07 Jan 2010 10:44:24 -0800
In-Reply-To: <adf1fd3d1001070800k6fa501fej39b84f849b7e5b50@mail.gmail.com>
X-Nabble-From: martinvz <martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136380>


Thanks for your post, Santi. I can not share my repository since it is =
a
project at work. I was troubleshooting a bit myself and found the follo=
wing
section in git-pull.sh:

	oldremoteref=3D"$(git rev-parse -q --verify "$remoteref")" &&
	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
	do
		if test "$reflog" =3D "$(git merge-base $reflog $curr_branch)"
		then
			oldremoteref=3D"$reflog"
			break
		fi
	done

Why is it that reflog entries are allowed to override the remote refere=
nce?


Thanks,
Martin



Santi B=C3=A9jar-2 wrote:
>=20
> On Thu, Jan 7, 2010 at 1:23 PM, martinvz
> <martin.von.zweigbergk@gmail.com> wrote:
>>
>> I have a branch configured to track a remote branch by rebasing. I
>> excepted
>> that "git pull" would therefore be equivalent to fetching from the r=
emote
>> repository followed by rebasing the remote branch, but it isn't. Whe=
n
>> doing
>> "git rebase <remote>/<branch>", it applies only the commits after th=
e
>> merge
>> base. When doing "git pull", it tries to apply two more commits (the=
 two
>> commits preceding the merge base). Why is this?
>>
>> I get the same result even if I do "git pull --rebase <remote> <bran=
ch>",
>> it
>> doesn't seem to have anything to do with incorrect configuration of =
the
>> branch.
>=20
> Yes, both should do the same (at least when upstream is not rebased).
> Can you provide a test case or instructions to reproduce the behavior=
?
>=20
> Thanks,
> Santi
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

--=20
View this message in context: http://n2.nabble.com/Difference-between-p=
ull-rebase-and-fetch-rebase-tp4266164p4268064.html
Sent from the git mailing list archive at Nabble.com.
