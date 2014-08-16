From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/5] Large file improvements
Date: Sat, 16 Aug 2014 10:08:01 +0700
Message-ID: <1408158486-7328-1-git-send-email-pclouds@gmail.com>
References: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 05:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIULq-0000sM-Lw
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 05:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbaHPDIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 23:08:12 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60725 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaHPDIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 23:08:11 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so4329642pde.9
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 20:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yQoCkIpulD9/TG5TZBFLqR6nANAzCIGi0udUOKnQTek=;
        b=CGQpChm6zqMzy7PXxsZfbNMivStYaYm7uwwGZgorlFHjonZkfpoj+tXGWsrVmGl1X4
         GEDHX3xkrHMu19ushkGH7e/oGcFJdE1poBM/ty/7uVA+HxfSb4T8dc+RGBj21THrTxNs
         yc04epqXF0Q+FA7NERdueSS0WD3aoYeRmn9/CztYXcPiO3f8p6IJhjb6zwE1J1A+sdVQ
         iyrksdLIfBCCAQZhoDPWsddX4jE2ufJTaXKVVkRDDzNQw1HOoj2hEsqYxnpa8sSwIjTS
         25hozuu75cCx0m7MDHM7kG+fDg2nL4lcuo5A+4AW1/cTjkcxofs32EFJdMjzK3Tjfn90
         CiYg==
X-Received: by 10.70.56.10 with SMTP id w10mr7792042pdp.135.1408158491449;
        Fri, 15 Aug 2014 20:08:11 -0700 (PDT)
Received: from lanh ([115.73.215.192])
        by mx.google.com with ESMTPSA id sz4sm9330341pbc.28.2014.08.15.20.08.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 20:08:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Aug 2014 10:08:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255313>

Since v3:

 - rename xmallocz_gentle to xmallocz_gently
 - drop the unpack-objects patch
 - fix allways type

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  wrapper.c: introduce gentle xmallocz that does not die()
  sha1_file.c: do not die failing to malloc in unpack_compressed_entry
  diff.c: allow to pass more flags to diff_populate_filespec
  diff --stat: mark any file larger than core.bigfilethreshold binary
  diff: shortcut for diff'ing two binary SHA-1 objects

 Documentation/config.txt        |  3 +-
 Documentation/gitattributes.txt |  4 +--
 diff.c                          | 52 ++++++++++++++++++++++---------
 diffcore-rename.c               |  6 ++--
 diffcore.h                      |  4 ++-
 git-compat-util.h               |  1 +
 sha1_file.c                     |  4 ++-
 t/t1050-large.sh                | 20 ++++++++++++
 wrapper.c                       | 68 +++++++++++++++++++++++++++++++--=
--------
 9 files changed, 125 insertions(+), 37 deletions(-)

--=20
2.1.0.rc0.78.gc0d8480
