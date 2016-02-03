From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/20] worktree.c: recognize no main worktree
Date: Wed,  3 Feb 2016 16:35:41 +0700
Message-ID: <1454492150-10628-12-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQts4-00060Z-FW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbcBCJg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:58 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34037 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbcBCJgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:55 -0500
Received: by mail-pa0-f45.google.com with SMTP id uo6so10985998pac.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JGBnPDdlYy9i/lQ+ZPCgrB+1DWhLV3GxOp6mxm0BmAY=;
        b=aDnMglgZ+ERDOeP40VPRKeFE1CUm0+Vai7Vr7YlsTNS3osUnDOzf2Si+I/mIWABSFf
         0w5wb8FyVfvFc4Vk8icMWFXdfOR3Ai86ODmIPm1on+9W8FWwOAzGkwmhf7C1TrpEWNiz
         dNieag9/nMdh9dngauOKYnvkfhxAr5ePiJmN4kr/rVbaRygTJRQMWj9vbw2nPD6iQQjd
         43IfjMG7S7ZofjFHXnJRDEPtMShGqyn4XFKcYVhIkfbySrOFGOXnSdP/EatMRcR4h7Oi
         GS/rP5bARDPS9JxuFoiYLbqgdtsSHian9Y5C2IpJqFrIxqEzeHm0NL4bDBPheeK2tC/a
         bkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=JGBnPDdlYy9i/lQ+ZPCgrB+1DWhLV3GxOp6mxm0BmAY=;
        b=flSSxc8lkyDBWtEIHfo7aB9ouan0wd29XjojM9X51w5b4H+XBhPYN73S0rVL6GnKM6
         FIYXLtF6wCpUphRU+dAscGBXe7X1MG6i4XPFgAhXVbW177jv2/JGgQtswuLXOvwF+d+Z
         1HnW+QdCLwnCJkUAridFvcQYkZZjZhgnly24Cismlep9keXpZeUh5pv/NwUje+blZXnc
         gVMOo3xhp7cQcwnCNjazbo0pP1F8QTDKcKlCSfePHQNDtP0xCUSiwzIQ/alggszUCKHE
         Ntki64uC6pGlzUh/6tzkDcNe0N/XqcTuPjLnYukw0K+tzgNpAAzRuJx95bvLBGFkcYug
         PdgA==
X-Gm-Message-State: AG10YORM3cONSboTnYrW5ohN1c1IDgdXMr3eQzVQF+dOdQqtW0UFyawOe/vCGdwYVq3KFg==
X-Received: by 10.66.147.165 with SMTP id tl5mr731337pab.88.1454492215167;
        Wed, 03 Feb 2016 01:36:55 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id b63sm8427664pfj.25.2016.02.03.01.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:06 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285356>

Because HEAD is part of repository signature, even if it's per-worktree
file, we can't simply delete it. So main worktree is considered gone if
=2Egit/HEAD contains all-zero SHA-1.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/worktree.c b/worktree.c
index e878f49..80c525b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -49,6 +49,8 @@ static int parse_ref(char *path_to_ref, struct strbuf=
 *ref, int *is_detached)
 		if (!starts_with(ref->buf, "ref:")) {
 			if (is_detached)
 				*is_detached =3D 1;
+			if (starts_with(ref->buf, sha1_to_hex(null_sha1)))
+				return -1;
 		} else {
 			strbuf_remove(ref, 0, strlen("ref:"));
 			strbuf_trim(ref);
--=20
2.7.0.377.g4cd97dd
