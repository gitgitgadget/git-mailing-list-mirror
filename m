Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD691F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 18:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfJYSFk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 14:05:40 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54519 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbfJYSFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 14:05:39 -0400
X-Originating-IP: 1.186.12.52
Received: from localhost (unknown [1.186.12.52])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CEB501C0002;
        Fri, 25 Oct 2019 18:05:35 +0000 (UTC)
Date:   Fri, 25 Oct 2019 23:35:33 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: .git/binary
Message-ID: <20191025180533.ed6du6weja2wfx6c@yadavpratyush.com>
References: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
 <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
 <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/19 07:32PM, без имени wrote:
> > Or were you thinking of some other meaning for "files stored in a single (current) state"?
> 
> It means that new versions of files located in `.git / binary` will completely replace old versions in history, and therefore will be in a single (current) state in history. What used to be another version of this file should be ignored (very useful for PNG, JPEG, PDF).
 
Something like this might have trouble working with checkouts of past 
commits, which is a major reason (at least for me) for using a version 
control system.

Say you have two files marked as "binary" A.png and B.png at commit X. 
Some part of your code references those files. Now let's say you make a 
new commit Y where you remove A.png. You also remove all references to 
A.png in your code since you don't need it anymore. In your suggested 
system, we drop A.png.

Now if you checkout the commit X, A.png does not exist. This means your 
code won't compile or work properly, defeating the purpose of version 
control.

You can argue that "how about we keep deleted files in history, but for 
the files that are modified, we don't keep their history, just the 
latest version?".

For that argument, consider the following: say you have a commit X which 
has A.png. A.png has the dimensions 200x200. You make a new commit Y 
where you make A.png larger, say 400x400.

Now if you checkout X, A.png is still 400x400 since we didn't track its 
history. And so, the behaviour of your software at that point might also 
change, defeating the purpose of version control.

So instead, I'd point you to git-lfs [0]. I haven't personally used the 
tool ever, but it _might_ help in your use case.

[0] https://git-lfs.github.com/

-- 
Regards,
Pratyush Yadav
