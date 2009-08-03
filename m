From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: From P4 to Git
Date: Mon, 3 Aug 2009 15:50:14 +0200
Message-ID: <81b0412b0908030650oc39f4a3s7c059e300b65addb@mail.gmail.com>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain>
	 <85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com>
	 <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com>
	 <4A76967B.7080502@vilain.net>
	 <81b0412b0908030147i34a7440dg982c7a6e7dc51bca@mail.gmail.com>
	 <1249299010.7164.8.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 15:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXxvn-0004cn-F2
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 15:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbZHCNuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbZHCNuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 09:50:16 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50626 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891AbZHCNuP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 09:50:15 -0400
Received: by bwz19 with SMTP id 19so2443625bwz.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qyYctIAOKdYdG1k0eB/wjG4MEz1A54BFHGMfyCkC/o4=;
        b=JsGHN5bdHWy/6Hj/Eg3BqwwjnLihOk3IQzFGb0luLHzOXq4gTGZ1OhFZPV6l9cwgcR
         Q9egYLAZ1iIn8OmwtlDHrjzObVqb9T1c7gZBfzHFMnNJr1Bn0XaDu9KFsmqzcrLDecaT
         oOR6K201vOS5mrxsk1qstV2y095yv8JJoGoRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f7N1WhFUvyViQHTqNqBCQInqSti93wdOXNiqLqteFiCILy57Suze9xBAW9mqHOYUix
         2rQh17ZfU5AmBDgfJGS3LHxWsfW76zWMsh7+me4q8IYGG9jTWTXgEk3hyj/7cZKQAbzA
         YeFNJVY4tbd7H4KW55cjh1TeuyOyA/jExteO4=
Received: by 10.204.54.80 with SMTP id p16mr5688375bkg.115.1249307414822; Mon, 
	03 Aug 2009 06:50:14 -0700 (PDT)
In-Reply-To: <1249299010.7164.8.camel@maia.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124694>

On Mon, Aug 3, 2009 at 13:30, Sam Vilain<sam@vilain.net> wrote:
> On Mon, 2009-08-03 at 10:47 +0200, Alex Riesen wrote:
>> Is it an import-once tool, or can the process be restarted? (because=
 it looks
>> like the script needs a complicated setup).
>
> It's fully restartable. =C2=A0Not only that but it uses transaction
> protection to make sure that its internal state doesn't get corrupted
> when performing the various options.

"varios options"? Operations? As when working on a live server?
Aren't P4 changelist numbers always increasing? Or you mean
the protection against multiple running instances of p4raw,
so it is also parallelizable?

>> Can it be used from a client machine?
>> =C2=A0And more importantly:
>> can the branches be found from incomplete history,
>> restricted by path and changelist range? (because, in a corporate
>> setup, clients seldom have full access to all data).
>
> No, it's server only. ...

Darn. I hoped it wasn't. Can't play with it, then.

> ...=C2=A0I think I did get around to implementing not having
> to go through all the stages for branches you didn't care to import. =
=C2=A0It's
> difficult though, the stage which correlates those thousands of 'inte=
grate'
> records is never going to be fast.

Maybe if it is done locally, it can be improved? You seem to use the
Postgre for lookups, right?

>=C2=A0Be prepared to tune your postgres - add lots of shared_buffers a=
nd
> sort memory if your project is as large as Perl.

Mine isn't, but it is thrown on a server with a lot of others. Some bra=
nched
off mine, some integrate it, some just copied and re-introduced into re=
pository
(these will probably worked with manually forever). There is also a sma=
ll
problem of different P4 servers, hosting code from the same project (th=
ey
pull different repos together on client, imagine that!)

And all of them go back for 5-6 years, so it is kind of largish (not to=
 mention
a mess of binaries).

Some branches I hope to merge back. I do that already, but it is a lot =
of
manual work (I use that git-p4-import.bat I posted early, which only ca=
n
import a sequence of changelists with files they touch).

That's were I hoped your project could help. I thought, if I pull in al=
l the
needed changelists (selected by path/CL), there may be a way to
recreate a mergeable history out of this dump. At least, one involving =
less
labor then I have to do now.
