From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Mon, 30 Aug 2010 14:33:24 +0000
Message-ID: <AANLkTik-7FCm-WLOKOKd5uA9astMXtdZZLTT=0euX5RL@mail.gmail.com>
References: <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
	<20100828214641.GA5515@burratino>
	<20100828215956.GB5515@burratino>
	<alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
	<20100828221655.GB5777@burratino>
	<AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
	<20100829204519.GB1890@burratino>
	<AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com>
	<20100830134136.GA2315@burratino>
	<alpine.BSF.2.00.1008301353260.95618@x.fncre.vasb>
	<20100830140958.GE2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:33:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5QU-0004aG-TX
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab0H3Od0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 10:33:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54859 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0H3OdZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 10:33:25 -0400
Received: by fxm13 with SMTP id 13so3249294fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yWyTXnyRk0iAb1T2Mv0MOGcwkyaNLpmcl4TviA/7W2c=;
        b=FLHrBfJrdUFToWqp72PY/cwjXIbB4RbQuP2y0G0CdbSrDVJDb/KDfYZyqxMGNWf9bg
         +vOoNYTL+R18BStRWL0OT7PBcCFsxEIjN44Z/VTAeKSxcqBFCX/yqkcwOy1318kTjHky
         D00CNez9WEpMo8KjZPknG75JivHvvJhpE35tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mdkbn8yDzJE762xe5tDOSniNZFCXUhUTIagOBDtFwlSGUJvI6v6Un8W3Cr3MslxnWX
         DEiPxpFlJMUn/toCHlP4rye6svElR0lGala2M/O0XD/Fz7yi0ksh9pl6Nu+6hWyx/ab8
         fMsf/xHWOGYYZujrNEgf957/kUjrEw5bbV5HA=
Received: by 10.223.103.134 with SMTP id k6mr3940538fao.5.1283178804461; Mon,
 30 Aug 2010 07:33:24 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 30 Aug 2010 07:33:24 -0700 (PDT)
In-Reply-To: <20100830140958.GE2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154814>

On Mon, Aug 30, 2010 at 14:09, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Marcin Cieslak wrote:
>
>> Well, in this case everybody will be force to have UTF-8 in output
>> on-screen, not useful for people using ISO8859-*, KOI8-R and similar
>> things...
>
> Can't we do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0charset =3D nl_langinfo(CODESET);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "C");
>
> to allow an arbitrary character set?

Yes, it seems so! With this patch:

    --- a/gettext.c
    +++ b/gettext.c
    @@ -3,2 +3,3 @@
     #include <libintl.h>
    +#include <langinfo.h>
     #include <stdlib.h>
    @@ -8,2 +9,3 @@ extern void git_setup_gettext(void) {
            char *envdir =3D getenv("GIT_TEXTDOMAINDIR");
    +       char *charset;

    @@ -19,2 +21,6 @@ extern void git_setup_gettext(void) {
            (void)setlocale(LC_MESSAGES, "");
    +       (void)setlocale(LC_CTYPE, "");
    +       charset =3D nl_langinfo(CODESET);
    +       (void)bind_textdomain_codeset("git", charset);
    +       (void)setlocale(LC_CTYPE, "C");
            (void)textdomain("git");

The sanity test still passes:

    ./t0201-gettext-fallbacks.sh ......... ok
    ./t0200-gettext-basic.sh ............. ok
    ./t0203-gettext-setlocale-sanity.sh .. ok
    ./t0202-gettext-perl.sh .............. ok
    All tests successful.

And the resulting git binary can emit both UTF-8 and ISO-8859-1 text
from its *.po files, respectively:

    Bj=C3=B3 til t=C3=B3ma Git lind =C3=AD /tmp/meh/.git/
    Bj=EF=BF=BD til t=EF=BF=BDma Git lind =EF=BF=BD /tmp/meh/.git/
