From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 23/24] merge script: notice @{-1} shorthand
Date: Tue, 17 Aug 2010 02:11:30 -0500
Message-ID: <20100817071130.GW22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGMg-0003ZW-JG
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab0HQHNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:13:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57437 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0HQHNF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:13:05 -0400
Received: by mail-yw0-f46.google.com with SMTP id 1so2274283ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=v/lWhBEc0KlBg05k0HrkTlL9CNI4QMlD3mHnerVpkXI=;
        b=hfRV+kn9fCDtvCvLTpHeSEf3EkBQ7hLxKXfs88Zx3jwoPzoUEm+6SSCKv+37Tm8uYr
         THXJVPfoDoPhx0luBtV1CwzAntl53kSxLyqOPWTkl7zghhe1NfswCYsibVFqZZwyHZQE
         n1ja8HREqZ/OdINrbpLyhyoi/3yNYWIwdM96w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qOX64N/hFNlSqPzvHCjlDUuM908RYmVQYDO58XLImA0s+i4qVqNEDyxKBfMFNuWOlC
         9a7EabVRAmLfyjMjJAb6bKraDTPecaZEQbQl/dDwbScIy5/9CT0Xnp2tvea5i/zK2S/J
         /0TpslBbKb4RfQ/HdkoGF9NLKjFnN8vfZrTb8=
Received: by 10.100.153.15 with SMTP id a15mr7073084ane.179.1282029185474;
        Tue, 17 Aug 2010 00:13:05 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c19sm11771220ana.22.2010.08.17.00.13.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:13:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153726>

Port v1.6.2-rc1~10^2 (Teach @{-1} to git merge, 2009-02-13) to
the old merge script.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 5a2addd..bed55a4 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -148,13 +148,15 @@ merge_name () {
 	if found_ref=$(git rev-parse --symbolic-full-name --verify \
 							"$remote" 2>/dev/null)
 	then
+		expanded=$(git check-ref-format --branch "$remote") ||
+			exit
 		if test "${found_ref#refs/heads/}" != "$found_ref"
 		then
-			echo "$rh		branch '$remote' of ."
+			echo "$rh		branch '$expanded' of ."
 			return
 		elif test "${found_ref#refs/remotes/}" != "$found_ref"
 		then
-			echo "$rh		remote branch '$remote' of ."
+			echo "$rh		remote branch '$expanded' of ."
 			return
 		fi
 	fi
-- 
1.7.2.1.544.ga752d.dirty
