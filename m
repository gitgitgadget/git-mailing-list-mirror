From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH 0/4] Some improvements for git-imap-send
Date: Tue,  9 Feb 2010 21:09:01 +0900
Message-ID: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	jwhite@codeweavers.com, robertshearman@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 09 13:19:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nep3b-0000uz-0p
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 13:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab0BIMSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 07:18:50 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:54581 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab0BIMSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 07:18:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id E00B8E9D86E;
	Tue,  9 Feb 2010 21:09:54 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZjBgSaO3wDnA; Tue,  9 Feb 2010 21:09:53 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id B26BAE9D865;
	Tue,  9 Feb 2010 21:09:53 +0900 (JST)
X-Mailer: git-send-email 1.7.0.rc1.52.gf7cc2.dirty
In-Reply-To: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139396>

Hi Git folks,

Thanks for your patch
( http://article.gmane.org/gmane.comp.version-control.git/139186 ),
now I can enable boolean values
with no assign statement in imap section like "preformattedHTML" in .gitconfig.

This patch series adds two new options to git-imap-send,
"auth-method" and "lf-to-crlf".

Users can specify authenticate method with "auth-method".
This patch also adds new auth method "CRAM-MD5".

Some strict IMAP servers (e.g. Cyrus) don't allow
"bare newlines" in messages.
If "lf-to-crlf" enabled, git-imap-send
converts LF to CRLF("\r\n") before storing messages
to draft folder.

If you think these are useful, please use.

Thanks,

Hitoshi Mitake (4):
  Add base64 encoder and decoder
  Add stuffs for MD5 hash algorithm
  git-imap-send: Implement CRAM-MD5 auth method
  git-imap-send: Add method to convert from LF to CRLF

 Documentation/git-imap-send.txt |    9 +
 Makefile                        |    6 +
 base64.c                        |  122 ++++++++
 base64.h                        |   36 +++
 imap-send.c                     |  137 ++++++++--
 md5.c                           |  600 +++++++++++++++++++++++++++++++++++++++
 md5.h                           |   61 ++++
 md5_hmac.c                      |  137 +++++++++
 md5_hmac.h                      |   36 +++
 9 files changed, 1127 insertions(+), 17 deletions(-)
 create mode 100644 base64.c
 create mode 100644 base64.h
 create mode 100644 md5.c
 create mode 100644 md5.h
 create mode 100644 md5_hmac.c
 create mode 100644 md5_hmac.h
