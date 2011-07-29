From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 06:19:44 -0700 (PDT)
Message-ID: <m3pqktql6s.fsf@localhost.localdomain>
References: <1311934832699-6632987.post@n2.nabble.com>
	<4E329EDB.6040007@hupie.com>
	<1311940877783-6633274.post@n2.nabble.com>
	<m339hps2is.fsf@localhost.localdomain> <4E32AE7C.70004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: llucianf <llucianf@gmail.com>, git@vger.kernel.org,
	Ferry Huberts <mailings@hupie.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 29 15:19:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmmyl-0005iB-Sv
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 15:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab1G2NTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 09:19:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52886 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1G2NTq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2011 09:19:46 -0400
Received: by fxh19 with SMTP id 19so2291158fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=YQ3HHbSjAdrtIj1PSXJQQWB/YENmsygyIPJz3LWcTXs=;
        b=s+/kNKWgwo4/ztBPwdSRJQTPNdZogsM2cSraJnB+c9/VDikzEyl+KVCy0dZ5H9ON5U
         lSQ1OobtVSHeF83y5zS939GCNzNcjAVS7x+LXvSO51GZIKi/BQGhiUwrmrz5Wpc0eTCS
         szNfP0h0aPf5HkQ52HU+5igDiIxCRhf6JMRNI=
Received: by 10.223.145.7 with SMTP id b7mr1815800fav.56.1311945585439;
        Fri, 29 Jul 2011 06:19:45 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id a24sm1090712fak.12.2011.07.29.06.19.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 06:19:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6TDJ8aL011137;
	Fri, 29 Jul 2011 15:19:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6TDIpWl011133;
	Fri, 29 Jul 2011 15:18:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E32AE7C.70004@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178148>

Johannes Sixt <j.sixt@viscovery.net> writes:
> Am 7/29/2011 14:19, schrieb Jakub Narebski:
> > For that you can use 'assume-unachanged' mechanism (note: it is loc=
al
> > to repository).  The gitignore(7) manpage says:
> >=20
> >   NOTES
> >      The purpose of gitignore files is to ensure that certain files=
 not tracked
> >      by git remain untracked.
> >=20
> >      To ignore uncommitted changes in a file that is already tracke=
d, use
> >      `git update-index --assume-unchanged <file>`.
>=20
> This statement in our documentation is *wrong*!! Please do not sugges=
t it
> for cases like the OP's!
>=20
> See the discussion of assume-unchanged in git-update-index: This bit
> actually means that git may assume that the file was not changed, and=
 it
> can take the worktree's data when it otherwise would have to unpack t=
he
> index's data. IOW, using it for the purposes that the OP would need i=
s
> *dangerous*.

Are you sure?  It seems to work as I thought it would.

  $ git init
  Initialized empty Git repository in /tmp/jnareb/test/.git/
  [master!test]$ echo foo >foo
  [master!test]$ echo bar >bar
  [master!test]$ echo bar >.gitignore
  [master!test]$ git add .
  [master!test]$ git commit -m Initial
  [master (root-commit) 522267b] Initial
   2 files changed, 2 insertions(+), 0 deletions(-)
   create mode 100644 .gitignore
   create mode 100644 foo
  [master!test]$ git add -f bar
  [master!test]$ git commit -m 'Add bar (ignored)'
  [master a708f70] Add bar (ignored)
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 bar
  [master!test]$ echo foo >>foo
  [master!test]$ echo bar >>bar
  [master!test]$ git status -s
   M bar
   M foo
  [master!test]$ git update-index --assume-unchanged bar
  [master!test]$ git status -s
   M foo
  [master!test]$ git commit -a -m "assume-unchanged bar, both changed"
  [master ec74f8e] assume-unchanged bar, both changed
   1 files changed, 1 insertions(+), 0 deletions(-)
  [master!test]$ git status -s
  [master!test]$ git show
  commit ec74f8e3f3f819bba22453324d7659fe8dd253e8
  Author: Jakub Narebski <jnareb@gmail.com>
  Date:   Fri Jul 29 44 2011 +0200
 =20
      assume-unchanged bar, both changed
 =20
  diff --git a/foo b/foo
  index 257cc56..0d55bed 100644
  --- a/foo
  +++ b/foo
  @@ -1 +1,2 @@
   foo
  +foo

Notice that change to 'bar' didn't get comitted.

--=20
Jakub Nar=EAbski
