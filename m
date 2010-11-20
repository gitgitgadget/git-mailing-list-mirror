From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/15] vcs-svn: Make source easier to read on small screens
Date: Fri, 19 Nov 2010 18:53:54 -0600
Message-ID: <20101120005354.GM17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbj5-0003HE-Ge
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab0KTAyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:54:43 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56280 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab0KTAym (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:54:42 -0500
Received: by yxf34 with SMTP id 34so3101826yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eJxKJTESQC/PW4pK69MioXmfvhU8gGppEeC01eIQv78=;
        b=ceBOk0p+fpefTIdVKYmUxp3dCYEkA+M6qgEWefcieR9y/FG0BfR1HVQAr2yof1kj3y
         y/YlZB/SKcmJ35aauBigK1ivD1IZDeyNPs3LVO2+EQkYhL5l/h7Qh+cXYXm758tL/y+d
         k8scCHxqrfVBvxJlsC7A1t3YAZMi6pPpF21yA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wXuf/0gfLtL4xi8TRLaTXH2IlIuOnH6ySQH6v1pKpQRqST/RPAzRUWHlgHKfz4DES7
         lvLmV2D+SJ8/6cZpzpt7uHO2N9SPZ5gZ09cxzV6wBQL+/pKVAoAZ6pfdQlQevh0sY7KW
         hmnqzpJnoss2KP1mlaAjtsWA4Mnuoex000uZI=
Received: by 10.151.79.1 with SMTP id g1mr4572667ybl.375.1290214481730;
        Fri, 19 Nov 2010 16:54:41 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id y21sm1444428yhc.14.2010.11.19.16.54.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:54:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161812>

Remove some newlines from handle_node() that are not needed for
clarity.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 62bb148..5de32e1 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -156,31 +156,25 @@ static void handle_node(void)
 
 	if (node_ctx.text_delta || node_ctx.prop_delta)
 		die("text and property deltas not supported");
-
 	if (node_ctx.textLength != LENGTH_UNKNOWN)
 		mark = next_blob_mark();
-
 	if (node_ctx.action == NODEACT_DELETE) {
 		if (mark || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
 		return repo_delete(node_ctx.dst);
 	}
-
 	if (node_ctx.action == NODEACT_REPLACE) {
 		repo_delete(node_ctx.dst);
 		node_ctx.action = NODEACT_ADD;
 	}
-
 	if (node_ctx.srcRev) {
 		repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
 		if (node_ctx.action == NODEACT_ADD)
 			  node_ctx.action = NODEACT_CHANGE;
 	}
-
 	if (mark && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
-
 	if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode = repo_modify_path(node_ctx.dst, 0, mark);
 		if (!mode)
@@ -197,7 +191,6 @@ static void handle_node(void)
 	} else {
 		die("invalid dump: Node-path block lacks Node-action");
 	}
-
 	if (have_props) {
 		const uint32_t old_mode = node_ctx.type;
 		node_ctx.type = type;
@@ -206,7 +199,6 @@ static void handle_node(void)
 		if (node_ctx.type != old_mode)
 			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
 	}
-
 	if (mark)
 		fast_export_blob(node_ctx.type, mark, node_ctx.textLength);
 }
-- 
1.7.2.3
