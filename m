From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 2/2] i18n: Add extra -- to seperate gettext and message
Date: Sat, 16 Jun 2012 00:05:53 +0800
Message-ID: <CANYiYbGnoZDMkOq-goaPO98L4Ar1HzMVS-JjjBz7rNHVgv4ywQ@mail.gmail.com>
References: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
	<1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
	<CACBZZX5EGvJm0aqG5iVn7wnoqFATUqP4gbS-2tnAiLqeFQZifg@mail.gmail.com>
	<CANYiYbFx=Z7TTYUbAhzgHFYB6O_grROWoWHbtuhuABeXdFk4-Q@mail.gmail.com>
	<7vpq9ft3ls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 18:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfZ27-00025j-2w
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 18:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab2FOQFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 12:05:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33560 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2FOQFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 12:05:54 -0400
Received: by yenl2 with SMTP id l2so2013990yen.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OKfKemu9/ScbcRf2qbxwqZmKnN8c+H6L3sPTZ6Ugi4M=;
        b=trohuPMOtKo0EdLYoCs/bMsBPqDqFK3xjbHORP/g5JUkQpqtBceC/2hA83ypNnl3aN
         8QURVx5LtANgNBpCR4uWjs0Ya2wqN6vZCrsvSTOlUo6h5hSeG07Lz/YNrnjUkHphTjgf
         vQaYRWh31Dpetf33o560o73I5zT+MW91gYBNgFvr1eS2gmIbE3hkRGyZGkQMmR0N3hUg
         O8rwrl4bFiSMOtgo2WQlsYW0PT6fWViYJsj8W5oAstGtiKX3fcQYnbX7ikFPmWLau8jt
         2+jo1DrxbaBaCcfhG0r4AtWNj5SgOLyALTmreFuNzD+kY95b6NfMWJ7VBTfOH/1O2MjY
         S1ow==
Received: by 10.50.169.7 with SMTP id aa7mr2563651igc.52.1339776353633; Fri,
 15 Jun 2012 09:05:53 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Fri, 15 Jun 2012 09:05:53 -0700 (PDT)
In-Reply-To: <7vpq9ft3ls.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200064>

2012/6/5 Junio C Hamano <gitster@pobox.com>:
> I think there is value for having a generic solution than declaring
> "No message shall begin with a dash".
>
> I am not convinced that it is ideal for the implementation of
> gettext_ln to prepend "--" in front when it calls gettext, though.

I saw =C6var's bug report on xgettext to the GNU gettext list:

 * http://git.661346.n2.nabble.com/GETTEXT-BUG-xgettext-1-can-t-extract=
-quot-gettext-foo-quot-td7560744.html

May be post to a more official mailing list, such as bug-gnu-utils at
https://lists.gnu.org/mailman/listinfo/bug-gnu-utils will get some resp=
onse,
but I doubt there won't be a clear resolution in xgettext.

The default configurations of xgettext for shell scripts are defined in=
 file
'gettext-tools/src/x-sh.c':

      x_sh_keyword ("gettext");
      x_sh_keyword ("ngettext:1,2");
      x_sh_keyword ("eval_gettext");
      x_sh_keyword ("eval_ngettext:1,2");

Keyword "gettext" above is the same as "gettext:1". xgettext has
no idea of options and arguments, if there is a seperator ('--') betwee=
n
gettext and the message, message is argument 2. For example:

    gettext -- "--cached cannot be used with --files"

We can override the default settings of xgettext by passing '-k' and
multiple '--keyword', '--flags' options to xgettext.

    xgettext  ... --language=3DShell \
                  -k  --keyword=3Dgettext:2 \
                  --flag=3Dgettext:2:pass-sh-format  ...

But "gettext message" will be broken.

Write a wrapper for gettext  and extract messages using
'xgettext --keyword=3D<gettext-wrapper>' is a reasonable solution.


--=20
Jiang Xin
