From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 19:03:27 +0100
Message-ID: <200811101903.27685.jnareb@gmail.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com> <m3iqqvefmo.fsf@localhost.localdomain> <8763mvlbwb.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Nazarewicz <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:05:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzb8F-0003dB-Ho
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 19:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbYKJSDo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbYKJSDo
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 13:03:44 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:28384 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbYKJSDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 13:03:44 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1618901tic.23
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=y3TQiVzBTNt1UrxZT8wm6rie8C55biouRuL0QksVpJY=;
        b=PG8m/2LmR7uhVo7a4Ct3Xj8pFhM1lGKcEc70FRBVVaIxsGEgLPLpH6E5hHD0eDx3d1
         xb87K/NsJ4nntCrhm/K3uXqsmTMdSADy5OOcN8VJndDOsV0dqZx5I+GQ/aG3l7OgUp+f
         DOXx55Jws1MzVL5cdOeV9F57b0Ma3gzwS+N+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZV4qBiHNgZTVUL7TBBRWVHLFjugfSfmpgFhNQixbE0DhcD0EIGcSKvWrN48+bNUheQ
         UA2UW39/yW1ql7F7JtWtoo74gxIUpRNWO/cqs3EU/t8FCQ9e5pzzNS6yKlKaWDw3r+hD
         hbEgs3bilxrYhxsEOpRwxmmctefPZM0mDNC/4=
Received: by 10.110.47.9 with SMTP id u9mr3741403tiu.51.1226340222031;
        Mon, 10 Nov 2008 10:03:42 -0800 (PST)
Received: from ?192.168.1.11? (abwz230.neoplus.adsl.tpnet.pl [83.8.249.230])
        by mx.google.com with ESMTPS id w5sm2113203tib.14.2008.11.10.10.03.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 10:03:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <8763mvlbwb.fsf@erwin.mina86.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100536>

Dnia poniedzia=B3ek 10. listopada 2008 18:38, Michal Nazarewicz napisa=B3=
:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > The reason why git doesn't support keywords like $Revision$ or $Dat=
e$
> > is performance: the $Revision$ and $Date$ are keywords related to
> > _commit_ data, not blob data.=20
>=20
> In my case identifying content not commit would be even better.

Well, in that case using `ident` attribute would be enough
(but cryptic).

 # set `ident` attribute for all files
 $ echo '* ident' > .gitattributes

 # check that it is set for file 'foo'
 $ git check-attr ident -- foo
 foo: ident: set

 # edit file to contain '$Id$' keyword
 $ cat foo
 ...
 ... $Id$ ...
 ...

 # make a commit
 $ git commit -a

 # $Id$ keyword is replaced on checkout
 $ git add foo
 $ git checkout foo

 # and check that it got replaced
 $ cat foo
 ...
 ... $Id: 0ca1524d4460ba6bc91bf3adc9dab13212599243 $ ...
 ...

But you need git to make use of this SHA-1 _blob_ (contents) identifier

--=20
Jakub Narebski
Poland
