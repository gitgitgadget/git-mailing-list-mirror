From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 26/32] svn: learn ref-storage argument
Date: Wed, 24 Feb 2016 17:58:58 -0500
Message-ID: <1456354744-8022-27-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPg-00040K-Pi
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759221AbcBXW7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 17:59:51 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34713 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759199AbcBXW7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:44 -0500
Received: by mail-qg0-f47.google.com with SMTP id b67so27015839qgb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6O0ByBPZkcDYeoRADSItuF8NNEU66VSs6r2uefaESqU=;
        b=df9Pn8+KzjWcwjlQYWPF/QQfa9oQpxbi5q+DG9706+ZtakcgURU3jxFQPdy7qWE1Np
         SVko2V8kMqFEDE4dL6rD0etjvoC3scbqimb9JEBdJ44TIFVQJzavn8L0BTc1KdX9YVGK
         d34ML5eEd/aaM2kM+Y3SlFb5j9avnlEoGQYwImxsOreIiTR5SzS5NycmuMXjbYj3tyqB
         9eBZ6BpPA4ttNC/E2kuKeXDYWOFu8cB+uC/YYh1mRt2S4chczam/pzDI98MQLlNGcmpV
         dOnnHyD7QRxWSTKPah42oCiN+MRCZkqOFcCZ/qzZM6164b54u3bIOWlt34c2XZ+Xfkb4
         RIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6O0ByBPZkcDYeoRADSItuF8NNEU66VSs6r2uefaESqU=;
        b=TUOUv03Ptded1FmsLtEwtAcaFgKHpzhPIedv0555Z9q7yTVfWBytjbcu5tpfxrmEua
         sRTDH8u/ZNqkm4ysJbARJMZ+kIBO/TnIiFM/FjlB0kNM+1nEk/YVgy2m1EAMwcIJ/JLP
         XrfXieyoEb1pdn5dhK8tYNSVhODicUNnWnv/K2jq0ImMb1M6kEZDmWvfCb+nYBiwPJdk
         Tmq0w3jYROGtp8Ay6YgYDYfv1kLxVOMK50p0+t57bQXTrTUkw076zTh/k+y5x5z2pDU6
         roNnihm/oq7zdwNmFAqBVpGqr/totew5wto4pekUSC1JH4252etnhTU/sUACMDxdGukD
         KNXw==
X-Gm-Message-State: AG10YOQ1UYqH16oF7FbD/6yMpcd27DOteMeTUzaWnlDkMq1naL8GfPUIOd5GZjRfol+QwA==
X-Received: by 10.140.181.130 with SMTP id c124mr54811669qha.75.1456354783530;
        Wed, 24 Feb 2016 14:59:43 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:42 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287256>

git svn learns to pass the ref-storage command-line argument (to init
and clone) through to git init.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/completion/git-completion.bash | 2 +-
 git-svn.perl                           | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index cb9c473..ba4137d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2477,7 +2477,7 @@ _git_svn ()
 			--branches=3D --stdlayout --minimize-url
 			--no-metadata --use-svm-props --use-svnsync-props
 			--rewrite-root=3D --prefix=3D --use-log-author
-			--add-author-from $remote_opts
+			--add-author-from --ref-storage=3D $remote_opts
 			"
 		local cmt_opts=3D"
 			--edit --rmdir --find-copies-harder --copy-similarity=3D
diff --git a/git-svn.perl b/git-svn.perl
index fa5f253..62464d1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -141,7 +141,7 @@ my %fc_opts =3D ( 'follow-parent|follow!' =3D> \$Gi=
t::SVN::_follow_parent,
 		'localtime' =3D> \$Git::SVN::_localtime,
 		%remote_opts );
=20
-my ($_trunk, @_tags, @_branches, $_stdlayout);
+my ($_trunk, @_tags, @_branches, $_stdlayout, $_ref_storage);
 my %icv;
 my %init_opts =3D ( 'template=3Ds' =3D> \$_template, 'shared:s' =3D> \=
$_shared,
                   'trunk|T=3Ds' =3D> \$_trunk, 'tags|t=3Ds@' =3D> \@_t=
ags,
@@ -153,6 +153,7 @@ my %init_opts =3D ( 'template=3Ds' =3D> \$_template=
, 'shared:s' =3D> \$_shared,
 		  'use-svnsync-props' =3D> sub { $icv{useSvnsyncProps} =3D 1 },
 		  'rewrite-root=3Ds' =3D> sub { $icv{rewriteRoot} =3D $_[1] },
 		  'rewrite-uuid=3Ds' =3D> sub { $icv{rewriteUUID} =3D $_[1] },
+		  'ref-storage=3Ds' =3D> \$_ref_storage,
                   %remote_opts );
 my %cmt_opts =3D ( 'edit|e' =3D> \$_edit,
 		'rmdir' =3D> \$Git::SVN::Editor::_rmdir,
@@ -469,6 +470,9 @@ sub do_git_init_db {
 				push @init_db, "--shared";
 			}
 		}
+		if (defined $_ref_storage) {
+			push @init_db, "--ref-storage=3D" . $_ref_storage;
+		}
 		command_noisy(@init_db);
 		$_repository =3D Git->repository(Repository =3D> ".git");
 	}
--=20
2.4.2.767.g62658d5-twtrsrc
