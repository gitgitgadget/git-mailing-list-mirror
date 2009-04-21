From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 20:47:01 +0200
Message-ID: <20090421204701.1e0115c0@gmail.com>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
	<alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302>
	<41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>
	<20090421024433.GC14479@coredump.intra.peff.net>
	<7vskk2bt3x.fsf@gitster.siamese.dyndns.org>
	<fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com>
	<alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0904211100350.10279@pacific.mpi-cbg.de>
	<20090421195434.3a01676d@gmail.com>
	<20090421180529.GA7583@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwL2s-0005Bp-Qc
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080AbZDUSrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 14:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbZDUSrL
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:47:11 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33253 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZDUSrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 14:47:09 -0400
Received: by fxm2 with SMTP id 2so2685681fxm.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NSt8qQGpG9ElLVkXXnYJ8tZzyVXj2yLJtvfgVlDFWQ4=;
        b=VJzuwUX/Bh615mSYs6fcb0+ZLVQ6oxTr8eI3iWbNuyclkhI51Gdh7oTlF6KGBX/FYN
         IF7hInQvvKRznMWV/WaWj99beNaxWTDrq/fJWix3Jfnc+NNi+UiygfCG7yGE3XrdGyhM
         bzU7WFYlihTAqaLsawwZW1nPlN7BQa94At9NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=gepEvtUMVRKg2yt9zU5shqEpx6qi7RWG9DOsyfS7LsTVhS/DeUfzW7ELz5LqjTW6nT
         c+sqVrAEtxdUjh+kf9jOwX+aSd8H17Lj9vLAtShanU1E4jIvtIdN9mowBVtR0VRADnYL
         N1J0dL7g6XfnK6+DrNNCkvstccucDchHR+jZA=
Received: by 10.204.61.137 with SMTP id t9mr6761768bkh.204.1240339625733;
        Tue, 21 Apr 2009 11:47:05 -0700 (PDT)
Received: from localhost (77-253-150-63.adsl.inetia.pl [77.253.150.63])
        by mx.google.com with ESMTPS id 35sm13229851fkt.23.2009.04.21.11.47.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 11:47:05 -0700 (PDT)
In-Reply-To: <20090421180529.GA7583@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117148>

Jeff King <peff@peff.net> wrote:

> On Tue, Apr 21, 2009 at 07:54:34PM +0200, Micha=C5=82 Kiedrowicz wrot=
e:
>=20
> > And here is a test case:
> > [...]
> > +	echo "hello" > date &&
> > +	git add date &&
> > +	git commit -m initial &&
> > +
> > +	git branch parallel &&
> > +
> > +	echo "hello" > LICENSE &&
> > +	cp LICENSE LICENSE-copy &&
> > +	git add LICENSE &&
> > +	git commit -m LICENSE &&
>=20
> I thought the point was about _empty_ renames. This is a small but
> non-zero rename.
>=20
> -Peff

Yes, you are right. But change these echos to touch and you'll see that
this bug happens if date and LICENSE are the same, not necessary empty.

Micha=C5=82 Kiedrowicz
