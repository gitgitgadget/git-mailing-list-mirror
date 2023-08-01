Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4DC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjHASt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjHAStx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:49:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5C2717
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:49:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so90761681fa.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690915775; x=1691520575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5cewPeNKx4HWiHmFINOYCJqqzpjqQHEOBeKSGaGKlvY=;
        b=n5ykNtmHDhcqPTXEYn8NO2bwABNltgdboImCnCF+TbdMLeMVv6qGkcUsMhO0DJU2Sw
         kPkwtuVScF2F0b9fjQ1Kuvm7EP6faE60VFMFL9CKqDinluG8aA+jkI+zgX/J2MWW/n3F
         rfc1GRfeBY/B14ydXrXGMWkoX8d+xZS4jg4/Uiub1BNmBGPoIWupiNxQcz4VQ0OBQiis
         AoXG/H3Y/5TGtY9oLOiQV2Agy4kaCXUg/fivJhCV0GAloINKghOlqTFv4r4bUmlUwKXc
         eXsLenaUyg4Z0CIci4VARUzHDTYcVuCUt43hbk3JM3F6GNbmKjmtkksgKjSPBFFRWmDJ
         cvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915775; x=1691520575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cewPeNKx4HWiHmFINOYCJqqzpjqQHEOBeKSGaGKlvY=;
        b=WMVt1ZNDrIBB/Nl7dqVzeCgIZAlNFdNjVkozIx3ADZ7kWGsedJf7FSwMd6K2Iw0Tr8
         pq0/wWnBrkGunFXiwragJbdSmKDp/XW6mDTLRD5RlruYdVt2GDlRP3gL7NTjS79toUF2
         tXsdeJ47kQKUFERjqCUpTv5gfNi4ZAPVjfqWBA4Q2ahWMAjBIi/QF2NOlBQImY/QCpkW
         jMLgAgmkrHz6PkXHdnrVsIqy5DVI5re4al+eZ4PPBkYqNs9b9p9hQnT8JKXmY0fmReOc
         gE26GDbChJeIHuO7xr62ePH+oLUCXImH5QONWdRsApxaIY5NOKkdGhvyGQ12kmXTpLRe
         L92g==
X-Gm-Message-State: ABy/qLYzTif8BPMEiJ4l9XNvdfu2CDqL168NHPgx6PcbTzGMCskg2afv
        8JEFZWt1IHsfZWWja5TueRU=
X-Google-Smtp-Source: APBJJlHaVV0uH7VqdywE+ANW5rWK+kTOEWwkdH7tjZvdCtOo3XYw0cenVyCcZpb3n/hgxnuX/oX3wg==
X-Received: by 2002:a2e:9603:0:b0:2b9:4093:a873 with SMTP id v3-20020a2e9603000000b002b94093a873mr2905332ljh.5.1690915775258;
        Tue, 01 Aug 2023 11:49:35 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003fe263dab33sm3680264wmj.9.2023.08.01.11.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:49:35 -0700 (PDT)
Message-ID: <619e458b-218b-a790-dfb4-9200e201b513@gmail.com>
Date:   Tue, 1 Aug 2023 19:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/7] sequencer: use rebase_path_message()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <8f6c0e4056742951ce84acbdb07b0518f7607b2a.1690903412.git.gitgitgadget@gmail.com>
 <xmqq4jlid6cx.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq4jlid6cx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08/2023 18:23, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Rather than constructing the path in a struct strbuf use the ready
>> made function to get the path name instead. This was the last
>> remaining use of the strbuf so remove it as well.
> 
> The same comment about "get_dir() vs hardcoded rebase-merge" applies
> here, I think.  And the same (1) assertion to ensure that we are in
> "rebase -i" when make_patch() is called should give us a sufficient
> safety valve,

Agreed

> or (2) instead of hardcoding rebase_path_message(),
> call it sequencer_path_message() and switch at runtime behaving the
> same way as get_dir(opts) based version, would also work.

I think that would me misleading because cherry-pick/revert do not 
create that file - they rely on "git commit" reading .git/MERGE_MSG

Best Wishes

Phillip

> Thanks.
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 70b0a7023b0..dbddd19b2c2 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -3501,7 +3501,6 @@ static int make_patch(struct repository *r,
>>   		      struct commit *commit,
>>   		      struct replay_opts *opts)
>>   {
>> -	struct strbuf buf = STRBUF_INIT;
>>   	struct rev_info log_tree_opt;
>>   	const char *subject;
>>   	char hex[GIT_MAX_HEXSZ + 1];
>> @@ -3529,18 +3528,16 @@ static int make_patch(struct repository *r,
>>   		fclose(log_tree_opt.diffopt.file);
>>   	}
>>   
>> -	strbuf_addf(&buf, "%s/message", get_dir(opts));
>> -	if (!file_exists(buf.buf)) {
>> +	if (!file_exists(rebase_path_message())) {
>>   		const char *encoding = get_commit_output_encoding();
>>   		const char *commit_buffer = repo_logmsg_reencode(r,
>>   								 commit, NULL,
>>   								 encoding);
>>   		find_commit_subject(commit_buffer, &subject);
>> -		res |= write_message(subject, strlen(subject), buf.buf, 1);
>> +		res |= write_message(subject, strlen(subject), rebase_path_message(), 1);
>>   		repo_unuse_commit_buffer(r, commit,
>>   					 commit_buffer);
>>   	}
>> -	strbuf_release(&buf);
>>   	release_revisions(&log_tree_opt);
>>   
>>   	return res;
