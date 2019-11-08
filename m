Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF781F454
	for <e@80x24.org>; Fri,  8 Nov 2019 14:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfKHO4t (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 09:56:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54030 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKHO4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 09:56:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id x4so6479680wmi.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aOWpzb76OE3CBzuCFzxUP7MsZK4sXLzJAQvnbKrDhJo=;
        b=UTkT2VDt/tGllIPKyHkvrl+HfsEkGHoaKSiiPTW+kJBw/2a9Tdgry1wf5mDoX9T4Iy
         A7K6w0Gw5PUvxbKlbhCcUfr9AypKoq0OwszfPKrx8skB/c8FMQqG+wPpVFXlboQ68mcZ
         fIY1kgCqCqViYvwlrqcZHm0gQxS2UvoEn8Tv7/P3RspZd46EGf9315ByYTfRrYQ/MGtW
         rXeyY63nENdoY4DHIaeQ/j+cr9OZ5Ce3SkdAt6P5Y9stb36ocYo2Aiy9a1mqXwGrNgOU
         pIZJOHwjuFgGTJqQmLSSRZqIN4sFtVV2nHyN7CWEAf2kCw5fsG/yVykEzstZ+jh379Ha
         KLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aOWpzb76OE3CBzuCFzxUP7MsZK4sXLzJAQvnbKrDhJo=;
        b=hr1yqOhRWUWRB8utKQ66OgWrnteddpUT7mfH/Vljf6pqM/W7hplxMyOHfa97pgg+bx
         KdqjzAV3zlPPiVxPMnbLWpWirGsMQbxwcKXIn+YfNppDojybBMJlSQTg9pJcksfJnJCL
         U1LZ7TYDAvheQevPCqbVnloAJhrZ8kQ8f2myN6sDdbSwqQqNMq0gLxYbyk2y3svHIamD
         v4uflbOBKMlo/PX+qoFhRtIyvY769GfDCvMcv8QRE6UBvsFUt6SViR+NUvFiN3gSzqN6
         q6EecE8WU2O+qhu/nu7RfoBW7NG9wISo2Vza/EN7FlxqD9eHE4l8t1mgVc8ns/64V0Ys
         /eBA==
X-Gm-Message-State: APjAAAV66Jul5/DfCBZyFRtjEYOt8mCikCot0rt9BdkTbEWZhDoymPs9
        GUE83WWLwb5nG+Tb2DFMDd4=
X-Google-Smtp-Source: APXvYqxdMD6WU6gh8BCNt1x/ij5F/cCyI/xFW5y71r+e90jzPTiI8k+y/dcM5h9krZ4L5/I1vaRiJg==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr7827549wmj.61.1573225005675;
        Fri, 08 Nov 2019 06:56:45 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-25-36.as13285.net. [92.22.25.36])
        by smtp.gmail.com with ESMTPSA id 200sm10059665wme.32.2019.11.08.06.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:56:45 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] Make "git branch -d" prune missing worktrees
 automatically.
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Peter Jones <pjones@redhat.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20191017162826.1064257-1-pjones@redhat.com>
 <20191017162826.1064257-2-pjones@redhat.com>
 <CAPig+cS6SzLdgmzffNkg72YSiDQ9eQRqTK12NsraKpGbkJFY_w@mail.gmail.com>
 <20191018194317.wvqphshpkfskvkyh@redhat.com>
 <CAPig+cTExu1+XyhUaq=yY09CAK6NN_BQViQETU8_fbGxu3jWzg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8c583f0c-c359-0fbe-2ffa-304db82b0a86@gmail.com>
