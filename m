From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 9 Nov 2010 13:38:23 +0100
Message-ID: <AANLkTiny+NmXew6UxjNMO+o75=CxxWm9iVRMRxs0LyTJ@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
	<1288524860-538-2-git-send-email-avarab@gmail.com>
	<4CCFCCC8.7080603@viscovery.net>
	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
	<4CD8F965.6050402@viscovery.net>
	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
	<4CD918AB.6060206@viscovery.net>
	<AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
	<4CD9241F.6070807@viscovery.net>
	<AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>
	<4CD933BF.6070105@viscovery.net>
	<AANLkTimhbp3AngtJjBYhHpa173=D-XJOg9L2sd6YMCwA@mail.gmail.com>
	<4CD93CF2.2060800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 13:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFnT4-0008Go-4d
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab0KIMiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 07:38:25 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59374 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab0KIMiY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 07:38:24 -0500
Received: by fxm16 with SMTP id 16so4875244fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6bGR2lJz0byH3INEsnDDDe08sUiPP7vKllHYY0Dfxg8=;
        b=aXpf77mAAvfBPOnf0aT64lsJsJHb8qgmjhnLp/tCNC2mqXejAPxwIgfnTrzX9kU1uk
         prZKNzxgYP/wGifivRV2XXim4BBiz24KE31zIj1d1NsR+StY6lJv9ydAFLdFeWCdSDEO
         Zr9oO8rXkVptZ68TPwWETOvRNH6qwoNZgawuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U2OYS7+lTd3OgrJMJK3e0100ev67/L6fOK4KRs/TsIjoe6xuuiXAg3WNXt2k1Dzazr
         9xYLRuw3HUUn6ISpNm3bp1Oc5DBS2f5vRvFAqRfH5L844++Cc4U2LNWvBI1XxNWw5GsI
         4Uu+/++iK1Isb+3Dfb3/vza0lD8UoHarC1PHg=
Received: by 10.223.71.199 with SMTP id i7mr5146853faj.57.1289306303078; Tue,
 09 Nov 2010 04:38:23 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 04:38:23 -0800 (PST)
In-Reply-To: <4CD93CF2.2060800@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161042>

On Tue, Nov 9, 2010 at 13:22, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 11/9/2010 12:57, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> How about if you just replace your tests with "cat". That should giv=
e
>> a more accurate indication of what speed it *should* be operating at=
,
>> once I fix those Makefile issues.
>
> Just FYI:
>
> $ time (for i in {1..100}; do eval_gettext2 foobar; done) > /dev/null
>
> real =C2=A0 =C2=A00m14.844s
> user =C2=A0 =C2=A00m11.635s
> sys =C2=A0 =C2=A0 0m4.372s
>
> Please understand that on Windows there is a difference between cat, =
sed,
> etc. and git. There is also a speed difference, which is annoying, bu=
t it
> is fact and *not* a bug. You cannot argue with how the timings "shoul=
d be".

I don't know/use Windows, or Git on Windows. So forgive my ignorance.

I understood your previous comments to mean that the invocation time
of git-* on one hand and cat(1) on the other hand had to do with how
many DLL's the former needed.

Since git-sh-i18n--envsubst needs the same DLL's (i.e. the libc) as
cat(1) and *nothing else* it should be as fast as cat(1) and not as
slow as git-*(1) once I fix that unfortunate Makefile bug, right?

Or is it something to do with the built-in MinGW tools being special
in some way (e.g. preloaded?)? In that case benchmarking a
hello-world.c for a git-sh-i18n--envsubst (or fixing the linking of
git-sh-i18n--envsubst) would make for a better comparison.

>> Anyway, if it's no more expensive than cat(1) (which it shouldn't be=
)
>> it probably won't be a problem to use git-sh-i18n--envsubst.
>
> It *is* more expensive.
>
> BTW, current ab/i18n fails to compile when NO_GETTEXT is specified in
> config.mak and libintl.h is not available. I suggest the fix below.

We already discussed this back in August. I came up with what I
thought was a more elegant solution, but didn't implement it yet:
http://www.spinics.net/lists/git/msg137783.html

I can try to come up with one (next weekend or something) and CC it to
you for testing.

> diff --git a/Makefile b/Makefile
> index c55baa6..e9ee142 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -619,9 +619,6 @@ LIB_OBJS +=3D entry.o
> =C2=A0LIB_OBJS +=3D environment.o
> =C2=A0LIB_OBJS +=3D exec_cmd.o
> =C2=A0LIB_OBJS +=3D fsck.o
> -ifndef NO_GETTEXT
> -LIB_OBJS +=3D gettext.o
> -endif
> =C2=A0LIB_OBJS +=3D graph.o
> =C2=A0LIB_OBJS +=3D grep.o
> =C2=A0LIB_OBJS +=3D hash.o
> @@ -1539,7 +1536,8 @@ endif
>
> =C2=A0ifdef NO_GETTEXT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0COMPAT_CFLAGS +=3D -DNO_GETTEXT
> -endif
> +else
> + =C2=A0 =C2=A0 =C2=A0 LIB_OBJS +=3D gettext.o
>
> =C2=A0ifdef NEEDS_LIBINTL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EXTLIBS +=3D -lintl
> @@ -1552,6 +1550,7 @@ endif
> =C2=A0ifdef GETTEXT_POISON
> =C2=A0 =C2=A0 =C2=A0 =C2=A0COMPAT_CFLAGS +=3D -DGETTEXT_POISON
> =C2=A0endif
> +endif
>
> =C2=A0ifeq ($(TCLTK_PATH),)
> =C2=A0NO_TCLTK=3DNoThanks
>
