From: Trygve Aaberge <trygveaa@gmail.com>
Subject: [PATCH] completion: Support exclude prefix, ^<rev>
Date: Thu, 29 Jan 2015 18:05:54 +0100
Message-ID: <20150129170554.GP8104@aaberge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 18:06:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGsXb-00078i-96
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 18:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbbA2RF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 12:05:58 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:45657 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbbA2RF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 12:05:58 -0500
Received: by mail-lb0-f173.google.com with SMTP id p9so30456823lbv.4
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 09:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=l1YYAv7BPTH7pk6QLHV4D3eOLHXp8wQaWxwzcF+4yA4=;
        b=MEH2Nf9Gf5dMGVb04LahnWM2Wp38IZ+wVmp+xQRN4Staj32b8B+H8TG9gUVQLJ8H60
         H3Yyu/BqjlxUnlOjlLBf8kWT1Q9yh8SeorJLGs02MSFIwTqQ2U9Bjs82KyvNg6AFKfSJ
         DJlb5STrkHOao7KbtoYqeh6EVEpkYHUaePeYbnXu47U8c+tOZKvYB2ZaLMZmIJ92P166
         vqBV4BKzhuKAnHi05N6lGQEctS3oVOdfV39oOs9HBxXs/lL2ISXbZ4zcoaUellQ/bkBA
         35wL7bInqFVaA7HJmx8+UbQUtEJnMLiREupR6lU2F85+rHHdg3c2/FiqTas3j5kIsgnv
         xMYQ==
X-Received: by 10.112.57.226 with SMTP id l2mr2032344lbq.27.1422551156603;
        Thu, 29 Jan 2015 09:05:56 -0800 (PST)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by mx.google.com with ESMTPSA id s7sm2216429las.17.2015.01.29.09.05.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Jan 2015 09:05:55 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263153>

When using the exclude pattern, ^<rev>, the completion did not work.
This enables completion after ^ in the same way that completion after ..
is done.

Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8cfee95..3036dac 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -496,6 +496,10 @@ __git_complete_revlist_file ()
 		cur_="${cur_#*..}"
 		__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		;;
+	^*)
+		cur_="${cur_#^}"
+		__gitcomp_nl "$(__git_refs)" "^" "$cur_"
+		;;
 	*)
 		__gitcomp_nl "$(__git_refs)"
 		;;
-- 
2.2.2
