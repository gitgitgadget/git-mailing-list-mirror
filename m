From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 13/19] from-submodule: add url to .gittrees
Date: Sat, 9 Mar 2013 19:28:31 +0000
Message-ID: <CALeLG_kbrP=ZR0T9BjvB6RMsR8vJuu-kSmxp_4AMdB1okGHidg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPRy-0003e7-QG
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab3CIT2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:28:33 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35421 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CIT2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:28:32 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so2221326obc.19
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=IAFo8vQ4Axqt5JULSwuN9SQJikPW+XmZ59lQB/foFn8=;
        b=NCqo1rK1u2mjbxvUVxp0lBdSy9IVlKMTsYjvbWO8/52RG+E/zmY7WM1RfWvz1LAM4r
         y5ueQEsOsZgxtVGneLj48uj5WUg9yYDH4Ev4VgE8ejNMLGrQsSF9PPEV+ux8YiJp/d9Z
         4hiaHuEnAenAHcI6Be8ulPgUaUdwOfoeM7tjjecBD48n/CxwX5l4jZIQlAX46Ldp2U6+
         IV5WmKwUQXNJqZ8ti+MhjHDsPQkjyFl9X3BX2tgeTzSecmbse2sroy1+r8Al5gnHS7W9
         51gqEeEDLM9CYHcTOZV03Na9BRX7h6nymA8XAOey6w8l4SCmZs/DdZIXsgq/E4X5LsaX
         kyPw==
X-Received: by 10.60.22.34 with SMTP id a2mr5044562oef.97.1362857312066; Sat,
 09 Mar 2013 11:28:32 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:28:31 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQnWe+K5yxOzr2oDpsalMnwHjGIMMtKaSbk+gHMLfdnTA/fpME0UYbPwyyee9qNtX8IWQJqu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217750>

>From e1b71e3bf8abaea424972d13ba028b911b07d85a Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:34:31 +0000
Subject: [PATCH 13/19] from-submodule: add url to .gittrees

Conflicts:
	git-subtree.sh

Original-Author: Herman van Rink <rink@initfour.nl>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index ae7d1fe..84c90c7 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -806,6 +806,7 @@ cmd_from-submodule()
 	ensure_clean

 	local submodule_sha=$(git submodule status $prefix | cut -d ' ' -f 2)
+	local submodule_orig_repo=$(git config --file .gitmodules
submodule.$prefix.url)

 	# Remove references to submodule.
 	git config --remove-section submodule.$prefix
@@ -824,6 +825,10 @@ cmd_from-submodule()
 	# subtree add from submodule repo.
 	cmd_add_repository $tmp_repo HEAD

+	# Update .gittrees with the original repo url
+	git config --file .gittrees --unset subtree.$prefix.url
+	git config --file .gittrees subtree.$prefix.url $submodule_orig_repo
+
 	# Remove submodule repo.
 	rm -rf $tmp_repo
 }
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
