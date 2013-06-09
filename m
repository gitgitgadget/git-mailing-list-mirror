From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 00/15] Towards a more awesome git branch
Date: Sun,  9 Jun 2013 23:24:19 +0530
Message-ID: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:56:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljr7-0006L0-Op
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab3FIR4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:37 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37662 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab3FIR4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:36 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so3817913pad.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=vPxlQdFo1RpjeLjyM5eH9ae0Yr3ECNJeX/KVU4KCxrk=;
        b=k6Dwcpsr7t4RHKkLZ/N7X4EkPELn1OxOzxGx6hWWjZeD3/+YjESsha3LfNW9vCM3sZ
         wt2O/IplR4QkRSl+r2Qep9yFJra8eDMA3ZkX+ZdJR2oStKhgyPHAUc6QVZ1O7Te+lIl7
         Q0zB0iAtQYOPqh1ffvF6TKRa86mBvv+/E8bVExyi2msv9oT99qwvclDyUhdQg3FHhunf
         +f0OsVhGp0eJhQ26nZOSbnWIh8BQyUcf8TCVX2LQBTEK/2cz3FjP1CIB0V5l+oS87rPq
         KrRbDeMq+t2S37ZQ4qibm/TEZ0BrtAbb4f+wV85Qc0Jv12kUXfIpKg0ckCAcmmwvtmVa
         4qEg==
X-Received: by 10.68.129.10 with SMTP id ns10mr6954935pbb.13.1370800595946;
        Sun, 09 Jun 2013 10:56:35 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227057>

Hi,

This iteration contains some minor fixups (courtesy reviews by Eric
Sunshine and Junio), and some tests from Duy squashed in.  Also,
missing signoffs from Duy filled in.

Let's get this merged and work on stuff to do on top.

Thanks.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  for-each-ref, quote: convert *_quote_print -> *_quote_buf
  for-each-ref: don't print out elements directly
  pretty: extend pretty_print_context with callback
  pretty: allow passing NULL commit to format_commit_message()
  for-each-ref: get --pretty using format_commit_message()
  for-each-ref: teach verify_format() about pretty's syntax
  for-each-ref: introduce format specifier %>(*) and %<(*)
  for-each-ref: improve responsiveness of %(upstream:track)

Ramkumar Ramachandra (7):
  tar-tree: remove dependency on sq_quote_print()
  quote: remove sq_quote_print()
  pretty: limit recursion in format_commit_one()
  for-each-ref: introduce %(HEAD) marker
  for-each-ref: introduce %(upstream:track[short])
  pretty: introduce get_pretty_userformat
  for-each-ref: use get_pretty_userformat in --pretty

 Documentation/git-for-each-ref.txt |  43 +++++-
 builtin/for-each-ref.c             | 279 +++++++++++++++++++++++++++++=
+-------
 builtin/tar-tree.c                 |  11 +-
 commit.h                           |   9 ++
 pretty.c                           |  77 +++++++++-
 quote.c                            |  61 +++-----
 quote.h                            |   8 +-
 t/t6300-for-each-ref.sh            | 143 +++++++++++++++++++
 8 files changed, 521 insertions(+), 110 deletions(-)

--=20
1.8.3.247.g485169c
