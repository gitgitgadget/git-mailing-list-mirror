From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Bug in "git show"?
Date: Mon, 15 Jul 2013 13:25:59 +0200
Message-ID: <51E3DC47.70107@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 13:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uygue-0007ao-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 13:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab3GOLZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 07:25:48 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:63617 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab3GOLZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 07:25:48 -0400
Received: by mail-bk0-f53.google.com with SMTP id e11so4459660bkh.26
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=xg8Bq9KzT4FdvgS1t9/GcCWg7bXkEpQIsxfpqY5O2vA=;
        b=LITouJjB1tGzbCpwudiPv2tuspOarUbivU+UHul6B8zBELYy+3HR8yjLpuaj9oBZ7U
         rjVW2OAPuC5K7YEASMdbmIdir0m8S/5DXafgHEqJSMg+uwG/s7aKSneU5j/P2SjsNcM6
         TRGgvBmfh7QRujW1WOgy3R17Loj3wvw/RnFeueKQ8BLlc+V3WShWuCvqJQO7YKawrXCv
         D5yu+yxIKhV/qrp3oCndWeQjUfQ/k/rzRBGfu0XKPmyKLo6xZ7cH9BzvsC2oj1XFvgys
         rb0uLBJPtbYAVZKJYPZ4uerCCwy83mFybRLh8X4iYEtJsMhvz8ojb5jI7eTVSimtN99F
         eyrw==
X-Received: by 10.205.14.138 with SMTP id pq10mr7607640bkb.123.1373887546505;
        Mon, 15 Jul 2013 04:25:46 -0700 (PDT)
Received: from [131.234.75.130] (eduroam-75-130.uni-paderborn.de. [131.234.75.130])
        by mx.google.com with ESMTPSA id lb14sm12052868bkb.6.2013.07.15.04.25.45
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 04:25:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230457>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

so I wanted to write a script using some git commands,
but the output of the git commands is not as expected.
I am using

git --version
git version 1.8.3.2.804.g0da7a53
(current origin/master at git://github.com/gitster/git.git)

The command I am trying to use is
git --no-pager show --format="%ad" <commit>

Expected output:
sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^
Fri Jul 12 12:04:19 2013 -0700

sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^
Fri Jul 12 12:04:17 2013 -0700

sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^^
Fri Jul 12 12:04:16 2013 -0700

sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^^^
Fri Jul 12 12:04:14 2013 -0700

sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^^^^
Fri Jul 12 12:04:12 2013 -0700

sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^^^^^
Fri Jul 12 12:04:10 2013 -0700

sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^^^^^^
Fri Jul 12 12:04:09 2013 -0700

sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^^^^^^^
Fri Jul 12 12:04:07 2013 -0700

However I sometimes also get:
sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53
Fri Jul 12 10:49:34 2013 -0700

diff --git a/Documentation/RelNotes/1.8.4.txt
b/Documentation/RelNotes/1.8.4.txt
index 0e50df8..4250e5a 100644
- --- a/Documentation/RelNotes/1.8.4.txt
+++ b/Documentation/RelNotes/1.8.4.txt
@@ -79,6 +79,13 @@ Foreign interfaces, subsystems and ports.

 UI, Workflows & Features

+ * "gitweb" learned to optionally place extra links that point at the
+   levels higher than the Gitweb pages themselves in the breadcrumbs,
+   so that it can be used as part of a larger installation.
+
+ * "git log --format=" now honors i18n.logoutputencoding configuration
+   variable.
+
  * The "push.default=simple" mode of "git push" has been updated to
    behave like "current" without requiring a remote tracking
    information, when you push to a remote that is different from where


sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53^^^^^^^^
Fri Jul 12 12:04:07 2013 -0700

diff --cc t/t5505-remote.sh
index ee5d65d,8d0f3e3..8f6e392
- --- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@@ -61,25 -62,25 +61,25 @@@ test_expect_success C_LOCALE_OUTPUT 're
  '

  test_expect_success 'add another remote' '
 -(
 -      cd test &&
 -      git remote add -f second ../two &&
 -      tokens_match "origin second" "$(git remote)" &&
 -      check_tracking_branch second master side another &&
 -      git for-each-ref "--format=%(refname)" refs/remotes |
 -      sed -e "/^refs\/remotes\/origin\//d" \
 -          -e "/^refs\/remotes\/second\//d" >actual &&
 -      >expect &&




So at some commits, also the diff is shown, which should not happen
if you're using --format="%ad" to my understanding.

So far it seems to be deterministic here. (Each commit either always
behaves correctly or incorrectly). Initially I suspected it being
different for merges or no-merges, but I gut the unexpected behavior
for both merge and non-merge commits.

Can somebody confirm this behavior or has any idea, whether I am doing
something wrong here?

Thanks,
Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR49xHAAoJEJQCPTzLflhqiFcP/0S5M71urjn1Fh5Cz2950wBl
cs6+r9wKF5366wv3Ombfh0KrOPQCE7Yv1GWk2r2L008BWrz0wgnsl1xnMnAT00dH
1WzmupWExxwXHAueDisq2qL4dubFrnVxKWvpwxBd3JBbsWNXeTGl5o6dl69zaXdx
JHzIHvw1/vrxoCLaflitjcQezuFITOVVoNsYawK12gznjxujONm0sej5TBFUw784
K5KTJNJqxzUf9+Z+88hg2oif7kJlugTIqtH5sRMVwXrkpc12f+HcwROg0srE5ITc
8WpK0s7xgZokUCohMhUXlLAOYJwAZju+K1LExkrQ9T32oP4iAKsJpqcRLAAX6Ig7
OeaWUQ2WX2CfYDExjuV6h+FXAU0qT87iv3PgeZWAnmgDQPUwFboIxuF1Nrpq/FOY
Ioe2YOsFOdhmuDjCHEfu0aVNOeejHS8LEkC1IUI/+PzDlEJC/b17SwEdrD4aVCPj
RZhz2zI8ZxYHP9ITvMDs1VQRP6jMSAwEtAWg7ac7ypETToOIAxRp2j9Rrjayt8A5
/TZ++wMh7G4Tm/D9+iutQnqzE8E8eiT6i7LgAcDSA3g6oq7/hUzupKU2lc+znO2J
wxiwdqYBHWtw1Jc8eaZAJC/NMfxbRzOSCx4lJbO+tpXP0pR/OPIg2f2wUXcAh3zH
JC9GdEUVIwN34j2ueoZ8
=G6Oc
-----END PGP SIGNATURE-----
