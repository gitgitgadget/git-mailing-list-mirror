From: demerphq <demerphq@gmail.com>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Sun, 2 Aug 2009 16:19:54 +0200
Message-ID: <9b18b3110908020719h79cf4872p9f284346cd6a185b@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
	 <4A720393.6030607@lsrfire.ath.cx>
	 <9b18b3110907310304w261ee30bw8c06c6a65e936e6e@mail.gmail.com>
	 <4A759A21.7070806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 02 16:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXbv0-0005TH-MU
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 16:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbZHBOUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Aug 2009 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbZHBOUA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 10:20:00 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:60812 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbZHBOTy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Aug 2009 10:19:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so3815025and.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 07:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zvbXliL3cvrdlkuKlDY7rxWMG/Nr1fvtkdrdTrduRi4=;
        b=UJ8iUZ1GCP80mUsgzxe/WhICwVw0kmPEFVYunTpiWH78s4MsdegeKUGDS0lHL03iEd
         kLYzjVBIM29ZT2vMnGysvSecbqeirwRa0OiAO1BH/eKwqxa2dizfW2WwvHz1947KHb18
         2qVXfXzPUZG8XrvfYgGIDmn1HMGjuvNm028yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DQEcTVpHLYKs/ggycy9+rfXO5tctZ130SSpHSlq9vQ7wXQUYQ2DCQaQ4PnGFLq3YOt
         /jKYWGd8Koa3MTGe/VpVlTtg+8Wg8Io104/fyuEUPSvVDtv6VrInTrIjtzo2SWjYWMBH
         nQ/Rb7rGYRuxorj/oRURkjbmRiA4zmC6PNc60=
Received: by 10.231.37.77 with SMTP id w13mr1237365ibd.3.1249222794151; Sun, 
	02 Aug 2009 07:19:54 -0700 (PDT)
In-Reply-To: <4A759A21.7070806@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124673>

2009/8/2 Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
> demerphq schrieb:
>> 2009/7/30 Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
>>> demerphq schrieb:
>>>> So then git also would benefit from support in git-archive for add=
ing
>>>> arbitrary files to the archive during generation?
>>> Yes, and this has come up before.
>>>
>>> How about the following? =A0It's missing documentation and a test c=
ase,
>>> but you could try
>>>
>>> =A0 =A0 =A0 =A0$ git archive --add-file extra HEAD >HEAD+extra.tar
>>>
>>> or
>>>
>>> =A0 =A0 =A0 =A0$ git archive --prefix=3Da/ --add-file extra --prefi=
x=3Db/ HEAD >ba.tar
>>>
>>> Only the file name part (after the last slash) of the extra file is=
 used,
>>> together with the prefix, to form the path of the archive entry.
>>>
>>> Opening the extra files when parsing the command line arguments and=
 closing
>>> them after they have been written into the archive is a bit iffy, b=
ut it's
>>> impractical to report open errors after parts of the archive have a=
lready
>>> been created.
>>
>> I havent managed to try it out yet but this is pretty much exactly
>> what I was looking for. Only thought I had was that it might be nice
>> to be able to specify what name the file should be added as so that
>> you can add files to subpaths deeper than the root/root prefix of th=
e
>> tar. However for /my/ particular purposes that is unnecessary, it on=
ly
>> occurs to me as a nice to have. But if you were inclined to think
>> about extending it I was thinking an argument notation like --add-fi=
le
>> foo:bar/baz/bop might be useful.
>
> With the patch as-is, you can make a file named bop appear as
> bar/baz/bop in the archive (by using a prefix of bar/baz/), but not a=
s
> foo. =A0I wonder how often one needs to rename a file while adding it=
 to
> the archive -- or indeed if this is needed at all. =A0Being lazy, I'd=
 wait
> for such a case to appear before supporting it with a double-valued
> command line argument.

Well I was kinda thinking the case of a snapshot generator on
something like gitweb.

In that case you could have multiple processes trying to create the
same snapshot.

One solution is to do the work in a process specific temporary
directory with the correct name and then add it that way.

A slightly nicer approach is create the file in a common working
directory with a temporary name and then have it added to the archive
with a different name. This is actually the approach I used by
exploiting the the --transform option to tar. So while it might appear
my request is a YAGNI it is actually a IADNI (I Already Did Need It).

Even nicer and cleaner of course would be support something like
"--add-file -=3D.patch"  with the "-" meaning "read from STDIN", which
then means temporary files can be avoided, assuming one only needs to
add a single file to the archive. This is particularly nice if the
content of  the file can be generated from the output of something
like git-describe or git rev-parse or any generic tool.

So IMO actually this functionality would be very useful, and isnt so
weird when you think of it in context of generating snapshots for a
"git aware" build process.

Of course this is all very easy for me to say as a back-seat driver. :-=
)

cheers,
Yves




--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
