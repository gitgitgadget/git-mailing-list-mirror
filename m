From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Fri, 14 May 2010 08:54:07 +0200
Message-ID: <AANLkTilkFHK1UIvSLEstXFIOJTsit02EZe1Wsoj_zRRX@mail.gmail.com>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com> 
	<20100505050640.GC8779@coredump.intra.peff.net> <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com> 
	<20100512133537.GA28956@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 14 08:54:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OConF-0003SP-9L
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 08:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab0ENGya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 02:54:30 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:50543 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab0ENGy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 02:54:29 -0400
Received: by ewy8 with SMTP id 8so771471ewy.28
        for <git@vger.kernel.org>; Thu, 13 May 2010 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TlCXYSRTCXFUU7FMVQpeOdraAgBas/uP1PDf8oz7kPg=;
        b=hMfJ6zgOYAVTZraCfNIsYQfAuiK3Y7zPFVxhzcJ/MjL98S6r6FPGrSuMGG4L99Dq6E
         +xKpdUOCBIxvI6sxKkmTLeMqOXUnO9b9u98RIhMDGKh5GeUt7S/+ndl4pltXE55D+qDf
         CBwPh9uv4mCSwc8fiZ396wbC/YbrQc3NfzJfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ujn9LkN2CwLBXke09w52rbp7yT5jMOnVokXLAwWB1A92NtafAk5zL4hDdvYrIVE6Vr
         IGfN93ivuIuiQZyVTuMyvpkhjpCBFoE9EdnpMXVE5nUGt3eZUzrIJqm2wRO6uFn+l3a/
         3pj0tpyCvz+JgrmprrC2fysa5Beh9JN8chVN0=
Received: by 10.213.79.11 with SMTP id n11mr158963ebk.28.1273820067153; Thu, 
	13 May 2010 23:54:27 -0700 (PDT)
Received: by 10.213.8.210 with HTTP; Thu, 13 May 2010 23:54:07 -0700 (PDT)
In-Reply-To: <20100512133537.GA28956@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147053>

On Wed, May 12, 2010 at 3:35 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 06, 2010 at 02:24:41PM +0200, Knittl wrote:
>
>> =A0- initial commit is also printed when there is tracking informati=
on
>> (i still haven't managed to create a situation like that. `git branc=
h
>> oldmaster; rm .git/refs/heads/master; git branch master --set-upstre=
am
>> oldmaster` will reset branch master to oldmaster (a bug?))
>
> Try:
>
> =A0git branch oldmaster
> =A0rm .git/refs/heads/master
> =A0git config branch.master.remote .
> =A0git config branch.master.merge refs/heads/oldmaster
>
> That being said, I still get "Initial commit on master". I think that
> stat_tracking_branch just gives up if the branch doesn't exist (which
> does make some sense). So in practice, I think your original and this
> one actually behave the same (sorry, I know that changing it was my
> suggestion).
>
> And no, the "--set-upstream" behavior is not a bug. At least not
> according to the documentation. ;)

yep, that's what i discovered too=97but i don't care if this condition
is 3 lines up or down. if stat_tracking_branch decides it will work
for initial commits, then this code will do the expected thing

>> =A0- colors to match output of `git branch` (green: current, red: re=
mote)
>> =A0- output format is copy-pasteable, ahead/behind information is in=
 the
>> same format as in `git branch -v`
>
> I think it's much nicer, though the colors are a bit much for my liki=
ng.
> Still, it's configurable, so I don't have to care. :)

i find the numbers quicker to spot when they are a different color
from normal text, but if the majority objects i can remove them of
course.

>> =A0- branch information is still printed by default, i have to look =
into
>> commandline option parsing first. i was thinking of `git status -v -=
b`
>> (as in `git checkout -b` to mean branch)
>
> You may also want to have a configuration option if it is the output =
you
> prefer all the time (similarly, if you are using "git status -s" all =
the
> time, you might want a config option to make "git status" do what you
> want).

on my local system i have `alias.st =3D git status -sb`, so i don't
really find a need to make a config option. actually i fall into both
groups you described in your first answer: having a quick glance what
files were changed and grouping files based on status. so i write both
`git st` and `git status` quite often (also with `git stat` my alias
for `git diff --stat` to see what changed content-wise)

>> ---------8<----------------
>> From 82b4481d38ae0cd62030aeea67160656b7c763e2 Mon Sep 17 00:00:00 20=
01
>> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
>> Date: Tue, 20 Apr 2010 22:40:54 +0200
>> Subject: [PATCH] Show branch information in short output of git stat=
us
>
> This patch looks OK, but:
>
> =A01. I think for the final version you can just squash in part 2/2.

should be no problem. the second patch changed quite a bit, so i
thought it is easier to review when i send it as a separate patch. the
final patch can be squashed of course

> =A02. Your patch has wrapped lines which make it impossible to apply
> =A0 =A0 without fixing up manually. This is a common gmail problem. =A0=
See
> =A0 =A0 the "gmail" section of SubmittingPatches.

ok, browsed through that. i think i will just put my branch into a
pasteservice or on a fileserver, unless the email way is *really*
preferred=97what about email attachments?

cheers, daniel

--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
