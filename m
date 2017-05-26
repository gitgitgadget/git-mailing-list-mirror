Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07F81FA14
	for <e@80x24.org>; Fri, 26 May 2017 17:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940881AbdEZRHi (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 13:07:38 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36841 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdEZRHb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 13:07:31 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so16806620pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1lZvw63BbUEMwBWUpCBj2YGxiDO11i/axeyTwymNBCE=;
        b=eJWOJDx10kTkVNpaiVSpbyoHrpLB87XbkNLxbMSfoNYyvFH3EvgHZsfiyohl8C0lVf
         J9bO+TsO2PAqg3n6sUTf1mYehDAHsa6rJhyw9YD5joZlvohSBsQwc3AvJKiKl92lRGnO
         IRk1cHAOpl0bEv8QZjvpKOuEXPMTpTLDuKn8/YQGEnGhC8nHZQIs/zK1SeVVekyfQKUG
         qIUTN1KQ2l7BW/Vrt1QVSqREGKE0ZERKOAtdN+Nauxbhe2DW9k30G0dT3eA3c9yNDTLi
         GlSsyISvwlOKUjAVVO6Pg41ITtSVQhYxbHYDe8e3nCcKB0m2vOFbdfO/KX5ze8F71ae+
         Sk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1lZvw63BbUEMwBWUpCBj2YGxiDO11i/axeyTwymNBCE=;
        b=smQ1344iJZFIM7pBCQmPfHwRbQFFAprdsjl3RnuSg93lvJZf+KO0Ov8oqapvMPa9CW
         WsbVJ3xaYg84VaTqrcuSvxmWMEo6VLINdXoNYedqSoTIL8dY3lK3pxK6via4K4NgBgCw
         Yp4rl8njLuHzyprtCAXUKgxrq3TDCsj8x4bIPwejBeeIEgaHrDJeYbszeVXrry1wPrHM
         ryXuK2A0tH+6sHa2kvLpJQzAgnZF+U2QvTHR5nXPAAlAI/jc128tXomLTbbAinaJT5rq
         V1CK5xqQiy1SYV3LIZyR1P7siK3lLXhNkzSnGmhUP5vrn9uP/o7jTmaCzCZXPw9kG2mV
         /4tQ==
X-Gm-Message-State: AODbwcBtwDz2q872XExH9fbb1f/Qr1SNAXfDKpeqlFMpklNf5enSuGvB
        0I5sRHm1FNsGeedigsGt9BKtRDvczaaf
X-Received: by 10.84.174.3 with SMTP id q3mr328022plb.52.1495818450477; Fri,
 26 May 2017 10:07:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 26 May 2017 10:07:30 -0700 (PDT)
In-Reply-To: <01e8c552-fd3a-ee05-1ff1-3b3ea0f7feeb@ramsayjones.plus.com>
References: <20170521125814.26255-2-pc44800@gmail.com> <20170526151713.10974-1-pc44800@gmail.com>
 <01e8c552-fd3a-ee05-1ff1-3b3ea0f7feeb@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 May 2017 10:07:30 -0700
Message-ID: <CAGZ79kYbi5QxWAsxdfPkuWEyMt9Qg753sm0vExsKaWyksDVw+Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 1/3] submodule: fix buggy $path and $sm_path
 variable's value
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 9:31 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 26/05/17 16:17, Prathamesh Chavan wrote:
>> According to the documentation about git-submodule foreach subcommand's
>> $path variable:
>> $path is the name of the submodule directory relative to the superproject
>>
>> But it was observed when the value of the $path value deviates from this
>> for the nested submodules when the <command> is run from a subdirectory.
>> This patch aims for its correction.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
>> ---
>> This series of patch is based on gitster/jk/bug-to-abort for untilizing its
>> BUG() macro.
>>
>> The observation made was as follows:
>> For a project - super containing dir (not a submodule) and a submodule sub
>> which contains another submodule subsub. When we run a command from super/dir:
>>
>> git submodule foreach "echo \$path-\$sm_path"
>>
>> actual results:
>> Entering '../sub'
>> ../sub-../sub
>> Entering '../sub/subsub'
>> ../subsub-../subsub
>>
>> expected result wrt documentation and current test suite:
>> Entering '../sub'
>> sub-../sub
>> Entering '../sub/subsub'
>> subsub-../sub/subsub
>>
>> This make the value of $path confusing and I also feel it deviates from its
>> documentation:
>> $path is the name of the submodule directory relative to the superproject.
>> Hence, this patch corrects the value assigned to the $path and $sm_path.
>>
>>  git-submodule.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index c0d0e9a4c..ea6f56337 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -344,9 +344,9 @@ cmd_foreach()
>>                               prefix="$prefix$sm_path/"
>>                               sanitize_submodule_env
>>                               cd "$sm_path" &&
>> -                             sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
>>                               # we make $path available to scripts ...
>>                               path=$sm_path &&
>> +                             sm_path=$displaypath &&
>>                               if test $# -eq 1
>>                               then
>>                                       eval "$1"
>>
>
> Hmm, I'm not sure which documentation you are referring to,

Quite likely our fine manual pages. ;)

       foreach [--recursive] <command>
           Evaluates an arbitrary shell command in each checked out submodule.
           The command has access to the variables $name, $path, $sha1 and
           $toplevel: $name is the name of the relevant submodule section in
           .gitmodules, $path is the name of the submodule directory relative
           to the superproject, $sha1 is the commit as recorded in the
           superproject, and $toplevel is the absolute path to the top-level
           of the superproject. Any submodules defined in the superproject but
           not checked out are ignored by this command. Unless given --quiet,
           foreach prints the name of each submodule before evaluating the
           command. If --recursive is given, submodules are traversed
           recursively (i.e. the given shell command is evaluated in nested
           submodules as well). A non-zero return from the command in any
           submodule causes the processing to terminate. This can be
           overridden by adding || : to the end of the command.

As $path is documented and $sm_path is not, we should care about
$path first to be correct and either fix the documentation or the implementation
such that we have a consistent world view. :)

> but if
> $path != $sm_path then something is wrong. (unless their definition
> has changed, of course).

I would lean in doing so (changing their definition):

    $path (as documented) is the name of the submodule directory
    relative to the direct superproject (so in nested submodules you
    go up only one level).

$sm_path on the other hand is not documented at all and yields
non-sense results in corner cases.

With this patch it becomes less non-sensey and could be documented as:

    $sm_path is the relative path from the current working directory
    to the submodule (ignoring relations to the superproject or nesting
    of submodules). This documentation also fits into the narrative of
    the test in t7407.

Thanks,
Stefan
