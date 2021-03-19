Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2919DC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE01161988
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSShu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSShl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 14:37:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6BDC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 11:37:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so9454137ota.0
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6PR2ERHP/mxp/mnJiO0WiQtlarMEDz4U0XpyeabniuU=;
        b=iHRapMvDSLNZmDwNvzEcSGC6y5bs8gzJNxHvO9wZHJ0jUFO231Ad/cWGElBxFt0qzF
         dzv+H2rzmUGaM3KkWMKfskewF1LJu0c087V4JwPkY36+WYa/MKUWq0TGvwOL6Iu5pEe5
         5ixiYWzfqCrvgFYfYHthQF9OkwQ+JTcmWPwGCbGQHZIBieazOT1ML3uC94MVZyj4+WZh
         5wjLv9rL8/R48h5Rvrmrdh8CjKcpFbGihvnuy7RD4eAESSWzWFNxbMMWoScPARXU7f3q
         DCLjMBr1RbTCXUC9eQs/RLtTCfhrIaa5+ueeYIHnoMP3He0hYc79gYIa559fHGP6jGwp
         0/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6PR2ERHP/mxp/mnJiO0WiQtlarMEDz4U0XpyeabniuU=;
        b=ZImNvXtu97L5rec5glQ0f+mbciNTTqHftJK7iVjZjFfM5u+TIEo0xftvg1XXWuFL33
         8nMV+gYy1cQCUJQvt5qvU5O6MMftzH0gXXXeGacYpgvRTNWe2XiZPJk7QV5p/eEHjaKU
         j/2WZvvEzpwJSgnoLhO07XipVl161vztz2MrPHfcyslzpZduBtJEo2TUK0uSxGqB40Ps
         vRhVoUNZbHH0MaePs3/YryNUCoXNMzDGN1m6AAl1b7I02CkxSZ9fQpyncpZ88WeG3jWP
         +f37DsjX+bli6fLqNiOYyQh1EEWXDkUcmgb8T+psy9D/d4WcBrrvRmhxzlf3q9nr2tVB
         OFLg==
X-Gm-Message-State: AOAM531fiEZFJwf6XdZ+cJMJrhb6gF/bcJbfJdN9OhdtP5LoGQYT9pK8
        snxcTGO+6vNO9qa1MDGWnl9KJUhn4xmOsA==
X-Google-Smtp-Source: ABdhPJyAY8gwksDB4TzuIO4hZ/A7BH7AdTljwE+N6k4z/ceOJRMzqHbAmR4ElJAyFe/EPNH5RmbYYg==
X-Received: by 2002:a05:6830:817:: with SMTP id r23mr2121738ots.234.1616179060558;
        Fri, 19 Mar 2021 11:37:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7c62:2958:a423:b37b? ([2600:1700:e72:80a0:7c62:2958:a423:b37b])
        by smtp.gmail.com with ESMTPSA id w1sm1399100oop.1.2021.03.19.11.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 11:37:40 -0700 (PDT)
Subject: Re: [PATCH] Fix a typo in git-maintenance documentation
To:     Junio C Hamano <gitster@pobox.com>,
        Nils Leif Fischer via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Nils Leif Fischer <hello@nilsleiffischer.de>,
        Nils Leif Fischer <nils.fischer@aei.mpg.de>
References: <pull.984.git.git.1616149021392.gitgitgadget@gmail.com>
 <xmqqv99nm3jy.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a73d5c2-831c-8e9e-5f21-2f8ef24dfa42@gmail.com>
Date:   Fri, 19 Mar 2021 14:37:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqv99nm3jy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2021 1:55 PM, Junio C Hamano wrote:
> "Nils Leif Fischer via GitGitGadget" <gitgitgadget@gmail.com>
>>  gc::
>>  	Clean up unnecessary files and optimize the local repository. "GC"
>> -	stands for "garbage collection," but this task performs many
>> +	stands for "garbage collection", but this task performs many
> 
> Isn't this merely an American style vs British style issue?

Yes, I believe so.

> https://www.grammarly.com/blog/quotation-marks
> https://www.thepunctuationguide.com/british-versus-american-style.html
> https://owl.purdue.edu/owl/general_writing/punctuation/quotation_marks/more_quotation_mark_rules.html

Specifically, this quote from your first link:

  Commas and periods always go inside the quotation marks in
  American English; dashes, colons, and semicolons almost always
  go outside the quotation marks; question marks and exclamation
  marks sometimes go inside, sometimes stay outside.

The only time I break this is when the exact string matters,
such as referencing an exact command with options. In those
cases, I try to restructure the sentence to avoid having a
comma or period outside of the quote.

Thanks,
-Stolee
