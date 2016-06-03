From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/6] worktree.c: add is_main_worktree()
Date: Fri,  3 Jun 2016 19:19:40 +0700
Message-ID: <20160603121944.28980-3-pclouds@gmail.com>
References: <20160530104939.28407-1-pclouds@gmail.com>
 <20160603121944.28980-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:20:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8o5V-0002zT-JF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbcFCMUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:20:22 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35897 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbcFCMUS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:20:18 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so5901921pad.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pxxVhVGoxpl6Ypc2UDPu5N3VBmR4VbYnnAgz7K8Hi8=;
        b=e1fdV3AMhPn5ONnxKxtYiuO7dNko0DwFY8o+bWtCy87xhhcFZ4i8FMH/O+WVnRtdZR
         vUc/fCFm6d7SHL1PD8m1xMjerX3M/lACGMGJj8IJtkDDFd0nbv9u8FmmWe40yavHznyZ
         DVSTETWH7OiggCQjqu8scjMg3nVlc0tVtUi46z69Mj43MbwuUzudro2SnxUcqRhknS8a
         bDWRDe1QlTIDBO6O7+AO9cYZeN+/bvJJMYQH18aap/lnMaQK1eK9J+xv9yCEEiO1S1vB
         6nDDDM7l68LbB5OhLirpcHgW/G3OyNLJTsNRVs7T0IoeLYS/MIeZJU4gRK721iAoN1E2
         c2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pxxVhVGoxpl6Ypc2UDPu5N3VBmR4VbYnnAgz7K8Hi8=;
        b=JGlNG4VvUXtOq21eOY1o5JCafuGRG6toGTKpvKxz3Ubop/Xm9XXQJMbY2g+kKKJ49O
         16eLUvlHTwuDRqdRneMjnzOnMUFDABI6oZrp0xK7AT7q5uYdmLijUv1Iil+fnDi2IWAO
         s/Hf4zh70DbnOI5RHtW+j1W/yxfcOQ6vXUDzCm4limHfyo42Mtxr1+TDzwt+82UidATC
         tMlIORaMlO/ccWqU1tAVvg+Yd/o2DLUcfW+giwDOslkRTSD6jLNQZlnHFExKtiE2nd6/
         NS5c+jU90bL1XZeaEiD0kNI4WKB5TLdQAyonh3lLdRErTGvZfgTmNI15X69/1hKZl6Id
         EArw==
X-Gm-Message-State: ALyK8tKqN1RBWBjI0TtH71xRW6d74WpqbyFBUNp3n3Bh3PwUJVXb+NZRucEc6qKyjohL2g==
X-Received: by 10.66.145.195 with SMTP id sw3mr4997698pab.36.1464956417690;
        Fri, 03 Jun 2016 05:20:17 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id x19sm8115585pfi.81.2016.06.03.05.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 05:20:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 19:20:12 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296310>

Main worktree _is_ different. You can lock (*) a linked worktree but no=
t
the main one, for example. Provide an API for checking that.

(*) Add the file $GIT_DIR/worktrees/xxx/locked to avoid worktree xxx
from being removed or moved.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 5 +++++
 worktree.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/worktree.c b/worktree.c
index 554f566..eb3aaaa 100644
--- a/worktree.c
+++ b/worktree.c
@@ -229,6 +229,11 @@ struct worktree *find_worktree(struct worktree **l=
ist,
 	return *list;
 }
=20
+int is_main_worktree(const struct worktree *wt)
+{
+	return !wt->id;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 7ad15da..e1c4715 100644
--- a/worktree.h
+++ b/worktree.h
@@ -37,6 +37,11 @@ extern struct worktree *find_worktree(struct worktre=
e **list,
 				      const char *prefix,
 				      const char *arg);
=20
+/*
+ * Return true if the given worktree is the main one.
+ */
+extern int is_main_worktree(const struct worktree *wt);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
