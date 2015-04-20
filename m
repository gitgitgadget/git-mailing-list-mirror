From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v4] git-p4: Use -m when running p4 changes
Date: Mon, 20 Apr 2015 16:15:08 +0100
Message-ID: <CAE5ih79BLm1LbZersZeOxShq=W4X5xaPHE1cDwctA5cJOSLRJA@mail.gmail.com>
References: <CALM2SnY4GZDSYOjLmDqdq9SgGGywRO2A3XU3639E_0JAh-2P5A@mail.gmail.com>
	<1429542020-11121-1-git-send-email-lex@lexspoon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 17:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkDPm-00050k-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 17:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbbDTPPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 11:15:10 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35382 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbDTPPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 11:15:09 -0400
Received: by obcux3 with SMTP id ux3so16742764obc.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2FuEDOyTvaX07wgjmSGW2UakuRNukeoO3sdcYrY9pOM=;
        b=jvpZa66Id6/IV0JI58/vveaGQJq1Uf8wjMNYYb+YoCJTdHXjK6xTIoPcuQOENhAHMO
         B9RAB/mQr/T9+cItd1GxN5iPF9jKw9KEokSjDoAZkd3No45GnQarNyeISCZS0QPW9o4J
         hKkzkK2zQ+cuu6TvB64n9wm4nzC7jERyA1hZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2FuEDOyTvaX07wgjmSGW2UakuRNukeoO3sdcYrY9pOM=;
        b=ZbpTwzobQjykse3VterH4/GxstWPvyq2J4Z7XUehUj+OjH+9eUtjw+kdHBWyjViajd
         4242vwYE4KE+UBYfZLe7FI0ZsVfEXASZHVg/beldYa0fe36y1s/IV68ykK/eBY95tLIA
         WqxITiy3TXkdQc/MwQCqQYLeM6LLoxYW3mdppChlyy6ufBs9ma0R4hsy0BdOO5gXpTWD
         lDuSz6/1EscCvWiWRWyEJ7rRcCxF5Y5xvcIo05AtiL7FeKvOrAYVcq6papeE9ccN/83p
         WgI7jKqau+vIWO0X5Tlh2isTE5hL0i4eIXJgV+SFd4rlDO1XTA1H55J4CcJjJYLOZn0F
         OG5A==
X-Gm-Message-State: ALoCoQnAwrlWmjn6Yffwuv05pjEFCN33N/vrTnHkBfc61YgVdWCylraqyZyf4VKIf8eWbqD76y0+
X-Received: by 10.202.198.149 with SMTP id w143mr14060274oif.72.1429542908265;
 Mon, 20 Apr 2015 08:15:08 -0700 (PDT)
Received: by 10.60.59.167 with HTTP; Mon, 20 Apr 2015 08:15:08 -0700 (PDT)
In-Reply-To: <1429542020-11121-1-git-send-email-lex@lexspoon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267470>

Sorry - could you resubmit your patch (PATCHv4 it will be) with this
change squashed in please? It will make life much easier, especially
for Junio!

Thanks!
Luke


