From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/2] Work around too many file descriptors
Date: Mon,  1 Nov 2010 15:54:19 -0700
Message-ID: <1288652061-19614-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 23:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD3Gt-0005GX-SA
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 23:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0KAWy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 18:54:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46551 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab0KAWyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 18:54:24 -0400
Received: by yxk8 with SMTP id 8so3279416yxk.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 15:54:24 -0700 (PDT)
Received: by 10.42.51.10 with SMTP id c10mr2700843icg.77.1288652063831;
        Mon, 01 Nov 2010 15:54:23 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id 8sm9001895iba.22.2010.11.01.15.54.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 15:54:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.191.g2d0e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160500>

This tiny series tries to work around not having enough file
descriptors to open every pack in a repository.  It is the logical
conclusion of Johannes Schindelin's commit fd73ccf2 ("Cope better
with a _lot_ of packs").

The patch was prepared on top of gitster's recent two changes to
improve error handling in read_sha1_file().

Shawn O. Pearce (2):
  Use git_open_noatime when accessing pack data
  Work around EMFILE when there are too many pack files

 sha1_file.c |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

-- 
1.7.3.2.191.g2d0e5
