From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/13] remote-hg: properly report errors on bookmark pushes
Date: Thu,  4 Apr 2013 09:30:12 -0600
Message-ID: <1365089422-8250-4-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm8z-0003uy-Sc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762542Ab3DDPbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:35 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:60447 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762486Ab3DDPbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:31 -0400
Received: by mail-oa0-f54.google.com with SMTP id n12so2873529oag.41
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6RnqPkOzcSu/6IgaZeg8/+MHi2o/J089wvX3sg7PyhQ=;
        b=F3j0tifen1b94lrXMQx5vP+QEiRJgjEhK3joZ7UrZz4xCPuUoTfKAIydjUfNr9NbSe
         XveIaFgCvBYkBdgFK6CBTeQKwijVpwXI9S1XyCwIBmpAi/fsjYIEiN8e8D86z5kc5B79
         59zdf1rqSt8hyKDLPadiyLXx98t9sNgeOo+1wETW/29/hicwl9v3lxT2w5JRw6YXzghD
         lAWs1WtlbD9Fgzmi2pB73fGGvE6c0mhJcYnxR/TfvBpOtjs1g+Bp2kvLSDFtFGA9ogdy
         OgqwgXOwUrqMrpL8rER3H5CCjs0JzZyiOTFmp+6PLyBpuMDr/5vqKlWq/vKKNxBo2xa6
         sSgA==
X-Received: by 10.60.149.229 with SMTP id ud5mr4672973oeb.133.1365089488903;
        Thu, 04 Apr 2013 08:31:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id do4sm2973191oeb.0.2013.04.04.08.31.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220006>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 844ec50..19eb4db 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -710,6 +710,7 @@ def do_export(parser):
             else:
                 old = ''
             if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+                print "error %s" % ref
                 continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
-- 
1.8.2
