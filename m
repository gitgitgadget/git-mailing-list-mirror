Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8566C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 11:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiEZLkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiEZLkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 07:40:20 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7638217F
        for <git@vger.kernel.org>; Thu, 26 May 2022 04:40:19 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuBqj-000A3L-4w;
        Thu, 26 May 2022 12:40:17 +0100
Message-ID: <7367a18a-2e41-22e2-d8c5-2ccff71c58a0@iee.email>
Date:   Thu, 26 May 2022 12:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
 <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2022 10:40, Ævar Arnfjörð Bjarmason wrote:
> On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> Since feebd2d256 (rebase: hide --preserve-merges option, 2019-10-18)
>> this option is now removed as stated in the subsequent release notes.
>>
>> Fix the option tip.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  builtin/rebase.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 7ab50cda2ad..6ce7e98a6f1 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1110,7 +1110,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>>  			parse_opt_interactive),
>>  		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>> +			      N_("(REMOVED) try to recreate merges instead of "
>>  				 "ignoring them"),
>>  			      1, PARSE_OPT_HIDDEN),
>>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> I have some local patches for this more generally, but for
> PARSE_OPT_HIDDEN options we never do anything with the "argh" field,
> i.e. it's only used for showing the "git <cmd> -h" output, and if it's
> hidden it won't be there.
>
> So there's no point in changing this string, nor to have translators
> focus on it, it'll never be used.

I still think it's useful for those that read the code, as it reminds
folks about what it is/was, and why it's hidden, hence the usefulness of
the change, from my perspective. I'm flexible either way, but didn't
feel the 'DEPRECATED' was correct information.
>
> This series shouldn't fix the general issue (which parse-options.c
> should really be BUG()-ing about, after fixing the existing
> occurances. But For this one we could just set this to have a string of
> "" or something, only the string you're changing in 3/3 will be seen by
> anyone.

