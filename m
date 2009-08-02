From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Adding files to a git-archive when it is generated, and whats
 the 	best way to find out what branch a commit is on?
Date: Sun, 02 Aug 2009 15:52:33 +0200
Message-ID: <4A759A21.7070806@lsrfire.ath.cx>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>	 <4A720393.6030607@lsrfire.ath.cx> <9b18b3110907310304w261ee30bw8c06c6a65e936e6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 15:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXbUl-0005QG-Nn
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 15:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZHBNwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Aug 2009 09:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbZHBNwl
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 09:52:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:52101 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbZHBNwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 09:52:41 -0400
Received: from [10.0.1.101] (p57B7F321.dip.t-dialin.net [87.183.243.33])
	by india601.server4you.de (Postfix) with ESMTPSA id B9E912F8043;
	Sun,  2 Aug 2009 15:52:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <9b18b3110907310304w261ee30bw8c06c6a65e936e6e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124672>

demerphq schrieb:
> 2009/7/30 Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
>> demerphq schrieb:
>>> So then git also would benefit from support in git-archive for addi=
ng
>>> arbitrary files to the archive during generation?
>> Yes, and this has come up before.
>>
>> How about the following?  It's missing documentation and a test case=
,
>> but you could try
>>
>>        $ git archive --add-file extra HEAD >HEAD+extra.tar
>>
>> or
>>
>>        $ git archive --prefix=3Da/ --add-file extra --prefix=3Db/ HE=
AD >ba.tar
>>
>> Only the file name part (after the last slash) of the extra file is =
used,
>> together with the prefix, to form the path of the archive entry.
>>
>> Opening the extra files when parsing the command line arguments and =
closing
>> them after they have been written into the archive is a bit iffy, bu=
t it's
>> impractical to report open errors after parts of the archive have al=
ready
>> been created.
>=20
> I havent managed to try it out yet but this is pretty much exactly
> what I was looking for. Only thought I had was that it might be nice
> to be able to specify what name the file should be added as so that
> you can add files to subpaths deeper than the root/root prefix of the
> tar. However for /my/ particular purposes that is unnecessary, it onl=
y
> occurs to me as a nice to have. But if you were inclined to think
> about extending it I was thinking an argument notation like --add-fil=
e
> foo:bar/baz/bop might be useful.

With the patch as-is, you can make a file named bop appear as
bar/baz/bop in the archive (by using a prefix of bar/baz/), but not as
foo.  I wonder how often one needs to rename a file while adding it to
the archive -- or indeed if this is needed at all.  Being lazy, I'd wai=
t
for such a case to appear before supporting it with a double-valued
command line argument.

Ren=E9
