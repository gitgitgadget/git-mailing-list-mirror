From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/24] merge script: tweak unmerged files message to match
 builtin
Date: Tue, 17 Aug 2010 02:03:36 -0500
Message-ID: <20100817070336.GM22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGEa-0000RD-2V
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948Ab0HQHFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:05:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42193 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715Ab0HQHFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:05:12 -0400
Received: by gxk23 with SMTP id 23so2288305gxk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=73eGNF2iI8Gt8BBVodwar+XShDtf8EVCk4niuAXwbpc=;
        b=Wqb/wd+TVAbHGGPtXx/9QORFHNeskvatc6l9zXLGZDpm/Vt3pwoYq5pRl9lQuUIHMA
         SORcrSuOBDTWVAh28lzo80+HLvmv2F9bRWyIJk0sTMiMIM6njy4unsLUDr8r3QHlkszt
         nKjPapEGFLR8SRDje7cUNFlCzQvKmcXoMgmVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=slppeNdy0577046O8HLKZl1NV5/kw/Q4+SMjVIoCSUrKj35JhoOMpqMHEuk0jahu00
         p3w8xzMXJ0kVQD4OrvR8O41UK4Jzu0APAR2vLT1HOVnRGh+Y66DkHByvndwGf/cwpDkg
         OCtp97jlW2hgZfiRJQ3/wDjzrs3Ew3HBNt/vM=
Received: by 10.151.17.31 with SMTP id u31mr6955368ybi.194.1282028711521;
        Tue, 17 Aug 2010 00:05:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q17sm7498489ybk.17.2010.08.17.00.05.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:05:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153716>

Before:

	You are in the middle of a conflicted merge.

After:

	Merge is not possible because you have unmerged files.

I prefer the old message, but the new one is more consistent with
other commands and tests expect it.  In particular, without this
change the scripted merge does not pass t3030.

Based on v1.7.0-rc0~66^2 (Be more user-friendly when refusing to do
something because of conflict., 2010-01-12).

Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 72853cf..99fe1f2 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -25,7 +25,7 @@ require_work_tree
 cd_to_toplevel
 
 test -z "$(git ls-files -u)" ||
-	die "You are in the middle of a conflicted merge."
+	die "Merge is not possible because you have unmerged files."
 
 LF='
 '
-- 
1.7.2.1.544.ga752d.dirty
