From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] add alloc_ref_with_prefix()
Date: Mon, 20 Oct 2008 12:34:22 +0200
Message-ID: <48FC5EAE.9000108@op5.se>
References: <48F9A054.4010703@lsrfire.ath.cx>	 <36ca99e90810180227u367783f6vc3b7af0176f6df06@mail.gmail.com>	 <48F9AECA.3020606@lsrfire.ath.cx> <36ca99e90810180507q2dedf4ck7262239ae91d892f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 17:06:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krs6s-0007dI-JE
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 12:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYJTKe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2008 06:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbYJTKeZ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 06:34:25 -0400
Received: from mail.op5.se ([193.201.96.20]:35489 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbYJTKeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 06:34:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B19AA1B8037A;
	Mon, 20 Oct 2008 12:27:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.849
X-Spam-Level: 
X-Spam-Status: No, score=-3.849 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.550, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DnXyNT4fqY3b; Mon, 20 Oct 2008 12:27:50 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E1ED21B800B2;
	Mon, 20 Oct 2008 12:27:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <36ca99e90810180507q2dedf4ck7262239ae91d892f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98671>

Bert Wesarg wrote:
> On Sat, Oct 18, 2008 at 11:39, Ren=E9 Scharfe <rene.scharfe@lsrfire.a=
th.cx> wrote:
>>>> +static struct ref *alloc_ref_with_prefix(const char *prefix, size=
_t prefixlen,
>>>> +               const char *name)
>>>> +{
>>>> +       size_t len =3D strlen(name);
>>>> +       struct ref *ref =3D xcalloc(1, sizeof(struct ref) + prefix=
len + len + 1);
>>>> +       memcpy(ref->name, prefix, prefixlen);
>>>> +       memcpy(ref->name + prefixlen, name, len);
>>> Where does you \0-terminate the string?
>> xcalloc() calls calloc(), which zeroes the memory.
> So, you write the memory range twice, just for the last \0?
>=20

calloc() doesn't do the zeroing pass if it gets memory from the kernel,
which guarantees that the memory is already zeroed out. In reality,
calloc() usually saves on both readability and performance over
explicitly nul-terminating strings.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
