From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 12:46:44 +0100
Message-ID: <7C01ADFC-6D1D-403F-A917-DBF289AF754C@wincent.com>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com> <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> <7vejchkp6o.fsf@gitster.siamese.dyndns.org> <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com> <alpine.LSU.1.00.0801171106510.17650@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 12:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFTDY-0007m1-1w
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 12:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbYAQLrD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 06:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbYAQLrB
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 06:47:01 -0500
Received: from wincent.com ([72.3.236.74]:35607 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbYAQLrB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 06:47:01 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0HBkjGQ020281;
	Thu, 17 Jan 2008 05:46:46 -0600
In-Reply-To: <alpine.LSU.1.00.0801171106510.17650@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70850>

El 17/1/2008, a las 12:10, Johannes Schindelin escribi=F3:

> On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
>
>> And what do we do when asked to check out a tree which has two =20
>> different
>> files in it whose normalized forms are the same (ie. a clone of a =20
>> repo
>> created on a non-HFS+ filesystem)?
>>
>> We either have to fail catastrophically, preventing the user from
>> working with that tree on HFS+, or arbitrarily pick one of the =20
>> files as
>> the "winner" which gets written out into the work tree. None of the
>> options is particularly attractive, although luckily this exact
>> situation is unlikely to come up in practice.
>
> Anything else but failure would be Not What You Want.  You might =20
> want a
> special mode where you use a _different_ name on-disk (something =20
> like the
> infamous short names on FAT), but that _must_ be turned off by =20
> default:
> think of Martin's HEAD example.  Sometimes, it's just not possible to
> check such a tree out on a less-than-nice system.

Such a special mode would be mostly useless in most contexts, where =20
Git is used to track source code. It would enable you to check out the =
=20
tree for inspection, but you probably couldn't build anything from it =20
seeing as at least one of the filenames specified in your Makefile =20
wouldn't be present in the work tree.

As such, in that kind of situation I'd rather see a big red warning =20
printed out that the checkout failed because a particular file =20
couldn't be written out, and perhaps an instruction to the user that =20
they can use "git show" if they want to see the blob/s which wasn't/=20
weren't written.

Cheers,
Wincent
