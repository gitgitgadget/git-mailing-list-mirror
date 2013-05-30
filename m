From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] cherry-pick: fix memory leaks
Date: Thu, 30 May 2013 06:58:52 -0500
Message-ID: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 14:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1XA-0001Dx-OY
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab3E3MAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:00:41 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:51616 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab3E3MAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:00:40 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so24467yho.30
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TCwZUIUkQ/Pmg/29Hj+CB0So2ht05xVGX1WPkeRiYdY=;
        b=sRKBJKw43Ze/ZmjqlIdFRzQCQ05hzKkds1i+RHx91EBYAoWTC1zGLlUuAoycBzJgIH
         CikiMPIQ2wNYZmfKG0gQN0AWlYIH9Xtn68K9CB3y1KJElW5inGZownZb8E3eE7DQYLdf
         DajNtQZ79cYZ25GJElgH3yhWpirQYm2myfl/Mv+aXwUccfUKCAfc5m3dSZ1Qzqbbpboc
         W/Y5EnX+iDn8jKiXrxrJjdu0tsi1A8IQvckz6uDoK7sH1lsCH4xdO52FNS3PZPLrnRet
         Zp/npZNVItMBYIEPUN82GhnZDEGfIi6RAFwnAQVImejkerRmcA9edKlcgbUGWrcV/rFv
         Pu9Q==
X-Received: by 10.236.169.132 with SMTP id n4mr3342754yhl.173.1369915239200;
        Thu, 30 May 2013 05:00:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j20sm11813925yhi.1.2013.05.30.05.00.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 05:00:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225968>

Hi,

I took a shot at fixing the memory leaks of cherry-pick, and at least in my
tests the memory doesn't seem to increase any more.

Felipe Contreras (4):
  commit: reload cache properly
  read-cache: plug small memory leak
  unpack-trees: plug a memory leak
  unpack-trees: free created cache entries

 builtin/commit.c |  2 ++
 read-cache.c     |  2 ++
 unpack-trees.c   | 16 +++++++++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.8.3.rc3.312.g47657de
