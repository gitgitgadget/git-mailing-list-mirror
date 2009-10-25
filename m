From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 2/5] http-backend: reword some documentation
Date: Sun, 25 Oct 2009 14:05:32 -0400
Message-ID: <1256493935-8680-3-git-send-email-lodatom@gmail.com>
References: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
 <1256493935-8680-2-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 19:05:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N27Sq-00075h-HV
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 19:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbZJYSEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 14:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753864AbZJYSEs
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 14:04:48 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:28831 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbZJYSEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 14:04:47 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1667665qwb.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=98xB25FwExREQeIKsZza2QJYFDiUUyWeOyAWmIf/bE0=;
        b=YJ605i41TjLMyPqrNJUh/OtXx9TXl0MIbAYkbc6eKXbw7/iKID94bKidGHdSAnJhDs
         +pylEg8nQt5swl+VQduB8DlOkrafHcAlZGBDvXZLOb8W1WhQPo8QBBtF8AWdOjoiT0/A
         MhqpWdvKBepMihCs8liRs1dNTmwab9Uv2Uyv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kny/U8U9YsaJZcZM63xhChtAz4WdtCdqysqMjlGcU1hK7gXqyXHErmzajxDBo855v/
         YgsyELGm10CsFrbdpBifUoSpVMqKFCJkn+ZlOt/2DGsudG6oFrirXyY0kgH3edvH6fo/
         uWDUK4tQ+o6UOmKekM9+KbFrLA/jbO4AyyVeI=
Received: by 10.224.96.77 with SMTP id g13mr6757439qan.305.1256493892845;
        Sun, 25 Oct 2009 11:04:52 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 7sm13930120qwf.46.2009.10.25.11.04.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 11:04:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256493935-8680-2-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131231>

Clarify some of the git-http-backend documentation, particularly:

* In the Description, state that smart/dumb HTTP fetch and smart HTTP
  push are supported, state that authenticated clients allow push, and
  remove the note that this is only suited for read-only updates.

* At the start of Examples, state explicitly what URL is mapping to what
  location on disk.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-http-backend.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 99dbbfb..0b5e951 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -14,13 +14,15 @@ DESCRIPTION
 -----------
 A simple CGI program to serve the contents of a Git repository to Git
 clients accessing the repository over http:// and https:// protocols.
+The program supports clients fetching using both the smart HTTP protcol
+and the backwards-compatible dumb HTTP protocol, as well as clients
+pushing using the smart HTTP protocol.
 
 By default, only the `upload-pack` service is enabled, which serves
 'git-fetch-pack' and 'git-ls-remote' clients, which are invoked from
-'git-fetch', 'git-pull', and 'git-clone'.
-
-This is ideally suited for read-only updates, i.e., pulling from
-git repositories.
+'git-fetch', 'git-pull', and 'git-clone'.  If the client is authenticated,
+the `receive-pack` service is enabled, which serves 'git-send-pack'
+clients, which is invoked from 'git-push'.
 
 SERVICES
 --------
@@ -50,6 +52,8 @@ automatically by the web server.
 
 EXAMPLES
 --------
+All of the following examples map 'http://$hostname/git/foo/bar.git'
+to '/var/www/git/foo/bar.git'.
 
 Apache 2.x::
 	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
-- 
1.6.5.1
