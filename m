From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/26] worktree lock, move, remove and unlock
Date: Tue, 16 Feb 2016 20:29:01 +0700
Message-ID: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:29:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfgr-00022B-23
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbcBPN3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:29:13 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33385 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcBPN3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:29:11 -0500
Received: by mail-pa0-f48.google.com with SMTP id fl4so91701443pad.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dZBbKo9znFMhJfUdXtYE/5+KUzW3tGpmMB4CwcmU2s4=;
        b=wSOtvjrnNRmVOmaWb0knszghH9ZgqrHsP7YdYjPRRHm8qO0vsBsUBWAwYt+JRhSule
         EFt4alRj0dXoxWqrPWjWQablBL66IkoWlrpNuW+ye6j6tpZWmfKMSc4ItyaPQS8LQz8/
         JMY+viSGi45NDFC/aQ1vuQ2R2Z2CKFGaOeaNVlfH9N7WmII7kT/adpaTroYjvyHGqBcn
         Y5hw4YCHHwB0pfbVAf3uEmbAwIU98qjyBFX8AuH0a5ksyrWqVQUyiX3jgW7eYy2dl1lO
         0ynSQkE7NhdUvBn3gg6z/6Rb+renO8h9ee5872aKIDmGyPVEONxsId9w3Lxd9RqVzz8K
         rnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dZBbKo9znFMhJfUdXtYE/5+KUzW3tGpmMB4CwcmU2s4=;
        b=TU9kOVNuL2h28uuwFBAB6NodHY3FfCYQ+cQPQGOj6QcoIKu6wawp4d9EGvWq+t+TBe
         rJ+Cx9dEfLcEybxyiUr7fVlDt2Ll2F4qPCnzkgFI1Pc9+IUocg11pxeI/dUpxsIHV6JV
         H05511wJEa+671/+CPzAl1yjKG6/yKYgVtRXavi4838os9qsuyj3yh0mUvi+fEQXxdme
         /mv465cTyATbXzQSaUWl5C8PxojcXGDsHDtpT/l+934qgb0qr7JiClKelOkwriJy7Ftk
         sEm56KfZMIxVLF/0cjAjRqcMrpWi7iUdm9o2bPpqK+WgklKSeuwjhQYHjzcuDX3HVP7d
         UUAg==
X-Gm-Message-State: AG10YOT7zPzqBDUc8mCYhwRJE+zk5K1B3cuMRYRz/3ltq55Vil+dXHScMpTm1cDcqamG+A==
X-Received: by 10.66.102.70 with SMTP id fm6mr30654698pab.98.1455629351416;
        Tue, 16 Feb 2016 05:29:11 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id i23sm45964787pfj.68.2016.02.16.05.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:29:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:29:34 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286360>

I think this is good enough to be further polished and maybe released.
The series adds four new commands and bash completion for git-worktree.

Remaining work to do on git-worktree:

 - "git worktree move --repository", in v1 but left out in v2 because
   it's trickier.

 - .git/config issue and submodule support

A bit off topic, I've been using this script to add "cw" command, to
chdir to another worktree with tab-completion. It works wonderfully,
but I'm not sure if it can ever be merged to git-completion.bash.

-- 8< --
cw() {
    cd "$(git worktree list --porcelain | grep -B2 refs/heads/$1 | head=
 -n1 | cut -f 2 -d ' ')"
}

_git_cw() {
	local cur words cword prev
	_get_comp_words_by_ref -n =3D: cur words cword prev

    	local list=3D"$(git worktree list --porcelain | grep '^branch refs=
/heads/' | cut -c 19-)"
	__gitcomp "$list"
}

complete -o bashdefault -o default -o nospace -F _git_cw cw 2>/dev/null=
 || \
    complete -o default -o nospace -F _git_cw cw
-- 8< --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (26):
  usage.c: move format processing out of die_errno()
  usage.c: add sys_error() that prints strerror() automatically
  copy.c: import copy_file() from busybox
  copy.c: delete unused code in copy_file()
  copy.c: convert bb_(p)error_msg to (sys_)error
  copy.c: style fix
  copy.c: convert copy_file() to copy_dir_recursively()
  completion: support git-worktree
  git-worktree.txt: keep subcommand listing in alphabetical order
  wrapper.c: allow to create an empty file with write_file()
  path.c: add git_common_path() and strbuf_git_common_path()
  worktree.c: use is_dot_or_dotdot()
  worktree.c: store "id" instead of "git_dir"
  worktree.c: add clear_worktree()
  worktree.c: add find_worktree_by_path()
  worktree.c: add is_main_worktree()
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree.c: add is_worktree_locked()
  worktree: avoid 0{40}, too many zeroes, hard to read
  worktree: simplify prefixing paths
  worktree: add "lock" command
  worktree: add "unlock" command
  worktree: add "move" commmand
  worktree move: accept destination as directory
  worktree: add "remove" command

 Documentation/git-worktree.txt         |  55 +++--
 builtin/worktree.c                     | 240 ++++++++++++++++++++-
 cache.h                                |   4 +
 contrib/completion/git-completion.bash |  29 +++
 copy.c                                 | 369 +++++++++++++++++++++++++=
++++++++
 git-compat-util.h                      |   1 +
 path.c                                 |  29 +++
 t/t2028-worktree-move.sh (new +x)      | 103 +++++++++
 usage.c                                |  35 +++-
 worktree.c                             | 171 +++++++++++++--
 worktree.h                             |  40 +++-
 wrapper.c                              |   2 +-
 12 files changed, 1029 insertions(+), 49 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

--=20
2.7.0.377.g4cd97dd
