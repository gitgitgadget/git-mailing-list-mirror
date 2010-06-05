From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH RFC] gettext: Support building on non-GNU with -lintl
Date: Sat, 05 Jun 2010 04:42:50 -0700 (PDT)
Message-ID: <m3aar9r9ek.fsf@localhost.localdomain>
References: <1275669370-6004-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 13:43:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKrmF-00068Q-Mf
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 13:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113Ab0FELmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 07:42:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933033Ab0FELmx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 07:42:53 -0400
Received: by fg-out-1718.google.com with SMTP id l26so440328fgb.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=rcYIWydWEQM3PidCe0PB1JY3kEipRMOsGp8qqu/M31k=;
        b=sQCU7gbUi5bhHiCzELhNf1tD4Y62pvpLGWzEwA5FrM/fqQ4Ov4eSPLMbmMeLqVCidE
         nERmvDd9L3wjwL34wwzapZNo/vJKTzAR6uegGaEnT62+TRyi+Q0kb8sLdfZoPDYusg1x
         pQIuiiE3wrUkpVhvrOjOJSFn9LQ1bcSLu9Efo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=l/HuCp58Tob3lqfcqNXMUF4hAyjS9amYss8NIcv4aSiUUKoHE9NJZ6zN9QewFhpB8S
         m5FOFpiCxDE53RgTKUZWmC2b9Gl/LUh6Pbn7OwUrTYcWNurwBp7MXQZqXq6oo79ajk3U
         aFnuNEOuimoQ/0AUQNSSl1K34QQhUL6KJ/KeA=
Received: by 10.102.13.11 with SMTP id 11mr4266802mum.74.1275738170947;
        Sat, 05 Jun 2010 04:42:50 -0700 (PDT)
Received: from localhost.localdomain (aehn204.neoplus.adsl.tpnet.pl [79.186.195.204])
        by mx.google.com with ESMTPS id y6sm3251346mug.20.2010.06.05.04.42.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 04:42:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o55Bil6X004345;
	Sat, 5 Jun 2010 13:44:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o55Bia45004341;
	Sat, 5 Jun 2010 13:44:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1275669370-6004-1-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148467>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> Change the build process on non-GNU systems to use -lintl if
> NO_GETTEXT hasn't been set.
>=20
> Systems that use the GNU C Library don't need this, but on others the
> GNU libintl library is an externally install package, so we need to
> explicitly link to it.
>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---

[...]
> diff --git a/Makefile b/Makefile
> index 5169aec..1dfcd65 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -28,6 +28,15 @@ all::
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push=
 is
>  # not built, and you cannot push using http:// and https:// transpor=
ts.
>  #
> +# Define NO_GETTEXT if you don't have libintl installed, or don't wa=
nt
> +# to build Git with localization support.
> +#
> +# Define NEEDS_LIBINTL if you haven't defined NO_GETTEXT=3DYesPlease=
,
> +# but your system needs to be explicitly linked to -lintl. This is
> +# defined automatically if we're building gettext support on systems
> +# where we expect not to use glibc (which has libintl included in
> +# libc).

Could you add test for NEEDS_LIBINTL to configure.ac?  Thanks in
advance.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
