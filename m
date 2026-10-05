Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A54BD7B6
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218283; cv=none; b=U7qfkLfZHllsyFgtF63dsqQlBqECtOH4lH+XRB6EJnE7H7qjlpia7wpnz0gxFVlWiLkfHEtDJwofuX22vA+jrcpKRAsHcLcckHHabsKo3Hg+h/x98/LgNC7fwFktZg+2eHjE7Lakj6fO4NFP99RD++OUDW34mLsRSTjHCjrwDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218283; c=relaxed/simple;
	bh=sl7yCxuEwh61yqdKQR0mIXH2aw6EZ19Yq1hvjxFnOk4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o55Oizqv7u8uW9rA7jprpxLjUQRpRmSHhQQwkDzTGGpvcYMbbR0tmMtrJZWN6IExqVJnJQHcyiFRgQrVFOdKJGoJRNOz+QThoVb3dx3AreMgQOAs/pK0v+ggXtMaqawFnHyQTxQMOffbHfGNu47S44JEZxhXz/Inxy8wAKNpBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5//9g4l; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5//9g4l"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so706772f8f.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218276; x=1791823076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajJ4Z3HDKvJcOQ/u+7Q+69DNEgdE9x8i3zLa5uc16AU=;
        b=N5//9g4lTwoL2T0+icl/NZrRX6ttK3dZJlKdpk8on/7sum1ZLxuU6X1UpOM4PGCK4S
         Sfa4+q3CpWkiPBNZ2ElnR40OBflYCI1ndTk4D9XlNDGa+Sj3f1miVpIO63ntDiTQtxaX
         skm04xZ/grjAWllqpIAqNY1kS/+cH3qJkSS0Opbl18MFNubS5HckoqLHWb1oIUSsYdmK
         eaoqwciW1wA0ga08P0JG4iK5Q8yRuJb8m0DqxJuinDUniDf6yjeBf+lVtRIsAviaDVa0
         4s0UE+Puaej8ISGL6hSZ7PYw4YYGrMBaddHXV3pdYzE92KJK93nuyQdMbqF5ZrIl0nV6
         K1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218276; x=1791823076;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ajJ4Z3HDKvJcOQ/u+7Q+69DNEgdE9x8i3zLa5uc16AU=;
        b=KBRiaQVtjq2i0UlFjX3M7ITeGXgTeJOsGcgHv/djVPWaDrhUvqxCt+wtLPk7nULS/G
         r1fZ+NEPOaBV/Y02BjR6GTU2e9fYXQpUaZ5ht0VTpHCKcs0o5ccPG2bPIo7ymyDzNCDE
         A1zPubfaOwXu42TUgvPlLOiWBdzt4haeIcZrdbHz0CSUy1AFu7PI+rW4NT89y0ujZ/lD
         8CohOy/rth1az6yZkWZIgyUsTxWk+QaIu+aX4cRjyvJCFR8OgloNNbzc0wtsk/HvMvEh
         nUbfCjz7OTiLy4e5R6nVQji+NiytKCH3uKm8gdLb3pf8G+koM6XdYG/pgTv9700LQnQI
         JTBg==
X-Gm-Message-State: AFuF++nKnnXQXzSxEW7ck+eeblQSfl8lVyLVcePSgtB4KHAzOqLWtsfc
	9Mb9DSqJHGg0oKK8BWmo5Hv2as6AXBCHpEqk9gy8SlGXt0y35pPpEqeK
X-Gm-Gg: AYBFou1Q/8GXK5L9N3OzGrE01+7U+RlBccjAQlWll/Plampg5K2aSz5lOYzV3cI6q9b
	uY3I8PrcqcZLw3AWGsoQMBiBLE1apxtcdCv5Ob+But7rYy57o/KpJdrRF051nWGhAJ8zj8dYJfl
	+TrbmrEfWoorfoOyBIFnEb9kyiVSkR3wWtdn3fDTssTSp1KqbgnJSk2LurU67nGoJsHvF8rmjAp
	4sdUEB3E76v7SHjctZpLN9jonArvbos0vghiieB+qZUmBfYNFGgSyrvaJ6YntcFyw7SkoE9uX6p
	mRnlJKNPR6TnqSgiKjPJE+JNRZtTmy4lt1ko3U+sP+cwQyjLjphiJaotJjrFbJBjKPcnEIh2C2j
	qFNaHW7to1+xzNNOulflMK/2g0qMjFneA5Jq0ScQbwfL1eFTnzSc7arLEFd9rsV40biidScgALD
	H9wfKV3QhmJrSX+H+gjJaThs7Kb89BbulKcSKszXuAxMlc4Hhe/htq8b21dJ0j2MREunmzgAjqX
	n718darXZddGsw9Tjj37flCaUddN9xkiptJY66f8xmgLqmYxR3E
