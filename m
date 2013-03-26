From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 16:48:44 +0700
Message-ID: <20130326094844.GA32583@duynguyen-vnpc.dek-tpc.internal>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Richard Weinberger <richard@nod.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Mar 26 10:49:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKQVP-0003ob-5o
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 10:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab3CZJsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 05:48:54 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42670 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab3CZJsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 05:48:53 -0400
Received: by mail-pd0-f180.google.com with SMTP id g10so2971678pdj.11
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=upcMAxUWdhEoBdNRoQAu77yvCWCaIBahTWXzfdbeZVY=;
        b=iZkMNH8Xa0ynocEAR8HuaQlvD9YbDoHjlpfxndbPFSSD61PbZC2QJsvFQ0wf+jjx9t
         33rQkahQriaA1AHBu4E1gGmtJr4wdQRWEGO7F6tqXqLL2xO5IjoXTlQbD20OOC/X6Zpm
         +MvjciXdzvb23RagKmIcWomw5DF5r54gxjAEwqOBM82PQWN0Vilhm49ohTb4MvLQnDWY
         zAdl//kbJoUFbYRRBHFkyrbN6EBQdJUQFHBIXG7bM0+s9ZpUAyGFBII2cSB9uHNYXZPC
         wgLduxON8o3YUHkcZH3kbr+GiFoPZNx1OEOR6m9x711XG9h4PwdMvEp4UBY/ouRpmhNz
         +ILw==
X-Received: by 10.66.164.97 with SMTP id yp1mr23018531pab.49.1364291333111;
        Tue, 26 Mar 2013 02:48:53 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id hw16sm18537547pab.19.2013.03.26.02.48.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 02:48:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 26 Mar 2013 16:48:44 +0700
Content-Disposition: inline
In-Reply-To: <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219149>

On Tue, Mar 26, 2013 at 08:02:30AM -0000, Philip Oakley wrote:
> >> Yeah, for historical reasons GIT_WORK_TREE defaults to $(pwd) when
> >> GIT_DIR is explicitly set.
> >
> > And it *WILL* be that way til the end of time.  Unless you are at
> > the top level of your working tree, you are supposed to tell where
> > the top level is with GIT_WORK_TREE when you use GIT_DIR.  Always.
>=20
> Should this important warning be part of the git(1) documentation on =
the=20
> environment variables (and possibly other places) given the consequen=
ces=20
> of this case? It wasn't something I'd appreciated from a simple readi=
ng.

Something like this, maybe?

-- 8< --
Subject: [PATCH] git.txt: document the implicit working tree setting wi=
th GIT_DIR

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7efaa59..ce55abf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -671,6 +671,8 @@ Git so take care if using Cogito etc.
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
 	The '--git-dir' command-line option also sets this value.
+	If neither GIT_WORK_TREE nor '--work-tree' is set, the
+	current directory will become the working tree.
=20
 'GIT_WORK_TREE'::
 	Set the path to the working tree.  The value will not be
--=20
1.8.2.82.gc24b958
-- 8< --
