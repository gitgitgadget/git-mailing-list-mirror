From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 0/9] http: end urls with slash
Date: Thu, 25 Nov 2010 16:21:01 +0800
Message-ID: <1290673270-4284-1-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLXCH-0002gK-4f
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab0KYI2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:28:49 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56120 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab0KYI2s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:28:48 -0500
Received: by yxp4 with SMTP id 4so337813yxp.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UMydg4oC/xuTzwDpuj9cU9/ciUxHR6y9Bn5XD2s5lFI=;
        b=t5qJNv7geq3qbbmYB5jUnQFCJ5XclCrMKo4991KnhYwJBoRj3j8rG+AnC2alSbSkbI
         Jy9yc1X5B2+4LfDc3gy2cNCxqPDLOSxmxy3vtnY9F9sVon6UISYUWamFQ1doimc59LPE
         fWhHmXe+S2ZItVOUN7NXXXe72TQg1SV+fQobY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S5pFoAa9+6yU9ArXPLMU95l5g9Sa5LcnMzdAarN3E/qb2jO4zcs30IMw5LgxrZPAP7
         mPNBlnWY0533vNBC/8uDuHPlGeEDCjjzmfeK4zbfMgUBvd+x/b4wKKTWu1ZQ0QiZlVV/
         P5H3Nfa4Dl1B0O+3vD5gbOT1ews4AAscZncCo=
Received: by 10.42.173.72 with SMTP id q8mr160899icz.350.1290673318982;
        Thu, 25 Nov 2010 00:21:58 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.21.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:21:57 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162116>

This patch series contains Gabriel's fix, as well as some related work I did in
the area while looking through the code paths.

Changed from v2:
 - new patches (#2 and #9) that reworks http-fetch url slashing code, and test
   that this doesn't break anything.
 - patch #4: remove pointer check before running free(), as pointed out by
   Johnathan.

All other patches remain unchanged.

Contents:
[1/9] t5550-http-fetch: add missing '&&'
[2/9] t5550-http-fetch: add test for http-fetch
[3/9] shift end_url_with_slash() from http.[ch] to url.[ch]
[4/9] url: add str wrapper for end_url_with_slash()
[5/9] http-backend: use end_url_with_slash()
[6/9] http-push: Normalise directory names when pushing to some WebDAV servers
[7/9] http-push: check path length before using it
[8/9] http-push: add trailing slash at arg-parse time, instead of later on
[9/9] http-fetch: rework url handling

 Makefile              |    2 +-
 http-backend.c        |    4 +---
 http-fetch.c          |   16 +++++-----------
 http-push.c           |   31 ++++++++++++++++---------------
 http.c                |    8 +-------
 http.h                |    2 +-
 t/t5550-http-fetch.sh |   16 ++++++++++++++--
 url.c                 |   14 ++++++++++++++
 url.h                 |    3 +++
 9 files changed, 56 insertions(+), 40 deletions(-)

-- 
1.7.3.2.495.gc7b3f
