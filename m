From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH nd/split-index] fixup! read-cache: new API write_locked_index instead of write_index/write_cache
Date: Sun,  1 Jun 2014 07:47:15 +0700
Message-ID: <1401583635-1332-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8Ad+hfmJSgKX6O9FTXggUjyMkpJLzf=awnV5oFACsX+vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, ramsay@ramsay1.demon.co.uk,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 02:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqtoV-0001hf-Oj
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 02:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbaFAAjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2014 20:39:40 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40835 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbaFAAjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 20:39:39 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so2867202wib.12
        for <git@vger.kernel.org>; Sat, 31 May 2014 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ybRZrYgOTQv7vMJAd7A17sVLUbXc/H8Hb4x3gpux5MM=;
        b=XkLUPYJtMsOMkg/iEo5fiaVDT2DVBG1suSXZScNFZ3EDUYQI4MkiTMGU2wbxaAOnX2
         7I+aX/X7/Rj1XdNmyuXOTX3VvJoAZfisfcdFXV34dkWOASCs1FLDfeXOLuY9F+EK9GIj
         lf/VhSGOKrH0/v+vm+/KTSg8YS9vOwoJugw1V//B/7nt7X1rR7LMdbeWGEo2lv8zWzmP
         u8iYClDthAdy8t4EcKxTI01G22sgaTOSafBjFa1HoV45SiiX3sPpI/Qd1yl0tN1Z5Wn1
         gGGlb33vfPYWkRLuTkRSDrJThigaNH7fb2O1vBzrUqlfZcCuskmIctbjMJL/sdpY3Zv4
         /Mvg==
X-Received: by 10.194.242.136 with SMTP id wq8mr37184441wjc.4.1401583177855;
        Sat, 31 May 2014 17:39:37 -0700 (PDT)
Received: from lanh ([115.73.254.8])
        by mx.google.com with ESMTPSA id ht5sm22433384wjb.49.2014.05.31.17.39.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 May 2014 17:39:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 Jun 2014 07:47:21 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <CACsJy8Ad+hfmJSgKX6O9FTXggUjyMkpJLzf=awnV5oFACsX+vQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250516>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I intended it resend the series after the comments I received, but it
 looks like Junio has picked up all comments except this one, so
 here's the fix.

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 377c877..4b709db 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -672,7 +672,7 @@ static void prepare_revs(struct replay_opts *opts)
 static void read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
-	hold_locked_index(&index_lock, 0);
+	int index_fd =3D hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("git %s: failed to read the index"), action_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,=
 NULL);
--=20
1.9.1.346.ga2b5940