Date:   Fri, 8 Nov 2019 14:56:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTExu1+XyhUaq=yY09CAK6NN_BQViQETU8_fbGxu3jWzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/11/2019 10:14, Eric Sunshine wrote:
> [cc:+duy]
> 
> On Fri, Oct 18, 2019 at 3:43 PM Peter Jones <pjones@redhat.com> wrote:
>> On Thu, Oct 17, 2019 at 01:28:09PM -0400, Eric Sunshine wrote:
>>> Echoing SEZDER's comment on patch 1/2, this behavior is an intentional
>>> design choice and safety feature of the worktree implementation since
>>> worktrees may exist on removable media or remote filesystems which
>>> might not always be mounted; hence, the presence of commands "git
>>> worktree prune" and "git worktree remove".
>>
>> Okay, I see that use case now - I hadn't realized there was an
>> intentional design decision here, and honestly that's anything but clear
>> from the *code*.
> 
> It can indeed sometimes be difficult to get a high-level functional
> overview by examining code in isolation. In this case, at least,
> git-worktree documentation tries to be clear about the "why" and "how"
> of the pruning behavior (which is not to say that the documentation --
> or the code -- can't be improved to communicate this better).
> 
>> It's surprising, for example, that my patches didn't break a single
>> test case.
> 
> Tests suites are never perfect, and an attempt to prune a dangling
> worktree by deleting a branch likely never occurred to the
> git-worktree implementer(s).
> 
>>> These minor implementation comments aside, before considering this
>>> patch series, it would be nice to see a compelling argument as to why
>>> this change of behavior, which undercuts a deliberate design decision,
>>> is really desirable.
>>
>> Okay, so just for clarity, when you say there's a deliberate design
>> decision, which behavior here are you talking about? If you mean making
>> "lock" work, I don't have any issue with that. If you mean not cleaning
>> up when we do other commands, then I don't see why that's a concern -
>> after all, that's exactly what "lock" is for.
> 
> To clarify, I'm talking about Duy's deliberate design decision to
> model git-worktree auto-pruning after Git's own garbage-collection
> behavior. That model includes, not only explicit locking, but a grace
> period before dangling worktree administrative files can be pruned
> automatically (see the gc.worktreePruneExpire configuration).
> 
> The point of git-worktree's grace period (just like git-gc's grace
> period) is to avoid deleting potentially precious information
> permanently. For instance, the worktree-local "index" file might have
> some changes staged but not yet committed. Under the existing model,
> those staged changes are immune from being accidentally deleted
> permanently until after the grace period expires or until they are
> thrown away deliberately (say, via "git worktree prune --expire=now").
> 
>> Assuming it is the "lock" behavior we're talking about, I don't think I
>> actually have any intention of breaking this design decision, just
>> making my workflow (without "lock") nag at me less for what seem like
>> pretty trivial issues.
> 
> The ability to lock a worktree is an extra safety measure built atop
> the grace period mechanism to provide a way to completely override
> auto-pruning; it is not meant as an alternate or replacement safety
> mechanism to the grace period, but instead augments it. So, a behavior
> change which respects only one of those safety mechanisms but not the
> other is likely flawed.
> 
> And, importantly, people may already be relying upon this behavior of
> having an automatic grace period -- without having to place a worktree
> lock manually -- so changing behavior arbitrarily could break existing
> workflows and result in data loss.
> 
>> I can easily accommodate "git worktree lock". What bugs me though, is
>> that using worktrees basically means I have to replace fairly regular
>> filesystem activities with worktree commands, and it doesn't seem to be
>> *necessary* in any way. And I'm going to forget. A lot.
>>
>> To me, there doesn't seem to be any reason these need to behave any different:
>>
>> $ git worktree add foo foo
>> $ rm -rf foo
>> vs
>> $ git worktree add foo foo
>> $ git worktree remove foo
>>
>> And in fact the only difference right now, aside from some very
>> minuscule storage requirements that haven't gotten cleaned up, is the
>> first one leaves an artifact that tells it to give me errors later until
>> I run "git worktree prune" myself.
> 
> I understand the pain point, but I also understand Duy's motivation
> for being very careful about pruning worktree administrative files
> automatically (so as to avoid data loss, such as changes already
> staged to a worktree-local "index" file). While the proposed change
> may address the pain point, it nevertheless creates the possibility of
> accidental loss which Duy was careful to avoid when designing worktree
> mechanics. Although annoying, the current behavior gives you the
> opportunity to avoid that accidental loss by forcing you to take
> deliberate action to remove the worktree administrative files.
> 
> Perhaps there is some way to address the pain point without breaking
> the fundamental promise made by git-worktree about being careful with
> worktree metadata[*], but the changes proposed by this patch series
> seem insufficient (even if the patch is reworked to respect worktree
> locking). I've cc:'d Duy in case he wants to chime in.

I agree that we want to preserve the safe guards in the worktree design. 
I wonder if detaching the HEAD of the missing worktree would solve the 
problem without losing data. In the case where something wants to 
checkout the same branch as the missing worktree then I think that is a 
good solution. I think it should be OK for branch deletion as well.

Best Wishes

Phillip

> [*] For instance, perhaps before auto-pruning, it could check whether
> the index is recording staged changes or conflict information, and
> only allow auto-pruning if the index is clean. *But* there may be
> other ways for information to be lost permanently (beyond a dirty
> "index") which don't occur to me at present, so this has to be
> considered carefully.
> 
