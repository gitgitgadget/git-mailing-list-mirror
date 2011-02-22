From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 00/73] No-op gettextize core Git C programs
Date: Tue, 22 Feb 2011 23:41:19 +0000
Message-ID: <1298418152-27789-1-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tQ-0007sP-Lv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab1BVXnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:32 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab1BVXnb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:31 -0500
Received: by bwz10 with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=X/jNmFbL3rRTLqMBdTzPDVKvhY3YFkLp8wlV6GN3+/8=;
        b=oCp0Q9BzyTEQYAqKjHsPALOOKDEJ6EPpl98WLTkMJqv8zvdtlcNHTqvtdCPB+/DMcm
         wolZ4W3Qli7FMQaLjgxdCMbwb4kNnk/VWltyFSnqo90JMpbLBYbGMrhq9qM0TbMfxc9M
         MNzkEkqOl5Mmd3aOJcb2ixi0vX+dhc0nhKrwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RYg0aOuo7p1msDLBle+YBWxUtbar38KSQY4TjybZ4q1KaZbvaw0HkVZANad7ZoMuic
         NRfc6pl7nm8JeCDGVqlR6vZXJv7w1In89k2CLHm/GccFnG1dOh+ii2q8rzn4ngO4fK9q
         FdfrBKxwsrgNi6xpsOIn73IVwCSApU3n2bfNc=
Received: by 10.204.4.212 with SMTP id 20mr3047670bks.172.1298418209460;
        Tue, 22 Feb 2011 15:43:29 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.28
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:28 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167591>

This is an improved version of the no-op gettextize series for core
Git C programs based on Jonathan Nieder's v3 series. Changes since
then.

  * After it's applied Git will no longer fail tests when compiled
    with GETTEXT_POISON=3DYesPlease. It did this because Jonathan's
    series changed the GETTEXT POISON string. See the comment in the
    "simulate unfriendly translator" patch. Regarding Junio's comment:
   =20
      As to Malkovich, I tend to agree with your reasoning that code th=
at
      emit messages prefixed by "#" rebase relies on should be restruct=
ured
      to limit the scope of translation to just the body of these lines=
, and
      that should be done in a separate patch.

    I agree. I'll change it to just "GETTEXT POISON" in a later
    patch. But I'd prefer not to break git in any testing mode until
    then.
   =20
  * Reverted back to using the "gettextize" patch subjects I
    originally used. I'm using these consistetly so I can later git
    log --grep=3Dgettextize: to find them. I'd like to preserve that
    attributed.

  * Amended and improved some log messages.

Other than that it's the same. For this to compile without warnings
you first need the "Add missing const to char* declarations" series
I've just submitted. But otherwise it's all good to go.

Jonathan Nieder (1):
  gettext: do not poison translations unless GIT_GETTEXT_POISON envvar
    is set

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (72):
  gettext: add no-op _() and N_() wrappers
  gettext tests: add GETTEXT_POISON to simulate unfriendly translator
  Makefile: "pot" target to extract messages marked for translation
  gettextize: git-init basic messages
  gettextize: git-init "Initialized [...] repository" message
  gettextize: git-clone basic messages
  gettextize: git-clone "Cloning into" message
  gettextize: git-clone "Cloning into" message
  gettextize: git-add basic messages
  gettextize: git-add "The following paths are ignored" message
  gettextize: git-add "did not match any files" message
  gettextize: git-add "remove '%s'" message
  gettextize: git-add "Unstaged changes" message
  gettextize: git-branch basic messages
  gettextize: git-branch "remote branch '%s' not found" message
  gettextize: git-branch "Deleted branch [...]" message
  gettextize: git-branch "git branch -v" messages
  gettextize: git-branch "(no branch)" message
  gettextize: git-checkout basic messages
  gettextize: git-checkout: our/their version message
  gettextize: git-checkout describe_detached_head messages
  gettextize: git-checkout "HEAD is now at" message
  gettextize: git-checkout "Switched to a .. branch" message
  gettextize: git-commit basic messages
  gettextize: git-commit "middle of a merge" message
  gettextize: git-commit formatting messages
  gettextize: git-commit print_summary messages
  gettextize: git-commit "enter the commit message" message
  gettextize: git-commit advice messages
  gettextize: git-diff basic messages
  gettextize: git-fetch basic messages
  gettextize: git-fetch formatting messages
  gettextize: git-fetch update_local_ref messages
  gettextize: git-fetch split up "(non-fast-forward)" message
  gettextize: git-grep basic messages
  gettextize: git-grep "--open-files-in-pager" message
  gettextize: git-log basic messages
  gettextize: git-log "--OPT does not make sense" messages
  gettextize: git-merge basic messages
  gettextize: git-merge "Updating %s..%s" message
  gettextize: git-merge "You have not concluded your merge" messages
  gettextize: git-merge "Wonderful" message
  gettextize: git-mv basic messages
  gettextize: git-mv "bad" messages
  gettextize: git-rm basic messages
  gettextize: git-reset basic messages
  gettextize: git-reset reset_type_names messages
  gettextize: git-reset "Unstaged changes after reset" message
  gettextize: git-tag basic messages
  gettextize: git-tag tag_template message
  gettextize: git-push basic messages
  gettextize: git-push "prevent you from losing" message
  gettextize: git-status basic messages
  gettextize: git-status "nothing to commit" messages
  gettextize: git-status shortstatus messages
  gettextize: git-status "Changes to be committed" message
  gettextize: git-status "Initial commit" message
  gettextize: git-status "renamed: " message
  gettextize: git-archive basic messages
  gettextize: git-bundle basic messages
  gettextize: git-clean basic messages
  gettextize: git-clean clean.requireForce messages
  gettextize: git-describe basic messages
  gettextize: git-gc basic messages
  gettextize: git-gc "Auto packing the repository" message
  gettextize: git-notes basic commands
  gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
  gettextize: git-revert basic messages
  gettextize: git-revert "Your local changes" message
  gettextize: git-revert literal "me" messages
  gettextize: git-revert split up "could not revert/apply" message
  gettextize: git-shortlog basic messages

 Makefile                         |   27 ++++++
 builtin/add.c                    |   50 ++++++------
 builtin/archive.c                |   14 ++--
 builtin/branch.c                 |   69 ++++++++--------
 builtin/bundle.c                 |    6 +-
 builtin/checkout.c               |   93 +++++++++++-----------
 builtin/clean.c                  |   33 +++++---
 builtin/clone.c                  |   63 ++++++++-------
 builtin/commit.c                 |  162 +++++++++++++++++++-----------=
