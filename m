From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] fast-export: speed improvements
Date: Thu,  2 May 2013 23:31:38 -0500
Message-ID: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 06:33:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY7gD-0004ag-53
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 06:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab3ECEdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 00:33:04 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:57416 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3ECEdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 00:33:03 -0400
Received: by mail-yh0-f47.google.com with SMTP id i57so47950yha.6
        for <git@vger.kernel.org>; Thu, 02 May 2013 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Y94W4jQNuI7gM+2yYK7Ex35hdB3ZWB+56UaOhqgcRbY=;
        b=D0sR33klsXJ/a9fHPVfTsLuc20L8GzmU+oEEu2pt/Nsjeo/J31h6o6EeSGfYYFTH7S
         qZrn+sDUsAexIumb4EanSBhrHeO9KNy/+LsJVn2FZt9qghxuASFoU6/dl/XMvC7VqAts
         e5kZxkbAlG97kQ44eMzrr+fTPpp+X3I7ijd98ImGgdrVMVbVg8NOndEFg1BWPoW7Pix1
         QV8cvzvyMHbZQ57Ku1XiCQnwS/oIupD0rzcGVdsTQ7YGdUBdo2V9QqpKxd3h0YicT2T+
         98XGqjiMyJSfXUnPVRjI97Y1Wavk0XhpOHBAUTIReJCvJ/Nt3ptL59JjcbZYsy3zhtxq
         cMiQ==
X-Received: by 10.236.118.113 with SMTP id k77mr7269759yhh.147.1367555581848;
        Thu, 02 May 2013 21:33:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id y24sm13556953yhn.20.2013.05.02.21.32.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 21:33:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223275>

Hi,

Parsing the marks of an import of the emacs repository moves fast-export to a
crawl. It takes 14 minutes in my setup, after these patches, it takes 1 second.

The important patches are #2 and #3, the rest are niceities.

Felipe Contreras (4):
  fast-{import,export}: use get_sha1_hex() directly
  fast-export: improve speed by skipping blobs
  fast-export: don't parse all the commits
  fast-import: only store commit objects

 builtin/fast-export.c | 17 ++++++++++-------
 fast-import.c         | 19 ++++++++++++-------
 2 files changed, 22 insertions(+), 14 deletions(-)

-- 
1.8.3.rc0.401.g45bba44
