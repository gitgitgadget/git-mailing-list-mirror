Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786D5201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdEOWn1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:43:27 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32774 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdEOWn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:43:26 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so69973311pfh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EDG/XSHhkgbomc2SkAu6VfhLuGqrYyxI4B9SRGm+drw=;
        b=Uhn5icWK6BRy4KryO0mKakPcDzN2e8uMV7739dXBV/6FQA1Ru9oU+9Fu6ujSPI8eUS
         KPj9D3pi+CfzJbRsWnvoNAYCKWXdf6JeXfcqIPmZqTKOD/lJIRTNhzkdacqXjiDfRiFg
         nW8ZhkY5eo0k7oND+9nNX8i8KIV5vToH2gMUS+mf6m6JxdRK4qb2YJtUzAJeZ9Qld19s
         mA5gIXtOj8AWsccshoMOqvdofns0onFDLcpCj/rwOYswmRqQe7Ai8kWYclInIZiagFP1
         WY7gYk48xwk9HT6vRXgMg4vChhHfAQSzmNM59BoCvG5dOgv1jBBvzncBB8fxjJFHrWoH
         Q0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EDG/XSHhkgbomc2SkAu6VfhLuGqrYyxI4B9SRGm+drw=;
        b=RxAoR2S2sRrBVDCFHPtHHv/9GRhQBxwTDoA6V9z2JTjq09wVORi5o6ogczgd06VTtX
         KwsHxhSmSBBbIf7rWHiNGq0xXQydKR4iaQc+tNm+66TK9yXSpRrQ7dsAedM93PRtAYWV
         d5Q1ncGDJMC4ywzqgMZ2BIoAWK2gAFMT9w8VK1XdhCo+1Mh0p/sIK4dd0jNIOjpso/4k
         Nj/DWuuRrTx67X0LUdIAXjcAGQI1fwFWwZo5jfGqgaoI666hEQtFmCSpS8W3dKGBv1U/
         tUcHsmDE0IGb/uLgaL/h0+LoHseW+1CTixt1/jTIKVTyHYDz8OpdFvVTdPZYl+37Qqsp
         B8mA==
X-Gm-Message-State: AODbwcAGvGyk4dmtlgQUTjNVSf761znzIDEaKMmbq9WaBLCCbhgZO7bv
        x9kyHpIU4KPlIg==
X-Received: by 10.99.130.73 with SMTP id w70mr8684968pgd.119.1494888206135;
        Mon, 15 May 2017 15:43:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id l85sm21205645pfg.123.2017.05.15.15.43.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 15:43:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "taylor\, david" <David.Taylor@dell.com>
Subject: Re: git worktrees must exist even if locked
References: <63F1AEE13FAE864586D589C671A6E18B0D6B8C@MX203CL03.corp.emc.com>
Date:   Tue, 16 May 2017 07:43:23 +0900
In-Reply-To: <63F1AEE13FAE864586D589C671A6E18B0D6B8C@MX203CL03.corp.emc.com>
        (david taylor's message of "Mon, 15 May 2017 13:58:19 +0000")
Message-ID: <xmqqshk568s4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"taylor, david" <David.Taylor@dell.com> writes:

> The original report was against Git v2.12.2.  I have since tried v2.12.3, v2.13.0,
> and the next branch.  All exhibit the same symptoms.
>
> Even if you ignore the original scenario for creating the problem, if I do a 'rm -rf' or 'mv'
> of a tree that contains within it worktrees, that should not break the use of Git with
> worktrees that live elsewhere nor commands that don't require a repository.

Duy, any ideas?

Thanks.

>
>> -----Original Message-----
>> From: taylor, david
>> Sent: Wednesday, May 10, 2017 4:25 PM
>> To: git@vger.kernel.org
>> Subject: git worktrees must exist even if locked
>> 
>> The Git documentation in describing worktrees says that one reason
>> why you might want to lock a worktree is to prevent it from being pruned
>> if it is on a removable media that isn't currently mounted.
>> 
>> So, my expectation was that if the worktree is inaccessible (and locked), Git
>> would pretend that there is no worktree by that name.
>> 
>> In reality, if you have such a worktree, Git gets an error.
>> 
>>  On local systems, /home is local to a machine; home directories are
>> elsewhere.
>> Home directories are NFS mounted; /home is not.
>> 
>> . create a repository in /my/home/dir/my-repo.git with
>> 
>>     git clone --bare <some arguments>
>> 
>> . create an empty directory /home/somedir/worktree-tests
>> 
>> . use 'git worktree add' to add /home/somedir/worktree-tests/<branch-
>> name>
>>   as a worktree on branch <branch-name>.  It gets populated with the correct
>>   content.
>> 
>> . lock it using'git worktree lock'
>> 
>> So far, so good.  Now, go to a different computer -- one on which
>> /home/somedir/worktree-tests does not exist (and therefore
>> /home/somedir/worktree-tests/<branch-name> does not exist).
>> 
>> . cd /my/home/dir/my-repo.git
>> 
>> Now, try issuing Git commands.  Many will fail.
>> 
>>   git fetch ==> fails:
>> 
>>   fatal: Invalid path '/home/somedir/worktree-tests': No such file or directory
>> 
>>   git status ==> fails -- same error as above
>>   git help worktree ==> fails -- same error as above
