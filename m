From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 0/2] use libcharset.h with gettext if available
Date: Wed, 29 Sep 2010 13:41:37 +0200
Message-ID: <AANLkTikMWy2a0M6bFMj+Jb+2QewUGsUjMsbv=XyR1Tr9@mail.gmail.com>
References: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com>
 <1285698577-28395-1-git-send-email-avarab@gmail.com> <AANLkTinxSqPD8H4Giigb1vbi7DC2wpDVqWmXGVZXmeKQ@mail.gmail.com>
 <AANLkTin90pKaVGVaG-4PW50TAhgfp1QVtrKpvyVxpnW0@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 13:42:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0v32-0001X6-En
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab0I2LmC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 07:42:02 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43834 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab0I2LmA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 07:42:00 -0400
Received: by gye5 with SMTP id 5so142357gye.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=EvR5+psIgCtnWdSMIEtQ6FRf9HlbbE0kCqs/vgVzhUc=;
        b=KFsI046va/cvhUaxVlIdc9gs9J3CuDqMaEaViHbQmhixj1o0CdNmQV56oZ3wn1JVJL
         XPo/yOfmXN+qkSLeeoj8vjILgi2ZqhQ3OPPYs7ZRc6jCJC3yu9aLb862m7mVUdQ9BVGp
         MwyZx9P5dHdwLfQsbbScXEA7QVAcl1nrQ9NBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=N2EWg+5LybvT7EXShV6zU7aQFxcehe6GxUbKo80IiRq4brNMHXkyAvZ3Jav/dkqmvt
         R3ALte86wD9/Y5nHiSQ9O7VL5zshM/x2q5SJKeVLbl9iUtzc7V+dloxJXlI/GvajifYn
         YmUzcqqypwPL1XPtRRmL0wc7eJgjuFu0NNCjU=
Received: by 10.151.141.17 with SMTP id t17mr1944966ybn.32.1285760520234; Wed,
 29 Sep 2010 04:42:00 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Wed, 29 Sep 2010 04:41:37 -0700 (PDT)
In-Reply-To: <AANLkTin90pKaVGVaG-4PW50TAhgfp1QVtrKpvyVxpnW0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157557>

On Wed, Sep 29, 2010 at 12:00 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Sep 28, 2010 at 21:47, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> On Tue, Sep 28, 2010 at 8:29 PM, =C6var Arnfj=F6r=F0 Bjarmason
>>> =A0* Added defaults for NO_LIBCHARSET to the default, I only change=
d the
>>> =A0 defaults for the MINGW entry, maybe it should be changed on Cyg=
win
>>> =A0 and Windows too? And probably on OpenBSD and NetBSD too.
>>>
>>
>> I don't think NO_LIBCHARSET should be the default. libcharset is
>> reported to be a bit better than nl_langinfo at normalizing the
>> encoding, and GNU gettext depends on libcharset (through libiconv,
>> which libcharset is distributed with). So in the case of a GNU
>> gettext, libcharset should really be present.
>
> I can't find any package (with apt-file) on Debian or Ubuntu that
> provides libcharset.h, but I have langinfo.h on those systems.
>

Strange. A 'make install' on libiconv installed libcharset.h to
$prefix/include on my system. But looking a bit deeper, it seems that
glibc supplies it's own iconv implementation (perhaps based on
libiconv, I don't know). So yes, I tend to agree with you. GNU
platforms should not be expected to have libcharset.

> The GNU gettext manual also reccomends the use of nl_langinfo in
> "11.2.4 How to specify the output character set `gettext' uses", so i=
t
> seems that using that and not libiconv is the default way of doing
> things on GNU gettext + GNU libc systems.
>

OK, fair enough. I based my comment on some comment by the GNU gettext
maintainer (who is also the libcharset maintainer - libcharset does in
fact use nl_langinfo if present), but since this is in the manual I
fully withdraw my comment.

Then again, if this is an opt-in rather than an opt-out, perhaps we
should change the switch to HAVE_LIBCHARSET? I don't mean to go in
circles here, but it sounds more self-documenting to me.