On 20 April 2015 at 16:00, Lex Spoon <lex@lexspoon.org> wrote:
> Simply running "p4 changes" on a large branch can
> result in a "too many rows scanned" error from the
> Perforce server. It is better to use a sequence
> of smaller calls to "p4 changes", using the "-m"
> option to limit the size of each call.
>
> Signed-off-by: Lex Spoon <lex@lexspoon.org>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Luke Diamand <luke@diamand.org>
> ---
> Updated to avoid the crash Luke pointed out.
> All t98* tests pass now except for t9814,
> which is already failing on master for some reason.
>
>  Documentation/git-p4.txt | 17 ++++++++++---
>  git-p4.py                | 52 ++++++++++++++++++++++++++++++---------
>  t/t9818-git-p4-block.sh  | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+), 14 deletions(-)
>  create mode 100755 t/t9818-git-p4-block.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index a1664b9..82aa5d6 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -225,9 +225,20 @@ Git repository:
>         they can find the p4 branches in refs/heads.
>
>  --max-changes <n>::
> -       Limit the number of imported changes to 'n'.  Useful to
> -       limit the amount of history when using the '@all' p4 revision
> -       specifier.
> +       Import at most 'n' changes, rather than the entire range of
> +       changes included in the given revision specifier. A typical
> +       usage would be use '@all' as the revision specifier, but then
> +       to use '--max-changes 1000' to import only the last 1000
> +       revisions rather than the entire revision history.
> +
> +--changes-block-size <n>::
> +       The internal block size to use when converting a revision
> +       specifier such as '@all' into a list of specific change
> +       numbers. Instead of using a single call to 'p4 changes' to
> +       find the full list of changes for the conversion, there are a
> +       sequence of calls to 'p4 changes -m', each of which requests
> +       one block of changes of the given size. The default block size
> +       is 500, which should usually be suitable.
>
>  --keep-path::
>         The mapping of file names from the p4 depot path to Git, by
> diff --git a/git-p4.py b/git-p4.py
> index 549022e..e28033f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -740,17 +740,43 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
>  def originP4BranchesExist():
>          return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
>
> -def p4ChangesForPaths(depotPaths, changeRange):
> +def p4ChangesForPaths(depotPaths, changeRange, block_size):
>      assert depotPaths
> -    cmd = ['changes']
> -    for p in depotPaths:
> -        cmd += ["%s...%s" % (p, changeRange)]
> -    output = p4_read_pipe_lines(cmd)
> +    assert block_size
> +
> +    # Parse the change range into start and end
> +    if changeRange is None or changeRange == '':
> +        changeStart = '@1'
> +        changeEnd = '#head'
> +    else:
> +        parts = changeRange.split(',')
> +        assert len(parts) == 2
> +        changeStart = parts[0]
> +        changeEnd = parts[1]
>
> +    # Accumulate change numbers in a dictionary to avoid duplicates
>      changes = {}
> -    for line in output:
> -        changeNum = int(line.split(" ")[1])
> -        changes[changeNum] = True
> +
> +    for p in depotPaths:
> +        # Retrieve changes a block at a time, to prevent running
> +        # into a MaxScanRows error from the server.
> +        start = changeStart
> +        end = changeEnd
> +        get_another_block = True
> +        while get_another_block:
> +            new_changes = []
> +            cmd = ['changes']
> +            cmd += ['-m', str(block_size)]
> +            cmd += ["%s...%s,%s" % (p, start, end)]
> +            for line in p4_read_pipe_lines(cmd):
> +                changeNum = int(line.split(" ")[1])
> +                new_changes.append(changeNum)
> +                changes[changeNum] = True
> +            if len(new_changes) == block_size:
> +                get_another_block = True
> +                end = '@' + str(min(new_changes))
> +            else:
> +                get_another_block = False
>
>      changelist = changes.keys()
>      changelist.sort()
> @@ -1911,7 +1937,10 @@ class P4Sync(Command, P4UserMap):
>                  optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
>                  optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
>                                       help="Import into refs/heads/ , not refs/remotes"),
> -                optparse.make_option("--max-changes", dest="maxChanges"),
> +                optparse.make_option("--max-changes", dest="maxChanges",
> +                                     help="Maximum number of changes to import"),
> +                optparse.make_option("--changes-block-size", dest="changes_block_size", type="int",
> +                                     help="Internal block size to use when iteratively calling p4 changes"),
>                  optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
>                                       help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
>                  optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
> @@ -1940,6 +1969,7 @@ class P4Sync(Command, P4UserMap):
>          self.syncWithOrigin = True
>          self.importIntoRemotes = True
>          self.maxChanges = ""
> +        self.changes_block_size = 500
>          self.keepRepoPath = False
>          self.depotPaths = None
>          self.p4BranchesInGit = []
> @@ -2586,7 +2616,7 @@ class P4Sync(Command, P4UserMap):
>          branchPrefix = self.depotPaths[0] + branch + "/"
>          range = "@1,%s" % maxChange
>          #print "prefix" + branchPrefix
> -        changes = p4ChangesForPaths([branchPrefix], range)
> +        changes = p4ChangesForPaths([branchPrefix], range, self.changes_block_size)
>          if len(changes) <= 0:
>              return False
>          firstChange = changes[0]
> @@ -3002,7 +3032,7 @@ class P4Sync(Command, P4UserMap):
>                  if self.verbose:
>                      print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
>                                                                self.changeRange)
> -                changes = p4ChangesForPaths(self.depotPaths, self.changeRange)
> +                changes = p4ChangesForPaths(self.depotPaths, self.changeRange, self.changes_block_size)
>
>                  if len(self.maxChanges) > 0:
>                      changes = changes[:min(int(self.maxChanges), len(changes))]
> diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
> new file mode 100755
> index 0000000..153b20a
> --- /dev/null
> +++ b/t/t9818-git-p4-block.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description='git p4 fetching changes in multiple blocks'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'Create a repo with ~100 changes' '
> +       (
> +               cd "$cli" &&
> +               >file.txt &&
> +               p4 add file.txt &&
> +               p4 submit -d "Add file.txt" &&
> +               for i in $(test_seq 0 9)
> +               do
> +                       >outer$i.txt &&
> +                       p4 add outer$i.txt &&
> +                       p4 submit -d "Adding outer$i.txt" &&
> +                       for j in $(test_seq 0 9)
> +                       do
> +                               p4 edit file.txt &&
> +                               echo $i$j >file.txt &&
> +                               p4 submit -d "Commit $i$j" || exit
> +                       done || exit
> +               done
> +       )
> +'
> +
> +test_expect_success 'Clone the repo' '
> +       git p4 clone --dest="$git" --changes-block-size=10 --verbose //depot@all
> +'
> +
> +test_expect_success 'All files are present' '
> +       echo file.txt >expected &&
> +       test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt outer4.txt >>expected &&
> +       test_write_lines outer5.txt outer6.txt outer7.txt outer8.txt outer9.txt >>expected &&
> +       ls "$git" >current &&
> +       test_cmp expected current
> +'
> +
> +test_expect_success 'file.txt is correct' '
> +       echo 99 >expected &&
> +       test_cmp expected "$git/file.txt"
> +'
> +
> +test_expect_success 'Correct number of commits' '
> +       (cd "$git" && git log --oneline) >log &&
> +       test_line_count = 111 log
> +'
> +
> +test_expect_success 'Previous version of file.txt is correct' '
> +       (cd "$git" && git checkout HEAD^^) &&
> +       echo 97 >expected &&
> +       test_cmp expected "$git/file.txt"
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 1.9.1
>
