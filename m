From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 18/20] svn: learn ref-storage argument
Date: Thu, 14 Jan 2016 11:26:15 -0500
Message-ID: <1452788777-24954-19-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjy-0002SK-6H
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbcANQ0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:55 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:32813 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbcANQ0w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:52 -0500
Received: by mail-qk0-f172.google.com with SMTP id p186so228167662qke.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dGcbZ81EWm/tWV91s4cz1//X/c9mTh0vRHyUE/Atmjw=;
        b=ri+g62+E9Y1+1wviExILFr8iweGi23WX+ddpDHlWf1fTZ+jKj7woU6O/iW/H74B/N6
         N8+qBiZcybUvzvY7BCaZ4RrMHA05mpr9wBR4vTNx2CrfGbtC9bSvdLpaMO9vL0yyycHp
         TEPoPmxaO20KBG1iNVIUQ0SrMQHP150zYgeBG+s2Kng//JDXxFYnQ3OpP2BKvrKKwnUi
         OgqxcjyvHYQ/FhvgMjfVhtuHCWE5h61UJIVXl7OkriLp5zrWvQFyIStTsS2cmSKWT6cs
         kf9uqSkjTvr4Mv5fvCOsqSjLcKA9fYX2HEypUX74O43Lapj7J8kNv8xng0w+vdHF7OI1
         heug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dGcbZ81EWm/tWV91s4cz1//X/c9mTh0vRHyUE/Atmjw=;
        b=hvSsHKhoaLaEG1trOkOx4aYfdQUo10IN+iTEy4dUAlTZP42DXs4ZQj/xZ/3QrBwtVc
         t/r2NOldljr15z48wfWPnamMmWRvj1Wv7T3UcM84xAD+/HrMBmdR6F7FrPKaVaSNzD2O
         4z874+KWFwKAzTZMa2+d7a9a6wxiZzx0qkF/bI3BJKdsCYld+yEXAykOoT1JNeEPF/YI
         3P5BXiFiaxwNyuUAyIgFAzHG/+s5zuMW7VXEtlA0vqUd/+NIQI0zGBvIxGjxaJGSAUXb
         3orNjgdMF4IQ9H/4QP+/078bxfNAMXO4BhQloGOJJriehPs/BKlbT1AW3OkI7LaeVlyU
         6N8w==
X-Gm-Message-State: ALoCoQmlPSXO67JQvIJ+xxldspFbP+B7QEYVjO7gVllxqy0Ms/mKOtZqlukgaMR6FFYLoIVlPmxUbDWcxfY8vA0UfVoaMVc2ng==
X-Received: by 10.55.22.9 with SMTP id g9mr6707821qkh.12.1452788812167;
        Thu, 14 Jan 2016 08:26:52 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:51 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284044>

git svn learns to pass the ref-storage command-line argument (to init
and clone) through to git init.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-svn.perl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index fa5f253..15d1544 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -141,7 +141,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'localtime' => \$Git::SVN::_localtime,
 		%remote_opts );
 
-my ($_trunk, @_tags, @_branches, $_stdlayout);
+my ($_trunk, @_tags, @_branches, $_stdlayout, $_ref_storage);
 my %icv;
 my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
@@ -153,6 +153,7 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
 		  'use-svnsync-props' => sub { $icv{useSvnsyncProps} = 1 },
 		  'rewrite-root=s' => sub { $icv{rewriteRoot} = $_[1] },
 		  'rewrite-uuid=s' => sub { $icv{rewriteUUID} = $_[1] },
+		  'ref-storage=s' => \$_ref_storage,
                   %remote_opts );
 my %cmt_opts = ( 'edit|e' => \$_edit,
 		'rmdir' => \$Git::SVN::Editor::_rmdir,
@@ -469,6 +470,9 @@ sub do_git_init_db {
 				push @init_db, "--shared";
 			}
 		}
+		if (defined $_ref_storage) {
+		    push @init_db, "--ref-storage=" . $_ref_storage;
+		}
 		command_noisy(@init_db);
 		$_repository = Git->repository(Repository => ".git");
 	}
-- 
2.4.2.749.g730654d-twtrsrc
