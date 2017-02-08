Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA651FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdBHXTv (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:19:51 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33939 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdBHXTu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:19:50 -0500
Received: by mail-pf0-f196.google.com with SMTP id y143so12388132pfb.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 15:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=A7OFXucWDojfz0F+7e4Wz9rStAOBssw7W1OcSS00iy8=;
        b=caZXa19bKwX4SwYAgVNo1Eb7cBCe/q2gqlaLJGcwioDqSzVS77ZepTap1gEID2UE6g
         UdXuxqDohdoQVo9GaU8yTD2XWQFmFIqc83mgvCu3T9V/Gvjq2lNbyRcan9pJJOiInMqp
         RuzNlXNyrbqDS5rriHa9niy7rwEUGSz8liBN/LKoRmwHJoQCzfpmTZURZ76VBIGILe7J
         WlHAvp2SL9vTjcN4N5rQ8iLgcGc/9CqdnDzt43chYe3OGQke87pBUrKyk33b+mQoLB6H
         WRIBNBtpDhlRS2w2Q+CDKp8DQtd4vCfsy0/+7JKeNOu7g8V1hbKUjln8/+o+d+j8GC1r
         TDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=A7OFXucWDojfz0F+7e4Wz9rStAOBssw7W1OcSS00iy8=;
        b=S4PMJZEZ47AzMKafidOXB7/aFLpVhS+uIy68TkoeYGZzGmDOuwuWbexq4dkMRpfV+P
         UWpIjnBza7i+b64usmr1aRDzdOucRict9YLt8JQDwVkp+Y9kDDCxCTU/XKcjYW1O2+Hp
         92tOpmsProBZnOcsgsvVc8BdlKMBRHK6blSyyYJ0sZaE0ZAg6PfaPoh0SVICnho7gI1V
         pFKAZN0G1t5tgmT0XAgVH6YDnJcjNJrKoZsHJ7B5+9NQ0oheSkwewpBSQtT6h+gHDQVN
         EFHscoCCZjOse3jO/uBb60856AmqGFLDCICy5Bm3LIPUaeRjgd4Z77W7s4e1EKJNEr/+
         0WCw==
X-Gm-Message-State: AMke39lD/+sN5rC2bPVyMW//6IcJqPXNNh3/7vxQPcEgfjJmaqgNFOVst1gPmF+oJicNeg==
X-Received: by 10.84.218.5 with SMTP id q5mr112931pli.80.1486595990074;
        Wed, 08 Feb 2017 15:19:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id x2sm22936197pfa.71.2017.02.08.15.19.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 15:19:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs from another worktree
References: <20170208113144.8201-1-pclouds@gmail.com>
        <20170208113144.8201-3-pclouds@gmail.com>
        <CAGZ79kZk1Chq1R-anz0RC+0GDEubGm5kEQOsy5bz9zwCYEi9nw@mail.gmail.com>
Date:   Wed, 08 Feb 2017 15:19:48 -0800
In-Reply-To: <CAGZ79kZk1Chq1R-anz0RC+0GDEubGm5kEQOsy5bz9zwCYEi9nw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Feb 2017 11:50:40 -0800")
Message-ID: <xmqqvasktgmj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 8, 2017 at 3:31 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> (**) At this point, we may want to rename refs *_submodule API to
>> something more neutral, maybe s/_submodule/_remote/
>
> I agree on (**), except that I am not sure if /_remote/ is a better name,
> because there is already a concept of a "remote" as well as
> "remote-tracking" in Git. (Usually it is not reachable on the same
> FS, but resides on another machine).

I agree with you that the concept of remote is quite detached from
the concept of wt and submodule whose refs need to be peeked at from
the local repository.  After all, "remote" tracking branches are
part of local repository's refs.

> My gut reaction would be to s/submodule/alternative/ here,
> but we also have a thing called alternates already.

... and I tend to think that is far closer a concept.  You borrow
objects from your alternate object store, and that alternate object
store may have its own set of refs you would need to peek when you
are computing reachability from refs.

Also don't we already enumerate such refs that pin objects in the
alternate object store when doing object transfer negotiation in
order to send ".have" entries for their tips?  What API do we use to
do that, I wonder.
