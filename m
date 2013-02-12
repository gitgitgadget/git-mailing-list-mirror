From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/4] count-objects improvements
Date: Tue, 12 Feb 2013 16:27:53 +0700
Message-ID: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 10:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5C9t-0002Yv-T0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 10:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993Ab3BLJ1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 04:27:49 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:50851 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758640Ab3BLJ1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 04:27:13 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so3184796dan.9
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 01:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2zKUqM1YKqcuAsa0FbikKYyaPYlXjaLns42Hgwibuc4=;
        b=vKzrxqsw25MfU/A85YbZHggrzt354gNTHujqvxKrzRuuXAWJf12fIGubOwTxoIGToU
         vEMJBCX2ijTLgZmKpMKjQkDjiILydsj35KBbNwJPIo3DA9TTvF11Y71K4Ry8Qv74yNwm
         P9ZNVxx0Na+AlIgVmhsnVECrcQU9U1LhM8ui21a99ZrdysgZ6B95gG0niQTKUHTneX41
         3v/l01lahu1huft4RvqyoU5QgDjqbUf1b9BwvuW7uVtx/5AeEBtltuHHw/kTO/eTy76T
         BmiDIzIe8eiNXhZIm4zh5CXdj8IS9S+5CgwTYAcKLXv97hFKdhebhp0GVD4l4uR79AZR
         a2sA==
X-Received: by 10.66.81.231 with SMTP id d7mr50166524pay.27.1360661232332;
        Tue, 12 Feb 2013 01:27:12 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id k7sm60177484paz.13.2013.02.12.01.27.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 01:27:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Feb 2013 16:27:59 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216127>

Compared to v2 [1], this version
 - fixes sparse warning
 - restructures 2/3 (now 3/4) to make it easier to read
 - report "path too long" instead of "garbage found" in
   .git/path/too/long/pack-xxx.pack case
 - changes output prefix "error:" to "warning:"

[1] http://thread.gmane.org/gmane.comp.version-control.git/215378/focus=
=3D215744

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  git-count-objects.txt: describe each line in -v output
  sha1_file: reorder code in prepare_packed_git_one()
  count-objects: report garbage files in pack directory too
  count-objects: report how much disk space taken by garbage files

 Documentation/git-count-objects.txt |  22 ++++++--
 builtin/count-objects.c             |  43 +++++++++++---
 cache.h                             |   3 +
 sha1_file.c                         | 108 ++++++++++++++++++++++++++++=
+++-----
 4 files changed, 148 insertions(+), 28 deletions(-)

--=20
1.8.1.2.536.gf441e6d
