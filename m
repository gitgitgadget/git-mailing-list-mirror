From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Another attempt to get the SVN exporter merged
Date: Thu, 10 Jun 2010 15:09:43 +0200
Message-ID: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 15:09:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhVF-0002Rk-V9
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 15:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab0FJNI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 09:08:56 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:61012 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0FJNIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 09:08:55 -0400
Received: by ewy23 with SMTP id 23so80476ewy.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ej/xkaoB+g+NFCu4qLg21txpHWPSm7dBpyWTyOHMMwY=;
        b=ab1i08FjpW303jRebtjQZlNHaAbS2Q999FZ7ba1YWsESfngLw2Jgc4IVRrBoodXpc4
         ZaXmKJvLSuPyjiMgLwoc5FKGYUYlSJsXsgfbc9eeG8B+StUPMrCVrInuDVvCdF3MtvgU
         5AA/Ae1RvJ1JKb08h+TSn9cNpVhH9Ljd5mCng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lFUJvaenPDvFqejGYh+TD1VEXIgW0HH3EGynSAMd88munXYwq2SM2OHiSB3VLw+E5w
         BnXcwUA7ZQlb2zifecM8clTf/BJG0xG/KlmX90qjqjuEBY/QTiL6UNttTncrwsHYYsYX
         Rs+vIV5pBD+bNHBaWlprh8QCdg5n/thE5V/mg=
Received: by 10.213.31.140 with SMTP id y12mr88706ebc.87.1276175333493;
        Thu, 10 Jun 2010 06:08:53 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm4784517ewy.5.2010.06.10.06.08.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 06:08:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148866>

Hi,

It certainly looks like I'll never give up trying to get this series
merged- this is my third attempt :) Much thanks to David for all the
awesome code, and to Jonathan for all the detailed timely
reviews. Hopefully, this time the series will have fewer mistakes and
will actually be merged. Sadly, I still haven't been able to get rid
of the compiler warnings about unused functions, and it looks like
this series won't graduate to `master` before that happens- I'd
appreciate pointers on how to do this.

Please feel free to nitpick every little detail, but please don't use
that as an excuse to hold up the series. I'd appreciate some acks from
everyone who has been involved with this to make it easier for Junio
to decide.

Major change since last time: Removed dependency on mmap for
portability reasons.

Thanks!

-- Ram

David Barr (5):
  Add memory pool library
  Add library for string-specific memory pool
  Add stream helper library
  Add infrastructure to write revisions in fast-export format
  Add SVN dump parser

Jason Evans (1):
  Add cpp macro implementation of treaps

 vcs-svn/fast_export.c |   74 +++++++++++
 vcs-svn/fast_export.h |   14 ++
 vcs-svn/line_buffer.c |  134 ++++++++++++++++++++
 vcs-svn/line_buffer.h |   14 ++
 vcs-svn/obj_pool.h    |   90 +++++++++++++
 vcs-svn/repo_tree.c   |  335 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   26 ++++
 vcs-svn/string_pool.c |  116 +++++++++++++++++
 vcs-svn/string_pool.h |   15 +++
 vcs-svn/svndump.c     |  298 +++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.h     |    7 +
 vcs-svn/trp.h         |  201 +++++++++++++++++++++++++++++
 vcs-svn/trp.txt       |   61 +++++++++
 13 files changed, 1385 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt
