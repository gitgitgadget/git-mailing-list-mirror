From: Chris Packham <judge.packham@gmail.com>
Subject: recurse_submodules vs recurse-submodules
Date: Fri, 11 Feb 2011 11:59:31 +1300
Message-ID: <AANLkTimppKC_CsN6hc4xGqtMBk8p2QEFjHYRWesKK8_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens.Lehmann@web.de
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnfUB-0008Es-2z
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab1BJW7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:59:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57064 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab1BJW7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:59:33 -0500
Received: by fxm20 with SMTP id 20so2028596fxm.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 14:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=F5FkoJofS0AXcrgwdF5baYn1n5lH5udrmamARt4qvqI=;
        b=LResUmL/3eNS5h5AJoNyFBnbsb41DeF9AnBFo4oYXVaj41sXmRvpu1JeuML58+F8ac
         pCnxK0pk98vhllEsqvybDEg7zxsJfmRYqskvme5m1/sMPXfstRwxQ3l6P0FZkVBR74oG
         2e3D3DAsCinTq0+0UiWL+xsq6BxP6f6qDJYDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=vwE1IKK+DQhhBzZjZC4cBV7f1BIrP4FRKBquWV2JKM0LM/PC9Bq2y7Vnwn+TDvHN3X
         2eLjSVGdWSW8qEnDKm1sV1r2cLZ29UVEOn4IDz0yQgXi1HxE+M8vwoPRaG6yXKMX0AbO
         1GbzacKXOUI8iUvvZcLxbRq2SGimkzDcnoXRM=
Received: by 10.223.102.67 with SMTP id f3mr3269268fao.125.1297378772018; Thu,
 10 Feb 2011 14:59:32 -0800 (PST)
Received: by 10.223.93.202 with HTTP; Thu, 10 Feb 2011 14:59:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166512>

Hi,

Just noticed this in git 1.7.4

  git clone -h
  ...
      --recursive           initialize submodules in the clone
      --recurse_submodules  initialize submodules in the clone

  git fetch -h
  ...
     --recurse-submodules  control recursive fetching of submodules

The recurse_submodules option for git clone was added in ccdd3da6 I'm
guessing it wasn't Jens' intention to use an underscore instead of a
hypen. Also as it is fairly new it should be safe to correct without
worrying about retaining the incorrect option for backwards
compatibility.


Here's my attempt at a fix

----8<----
From 24c582c2c9bc4f66980679a20d3eb9de6a031071 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Fri, 11 Feb 2011 11:31:06 +1300
Subject: [PATCH] clone: fixup recurse_submodules option

The recurse_submodules option was added in ccdd3da6 to bring 'git clone'
into line with 'git fetch' and future commands. The correct option should
have been "recurse-submodules".

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 61e0989..82a6938 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -66,7 +66,7 @@ static struct option builtin_clone_options[] = {
 		    "setup as shared repository"),
 	OPT_BOOLEAN(0, "recursive", &option_recursive,
 		    "initialize submodules in the clone"),
-	OPT_BOOLEAN(0, "recurse_submodules", &option_recursive,
+	OPT_BOOLEAN(0, "recurse-submodules", &option_recursive,
 		    "initialize submodules in the clone"),
 	OPT_STRING(0, "template", &option_template, "path",
 		   "path the template repository"),
-- 
1.7.4
