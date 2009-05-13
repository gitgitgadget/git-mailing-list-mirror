From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 23:47:10 +0200
Message-ID: <op.utv1gwsi1e62zd@merlin.emma.line.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
 <20090512151403.GS30527@spearce.org>
 <20090512161638.GB29566@coredump.intra.peff.net>
 <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
 <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
 <op.utvy5mie1e62zd@merlin.emma.line.org>
 <alpine.LFD.2.01.0905131401170.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Esko Luontola" <esko.luontola@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 13 23:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4MIO-0000IG-D1
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761460AbZEMVrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 17:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbZEMVrO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:47:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:52216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751088AbZEMVrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:47:14 -0400
Received: (qmail invoked by alias); 13 May 2009 21:47:14 -0000
Received: from g225203118.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.225.203.118]
  by mail.gmx.net (mp056) with SMTP; 13 May 2009 23:47:14 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX188rd9wqUo8dWRA1U75O93OSXqZDlhllxisb/mZlp
	uCiDbV9a1aF6iT
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 4404994385;
	Wed, 13 May 2009 23:47:11 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.01.0905131401170.3343@localhost.localdomain>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119117>

Am 13.05.2009, 23:10 Uhr, schrieb Linus Torvalds =20
<torvalds@linux-foundation.org>:

>
>
> On Wed, 13 May 2009, Matthias Andree wrote:
>
>> Am 13.05.2009, 19:12 Uhr, schrieb Linus Torvalds
>> <torvalds@linux-foundation.org>:
>>
>> > Use <stringprep.h> and stringprep_utf8_nfkc_normalize() or somethi=
ng =20
>> to do
>> > the actual normalization if you find characters with the high bit =
=20
>> set. And
>> > since I know that the OS X filesystems are so buggy as to not even=
 do =20
>> that
>> > whole NFD thing right, there is probably some OS-X specific "use t=
his =20
>> for
>> > filesystem names" conversion function.
>>
>> Sorry for interrupting, but NF_K_C? You don't want that (K for =20
>> compatibility,
>> rather than canonical, normalization) for anything except normalizin=
g
>> temporary variables inside strcasecmp(3) or similar. Probably not ev=
en =20
>> that.
>> The normalizations done are often irreversible and also surprising. =
You =20
>> don't
>> want to turn 2=C2=B3.c into 23.c, do you?
>
> No, you're right. We want just plain NFC. I just googled for how some
> other projects handled this, and found the stringprep thing in a post
> about rsync, and didn't look any closer.
>
> But yes, you're absolutely right, stringprep is total crap, and nfkc =
is
> horrible.

Crap? It's just besides the purpose and some limited form of fuzzy matc=
h. =20
Anyways...

> I have no idea of what library to use, though. For perl, there's
> Unicode::Normalize, but that's likely still subtly incorrect for the =
OS-X
> case due to the filesystem not using _strict_ NFD.

Perhaps ICU (ICU4C), from http://site.icu-project.org/

--=20
Matthias Andree
