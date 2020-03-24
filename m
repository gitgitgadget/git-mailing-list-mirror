Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41208C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 17:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA65206F6
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 17:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vU0Hy4nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCXRCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:02:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35961 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgCXRCG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 13:02:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id l23so7630319otf.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yU0/0bybN9zSgrorWBt6UKxJIAlR52cPaqaPhutB0M8=;
        b=vU0Hy4nXFv6ywLJA9IwAYlfvZD+y2V7lRjz8k5FQzvB0k1xkXIkv6oUThFHEaaiuV/
         KDrPuC+BY6KS5gnzNzfGrK8ypb3ZW6U7fpt/CyD/qloI5maMcupgC58/dL/30Fwt0/DN
         1LS8DyMt5b8YfuOd7Aa6tNx9LiDkEX4yPDYt3JJa/eYEd35xVAUUK4ojKW1v2iXB9AcM
         /Zq7LRrKomm5dXC/6FgDKVBqwh/suH7p8CtuzTuTOU1oedYRsvw8lDBxgqS/Y/PfeWyw
         tZVKd8+rQD7fGrGdHqJtZXNmPPSZPn5kKZZd1AKnRwvYYAmXe5HEFSkCt5cDuXPL6BxR
         kXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yU0/0bybN9zSgrorWBt6UKxJIAlR52cPaqaPhutB0M8=;
        b=MidOmvp6eUj6yfsudMYng7+GLa69RO9msO8sF+kGyC7sSGMHgcj2N6xKHQex7osbgu
         cM0N8TL+gHNMmfT7SlLqxnhj57Jt9Kn1W2FTR1c9uRS7F1s5nJZ/su4ChvUwdE/Twq2o
         TUaP5WUN7kzZSrRdM6muvCAjEktR8HRxiHkifTCd8q7NkjIYAFj8WvQL6M0ATRRe++6a
         Dt9dUus2PQ9+FsMbQRrsrd3tAjUW64Lm5UN0QSKt8u+fvCoyYdGnVTZXQM+opjAiJu/E
         q9lsct9YWzPuUODSHKZEQQT4EgI9X13dCcpH8HRpnX7AOH1DMOtzS/eCXShsnaxg52UF
         mUqw==
X-Gm-Message-State: ANhLgQ3MBAiGJsOacrEJaPXhc5ktKFKDFjow+BswFVGLeT67rdnv06Ww
        C/8zOwMUZwePgw9dw3ifpxGo8nMDnLg=
X-Google-Smtp-Source: ADFU+vsFk7hoomRrvAf2f1eXHWusHAnibbzGqye+g5cFQMN+UYBbaeDqEkNcIHgYwkrzkLXOx50yTw==
X-Received: by 2002:a05:6830:3090:: with SMTP id f16mr21930681ots.211.1585069325386;
        Tue, 24 Mar 2020 10:02:05 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 1sm2522411otd.31.2020.03.24.10.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 10:02:04 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
 <59c04216-8dd9-cbbf-a869-a65ed8ca6e0a@gmail.com>
 <CABPp-BFf-A_a=_02gP_=kBFmQmpM8udFZyrq17Co_u+QWURFKw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <068ff330-5ace-32b6-e930-db5bd7480bec@gmail.com>
Date:   Tue, 24 Mar 2020 13:02:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFf-A_a=_02gP_=kBFmQmpM8udFZyrq17Co_u+QWURFKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2020 12:16 PM, Elijah Newren wrote:
> On Tue, Mar 24, 2020 at 8:12 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/24/2020 3:15 AM, Elijah Newren wrote:
>>> Hi Matheus,
>>>
>>> On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
> ...
>>>> Something I'm not entirely sure in this patch is how we implement the
>>>> mechanism to honor sparsity for the `git grep <commit-ish>` case (which
>>>> is treated in the grep_tree() function). Currently, the patch looks for
>>>> an index entry that matches the path, and then checks its skip_worktree
>>>
>>> As you discuss below, checking the index is both wrong _and_ costly.
>>
>> I'm not sure why checking the index is _wrong_, but I agree about the
>> performance cost.
> 
> Let's say there are two directories, dir1 and dir2.  Over time, there
> have existed a total of six files:
>    dir1/{a,b,c}
>    dir2/{d,e,f}
> At the current time, there are only four files in the index:
>    dir1/{a,b}
>    dir2/{d,e}
> And the user has done a `git sparse-checkout set dir2` and then at
> some point later run `git grep OTHERCOMMIT foobar`.  What happens?
> 
> Well, since we're in a sparse checkout, we should only search the
> relevant paths within OTHERCOMMIT for "foobar".  Let's say we attempt
> to figure out the "relevant paths" using the index.  We can tell that
> dir1/a and dir2/a are marked as SKIP_WORKTREE so we don't search them.
> dir1/c is untracked -- what do we do with it?  Include it?  Exclude
> it?  Carrying on with the other files, dir2/d and dir2/e are tracked
> and !SKIP_WORKTREE so we search them.  dir2/f is untracked -- what do
> we do with it?  Include it?  Exclude it?
> 
> We're left without the necessary information to tell whether we should
> search OTHERCOMMIT's dir1/c and dir2/f if we consult the index.  Any
> decision we make is going to be wrong for one of the two paths.
> 
> If we instead do not attempt to consult the index (which corresponds
> to a version close to HEAD) in order to ask questions about the
> completely different OTHERCOMMIT, but instead use the sparsity
> patterns to query whether those files/directories are interesting,
> then we get the right answer.  The index can only be consulted for the
> right answer in the case of --cached; in all other cases (including
> OTHERCOMMIT == HEAD), we should use the sparsity patterns.  In fact,
> we could also use the sparsity patterns in the case of --cached, it's
> just that for that one particular case consulting the index will also
> give the right answer.

Thanks! This helps a lot.

-Stolee

