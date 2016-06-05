From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/6] fetch: change flag code for displaying tag update and deleted ref
Date: Sun,  5 Jun 2016 10:11:38 +0700
Message-ID: <20160605031141.23513-4-pclouds@gmail.com>
References: <20160603110843.15434-1-pclouds@gmail.com>
 <20160605031141.23513-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 05:12:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OU8-0004V0-4v
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbcFEDMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 23:12:14 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35192 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFEDML (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:12:11 -0400
Received: by mail-pa0-f67.google.com with SMTP id gp3so9012968pac.2
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4UTl+AR6cHDUrZEeGz+BpzZ7RNAkLhtoF0XwXTrTNQ=;
        b=E+NP7KLxxBEnEhlQW1ELe/OSzgbPshM38xm5fP/9jjDGGoj31+LqiyB3BXUXQKBdAm
         fu+r6Rgqeh/0v+Mlfq6jggH+hyfkyiHh2mV1PSjAs9XnEYQ17HdI0LiQwSV3wNkv9Pw9
         2909uDSBqmG3VCGU4raAZLzVyy5K6i6UA+RSjW9PWAA3aT+WTXQY5J/jo2eBGL9LTY5H
         bpFt7RvnbDV8WfNd5Dh2aCboieidQEspnBp+lr0sCZcF/B4DDLHpuWar8zoirLd7D0Ii
         r4nhU+4nqjhzXQj3NjleucaW3rWYR1J/TyjSsBYpakk+G75ELckT18fOHgYQMR2dKppj
         843g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4UTl+AR6cHDUrZEeGz+BpzZ7RNAkLhtoF0XwXTrTNQ=;
        b=aS5zXOEDnliDDZa28mcTJoAPKyrNmSOLA+t7AAMXhIqtUNABYzUlXzLm3t/MPvGzpB
         L3vyTVgiooYxNeK+c4QpK1+NunRUOkrgTnDPKxhztKPk+z8EOZ0hNf0e1BrKAUEZLHIC
         qnOnBqT7HoF9TKaaQEhW6tpuOWTO3pn56Gwk0Guyd8C4kLNTbkhPCn3uIePuNR+ZwPJB
         jBEjsxl1HbAmZD7zFEz66jUCNgz3i1UIaYDBUrSA9yXw8TL9mBLX+CGf7ok0UFYJVTBo
         /6yLxcRFgIAMRytQWGG1r3RobD1v7w9yq6kT/u6ywcXeOZV0vYNDW9hQDbfE6uaKL9ME
         xq2g==
X-Gm-Message-State: ALyK8tL6F+5PImAtjHUWkXj+OCDFAQhl+Rba9WnB2hcHqnXhZ8Xf+oyzTzYIMISko2PCgA==
X-Received: by 10.66.84.164 with SMTP id a4mr15409776paz.90.1465096330881;
        Sat, 04 Jun 2016 20:12:10 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id j65sm18035390pfj.44.2016.06.04.20.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 20:12:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 05 Jun 2016 10:12:05 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160605031141.23513-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296454>

This makes the fetch flag code consistent with push, where '-' means
deleted ref.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fetch.txt | 4 ++--
 builtin/fetch.c             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index a0d0539..6c6b2c1 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -120,8 +120,8 @@ flag::
 	A single character indicating the status of the ref:
 (space);; for a successfully fetched fast-forward;
 `+`;; for a successful forced update;
-`x`;; for a successfully deleted ref;
-`-`;; for a successful tag update;
+`-`;; for a successfully deleted ref;
+`t`;; for a successful tag update;
 `*`;; for a successfully fetched new ref;
 `!`;; for a ref that was rejected or failed to update; and
 `=3D`;; for a ref that was up to date and did not need fetching.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a7f152a..8177f90 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -500,7 +500,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		int r;
 		r =3D s_update_ref("updating tag", ref, 0);
-		format_display(display, r ? '!' : '-', _("[tag update]"),
+		format_display(display, r ? '!' : 't', _("[tag update]"),
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref);
 		return r;
@@ -814,7 +814,7 @@ static int prune_refs(struct refspec *refs, int ref=
_count, struct ref *ref_map,
 				fprintf(stderr, _("From %.*s\n"), url_len, url);
 				shown_url =3D 1;
 			}
-			format_display(&sb, 'x', _("[deleted]"), NULL,
+			format_display(&sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), prettify_refname(ref->name));
 			fprintf(stderr, " %s\n",sb.buf);
 			strbuf_release(&sb);
--=20
2.8.2.524.g6ff3d78
