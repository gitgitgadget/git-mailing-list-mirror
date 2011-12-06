From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] userdiff: allow * between cpp funcname words
Date: Tue, 06 Dec 2011 22:07:03 +0100
Message-ID: <4EDE83F7.6030708@lsrfire.ath.cx>
References: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch> <20111206190217.GD9492@sigill.intra.peff.net> <201112062117.57690.trast@student.ethz.ch> <20111206201944.GB27930@sigill.intra.peff.net> <4EDE8086.9080303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2ET-0006oe-Mg
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab1LFVHO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 16:07:14 -0500
Received: from india601.server4you.de ([85.25.151.105]:39023 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab1LFVHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:07:14 -0500
Received: from [192.168.2.105] (p4FFD9BF7.dip.t-dialin.net [79.253.155.247])
	by india601.server4you.de (Postfix) with ESMTPSA id B14192F8033;
	Tue,  6 Dec 2011 22:07:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4EDE8086.9080303@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186384>

Am 06.12.2011 21:52, schrieb Johannes Sixt:
> Am 06.12.2011 21:19, schrieb Jeff King:
>> On Tue, Dec 06, 2011 at 09:17:56PM +0100, Thomas Rast wrote:
>>
>>>> Looks reasonable to me. You can see the difference, for instance, =
with:
>>>>
>>>>    git show -U1 3c73a1d
>>>>
>>>> (The -U1 is because of the annoying "we will start looking for the
>>>> header at the top of context, not the top of changes" behavior I
>>>> mentioned last week).
>>>
>>> Actually (sadly) I'll have to revise it.  It doesn't match much of =
C++
>>> either, and I haven't yet come up with a reasonable regex that
>>> matches, say,
>>>
>>>    foo::Bar<int>::t&  Baz::operator<<(
>>>
>>> which I would call ludicrous, but it's valid C++.
>>
>> Ick, yeah. Maybe it is worth doing the "*" thing for now, and then
>> worrying about advanced C++ stuff on top as another patch. AFAICT, y=
our
>> original patch is a strict improvement.
>
> Excuse me, where's the problem? The above example shows this
>
> @@ -105,8 +105,8 @@ char *url_decode(const char *url)
>          struct strbuf out =3D STRBUF_INIT;
> -       const char *slash =3D strchr(url, '/');
> +       const char *colon =3D strchr(url, ':');
> ...
>
> with current 4cb5d10b. This looks quite correct, no?

That's with the default heuristic; try something like this first to tur=
n=20
on userdiff:

	$ echo url.c diff=3Dcpp >>.gitattributes

Ren=C3=A9
