From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 7/7] perl/Git.pm: rename 'ActiveState' to 'Windows'
Date: Wed, 30 Jan 2013 15:23:03 -0200
Message-ID: <1359566583-19654-8-git-send-email-gnustavo@cpan.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bVO-0002Am-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445Ab3A3RbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:31:00 -0500
Received: from mail-gg0-f177.google.com ([209.85.161.177]:62122 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441Ab3A3Ra6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:30:58 -0500
Received: by mail-gg0-f177.google.com with SMTP id q1so302238gge.36
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=dudzYZ+NxMttntkLrEatxn2kIrtzppR7YVzAGCYrhe0=;
        b=Y3j7i696dqgVyJVBJasp1I/bDvbiBkshxHON4jfyKu0j+UMOf9W+mrRSNNzoFiUsPo
         MpBfcRSZN7d1nLUk+E5nrsNj/kRJ+ecItSPpzrF8cw7JgjPfCuorROkBpNpJ/NRme7cw
         mUNC0W5sul57kPeR3MOivAjX2H8eAOgLdE7J7g8a4pJTmcZjLlMG2k+rfyyVCdVo2qLA
         KJz/cMaU6hAd2B9OvRapV4T1F+Bb1AA/4hQBuLC/m74SA8IB4wPAGqOOpE4QlOAk1QOw
         fvQSx9c7XInfiDXzLyebwaoreDUglOS5jmjOTq0eEOowUlE2zNNLm5kaswtzkJLKJSMY
         nN0A==
X-Received: by 10.236.131.211 with SMTP id m59mr6449581yhi.49.1359566601387;
        Wed, 30 Jan 2013 09:23:21 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.19
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:20 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
In-Reply-To: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
X-Gm-Message-State: ALoCoQmmb2/V2aIdbFMIeazFP6SnbDbpSeyznSHyQRzQ64QTbl/TPBmiFcm6YeI1Is1wvL8hSiMM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215041>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

Windows specific code was mentioning ActiveState Perl specifically,
but that code works with Strawberry Perl too.

Hence, we rename every instance of 'ActivePerl' to 'Windows' to convey
the more general idea.

Signed-off-by: Gustavo L. de M. Chaves <gnustavo@cpan.org>
---
 perl/Git.pm | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index fdef024..e03b82f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1297,11 +1297,10 @@ sub _command_common_pipe {
 
 	my $fh;
 	if ($^O eq 'MSWin32') {
-		# ActiveState Perl
 		#defined $opts{STDERR} and
-		#	warn 'ignoring STDERR option - running w/ ActiveState';
+		#	warn 'ignoring STDERR option - running on Windows;
 		$direction eq '-|' or
-			die 'input pipe for ActiveState not implemented';
+			die 'input pipe for Windows not implemented';
 
 		# Set up repo environment
 		local $ENV{GIT_DIR}       = $self->repo_path() if defined $self && $self->repo_path();
@@ -1315,13 +1314,13 @@ sub _command_common_pipe {
 			chdir $self->wc_subdir() if $self->wc_subdir();
 		}
 
-		# the strange construction with *ACPIPE is just to
+		# the strange construction with *WINPIPE is just to
 		# explain the tie below that we want to bind to
 		# a handle class, not scalar. It is not known if
-		# it is something specific to ActiveState Perl or
+		# it is something specific to Perl on Windows or
 		# just a Perl quirk.
-		tie (*ACPIPE, 'Git::activestate_pipe', $cmd, @args);
-		$fh = *ACPIPE;
+		tie (*WINPIPE, 'Git::windows_pipe', $cmd, @args);
+		$fh = *WINPIPE;
 
 		chdir $cwd;
 	} else {
@@ -1391,9 +1390,9 @@ sub DESTROY {
 }
 
 
-# Pipe implementation for ActiveState Perl.
+# Pipe implementation for Perl on Windows.
 
-package Git::activestate_pipe;
+package Git::windows_pipe;
 use strict;
 
 sub TIEHANDLE {
-- 
1.7.12.464.g83379df.dirty
