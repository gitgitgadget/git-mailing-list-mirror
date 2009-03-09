From: Phil Lawrence <prlawrence@gmail.com>
Subject: [PATCH] Append ampersand to "Target" of lnk files created by 
	do_cygwin_shortcut
Date: Mon, 9 Mar 2009 17:09:49 -0500
Message-ID: <530ac78e0903091509y5209dec9q4c716d1e400357f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 23:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgnhZ-0003Ms-PL
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 23:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZCIWJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 18:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZCIWJw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 18:09:52 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:45602 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbZCIWJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 18:09:52 -0400
Received: by el-out-1112.google.com with SMTP id b25so1073285elf.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=DyrEdL9+B+HSCQYD4zuO1JJM1srutHIX3J9fBHkpxkI=;
        b=u183BxwdA0Ns2ddtVuPfJiW8u1NoyeNBq4Lt/fGjWutsb4X6RlmzITkjAMVNbxGWzp
         oI6HeiI4Ny0ewqq8iW1yQIddJnYRzSvKRPU4/qnMX4y4cayGTVIKAG5BMdDxyYU7ayFE
         m9D2GF2WE3DYUV84HZ92NGyBpGLM2/Fb58xBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WRftXM8m62OfgGTIq85qMGY2vIvSdCMQGNiFwjExgsQfgP4MDEheq0hD/TV4HG3eM2
         RP92LDGgTBIr6Tx0tWu3OjoFs8TPZaEiVxc5vRO4SIgZX4XrSABgQnWlgjmNXW7yRaHM
         48j5TdhYlOwAzeU16bpeLYYmfZNoBnCRjRJfI=
Received: by 10.231.30.67 with SMTP id t3mr1552998ibc.21.1236636589294; Mon, 
	09 Mar 2009 15:09:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112750>

On Mon, Mar 9, 2009 at 4:12 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> <snip!>
>
> Could you add those explanations to the commit message?

Done:

>From 0780db8d53bdd0bb02b154d23c3c80bcccc0d955 Mon Sep 17 00:00:00 2001
From: Phil Lawrence <prlawrence@gmail.com>
Date: Thu, 5 Mar 2009 17:56:58 -0600
Subject: [PATCH] Append ampersand to "Target" of lnk files created by
do_cygwin_shortcut

The git-gui menu item "Repository | Create Desktop Icon" creates a
shortcut (.lnk file) on the Windows desktop.  The purpose of the
created shortcut is to make it easy for a user to launch git-gui
for a particular repo in the future.

A Windows user would expect to see git gui launch when they click
the shortcut; they would not expect (nor want) to see a cmd window
open and remain open in the background.

msysGit avoids opening a command window altogether when it's Git GUI
shortcut is used.  Ideally, git on cygwin would also have shortcuts
that simply open the GUI, but as a first step, this change allows
the shell window to politely disappear after starting git gui as a
background process.

Signed-off-by: Phil Lawrence <prlawrence@gmail.com>
---
 lib/shortcut.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index 38c3151..2f20eb3 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -54,7 +54,7 @@ proc do_cygwin_shortcut {} {
                                        $argv0]
                                win32_create_lnk $fn [list \
                                        $sh -c \
-                                       "CHERE_INVOKING=1 source
/etc/profile;[sq $me]" \
+                                       "CHERE_INVOKING=1 source
/etc/profile;[sq $me] &" \
                                        ] \
                                        [file dirname [file normalize [gitdir]]]
                        } err]} {
--
1.6.1.9.g97c34

Phil Lawrence
