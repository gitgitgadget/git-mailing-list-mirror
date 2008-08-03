From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/5] correct usage help string for git-hash-object
Date: Sun,  3 Aug 2008 18:36:19 +0400
Message-ID: <1217774182-28566-2-git-send-email-dpotapov@gmail.com>
References: <20080803055602.GN7008@dpotapov.dyndns.org>
 <1217774182-28566-1-git-send-email-dpotapov@gmail.com>
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeiF-0007u3-TD
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbYHCOgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbYHCOgc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:36:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711AbYHCOgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:36:31 -0400
Received: by nf-out-0910.google.com with SMTP id d3so606841nfc.21
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JbGOLzD2DntwRVzSK7VfW57kiQEFvk5buIYJS7/8hfI=;
        b=xpNUX4CUa0dWkQEnFYwSmAPaionMix1WPHLF6GxM6VTgOyS8nL8SfcruFBFVqu5dgV
         5AqJbUDNNFjsV9keAVKKaLULxi03BGBDaZejwe8MzPsWWOJZKnQnhuI9nuNYhy9DJBk6
         S7Bp+fZAWUaHth9mIFuyvQ3Lp3E4Acbtn+OoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g79rAAQVVG5gKoZHMceer5Rd7qpPc8R4Iu+oX8rwUiiSNmI9HrdsWQ4PqnBC1y2irz
         9xtlm+hNy812BnZxacywcEYCSYgePAACZY/321fxVjKp8QQjuW9fTfqPzIwQyD4sQ+ha
         dccvgQH1PoEpN+TsGoFdYScFmPrDTSh+16gcw=
Received: by 10.210.71.13 with SMTP id t13mr15739963eba.42.1217774191263;
        Sun, 03 Aug 2008 07:36:31 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id d26sm9929143nfh.35.2008.08.03.07.36.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 07:36:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.58.gacdf
In-Reply-To: <1217774182-28566-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91243>

The usage string is corrected to make it fit in 80 columns and to make it
unequivocal about what options can be used with --stdin-paths.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/git-hash-object.txt |    4 +++-
 hash-object.c                     |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index ac928e1..a4703ec 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -8,7 +8,9 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 
 SYNOPSIS
 --------
-'git hash-object' [-t <type>] [-w] [--stdin | --stdin-paths] [--] <file>...
+[verse]
+'git hash-object' [-t <type>] [-w] [--stdin] [--] <file>...
+'git hash-object' [-t <type>] [-w] --stdin-paths < <list-of-paths>
 
 DESCRIPTION
 -----------
diff --git a/hash-object.c b/hash-object.c
index ce027b9..ac44b4e 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -49,7 +49,8 @@ static void hash_stdin_paths(const char *type, int write_objects)
 }
 
 static const char hash_object_usage[] =
-"git hash-object [ [-t <type>] [-w] [--stdin] <file>... | --stdin-paths < <list-of-paths> ]";
+"git hash-object [-t <type>] [-w] [--stdin] [--] <file>...\n"
+"   or: git hash-object  --stdin-paths < <list-of-paths>";
 
 int main(int argc, char **argv)
 {
-- 
1.6.0.rc1.58.gacdf
