Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594831FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdFSRzV (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:55:21 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35351 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdFSRzU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:55:20 -0400
Received: by mail-pg0-f50.google.com with SMTP id 132so17698646pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=R/BpAd3MBpIs0+fOuxn4PXfwKmfBw6ZhVFQIsdGKfuA=;
        b=iSva5LTSWkQIlCUP1JlJciZTLpPDyOYTRKoC9wMuTFtas28mqeQOnDgufB7fNeBP20
         28OywEgCrRGO5EZW3AnFYnl1USdGogKAzEIwcgb6GckyAIgFaHQlD6CXxUbCNG6OA13z
         vyRGzPGrnGqnAox60PVIXi+6IJbevq26SQFpOUWRVuk86Hhvw/GW4GCdA4MVvKFrQQW5
         GlhPUoUQIAmrbpObQR/8kVqLzDUAAPUZj4p1QFbccZ/xw8rclWcwCzOoZmHcriYJj+PG
         u7dRLK8PeTFIsbw1Ew5d4upm9zgmuIiLIXSfiGD8aVerOG6HEcfdLtqvMfMtdhSMden1
         toiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=R/BpAd3MBpIs0+fOuxn4PXfwKmfBw6ZhVFQIsdGKfuA=;
        b=eGBVrporl4RKGAi1efRCzRL1huYhTpaTJZfR1fUuSpweHhf67/vcEMikUcS3vSJ29Y
         PNh+P/SxG5Ggo7LWZQQWGkH2n9/L/YhrWzA2KS+8VRtUJAp09V51N1haPVyfd9kXFCY7
         Lc1C4PvC0mrEBXeFyDcBJ0+xQtwVVMiOCTbCn1GIY/p6+3ohwzUuvv6taSvgGvvX7/3w
         cFsfQgBpQdR38IOpTCXFQpSIEacTSJ7i767rnr1vZPqfNRAPjoBb0vsu4XtrDVg6wLKj
         4q5koFtPGPuBZFxQ5iNFbrIp9/CYpqZkOAroLjgUQanVjgjhbwpDPwCiYow/q3HjzS4V
         Vi5Q==
X-Gm-Message-State: AKS2vOxs7kOUwN5F+HRAeqqaCeyUuBZ8iD0/Ja/3OlocpxSrwAzxyJdW
        iX97GAESVhSxlA==
X-Received: by 10.84.217.78 with SMTP id e14mr6571276plj.268.1497894909319;
        Mon, 19 Jun 2017 10:55:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id r77sm21432639pfg.95.2017.06.19.10.55.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 10:55:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Subject: Re: Restoring detached HEADs after Git operations
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
        <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
        <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
Date:   Mon, 19 Jun 2017 10:55:07 -0700
In-Reply-To: <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 19 Jun 2017 09:37:01 -0700")
Message-ID: <xmqqefufuakk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jun 19, 2017 at 2:52 AM, Patrick Lehmann
> <Patrick.Lehmann@plc2.de> wrote:
>> Hello Lars,
>>
>> for your questions:
>>> If there are multiple branches with the same hash then your script would pick the first one. Can you imagine a situation where this would be a problem?
>>
>> I can't think of a good solution to resolve it automatically. Maybe a script could print that there are multiple possibilities and it choose the first branch in the list.
>>
>>
>>> Plus, you are looking only at local branches. Wouldn't it make sense to look at remote branches, too?
>>
>> This is also related to restoring tags. If we go this way, we should have this priority list:
>> - local branches
>> - remote branches
>
> For remote branches you would create a local branch of the same name
> (if such a branch would not exist, possibly setting it up to track that remote
> branch)?
>
>> - tags
>
> as said in the other email and similar to remote branches, we'd not want to have
> HEAD pointing to them directly but somehow have a local branch.

Let's step back a bit.  We detach the HEAD for a good reason, no?
Why is it a good idea to move them back on to a branch picked among
multiple ones that all happen to be pointing at the same commit?

The user may build on a history of a submodule, and then may push
the result out to a particular branch at the other side; that is
when being on a named branch in the submodule becomes useful, but
even then I do not think randomly picking one branch and be on it
is a good thing to do.

I would understand the workflow would go more like so:

 - You do something at the superproject (e.g. create a new branch X
   from an existing commit and check it out), which results in
   submodules' HEADs getting detached at the commits bound to the
   superproject's tree.

 - Because you want to make changes to both submodules and the
   superproject in a consistent way, you'd want to commit changes to
   all of these repositories and the push the result out in an
   atomic way.

 - Hence you tell "Hey, Git, I want all the submodules that I
   modified to be on branch X" from the superproject.

   - This may succeed in a submodule where X is a new name, or the
     current tip of branch X is an ancestor of the detached HEAD.

   - This may fail in a submodule where there is branch X that does
     not want to move to the detached HEAD's state.  In this latter
     case, the user needs to deal with the situation (perhaps the
     old X is expendable; perhaps the HEAD's commit may need to be
     merged to old X; perhaps there are other cases).

though.
