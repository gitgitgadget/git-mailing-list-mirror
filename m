From: David Kastrup <dak@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 08:06:48 +0200
Message-ID: <85ejfvh9tz.fsf@lola.goethe.zz>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710151859590.7638@iabervon.org>
	<uodezisvg.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, ae@op5.se, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfZ9-0000du-2q
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760930AbXJPGFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 02:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758202AbXJPGFy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:05:54 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:40633 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760162AbXJPGFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 02:05:53 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IhfYt-0007FP-Pr; Tue, 16 Oct 2007 02:05:51 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 15EE01C4D4B3; Tue, 16 Oct 2007 08:06:48 +0200 (CEST)
In-Reply-To: <uodezisvg.fsf@gnu.org> (Eli Zaretskii's message of "Tue\, 16 Oct 2007 06\:30\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61085>

Eli Zaretskii <eliz@gnu.org> writes:

>> Date: Mon, 15 Oct 2007 20:45:02 -0400 (EDT)
>> From: Daniel Barkalow <barkalow@iabervon.org>
>> cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de, ae=
@op5.se,=20
>>     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
>>=20
>> I believe the hassle is that readdir doesn't necessarily report a RE=
ADME in=20
>> a directory which is supposed to have a README, when it has a readme=
=20
>> instead.
>
> Sorry I'm asking potentially stupid questions out of ignorance: why
> would you want readdir to return `README' when you have `readme'?
>
>> I think we want O(n) comparison of sorted lists, which doesn't=20
>> work if equivalent names don't sort the same.
>
> You comparison function should be case-insensitive on Windows, or am
> I missing something?

Well, are "I" and "i" the same letters?  What about "=C4=B0" and "i"?  =
Or
"I" and "=C4=B1"?  What about Greek where uppercasing loses accents
(actually not unusual in literate French, either).  And what about
German =C3=9F and SS/SZ?

"case-insensitive" is a simple word, but the devil is in the details,
and that means basically requiring a system-provided sorting function.
And actually the _killer_ detail here is that git _must_ have the same
sorting order on every platform, since the order of files in a
directory tree affects its SHA-1 sum.  So a system-dependent sorting
order breaks git interoperability.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
