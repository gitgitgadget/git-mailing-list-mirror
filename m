From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 00/13] nd/pretty-formats
Date: Fri, 19 Apr 2013 09:08:39 +1000
Message-ID: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:09:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxx2-00074V-Jw
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab3DRXJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:09:07 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62187 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3DRXJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:09:06 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so1889122pab.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NF6WXMv7yt0l8+7hnUfnTzD+AHZJlJDiQXLnx8ZCCFM=;
        b=g5a4vlT1MnXxtyac8YWo7XGXPXtR7JYuFnuaKaLtwRvqV5l4Ic9ONDHe7J781UyN2j
         7lRBr9TssWPTiEVlKLIZqGVfck4Ldb+sVH7q2KCP/wS8zowiPNn97DT/t9kWnCQpSdr5
         I5ZyceiZfQqtwiB8HX50jlC4k62mZ8fQjMrK+TkrbEz2CKhYSfFOFWKFFZixcNmlQJsi
         8fhiX5YihB1swaKDGSCEuE++ugUCJ1ZHZyXfoFa4nifoVyTvHPbMvcI2fzr8BQdxLWKb
         XmDAk0ZCH3kShz5VapuqzfyvrYo6EFj6e4KwBhcm031GQksiBsWXEoEIEuh7IjvbydS3
         sA6w==
X-Received: by 10.68.138.7 with SMTP id qm7mr15968516pbb.169.1366326544701;
        Thu, 18 Apr 2013 16:09:04 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id zv4sm11179309pbb.28.2013.04.18.16.09.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:09:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:08:54 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221702>

v4 fixes comments from v3, mainly in the auto-coloring patch, and uses
qz_to_tab_space for changes in t4205. It also fixes a coding style
issue in 06/13, spotted in v2 but I missed it in v3.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (13):
  pretty: save commit encoding from logmsg_reencode if the caller needs=
 it
  pretty: get the correct encoding for --pretty:format=3D%e
  pretty-formats.txt: wrap long lines
  pretty: share code between format_decoration and show_decorations
  utf8.c: move display_mode_esc_sequence_len() for use by other functio=
ns
  utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
  utf8.c: add reencode_string_len() that can handle NULs in string
  pretty: two phase conversion for non utf-8 commits
  pretty: split color parsing into a separate function
  pretty: add %C(auto) for auto-coloring
  pretty: support padding placeholders, %< %> and %><
  pretty: support truncating in %>, %< and %><
  pretty: support %>> that steal trailing spaces

 Documentation/pretty-formats.txt |  35 +++-
 builtin/blame.c                  |   2 +-
 builtin/commit.c                 |   2 +-
 commit.h                         |   1 +
 compat/precompose_utf8.c         |   2 +-
 log-tree.c                       |  48 ++++--
 log-tree.h                       |   1 +
 pretty.c                         | 358 +++++++++++++++++++++++++++++++=
+-------
 revision.c                       |   2 +-
 t/t4205-log-pretty-formats.sh    | 175 +++++++++++++++++++
 t/t4207-log-decoration-colors.sh |   8 +-
 t/t6006-rev-list-format.sh       |  12 +-
 utf8.c                           | 104 +++++++++---
 utf8.h                           |  23 ++-
 14 files changed, 648 insertions(+), 125 deletions(-)

--=20
1.8.2.82.gc24b958
