From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sat, 10 Aug 2013 18:34:59 +0200
Message-ID: <20130810163459.GE25779@paksenarrion.iveqy.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
 <20130810125140.GD25779@paksenarrion.iveqy.com>
 <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Sedat Kapanoglu <sedat@eksiteknoloji.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 18:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8C4i-0004Em-3h
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 18:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182Ab3HJQb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 12:31:28 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:52005 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965078Ab3HJQb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 12:31:26 -0400
Received: by mail-lb0-f175.google.com with SMTP id 13so3813253lba.6
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=noxxPtdAQhdYUORN1MLpR0+nKhSBdfCgfuIMMPaMOJQ=;
        b=t7JNy7qd0YWUNJnowlaUe88IaWWGiqtiWRmAkVOhUe0ysGxFSYy4wcC3FdhNZSFAeX
         dZe79o0IGhdJdlLpkvWi1ZKbT3lQMCVSZ6HUYz9O5J7/bVOHeUwpORFp7QNzADzlNSBF
         Pn/Jeu93H8q0H7ilx3AZQgSv55qLvdnzeiH77pVbSAakGIcwYc1xlf5nzGd5gN1zsLlT
         Y10ImVQYv9XYwjozefW3ehFF2R8f25Ttj7tHMZJlbV/PlJtKTTLrMjGx2yzfNPmq7wz3
         AeEj0bRqlSsYXuPtSATXfrZrhjEQPsnGvPD+B8BmCb6OWE7TYq55Q798R+JkX4oJ85AJ
         Fl6g==
X-Received: by 10.112.57.49 with SMTP id f17mr1172173lbq.26.1376152285097;
        Sat, 10 Aug 2013 09:31:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id w5sm8349019lbw.3.2013.08.10.09.31.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 09:31:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V8C83-0000T9-4S; Sat, 10 Aug 2013 18:34:59 +0200
Content-Disposition: inline
In-Reply-To: <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232105>

On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat Kapanoglu wrote:
> > git is a disk intense program, so this setup is not sane at all. Wi=
th
> > that said I know that git on windows historically had problems with
> > working on smb-mounted shares (sometimes you're forced to have stup=
id
> > setups). I doubt that git really is the right tool for your work, s=
ince
>=20
> I reproduced the same problem in a regular symlink directory. Repro s=
teps:
>=20
> mkdir actualdir
> mklink /d symdir actualdir
> cd symdir
> git init .
>=20
> fatal: Invalid symlink 'D:/gitto': Function not implemented
>=20
> Thanks,
>=20
> Sedat

Good, then we can determinate that this is a symlink error, it seams
that readlink() isn't implemented in the msysgit version of msysgit.

However msysgit should have a implementation of readlink() according to=
:
http://mingw.5.n7.nabble.com/Replacement-for-readlink-td30679.html

I've CC:ed the msysgit-maillist so that they can decide if this is
something they want to address in newer releases.

(In the git source code the readlink call in this abspath.c)

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
