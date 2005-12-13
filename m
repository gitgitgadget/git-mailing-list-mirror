From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Tue, 13 Dec 2005 13:54:51 +0300
Message-ID: <11344712912199-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 11:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em7oX-0002qZ-U8
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 11:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVLMKzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 05:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVLMKzQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 05:55:16 -0500
Received: from mail1.imul.com ([217.113.72.31]:63500 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S964842AbVLMKzO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 05:55:14 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Tue, 13 Dec 2005 13:55:03 +0300
  id 000F5987.439EA887.00000BE2
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 4BB405256; Tue, 13 Dec 2005 13:56:44 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1Em7o3-0003s3-P7; Tue, 13 Dec 2005 13:54:51 +0300
In-Reply-To: 439C7CA9.4030404@zytor.com
X-Mailer: git-send-email
To: git@vger.kernel.org
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13574>

The egrep pattern used by cg-tag is too restrictive. While it will prevent
control characters from being specified as a tag name, it will also reject
nearly anything written in a non-English language, as noted by -hpa

Signed-off-by: Martin Atukunda <matlads@dsmagic.com>

---

 cg-tag |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

187670279068e7177149765a7f736cc565a1fe19
diff --git a/cg-tag b/cg-tag
index da4f2d5..73616b8 100755
--- a/cg-tag
+++ b/cg-tag
@@ -54,7 +54,7 @@ id=$(cg-object-id -n "$id") || exit 1
 type=$(git-cat-file -t "$id")
 id=${id% *}
 
-(echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
+git-check-ref-format $name || \
 	die "name contains invalid characters"
 
 mkdir -p $_git/refs/tags
-- 
0.99.9.GIT
