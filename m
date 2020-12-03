Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43933C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D429B22262
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgLCTxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 14:53:23 -0500
Received: from mail.javad.com ([54.86.164.124]:53950 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCTxX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 14:53:23 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2A9503E96D;
        Thu,  3 Dec 2020 19:52:42 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkuee-0003zZ-Ie; Thu, 03 Dec 2020 22:52:40 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 27/27] doc/git-show: include --diff-merges description
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-28-sorganov@gmail.com>
        <CABPp-BG_YT2i_27tqkh_e4mwfkYae-zDCEYL=F+NjYQed2gKAg@mail.gmail.com>
Date:   Thu, 03 Dec 2020 22:52:40 +0300
In-Reply-To: <CABPp-BG_YT2i_27tqkh_e4mwfkYae-zDCEYL=F+NjYQed2gKAg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 3 Dec 2020 08:47:35 -0800")
Message-ID: <87wnxyfz07.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> Hi,
>
> On Sun, Nov 8, 2020 at 1:44 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Move description of --diff-merges option from git-log.txt to
>> diff-options.txt so that it is included in the git-show help.
>>
>> While we are at it, make git-show closer to git-log in this area by
>> providing similar wording in the introduction of diff options.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/diff-options.txt | 54 ++++++++++++++++++++++++++++++++++
>>  Documentation/git-log.txt      | 52 --------------------------------
>>  Documentation/git-show.txt     |  8 +++--
>>  3 files changed, 60 insertions(+), 54 deletions(-)
>>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 573fb9bb71e2..f1629887103e 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -33,6 +33,60 @@ endif::git-diff[]
>>         show the patch by default, or to cancel the effect of `--patch`.
>>  endif::git-format-patch[]
>>
>> +ifdef::git-log[]
>> +Note that unless one of `--diff-merges` variants (including short
>> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
>> +will not show a diff, even if a diff format like `--patch` is
>> +selected, nor will they match search options like `-S`. The exception
>> +is when `--first-parent` is in use, in which case
>> +`--diff-merges=first-parent` is implied.
>
> So, now diff-options says that no diffs are the defaults for merge commits...
>
>> +
>> +--diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
>> +--no-diff-merges::
>> +       Specify diff format to be used for merge commits. This has no
>> +       effect unless diff output is enabled in the first place (e.g.,
>> +       with `--patch` option.)
>> ++
>> +--diff-merges=(off|none):::
>> +--no-diff-merges:::
>> +       (default) Disable output of diffs for merge commits. Useful to
>> +       override implied value.
>> ++
>> +--diff-merges=first-parent:::
>> +       This option makes merge commits show the full diff with
>> +       respect to the first parent only, exactly like  regular
>> +       commits.
>> ++
>> +--diff-merges=separate:::
>> +-m:::
>> +       This makes merge commits show the full diff with respect to
>> +       each of the parents. Separate log entry and diff is generated
>> +       for each parent.
>> ++
>> +--diff-merges=combined:::
>> +-c:::
>> +       With this option, diff output for a merge commit shows the
>> +       differences from each of the parents to the merge result
>> +       simultaneously instead of showing pairwise diff between a
>> +       parent and the result one at a time. Furthermore, it lists
>> +       only files which were modified from all parents.
>> ++
>> +--diff-merges=dense-combined:::
>> +--cc:::
>> +       With this option the output produced by
>> +       `--diff-merges=combined` is further compressed by omitting
>> +       uninteresting hunks whose contents in the parents have only
>> +       two variants and the merge result picks one of them without
>> +       modification.
>> +
>> +--combined-all-paths::
>> +       This flag causes combined diffs (used for merge commits) to
>> +       list the name of the file from all parents.  It thus only has
>> +       effect when `--diff-merges=[dense-]combined` is in use, and
>> +       is likely only useful if filename changes are detected (i.e.
>> +       when either rename or copy detection have been requested).
>> +endif::git-log[]
>> +
>>  -U<n>::
>>  --unified=<n>::
>>         Generate diffs with <n> lines of context instead of
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index de498a189646..0cacc780bf30 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -120,58 +120,6 @@ DIFF FORMATTING
>>  By default, `git log` does not generate any diff output. The options
>>  below can be used to show the changes made by each commit.
>>
>> -Note that unless one of `--diff-merges` variants (including short
>> -`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
>> -will not show a diff, even if a diff format like `--patch` is
>> -selected, nor will they match search options like `-S`. The exception
>> -is when `--first-parent` is in use, in which case
>> -`--diff-merges=first-parent` is implied.
>> -
>> ---diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
>> ---no-diff-merges::
>> -       Specify diff format to be used for merge commits. This has no
>> -       effect unless diff output is enabled in the first place (e.g.,
>> -       with `--patch` option.)
>> -+
>> ---diff-merges=(off|none):::
>> ---no-diff-merges:::
>> -       (default) Disable output of diffs for merge commits. Useful to
>> -       override implied value.
>> -+
>> ---diff-merges=first-parent:::
>> -       This option makes merge commits show the full diff with
>> -       respect to the first parent only, exactly like  regular
>> -       commits.
>> -+
>> ---diff-merges=separate:::
>> --m:::
>> -       This makes merge commits show the full diff with respect to
>> -       each of the parents. Separate log entry and diff is generated
>> -       for each parent.
>> -+
>> ---diff-merges=combined:::
>> --c:::
>> -       With this option, diff output for a merge commit shows the
>> -       differences from each of the parents to the merge result
>> -       simultaneously instead of showing pairwise diff between a
>> -       parent and the result one at a time. Furthermore, it lists
>> -       only files which were modified from all parents.
>> -+
>> ---diff-merges=dense-combined:::
>> ---cc:::
>> -       With this option the output produced by
>> -       `--diff-merges=combined` is further compressed by omitting
>> -       uninteresting hunks whose contents in the parents have only
>> -       two variants and the merge result picks one of them without
>> -       modification.
>> -
>> ---combined-all-paths::
>> -       This flag causes combined diffs (used for merge commits) to
>> -       list the name of the file from all parents.  It thus only has
>> -       effect when `--diff-merges=[dense-]combined` is in use, and
>> -       is likely only useful if filename changes are detected (i.e.
>> -       when either rename or copy detection have been requested).
>> -
>>
>>  :git-log: 1
>>  include::diff-options.txt[]
>> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
>> index fcf528c1b30d..abe58ce5d3a8 100644
>> --- a/Documentation/git-show.txt
>> +++ b/Documentation/git-show.txt
>> @@ -45,8 +45,12 @@ include::pretty-options.txt[]
>>  include::pretty-formats.txt[]
>>
>>
>> -COMMON DIFF OPTIONS
>> --------------------
>> +DIFF FORMATTING
>> +---------------
>> +
>> +By default, `git show` does not generate any diff output. The options
>> +below can be used to show the changes made by each commit.
>> +
>
> This is not right, `git show` generates diff output by default for
> both normal commits and merge commits -- it defaults to -p --cc (see
> show_setup_revisions_tweak() of builtin/log.c).  Also see earlier in
> git-show.txt where it says
>
>        For commits it shows the log message and textual diff. It also presents
>        the merge commit in a special format as produced by git diff-tree --cc.
>
>>  :git-log: 1
>>  include::diff-options.txt[]
>
> ...and the included text will contain the repeated claim that no diffs
> are shown by default for merge commits, which is true for `git log`
> but not `git show`.

Yes, I need to re-consider this, as I already admitted in my reply to
your previous catch of the related problem in the documentation.

They all came from single point of misunderstanding.

Will try to get it right in the next re-roll.

Thanks,
-- Sergey Organov
