From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 18:35:07 +0400
Message-ID: <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com> <20101007141015.GB8162@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 16:37:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3rab-0002KC-Kk
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 16:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0JGOfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 10:35:11 -0400
Received: from mail.intellij.net ([213.182.181.98]:47639 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0JGOfK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 10:35:10 -0400
Received: (qmail 3864 invoked by uid 89); 7 Oct 2010 14:35:08 -0000
Received: by simscan 1.1.0 ppid: 3594, pid: 3848, t: 0.0587s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 7 Oct 2010 14:35:08 -0000
In-Reply-To: <20101007141015.GB8162@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158403>


My bad, this happens only on Windows (at least not on Mac OS X).

So it more likely is an msys porting problem or something like that, no=
t a bug of Git itself.
I've tested it on Windows XP SP3 with official installer for Git 1.7.2.=
3 and 1.7.3.1

I don't think it's a terminal problem. I've tried saving the output in =
a file:
git log --pretty=3Dformat:%H%x00%ct  >a.txt

I've also tried invoking the git process from a program and catching it=
s output.

How could I report this bug? Or this message is enough? :)

07.10.2010, =D7 18:10, Jeff King =CE=C1=D0=C9=D3=C1=CC(=C1):

> On Thu, Oct 07, 2010 at 03:25:29PM +0400, Kirill Likhodedov wrote:
>=20
>> With a null byte
>>> git log --pretty=3Dformat:%H%x00%ct
>> Ignores anything appearing after the null byte:
>>=20
>> ee5d714b95d133ff555bc8c7933dc752b5b277f5
>> cb1b9dd688d9cf155257c94e749172820b56d87a
>> b4c75be10b14d021003853e527e47ad88dc5a55b
>> 1963187da6a45f898e62e4e922faac6b9382b4e4
>>=20
>> Other bytes behave fine.=20
>>=20
>> Using %x00 worked in Git 1.7.1 and stopped working in 1.7.2.3 (or ev=
en earlier).
>=20
> I can't reproduce using v1.7.2.3. Are you sure your pager or terminal
> isn't hiding everything after the NUL? Have you tried piping it throu=
gh
> "xxd" or "cat -A"? I get:
>=20
>  $ git log -1 --pretty=3Dfoo%x00bar | xxd
>  0000000: 666f 6f00 6261 720a                      foo.bar.
>=20
>  $ git log -1 --pretty=3Dfoo%x00bar | cat -A
>  foo^@bar$
>=20
>> Is it a bug or a feature (not allowing null bytes in the custom form=
at anymore)?
>=20
> If it is not working, it is most definitely a bug.
>=20
> -Peff

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