X-Received: by 2002:a05:600c:4792:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1788fd1e8mr2561925e9.14.1791218275760;
        Mon, 05 Oct 2026 09:37:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db8f28sm1813915e9.15.2026.10.05.09.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 09:37:55 -0700 (PDT)
Message-ID: <632af360-5797-4794-82b7-02c7dd8f7bd4@gmail.com>
Date: Mon, 5 Oct 2026 17:37:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] stash: expose untracked modes in create
To: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <8453ebd1-77c1-4941-afbf-572f9e7b12c1@gmail.com>
 <CANUHOw201hr2LgHb1ThcadiH8Y5k3zUArnhtj8g8SRVrvMsN-g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANUHOw201hr2LgHb1ThcadiH8Y5k3zUArnhtj8g8SRVrvMsN-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kazumasa

On 01/10/2026 18:44, 重田一聖 wrote:
> Hi Phillip,
> 
> Thanks for the review.
> 
> Sorry, I got a little carried away and sent v2 before replying.
> 
>> This doesn't seem to match the code changes.
> 
> For the no-change case, plain "git stash create" already checks for
> tracked changes before calling do_create_stash(), and returns 0 with
> empty output when there is nothing to create.
> 
> For -u and -a, I think we should follow that existing "create" behavior
> as well, using check_changes() for the selected mode before calling
> do_create_stash(), and returning 0 when it finds nothing to create.

I'm not really sure why that call to check_changes_tracked_files() is 
there in create_stash() as do_create_stash() repeats the same check.
I've sent a couple of patches [1] to fix that.

 > I am also thinking of mapping do_create_stash()'s internal no-change
 > status of 1 to 0 in the unlikely case where the state changes between
 > these checks.

I think that is worth doing but it is not related to adding new options 
so should be a separate patch.
> That 1 is not STASH_APPLY_CONFLICT. Following 786fc390465f
> ("stash: reserve exit status 1 for conflicts"), I do not think it should
> escape as public exit status 1, and would map it to 0 instead.

I agree we should exit 0 in that case.
>> You should pass PARSE_OPT_STOP_AT_NON_OPTION to parse_options()
>> to prevent that.
> 
> I plan to use PARSE_OPT_STOP_AT_NON_OPTION as you suggested.

That's great

Thanks

Phillip

[1] 
https://lore.kernel.org/git/cover.1791218125.git.phillip.wood@dunelm.org.uk

