From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to embed a hash, tag or branch name?
Date: Sat, 1 Aug 2009 15:13:07 +0200
Message-ID: <200908011513.13016.jnareb@gmail.com>
References: <20090731081723.GE29909@nalle> <20090731095238.GG29909@nalle> <4A743735.9020806@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, git@vger.kernel.org
To: Dirk =?iso-8859-1?q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat Aug 01 15:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXEOw-0006vG-QN
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 15:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbZHANNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 09:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZHANNX
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 09:13:23 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:60108 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbZHANNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 09:13:23 -0400
Received: by ewy10 with SMTP id 10so2068650ewy.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JcSNuISLFA/oHk78NG74Y54+x9bQZlbIdVgUT61A0h8=;
        b=JnkPX9UkerehIc4XPQuVrbB+lAyR9tzctAPd2iVdvjBBjG5KZoz2fzpiW3Jsp3xZHn
         lxwQ6vqKiXyFFoPpttZyKg5bpFPuvi1Mqf5+ojbSb0t+ayTkPg6jiRavdQ1qhCuiKhqM
         O3VZ/o6c/oCyjyjcNrs5TDHi97rLk5GYOAc6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=c2A2EfBK9/wfErM7krnqDseQREQgFZrFf3v8GOlfL6AloUB3HJMYlwz5aFFfWSSvFf
         i6zqMv0O/l9KjfzDexKmu9E7Z8JhLdf0T2a8PxUIUYEQr8G/j5FfQ5IcJu1uUs8myBvJ
         qe3KntsQlUZCdtVqnQr2zWe5UfgMk1aeg7Zhk=
Received: by 10.210.20.10 with SMTP id 10mr2302741ebt.72.1249132401908;
        Sat, 01 Aug 2009 06:13:21 -0700 (PDT)
Received: from ?192.168.1.13? (abvt157.neoplus.adsl.tpnet.pl [83.8.217.157])
        by mx.google.com with ESMTPS id 10sm4455587eyz.11.2009.08.01.06.13.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 06:13:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A743735.9020806@dirk.my1.cc>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124622>

On Sat, 1 August 2009, Dirk S=FCsserott wrote:
> Am 31.07.2009 11:52 schrieb Mikko Rapeli:
>> On Fri, Jul 31, 2009 at 02:27:50AM -0700, Jakub Narebski wrote:

>>> You can embed SHA-1 of a _file contents_ (blob) using '$Id: $' keyw=
ord
>>> with `ident` attribute - see gitattributes manpage.
>>=20
>> Great, thanks!
>>=20
>>> The correct solution of embedding version number is to do it at=20
>>> _build time_, using e.g. script similar to GIT-VERSION-GEN used by
>>> Git itself and by Linux kernel.  It helps if you tag your releases.
>>=20
>=20
> Hi Mikko,
>=20
> I don't know whether you want to use the "ident" command on your fina=
l
> binary. With Git, that's pointless, as all source files will have the
> same $Id$. So it's perfectly sufficient to have only ONE file enriche=
d
> with Git's SHA1.

You are wrong.  In Git $Id$ / $Id: $ expands to SHA-1 id of _blob_=20
(i.e. of file *contents*), not SHA-1 id of a commit.  This way when
switching branches or rewinding branch using git-reset we don't have
to pay huge performance penalty because of `ident`, as we would have
because every file would have to be changed if $Id$ was about commit
id (or if there was $Revision$ or $Author$ implemented).

> Suggestion: During build time, compile (and link in) a file (e.g.
> version.c) with "-DVERSION=3D\"$(git describe)\"". My version.c looks=
 like
> this:

GIT-VERSION-GEN and various tricks in Makefile do just that, not only
for compiled parts, but also for scripts.

[...]
--=20
Jakub Narebski
Poland
