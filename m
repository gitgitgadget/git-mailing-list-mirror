Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C7DC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB0MJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 07:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0MJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 07:09:26 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9734C7A80
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 04:09:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id cf14so6183901qtb.10
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 04:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jb78BnAyuPhp1o2tvNVpr0jl3j/tp6gv/yHJhyqwKCI=;
        b=FQ36Tov8NlZvQXOjuDtFdGWF40G9O3ub32sLVVEiZZw+cR1ZiTsC+MfR1BJwfGtCQf
         GJrtaUnp+fWJzbqGqVSrOALjTqSNVlr91FAWWLzmFn8pWA/T1jrwMxByMnDw76S5j2iQ
         dg4s16rDlw5FjUnuyQyvH1AUclecBERZzspoOfr7Q1CGzxLZDIg+45IGb+w+S6O7vg40
         3UHuON7oqmuu1H4/1FFGyh+GFr4Lrr+swn9nh1VVK88ZIZjiJAsJuRg7fOf0mYhxwm6O
         JnCP94jRimTSF7rf1Xhymy+8yOhmq+5+sq3CgVA7VHVXtnfIf+2YS/0LT7U3QKLm9NW9
         I6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb78BnAyuPhp1o2tvNVpr0jl3j/tp6gv/yHJhyqwKCI=;
        b=WRnKKFZLo/jwAmK3XEg8dVI2o7q+IsbKVmnim26FkQ7Pc6Tz7Cca4KcEVa1rKCF8J4
         E4spnTuM2kp0Icd3mAtDiOnSlmXYVO4YcBNHzk99Q7vSq1ssV4vl+c15Wi74PqGRV/04
         Ek2+c4uN5ur1cznEQ+7AHN37K4iZWDTdONBaGPWyJgGY2b9xUC+Aw5OWCtIZ0vbIp5BX
         eg9GPbm9qvAVS3gly8vgfi2hAgiIK/8KtGWNZxWLU4kfT5umFl+QUl5NLlikG96C1vHv
         Jt+8yeu9VmXNl/iyYFPiKjEkRQLhFbW0KZtk3Z6T4bflkhvoz598jdmf2Eb28ZNe7BnT
         tzZA==
X-Gm-Message-State: AO0yUKVGssWc6JCh/A9wUTyGePYpMvLqbTER64ClrnPcfRJMHjAX7mnR
        9W4HecqlN1ie6x/2hR/rP+T8q2W2Xc503yE=
X-Google-Smtp-Source: AK7set+rsPHNG2kBBglNiHyry5tXYsCXtg6GgcYdXoSyQ9paHALD7zWQCY39ZU+SoV6pgXsWYOZy9Q==
X-Received: by 2002:ac8:58d2:0:b0:3bf:e05a:f2f2 with SMTP id u18-20020ac858d2000000b003bfe05af2f2mr1255922qta.31.1677499760526;
        Mon, 27 Feb 2023 04:09:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cb8:323e:d144:f6b9? ([2600:1700:e72:80a0:cb8:323e:d144:f6b9])
        by smtp.gmail.com with ESMTPSA id x21-20020a376315000000b007419eb86df0sm4798141qkb.127.2023.02.27.04.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 04:09:19 -0800 (PST)
Message-ID: <c6c82351-4d41-990f-0cdd-565bf2955100@github.com>
Date:   Mon, 27 Feb 2023 07:09:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/3] fsck: check even zero-entry index files
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
 <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net> <xmqqr0uf0y4b.fsf@gitster.g>
 <Y/vdV4bjorvRYoaR@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y/vdV4bjorvRYoaR@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/23 5:29 PM, Jeff King wrote:
> On Fri, Feb 24, 2023 at 09:30:44AM -0800, Junio C Hamano wrote:
> 
>> So we had a separate worktree with its index pointing at an object
>> by its resolve-undo (or cache-tree) extension, but somehow lost that
>> object to gc (I agree with your assessment that it should no longer
>> happen since 2017).  gc these days knows about looking at the index
>> of all worktrees, finds the issue, and stops for safety.  fsck that
>> is run in the primary worktree may not have noticed but fsck run
>> from that worktree would notice the issue.
>>
>> Sounds like a frustrating one.  
>>
>> Thanks, both, for finding and fixing.
> 
> I saw that this hit next, but I had a few fixups that I had planned to
> squash in. I saw you got the leak-fix one, but I have one more. Since
> this is the end of the cycle, we _could_ just squash it in when we
> rewind next. But having now written it as a patch on top, I think the
> explanation kind of merits its own commit.

I just read all four (and a half) patches and agree that this
is a valuable change. Thanks for working on it.

-Stolee
