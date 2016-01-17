From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 contrib/subtree 1/1] Add a test for subtree rebase that
 loses commits
Date: Sun, 17 Jan 2016 18:32:44 -0500
Message-ID: <CAPig+cTMAnbyT3-FFN4juUooosiydOCX-ETwTghpnKoOeXcMpQ@mail.gmail.com>
References: <CAPig+cQ6Dfvc4dkQVZ6BqzD76nZ4mCcqkO4eAecrMENKWtgWEg@mail.gmail.com>
	<ec1decfc5fd463f1e78a5aa2636c24fb11e80a62.1453072387.git.greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 00:32:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKwoU-0007Vq-5U
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 00:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbcAQXcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 18:32:47 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34421 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbcAQXcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 18:32:45 -0500
Received: by mail-vk0-f68.google.com with SMTP id a123so12055720vkh.1
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 15:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6HJvXGGg0BJsQeR4QQVxKlMk5dIaYf1J8zYsDJFcyG8=;
        b=UkUQPPKv2ayCFzHXA4fDJ2DVEOsEBRnVigtcK1Fb//8y6FTypCSPJgpO7w9tdPmRUc
         sP1rhAcWSVCBJ/jRJhWQbnambbgNdhrTmjYf+Jul7cZCkR26WIm7gACuGWj3YF8slmCW
         XJqjhmN2E+bFBLevfclkGS/BxN2N5QrFB+AlFchp/vrpXquyc49VubpAn6URNQ0wMXsh
         O+tFO91OFzq12Uzx5QVAMw6iUuBSfyeWvNjnbJ2VnXJC2pJ0US8dLLaiOJGW8WdaBPGy
         rn8u2FtIJcP5M9rfwZLdfN64VAbsWw3zDnpSD8ZC/41N1xhEWQUcl5XBnmhjqIjwntM6
         1WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6HJvXGGg0BJsQeR4QQVxKlMk5dIaYf1J8zYsDJFcyG8=;
        b=JaeIsOxV3VO5yjXy2uYSpnqU5VX0c/NfrVWphs1ZX0t9eSNN3vywDOZJF6vcI8d74M
         QZ75kVQhcLQQlHrOjsu+A33amTQbaL9sauZuPezttiOjjiLZYdfK3KF3wlVh8IFtOFc5
         R7xp74UFLbgFrjY7Ld/gx6NTpRWvgfcwbueHHVJwarEXrhdikvNprfikVsW+fY6Qg+ff
         8QUyvI226NttnsIYWxKV9vP8cdSUzcHSYm3DITeqhT2pfrGQyYN+XVCvY4ZhkGnkQ5AV
         B2MgMc9FIgrXjIgLySstmq5/gsyvHVwBVI/ZArVGwK8VRIRHBN1YkuQ0sIHCwIAmUalK
         +1Cw==
X-Gm-Message-State: ALoCoQlgwfGcRjSlMc9rAOSiWqEkkc1180/nEsiN4VwgDW286K5UyFEQhL4e0+ACn88Q8gHphI5dpSkSxFEgfiLI40+6xo/WLQ==
X-Received: by 10.31.47.135 with SMTP id v129mr15072444vkv.115.1453073564782;
 Sun, 17 Jan 2016 15:32:44 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 17 Jan 2016 15:32:44 -0800 (PST)
In-Reply-To: <ec1decfc5fd463f1e78a5aa2636c24fb11e80a62.1453072387.git.greened@obbligato.org>
X-Google-Sender-Auth: o2Ed3RLFH932uIT1LvyjG0QX4dw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284274>

On Sun, Jan 17, 2016 at 6:13 PM, David Greene <greened@obbligato.org> wrote:
> From: David A. Greene <greened@obbligato.org>
>
> This test merges an external tree in as a subtree, makes some commits
> on top of it and splits it back out.  In the process the added commits
> are lost or the rebase aborts with an internal error.  The tests are
> marked to expect failure so that we don't forget to fix it.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>
> Notes:
>     Change History:
>
>     v1 - Initial version
>     v2 - Additional tests and code cleanup
>     v3 - Remove check_equal, mark comments on failure and remove
>          test_debug statements

Hmm, the v3 changes described here don't appear in this version. In
fact, v2 and v3 are identical.

>  t/t3427-rebase-subtree.sh | 79 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> new file mode 100755
> index 0000000..add3b79
> --- /dev/null
> +++ b/t/t3427-rebase-subtree.sh
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
> +
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
