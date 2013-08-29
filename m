From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/9] transport-helper: add 'force' to 'export' helpers
Date: Thu, 29 Aug 2013 10:23:20 -0500
Message-ID: <1377789808-2213-2-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF490-0008ME-KU
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab3H2P2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:28:19 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46287 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab3H2P2S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:28:18 -0400
Received: by mail-oa0-f46.google.com with SMTP id o20so770930oag.5
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2U8x5B+kZaeUzBnaE8Ifh+Lwxp9fIkCnavDeHNJcLC8=;
        b=FlMYiUUAN3xFTTqKohaMAU9pIpVzcog9vQ23SwtCjqlcGTdz5yXJeu28sFu2wsqXA6
         i2kybHxJsbZ+W8DiGUZ1qK9CTMqM3yG1BnnqyZhZWeM7KnC7+33LAMh7jjhxwZJmq0w0
         VxlhKuD9E9atAeOaJ5MGQBPjPTbfkJrDg+/hW3GgOyeXkQ0k43EXWKrh0bY3gJwmo6qU
         dlqI+5Qk7kssWUFlhFC78e8XJyPWP7x3uPhYjetl+HMiyJyDOuD6jrFpe0DlBLtyugVV
         tQxpPx1P4X/NjFQB6AjMWia9kytPufxgPWsIEdHybXuy6OUFgJWM3Wcn/5Y2OY3o7jkI
         lWjA==
X-Received: by 10.182.76.98 with SMTP id j2mr1953918obw.106.1377790097729;
        Thu, 29 Aug 2013 08:28:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ps5sm33018663oeb.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:28:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233268>

Otherwise they cannot know when to force the push or not (other than
hacks).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 63cabc3..62051a6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -814,6 +814,9 @@ static int push_refs_with_export(struct transport *transport,
 			die("helper %s does not support dry-run", data->name);
 	}
 
+	if (flags & TRANSPORT_PUSH_FORCE)
+		set_helper_option(transport, "force", "true");
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.4-fc
