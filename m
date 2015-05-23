From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Sat, 23 May 2015 09:22:56 +0700
Message-ID: <20150523022256.GA17789@lanh>
References: <555FD1EA.2060706@rightscale.com>
 <CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thorsten von Eicken <tve@rightscale.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 04:23:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvz5b-0002aw-BM
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 04:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175AbbEWCW6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2015 22:22:58 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34622 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883AbbEWCW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 22:22:58 -0400
Received: by pdbnk13 with SMTP id nk13so32046535pdb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w7JRc8oLE3PxsMgduHSNAMaH2xJKCpj7MuyxI5I3lOg=;
        b=NrKWGKDQXxR2e6j/Fs9Xs2psQ2SGqFmaQKN/xIolCM+ZuDOfKT0yJTuqTj8dB6fRmj
         Ewx19IyyFM8m9k61Nw+R03QI4G07YOK5QhaDPsmN39mg2F7zW8HCG4wi2yuRvUo13bXP
         uKoeWYFoWr812iVIzQKr3dQbcOhQer+d7MZIhvXJQXd151/QLMpF0CCrRPLklQeCwpFw
         zdxQdL4QO0df7EiLI6YLQSbl6g4RyvNc4HkpUYE8LUe7KKc7tsAdzgxhksM/xfvifcHZ
         Q8c6JH9G9A2O43YxkfBq64fnXIYuqLAcACle10tpkXOi/KoLZWyQT2B/AWFXKeoauqcQ
         uAWQ==
X-Received: by 10.68.135.36 with SMTP id pp4mr20969681pbb.134.1432347777701;
        Fri, 22 May 2015 19:22:57 -0700 (PDT)
Received: from lanh ([115.73.30.10])
        by mx.google.com with ESMTPSA id x2sm3351166pda.31.2015.05.22.19.22.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 19:22:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 May 2015 09:22:56 +0700
Content-Disposition: inline
In-Reply-To: <CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269791>

On Fri, May 22, 2015 at 07:03:48PM -0700, Junio C Hamano wrote:
> As far as I know, GIT_DIR was prepared as a mechanism to point at
> another .git directory that does not live inside the working tree, no=
t
> as a mechanism to rename it to arbitrary name. E.g.
>=20
>  $ git init
>  $ mv .git .svn
>  $ GIT_DIR=3D$(pwd)/.svn ; export GIT_DIR
>=20
> is not expected to work.

This is not the first time we get this report. Perhaps we should
document it.

-- 8< --
Subject: git.txt: mention the special name ".git" in GIT_DIR

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 90c5f37..91d6dd2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -691,6 +691,9 @@ Git so take care if using Cogito etc.
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
 	The '--git-dir' command-line option also sets this value.
++
+Note that if GIT_DIR is set explicitly to a directory inside working
+tree, the directory name must be ".git".
=20
 'GIT_WORK_TREE'::
 	Set the path to the root of the working tree.
-- 8< --
