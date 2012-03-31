From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Purging old history
Date: Sat, 31 Mar 2012 01:25:27 -0700 (PDT)
Message-ID: <m37gy1b2j0.fsf@localhost.localdomain>
References: <17650-1333167969-40275@sneakemail.com>
	<CALkWK0=mcQR3CBMpa5P1f+JwqNMqUs3D4=tVPx4c_4R+TXCKbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John M. Dlugosz" <ngnr63q02@sneakemail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 10:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDtdU-0007RF-DH
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 10:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab2CaIZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 04:25:33 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50889 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab2CaIZa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 04:25:30 -0400
Received: by wgbds11 with SMTP id ds11so1226343wgb.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=SRwQOfBqodcV5l+bAwawhF3d9D60toweeufmR7geTzc=;
        b=uC0UFza+gyik5zkVFIYLOvoPSiJEuiEqw93ubFnKrEU8zpOhhFOw0X+8L7corRDQei
         OAZkYVa5mLHeEFM1i62VtO9diXklpf+djDpORdwU9Ro9peBgxYWu/WWHjnUy5DOHWj8l
         onrnXBqRIvioyKrzXg6euk2tSidQrU7spJsrPnpgx0P9s3zQyMKq+oGencE9/hyDwFuV
         q6OKXXJy1Uo1okmVl49SNLWIFengQe8KnJ+2w6/B747BVbtNxPRnFW+lXDfAyU1tqb3Y
         lA5f6K1p0T5FtrK0f79FFqJpuwORijgZ7Dy1ENUzxpfYUR8FfAQeGfDvrUp322Ju6Uqj
         EmxQ==
Received: by 10.180.96.228 with SMTP id dv4mr5046252wib.14.1333182328481;
        Sat, 31 Mar 2012 01:25:28 -0700 (PDT)
Received: from localhost.localdomain (addb154.neoplus.adsl.tpnet.pl. [79.184.53.154])
        by mx.google.com with ESMTPS id e6sm13730357wix.8.2012.03.31.01.25.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 01:25:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2V8PP0u000953;
	Sat, 31 Mar 2012 10:25:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2V8POEK000950;
	Sat, 31 Mar 2012 10:25:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CALkWK0=mcQR3CBMpa5P1f+JwqNMqUs3D4=tVPx4c_4R+TXCKbw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194437>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
> John M. Dlugosz wrote:

> > Is there a simple way to delete old commits, say beyond a certain a=
ge,
> > before putting it on the server? =A0The ancient stuff is not releva=
nt and
> > there are a lot of binaries. =A0Some users may have trouble with an=
 extensive
> > download when syncing the first time.

It seems that you have XY problem.

One solution to extensive initial download is to create a git-bundle
of all commits up to e.g. some tag, and host it using HTTP, FTP
(which are resumable), or even P2P like BitTorrent.
=20
Another solution would be to educate users to use shallow clones,
i.e. use "--depth" option to git-clone... and help git developers make
shallow clones better (there are some unncessary limitations in using
shallow clones).

> Yes, although your terminology is wrong: it's not about "deleting"
> commits; simply create a fresh root commit and rebase your work on to=
p
> of it.  As an example, let's say you want to squash history from the
> 67afe1 (the old root) to 7ef42b on the master branch:
>=20
> $ git checkout -b newroot 7ef42b
> $ git reset 67afe1
> $ git add .
> $ git commit --amend
> $ git checkout master
> $ git rebase --onto newroot 7ef42b

A simpler solution, one that would work also in presence of merges, is
to use grafts mechanism (see gitrepository-layout(5)) to cauterize
history, check using git-log or gitk that shortened history is
correct, make grafts permanent altering history with
git-filter-branch, and finally removing grafts.

P.S. Please read first all the warnings about rewriting history, and
about all its disadvantages for downstream.

--=20
Jakub Narebski