--------
 builtin/describe.c               |   36 ++++----
 builtin/diff.c                   |   18 ++--
 builtin/fetch.c                  |   82 ++++++++++----------
 builtin/gc.c                     |   24 +++---
 builtin/grep.c                   |   34 ++++----
 builtin/init-db.c                |   58 ++++++++------
 builtin/log.c                    |   68 ++++++++--------
 builtin/merge.c                  |  128 +++++++++++++++---------------
 builtin/mv.c                     |   32 ++++----
 builtin/notes.c                  |  112 +++++++++++++-------------
 builtin/push.c                   |   42 +++++-----
 builtin/reset.c                  |   42 +++++-----
 builtin/revert.c                 |   76 ++++++++++--------
 builtin/rm.c                     |   22 +++---
 builtin/shortlog.c               |    8 +-
 builtin/tag.c                    |   66 ++++++++--------
 cache.h                          |    1 +
 gettext.c                        |   14 +++
 gettext.h                        |   32 ++++++++
 po/.gitignore                    |    1 +
 t/lib-httpd.sh                   |    2 +-
 t/t0001-init.sh                  |    2 +-
 t/t1200-tutorial.sh              |    5 +-
 t/t2200-add-update.sh            |    2 +-
 t/t2204-add-ignored.sh           |   37 ++++++---
 t/t3030-merge-recursive.sh       |    2 +-
 t/t3200-branch.sh                |    2 +-
 t/t3203-branch-output.sh         |    2 +-
 t/t3501-revert-cherry-pick.sh    |    2 +-
 t/t3507-cherry-pick-conflict.sh  |    2 +-
 t/t3700-add.sh                   |   13 +++-
 t/t4001-diff-rename.sh           |    4 +-
 t/t4014-format-patch.sh          |    2 +-
 t/t5526-fetch-submodules.sh      |   40 ++++++++--
 t/t5541-http-push.sh             |    7 +-
 t/t5601-clone.sh                 |    2 +-
 t/t6040-tracking-info.sh         |    2 +-
 t/t6120-describe.sh              |    2 +-
 t/t7004-tag.sh                   |    1 +
 t/t7012-skip-worktree-writing.sh |    4 +-
 t/t7060-wtstatus.sh              |    2 +-
 t/t7102-reset.sh                 |    2 +-
 t/t7110-reset-merge.sh           |    6 +-
 t/t7201-co.sh                    |   10 +-
 t/t7300-clean.sh                 |    6 +-
 t/t7500-commit.sh                |    8 +-
 t/t7501-commit.sh                |    7 +-
 t/t7502-commit.sh                |   60 +++++++++------
 t/t7506-status-submodule.sh      |   28 +++---
 t/t7508-status.sh                |  115 +++++++++++++++------------
 t/t7600-merge.sh                 |    2 +-
 t/t7607-merge-overwrite.sh       |   10 ++-
 t/t7611-merge-abort.sh           |   20 ++++-
 t/t7811-grep-open.sh             |    2 +-
 t/test-lib.sh                    |    9 ++
 wt-status.c                      |  116 ++++++++++++++--------------
 65 files changed, 1084 insertions(+), 867 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 po/.gitignore

--=20
1.7.2.3
