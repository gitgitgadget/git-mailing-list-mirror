From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native 
	fetches
Date: Sat, 25 Jul 2009 15:08:49 -0600
Message-ID: <f488382f0907251408q383a7789l5342c7ec41b402a@mail.gmail.com>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
	 <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 23:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoUQ-0005OV-6x
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbZGYVIu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 17:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZGYVIu
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:08:50 -0400
Received: from mail-yx0-f198.google.com ([209.85.210.198]:48088 "EHLO
	mail-yx0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbZGYVIt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 17:08:49 -0400
Received: by yxe36 with SMTP id 36so1289743yxe.33
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 14:08:49 -0700 (PDT)
Received: by 10.90.34.10 with SMTP id h10mr4299388agh.31.1248556129499; Sat, 
	25 Jul 2009 14:08:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124073>

On Sat, Jul 25, 2009 at 12:25 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
>
> On Sat, 25 Jul 2009, Daniel Barkalow wrote:
>>
>> This is similar to, but different from, my git-vcs-* stuff; this one
>> expects the helper to be able to look up sha1s for refs efficiently,=
 and
>> to be able to fetch objects directly into the local object database
>> without fast-import. On the otherhand, it should be sufficiently gen=
eral
>> to allow arbitrary methods for moving the data around.
>
> Wonderful.
>
> I tested the series, and now there is (not surprisingly, but I made s=
ure
> to test anyway) no difference what-so-ever between NO_CURL and defaul=
t,
> and 'ldd' looks nice.
>
> Plus it looks like that whole "shim" thing is a good idea in general,=
 in
> that it allows a much more flexible model for fetching/pushing.
>
> So a very big Acked-by: from me for the series. I didn't test that ht=
tp:
> works with it, but I don't personally even care, so I'd ack it even
> without that ;)
>
> Btw, some real timing numbers for 'time make -j64 test':
>
> =A0- before:
> =A0 =A0 =A0 =A0real =A0 =A01m16.070s
> =A0 =A0 =A0 =A0user =A0 =A02m47.046s
> =A0 =A0 =A0 =A0sys =A0 =A0 2m34.698s
>
> =A0- after:
> =A0 =A0 =A0 =A0real =A0 =A00m58.851s
> =A0 =A0 =A0 =A0user =A0 =A01m57.087s
> =A0 =A0 =A0 =A0sys =A0 =A0 1m44.671s
>
> so that's actually a real-world example of the whole 'scripting
> performance'. Not an insignificant speedup on my machine (with an
> obligatory "nyaah, nyaah, I can do the git test-suite under a minute"=
 just
> to rub peoples noses in the fact that my desktop computer is disgusti=
ngly
> fast).

But more importantly, how fast can your machine compile the kernel?
(without ccache or any "cheats" like that, of course)

>
> That's an almost 30% performance improvement, despite the fact that p=
arts
> of the test suite didn't actually change (shell costs are the same, t=
he
> svn tests are quite perl-intensive etc).
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
