From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/workdir/git-new-workdir broken in 1.7.10 after introducing gitfiles
Date: Sat, 21 Apr 2012 21:41:23 -0700
Message-ID: <xmqqy5poxtsc.fsf@junio.mtv.corp.google.com>
References: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com>
	<4F930043.1080506@web.de> <xmqq397wzwwd.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antonin Hildebrand <antonin@hildebrand.cz>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 22 06:42:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLocd-0000wf-So
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 06:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab2DVEl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 00:41:26 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:35230 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2DVEl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 00:41:26 -0400
Received: by bkcjk7 with SMTP id jk7so11925bkc.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 21:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=NFfxRfiLZ9YiizxhpMBT9bc3PG3Y85YOiGmH1eP+VkU=;
        b=Pq27RJi9Pn4G6U7FE2CpOfN2xsU1cB3358auNnfcpf2P3JLx7QyUNNtHjRXCA8wBu/
         K4oQlZXDZvs+NF2QiLMxNEZxNBVvhls74qvZdQLeoXd2KWZwTK+gCmg0YrH55uxCexXt
         0RmCL8jxBPZDjO0x+fSaz3ihxjPmWrrGY1F7qmcYE2Eo7aJjnya5Ca+hHYYv0o9W1+v9
         /p9QsC/vuw6p6+E+qc95PUzgnbezk0lQWdNAsEXVRixfNkwL2ZIjSpOHe2fsDACiwzKm
         vqAmMX+04f5ulaD+qrusiZdYRfeZ3cJgvbHPzDc2xQvzGlFTq64pi/yJM06wd/yyaPLl
         9/rw==
Received: by 10.14.127.10 with SMTP id c10mr2992830eei.2.1335069684591;
        Sat, 21 Apr 2012 21:41:24 -0700 (PDT)
Received: by 10.14.127.10 with SMTP id c10mr2992814eei.2.1335069684475;
        Sat, 21 Apr 2012 21:41:24 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si10435757eef.2.2012.04.21.21.41.24
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sat, 21 Apr 2012 21:41:24 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 4A74420004E;
	Sat, 21 Apr 2012 21:41:24 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 9B9A0E120A; Sat, 21 Apr 2012 21:41:23 -0700 (PDT)
In-Reply-To: <xmqq397wzwwd.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 21 Apr 2012 12:51:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlS817xSvw3xSVetpJ/SINoPsO5fCwXWWCPCEVNB4+mzl1ENKEcm81E8obqul3/qSiDmStXhpoUqChQEkcuIS6LgmDuRS4cGCf5a5pRM2Du0N6yhmIzf/hvObnnH8a7XNMFAk10wfGW6O4UoyBUcnms0Fhv8rmSAJQsKFP3yFPA5vhvp3c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196073>

Junio C Hamano <gitster@pobox.com> writes:

> As you analyzed correctly, core.worktree lets a GIT_DIR to declare that
> there is a single working tree associated with it. It fundamentally is
> incompatible with new-workdir, which is a hack to let more than one
> working tree associated with a single GIT_DIR.
>
> I however do not think a simplistic "unset core.worktree" is a good
> suggestion, though, as we do not know why the original repository has
> that variable set pointing at somewhere.  Blindly removing it will break
> the use of the original repository.  If somebody _really_ wants to use
> new-workdir for whatever reason in such a setting, I would imagine that
> doing something like this:
> ...
> may work.

I am too lazy to try it out myself, but a hack something along the line
of the attached patch _might_ turn out to work well.

At least, it gives an incentive to people to update to more recent
versions of git ;-)  I dunno.

-- >8 --
Subject: new-workdir: use its own config file

Instead of letting a new workdir share the same config, we simply
include the original config and override core.worktree in it.  This
obviously changes the behaviour from the traditional workdir, by making
any update to the config in a workdir private to that workdir and not
reflected back to the original repository.  Because a workdir is
supposed to be just a peek only window to check out a branch that is
different from the main working tree, and you are not expected to modify
the config file in any way (e.g. you do not create a new branch with
remote configuration in a workdir), it may not be a huge issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/workdir/git-new-workdir |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..1d49258 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -63,7 +63,7 @@ mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
 # create the links to the original repo.  explicitly exclude index, HEAD and
 # logs/HEAD from the list since they are purely related to the current working
 # directory, and should not be shared.
-for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
+for x in refs logs/refs objects info hooks packed-refs remotes rr-cache svn
 do
 	case $x in
 	*/*)
@@ -77,6 +77,12 @@ done
 cd "$new_workdir"
 # copy the HEAD from the original repository as a default branch
 cp "$git_dir/HEAD" .git/HEAD
+cat >".git/config" <<EOF
+[include]
+	path = "$git_dir/config"
+[core]
+	worktree = "$(pwd)"
+EOF
 # checkout the branch (either the same as HEAD from the original repository, or
 # the one that was asked for)
 git checkout -f $branch
