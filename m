From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] git-svn: add --authors-prog option
Date: Thu, 21 May 2009 01:43:43 -0700
Message-ID: <20090521084343.GA6401@dcvr.yhbt.net>
References: <20090510003509.GA2000@dcvr.yhbt.net> <1242350835-22684-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 10:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M73sZ-0005Mz-68
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 10:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbZEUIno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 04:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbZEUInm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 04:43:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53395 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbZEUInm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 04:43:42 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA041F7CC;
	Thu, 21 May 2009 08:43:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1242350835-22684-1-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119661>

Mark Lodato <lodatom@gmail.com> wrote:
> Signed-off-by: Mark Lodato <lodatom@gmail.com>

Thanks again Mark, sorry again for the late response, it's been
a long few weeks for me.

Acked-by: Eric Wong <normalperson@yhbt.net>

And pushed out to git://git.bogomips.org/git-svn along with
a few others that I had acked:

Alex Vandiver (3):
      git-svn: Fix for svn paths removed > log-window-size revisions ago
      git-svn: Correctly report max revision when following deleted paths
      git-svn: Set svn.authorsfile if it is passed to git svn clone

Eygene Ryabinkin (1):
      git-svn testsuite: use standard configuration for Subversion tools

Mark Lodato (1):
      git-svn: add --authors-prog option

> ---
> 
> Third attempt at the patch.  I fixed a typo and reworded the documentation
> (thanks to Michael Gruber), and I fixed a small mistake in the commit message.
> Other than rebasing onto master, nothing else was changed.

A bunch of tests got broken but I squished this on top to fix them:

diff --git a/git-svn.perl b/git-svn.perl
index af80e24..a70c7d7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -265,7 +265,9 @@ usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
 load_authors() if $_authors;
-$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
+if (defined $_authors_prog) {
+	$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
+}
 
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
 	Git::SVN::Migration::migration_check();

-- 
Eric Wong
