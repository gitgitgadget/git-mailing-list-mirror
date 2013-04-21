From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/1] git-multimail: a replacement for post-receive-email
Date: Sun, 21 Apr 2013 12:49:39 +0200
Message-ID: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Chris Hiestand <chrishiestand@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	=?UTF-8?q?Stefan=20N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 12:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTrqb-00044r-ES
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 12:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab3DUKuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 06:50:11 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:54690 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753155Ab3DUKuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Apr 2013 06:50:09 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-76-5173c46067d1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.BD.02295.064C3715; Sun, 21 Apr 2013 06:50:08 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49D6.dip0.t-ipconnect.de [79.221.73.214])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3LAo0sm022946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Apr 2013 06:50:05 -0400
X-Mailer: git-send-email 1.8.2.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqJtwpDjQ4MRxNYu1z+4wWVw7uZjF
	Ym93J6tF15VuJouG3ivMFm9vLmG0uPR5PatF45Mii9sr5jNbvD/7n9mBy+Pv+w9MHuf2LmTx
	2DnrLrvHxC/HWT0uXlL2+LxJzuPA5cdsAexR3DZJiSVlwZnpefp2CdwZK08dYS9YoFKxcON8
	pgbGfzJdjJwcEgImEhNOL2eCsMUkLtxbz9bFyMUhJHCZUaJ18xV2kISQwAUmib+fC0BsNgFd
	iUU9zWANIgJqEhPbDrGANDALnGWWeHushxkkISzgLXHx01egIg4OFgFViV1TjUHCvAIuEkfP
	drBCLFOQOL59G+MERu4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MULC
	jGcH47d1MocYBTgYlXh4C34UBQqxJpYVV+YeYpTkYFIS5X2wtzhQiC8pP6UyI7E4I76oNCe1
	+BCjBAezkgiv5gqgHG9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgnfm
	YaBGwaLU9NSKtMycEoQ0EwcniOAC2cADtGEGSCFvcUFibnFmOkTRKUZFKXHeGpCEAEgiozQP
	bgAsIbxiFAf6R5g3AaSKB5hM4LpfAQ1mAhr8mbsQZHBJIkJKqoGxQqsjqvN4wjmDg409BjzP
	DCsf73czfqu4a7LHhJlNMnsUlO8q/To8Mdt+ern7KZeOnl7+HuGzm2yKFPe8WLRxjpSIauBn
	xq8lYeorpIo7hKd+mjZhW1nL+6Rpz/pW6ex4IccpN33+ew+1vE87uL1bT1qxKhxM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221941>

This is the third iteration of submitting git-multimail to Git.  The
first pass [1] was a modest trial balloon, proposing to add a new
script to live alongside post-receive-email.  Following feedback [2]
from the mailing list, I decided to make the script a full replacement
for post-receive-email (and renamed it from post-receive-multimail.py
to git-multimail).  The second pass [3] was an RFC that generated a
lot of useful feedback, some requests for better support of old
features (mostly implemented), and some contributions by other members
of the community (especially Matthieu Moy).  The overall reaction to
git-multimail as a replacement for post-receive-email has been quite
positive.

Now I believe that git-multimail is ripe for inclusion in contrib.
Its features are documented in the README file and its advantages over
post-receive-email are documented in the file
README.migrate-from-post-receive-email.

This series consists of a single patch that adds a directory
contrib/hooks/git-multimail/ containing five files, described in the
patch's commit message.  It does *not* deprecate post-receive-email,
let alone remove it, though I hope that both of those steps will be
warranted in time.

If there is consensus that git-multimail should be integrated into the
Git project, there are some logistical issues that need to be
discussed:

* Code drop versus merge?

  * The first 170 commits to git-multimerge took place in a private
    repository, commingled with other material.  All of these commits
    were by me.  I don't have time to sanitize these commits into a
    publishable history, so I'm afraid that part of the history will
    never become public.

  * The subsequent 200 commits of the history have been published to
    GitHub [4].  (The version that I am submitting corresponds to the
    git-multimail subtree of revision
    c06a1af5d3a9dfbac7eb704dc8e15a2aee60a334 of that repository.)
    These commits are reasonably clean, though definitely not up to
    the usual Git project standards.  The first of these commits
    consists of a code drop from the private repository just
    mentioned.  The recent part of this history includes commits by
    other authors.

  Would it be preferable to merge the last 200 commits of the
  git-multimail history into the Git project (presumably via subtree
  merge), or just to incorporate it as a single, squashed patch?

* What to include?  The GitHub repo contains some infrastructure
  outside of the git-multimail directory, which is not included in
  this patch series:

      .gitignore, COPYING -- redundant with the Git project's
          top-level files.

      MANIFEST.in, setup.py -- infrastructure for Python's setuptools
          (to allow git-multimail to be packaged as a Python module,
          probably irrelevant in the context of the Git project.

      README -- a symlink to git-multimail/README.

      t/ -- some crude scripts and data that I have been using for
          testing.  The tests are largely manual, so it is not clear
          whether they would be helpful within the Git project.

      notes.txt -- TODO list etc.

* How to organize future development?  Directly in the Git repo, using
  the git mailing list, etc?  As a fork of the Git project that
  occasionally issues patches and/or pull requests to the main
  project?  Or as a separate project that does not include the whole
  Git tree, which is occasionally merged back to the Git project using
  subtree merge?

[1] http://article.gmane.org/gmane.comp.version-control.git/201433
[2] http://article.gmane.org/gmane.comp.version-control.git/201471
[3] http://article.gmane.org/gmane.comp.version-control.git/214686
[4] https://github.com/mhagger/git-multimail

Michael Haggerty (1):
  git-multimail: a replacement for post-receive-email

 contrib/hooks/git-multimail/README                 |  410 ++++
 .../README.migrate-from-post-receive-email         |  146 ++
 contrib/hooks/git-multimail/git_multimail.py       | 2126 ++++++++++++++++++++
 .../hooks/git-multimail/migrate-mailhook-config    |  270 +++
 contrib/hooks/git-multimail/post-receive           |   66 +
 5 files changed, 3018 insertions(+)
 create mode 100644 contrib/hooks/git-multimail/README
 create mode 100644 contrib/hooks/git-multimail/README.migrate-from-post-receive-email
 create mode 100755 contrib/hooks/git-multimail/git_multimail.py
 create mode 100755 contrib/hooks/git-multimail/migrate-mailhook-config
 create mode 100755 contrib/hooks/git-multimail/post-receive

-- 
1.8.2.1
