Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A82C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 10:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjBGKub (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBGKu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 05:50:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C069734C03
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 02:50:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg26so10743994wmb.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 02:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiFmDoxB7gNJoMHExrKIdAvE9F59sdnVoLs7m1G7eHU=;
        b=Dp2SMFFfhNnNAndv3vmY02eH1e1CYrNopSDJnQjw7UUNFI+menla1dozOKSnrsRnSM
         uTfHJrmg0mMUVmArIF4p7StKKWtsqRmnwoVHPx7gpZ2WfRKyAngqfhbS9HBNACRYOuy/
         U8YxhcklBmNYmdpi+leHBeMEug0aFzYmTu9s7f/mJp357M+/s0YT0iSTbyKdlC9mnzy0
         XHlttXg/9bIbQbeeTMvqNOJgSckhDBhO7xmtVJiVXbaiXGUYESBONvDnZAF03nM5VqI6
         u34JvJ+A2Sa/9R4F2XGt3ZFd3iyBmh2l+f1bw9TDsH9cHQ7xsVWJgUTf99qiXyyTT+RC
         89Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiFmDoxB7gNJoMHExrKIdAvE9F59sdnVoLs7m1G7eHU=;
        b=EnyWhnmN52zEmBYFLdB4AEQR6E+NZ63wfWM/WOqZXCg6HXq5dPkRcfdWTJ4K/8Ju3S
         F8J4TjXPKIzFw9piT3Pgo07pa5c7OIkWeipV6QgJJ9+LiCikhTdo20iMhKbgOesPCZ8I
         j9N1DrJ7rK8TfY84opX1b5gkq/CmuSLI9CNxa3v61klS09xl2ZhOasi4S0y4iddIInO5
         AwPrw7iciGAvN/yobUdYdfZ8uTyeNHVk4s622qZZlBD67hLTIBdcwlhddCMEshtblKMz
         dP9xUH6iVUh2HAaZ8blYxcp7M/q3IhBeyxxti5bboB/NxopFyIoe53Jz/6yvF45a/Izs
         qb6w==
X-Gm-Message-State: AO0yUKU7fYNhHTZZiHrpspKsW/MtcwLey21nJEw8u30dlLJnpLEClCFv
        5nCEf+2y4asx70Xezdz8zdI=
X-Google-Smtp-Source: AK7set9NdjPJH2Dmido0XK0ugnJ+PNMlWPc1c7VQeAyT/FyZhPFnpAbBSHj4YVPaK3VkICqZaH0DWw==
X-Received: by 2002:a05:600c:2e96:b0:3df:7948:886b with SMTP id p22-20020a05600c2e9600b003df7948886bmr2521327wmn.31.1675767011299;
        Tue, 07 Feb 2023 02:50:11 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm14904161wmc.4.2023.02.07.02.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:50:11 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1da499d6-3de3-ba34-1ca0-6f39e528b80b@dunelm.org.uk>
Date:   Tue, 7 Feb 2023 10:50:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] branch: fix die_if_checked_out() when
 ignore_current_worktree
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <8670d6c6-b5cd-a1e3-8fbf-b948cb687388@gmail.com>
 <230206.861qn27mt9.gmgdl@evledraar.gmail.com>
In-Reply-To: <230206.861qn27mt9.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02/2023 16:56, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Feb 05 2023, Rubén Justo wrote:
> 
>> -	wt = find_shared_symref(worktrees, "HEAD", branch);
>> -	if (wt && (!ignore_current_worktree || !wt->is_current)) {
>> -		skip_prefix(branch, "refs/heads/", &branch);
>> -		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
>> +	for (int i = 0; worktrees[i]; i++) {
> 
> I see that there are existing "int i" for counting worktrees in
> worktree.c, FWIW for new code I wouldn't mind if it's "size_t i"
> instead, to make it future proof (and to eventually get rid of cast
> warnings as we move more things from "int" to "size_t").

This seems to be different from the usual worries about int/size_t 
comparisons/truncation. worktrees is NULL terminated so there is no 
signed/unsigned comparison here as we're not comparing it to anything. 
The only concern would be that there are more than INT_MAX which seems 
unlikely.

Best Wishes

Phillip

>> @@ -435,10 +435,9 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
>>   					  const char *target)
>>   {
>>   
>> -	for (int i = 0; worktrees[i]; i++) {
>> +	for (int i = 0; worktrees[i]; i++)
>>   		if (is_shared_symref(worktrees[i], symref, target))
>>   			return worktrees[i];
>> -	}
> 
> You added this function in the last commit, let's just skip adding the
> braces to begin with, rather than this style-fix after the fact.
