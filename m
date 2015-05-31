From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/9] send-email: visually distinguish sendmail aliases parser warnings
Date: Sun, 31 May 2015 18:29:24 -0400
Message-ID: <1433111371-19573-3-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkX-0005cM-0a
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601AbbEaWa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:29 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33227 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758514AbbEaWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:20 -0400
Received: by igbpi8 with SMTP id pi8so48788590igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qny4A2x/J0F6axgyMSHzliMetnncUylhXCHxjfTA8NA=;
        b=BP0Om+SNUEAhHS+dTjuODtxBH/C0p0MhZTPIM7998UoQ7eAsFXHbUAdiCHkx6RlfRK
         HZbbs9a8lFwqNpNgbD317ZioGEwzYOrYtA3bZJtmUJAjU0n77FjVuT5Sa4Hqo2C0BCZZ
         OWEi39/TTvFrjHQCvrUTawo1RUtpz7eKrpuA5Xe5PsCzsDhw6B6yJ+hCZ6qqd/GFrzrM
         ePR0StFc5++DMVGlcy0IRykJ89Z2iizzeCL72+NxGHZAJsT6wdDMcoPLdz46o2m34aZz
         My6etqgSS+Wv4CEByjU2X2Y3X0V3wIxCsfkGzL7AaSHSC/7xdQ590iNMNGwHdHc7NKVF
         WmDw==
X-Received: by 10.107.167.73 with SMTP id q70mr22959133ioe.82.1433111420387;
        Sun, 31 May 2015 15:30:20 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270355>

Although emitted to stderr, warnings from the sendmail aliases parser
are not visually distinguished as such, and thus can easily be
overlooked in the normal noisy send-email output.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This prepends lowercase "warning:" rather than uppercase since lowercase
is used elsewhere in git-send-email.perl for diagnostic message
prefixes.

 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6bedf74..819f87e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -522,12 +522,12 @@ my %parse_alias = (
 
 		# warn on lines that contain quotes
 		elsif (/"/) {
-			print STDERR "sendmail alias with quotes is not supported: $_\n";
+			print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
 		}
 
 		# warn on lines that continue
 		elsif (/^\s|\\$/) {
-			print STDERR "sendmail continuation line is not supported: $_\n";
+			print STDERR "warning: sendmail continuation line is not supported: $_\n";
 		}
 
 		# recognize lines that look like an alias
@@ -538,7 +538,7 @@ my %parse_alias = (
 
 		# warn on lines that are not recognized
 		else {
-			print STDERR "sendmail line is not recognized: $_\n";
+			print STDERR "warning: sendmail line is not recognized: $_\n";
 		}}},
 
 	gnus => sub { my $fh = shift; while (<$fh>) {
-- 
2.4.2.538.g5f4350e
