From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 23 Jul 2008 14:24:21 +0200
Message-ID: <488722F5.9030602@free.fr>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882454D.2080500@free.fr> <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org> <4884917A.1060005@free.fr> <7vk5fdiheh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 14:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLdPc-0005w4-Ok
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 14:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbYGWMYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 08:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbYGWMYY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 08:24:24 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:60745 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573AbYGWMYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 08:24:24 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id E500812B6D6;
	Wed, 23 Jul 2008 14:24:22 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D3E0D12B6FC;
	Wed, 23 Jul 2008 14:24:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7vk5fdiheh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89641>

Junio C Hamano a =E9crit :
>
>> diff --git a/git-am.sh b/git-am.sh
>> index 60aaa4a..864c77e 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -202,8 +202,15 @@ then
>>  	die "previous rebase directory $dotest still exists but mbox given=
=2E"
>>  	resume=3Dyes
>> =20
>> -	case "$abort" in
>> -	t)
>> +	case "$skip,$abort" in
>> +	t,)
>> +		git rerere clear
>> +		git read-tree --reset -u HEAD HEAD
>> +		orig_head=3D$(cat "$GIT_DIR/ORIG_HEAD")
>> +		git reset HEAD
>> +		git update-ref ORIG_HEAD $orig_head
>> +		;;
>=20
> Sorry, I do not quite understand what this reset after the read-tree =
dance
> is trying to do; you have already reset the index to the tree in HEAD=
 when
> you cleared the change involved in the patch application with that
> two-tree form of read-tree.

I add reset to unstage paths with no conflict that are left behind. Per=
haps
read-tree can clear those paths as well but I do not know how, the man =
page
is hard to follow.

--=20
Olivier.
