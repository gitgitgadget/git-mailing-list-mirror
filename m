From: Stephen Bash <bash@genarts.com>
Subject: Re: mac osx
Date: Wed, 21 Sep 2011 11:42:17 -0400 (EDT)
Message-ID: <32759526.24168.1316619736958.JavaMail.root@mail.hq.genarts.com>
References: <CAP2yMaJz3-iX11vhbrTVasFD1zdwsdiDFKU7z7=an8pBoORk8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Kyle Neath <kneath@gmail.com>,
	tom smitts <tomsmitts@ymail.com>, git@vger.kernel.org,
	Timothy Harper <timcharper@gmail.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 17:42:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6OwR-0000R5-4F
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 17:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab1IUPmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 11:42:25 -0400
Received: from hq.genarts.com ([173.9.65.1]:4910 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751334Ab1IUPmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 11:42:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 74B21EA2896;
	Wed, 21 Sep 2011 11:42:23 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1ZdbPczB2K3; Wed, 21 Sep 2011 11:42:17 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 139F7EA2894;
	Wed, 21 Sep 2011 11:42:17 -0400 (EDT)
In-Reply-To: <CAP2yMaJz3-iX11vhbrTVasFD1zdwsdiDFKU7z7=an8pBoORk8w@mail.gmail.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181851>

----- Original Message -----
> From: "Scott Chacon" <schacon@gmail.com>
> Sent: Wednesday, September 21, 2011 10:58:03 AM
> Subject: Re: mac osx
>=20
> On Wed, Sep 21, 2011 at 5:52 AM, Timothy Harper <timcharper@gmail.com=
>
> wrote:
> >>> On Tue, Sep 20, 2011 at 3:40 PM, tom smitts <tomsmitts@ymail.com>
> >>> wrote:
> >>>> Do the git maintainers really think any mac users have
> >>>> =C2=A0a clue which git install package to download? You
> >>>> put some arcane chipset designation in the package
> >>>> =C2=A0name!
> >
> > Good point, I'll update the description to include "32-bit" and
> > "64-bit"
>=20
> Honestly this doesn't help much. I think the point is that these
> numbers or machs are not in any of the docs or ads I can think of for
> macs. I feel pretty stupid admitting this to this list, but I
> honestly don't know which macs are 32 bit - I assume the MBP is 64,
> but if someone challenged me I'm not sure I could really defend it.

Perhaps I can shed some light on the subject...  (Long time Mac user an=
d developer of software that has to deal with these sorts of issues all=
 the time)

Starting with the hardware: Apple announced the switch to Intel process=
ors in 2005, with the first machines shipping in early 2006 with the In=
tel Core Duo (i386/32-bit) processors.  In August of 2006 they introduc=
ed a Xeon-based Mac Pro that used the x86_64/64-bit instruction set.  A=
ccording to Wikipedia [1] by August of 2007 every Mac shipped was based=
 on an x86_64 chip.

Now Apple confused things with the software: Mac OS 10.5 (Leopard) intr=
oduced the ability to run 64-bit applications (and access more the 4GB =
of memory), but the kernel was still 32-bit (I've skimmed some articles=
 about how they did this, but I don't remember the details now).  Accor=
ding to this article [2] it wasn't until OS 10.6.4 (Snow Leopard) that =
Apple actually made the boot default to the 64-bit kernel (but I have f=
irst hand experience with commercial software that changes the default =
back to 32-bit!).

And during all this users were never educated about the difference beca=
use many (most?) applications built for Mac ship "universal binaries" w=
ith multiple architectures linked into the same file (though there are =
still a lot that just ship 32-bit).  I don't know how much effort it wo=
uld be to update the Git Makefile for universal builds on Macs (sometim=
es it's as easy as "-arch i386 -arch x86_64"), but that might be the mo=
st "Mac-like" way to go.

=46or the geeks in the audience if you really want to know:
  a) the instruction sets linked in a binary (executable or shared libr=
ary):=20
        $ file /path/to/binary/of/interest
  b) the currently booted kernel architecture:=20
        $ uname -m
  c) the currently running architecture set of any application:=20
        Activity Monitor lists in the column "kind": PowerPC, Intel, or=
 Intel (64-bit)

[1] http://en.wikipedia.org/wiki/Apple%E2%80%93Intel_transition
[2] http://macperformanceguide.com/SnowLeopard-64bit.html

HTH,
Stephen
