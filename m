From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 1/2] grep: add option to show whole function as context
Date: Tue, 02 Aug 2011 20:08:50 +0200
Message-ID: <4E383D32.5090604@lsrfire.ath.cx>
References: <4E357BE2.8030409@lsrfire.ath.cx> <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com> <4E36C840.9000808@lsrfire.ath.cx> <CAGdFq_go0xYy9BZWRDxAFGV95G7V-P9-=7VhsodLd+z-ho09Qw@mail.gmail.com> <4E36E075.20603@lsrfire.ath.cx> <7vei14hgcd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 20:09:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoJOl-0005f3-Iv
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 20:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab1HBSIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 14:08:55 -0400
Received: from india601.server4you.de ([85.25.151.105]:47911 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab1HBSIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 14:08:53 -0400
Received: from [192.168.2.104] (p4FFDA3FA.dip.t-dialin.net [79.253.163.250])
	by india601.server4you.de (Postfix) with ESMTPSA id 1282A2F8035;
	Tue,  2 Aug 2011 20:08:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vei14hgcd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178492>

Am 02.08.2011 01:17, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Add a new option, -W, to show the whole surrounding function of a ma=
tch.
>=20
> Thanks, will queue both patches.
>=20
> It feels somewhat dirty to take the range between the previous "funcn=
ame"
> and the next "funcname" and consider it the whole function, as if the=
re is
> nothing outside the function, though. I certainly understand that thi=
s is
> a natural and unfortunate consequence that "funcname" is a mechanism
> designed to mark only the _beginning_, and we didn't have any need fo=
r a
> mechanism to mark the _end_.
>=20
> I am not complaining; just making an observation.  I do not offhand h=
ave a
> suggestion for improving this, and I think the obvious "then let's co=
me up
> with another configuration to mark the end" is not an improvement but
> making things worse, so...

A certain amount of dirtyness is unavoidable unless we use a real
parser.  Apropos, labels are function boundaries as well, so there we
have another limitation (i.e. we won't get a function whole if it
contains labels without leading whitespace).

Ideally I'd like to see the whole function text up to the closing brace
but including any leading comments, if present.  Which is even more
complicated, of course.

=46or C-style and Shell files, /^}/ would probably suffice as a regex t=
o
find function endings..

=46irst I'm curious to see how useful the simple start-to-start heurist=
ic
is, though.  Even the -[ABC] options are kind of fuzzy -- how do you
know the number is high enough before running grep?  Let's see how far
this quick and dirty approach to present a smarter context can take us.

Ren=C3=A9
