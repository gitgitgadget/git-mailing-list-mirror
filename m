Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B05C8300A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD0B2082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2thGl+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3JpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgD3JpT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 05:45:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A790C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:45:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so6046959wrt.5
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DZa5DuEz8uI9YlEpflZzrLGnNrEXtnEA1CyfNqTI9b4=;
        b=d2thGl+7mOH/ZAVlF/z/R9G+OaH0BDwaL0LZjLihxkwOLrnoMDuIzBpTh1o8sfELGc
         jvtHQKufP/iIIANwMMDFqEObIbTk4CnaS/kxlC2lJxl1mG6fSaYI2fEV8ZhDvKJkprvA
         KVQsnYeP/Al1OgOxQLU4ZBiDXwvi/rIbtMS7R6FncVRhbLrEG3LoVUqTPHc+iJWEMEDH
         RXw+9UPD3IZySE/+aIA/6nj9pGr7g1jRtJXuS8wUXEVLrE2uenmx5SPZo4zYoOMs5+Wo
         dQtgst0agsYERfD8GBShd5dTgvLyFNwVmXHIPFC1MxcPj3HbdbAZE6IzEtDF+uqMYfN7
         pPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZa5DuEz8uI9YlEpflZzrLGnNrEXtnEA1CyfNqTI9b4=;
        b=t6Ka76wa2x5XyNZob4bzc6ULBuf6EnOzwBrhqPpkOjC11GPEkInmuf88mVlcrRpCfV
         Cs63D1ECdoDE0TPqareGAT5Jtk7bxVIybEE1sItF8orQQWv8JNrq1DgGW0xGKqrpPrfL
         xZ+yuHJG8WCaozFBfpspPvN925BAEqbT3fJwWDY00+r9PIZy1QmxCz2z/br/1iiHb/DJ
         FTljMuCocsQOI1jMmLdlWtLVyLMpcqEQbvumb/cItHEj5YKsglnzA5gQPhl2rXmjzjlg
         QamdgUyE7PDhC+GirbMDPdFhfaNtjFXtfbVDC0H/IGg/JiUNBtgPKJm2kJLwW2BBrqVN
         iiMw==
X-Gm-Message-State: AGi0Pua3LsfyjilqDGmoeMVW8OBCpwrzKIEB9fmYXTeq4sOjKBl5N5Ov
        owrFhXxhwOFq+nB0lcoOjlXERmrH
X-Google-Smtp-Source: APiQypL9C2Bf2y2zFBvKXK1KDTX76xS8AolP257YOxfXyBkZHO+Y/NXbQTOB3N+ThPNV03wjw2i4Rw==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr2952389wrx.189.1588239916876;
        Thu, 30 Apr 2020 02:45:16 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id 19sm11314152wmo.3.2020.04.30.02.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 02:45:16 -0700 (PDT)
Subject: Re: [PATCH] rebase: save autostash entry into stash reflog on --quit
To:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <353a67567a90aea8a90bce1de05d005c61b3b670.1588066252.git.liu.denton@gmail.com>
 <xmqqv9lj1k0c.fsf@gitster.c.googlers.com>
 <20200429002323.GB2570028@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a349bc81-2098-b2ae-76be-09b18b9229ef@gmail.com>
Date:   Thu, 30 Apr 2020 10:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429002323.GB2570028@generichostname>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 29/04/2020 01:23, Denton Liu wrote:
> Hi Junio,
> 
> On Tue, Apr 28, 2020 at 12:35:15PM -0700, Junio C Hamano wrote:
>>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>>> index f7a6033607..7d0c89a184 100644
>>> --- a/Documentation/git-rebase.txt
>>> +++ b/Documentation/git-rebase.txt
>>> @@ -256,7 +256,8 @@ See also INCOMPATIBLE OPTIONS below.
>>>  --quit::
>>>  	Abort the rebase operation but HEAD is not reset back to the
>>>  	original branch. The index and working tree are also left
>>> -	unchanged as a result.
>>> +	unchanged as a result. If a temporary stash entry was created
>>> +	using --autostash, it will be saved to the stash reflog.
>>
>> ... let's not do so for end-user facing documentation.  "..., it
>> will be stashed away".  Or we may not even want to say anything; any
>> "--autostash" user would expect that the changes that were stashed
>> before "rebase" started would not be discarded, and this change may
>> just be a bugfix.
> 
> Hmm, in this case, git-merge.txt may need an update as well. From
> 'dl/merge-autostash', 
> 
> 	'git merge --abort' is equivalent to 'git reset --merge' when
> 	`MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present in
> 	which case 'git merge --abort' applies the stash entry to the worktree
> 	whereas 'git reset --merge' will save the stashed changes in the stash
> 	reflog.
> 
> and
> 
> 	--quit::
> 		Forget about the current merge in progress. Leave the index
> 		and the working tree as-is. If `MERGE_AUTOSTASH` is present, the
> 		stash entry will be saved to the stash reflog.
> 
> both need to be amended to remove the reference to the "stash reflog".

I agree that it would be good to have the documentation for rebase and
merge match in this case

> When I was writing this documentation, I wanted to distinguish between
> the temporary autostash entry and the actual stash since the autostash
> entry isn't pushed to the stash unless there are conflicts or it's
> explicitly saved. I'm not sure that something like "If a temporary stash
> entry was created using --autostash, it will be stashed away" works very
> well since the word "stash" is overloaded here to mean "a random stash
> commit" and "stashed away in _the_ stash". Unfortunately, I'm also
> having trouble coming up with a suitable phrasing of my own.

It's tricky to distinguish between the two, when I was reviewing the
merge --autostash patches I was wary of the mention of the stash reflog
but could not come up with anything better to distinguish between
remembering the stash oid and saving it to the list of stashes. I'm not
too bothered what we end up doing so long as it is consistent across the
commands.

Best Wishes

Phillip

> I dunno, perhaps I'm overthinking this too and your suggested rewording
> sounds good and I'm just being too picky.
> 
> Thanks,
> 
> Denton
> 

