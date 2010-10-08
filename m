From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 03/10] branch_empty: use pretty_tree and therefore respect -i/-w
Date: Fri,  8 Oct 2010 09:58:01 +0200
Message-ID: <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qo-00020q-Ig
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943Ab0JHH6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab0JHH6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:17 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77487bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=5jCU9SsHDDGOpMgZRj2uXCWbEW+ox6X/kFEFaviSgfc=;
        b=PyS90HtHs7BL07Hwsh5DMH0TlyD/WUObblTjQeJ29RcUVeXf9rJKJhzi6WliCovxw0
         9ywuM+RXv61mH3r7zr7yXbPZOrNUp/u3CtMHvm4ABtQ6OhYgf9X2uOug8fPdN96S/IpC
         fgghsaiy2ILo79T4J7yiQZ+PhhBjLw8OsDvHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KDCZ6LmeNufU7VgVQoUrjI4pvN/XL9RG5OlTpiIz+J0N4b9eBv1CzIIO5QrLQo2qTf
         me/LMr/kazK7EsDwbn0VXFT8k0C0J1uRJkJldmm9vL6OR3BfCE2uO0lDQ89JxMq9B2Jn
         aXbjbdJR6SPkTNuuVZkfFSUfGlu05Lu33kIZU=
Received: by 10.204.71.139 with SMTP id h11mr1699830bkj.135.1286524696381;
        Fri, 08 Oct 2010 00:58:16 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id 11sm2425019bkj.23.2010.10.08.00.58.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158485>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index 308ed28..a166a70 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -283,10 +283,10 @@ needs_update()
 	recurse_deps branch_needs_update "$@"
 }
 
-# branch_empty NAME
+# branch_empty NAME [-i | -w]
 branch_empty()
 {
-	[ -z "$(git diff-tree "refs/top-bases/$1" "$1" -- | fgrep -v "	.top")" ]
+	[ "$(pretty_tree "$1" -b)" = "$(pretty_tree "$1" ${2-})" ]
 }
 
 # list_deps
-- 
1.7.1.1067.g5aeb7
