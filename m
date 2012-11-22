From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/4] nd/unify-appending-of-s-o-b
Date: Thu, 22 Nov 2012 23:38:05 +0700
Message-ID: <1353602289-9418-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 20:33:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcWM-00019y-II
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068Ab2KVTcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 14:32:52 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:64313 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757012Ab2KVTcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:32:50 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2315006dak.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hY6E6YP9q97tC3p1QwB8Pvpz1EZpbgRsJt/grRwfNZI=;
        b=0LAeLcm26xX2sK5TxrFpar03yMttfLEMFU94zNJwABMN8zwPPt3zNhwly8JWS982sN
         0Cdmzv1Pf0mh3Zsa3XNOsILOFjIIA58oBN/Mc14IQiJh0Fr0nOPzetqegSbO/I82pq3H
         nMnjdFcSvjbOyiNVs3qdwpCPyBFWP1kyr7WuQ6IXwguRHHYi/Fz5gvDu9Hq7M385/uS+
         dYjThJmWn57JkG7v89AypY0aaPtXqA7SB5o4LBpdXz+LXeJXmwQ1RcjTiObRywG/YNkc
         Lsc3hJHaQ89cHuEG9kZ05HKyUQX12bQYOZl6+JJUcyfP0FSXVYvBwkP7iZGsHNfuV6X7
         brBQ==
Received: by 10.68.241.232 with SMTP id wl8mr6088813pbc.144.1353602282455;
        Thu, 22 Nov 2012 08:38:02 -0800 (PST)
Received: from lanh ([115.74.40.93])
        by mx.google.com with ESMTPS id ku7sm2304372pbc.0.2012.11.22.08.37.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 08:38:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 22 Nov 2012 23:38:13 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210196>

This round cherry-pick and commit only skip S-o-b if the last one is
the same while format-patch skips it if the same one appears
anywhere in S-o-b list. I don't have strong opinion about which way is
more correct. Though if we decide to change format-patch behavior, the
series may become a bit different.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  t4014: more tests about appending s-o-b lines
  format-patch: stricter S-o-b detection
  format-patch: update append_signoff prototype
  Unify appending signoff in format-patch, commit and sequencer

 builtin/commit.c        |  10 ++-
 builtin/log.c           |  13 +---
 log-tree.c              |  66 +++++++++++++---
 log-tree.h              |   4 +
 revision.h              |   2 +-
 sequencer.c             |  65 +---------------
 sequencer.h             |   4 -
 t/t4014-format-patch.sh | 199 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t7501-commit.sh       |   2 +-
 9 files changed, 272 insertions(+), 93 deletions(-)

--=20
1.8.0.4.g5d0415a
