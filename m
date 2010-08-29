From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sun, 29 Aug 2010 15:45:19 -0500
Message-ID: <20100829204519.GB1890@burratino>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
 <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
 <20100828214641.GA5515@burratino>
 <20100828215956.GB5515@burratino>
 <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
 <20100828221655.GB5777@burratino>
 <AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:47:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpomU-00056F-6w
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab0H2UrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 16:47:05 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43714 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab0H2UrE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 16:47:04 -0400
Received: by ywh1 with SMTP id 1so1427445ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Kx7tk11Ei+iKznwvozKSQGRQWMuS7XpZdBKPat5iUJ0=;
        b=qv47o5MQuIXHpbfPPbl/uJ7KVExO1iXhbNuVuSZ588sBP3Xr0Q5LGTRW+bKn0pCb21
         OmGwAMq5U+jj/9QEngFy4FPP4aPNy3k/0D+j/mMSi6eK8LRc6uB+Zw6I/3dONaNKQT0Y
         pEBhs/jHAAXdtcaJnOhgg2CQCg617RX6xSjPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=g4N99tVi0C7wGhstGaOlPz9nAXSWRslOmPRXFZtOWPlq/vcY57xVaPc/jbZ/NtlVML
         2Y9cpPCyPMNTSxuWSPJLXMh8cfpkSC8BGMO1yhaWDiV5rcVKXhwSJ/62NdqUehsETJE+
         Skv0uWOuTGB4AGeU8hryNRhcBcZ8kGAQm/OhA=
Received: by 10.151.63.30 with SMTP id q30mr4510347ybk.154.1283114822907;
        Sun, 29 Aug 2010 13:47:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id d5sm2655912ybi.9.2010.08.29.13.47.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 13:47:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154717>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> So, my plan of attack is:
>=20
>  * Add compat/printf from Free, Open or NetBSD. Maybe make
>    compat/snprintf.c use that while I'm at it.

I would prefer to get this fixed in glibc, but of course that
has nothing to do with git.

>  * Use that instead of the GNU libc printf on systems that have glibc=
=2E
>  * Add a configure check for that.
>  * Revert 107880a
>  * Get gettext goodness with LC_CTYPE
>=20
> Does anyone see a problem with that? The potential issue is that
> LC_CTYPE is for:
>=20
>     "regular expression matching,

should be okay, I think (unless http-backend is a problem)

> character classification,

worked around (see git-compat-util.h)

>     conversion,

I don't know what this means; iconv() is not affected by LC_CTYPE,
is it?

> case-sensitive comparison,

Could be a problem: we use strcasecmp() heavily.

> and wide character
>     functions."

no problem. :)

> So it might have unintended side-effects. But the only other
> workaround I can see is to decree that all consumers of the localized
> messages must have a UTF-8 locale.

And that is no workaround at all; the problem is still seen with UTF-8
locales, no?
