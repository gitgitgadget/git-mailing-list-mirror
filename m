From: Sam Ravnborg <sam@ravnborg.org>
Subject: git apply fails to apply a renamed file in a new directory
Date: Thu, 25 Oct 2007 20:07:37 +0200
Message-ID: <20071025180737.GA13829@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 20:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il761-000806-UL
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbXJYSGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbXJYSGE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:06:04 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:36703 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbXJYSGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:06:03 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 446AF1828C
	for <git@vger.kernel.org>; Thu, 25 Oct 2007 20:06:01 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id AB633580D2; Thu, 25 Oct 2007 20:07:37 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62342>

I just stumbled on what looks like a simple bug in git apply.
I had following diff:

diff --git a/arch/i386/defconfig b/arch/x86/configs/i386_defconfig
similarity index 100%
rename from arch/i386/defconfig
rename to arch/x86/configs/i386_defconfig
diff --git a/arch/x86_64/defconfig b/arch/x86/configs/x86_64_defconfig
similarity index 100%
rename from arch/x86_64/defconfig
rename to arch/x86/configs/x86_64_defconfig
-- 
1.5.3.4.1157.g0e74-dirty

When trying to apply this diff using:
git apply -p1 < .../patch

I noticed that the two defconfig files were deleted as expected,
but the renamed versions did not appear in the arch/x86/configs/
directory.
The configs/ directory did not exist and was not created.
Without looking at git apply I assume that the rename failed because
it is not prepared to rename a file to a directory that does not exist.

Buried in other stuff so I did not take a look myself..

	Sam
