Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A2C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351161AbiCOSwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCOSwl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 14:52:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7245882A
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:51:29 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lr15-20020a17090b4b8f00b001c646e432baso1538902pjb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HcVRYGiScxF/1RiC1npMHhFPN3/LvoaOzIPQs1nXyp4=;
        b=QS5FwFKXH6yw25o4eGUNv5FYtHV1vX8UE1tgewVRRb4rl6kQHvBbAUzsVJ9dzkO4DW
         F4AGGJfc1N6cksjRXQYy4pxBc0kx66tmgwOVArTsnN2xSbNXyoOPEMz1XXdOmsxP7lay
         /3I6qQTOxZxJiOV+MjpQVXTH3AarqciTfVHqF2Yx6eKvXvBjEBdqatwgDI0fvcHnAbpc
         tX3Y87EhAH0K8UHl1l4nvpZ66IKB2EpJnTPDlyoUQnI4LFIoBVUaM6bcfPQFf0+iljiV
         pl/MYKXsnZpPzdcQr5lsPej7/x4SRr6QeMO7Y+qfTIVyLgZHSKYG+XpzTJGhriDp3+yW
         EAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HcVRYGiScxF/1RiC1npMHhFPN3/LvoaOzIPQs1nXyp4=;
        b=4ODar8BPMNz3AUscCSqdkK3hnCA+7U3Q7ZppU+reXqMIzBL0c6SFlEVVNwrezk165/
         o0Wbh+bXHJE73lkLG3SJOEHDemFWWw8d0S+MVjpzkFOywF/s4fQgusshaSh8TNbdb6Za
         2LiyX5sMEjNMPsFGinFAu0NK7r5TJUoiTKPk+f4zYFFWZkc5uxf/0kndLf3B1yXxgH8L
         2jC6BKyOX03D6l06MsTekHUgV+iJgGzrIBu6IQJTrGt6uD25jW0En4wP2tv+Vw82IfgR
         B6gvYo/35iIKDA7teACXSMGxO/LDy9GsQ3X3bnTkMXDqON1/FokaJ9m9CVzpe+V62OoV
         MAyw==
X-Gm-Message-State: AOAM5314Xu2gpWZIVujvdYNkKgXDl4AuznloBj+yR3yC+PHq7ycAAaPJ
        d5VjfnWr+ShJi762ljN7BCLvc8Pukxk/QQ==
X-Google-Smtp-Source: ABdhPJz7AfdN3BN6cJT/spwl/p11pUqki6JA8xWPvAd4Rs3huRUQY02J+xSDBrvjhFkhSIZGSIhsUzAatVCZpw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:10c5:b0:4f7:3bef:7fdc with SMTP
 id d5-20020a056a0010c500b004f73bef7fdcmr29872476pfu.23.1647370288550; Tue, 15
 Mar 2022 11:51:28 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:51:26 -0700
In-Reply-To: <d8783660-1487-1899-19bf-10654801ea0a@kdbg.org>
Message-Id: <kl6lee33xd5d.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com> <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
 <d8783660-1487-1899-19bf-10654801ea0a@kdbg.org>
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
From:   Glen Choo <chooglen@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.03.22 um 18:20 schrieb Glen Choo:
>> xing zhi jiang <a97410985new@gmail.com> writes:
>>> diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-exports-function
>>> new file mode 100644
>>> index 0000000000..63b79f5991
>>> --- /dev/null
>>> +++ b/t/t4018/javascript-exports-function
>>> @@ -0,0 +1,4 @@
>>> +exports.RIGHT = function(document) {
>>> +    
>>> +    return ChangeMe; >>> +}
>> 
>> I don't think we should include 'exports.foo = bar'. To my knowledge,
>> this is _not_ a standard ES feature, but rather the CommonJS module
>> system popularized by Node.js [1] and other frameworks. To confirm this,
>> I searched the ES spec and did not find any reference to exports.* [2].
>> 
>> Even if we wanted to support nonstandard 'language features' (and this
>> label is tenuous at best, CommonJS is not trying to replace the ES
>> modules standard AFAIK), Node.js is also starting to support ES modules,
>> so I don't think this is a good long term direction for Git.
>
> It is not a priority to model hunk header regular expressions after some
> standard and to ignore stuff that is outside the standard. The goal is
> to make them useful in a majority of cases. If there exists a noticable
> chunk of code that uses non-standard constructs, then that is worth
> being supported.

Interesting, I'll take note. I'm still personally not keen on supporting
CommonJS-only patterns when we are purportedly trying to show diffs for
JavaScript, but if we think this fits the style, I'm happy to oblige.

So the question becomes "Is there a significant amount of code that uses
this pattern?" Probably - this is a fairly common pattern in Node.js
after all. But in my experience,

 module.exports.RIGHT = function(document) {
     
     return ChangeMe;
 }

is even more common. The difference between 'module.exports' and
'exports' isn't worth going into (StackOverflow has all the answers, for
the curious), but if we're taking the approach of supporting CommonJS,
I'd like to be consistent and also support 'module.exports', i.e.
perhaps change:

  "^(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"

to something like:

  "^((module.)?exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
