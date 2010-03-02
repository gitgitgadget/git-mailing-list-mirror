From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/7] http: minor improvements
Date: Tue,  2 Mar 2010 18:49:24 +0800
Message-ID: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:49:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPfk-0003Yo-PF
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab0CBKtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:49:47 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:40254 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab0CBKtq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:49:46 -0500
Received: by yxe12 with SMTP id 12so38910yxe.33
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+tN+6cA6YP2OKwklHLs+T/HzwogZLXC0qmERLeIdHjY=;
        b=tvULXhmOPcvzoPaWF6RNT2/qaijh4jTipJiyRWYcO2MTYlcmnzhN3kz3jmg+eQxaFU
         bRyk2ELek2MKARH/Z6c6XuPH+aeyeIz0631+//m6WVOHCvLR5NG1HJAFJKvpjb/xKYp2
         BwvwgtNrRYMrFmpwFBZgGpya30acbIh+QQZb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XA1XAMdd+6r3JFzqzu8S79JSNMqAZO3rbEmzAXpS5QCylALwtp21eRev/ZmPm9yWYC
         7HpJcoedVh0H4dJB+mEpJho5EaR9qOSz5AJqaArBBtM2lNfiyLIGjjf68k31MrS4JiyD
         5q/v50EcbBrxYnGuKZYzv2IIK7TXK5DuSxTfk=
Received: by 10.101.184.29 with SMTP id l29mr463545anp.55.1267526985046;
        Tue, 02 Mar 2010 02:49:45 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.49.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:49:44 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141380>

This patch series was generated on top of 'next'. It contains some
general changes to http usage.

Some highlights:
  - add non-ff test cases to "dumb" http push test
  - separate init and cleanup of http from http-walker

Changes from v1 (based on comments from Clemens):
  - patch 3: don't say "remove condition", since we're actually enabling
    it.
  - patch 5: in keeping with separating http and http-walker, removed
    http_cleanup() from http-walker->cleanup().
  - patch 5: move http_cleanup() call after http-walker->cleanup(). This
    isn't really needed, but do this just in case http-walker->cleanup()
    does any http operations.

Contents:

[PATCH v2 1/7] t5541-http-push: check that ref is unchanged for non-ff test
[PATCH v2 2/7] t554[01]-http-push: refactor, add non-ff tests
[PATCH v2 3/7] http-push: remove "|| 1" to enable verbose check
[PATCH v2 4/7] http-walker: cleanup more thoroughly
[PATCH v2 5/7] http: init and cleanup separately from http-walker
[PATCH v2 6/7] remote-curl: use http_fetch_ref() instead of walker wrapper
[PATCH v2 7/7] remote-curl: init walker only when needed

 http-fetch.c         |    5 ++++-
 http-push.c          |    2 +-
 http-walker.c        |   21 +++++++++++++++++----
 remote-curl.c        |   21 +++++++++------------
 t/lib-httpd.sh       |   29 +++++++++++++++++++++++++++++
 t/t5540-http-push.sh |    3 +++
 t/t5541-http-push.sh |   22 ++--------------------
 walker.h             |    2 +-
 8 files changed, 66 insertions(+), 39 deletions(-)

--
Cheers,
Ray Chuan
