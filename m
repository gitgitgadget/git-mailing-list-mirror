From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: Re: [PATCH] gitattributes.txt: mention exceptions to gitignore
 rules
Date: Tue, 4 Jan 2011 15:40:50 +0000 (UTC)
Message-ID: <ifvf22$g68$1@dough.gmane.org>
References: <iftvu6@dough.gmane.org>
	<1294147915-1475-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 16:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa90i-0003GU-Fz
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 16:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab1ADPlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 10:41:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:44211 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab1ADPlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 10:41:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pa90Q-00031N-WD
	for git@vger.kernel.org; Tue, 04 Jan 2011 16:41:03 +0100
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 16:41:02 +0100
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 16:41:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.133 (House of Butterflies; GIT 3b0ee7d master)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164497>

On Tue, 04 Jan 2011 20:31:55 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:

> gitattr and .gitignore are supposed to use the same rules for matchin=
g
> patterns. Unfortunately it's not exactly the same in reality. Mention
> the differences so users won't be surprised, until gitattr gets updat=
es.
>=20
>=20
> diff --git a/Documentation/gitattributes.txt
> b/Documentation/gitattributes.txt index 5a7f936..cfaf107 100644
> --- a/Documentation/gitattributes.txt +++
> b/Documentation/gitattributes.txt @@ -56,6 +56,7 @@ When more than on=
e
> pattern matches the path, a later line
>  overrides an earlier line.  This overriding is done per attribute.  =
The
>  rules how the pattern matches paths are the same as in `.gitignore`
>  files; see linkgit:gitignore[5].
> +However patterns that end with a slash is not supported.
> =20

I'm afraid that is not all. The rules I've inferred:

  1. No pattern will match directory tree.
  2. It is only possible to match on path components.
  3. If pattern contains slash it is treated as absolute.

Example for file: d1/d2/f1.c

Patterns that match:
  *.c
  d1/d2/*
  /d1/d2/*
  */d2/*
  */*/*

Patterns that do not match but should:
  d2/*
  d2/
  d2
  d1/d2
  /d1/d2
