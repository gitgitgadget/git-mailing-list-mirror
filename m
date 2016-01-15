From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Add a test for subtree rebase that loses commits
Date: Thu, 14 Jan 2016 20:19:17 -0500
Message-ID: <CAPig+cQ6Dfvc4dkQVZ6BqzD76nZ4mCcqkO4eAecrMENKWtgWEg@mail.gmail.com>
References: <1451968805-6948-2-git-send-email-greened@obbligato.org>
	<1452467297-16868-1-git-send-email-greened@obbligato.org>
	<1452467297-16868-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:19:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJt2w-0006QR-VP
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 02:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbcAOBTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 20:19:19 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35239 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbcAOBTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 20:19:18 -0500
Received: by mail-qg0-f44.google.com with SMTP id o11so497706848qge.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 17:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sOR65Za/uysmKtm+aLg73Wpn+NJr+kVPfBZLlFdPlt4=;
        b=NLEY4UU1+6sNTCxXLd/xt6hEYjRcsXg8THBCw05Ih1rStLIkLt85BoNBLOxorar3TQ
         gDuEyuPGkl9RQ4/ghedTpxXoel7DCYELdxSxPYWNZy4h4W0+UulQquB0Wt2x5UQDOaO5
         pMrafvqCejkVqmVRnbFwQwH0WK6+pAyLdcww6l0wzqfSfNwL9s/Wf5dnJhkS439228Kl
         c8Gjs9OOo50RWkYTkKIAPzxjN9em3Bq+/YOEsTZeHzIxTV1Ujqma66ok5JzAkHp3Hb/o
         R5zEHjJOtVVzYm2leaBJ1q+h3O3uGGVQz6MuiyoHZcSdrrAKOEH+LC7mNYOOZBSZHbN7
         z05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sOR65Za/uysmKtm+aLg73Wpn+NJr+kVPfBZLlFdPlt4=;
        b=ha5XWBRf8xRJQDr5fUMdgdqVjwKYMXA93g+zl720HUOQoTEZLdxRh7w1rXy3PzqERy
         2Ysuyq7V+1gOZo0fKDDp+d65kWkC6cI8nZw5Id0ZqT7/etoHIujUmi5kYiP5dVWJWq9Y
         Kkh+7WkdhNS+1DWggnNw3e9zQxNz/mOwybhdZVnLeGoeTP52Soo7hmZc9qDoTR4P8UNu
         1chFCMKHaRnJzI1MhSrX0PRmbiJFqp404D5YHSRRXzn2xal9Et3u+6wplpkjFUGZYfmr
         XGoZuaQNKV5wfzGfBMqtkTJiFvx4LxkEkqoeeFUGrVItqX1wAqDjQkgJiHi+lLxiPZFj
         0aEg==
X-Gm-Message-State: ALoCoQkq3W4S0jUQiZSepLGs9tp2e/NATP7icwuh4Gt/+BOEvpbpwML0mdNWbi5xcTBafxfsakg9pW2orINZG7bCSc8s/iPgZQ==
X-Received: by 10.140.148.81 with SMTP id 78mr10383921qhu.17.1452820757233;
 Thu, 14 Jan 2016 17:19:17 -0800 (PST)
Received: by 10.233.221.1 with HTTP; Thu, 14 Jan 2016 17:19:17 -0800 (PST)
In-Reply-To: <1452467297-16868-2-git-send-email-greened@obbligato.org>
X-Google-Sender-Auth: LPkd6e6QQ4H-jMvO-wZQgBHdFHo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284129>

On Sun, Jan 10, 2016 at 6:08 PM, David Greene <greened@obbligato.org> wrote:
> From: "David A. Greene" <greened@obbligato.org>
>
> This test merges an external tree in as a subtree, makes some commits
> on top of it and splits it back out.  In the process the added commits
> are lost or the rebase aborts with an internal error.  The tests are
> marked to expect failure so that we don't forget to fix it.

This version looks better. A few minor comments below (not necessarily
deserving a re-roll)...

> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +
> +test_description='git rebase tests for -Xsubtree
> +
> +This test runs git rebase and tests the subtree strategy.
> +'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +check_equal() {
> +       test_debug 'echo'
> +       test_debug "echo \"check a:\" \"{$1}\""
> +       test_debug "echo \"      b:\" \"{$2}\""
> +       test "$1" = "$2"
> +}

I'm still curious as to why check_equal() is preferred over
test-lib-functions.sh:verbose().

> +last_commit_message() {
> +       git log --pretty=format:%s -1
> +}
> +
> +test_expect_success 'setup' '
> +       test_commit README &&
> +       mkdir files &&
> +       (
> +               cd files &&
> +               git init &&
> +               test_commit master1 &&
> +               test_commit master2 &&
> +               test_commit master3
> +       ) &&
> +       test_debug "echo Add project master to master" &&

Are these test_debug invocations still useful now that the test has
been fully developed?

> +       git fetch files master &&
> +       git branch files-master FETCH_HEAD &&
> +       test_debug "echo Add subtree master to master via subtree" &&
> +       git read-tree --prefix=files_subtree files-master &&
> +       git checkout -- files_subtree &&
> +       tree=$(git write-tree) &&
> +       head=$(git rev-parse HEAD) &&
> +       rev=$(git rev-parse --verify files-master^0) &&
> +       commit=$(git commit-tree -p $head -p $rev -m "Add subproject master" $tree) &&
> +       git reset $commit &&
> +       (
> +               cd files_subtree &&
> +               test_commit master4
> +       ) &&
> +       test_commit files_subtree/master5
> +'
> +
> +# Does not preserve master4 and master5.

This comment is explaining why the test is marked "failure", right?
When someone gets around to fixing the breakage and toggling this to
"success", there is a reasonably good chance that the comment will be
overlooked and thus become stale. Perhaps prefixing the comment with a
bold "FAILURE:" would serve as a reminder that the comment should be
dropped when the problem is fixed?

> +test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto' '
> +       reset_rebase &&
> +       git checkout -b rebase-preserve-merges master &&
> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +       git commit -m "Empty commit" --allow-empty &&
> +       git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
> +       check_equal "$(last_commit_message)" "files_subtree/master5"
> +'
> +
> +# Does not preserve master4, master5 and empty.
> +test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto' '
> +       reset_rebase &&
> +       git checkout -b rebase-keep-empty master &&
> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +       git commit -m "Empty commit" --allow-empty &&
> +       git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
> +       check_equal "$(last_commit_message)" "Empty commit"
> +'
> +
> +# fatal: Could not parse object
> +test_expect_failure 'Rebase -Xsubtree --onto' '
> +       reset_rebase &&
> +       git checkout -b rebase-onto master &&
> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +       git commit -m "Empty commit" --allow-empty &&
> +       git rebase -Xsubtree=files_subtree --onto files-master master &&
> +       check_equal "$(last_commit_message)" "Empty commit"
> +'
> +
> +test_done
> --
> 2.6.1
