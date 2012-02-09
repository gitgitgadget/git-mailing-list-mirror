From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] git-svn.perl: perform deletions before anything else
Date: Thu, 9 Feb 2012 21:55:46 +0100
Message-ID: <87bop7rajx.fsf@thomas.inf.ethz.ch>
References: <1328813725-16638-1-git-send-email-stevenrwalter@gmail.com>
	<87mx8rrf5i.fsf@thomas.inf.ethz.ch>
	<CAK8d-aJ3wi0e_NPunow-aBnhs1=o5K25r3e-Ha0m1U0ujTv7OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <normalperson@yhbt.net>, <git@vger.kernel.org>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 21:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvb23-0001Dz-1V
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 21:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212Ab2BIUzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 15:55:49 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:41959 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab2BIUzt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 15:55:49 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 9 Feb
 2012 21:55:43 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 9 Feb
 2012 21:55:45 +0100
In-Reply-To: <CAK8d-aJ3wi0e_NPunow-aBnhs1=o5K25r3e-Ha0m1U0ujTv7OA@mail.gmail.com>
	(Steven Walter's message of "Thu, 9 Feb 2012 15:45:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190321>

Oops, as Steven noticed I accidentally hit the wrong reply button.  So
here's my earlier reply and his answer.

Steven Walter <stevenrwalter@gmail.com> writes:

> On Thu, Feb 9, 2012 at 2:16 PM, Thomas Rast <trast@inf.ethz.ch> wrote=
:
>> Steven Walter <stevenrwalter@gmail.com> writes:
>>
>>> If we delete a file and recreate it as a directory in a single comm=
it,
>>> we have to tell the server about the deletion first or else we'll g=
et
>>> "RA layer request failed: Server sent unexpected return value (405
>>> Method Not Allowed) in response to MKCOL request"
>> [...]
>>> - =C2=A0 =C2=A0 my %o =3D ( D =3D> 1, R =3D> 0, C =3D> -1, A =3D> 3=
, M =3D> 3, T =3D> 3 );
>>> + =C2=A0 =C2=A0 my %o =3D ( D =3D> -2, R =3D> 0, C =3D> -1, A =3D> =
3, M =3D> 3, T =3D> 3 );
>>
>> You are making it delete first, but the original code seems to quite
>> deliberately put deletion after R (rename?). =C2=A0Are you sure you'=
re not
>> breaking anything else?
>
> No, I'm not 100% sure of that.
>
> In fact, looking at cf52b8f063 where this code seems to have started,
> it lists my case explicitly as one that subversion does not support:
>
> "a file is removed and a directory of the same name of the removed
> file is created."
>
> One thing that might make a difference is that the "file" that remove=
d
> was actually a symlink.  So either svn treats symlinks as a special
> case to that rule, or else the limitation the commit was meant to
> address is not present on recent versions of svn.  I can run some
> checks to see if that is the case.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