> Thanks,
> 
> Kazumasa Shigeta
> 
> 
> On Tue, 29 Sep 2026 17:08:08 +0100, Phillip Wood
> <phillip.wood123@gmail.com> wrote:
>> Hi Kazumasa
>>
>> On 29/09/2026 08:42, Kazumasa Shigeta wrote:
>>> `git stash create` always passes zero for the include_untracked parameter
>>> of do_create_stash(), even though that helper already supports untracked
>>> and ignored files and stash push/save expose those modes as
>>> -u/--include-untracked and -a/--all.
>>>
>>> Teach create to accept the same options and pass the existing mode
>>> through. Unlike push/save, create continues to only create objects: it
>>> does not update refs/stash or modify the index or working tree.
>>>
>>> When the selected mode finds no changes, do_create_stash() returns 1.
>>> Translate that to success so create keeps its existing no-object, empty
>>> output behavior.
>>
>> This doesn't seem to match the code changes. The code that prints the
>> object id when the stash is successfully created is unchanged, as far as
>> I can see what this patch does is change the exit status for "git stash
>> create" when there are no changes to stash. Instead of exiting 1, it
>> exits 0 even though it does not create a stash. That does not seem like
>> a good idea.
>>
>>> Use normal parse-options semantics, so options may appear after message
>>> arguments. A message that begins with a dash can be disambiguated with
>>
>> As "git stash create" concatenates excess arguments to use as the stash
>> message we should not be permuting options. "git stash create handle new
>> -u flag" should continue to create a stash with the message "handle new
>> -u flag" - it should not start stashing untracked files. You should pass
>> PARSE_OPT_STOP_AT_NON_OPTION to parse_options() to prevent that.
>>
>>> I proposed adding both --include-untracked and --all to
>>> "git stash create" in 2014:
>>> <1403856479-37421-1-git-send-email-shigeta@kanamei.co.jp>
>>>
>>> I should also apologize for dropping that thread after receiving review.
>>> I did not follow up on the comments at the time. Thanks to those who
>>> reviewed it then.
>>
>> Better late than never! I think the idea is fine, but the implementation
>> could do with a couple of tweaks so it is as backward compatible as
>> possible.
>>
>> Thanks
>>
>> Phillip
>>
>>> Separately, in 2017, Thomas Gummerer added an internal -u path while
>>> refactoring stash_create in 9ca6326dff29 (stash: refactor stash_create).
>>> That change explicitly kept the user interface of "git stash create"
>>> unchanged.
>>>
>>> When "stash create" was later converted to the builtin C implementation
>>> in d4788af875cc (stash: convert create to builtin), the untracked-file
>>> handling was carried into the new implementation and remains there today.
>>>
>>> More recently, Shabbir Bhojani proposed exposing --include-untracked:
>>> <pull.1892.git.1774768580147.gitgitgadget@gmail.com>
>>>
>>> This patch exposes both existing untracked modes, --include-untracked and
>>> --all, to "git stash create".
>>>
>>> Documentation/git-stash.adoc | 18 ++++++----
>>> builtin/stash.c | 36 ++++++++++++++-----
>>> t/t3903-stash.sh | 70 ++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 109 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
>>> index fc6a9a0..32f0fd5 100644
>>> --- a/Documentation/git-stash.adoc
>>> +++ b/Documentation/git-stash.adoc
>>> @@ -21,7 +21,7 @@ git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | -
>>> git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>>> [-u | --include-untracked] [-a | --all] [<message>]
>>> git stash clear
>>> -git stash create [<message>]
>>> +git stash create [-u | --include-untracked] [-a | --all] [<message>]
>>> git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
>>> git stash export (--print | --to-ref <ref>) [<stash>...]
>>> git stash import <commit>
>>> @@ -138,10 +138,12 @@ with no conflicts.
>>> `drop [-q | --quiet] [<stash>]`::
>>> Remove a single stash entry from the list of stash entries.
>>>
>>> -`create`::
>>> +`create [-u | --include-untracked] [-a | --all]`::
>>> Create a stash entry (which is a regular commit object) and
>>> return its object name, without storing it anywhere in the ref
>>> - namespace.
>>> + namespace. The `--include-untracked` option includes untracked
>>> + files, while `--all` also includes ignored files, without modifying
>>> + the working tree.
>>> This is intended to be useful for scripts. It is probably not
>>> the command you want to use; see "push" above.
>>>
>>> @@ -167,10 +169,11 @@ OPTIONS
>>> -------
>>> `-a`::
>>> `--all`::
>>> - This option is only valid for `push` and `save` commands.
>>> + When used with the `push` and `save` commands, all ignored and
>>> + untracked files are also stashed and then cleaned up with `git clean`.
>>> +
>>> -All ignored and untracked files are also stashed and then cleaned
>>> -up with `git clean`.
>>> +When used with the `create` command, ignored and untracked files are included
>>> +in the stash entry without modifying the working tree.
>>>
>>> `-u`::
>>> `--include-untracked`::
>>> @@ -179,6 +182,9 @@ up with `git clean`.
>>> all untracked files are also stashed and then cleaned up with
>>> `git clean`.
>>> +
>>> +When used with the `create` command, untracked files are included in the
>>> +stash entry without modifying the working tree.
>>> ++
>>> When used with the `show` command, show the untracked files in the stash
>>> entry as part of the diff.
>>>
>>> diff --git a/builtin/stash.c b/builtin/stash.c
>>> index 7a98434..57a4750 100644
>>> --- a/builtin/stash.c
>>> +++ b/builtin/stash.c
>>> @@ -59,7 +59,7 @@
>>> N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
>>> " [-u | --include-untracked] [-a | --all] [<message>]")
>>> #define BUILTIN_STASH_CREATE_USAGE \
>>> - N_("git stash create [<message>]")
>>> + N_("git stash create [-u | --include-untracked] [-a | --all] [<message>]")
>>> #define BUILTIN_STASH_EXPORT_USAGE \
>>> N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
>>> #define BUILTIN_STASH_IMPORT_USAGE \
>>> @@ -119,6 +119,11 @@ static const char * const git_stash_clear_usage[] = {
>>> NULL
>>> };
>>>
>>> +static const char * const git_stash_create_usage[] = {
>>> + BUILTIN_STASH_CREATE_USAGE,
>>> + NULL
>>> +};
>>> +
>>> static const char * const git_stash_store_usage[] = {
>>> BUILTIN_STASH_STORE_USAGE,
>>> NULL
>>> @@ -1643,26 +1648,39 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>>> return ret;
>>> }
>>>
>>> -static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
>>> +static int create_stash(int argc, const char **argv, const char *prefix,
>>> struct repository *repo UNUSED)
>>> {
>>> - int ret;
>>> + int ret = 0;
>>> + int include_untracked = 0;
>>> + struct option options[] = {
>>> + OPT_BOOL('u', "include-untracked", &include_untracked,
>>> + N_("include untracked files in stash")),
>>> + OPT_SET_INT('a', "all", &include_untracked,
>>> + N_("include ignored files in stash"),
>>> + INCLUDE_ALL_FILES),
>>> + OPT_END()
>>> + };
>>> struct strbuf stash_msg_buf = STRBUF_INIT;
>>> struct stash_info info = STASH_INFO_INIT;
>>> struct pathspec ps;
>>>
>>> - /* Starting with argv[1], since argv[0] is "create" */
>>> - strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
>>> + argc = parse_options(argc, argv, prefix, options,
>>> + git_stash_create_usage, 0);
>>> + strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
>>>
>>> memset(&ps, 0, sizeof(ps));
>>> - if (!check_changes_tracked_files(&ps))
>>> - return 0;
>>> + if (!include_untracked && !check_changes_tracked_files(&ps))
>>> + goto done;
>>>
>>> - ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
>>> - NULL, 0);
>>> + ret = do_create_stash(&ps, &stash_msg_buf, include_untracked, 0, NULL,
>>> + 0, &info, NULL, 0);
>>> if (!ret)
>>> printf_ln("%s", oid_to_hex(&info.w_commit));
>>> + else if (ret == 1)
>>> + ret = 0;
>>>
>>> +done:
>>> free_stash_info(&info);
>>> strbuf_release(&stash_msg_buf);
>>> return ret;
>>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>>> index 7211586..fe34879 100755
>>> --- a/t/t3903-stash.sh
>>> +++ b/t/t3903-stash.sh
>>> @@ -640,6 +640,76 @@ test_expect_success 'stash create - no changes' '
>>> test_must_be_empty actual
>>> '
>>>
>>> +# --all observes every untracked and ignored path in the worktree. Use one
>>> +# isolated repository for these checks so unrelated test state is not captured.
>>> +test_expect_success 'stash create with untracked options' '
>>> + test_when_finished "rm -rf stash-create-options" &&
>>> + test_create_repo stash-create-options &&
>>> + (
>>> + cd stash-create-options &&
>>> + test_commit base tracked base &&
>>> + echo create-ignored >.gitignore &&
>>> + git add .gitignore &&
>>> + git commit -m ignore &&
>>> +
>>> + git stash create -u >.git/actual &&
>>> + test_must_be_empty .git/actual &&
>>> + git stash create -a >.git/actual &&
>>> + test_must_be_empty .git/actual &&
>>> +
>>> + echo untracked >create-untracked &&
>>> + git stash create "without untracked" >.git/actual &&
>>> + test_must_be_empty .git/actual &&
>>> + short=$(git stash create "create untracked" -u) &&
>>> + long=$(git stash create --include-untracked "create untracked") &&
>>> + test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
>>> + echo untracked >.git/expect &&
>>> + git show "$short^3:create-untracked" >.git/actual &&
>>> + test_cmp .git/expect .git/actual &&
>>> + branch=$(git symbolic-ref --short HEAD) &&
>>> + echo "On $branch: create untracked" >.git/expect &&
>>> + git show --pretty=%s -s "$short" >.git/actual &&
>>> + test_cmp .git/expect .git/actual &&
>>> + test_path_is_file create-untracked &&
>>> +
>>> + echo ignored >create-ignored &&
>>> + with_untracked=$(git stash create -u "create options") &&
>>> + test_must_fail git cat-file -e "$with_untracked^3:create-ignored" &&
>>> + short=$(git stash create "create options" -a) &&
>>> + long=$(git stash create --all "create options") &&
>>> + test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
>>> + echo ignored >.git/expect &&
>>> + git show "$short^3:create-ignored" >.git/actual &&
>>> + test_cmp .git/expect .git/actual &&
>>> + test_path_is_file create-untracked &&
>>> + test_path_is_file create-ignored &&
>>> +
>>> + echo staged >staged &&
>>> + git add staged &&
>>> + echo modified >>tracked &&
>>> + git diff >.git/before-worktree &&
>>> + git diff --cached >.git/before-index &&
>>> + git status --porcelain=v1 --ignored >.git/before-status &&
>>> + test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
>>> + STASH_ID=$(git stash create -a -- -create-message) &&
>>> + git diff >.git/after-worktree &&
>>> + git diff --cached >.git/after-index &&
>>> + git status --porcelain=v1 --ignored >.git/after-status &&
>>> + test_cmp .git/before-worktree .git/after-worktree &&
>>> + test_cmp .git/before-index .git/after-index &&
>>> + test_cmp .git/before-status .git/after-status &&
>>> + test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
>>> + echo "On $branch: -create-message" >.git/expect &&
>>> + git show --pretty=%s -s "$STASH_ID" >.git/actual &&
>>> + test_cmp .git/expect .git/actual
>>> + )
>>> +'
>>> +
>>> +test_expect_success 'stash create rejects unknown options' '
>>> + test_expect_code 129 git stash create --unknown-option 2>err &&
>>> + test_grep "unknown option" err
>>> +'
>>> +
>>> test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
>>> git stash clear &&
>>> test_when_finished "git reset --hard HEAD" &&

