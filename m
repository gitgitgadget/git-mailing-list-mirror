From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 27/33] svn: learn ref-storage argument
Date: Mon, 29 Feb 2016 19:53:00 -0500
Message-ID: <1456793586-22082-28-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYa0-0007Nb-UR
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbcCAAyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 19:54:18 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36309 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcCAAx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:59 -0500
Received: by mail-qg0-f51.google.com with SMTP id u110so1416720qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TEDlCXBzh6+5XQGr4bLR0roeOXMihoVNZajoOinuOs=;
        b=AnIgQHTkIqdzRQhECXYIZ4nVaXiMYBQgq5G7GOS/kv6HO7ahSLCg8nr2pmzjTGI0NP
         6aUccxohMsQ5cfTTWp/m4An0VJPVS3swyRjn8d4pkJh+gJJsvVROE7O0LzCrR0ghs/Zb
         rTEYc0R/GT4MI/Y7bWu0W5kyW07oWTh84Caiq9dLk2jDZ+n3k/G59ubo/tSUWpO66sC3
         TTWtT4k8zlV9l86lRCkIyccREJl5ubLRcvTESw/Qa1oh5MqJPBE9U6NdXUnagbfqicHL
         ufc4EwcCzQVdMgVbfmDKAZSuiwmQnxNWmiIT3P+TPtAWCv/sCPfhTYRv3xGv69012c85
         w+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TEDlCXBzh6+5XQGr4bLR0roeOXMihoVNZajoOinuOs=;
        b=i6aHcoI4TKE2nrR2uCshfuvAK1ih5zx7/sdj1RpgZzQI7imVuPROh8LPjIBJSjyrxp
         ERebGRwLQ0cE5JE+aQfBlDW8OpUek23XkSJABj90S1VXk/8WJNGQSlviWG5HrbdO9NO4
         +Jl0u0e1SNZcXNAZwD51WGgn/WHTuKvEfMqxjPzkJqp9SSOTkio2VWpgUNVuT5BD63dH
         9OjsyUlKm2qvQ9+AujopydYnGG6drSqQF9zIy9NJAyf1+KjVCd1yszQyTrwBlpcOxqvK
         O8180pUWwdEQOdCA4v5LOMp97EwMPSTHBF0cUUVLXCc1ZyN12Zd9wX2eqfK7TjrZrNKQ
         dJcQ==
X-Gm-Message-State: AD7BkJLpnX4DHkVaTHSaM6oL/PhZhT4pXJ47z5dJ2PZLys9K2h2CquAQpuwYp1kcfNcHjw==
X-Received: by 10.140.252.197 with SMTP id x188mr24298954qhc.81.1456793638293;
        Mon, 29 Feb 2016 16:53:58 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:57 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287964>

git svn learns to pass the ref-storage command-line argument (to init
and clone) through to git init.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 git-svn.perl                           | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index a0225f4..4b15631 100644
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
