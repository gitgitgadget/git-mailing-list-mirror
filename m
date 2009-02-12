From: Jeremy White <jwhite@codeweavers.com>
Subject: [PATCH v2] Update documentation to add further information about
 using Thunderbird with git-imap-send.
Date: Thu, 12 Feb 2009 15:17:04 -0600
Message-ID: <499491D0.5000908@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 22:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXixC-00059p-12
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZBLVRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbZBLVRJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:17:09 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:46537 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbZBLVRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:17:08 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LXivh-00089i-Ki
	for git@vger.kernel.org; Thu, 12 Feb 2009 15:17:05 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109657>

Signed-off-by: Jeremy White <jwhite@codeweavers.com>
---

With thanks to Jakub Narebski, who caught that I had the boolean
flag inverted.


 Documentation/SubmittingPatches |   27 +++++++++++++++++++++++++++
 Documentation/git-imap-send.txt |   14 ++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ba07c8c..9b559ad 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -376,9 +376,36 @@ Thunderbird
 
 (A Large Angry SCM)
 
+By default, Thunderbird will both wrap emails as well as flag them as
+being 'format=flowed', both of which will make the resulting email unusable
+by git.
+
 Here are some hints on how to successfully submit patches inline using
 Thunderbird.
 
+There are two different approaches.  One approach is to configure
+Thunderbird to not mangle patches.  The second approach is to use
+an external editor to keep Thunderbird from mangling the patches.
+
+Approach #1 (configuration):
+
+This recipe is current as of Thunderbird 2.0.0.19.  Three steps:
+  1.  Configure your mail server composition as plain text
+      Edit...Account Settings...Composition & Addressing,
+        uncheck 'Compose Messages in HTML'.
+  2.  Configure your general composition window to not wrap
+      Edit..Preferences..Composition, wrap plain text messages at 0
+  3.  Disable the use of format=flowed
+      Edit..Preferences..Advanced..Config Editor.  Search for:
+        mailnews.send_plaintext_flowed
+      toggle it to make sure it is set to 'false'.
+
+After that is done, you should be able to compose email as you
+otherwise would (cut + paste, git-format-patch | git-imap-send, etc),
+and the patches should not be mangled.
+
+Approach #2 (external editor):
+
 This recipe appears to work with the current [*1*] Thunderbird from Suse.
 
 The following Thunderbird extensions are needed:
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index bd49a0a..1685f04 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -98,6 +98,20 @@ Using direct mode with SSL:
 ..........................
 
 
+CAUTION
+-------
+It is still your responsibility to make sure that the email message
+sent by your email program meets the standards of your project.
+Many projects do not like patches to be attached.  Some mail
+agents will transform patches (e.g. wrap lines, send them as
+format=flowed) in ways that make them fail.  You will get angry
+flames ridiculing you if you don't check this.
+
+Thunderbird in particular is known to be problematic.  Thunderbird
+users may wish to visit this web page for more information:
+  http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
+
+
 BUGS
 ----
 Doesn't handle lines starting with "From " in the message body.
