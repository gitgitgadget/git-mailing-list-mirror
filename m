Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3262C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 13:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771BA20936
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 13:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKe84qfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIVN10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIVN10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 09:27:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF920C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 06:27:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so3346710wmb.4
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3l7VUwShaNgKeFUfIdiMEyrhAVfan8RfQPuC42YD0bw=;
        b=ZKe84qflHo7pJ9Xf4vljZMMlpREUwThlgd8RsXQcfGz6F9cw3SzGUMnTP2R/sc+oY4
         zOSqc+bsEV6vrdjA0x1QZgXCb50mkfHIpR9POffeeSzF5/or+YyD4MSdUyUhRT9gdX2B
         dMv4kt1k+OMr617LVlg6XxHctAcGoleUabfUo0TQXMCTQpRb2RCVTZ8323UL4iPqswxV
         1RUNScurOOb4ByqvuwgDyxDY3eiG0DkB4v9WrIETIa7NZ3nyO1wJ5yFIxDaJdad3LQkX
         9IZbOY4JA4omgBus4vvS6UH502VdsNzSKlbuz3uxhjdmemlTZI1VLzlp+JTblpxTxZQa
         +B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3l7VUwShaNgKeFUfIdiMEyrhAVfan8RfQPuC42YD0bw=;
        b=qtTDZW+Yt4IsgYhhqWDgWKkOQDtUZJFu9MqUsjKXzZANRqyp1cFLK+Sb+MYh6DGcX+
         3AwhxHFi7Th8/jeQz2uJkaEoE+QRT3f/4No3+6C8fSqWatPgFSsgfvG/6QoAOJhWHzyt
         iAxDb8yyhVG3jjrvnAdietZBmGK6OLq22OEnRo4UArIrURrzabuq/wYGAU6V8AzpGBRz
         ZiDrzlHy2XLNsafFx+DIf2lhBV7tG3rQXF3t4s1lM6cmgXd+RvLRGOIufcku6XLp1sbD
         HQe3yJRsisVeDa8IEwK/osTBZ/IJgbK1ioWB+Z9d+LP6ojF/eH3hvBc9srPUC7wsKaFj
         htIQ==
X-Gm-Message-State: AOAM532yKf9cPpqfamm6HlZrE8DuiojzFY5Ij5Bm6muwnIlHgH1TdTNE
        L7g33DkfFst7c4IGqBgCkBxaeXRPYL0=
X-Google-Smtp-Source: ABdhPJyth4gGqVPaf1LwRDpc3QZstlUrMatGgJXwh1k8Ok4+H5k9+cuWLzDikTYaNPM6A2i7DIJDfA==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr1056301wmf.40.1600781244489;
        Tue, 22 Sep 2020 06:27:24 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id h76sm5325855wme.10.2020.09.22.06.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:27:23 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] commit: reorder synopsis
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
 <80a69318b57348c59e45c0f8df1c342ef84388d4.1600695050.git.gitgitgadget@gmail.com>
 <xmqqft7acre2.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2a14d3d2-743c-215e-aa69-de75a576f685@gmail.com>
Date:   Tue, 22 Sep 2020 14:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqft7acre2.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/09/2020 06:27, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Rearrange the synopsis for `git commit` to try and put options that
>> are used more often nearer the beginning.
> 
> Which option is used "more often" depends heavily on the workflow,
> and it is a bit unfriendly to those who are affected by this change
> not to list the ones you are demoting, with rationale for each,
> something like:

I agree the changes are a bit subjective, I thought --dry-run -u<mode>
and -v were probably not as important enough to justify their position
on the first line and it sounds like you basically agree with that.

>   - "--dry-run" may or may not be used often, but it is orthogonal to
>     the regular options that affect how the command behaves, and it
>     is much less important and interesting than the other options.
> 
> Among the ones you are demoting without explanation
> 
>   - "-s" is no longer even mentioned, which I do not think is a well
>     thought out change.

That's a mistake I did not intend to remove it, thanks for spotting that
 
>   - "-v" is to make the command do the same thing as it does without
>     it, but just more loudly, so it is less interesting than the
>     other options.
> 
>   - "-u<mode>" affects what is shown in the editor to prepare the log
>     message, which is of less importance than other options that
>     affect the outcome of the command.  When --no-status is in
>     effect, -u<mode> would not even have any effect, so it probably
>     makes sense to move this next to "--[no-]status".
> 
>   - "--reset-author" can be used not just to take ownership of the
>     commit from somebody else, but also be used to update the author
>     date of your own change.  It probably belongs to the same group
>     as -c/-C/-F/-m that affects the metadata of the resulting commit
>     and should stay at the original location in the list.  If you
>     want to change anything around this area, I'd suggest moving
>     --date=<date> close to this "options that affect commit's
>     metadata" group.

I was trying to group the author/date related option together - they 
all affect the metadata of the resulting commit

What do you think to

-'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
-	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
-	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
	   [-S[<keyid>]] [--] [<pathspec>...]
+'git commit' [-a | --interactive | --patch] [--amend]
+	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
+	   [--reset-author] [--author=<author>] [--date=<date>] [-s] [-e]
+	   [--allow-empty] [--allow-empty-message] [--no-verify]
+	   [--cleanup=<mode>] [-u<mode>] [--[no-]status]  [-v] [--dry-run]
	   [-i | -o | -p] [--pathspec-from-file=<file> [--pathspec-file-nul]]
  	   [-S[<keyid>]] [--] [<pathspec>...]

--dry-run and -v are demoted. -u<mode> is moved next to --[no-]status
as they are related. -s is restored but moved and the author/date
related options are moved up to join the other options that affect the
commit metadata. The downside is that --allow-empty and friends end up
being moved down a line as a consequence of keeping all the commit
metadata related options together.

If you are happy I'll redo the commit message based on your suggestions
above

Thanks

Phillip

> 
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   Documentation/git-commit.txt | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
>> index a1d1d1246f..9de4dc5d66 100644
>> --- a/Documentation/git-commit.txt
>> +++ b/Documentation/git-commit.txt
>> @@ -8,11 +8,11 @@ git-commit - Record changes to the repository
>>   SYNOPSIS
>>   --------
>>   [verse]
>> -'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
>> -	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
>> -	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>> -	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>> -	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>> +'git commit' [-a | --interactive | --patch] [--amend]
>> +	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
>> +	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e]
>> +	   [--reset-author] [--author=<author>] [--date=<date>]
>> +	   [--cleanup=<mode>] [-v] [-u<mode>] [--dry-run] [--[no-]status]
>>   	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>>   	   [-S[<keyid>]] [--] [<pathspec>...]
