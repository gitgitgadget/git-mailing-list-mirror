From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 5/7] Makefile: Add coverage-report-cover-db-html target
Date: Sun, 25 Jul 2010 14:40:59 +0000
Message-ID: <1280068861-17701-6-git-send-email-avarab@gmail.com>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 16:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2OX-0001DE-Fb
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab0GYOl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 10:41:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49376 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0GYOlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:41:23 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so602412ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9Zs2ArzlIbwrlKEPjkY4t/UuICkh5A+uTr0eWMQymfI=;
        b=ilMC2X4PtECks/r77N1zmQXoWrCZDvAc1NNnyL7H+q1eQrnX3PO5d0bmoZklvy4Bpo
         HEpiQjQjpbTvNIlfg5dzjdHGaaTfhpPxum9hxzgJzn+8ZiA9kFKB0F4HSH7xrR8ywnjU
         a0zEgwht82NBPn5jWgSwYV1xBde8ExOKRjpVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Y2vPMvm3FdGraq5dxKmOu3Y4T6wQ39GgeP8lD0rr9+K7OcJkUXkSd11loJyzOAHdrr
         Hsc+KrEBFbBF8pBpAgFBoM8ViUc5xTeWUmg9vwgudk02yE4dMlKeo/4cZ46nnERPkyl2
         Fbllsh2qhIrxW1L9qdTPRoZHdhxvqnkypR5Ac=
Received: by 10.213.28.134 with SMTP id m6mr5417131ebc.70.1280068882555;
        Sun, 25 Jul 2010 07:41:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm3977142eeh.23.2010.07.25.07.41.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 07:41:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151750>

Add a target to generate a detailed HTML report for the entire Git
codebase using Devel::Cover's cover(1) tool. Output it in
cover_db_html instead of the default cover_db, so that it isn't mixed
up with our raw report files.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    1 +
 Makefile   |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index bd53c02..baed247 100644
--- a/.gitignore
+++ b/.gitignore
@@ -209,3 +209,4 @@
 *.gcov
 /coverage-untested-functions
 /cover_db
+/cover_db_html
diff --git a/Makefile b/Makefile
index f2c680d..b6975aa 100644
--- a/Makefile
+++ b/Makefile
@@ -2307,3 +2307,5 @@ coverage-untested-functions: coverage-report
 coverage-report-cover-db: coverage-report
 	gcov2perl -db cover_db *.gcov
=20
+coverage-report-cover-db-html: coverage-report-cover-db
+	cover -report html -outputdir cover_db_html cover_db
--=20
1.7.0.4
