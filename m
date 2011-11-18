From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: add missing header file dependencies
Date: Fri, 18 Nov 2011 04:02:02 -0600
Message-ID: <20111118100202.GG25145@elie.hsd1.il.comcast.net>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <20111118045742.GA25145@elie.hsd1.il.comcast.net>
 <7vty62klg9.fsf@alter.siamese.dyndns.org>
 <20111118095820.GF25145@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 11:02:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRLH2-0005Bz-PC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 11:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669Ab1KRKCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 05:02:13 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43634 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1KRKCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 05:02:12 -0500
Received: by ggnb2 with SMTP id b2so2251990ggn.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0Bqq7KHEbx3hn0QunzKX6YeTnQnS+dgW51qP+7Nx0E8=;
        b=RIfR92fGRUt5t0wTpu94U1liPBnoMdt8iLbo2FeC642dcgGhxLpTwKxrBx+u3quE2n
         T2j+pbXPh+kudUuQOmDVc2hicnKh4A92Agy0WIbDYwqeAd8Fqa+s32tjKV+ppyFiNIcR
         MpKBdBfGHTjBeVBVJx9lWDRJvn6MYlj7T/i+Y=
Received: by 10.50.169.99 with SMTP id ad3mr2366448igc.6.1321610531538;
        Fri, 18 Nov 2011 02:02:11 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bu33sm1003816ibb.11.2011.11.18.02.02.10
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 02:02:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111118095820.GF25145@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185645>

When the streaming filter API was introduced in v1.7.7-rc0~60^2~7
(2011-05-20), we forgot to add its header to LIB_H.  Most translation
units depend on streaming.h via cache.h.

v1.7.5-rc0~48 (Fix sparse warnings, 2011-03-22) introduced undeclared
dependencies by url.o on url.h and thread-utils.o on thread-utils.h.

Noticed by make CHECK_HEADER_DEPENDENCIES=1.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Some makefile buglets found while testing.

 Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ee34eab8..34ac7957 100644
--- a/Makefile
+++ b/Makefile
@@ -518,6 +518,7 @@ LIB_H += compat/win32/syslog.h
 LIB_H += compat/win32/poll.h
 LIB_H += compat/win32/dirent.h
 LIB_H += connected.h
+LIB_H += convert.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -2009,13 +2010,13 @@ builtin/branch.o builtin/checkout.o builtin/clone.o builtin/reset.o branch.o tra
 builtin/bundle.o bundle.o transport.o: bundle.h
 builtin/bisect--helper.o builtin/rev-list.o bisect.o: bisect.h
 builtin/clone.o builtin/fetch-pack.o transport.o: fetch-pack.h
-builtin/grep.o builtin/pack-objects.o transport-helper.o: thread-utils.h
+builtin/grep.o builtin/pack-objects.o transport-helper.o thread-utils.o: thread-utils.h
 builtin/send-pack.o transport.o: send-pack.h
 builtin/log.o builtin/shortlog.o: shortlog.h
 builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
-connect.o transport.o http-backend.o: url.h
+connect.o transport.o url.o http-backend.o: url.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
-- 
1.7.8.rc2
