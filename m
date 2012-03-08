From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] pre-rebase hook: capture documentation in a <<here document
Date: Thu, 8 Mar 2012 06:21:55 -0600
Message-ID: <20120308122105.GA1562@burratino>
References: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
 <7vmxc6xs73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:22:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5cMG-000813-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab2CHMWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 07:22:06 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:46744 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757485Ab2CHMWE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:22:04 -0500
Received: by obbuo6 with SMTP id uo6so587294obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SyOnrQltGX4WY8CzIb3jhQWvDdUrtmfV1VfFTC0BoRU=;
        b=hsbna+GNLbV4oTeSiqh1qFrFoDYtW9p/wJORcgM7NPZFNTGYS1pwHo7+1A6MbZ077H
         RXzp0u2od0XwWA5pt3rpkgswzi03FokR8Ppgre8ujSjyuEcN+UqGVnz8BfQ1FhqUf7wm
         oTA3qTBPxQinmzhPLTAVcE5gp2xQa+Ib/imcjaKa1pawVaOMhtxe4dwcQErC1Zj1M9an
         QHETYFeHUl/psxQypQ/32QmVoXp5DDyS2wYcPaf209LM47rbMjGMMBNPFPSpBNsEWzMJ
         igYs4WCluX2QZsoVr36kYreBeUOzoPtcM44BWKPfGK5NJZurUFwieP8OFIY7LjlPQxqh
         wM9g==
Received: by 10.60.7.7 with SMTP id f7mr2453865oea.19.1331209323568;
        Thu, 08 Mar 2012 04:22:03 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 4sm872436oex.0.2012.03.08.04.22.02
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 04:22:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmxc6xs73.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192583>

Without this change, the sample hook does not pass a syntax check
(sh -n):

  $ sh -n hooks--pre-rebase.sample 
  hooks--pre-rebase.sample: line 101: syntax error near unexpected token `('
  hooks--pre-rebase.sample: line 101: `   merged into it again (either directly or indirectly).'

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>       pre-rebase hook: capture documentation in a <<here document [4]
>
> I do not mind this but if you are to do so you should remove the "exit 0"
> before that block.

Done. ;)

Thanks, and sorry for the slow reply.

Jonathan

 templates/hooks--pre-rebase.sample |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index 053f1111..b7f81c19 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -88,9 +88,7 @@ else
 	exit 1
 fi
 
-exit 0
-
-################################################################
+<<\DOC_END
 
 This sample hook safeguards topic branches that have been
 published from being rewound.
@@ -167,3 +165,5 @@ To compute (2):
 	git rev-list master..topic
 
 	if this is empty, it is fully merged to "master".
+
+DOC_END
-- 
1.7.9.2
