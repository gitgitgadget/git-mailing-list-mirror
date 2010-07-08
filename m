From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Thu, 8 Jul 2010 08:59:30 +0200
Message-ID: <201007080859.33958.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <201007072220.18824.jnareb@gmail.com> <7v39vustku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 08:59:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWl5N-0006iW-5U
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 08:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab0GHG7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 02:59:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51325 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0GHG7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 02:59:46 -0400
Received: by fxm14 with SMTP id 14so182244fxm.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=A8AEZb+o3DixUjuWDvUQX/690FFDnbSRlbWIFjHEO8g=;
        b=RdJqh8Amsh7y7WWQS8pH2jrT1aM3k1DaESnWCb1SgDD5HbXlr640nSx/J15I0iJxR6
         E/Rabc/Atk06yWxcOY+2dQrJsXJX/DCnDK4IxBDQYJOrZOmDDn/py32VHAjpvyiOkCr7
         jr7h0VeObml3vRBq/BfsJLMZV0cHzxGtnixqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=brdLEingb9t5DXZgOiYUpzUejsyXZCAZeRMK+PG4bU2NYmigpzwQBrheDJOE5OZAdV
         o1IhEGs08Jac753R9NmJwhGjHI11xRMLWfKbAIv7auKSbRuPmgPp0QWBUsI99joOpnsC
         veRiNvbgI3s0IC1cikjT1+8SE2YtJl1XNvE80=
Received: by 10.223.123.194 with SMTP id q2mr6694601far.64.1278572384501;
        Wed, 07 Jul 2010 23:59:44 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id 16sm16296065far.40.2010.07.07.23.59.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 23:59:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v39vustku.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150542>

Dnia czwartek 8. lipca 2010 02:30, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> >> > +install-modules:
> >> > +	install_dirs=3D$(sort $(dir $(GITWEB_MODULES))) && \
> >> > ...
> >
> > For example with the following Makefile:
> >
> >   GITWEB_MODULES +=3D GitwebCache/SimpleFileCache.pm
> >   GITWEB_MODULES +=3D GitwebCache/Capture.pm
> >   GITWEB_MODULES +=3D GitwebCache/Capture/SelectFH.pm
> >   GITWEB_MODULES +=3D Gitweb/Config.pm
> >  =20
> >   all:
> >   	@echo $(sort $(dir $(GITWEB_MODULES)))
> >
> > running 'make' results in:
> >
> >   Gitweb/ GitwebCache/ GitwebCache/Capture/
>=20
>=20
> Try replacing that with:
>=20
> 	all:
>         	install_dirs=3D$(sort $(dir $(GITWEB_MODULES))) && \
>                 echo $$install_dirs
>=20
> perhaps?
>=20
> Hint: dq.

You are completely right.  I'm sorry.  I should have copied the=20
structure from "[PATCH 2/2 v2] Makefile: work around ksh's failure to=20
handle missing list argument to for loop" more carefully.

I'll resend it.
--=20
Jakub Narebski
Poland
