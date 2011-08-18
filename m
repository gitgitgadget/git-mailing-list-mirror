From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] Decorate grafts and replaces
Date: Thu, 18 Aug 2011 19:29:33 +0700
Message-ID: <1313670578-2939-1-git-send-email-pclouds@gmail.com>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 14:29:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu1jM-0001I2-QD
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 14:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab1HRM3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 08:29:47 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41218 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab1HRM3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 08:29:46 -0400
Received: by pzk37 with SMTP id 37so2928610pzk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RWhCAU9ol2619ct9hzNYWWM8XRsJbiiC80NoeNQRDGw=;
        b=oEXfp5KziQYEYCGPZkQm2pifaM9EpyCD8wjSl33aWSAHi72pg60c8XfauA6n8v1dll
         4hYNv2kOMELsruD7Yp9MVS5LU81khkoMQoBcUWUMewp7W+ZBiooNDp5TQJQ2osG970LX
         9nsUAwvR9EORw10nVuyKCfP4BTuIgJXlPfq4g=
Received: by 10.142.2.3 with SMTP id 3mr352205wfb.409.1313670586503;
        Thu, 18 Aug 2011 05:29:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id c8sm1440559pbi.43.2011.08.18.05.29.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 05:29:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 19:29:40 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179589>

I originally wanted to decorate shallow cut points. Now it decorates
all grafts (normal as well as shallow cuts) and replaced commits/tags.

The first patch is an independent fix. The last one, decorating
replaces, can also be considered a fix (decorating "refs/replace/SHA1"
on random commits does not sound right, but maybe it's just me).

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  decoration: do not mis-decorate refs with same prefix
  Add for_each_commit_graft() to iterate all grafts
  Move write_shallow_commits to fetch-pack.c
  log: decorate grafted commits with "grafted"
  log: decorate "replaced" on to replaced commits

 builtin/fetch-pack.c |   30 ++++++++++++++++++++++++++++++
 commit.c             |   20 +++++---------------
 commit.h             |    3 ++-
 log-tree.c           |   34 ++++++++++++++++++++++++++++++----
 4 files changed, 67 insertions(+), 20 deletions(-)

--=20
1.7.4.74.g639db
