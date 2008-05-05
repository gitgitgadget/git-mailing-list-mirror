From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 23:49:35 +0200
Message-ID: <200805052349.35867.robin.rosenberg.lists@dewire.com>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 23:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt8a9-0004BA-Qa
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 23:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760040AbYEEVt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 17:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757646AbYEEVt7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 17:49:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20813 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757870AbYEEVt6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 17:49:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5D631802ABA;
	Mon,  5 May 2008 23:49:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3vtGrd9VJx5; Mon,  5 May 2008 23:49:55 +0200 (CEST)
Received: from [10.9.0.10] (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id BF8E98027E1;
	Mon,  5 May 2008 23:49:54 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81309>

m=E5ndagen den 5 maj 2008 18.40.24 skrev Avery Pennarun:
> On 5/4/08, Ittay Dror <ittayd@tikalk.com> wrote:
> >  Avery Pennarun wrote:
> > > In fact, as someone else pointed out, renaming a java file requir=
es
> > > you to modify the file anyhow, so having git auto-move the file t=
o
> > > another directory *still* wouldn't make it work any better.
> >
> > Sure it will, because otherwise I need to move it and still need to=
 fix
> > it. And there are many other file formats and languages where such =
a move
> > will not require any change (I think it is funny that Java is a
> > justification for not doing something for a tool primarily used by =
C
> > people).
>
> I mentioned Java because you mentioned you were working in java.
>
> The particular problem with Java doesn't happen to C people.  Imagine=
,
> for example, that I add a new file, lib/foo.c, to lib/lib.a (thus the=
y
> have to modify lib/Makefile), while someone else renames "lib" to
> "bettername".
>
> When I merge, if git would create bettername/foo.c (it currently
> won't) and properly automerge bettername/Makefile (it will), then the
> program would still compile correctly.  However this doesn't work in
> Java: lib/foo.java would include the word "lib" in its contents (in
> the namespace declaration) and so there's no way automatic merging
> would have resulted in a version that compiles correctly.

You will always find corner cases. Line-by line merge happens to
work, not because it is the theoretically correct way, but because we
have discovered that it nearly always works so our need for more
specialized merging is not huge. We have also adapted our development
practices to the way line-by-line merging works, i.e. we avoid binary
files and funny text file formats.

> So what I said isn't to *justify* git's behaviour, merely to point ou=
t
> that in java's case, there seems to be no way to get fully automatic
> merging that would work.  In C, this case would have worked, if only
> git supported directory renames.

Sure, a merge that understands this is java and does the correct thing.=
 Evn
your case for C (with hypotetical directory rename detection) would fai=
l if=20
the renamed directory was used in an #include-statement (like #include=20
<lib/foo.h>) Say someone thinks xxdiff should move to lib/xxdiff, while=
=20
someone else adds a new reference to <xxdiff/xxdiff.h>. To resolve all =
cases=20
you must have tools that understand what they are doing. Directyry rena=
me
detection only solves a few cases, but it may be easy enough to impleme=
nt to=20
warrant the effort to get the tick in the box.

>
> In neither case is it very much work to fix by hand, though :),

I agree on that.

-- robin
