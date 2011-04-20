From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: problem when using --cc-cmd
Date: Wed, 20 Apr 2011 12:45:47 -0300
Message-ID: <BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	<20110419215239.GA22632@elie>
	<1303268630.24766.9.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCZbP-0005eh-MY
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 17:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab1DTPpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 11:45:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57551 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab1DTPps convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 11:45:48 -0400
Received: by wya21 with SMTP id 21so722059wya.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4NDmAdir+l6xHBfmctjYRSq5SIdRniq/Icaa5b/Q6HY=;
        b=q6vkaQUGrQcLPZhDM/C2BVXnP6kNFq5T8+DxIJ51t1ldnKTNOW+oxwm/pOJXyI4HhS
         1bLRz5tOPLqykYBybqZrZf8MahOYzJOS540WdPshe2fbBTiaDgInVuphaPu5nxhO60KY
         +KYF2PWexru3odcJki1KmtF53x+a+hXanj3bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b+Vte8HiMqkjF0/7xEoZafpM8owxrhPmty4+YpJAVWDl6QWaP2zssoiXK2SG9hYhnh
         J4PD4BC/lDy+9I3oAT+146IwYEx46sSN2q9TZMp883bXHconALXOTYs46ilRkGEJyidA
         fbwV1O6hQM/YBs6Pe59ZnbAJzM8FG2YD8djr0=
Received: by 10.216.188.20 with SMTP id z20mr2833372wem.66.1303314347607; Wed,
 20 Apr 2011 08:45:47 -0700 (PDT)
Received: by 10.216.175.73 with HTTP; Wed, 20 Apr 2011 08:45:47 -0700 (PDT)
In-Reply-To: <1303268630.24766.9.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171868>

On Wed, Apr 20, 2011 at 12:03 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2011-04-19 at 16:52 -0500, Jonathan Nieder wrote:
>> Thiago Farina wrote:
>> > when I run:
>> > $ git send-email --to linux-kernel@vger.kernel.org --cc-cmd
>> > scripts/get_maintainer.pl foo
>> > I'm getting some lines like:
>> > Use of uninitialized value $cc in string eq at
>> > /home/tfarina/libexec/git-core/git-send-email line 964.
>> Yes, sounds like a bug. =C2=A0Cc-ing some send-email people for tips=
=2E
>
> I haven't seen this.
>
> What versions of ./scripts/get_maintainer.pl and git are
> you using?
>

$ scripts/get_maintainer.pl --version
scripts/get_maintainer.pl 0.26

$ git version
git version 1.7.5.rc2.5.g60e19

>> On the other hand, using --cc-cmd=3Dscripts/get_maintainer.pl does n=
ot
>> sound like a great idea to me. =C2=A0On one hand the output of
>> get_maintainer.pl is not an unadorned address per line like --cc-cmd
>> expects. =C2=A0On the other hand, at least some versions of
>> get_maintainer.pl returned more addresses than are likely to be
>> interested people (by using --git by default).
>>
>> I think get_maintainer.pl is meant to be a starting point for tracki=
ng
>> down who might be interested in a patch and should be followed by
>> careful investigation. =C2=A0(That means making sure that there is a
>> reasonable number of people and the reasons given by --roles ouput
>> make sense, and maybe even glancing at some messages by them from th=
e
>> relevant mailing list to make sure the script has not gone haywire.)
>
> Jonathan is basically correct in the what he writes above.
>
> I also think git history isn't a very good mechanism to
> rely on for determining MAINTAINERS, it should only be a
> fallback to determine who should receive a copy of a patch.
>
> That said, I use scripts/get_maintainer.pl to generate
> to's and cc's. =C2=A0I do not use --git or --git-fallback
> and rely only on the MAINTAINERS file pattern matching.
>
> Here are the settings I use:
>
Cool, thanks for sharing it. I'll add that to my config file.

> $ cat ~/.gitconfig
> [sendemail]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chainreplyto =3D false
> =C2=A0 =C2=A0 =C2=A0 =C2=A0thread =3D false
> =C2=A0 =C2=A0 =C2=A0 =C2=A0suppresscc =3D self
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tocmd =3D ~/bin/to.sh
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cccmd =3D ~/bin/cc.sh
>
> $ cat ~/bin/to.sh
> #!/bin/bash
>
> opts=3D"--nogit --nogit-fallback --norolestats --pattern-depth=3D1"
>
> if [[ $(basename $1) =3D~ ^0000- ]] ; then
> =C2=A0 =C2=A0./scripts/get_maintainer.pl --nom $opts $(dirname $1)/*
> else
> =C2=A0 =C2=A0maint=3D$(./scripts/get_maintainer.pl --nol $opts $1)
>
> =C2=A0 =C2=A0if [ "$maint" =3D=3D "" ] ; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "linux-kernel@vger.kernel.org"
> =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "$maint"
> =C2=A0 =C2=A0fi
> fi
>
> $ cat ~/bin/cc.sh
> #!/bin/bash
>
> opts=3D"--nogit --nogit-fallback --norolestats"
>
> if [[ $(basename $1) =3D~ ^0000- ]] ; then
> =C2=A0 =C2=A0./scripts/get_maintainer.pl --nom $opts $(dirname $1)/*
> else
> =C2=A0 =C2=A0./scripts/get_maintainer.pl $opts $1
> fi
>
>
>
>
