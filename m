From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Mon, 29 Sep 2008 20:44:24 +0200
Message-ID: <200809292044.24799.jnareb@gmail.com>
References: <20080925235029.GA15837@neumann> <20080929150722.GU23137@genesis.frugalware.org> <20080929181856.GX23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-2?q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:45:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNkg-0006at-No
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbYI2Sog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Sep 2008 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYI2Sog
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:44:36 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:13553 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYI2Sof (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:44:35 -0400
Received: by ey-out-2122.google.com with SMTP id 6so618905eyi.37
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=F6xFwsn5u7zbsphJK6092+NqFQ/OmzORsahgLTuz4o8=;
        b=CrQDKITgeisZ8zHRLhVRfrj01YarCld0dptaexgBA7pNFkB0/DUgDpYLif0a1gkQOQ
         2tjaGbiqUCmS6tM0HZIzLBDoBtDRZvnRD2u1MLUiEcyIAZ9HiCyVS8UYllCayqzOB+iC
         vCMIJtIi9IQC0K0dOEI5LJIs33jlfXkuwyBM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SaiNh0B4Zz+bbJ3WozR7J+pyqcbZ9610ddDw5N57/Ee0e7IEcVckIoS1ZfXfSIxEn4
         GnUXPk08p/EPZOeHQbMYg6SXPwt21YbnZLY0a9N+Cehv1npZWdXZEZAl3mEnXU/VVQof
         fp46/3w0kBVy1LU3xXopz0wUyNO/rnLH/wwow=
Received: by 10.103.170.13 with SMTP id x13mr4065857muo.27.1222713873380;
        Mon, 29 Sep 2008 11:44:33 -0700 (PDT)
Received: from ?192.168.1.11? (abvx193.neoplus.adsl.tpnet.pl [83.8.221.193])
        by mx.google.com with ESMTPS id u26sm1477527mug.5.2008.09.29.11.44.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 11:44:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080929181856.GX23137@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97043>

Dnia poniedzia=B3ek 29. wrze=B6nia 2008 20:18, Miklos Vajna napisa=B3:
> On Mon, Sep 29, 2008 at 05:07:22PM +0200, Miklos Vajna <vmiklos@fruga=
lware.org> wrote:

> > > Currently parents of merge commits are 'reduce(HEAD + MERGE_HEAD)=
'
> > > in symbolic equation; I propose they would be simply 'MERGE_HEAD'=
=2E
> > > then we set this branch to new commit
> >=20
> > Yes. Currently - after a merge conflict - you are able to check wha=
t
> > heads caused were merged, which caused the conflict, but with this
> > approach you would not be able to. I think this would be a step bac=
k...
>=20
> Uh, I should read my mail before sending it next time.
>=20
> I just wanted to say that in case, for example, I merge A^ and A, but=
 I
> get a conflict after octopus tried to merge A^ then it can be a usefu=
l
> info to see that A^ was a head. Putting reduce(HEAD + MERGE_HEAD) to
> MERGE_HEAD would hide this info, which would make the situation worse=
,
> IMHO.

I don't understand: I thought that merge strategy gets _reduced_ heads.
Moreover, if head reduction reduces number of heads to two, you would
use twohead merge (recursive) instead of octopus, and fast-forward if
there is only one head after reduction.

All that I proposed is to put those reduced heads into MERGE_HEAD.
I did not proposed to put yet unresolved heads in MERGE_HEAD in case
of octopus merge conflict. I think either you misunderstood me, or
I misunderstood you.

Take for example the following case of
[H@repo]$ git merge a b c

   .---.---.---.---H                   <-- H <-- HEAD
                    \
                     \.---.---.---a    <-- a
                           \
                            \-b        <-- b
                               \                             =20
                                \--c   <-- c

Currently after failed merge we have:
HEAD:=20
  refs: refs/heads/H
MERGE_HEAD
  sha1(a)
  sha1(b)
  sha1(c)

I propose it to be
HEAD:
  refs: refs/heads/H
MERGE_HEAD
  sha1(a)
  sha1(c)

And merge strategy chosen would be twohead one (recursive).


If the situation was slightly different

   .---.---.---.---.--.---.---.---H    <-- H <-- HEAD
                    \
                     \.---.---.---a    <-- a
                           \
                            \-b        <-- b
                               \                             =20
                                \--c   <-- c


I propose it to be
HEAD:
  refs: refs/heads/H
MERGE_HEAD
  sha1(H)
  sha1(a)
  sha1(c)

And merge strategy chosen would be octopus.

--=20
Jakub Narebski
Poland
