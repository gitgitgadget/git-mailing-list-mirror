From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] gettext: use libcharset when available
Date: Wed, 29 Sep 2010 15:34:54 +0200
Message-ID: <AANLkTinRsryfdnj_uUH++yZrV1r_M+NNoXLm9TSO9N+J@mail.gmail.com>
References: <AANLkTikMWy2a0M6bFMj+Jb+2QewUGsUjMsbv=XyR1Tr9@mail.gmail.com> <1285765637-16381-1-git-send-email-avarab@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 15:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0wth-0004JU-3D
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab0I2NfS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 09:35:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62376 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab0I2NfR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 09:35:17 -0400
Received: by ewy23 with SMTP id 23so192744ewy.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=NXOQRx0w/Y9tyzywmDoPov5YHDYw0NFMqCeKY95D3AI=;
        b=ou6vtezmsuNQc6d9HiOv2KxtckN+EA1o9xVx8eX1SyUp16j6MGVg6+FeX7Fv+lS2NA
         Dera75VgJUG4Zo9W87Apm2cU54+pdtmNFGao6ATw05F5dFh1KqAnPYcliAGoB8apivn6
         XKZfguoNO+HZ1wMKk4Hk/lMqk53Je7mgpHt3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=kMT22OyFivLKMXU/sn7cLIaoIl14QUPR2u1Jz+TlWF+PLFA6xJqxID/+bQWJERkNpk
         icwKrGETmRAWimqS8fwIwwY3NDktyMF6cW1cqfEhbgCPAvRFURGVZJ41kjYZa/AcZXx7
         R0Y/nn27GSxefd71ZYqk1aSirkQOmqYt2ep+A=
Received: by 10.213.48.131 with SMTP id r3mr1321584ebf.69.1285767315659; Wed,
 29 Sep 2010 06:35:15 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Wed, 29 Sep 2010 06:34:54 -0700 (PDT)
In-Reply-To: <1285765637-16381-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157568>

On Wed, Sep 29, 2010 at 3:07 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> From: Erik Faye-Lund <kusmabite@gmail.com>
>
> Change the git_setup_gettext function to use libcharset to query the
> character set of the current locale if it's available. I.e. use it
> instead of nl_langinfo if HAVE_LIBCHARSET_H is set.
>
> The GNU gettext manual recommends using langinfo.h's
> nl_langinfo(CODESET) to acquire the current character set, but on
> systems that have libcharset.h's locale_charset() using the latter is
> either saner, or the only option on those systems.
>
> GNU and Solaris have a nl_langinfo(CODESET), FreeBSD can use either,
> but MingW and some others need to use libcharset.h's locale_charset()
> instead.

Very minor nit: It's officially spelled MinGW, with an upper-case G.

>
> Since locale_charset returns a const char* instead of char* as
> nl_langinfo does the type of the variable we're using to store the
> charset in git_setup_gettext has been changed.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
>
> Junio, this goes on top of ab/i18n.
>

Wow, thanks for taking care of this!
