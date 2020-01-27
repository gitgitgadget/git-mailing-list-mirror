Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B93C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DD824681
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jClsovn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0TsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:48:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42585 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0TsE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 14:48:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so12925647wro.9
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pNrYwADSyWVNcIgxwnN9xplGHzGdmJnZb272hdmB7qg=;
        b=jClsovn5Q6qGRLpY7ujHbYVc52adRUY1m/Ibts4pj20w/EYZlW5JqPjWeZR5Sxtvry
         JJBKWxlBb8KlOVaYA9USsLFPzMs6gfl6sAUrUxjlLGp9fj2F4eUtq6DukBFr31b166it
         +FPaKsrmoThtm9TvI3fEgS0Hsdr03xgmsdmjrs3rrMLKOAnHQyU8h3HFNkOCRT+HkCda
         KCEAPES9+owUEk85ZqbNIcsSE2EQQJMP8GnsSabaoc1WEPR91PsxYXARzGQWfI14VRxE
         bXcBm2VHUD92OYo4YemSFDGy60KGt2E08FKTfERyoeo1sNH5465psdMVRsS04XIgl06P
         2BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pNrYwADSyWVNcIgxwnN9xplGHzGdmJnZb272hdmB7qg=;
        b=qLaDzmgs73ehZw76FK171sWuLTldWjhvNedmFuiDGHjX5FrGjflmDwpE/OWsRICKHj
         zkw61vYs51/NxAzDKCgy+vI93fsW1mznBVG+arNOqk0czyMgQZb42DyAlSfrW2P7TtCg
         yVjuryr/bITl8FyaIf9LG9bYH714RoRIq21Nm2qJwARDXQrveTf4Y+i/VFuEILIFSGAA
         rfrsLXP4SAJ0xU1qDTZl8aADmwBzRnvR8jyjssbdgZU9UQd0PjN5JgGRs6Buyf3zfFP9
         XktCnp9mIY6NmtkuHUDrq3J17FCAtbazzd0v03FNtrk3tsDGRtgFH6amguT3UlInC0jT
         5/pw==
X-Gm-Message-State: APjAAAVoQ5HBfNEV0NGd3LvU57/BF11BCdJjYUG3YCkxIdyA2hig2Jgz
        nh3ePErJZUL8vp2m/OA=
X-Google-Smtp-Source: APXvYqyeqVDU51a+FaSoc8tAJ77kFDuOblpvqnHpYD9VFZ4aYMhoWluJhhapN2qz1Vch3gDY2wmQtw==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr23997924wrr.306.1580154482938;
        Mon, 27 Jan 2020 11:48:02 -0800 (PST)
Received: from ?IPv6:2a02:810a:8c80:d2c:1d4:baf0:179f:5856? ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id o1sm22154240wrn.84.2020.01.27.11.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 11:48:02 -0800 (PST)
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net>
 <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
 <20200125200554.GC5519@coredump.intra.peff.net>
 <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
Message-ID: <dfcf0201-b634-2274-f041-a6ec4491825a@googlemail.com>
Date:   Mon, 27 Jan 2020 20:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Jeff,

On 27.01.20 08:00, Bert Wesarg wrote:
> On 25.01.20 21:05, Jeff King wrote:
>> On Sat, Jan 25, 2020 at 08:38:04AM +0100, Bert Wesarg wrote:
>>
>>> thanks for this pointer. My initial pointer was the help for push.default:
>>>
>>>   From git-config(1):
>>>
>>>         push.default
>>>             Defines the action git push should take if no refspec is explicitly
>>>             given. Different values are well-suited for specific workflows; for
>>>
>>> Thus I expected, that this takes effect, when just calling 'git push'.
>>
>> Yeah, I agree "explicitly given" is vague there. Perhaps the patch below
>> is worth doing?
>>
>>> What I actually want to achieve, is to track a remote branch with a
>>> different name locally, but 'git push' should nevertheless push to
>>> tracked remote branch.
>>>
>>> In my example above, befor adding the 'push.origin.push' refspec, rename the branch:
>>>
>>>      $ git branch -m local
>>>      $ git push --dry-run
>>>        To ../bare.git
>>>         * [new branch]      local -> local
>>>
>>> Is it possible that this pushes to the tracked branch automatically,
>>> and because I have multiple such branches, without the use of a push
>>> refspec.
>>
>> I think if push.default is set to "upstream" then it would do what you
>> want as long as you set the upstream of "local" (e.g., by doing "git
>> branch --set-upstream-to=origin/master local).
> 
> Thanks. This pushes only the current branch and honors the 'rename'.

while this works …

> 
>>
>> There's another way of doing this, which is when you have a "triangular"
>> flow: you might pull changes from origin/master into your local branch
>> X, but then push them elsewhere. Usually this would be pushing to a
>> branch named X on a different remote than origin (e.g., your public fork
>> of upstream on a server). And for that you can set branch.X.pushRemote.

… it does not play well if you have have both flows in one repository. And I do have both flows. I track the upstream 'master' in the local branch 'Y' and I have also a branch 'X' which is based on 'Y' but should be pushed to a different remote as branch 'Y'. I have configured 'branch.X.pushRemote = triangular' but with 'push.default' set to 'upstream' I get this when:

     $ git push triangular
     fatal: You are pushing to remote 'triangular', which is not the upstream of
     your current branch 'X', without telling me what to push
     to update which remote branch.

In this simple case, without a renaming, I would expect that 'git push' just works. May be just fallback to 'simple' if 'upstream' does not resolve to a fully qualified push?

Best,
Bert
