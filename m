From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/19] Add git-list-files
Date: Sun, 30 Nov 2014 15:55:48 +0700
Message-ID: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:56:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0Is-0002R2-Nu
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaK3I4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:56:22 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50220 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaK3I4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:56:21 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so9015666pdb.29
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=dtwEf0d8BJ8UISGBBcUPQ4XGWRsU4y2xFzScUb+8y8A=;
        b=CskEkAkpaXCSRifK+n0ObDS6LD//0AvyQF51KIQNCNrsxsKAZe0M+/t4GfY9eZanLx
         ATWV0Otv5kf9xFphIpW29TvCdXt9E6y61ypPPMZlhdmI3WL7upibNzF5NdNtfPqG7FIG
         GMCq9uIN8myVyyVt8B7UY5wGDJAegx4kO0rIEkbqC1hI60WlsJJhlEKalYlWmm+I8oIu
         p4gWtfV8eDu216Fy7OFUVJpparJxJSuYSFOPaNZ5zzYkjcGEzLamkbfpWFjxDx7avqbx
         hNJoOEzHiY5ia1Mi6+7WlpaFeS6T9ncqhhM/8O3NnZ9OxRpB2CvrO+936SpCFZ2wuRzW
         6XqA==
X-Received: by 10.70.37.35 with SMTP id v3mr28887738pdj.4.1417337781138;
        Sun, 30 Nov 2014 00:56:21 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id sq2sm14287772pbc.73.2014.11.30.00.56.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:56:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:56:19 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260423>

This is something else that's been sitting in my tree for a while now.
It adds "git list-files", intended to be aliased as "ls" with your
favourite display options.

As you can guess it's a friendlier version (and pretty close to GNU
ls) of ls-files. On one hand, I think this is a nice addition. On the
other hand, code bloat. Last version on the list is

http://thread.gmane.org/gmane.comp.version-control.git/244530/focus=3D2=
45464

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (19):
  ls_colors.c: add $LS_COLORS parsing code
  ls_colors.c: parse color.ls.* from config file
  ls_colors.c: add a function to color a file name
  ls_colors.c: highlight submodules like directories
  ls-files: buffer full item in strbuf before printing
  ls-files: add --color to highlight file names
  ls-files: add --column
  ls-files: support --max-depth
  Add git-list-files, a user friendly version of ls-files and more
  list-files: -u does not imply showing stages
  list-files: add -R/--recursive short for --max-depth=3D-1
  list-files: add -1 short for --no-column
  list-files: add -t back
  list-files: sort output and remove duplicates
  list-files: do not show duplicate cached entries
  list-files: show directories as well as files
  list-files: add -F/--classify
  list-files -F: show submodules with the new indicator '&'
  list-files: -M aka diff-cached

 .gitignore                             |   1 +
 Documentation/config.txt               |  22 ++
 Documentation/git-list-files.txt (new) |  99 +++++++
 Documentation/git-ls-files.txt         |  20 ++
 Makefile                               |   2 +
 builtin/ls-files.c                     | 415 ++++++++++++++++++++++++-=
--
 color.h                                |  10 +
 command-list.txt                       |   1 +
 git.c                                  |   1 +
 ls_colors.c (new)                      | 496 +++++++++++++++++++++++++=
++++++++
 10 files changed, 1034 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/git-list-files.txt
 create mode 100644 ls_colors.c

--=20
2.2.0.60.gb7b3c64
