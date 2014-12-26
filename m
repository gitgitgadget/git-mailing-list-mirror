From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 0/2] Fix issue with format-patch and diff.submodule
Date: Fri, 26 Dec 2014 17:11:44 -0600
Message-ID: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 00:11:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4e33-0004E5-IY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 00:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbaLZXLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2014 18:11:53 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44134 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaLZXLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2014 18:11:52 -0500
Received: by mail-ob0-f181.google.com with SMTP id gq1so35586510obb.12
        for <git@vger.kernel.org>; Fri, 26 Dec 2014 15:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oFdnFIdEHA9Oih5qcUAexbGNQ4GFr+krsOhKVkIu8aM=;
        b=uJl2+aVpZX6WOSa9ClIERoM5CqN6la4vrCCBIcZjrk6eXyposdNHm7G+JsQuziSsAs
         V7bsH9U9lVzX8S/ZG3z+p7RP/P8bXcxvc7FoBEs+IwCgGPMWCUDIyusyTSN5aV4AWtsN
         rNoUVI5GHKZAikC4cU2u4uvJBNqkVX+oxu5FahtbY8sa3/D9LoMSkx1NXpmg2jnSaGkI
         cq6JRudNw3oXrx3m0osplHNd3gL16bWVZrwvceaIVxLPcB8LxpL64stidhPXZnjy7/Ce
         pDqFyTCqZb5ylHyY94ZQqtbpK7dWWXHL8hrsShTG0+Xksd9Rp2k4GUcav4K8YncmJZ5c
         rKoA==
X-Received: by 10.182.108.194 with SMTP id hm2mr799638obb.85.1419635511796;
        Fri, 26 Dec 2014 15:11:51 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id w81sm15074486oiw.10.2014.12.26.15.11.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Dec 2014 15:11:50 -0800 (PST)
X-Mailer: git-send-email 2.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261830>

A colleague found an issue that when using diff.submodule=log in his
.gitconfig, format-patch would use the log format for submodule changes,
which would be ignored or error out when processed by git-am.
format-patch now ignores the diff.submodule option and a testcase for
this specific issue now exists.

Since this seems like a bug in current versions, I have based and
tested this on the "maint" branch, but there's no reason it shouldn't
apply cleanly to master as well.

Apologies for any rawness to the first round of this change.
"Long time listener; first time caller." Any feedback is appreciated.

Doug Kelly (2):
  t4255: test am submodule with diff.submodule
  format-patch: ignore diff.submodule setting

 builtin/log.c           |  2 +-
 t/t4255-am-submodule.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)

-- 
2.0.5
