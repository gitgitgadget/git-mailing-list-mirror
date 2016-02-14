From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 12/12] grep.c: reuse "icase" variable
Date: Sun, 14 Feb 2016 18:49:56 +0700
Message-ID: <1455450596-11904-13-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvE2-0001h7-2j
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbcBNLwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:52:22 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32774 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcBNLwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:52:21 -0500
Received: by mail-pf0-f195.google.com with SMTP id c10so6245701pfc.0
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4R9FdWDcgPV0vYrbY910EqfAz16+q6yCbwAI29Hb/HE=;
        b=jGn//j8y72oRqu8ZFAosoS1H6Q/ZsaWBORfN5nwyha4diGKLQbgjojtwpMFi6n3GKA
         6NZ1+RcnNYarSuPusPGiiq/rNJdmLAM1YoNuDcGN2z5LSkgjnLT+/Du4QC54sAKx9ntS
         np7GZLdWJO8W7tzy7NsywomCQgnM6ss6Lv4y1l07fIAp+taRJfg5O0JPLxTYCdhhzSf7
         7+dFuCKrC14bNvuGOtNJXLKa2TWbgCxppALeCA8WcG4dEDIyqg5xVOgsWaL5YR0x59xJ
         LfZdJTA5QA+LqMpyhKVkthurGfulgtSH/3Mn1H3UzCMfuvcay8UKhi+VdqzeOErOJyy+
         f1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=4R9FdWDcgPV0vYrbY910EqfAz16+q6yCbwAI29Hb/HE=;
        b=O0RcRvOD2PQ7Ru7Jz9nDrbf1JCN3T6yS4LZ7opJTyMNXrbRJweIpEwpN6Amc+v98Pc
         5JQyybpZCxIQisG8iOIR1732e5/asOB0yZt1x/qhcHkTMowmTAXryiHJlFJ0GytXLTpb
         GMfBs7sUvB02xU0qZ4hTuN5oM939KHJRqmMWL/kzKU1MmK+WXX04ZlIWQGW8v4diK9eO
         5Cl8Q25Kr1zUUyLEr1xzPr2G8CU42LzK0YJ6++SMktopLcf1yvxRNWUolvBzumf4oEJd
         pnORHanxRyrqSIKDdRg7poOR0yAsEMpZihmnjqy+1m/1vqz69HRMxzhCuVvWI/4SXMAd
         N9hw==
X-Gm-Message-State: AG10YORclNrOLnRHAHWXvIG1sxvcGA6VLEAZikTvhWMnJDYcLd7a3CoJp9NjTHsGcJrq2w==
X-Received: by 10.98.0.84 with SMTP id 81mr15952881pfa.67.1455450741654;
        Sun, 14 Feb 2016 03:52:21 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id e14sm31366154pap.24.2016.02.14.03.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:52:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:52:42 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286147>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 6e99b01..cb058a5 100644
--- a/grep.c
+++ b/grep.c
@@ -445,10 +445,7 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
 		p->fixed =3D 0;
=20
 	if (p->fixed) {
-		if (opt->regflags & REG_ICASE || p->ignore_case)
-			p->kws =3D kwsalloc(tolower_trans_tbl);
-		else
-			p->kws =3D kwsalloc(NULL);
+		p->kws =3D kwsalloc(icase ? tolower_trans_tbl : NULL);
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
--=20
2.7.0.377.g4cd97dd
