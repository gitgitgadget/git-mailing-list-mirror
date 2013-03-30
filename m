From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/12] Layout control placeholders for pretty format
Date: Sat, 30 Mar 2013 16:35:00 +0700
Message-ID: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:35:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsCJ-0001oW-J1
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab3C3JfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:35:09 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58131 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab3C3JfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:35:08 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so654353pab.35
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=FTsC0kYPpBOJZRxL3SNE+xkDT58uFqtfwJCK16TaYOM=;
        b=F9+y8HJqzem0hHY/77PeRRVKoHnixywysbWj0qNd3M4jNw+3HIAlD5Soe6LOUSg3N5
         vcJX/57OUk5mwHbCy53+TrNr0sCX8VBATqOOlge5BblNv30YHUdJScU1zHS9PXNZg8xP
         FJQo1z/fAdujC0Iuj9mtwDdR0QUNIM77g2Wnq7jKhlVF37u5fwWDSZqXaDYlrcYJMA/C
         G/CFwCUlxDEWTGCPNslGaaPzszJa2O4W9pnwUqrqcmxk+4ufwO9eBh7hvWYc7FEVgxtu
         UM8owmlFgowI/0JM+f4Da1Un31xENOE5/zkRutKVxOwFz0izwL758ZCB1+SEOQYa3U2z
         Qs5Q==
X-Received: by 10.68.180.193 with SMTP id dq1mr8055139pbc.67.1364636107915;
        Sat, 30 Mar 2013 02:35:07 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id ef3sm6799193pad.20.2013.03.30.02.35.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:35:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:35:12 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219569>

The only difference in v2 is typo fixes (mostly in commit messages,
but some in pretty-formats.txt). Also resend as a reminder to Junio if
he forgot to pick it up.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  pretty-formats.txt: wrap long lines
  pretty: share code between format_decoration and show_decorations
  utf8.c: move display_mode_esc_sequence_len() for use by other
    functions
  utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
  pretty: save commit encoding from logmsg_reencode if the caller needs
    it
  pretty: get the correct encoding for --pretty:format=3D%e
  utf8: keep NULs in reencode_string()
  pretty: two phase conversion for non utf-8 commits
  pretty: add %C(auto) for auto-coloring on the next placeholder
  pretty: support padding placeholders, %< %> and %><
  pretty: support truncating in %>, %< and %><
  pretty: support %>> that steal trailing spaces

 Documentation/pretty-formats.txt |  34 ++++-
 builtin/blame.c                  |   2 +-
 builtin/commit.c                 |   2 +-
 builtin/fast-export.c            |   3 +-
 builtin/mailinfo.c               |   3 +-
 commit.h                         |   1 +
 compat/precompose_utf8.c         |   2 +-
 log-tree.c                       |  60 +++++----
 log-tree.h                       |   3 +
 notes.c                          |   4 +-
 pretty.c                         | 282 +++++++++++++++++++++++++++++++=
+++-----
 revision.c                       |   2 +-
 sequencer.c                      |   5 +-
 t/t4207-log-decoration-colors.sh |   8 +-
 t/t6006-rev-list-format.sh       |  12 +-
 utf8.c                           | 104 +++++++++++----
 utf8.h                           |  14 +-
 17 files changed, 434 insertions(+), 107 deletions(-)

--=20
1.8.2.83.gc99314b
