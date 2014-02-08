From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] Ignore trailing spaces in .gitignore
Date: Sat,  8 Feb 2014 15:10:02 +0700
Message-ID: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 09:10:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC2zO-00071a-IG
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 09:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbaBHIKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 03:10:08 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53944 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaBHIKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 03:10:06 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so4151111pab.12
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 00:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=wG4Pm1/wEocw9qgFTA4krZi0AarbBZ0tYNLZp21YvtE=;
        b=wtmcP7jn0Q4tuzYvrlvkLRVv58Z2BlaRsrmJaxGTSyajathMnhlGmy9Poi3Je1TKt/
         NQ/M14FYVT1D2T0BMZWBc70szNaV+xG9zLG/Hoxakbyhf9RK+TgVv+LWDRqlXTxORPHW
         1zlcBNJHROfwbX8w4sYi4srmZVOE0RV+nbefxvKqe5UNL32LBIXX3KVzcyzvimxSJeZW
         1tnIFWmhCHkK7nYa5NOsiuq/fKI7iLj8u7qu0tLKtrYddwU09G87ccANxnN8xva/Bfiy
         BlVl7P0z2vC2BqaN6co1gKNFF+5GcA0zmmZ66JA12vDPHzZUuo8T1yDcIgh9BCR3kTRe
         h7Ug==
X-Received: by 10.66.155.133 with SMTP id vw5mr13054681pab.124.1391847006120;
        Sat, 08 Feb 2014 00:10:06 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id e6sm21068118pbg.4.2014.02.08.00.10.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 00:10:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Feb 2014 15:10:05 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241825>

Trailing spaces are invisible in most standard editors (*). "git diff"
does show trailing spaces by default. But that does not help newly
written .gitignore files. And trailing spaces are the source of
frustration when writing .gitignore.

So let's ignore them. Nobody sane would put a trailing space in file
names. But we could be careful and do it in two steps: warn first,
then ignore trailing spaces. Another option is merge two patches in
one and be done with it.

People can still quote trailing spaces, which will not be ignored (and
much more visible). Quoting comes with a cost of doing fnmatch(). But
I won't optimize it until I see someone shows me they have a use case
for it.

(*) either that or my coworkers keep pissing me off on purpose when
    they never clean trailing spaces.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  dir: warn about trailing spaces in exclude pattern
  dir: ignore trailing spaces in exclude patterns

 Documentation/gitignore.txt | 3 +++
 dir.c                       | 9 +++++++++
 2 files changed, 12 insertions(+)

--=20
1.8.5.2.240.g8478abd
