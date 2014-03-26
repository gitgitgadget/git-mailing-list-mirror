From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/17] git-ls
Date: Wed, 26 Mar 2014 20:48:00 +0700
Message-ID: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:47:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoBD-0007TE-20
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbaCZNrj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:47:39 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:56424 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaCZNri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:47:38 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so1951403pad.30
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2Al6XOGW0nlFt99KO3Zs0D7Ln9zYwT2izfMZM9jT8eA=;
        b=IMa3iMrbPXUx0cbvDNkfKqzYdhfgnCrJi28mS36+NT9QBlufRlEyQ2BkTgbij7LaNm
         kq5+q3DDWzghTvxenRDQ2vO3sfZesmh/ugWGxpeZzSU6pXxzilDIBJhxJgVbnF2y2w3e
         IsPdAscGW8+cOT6X22SWrU9VjIOr0K5hyHKDnFH4AfGENi0ruskIU2tkldOe2J6p51e6
         TpHaVAdsWAUUPdU1AVM/UDMIppzLZkEPRbyj0FL7XO1DzpQNbCDIUDKb/VwpC+3hIxVV
         KXvD9t9gBuFU8FMqS77aay9tnwIG8CgBFpLtu7pUmmSEcBBPMFuR9ojBpiSTJuX3NHj2
         qetw==
X-Received: by 10.68.2.99 with SMTP id 3mr86778497pbt.49.1395841657569;
        Wed, 26 Mar 2014 06:47:37 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id oz7sm58523165pbc.41.2014.03.26.06.47.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:47:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:48:29 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245179>

Compared to v1, git-ls now does not accept ls-files options (previous
git-ls is more like an alias of ls-files). I want this because ls may
take a different set of options than ls-files. Most functionality is
shared so if you're not happy with ls, you can fall back to ls-files.

New alias options are supported, -1 =3D=3D --no-column, -R =3D=3D
--max-depth=3D-1. If more than one file criteria is chosen (e.g. "ls -c=
mo")
then --tag is implied. File order is fixed ("ls-files -cmo" actually
shows two or three separate listings, "ls -cmo" shows one sorted
listing). It also shows directories from the index.

Documentation is there. No tests yet because the behavior may still
need some polishing.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (17):
  ls_colors.c: add $LS_COLORS parsing code
  ls_colors.c: parse color.ls.* from config file
  ls_colors.c: add function to color a file name
  ls_colors.c: highlight submodules like directories
  ls-files: buffer full item in strbuf before printing
  ls-files: add --color to highlight file names
  ls-files: add --column
  ls-files: support --max-depth
  ls-files: split main ls-files logic into ls_files() function
  Add git-ls, a user friendly version of ls-files and more
  ls: -u does not imply showing stages
  ls: add -R/--recursive short for --max-depth=3D-1
  ls: add -1 short for --no-column in the spirit of GNU ls
  ls: add -t back
  ls: sort output and remove duplicates
  ls: do not show duplicate cached entries
  ls: show directories as well as files

 .gitignore                     |   1 +
 Documentation/config.txt       |  22 ++
 Documentation/git-ls-files.txt |  22 ++
 Documentation/git-ls.txt (new) |  95 ++++++++
 Makefile                       |   2 +
 builtin.h                      |   1 +
 builtin/ls-files.c             | 446 +++++++++++++++++++++++++++++----=
---
 color.h                        |  10 +
 command-list.txt               |   1 +
 git.c                          |   1 +
 ls_colors.c (new)              | 496 +++++++++++++++++++++++++++++++++=
++++++++
 11 files changed, 1012 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/git-ls.txt
 create mode 100644 ls_colors.c

--=20
1.9.1.345.ga1a145c
