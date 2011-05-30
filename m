From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitk: Allow displaying time zones from author and commit timestamps
Date: Mon, 30 May 2011 08:29:51 +0200
Message-ID: <201105300829.52619.jnareb@gmail.com>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu> <m3mxi4yco5.fsf@localhost.localdomain> <20110530061757.GC3723@Imperial-SD-Longsword>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@mit.edu>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Tim Guirgies <lt.infiltrator@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 08:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQvzS-0001ZD-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 08:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab1E3GaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 02:30:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41848 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1E3GaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 02:30:04 -0400
Received: by bwz15 with SMTP id 15so2622965bwz.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 23:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=uNdIKNLPFQC2OHCO7HZqXxJEgpCnutsmWfL8ON2vpig=;
        b=SKBYP+EsdJPCvUNpWAQsOThy9AmgXk1LcfK2LTVFeyI8ouTp21+Dq4mP4RWfk6ILHd
         JRPDx77gPQHiiUzqfRTlFPQqITnopgJlvd6UAF4tKely2lbMekBFLRFL8K3BIpyHTOy+
         B/eE0fkii3Nykba01W+b3MyET/aQr9kUl2S2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gX90Q5Gzx7CM8NscANZZkh0/x8D1g2Go+IbDEMTw0l7X45OIz4tU4drfrNOOX6sTeH
         yCRS+MzUgMqqiJkAO+H4gbzAr4+VTijjzxfW5aQPEpQfuvT5b3lf19xKjSMjxA/3QLiU
         EBurTGj9b4Fm+H1qLm3km9PS/8JviF1BH6Rog=
Received: by 10.204.13.71 with SMTP id b7mr4095630bka.100.1306737002395;
        Sun, 29 May 2011 23:30:02 -0700 (PDT)
Received: from [192.168.1.13] (abvg56.neoplus.adsl.tpnet.pl [83.8.204.56])
        by mx.google.com with ESMTPS id ag6sm3146681bkc.18.2011.05.29.23.30.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 23:30:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110530061757.GC3723@Imperial-SD-Longsword>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174725>

Tim Guirgies wrote:
> On Sun, May 29, 2011 at 10:35:08PM -0700, Jakub Narebski wrote:
> > Anders Kaseorg <andersk@MIT.EDU> writes:

[...]
> > > Yeah, sorry, that deserved a bit more explanation.  This is a klu=
dge to=20
> > > get Tcl 8.4 to format dates in the right timezone.  IDK is an arb=
itrary=20
> > > made up 3-letter code (=E2=80=9CI Don=E2=80=99t Know=E2=80=9D), s=
ince a UTC offset can=E2=80=99t generally=20
> > > be converted into a zone name.  The format of TZ is described at:
> > > http://www.gnu.org/software/libc/manual/html_node/TZ-Variable.htm=
l
> > > http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap0=
8.html
> > >=20
> > > Actually, reading that again, I just realized that I need to inve=
rt the=20
> > > sign.  Also that it can be longer than 3 letters; I=E2=80=99ll us=
e =E2=80=9CUnknown=E2=80=9D=20
> > > instead.
> >=20
> > Why not use UTC+N timezone (note: please check of for +HHMM it is
> > UTC+HH or UTC-HH) for timezone with given numeric offset from
> > Coordinated Universal Time?
> >=20
> > BTW. UTC because http://www.nist.gov/pml/div688/utcnist.cfm#cut
>=20
> But what of half-hour offsets, in that case?  A better idea would be
> UTC+HHMM or UTC-HHMM.  As an example, SA (CST) has a timezone of
> UTC+0930.

I think full specification is UTC+HH:MM or UTC-HH:MM.  GNU date
understands 'TZ=3DUTC+09:30 date'.


P.S. I should have remembered about fractional timezones, as we have ha=
d
problems in gitweb with those... and I have checked then that git.git
repository includes some commits in fractional timezones.

--=20
Jakub Narebski
Poland
