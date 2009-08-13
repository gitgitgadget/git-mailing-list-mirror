From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 2/4] fast-import: define a new option command
Date: Wed, 12 Aug 2009 22:09:44 -0700
Message-ID: <1250140186-12363-3-git-send-email-srabbelier@gmail.com>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com>
 <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSaL-0001rC-BY
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbZHMFK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbZHMFKY
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:10:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:65153 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZHMFKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:10:21 -0400
Received: by rv-out-0506.google.com with SMTP id f6so169039rvb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 22:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=V+q3wjh78KlJJ6HYCeBUvZihNM4gy6bqKafd7Cme7o8=;
        b=tYY5Oz0aHOatZrLAc4IX9J0vu7QhqtSoM37gAnYyl8e+uq0iAi2PA0RaL/CrupoOc7
         6CsAbOSma04ET3GDNgf6depu4tZykjRpuIJxoMi6DhvMx1BGNFe4u6Kls5xUN/r5dneD
         A5nHg9SbiVNnyIzTugRTr+mAtO5uC0WVk1FSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OShZAtZLg6jMoD8IuqvSqAucPwj/2u8GHPosHbCDkCwICQN0FEdKNnWRUDuD9kUjKS
         L79h/BX4VQBrucvGJNZfYnG4CD2hlkFfzSo3aXzoqXXN+KxAECxAph+PAgR66wmu2nwV
         X/VWHSigKdbpx1ry1a4ymzxlmRbONFWRxB4bE=
Received: by 10.140.187.11 with SMTP id k11mr384463rvf.105.1250140222471;
        Wed, 12 Aug 2009 22:10:22 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm6740240rvb.20.2009.08.12.22.10.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 22:10:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125779>

This allows the frontend to specify any of the supported options as
long as no non-option command has been given.
---

    As requested, updated the documentation of the language format

 Documentation/git-fast-import.txt |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..6b5bc1b 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -303,6 +303,11 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`option`::
+    Specify any of the options listed under OPTIONS to change
+    fast-import's behavior to suit the frontends needs. This command
+    is optional and is not needed to perform an import.
+
 `commit`
 ~~~~~~~~
 Create or update a branch with a new commit, recording one logical
@@ -813,6 +818,24 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`option`
+~~~~~~~~
+Processes the specified option so that git fast-import behaves in a
+way that suits the front-ends needs.
+Note that options specified by the frontend override any options the
+user may specify to git fast-import itself.
+
+....
+    'option' SP <option> LF
+....
+
+The `<option>` part of the command may contain any of the options
+listed in the OPTIONS section, without the leading '--' and is
+treated in the same way.
+
+Option commands must be the first commands on the input, to give an
+option command after any non-option command is an error.
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
-- 
1.6.4.16.g72c66.dirty
