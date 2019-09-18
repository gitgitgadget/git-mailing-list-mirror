Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D2D1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfIRNvv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 09:51:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34294 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfIRNvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 09:51:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so9006506qth.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ylBTRI365LqZv/r38wwKYpokZJHCJoCGZiHP+hMhIBA=;
        b=Pji/CbPnQWe2ODXcsOniQqFgaRupjyfQvxNsFAEjB0As0s5wqHpHe4hAeQzBCLAj7t
         Duq8QTQIeD8HP2uvFNdhJCu+k9frErr463/svVfL6Apiov2i3yYyW9RjyLcGHPqEYdTk
         FfXq96mdWE2xgCf3FAQnd3UGAURBSjkYz/GcYziMIm5IiFLZ/j2lkKJ3heYuvOddhAq2
         aR4vwlVv4bSfW/VfZXb4zlEOdcRd29flXpaiHmEUj+HYkfUlMTNW5g++eMmpnBcsH+dc
         gGi371P+FEWrVFhdxkZVvyTV8Co9S8o/aFKQ2dFPu/W9k1Gxe9YmE7yhCisSo+fSGIHU
         m5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ylBTRI365LqZv/r38wwKYpokZJHCJoCGZiHP+hMhIBA=;
        b=aTBzsXIZ74mkvc+T7tEyvECG7fjud486Hkar8jKcVx/OSSb1G9h6lJCXz6lGlMRIVU
         2wHbnDt4J6Izv1i+PLhJ9jj7YOIMCWP0PAbwCH8xfUDgHnxCOK3ibQC3DFGKldxnb55A
         4pvbrIteoxRWtFcZmBD7DX1nwarbZ3u+1cKo6aPQ3ernagTmX/f/TbmkPe+BOZqedl8h
         evwO1/r9GV57e5IykRRzab77fd7ZhpQcSohsDijASg3aQtgqMYspVvGPhfw2QOdKtFRS
         L/exYizS24miYVQt87EjUFc6WhmUB6DXORWPfhN05x0R8OQrtyUXVENRgYsG41Au1Yw+
         as0w==
X-Gm-Message-State: APjAAAWw+1XVoawbFTY6ZCz0n304MtoZ1pzDmduFOvR3MSr37xYbuvNZ
        ctOM81PJxnNf3m1KzDihQ/U=
X-Google-Smtp-Source: APXvYqxrwjy8OlbVq0yth3BJatWmkV/oaDnirE74fHjf5yu4n5pCtMmBwIH+XjQphef/qxnQ6nuZqg==
X-Received: by 2002:ac8:65cf:: with SMTP id t15mr370836qto.364.1568814709108;
        Wed, 18 Sep 2019 06:51:49 -0700 (PDT)
Received: from [10.0.1.21] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id t32sm3474828qtb.64.2019.09.18.06.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 06:51:48 -0700 (PDT)
Subject: Re: [PATCH 3/9] clone: add --sparse mode
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <4ccd36b3966b62934cfbb0ec65e2851b50dfa1e3.1566313865.git.gitgitgadget@gmail.com>
 <CABPp-BGyDwgTRx3A4OPJT=5rMM-onkPtg9m58M=rDMHiJQxQ6Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <52514598-0c7c-4cc9-187b-8d40c4f5172f@gmail.com>
