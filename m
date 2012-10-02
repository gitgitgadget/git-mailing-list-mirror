From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] git-gui: Few issues with using full path name
Date: Tue,  2 Oct 2012 12:25:13 -0400
Message-ID: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 18:26:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5Hr-0006K0-JV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab2JBQZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:25:25 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36993 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab2JBQZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:25:24 -0400
Received: by iagy32 with SMTP id y32so753414iag.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TDE/j5XrvKA2QHVVVHxdAvhjiALatsdalmCBQ+2sjAk=;
        b=LfoLI8C09oTt/0lR2bymx3a89/WhGyRZF/ZJry7COy2/lqC79ojKwxJ7G5QLJ8CuCM
         4HUzSibNPF0G0ynbzt1ukvdbea7yPeiZ69Nbx36vTZYqs4dtLcugt+OzefWo0B33IBEz
         QSkyd5Ui+fpvCtQyc6JQu2oJtHJHSDjCy5YSbvuBKm8B/F6wWGYFhhP6ODT8LFAUzyzK
         9Y84awNMIRPSvRmRlcK3eWSZVOK1Q6epOx7t7aVE2P53qsEyT2egBrYfxOpZabh+izK3
         ZLZcha6k0y9xJMv3mDLNxsF0NBuvWzPjKyJlj5sTx5VfJcjVlFGlvTN7LLQ5Hlc4eM4X
         qcUw==
Received: by 10.50.202.73 with SMTP id kg9mr9404321igc.42.1349195124169;
        Tue, 02 Oct 2012 09:25:24 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id d19sm9109210igp.6.2012.10.02.09.25.19
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:25:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206812>

I ran into a file name parsing issue in git-gui. If I'm in a subfolder and try
to pass a full path to "git-gui blame", then "git-gui" will fail to detect the
argument as a valid path. The first patch will handle this scenario.

The second patch just another issue that I noticed when "git-gui" fails to
detect the file name. It'll then try to use the previously detected "head" as
the file name, while prepending it with "prefix". This is incorrect if "head"
is actually a full path.

There is also an issue when using a full path along with a rev argument, but I
don't have time to look it right now. I'll try to get to that issue another
time.

Andrew Wong (2):
  git-gui: Detect full path when parsing arguments
  git-gui: Don't prepend the prefix if value looks like a full path

 git-gui.sh | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.12.1.382.gb0576a6
