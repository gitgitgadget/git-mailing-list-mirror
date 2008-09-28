From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 1/8] Docs: send-email's usage text and man page mention same options
Date: Sat, 27 Sep 2008 20:09:49 -0500
Message-ID: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 03:29:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjl6E-00062G-3G
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 03:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYI1BWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 21:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYI1BWL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 21:22:11 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:49489 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbYI1BWK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Sep 2008 21:22:10 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8S1A2Ue006864;
	Sat, 27 Sep 2008 21:10:03 -0400 (EDT)
Received: from localhost.localdomain (97-116-110-244.mpls.qwest.net [97.116.110.244])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8S19usC017501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Sep 2008 21:10:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.g577ee
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96931>

Specifically, boolean options are now listed in the form

    --[no-]option

and both forms of documentation now consistently use

    --[no-]signed-off-by-cc

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |   21 +++++++++++++--------
 git-send-email.perl              |    8 ++++----
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3c3e1b0..9b31626 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -40,8 +40,7 @@ The --cc option must be repeated for each user you want on the cc list.
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---chain-reply-to::
---no-chain-reply-to::
+--[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -66,8 +65,7 @@ The --cc option must be repeated for each user you want on the cc list.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---signed-off-by-cc::
---no-signed-off-by-cc::
+--[no-]signed-off-by-cc::
         If this is set, add emails found in Signed-off-by: or Cc: lines to the
         cc list.
         Default is the value of 'sendemail.signedoffcc' configuration value;
@@ -146,8 +144,7 @@ user is prompted for a password while the input is masked for privacy.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---suppress-from::
---no-suppress-from::
+--[no-]suppress-from::
         If this is set, do not add the From: address to the cc: list.
         Default is the value of 'sendemail.suppressfrom' configuration value;
         if that is unspecified, default to --no-suppress-from.
@@ -163,8 +160,7 @@ user is prompted for a password while the input is masked for privacy.
 	if that is unspecified, default to 'self' if --suppress-from is
 	specified, as well as 'sob' if --no-signed-off-cc is specified.
 
---thread::
---no-thread::
+--[no-]thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
 	header set.
@@ -183,6 +179,15 @@ user is prompted for a password while the input is masked for privacy.
 	variable; if that is unspecified, choosing the envelope sender is left
 	to your MTA.
 
+--no-validate::
+	Don't perform any sanity checks on patches.
+	Currently, validation means the following:
++
+--
+		*	Warn of patches that contain lines longer than 998 characters; this
+			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
+--
+
 --to::
 	Specify the primary recipient of the emails generated.
 	Generally, this will be the upstream maintainer of the
diff --git a/git-send-email.perl b/git-send-email.perl
index d2fd899..9f56162 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -64,11 +64,11 @@ Options:
                   Only used if --compose is also set.  If --compose is not
 		  set, this will be prompted for.
 
-   --chain-reply-to If set, the replies will all be to the previous
+   --[no-]chain-reply-to If set, the replies will all be to the previous
                   email sent, rather than to the first email sent.
                   Defaults to on.
 
-   --signed-off-cc Automatically add email addresses that appear in
+   --[no-]signed-off-by-cc Automatically add email addresses that appear in
                  Signed-off-by: or Cc: lines to the cc: list. Defaults to on.
 
    --identity     The configuration identity, a subsection to prioritise over
@@ -95,9 +95,9 @@ Options:
 		  'cccmd' for the output of the cccmd, or 'all' to suppress
 		  all of these.
 
-   --suppress-from Suppress sending emails to yourself. Defaults to off.
+   --[no-]suppress-from Suppress sending emails to yourself. Defaults to off.
 
-   --thread       Specify that the "In-Reply-To:" header should be set on all
+   --[no-]thread       Specify that the "In-Reply-To:" header should be set on all
                   emails. Defaults to on.
 
    --quiet	  Make git-send-email less verbose.  One line per email
-- 
1.6.0.2.304.g577ee
