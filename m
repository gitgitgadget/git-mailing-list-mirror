From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 07/17] gettext.c: work around us not using
 setlocale(LC_CTYPE, "")
Date: Wed, 1 Sep 2010 00:58:07 +0200
Message-ID: <AANLkTi=c7j+U0Btgv5TgwkRmsY-TV-iQ3RARyZxYTDvk@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-8-git-send-email-avarab@gmail.com> <20100831151800.GG2315@burratino>
 <AANLkTi=+oGVx_T_-0T0RTqe+rV4QwQakjXUXKk8tddFL@mail.gmail.com> <20100831224517.GB6747@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 00:58:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqZmv-0001Gj-Lx
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab0HaW63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 18:58:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34170 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab0HaW63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 18:58:29 -0400
Received: by vws3 with SMTP id 3so5892275vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=aY92Ut2VDjOGhWOGf8QtqtSzyiHIriHcBKboxYu9A+U=;
        b=wZiWZbbc7nqLGSKpTXm9uCmpo6b/dmo5KhQG4jV29+qsN7OF1B1o2fHIKzCz8WkBlg
         2tUm+VwZ9IZPEc97ElDvJXiLOGa3v/Bs4yTO7qSwwkG9iyu2sN4SkbxqHHXFvoNI6MOF
         IDbQ1BB/pvmkk71V+nD5GX+rnOIVN7MFxXTkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=UpbVSN/2ySeSFCrTdI3K7SkvUo94qEEndBYqNA44dgb+qXd8GvAN/eX2/XBTRZlR+O
         1uOsbYfvROigT8Msfs6ZgXjwyMdZpTr4rJjJ392nBBgYN5ch1MPGzAWMCl4MeORSKTRV
         3ri0Rm6EVYXh60Ry11vuyXzQJ10Dn0bL5PmMk=
Received: by 10.220.125.38 with SMTP id w38mr3789097vcr.189.1283295507511;
 Tue, 31 Aug 2010 15:58:27 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Tue, 31 Aug 2010 15:58:07 -0700 (PDT)
In-Reply-To: <20100831224517.GB6747@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154992>

On Wed, Sep 1, 2010 at 12:45 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> =C6var Arnfj=F6r=F0 Bjarmason wrote:
>> On Tue, Aug 31, 2010 at 15:18, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
>>> Aside, not about this patch: glibc printf can be very convenient fo=
r
>>> translators, because of format strings like "%4$s". =A0Do other com=
mon
>>> platforms like FreeBSD and Mingw have something similar?
>>
>> I certainly hope so. I was planning on documenting its usage,
>> Johannes?
>
> Sorry, my knowledge was just outdated. =A0It's in posix[1] now, which
> I think means we can expect it to be in any recent libc.
>
> Unfortunately msys uses newlib 1.9.0 afaict, from 2001. =A0The %4$s
> support was introduced[2] to newlib by Eric Blake on 2007-04-25.
>

Git for Windows doesn't use the MSYS-runtime for Git itself, it only
use the MSYS-environment to build etc. It's using MSVCRT.DLL as the
CRT, which is even worse feature-wise.

http://msdn.microsoft.com/en-us/library/56e442dc.aspx describes the
format specification fields supported, and it does not look promising.
