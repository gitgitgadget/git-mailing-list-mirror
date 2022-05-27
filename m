Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248AEC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 12:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiE0Mao (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 08:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354427AbiE0MaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 08:30:25 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42811E3F6
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:08:59 -0700 (PDT)
Received: from [90.198.244.89] (helo=[192.168.0.6])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuYm1-000CCB-At;
        Fri, 27 May 2022 13:08:57 +0100
Message-ID: <08a87733-cb93-5590-3e96-614be2e64dce@iee.email>
Date:   Fri, 27 May 2022 13:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] rebase: note `preserve` merges may be a pull config
 option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <ece3eecdc4de44cdec1b6efa9079930721db85ad.1653556865.git.gitgitgadget@gmail.com>
 <xmqqv8tsvws7.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqv8tsvws7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2022 21:55, Junio C Hamano wrote:
> "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> The `--preserve-merges` option was removed by v2.35.0. However
> Are you sure about that?
Not any more. I think that was because of the version the user reported...
It's clearly wrong, as the down grade is to 2.33.0

> 52f1e821 (pull: remove support for `--rebase=preserve`, 2021-09-07)
> that is in v2.34.0 and above dropped pull.rebase=preserve from the
> Documentation/config/pull.txt (and others).  My local collection
> of various Git versions agrees with me.  "git help config" from
> 2.34.0 does not list preserve as a valid choice, but 2.33.0 does.
>
>> users may not be aware that it is also a Pull option, and it is
>> still offered by major IDE vendors such as Visual Studio.
>>
>> Extend the `--preserve-merges` die message to also direct users to
>> the use of the `preserve` option in the `pull` config.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>   builtin/rebase.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index aada25a8870..6fc0aaebbb8 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1205,7 +1205,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   			     builtin_rebase_usage, 0);
>>   
>>   	if (preserve_merges_selected)
>> -		die(_("--preserve-merges was replaced by --rebase-merges"));
>> +		die(_("--preserve-merges was replaced by --rebase-merges\n"
>> +			"Your `pull` configuration, may also invoke this option."));
> What is a `pull` configuration?
I was thinking of 'those that relate to the pull command';-)

>   Our configuration variable names
> all have at least one dot in it.  I think it is better to be
> explicit to clarify what exactly we are suggesting to fix.
>
> "Your `pull.rebase` configuration may be set to 'preserve', which is
> no longer supported; use 'merges' instead", or somesuch?

That's a lot better. I'll borrow that..
P.
