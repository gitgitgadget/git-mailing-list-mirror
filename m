From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above LIB_{H,OBJS}
Date: Sun, 14 Nov 2010 18:51:26 +0100
Message-ID: <AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
	<1289745857-16704-2-git-send-email-avarab@gmail.com>
	<20101114172331.GA26459@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgjl-0001qU-P6
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab0KNRv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:51:29 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39544 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNRv2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 12:51:28 -0500
Received: by fxm6 with SMTP id 6so1263869fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fgmwfQ9FCXxhiMaZMlWZ9SYByMc2PoMvS+FfCGFHMEE=;
        b=hiHfh4QzdSFy/eqS5vZ1i6nKu6By+umSKjQoeQWTj4OWuR4DKk4kpCCOA+r7ioon91
         +D49LJ5VM1mSRe7twLv4c3rmdeO8yKFtka1p8DuLj6H6ov5RZwC9vPiFYKdTZAdNkkWs
         /PJr90g1NfLBKpWFwP8jO7BodFZBmKf6FP6UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a7ke6unz1md9BX3S2kZJLgtAsJuMhhRJP5xWY702tADjIXgMRZ7adbZNQ11qyGUYBW
         nkZ60tNj4CLEmFwSDBQxlkHz/SlUN8Ea1mtbgmdSZEgIZsoOKA/ZXH+XYpOYu2fRDG7H
         sl7Uxa+9LlCoGb0e1wDr0kWOd6TuEmX5JPSc4=
Received: by 10.223.79.2 with SMTP id n2mr3891392fak.133.1289757086777; Sun,
 14 Nov 2010 09:51:26 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sun, 14 Nov 2010 09:51:26 -0800 (PST)
In-Reply-To: <20101114172331.GA26459@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161427>

On Sun, Nov 14, 2010 at 18:23, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Change the Makefile so that the "Platform specific tweaks" section
>> comes before the assignments to LIB_H and LIB_OBJS.
>
> Currently the Makefile is structured like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A. default target
> =C2=A0 =C2=A0 =C2=A0 =C2=A0B. basics
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1. basic configuration section
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a. -include GIT-VERSI=
ON-FILE and recipe to generate it
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b. uname_S :=3D $(she=
ll uname -s) and similar variables
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c. user-facing compil=
ation variables: CFLAGS, LDFLAGS, STRIP
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d. user-facing paths:=
 prefix, bindir_relative, etc
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e. program names: CC,=
 AR, etc
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2. basic cflags and ldflags (almos=
t configurable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3. main list of program targets:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCRIPTS, PROGRAMS, TE=
ST_PROGRAMS, BUILT_INS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OTHER_PROGRAMS, BINDI=
R_PROGRAMS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4. defaults for SHELL_PATH, PERL_P=
ATH, PYTHON_PATH
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5. main list of library targets:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LIB_FILE, XDIFF_LIB, =
LIB_H, LIB_OBJS, BUILTIN_OBJS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6. GITLIBS, EXTLIBS for the linker=
 command line
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7. platform-specific tweaks
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8. -include config.mak, config.mak=
=2Eautogen
> =C2=A0 =C2=A0 =C2=A0 =C2=A0C. preparations
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1. handling of the various NO_THIS=
_OR_THAT options.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This affects BASIC_CF=
LAGS, COMPAT_CFLAGS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COMPAT_OBJS, PROGRAMS=
, EXTLIBS, LIB_OBJ, LIB_H, etc
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2. machinery for non-noisy build
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3. shell-quoted and C-quoted varia=
bles
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4. ALL_CFLAGS, ALL_LDFLAGS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0D. main build rules
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1. all:: targets for the main buil=
d, subdirs
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2. shell sanity check
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3. building the git binary and bui=
lt-ins
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4. scripts and gitweb
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5. autoconf
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6. building objects:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a. %.o: %.c rule, hea=
der deps, dependency checking
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b. target-specific -D=
 flags
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7. building non-builtins, remote-c=
url
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8. libs
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 9. subdirs
> =C2=A0 =C2=A0 =C2=A0 =C2=A0E. GIT-CFLAGS, GIT-BUILD-OPTIONS, GIT-GUI-=
VARS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0F. bin-wrappers
> =C2=A0 =C2=A0 =C2=A0 =C2=A0G. tests
> =C2=A0 =C2=A0 =C2=A0 =C2=A0H. installation rules
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I. maintainer's dist rules, check-doc, cov=
erage, etc

That listing should be in a comment at the start of the
Makefile. Please submit a patch for that!

> This patch proposes moving A5 (main list of library targets) after
> A8 (end of configuration).

Right. Thanks for the helpful outline.

>> In the ab/i18n series I only want to build gettext.o (by adding it t=
o
>> LIB_OBJS) if NO_GETTEXT is unset. It's not possible to do that witho=
ut
>> an ugly hack if we haven't applied our platform specific tweaks befo=
re
>> LIB_{H,OBJS} gets assigned to.
>>
>> See <201008140002.40587.j6t@kdbg.org> (subject: "[PATCH] Do not buil=
d
>> i18n on Windows.") for Johannes's original report, and my follow-up =
in
>> <AANLkTiku5R+idX-C8f0AcCikBLmfEb5ZEhdft+CSRzU0@mail.gmail.com> where=
 I
>> suggested that the problem be solved in the manner of this patch.
>
> This doesn't motivate the patch all all to me. =C2=A0Is changing the =
list
> of LIB_OBJS in section C1 really an ugly hack? =C2=A0It is where
> configuration-specific things go and how BLK_SHA1, PROGRAM_OBJS, etc
> work already.

Yeah, because if it hadn't come before A8 it would have been *not*
assigned to in the first place like we do everywhere else. Moving A8
before A5 enables us to do that.

> That said, I can see another reason to move A3 and A5 lower down in
> the makefile. =C2=A0Namely, they don't seem to have anything obvious =
to
> do with configuration. =C2=A0Including the basic list of objects that
> high up may make the makefile easier to read straight through, but
> I don't think anyone is reading it straight through.
>
> So I wouldn't have anything against moving both A3 and A5 to right
> before C1, I just think it needs different motivation.

I was thinking about moving A3 & A5 further down. But since I just
needed A5 now I only ended up doing that. Moving them both would clean
things up though. I think we should do A8 as early as possible.
