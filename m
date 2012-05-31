From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Finding a branch point in git
Date: Thu, 31 May 2012 17:27:59 +0200
Message-ID: <CAMP44s1Q26B9hCdubfDiP2_YUUWGOtyyA=gSwqpGOE4FfZrN8A@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
	<20120528062026.GB11174@sigill.intra.peff.net>
	<CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
	<20120528190639.GA2478@sigill.intra.peff.net>
	<CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
	<20120530215415.GB3237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 17:28:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa7IF-00016E-NR
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 17:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547Ab2EaP2B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 11:28:01 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34087 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487Ab2EaP2A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 11:28:00 -0400
Received: by lbbgm6 with SMTP id gm6so930752lbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XGpkhKM5wW95EIqBiJ9J6R3tAYtV3p6s7i2LDff1Nhs=;
        b=WWkS/W/nHP0R9v7xjT2zdY5Z3HHSDC7FlWP3MPHpAqgr3douep3zhf6nd9gwT4JOT2
         xvbRdjQlrGmLJ2HZgaRiCvhEapyjsia4RfI4GssGVLZkRUKfhYHL541fHI+4qy3szwLi
         a855vX/kY6PMeln/gAqKqhOkeLy+zIRMNR+OIckgvkWrgvSxpC/Y3C7+3xpeCoCvO5Ko
         aZFogN17hPjC2TFlZL0Z39FQJ8dJdl7xuiX9oOrZfI42dC3NiFfulOWG+lkuEuf/LcE4
         54g3xAovld9TFbVsIsDrJ+l+uKi1Ht9boR84SH8vOfBlxtowyHDUne97beQhkslsp34G
         O46w==
Received: by 10.152.108.38 with SMTP id hh6mr4026456lab.28.1338478079441; Thu,
 31 May 2012 08:27:59 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Thu, 31 May 2012 08:27:59 -0700 (PDT)
In-Reply-To: <20120530215415.GB3237@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198922>

On Wed, May 30, 2012 at 11:54 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 30, 2012 at 07:07:39PM +0200, Felipe Contreras wrote:
>
>> On Mon, May 28, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
>> > On Mon, May 28, 2012 at 02:36:04PM +0200, Felipe Contreras wrote:
>> >
>> >> > What about a history with multiple branches?
>> >> >
>> >> > --X--A--B--C--D----E =C2=A0(master)
>> >> > =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
>> >> > =C2=A0 =C2=A0 =C2=A0 G--H--I---J =C2=A0 (branch X)
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0/
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L =C2=A0 =C2=A0(bra=
nch Y)
>> >> [...]
>> >>
>> >> Yes, but then you would need to specify a second branch. I would =
avoid
>> >> that if possible.
>> >
>> > I agree that is less nice. But I don't think the operation is
>> > well-defined with a single branch. If you ask for "when did branch=
 X
>> > split", then in the above graph it is unclear if you meant "split =
from
>> > master", or "split from Y".
>>
>> If you look from the context that I explained in the first mail; it
>> would be from *any* branch; IOW; find the first commit from branch X
>> (G), and then find the parent. That would be the first commit where
>> branch X started.
>
> I'm not sure that's possible, though, in the face of criss-cross merg=
es.
> How do we distinguish the history above from one in which branch Y wa=
s
> forked from master at G, and then branch X was forked from branch Y a=
t
> H?

That is true, but we could use the algorithm used by name-rev: G would
have a distance 3 from branch X, and distance 2 from Y, so it would be
considered part of branch Y.

Sure, it's not possible to know _for sure_, but this is a bit like
renames; we don't really know if a file was renamed or not, but we can
make a good guess.

>> I think it would be easy to support this case if somehow there was a
>> way to find all the commits that comprise a branch;
>>
>> =C2=A0% git log branch ^<any-other-branch>
>>
>> I could swear I saw such an option, but I've been looking for days a=
nd
>> I can't find it.
>
> I don't think there is such an option. You have to do something like:
>
> =C2=A0{
> =C2=A0 =C2=A0echo "--not"
> =C2=A0 =C2=A0git for-each-ref --format=3D'%(refname)' | grep -v "^$br=
anch\$"

Rather:
git for-each-ref --format=3D'%(refname:short)' refs/heads | grep -v "^$=
branch\$"

> =C2=A0} |
> =C2=A0git rev-list --stdin $branch

Cheers.

--=20
=46elipe Contreras
