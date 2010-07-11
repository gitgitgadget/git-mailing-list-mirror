From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 11 Jul 2010 09:48:12 +0100
Message-ID: <7414fff60758b3f60d69a1bbed49165e@212.159.54.234>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 10:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXsD1-0002r4-S7
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 10:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab0GKIsR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 04:48:17 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:58096 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375Ab0GKIsP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jul 2010 04:48:15 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 19EAA81A678A;
	Sun, 11 Jul 2010 09:48:14 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id D621C2262D5;
	Sun, 11 Jul 2010 09:48:13 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6p4mHVS7n6Hx; Sun, 11 Jul 2010 09:48:13 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 990511EC0BA;
	Sun, 11 Jul 2010 09:48:12 +0100 (BST)
In-Reply-To: <201007110916.29567.jnareb@gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150769>

On Sun, 11 Jul 2010 09:16:26 +0200, Jakub Narebski <jnareb@gmail.com>
wrote:
> Dnia niedziela 11. lipca 2010 08:55, Clemens Buchacher napisa=C5=82:
>> On Sat, Jul 10, 2010 at 02:57:35PM -0700, Jakub Narebski wrote:
>> >=20
>> > It's unfortunately not so easy.  The problem you have to solve is =
D/F
>> > conflict: if you have 'foo/bar' branch, you can't create 'foo'
branch,
>> > but after deleting 'foo/bar' you want to be able to create 'foo'
>> > branch and reflog for 'foo' branch.
>>=20
>> I'm going to read up on Jonathan's pointers. But I do not really
>> see the problem above. If the reflog already exists, the new branch
>> simpliy continues using it. So if the branch is re-created, it's as
>> if the branch had never been deleted.
>=20
> The problem is, that when you have 'foo/bar' branch, then you have
> 'foo/bar' reflog.  When you delete branch 'foo/bar', but do not delet=
e
> 'foo/bar' reflog (only add to it branch deletion event), and then you
> want to create 'foo' branch, git wouldn't be able to create reflog
> fo 'foo' because of directory / file (D/F) conflict: there is 'foo/'
> directory preventing file 'foo' from being created.

You could just change the reflog code so that if foo is a directory it
looks for/creates foo/.reflog (the dot is to prevent a clash with a val=
id
branch name)?

>> Or possibly we add a special reflog entry which points the branch
>> to a zero sha to signify that the branch had been deleted.
>=20
> That is a good idea anyway.

--=20
Julian