Date:   Wed, 18 Sep 2019 09:51:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGyDwgTRx3A4OPJT=5rMM-onkPtg9m58M=rDMHiJQxQ6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2019 7:17 PM, Elijah Newren wrote:
> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When someone wants to clone a large repository, but plans to work
>> using a sparse-checkout file, they either need to do a full
>> checkout first and then reduce the patterns they included, or
>> clone with --no-checkout, set up their patterns, and then run
>> a checkout manually. This requires knowing a lot about the repo
>> shape and how sparse-checkout works.
>>
>> Add a new '--sparse' option to 'git clone' that initializes the
>> sparse-checkout file to include the following patterns:
>>
>>         /*
>>         !/*/*
>>
>> These patterns include every file in the root directory, but
>> no directories. This allows a repo to include files like a
>> README or a bootstrapping script to grow enlistments from that
>> point.
> 
> Nice.
> 
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/git-clone.txt        |  8 +++++++-
>>  builtin/clone.c                    | 27 +++++++++++++++++++++++++++
>>  t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
>>  3 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index 34011c2940..0fe91d2f04 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -15,7 +15,7 @@ SYNOPSIS
>>           [--dissociate] [--separate-git-dir <git dir>]
>>           [--depth <depth>] [--[no-]single-branch] [--no-tags]
>>           [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
>> -         [--[no-]remote-submodules] [--jobs <n>] [--] <repository>
>> +         [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
>>           [<directory>]
>>
>>  DESCRIPTION
>> @@ -156,6 +156,12 @@ objects from the source repository into a pack in the cloned repository.
>>         used, neither remote-tracking branches nor the related
>>         configuration variables are created.
>>
>> +--sparse::
>> +       Initialize the sparse-checkout file so the working
>> +       directory starts with only the files in the root
>> +       of the repository. The sparse-checkout file can be
>> +       modified to grow the working directory as needed.
>> +
>>  --mirror::
>>         Set up a mirror of the source repository.  This implies `--bare`.
>>         Compared to `--bare`, `--mirror` not only maps local branches of the
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index f665b28ccc..d6d49a73ff 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -60,6 +60,7 @@ static const char *real_git_dir;
>>  static char *option_upload_pack = "git-upload-pack";
>>  static int option_verbosity;
>>  static int option_progress = -1;
>> +static int option_sparse_checkout;
>>  static enum transport_family family;
>>  static struct string_list option_config = STRING_LIST_INIT_NODUP;
>>  static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
>> @@ -147,6 +148,8 @@ static struct option builtin_clone_options[] = {
>>         OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>>         OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
>>                     N_("any cloned submodules will use their remote-tracking branch")),
>> +       OPT_BOOL(0, "sparse", &option_sparse_checkout,
>> +                   N_("initialize sparse-checkout file to include only files at root")),
>>         OPT_END()
>>  };
>>
>> @@ -734,6 +737,27 @@ static void update_head(const struct ref *our, const struct ref *remote,
>>         }
>>  }
>>
>> +static int git_sparse_checkout_init(const char *repo)
>> +{
>> +       struct argv_array argv = ARGV_ARRAY_INIT;
>> +       int result = 0;
>> +       argv_array_pushl(&argv, "-C", repo, "sparse-checkout", "init", NULL);
>> +
>> +       /*
>> +        * We must apply the setting in the current process
>> +        * for the later checkout to use the sparse-checkout file.
>> +        */
>> +       core_apply_sparse_checkout = 1;
>> +
>> +       if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>> +               error(_("failed to initialize sparse-checkout"));
>> +               result = 1;
>> +       }
> 
> Sigh...so much forking of additional processes.  I'd really rather
> that we were reducing how much of this we are doing in the codebase
> instead of adding more.  Every fork makes following stuff in a
> debugger harder.

At the moment, this is the simplest way to do this interaction. The
init subcommand is doing multiple things, and we can consider moving
this to be a library method instead of builtin-specific code later.

This is not a huge performance hit, as "clone" is called only once
per repo.

>> +
>> +       argv_array_clear(&argv);
>> +       return result;
>> +}
>> +
>>  static int checkout(int submodule_progress)
>>  {
>>         struct object_id oid;
>> @@ -1107,6 +1131,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>         if (option_required_reference.nr || option_optional_reference.nr)
>>                 setup_reference();
>>
>> +       if (option_sparse_checkout && git_sparse_checkout_init(repo))
>> +               return 1;
>> +
>>         remote = remote_get(option_origin);
>>
>>         strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index 35ab84aabd..b7d5f15830 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -87,4 +87,17 @@ test_expect_success 'init with existing sparse-checkout' '
>>         test_cmp expect dir
>>  '
>>
>> +test_expect_success 'clone --sparse' '
>> +       git clone --sparse repo clone &&
>> +       git -C clone sparse-checkout list >actual &&
>> +       cat >expect <<-EOF &&
>> +               /*
>> +               !/*/*
>> +       EOF
>> +       test_cmp expect actual &&
>> +       ls clone >dir &&
>> +       echo a >expect &&
>> +       test_cmp expect dir
> 
> Checking that a toplevel entry is present, but not checking that an
> entry from a subdir is missing as expected?

This test is checking that the file "a" is the _only_ entry in the root
of the repo. The directories "folder1" and "folder2" are not present, since
we are comparing the ls output to "expect".

Thanks,
-Stolee
