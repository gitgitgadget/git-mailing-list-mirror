From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make project specific override for 'grep' feature work
Date: Sun, 07 Dec 2008 10:36:36 +0100
Message-ID: <20081207093447.25785.41811.stgit@localhost.localdomain>
References: <20081207052230.GD4357@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 10:38:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9G5z-0003wh-SF
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 10:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbYLGJhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 04:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbYLGJhR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 04:37:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:18389 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbYLGJhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 04:37:15 -0500
Received: by ug-out-1314.google.com with SMTP id 39so373774ugf.37
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 01:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=rWBNBBcJjIy1+whPEForlFfNj6ONmH37n4blToRh21s=;
        b=R9u9yqUjzbh7VSgUGg1LibbmT37y36QWe89PVrdAK0kv9Jx3rTuP0jeytTZ42lvoI2
         xo5ixyUlKD2auOzVAyNb5XviFjTNwQ+14KaCSp0J912ymCnacdd4LL/6w4ljyGaKIYe7
         gzWAT/PxSFTQp9ovnnHPlQKiakLXUs7JM0PNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=XHejtRwjemjPJm84W2+ATbPUm3w5z1IQiB1nzy6+TpoARvw0mKWsCyxj16GxUxvq2n
         xtgmRQqcudqmAS3V8icRHF7xWRwkg80j001Snv6l2EPb4S8FsTue+MAjCWowFnle91we
         gZuTtShDgGIXoIbCLXMYvSfRmTgG1cT7et0no=
Received: by 10.67.87.11 with SMTP id p11mr1295586ugl.32.1228642633316;
        Sun, 07 Dec 2008 01:37:13 -0800 (PST)
Received: from localhost.localdomain (abvv225.neoplus.adsl.tpnet.pl [83.8.219.225])
        by mx.google.com with ESMTPS id 32sm4117833ugf.40.2008.12.07.01.37.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 01:37:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB79abeL025828;
	Sun, 7 Dec 2008 10:36:48 +0100
In-Reply-To: <20081207052230.GD4357@ftbfs.org>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102492>

The 'grep' feature was marked in the comments as having project
specific config, but it lacked 'sub' key required for it to work.

Kind-of-Noticed-by: Matt Kraai <kraai@ftbfs.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Matt Kraai wrote:

> A feature_grep subroutine is defined in gitweb.perl, but unlike the
> other feature_* subroutines there, it doesn't appear to be used
> anywhere.  Should it be removed?

No, it was oversight; it should be used in setting up 'grep' %feature
configuration, see below.

Thanks for catching this.

 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 95988fb..9517392 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -241,6 +241,7 @@ our %feature = (
 	# $feature{'grep'}{'override'} = 1;
 	# and in project config gitweb.grep = 0|1;
 	'grep' => {
+		'sub' => \&feature_grep,
 		'override' => 0,
 		'default' => [1]},
 
