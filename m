From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v2 1/2] pull --rebase: add --[no-]autostash flag
Date: Sun, 28 Feb 2016 15:21:55 +0530
Message-ID: <CA+DCAeTJ=cTJzVO4ttgMT-Penh1=eVZtPYDQhcF4a4zueYrCAA@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<xmqqk2lqeyzv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 10:52:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZy1J-0007ft-Ca
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 10:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973AbcB1Jv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 04:51:59 -0500
Received: from mail-qg0-f67.google.com ([209.85.192.67]:36664 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbcB1Jv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 04:51:56 -0500
Received: by mail-qg0-f67.google.com with SMTP id 14so8743347qgg.3
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nowxiZuM9zcZQyiH2yrFs7mk+DLcTPHUWzqiPv7DIu8=;
        b=k4Ty0AGv5oBDviN24leJm/jEmDHRhZSXh26MuB6ojiMyxIzxp+BeUaNrZejPD3GyoX
         p9QFrNB1cYmGR9br9cE50RgHPVA2rmQbskzngBFeDm+R7owDvcyqiN+jR01knOOhasXB
         XWmW+PxqZYzcXKle5VypbBH1vb5BnsfeapQf4cqp+lFWIYZ1AOCo1n5RS1Z+m1CSqUin
         fVypfdDuAb77ZT/z6zRWZgKKZMZBQWuUfTuyYIO7Kn8Pw+Ri+SoxwF4pxkynMHJFUKnG
         77JkBaaM1NNncZteMN35F8V8nNFL/MqgkqqmCxYpK9B3K50gK0nsBFwE2Xm3Wq3Lbe3i
         nwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nowxiZuM9zcZQyiH2yrFs7mk+DLcTPHUWzqiPv7DIu8=;
        b=G90mXDwi/mNbzPFJ8fjzZ4fCxfS88ZziNRVaWDDlUefChnRBp1YyWdj5kHGmsDA9Qn
         1fD0TpFFvQd6q1GFBiBWv0nnaR/Mg2HTpm3oCN68/uwY7CDLWgCY1yjlN/Cvv9oy7EkR
         i2/BODu/uWOMTw2maAoE8jGi0x3AjqOD6Wk5VzN2ZBdElQLXZmt3pO7Sdjeog4ykAuOD
         ppjsRXGR/J5HyoexsjnHC4qXS149ZRECER3Tm/E81foD5gKF0dJ1Czl78+dsyJDRk/NT
         uCEcLNNLYSIvDAkVzBhSci1UBYzj0hzBZ6RbtNCaWDl1fsGR1i7QTj5QHReISM9SAPvN
         RxYQ==
X-Gm-Message-State: AD7BkJK93wedwOfSPEdENd4IkjTn/CJ77NVyDK3USXZYhUYZWwHoUrHGCAwItv37Y6gZlooCR1QWNYAhwMeZ+Q==
X-Received: by 10.140.98.197 with SMTP id o63mr12671730qge.78.1456653115472;
 Sun, 28 Feb 2016 01:51:55 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Sun, 28 Feb 2016 01:51:55 -0800 (PST)
In-Reply-To: <xmqqk2lqeyzv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287761>

On Sun, Feb 28, 2016 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> git pull --rebase understands --[no-]autostash flag.
>>
>> This flag overrides config variable "rebase.autoStash"
>> if set (default is false).
>
> Is that a statement of a fact?  If so, is it true before this patch
> is applied, or after?
>
> Each project has local convention for log messages, and we do too.
> A long log message typically start by explaining how the world is,
> why that is not desirable, present a description of a possible world
> that is better, and then give commands to somebody who is updating
> the code telling him what to do to make that better world a reality
> (and optionally how).
>
> So perhaps (I am totally making this up; you need to fact check and
> adjust):
>
>     If you enable rebase.autoStash option in your repository, there
>     is no way to override it for "git pull --rebase" from the
>     command line.
>
>     Teach "git pull" a new "--[no-]autostash" option so that a
>     rebase.autoStash configuration can be overridden.  As "git
>     rebase" already knows "--[no-]autostash" option, it is just the
>     matter of passing one when we spawn the command as necessary.
>
> or something.  The first one gives the readers how the current world
> works, and why it is not ideal.  The proposed better world in this
> case is too simple--the first paragraph complained that "we cannot
> do X" and X is something reader would likely to agree is a good
> thing to do, so it can be left unsaid that a better world is one in
> which X can be done.
>
>> When calling "git pull --rebase" with "--autostash",
>> pull passes the "--autostash" option to rebase,
>> which then runs rebase on a dirty worktree.
>>
>> With "--no-autostash" option, the command will die
>> if the worktree is dirty, before calling rebase.
>
> These two paragraphs are too obvious and probably are better left
> unsaid.  Especially the latter--you are changing "pull" and do not
> control what "rebase" would do in the future.  It could be that a
> better rebase in the future may be able to do its job in a dirty
> worktree without doing an autostash.

OK. I will follow up with a better commit message.

>> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
>> ---
>>
>> Thanks to Paul and Matthieu for comments on previous round.
>> Changes:
>>       - --autostash flag added
>>       - OPT_COLOR_FLAG replaced by OPT_BOOL
>>       - Default value of opt_rebase changed
>>       - Few changes in code
>>       - Commit message improvements
>>       - Documentation added
>>       - Few tests removed as suggested by Paul
>>       - Added test for --autostash flag
>> All tests passed: https://travis-ci.org/mehul2029/git
>>
>>  builtin/pull.c          | 13 ++++++++-----
>>  t/t5520-pull.sh         | 19 +++++++++++++++++++
>>  t/t5521-pull-options.sh | 16 ++++++++++++++++
>>  3 files changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 10eff03..60b320e 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -85,6 +85,7 @@ static char *opt_squash;
>>  static char *opt_commit;
>>  static char *opt_edit;
>>  static char *opt_ff;
>> +static int opt_autostash = 0;
>
> Do not explicitly initialize a static to 0 (or NULL).
>
>>  static char *opt_verify_signatures;
>>  static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
>>  static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
>> @@ -146,6 +147,8 @@ static struct option pull_options[] = {
>>       OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
>>               N_("abort if fast-forward is not possible"),
>>               PARSE_OPT_NOARG | PARSE_OPT_NONEG),
>> +     OPT_BOOL(0,"autostash",&opt_autostash,
>> +             N_("automatically stash/stash pop before and after rebase")),
>>       OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>>               N_("verify that the named commit has a valid GPG signature"),
>>               PARSE_OPT_NOARG),
>> @@ -789,7 +792,8 @@ static int run_rebase(const unsigned char *curr_head,
>>       argv_array_pushv(&args, opt_strategy_opts.argv);
>>       if (opt_gpg_sign)
>>               argv_array_push(&args, opt_gpg_sign);
>> -
>> +     if(opt_autostash)
>
> Style: control keywords are followed by a single SP before the next '('.
>
>> +             argv_array_push(&args,"--autostash");
>
> Style: a single SP after a comma.
>
> How would --no-autostash defeat a configured rebase.autostash with this?
>
> By the way, how would this affect "git pull --autostash" that is run
> without "--rebase"?  If this is an option to "git pull", shouldn't
> the stashing done even when you are not doing a rebase but making a
> merge?

As "git rebase" takes "--[no-]autostash" as an option whereas "git
merge" does not,
hence "--[no-]autostash" option is only valid when "--rebase" option is used in
"git pull".

If user uses "git pull --[no-]autostash" then two possible things can be done:

           * Either "git pull" ignores "--[no-]autostash" and calls
underlying "git merge",
             as merge stashes the untracked files by itself. Thus
ignoring --no-autostash
             flag given by user.

           * Or "git pull" dies with the following error:

                    "--[no-]autostash is only valid when --rebase is used.
                     Example: git pull --rebase --[no-]autostash"

I suggest that the latter option should be used in this case as user should know
that stashing is performed by "git merge" anyway and "--no-autostash"
flag is not
a way to tell "git merge" to not to do stashing. Also this error will
fit perfectly with the
documentation of "--[no-]autostash" option given in the [PATCH v2 2/2].

Please suggest what are your views on this.

>>       argv_array_push(&args, "--onto");
>>       argv_array_push(&args, sha1_to_hex(merge_head));
>>
>> @@ -813,6 +817,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>       if (!getenv("GIT_REFLOG_ACTION"))
>>               set_reflog_message(argc, argv);
>>
>> +     git_config_get_bool("rebase.autostash",&opt_autostash);
>> +
>
> Why is this change even necessary?
>
>>       argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
>>
>>       parse_repo_refspecs(argc, argv, &repo, &refspecs);
>> @@ -835,13 +841,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>               hashclr(orig_head);
>>
>>       if (opt_rebase) {
>> -             int autostash = 0;
>> -
>>               if (is_null_sha1(orig_head) && !is_cache_unborn())
>>                       die(_("Updating an unborn branch with changes added to the index."));
>>
>> -             git_config_get_bool("rebase.autostash", &autostash);
>> -             if (!autostash)
>> +             if (!opt_autostash)
>>                       die_on_unclean_work_tree(prefix);
>
> I would have expected that
>
>  * a global opt_autostash is initialized to -1 (unspecified);
>
>  * opt_bool() would flip it to either 0 or 1 with --[no-]autostash;
>
>  * existing "rebase.autostash" configuration check inside "git pull"
>    code  gets removed;
>
>  * and the code that builds "git rebase" invocation command line
>    will do
>
>         if (opt_autostash < 0)
>                 ; /* do nothing */
>         else if (opt_autostash == 0)
>                 argv_array_push(&args, "--no-autostash");
>         else
>                 argv_array_push(&args, "--autostash");
>
> Then when "git pull --rebase" is run without "--[no-]autostash", the
> underlying "git rebase" would be run without that option, and does its
> usual thing, including reading rebase.autostash and deciding to do
> "git stash".  And when "git pull" is run with "--[no-]autostash",
> the underlying "git rebase" would be given the same option, and
> would do what it was told to do, ignoring rebase.autostash setting.
>
> So why does "git pull" still need to look at rebase.autostash
> configuration after this change?

I agree with your point that future rebase might be able to do it's job on
dirty working tree without  autostash option, so it's always better to
let rebase
check for dirty working tree and do the task of looking at rebase.autostash.

Thanks for a thorough review.

Cheers,
Mehul Jain
