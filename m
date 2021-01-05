Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9426DC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E36022CBE
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 17:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbhAERMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 12:12:54 -0500
Received: from w1.tutanota.de ([81.3.6.162]:50048 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbhAERMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 12:12:53 -0500
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id ACD5EFA0F3D
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1609866726;
        s=s1; d=tuta.io;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=8RdP7cQA3GrHBJ5Hr1em4CGPVBF1K41GFVDZCuTWGXE=;
        b=CWyDnSGoeDtq8SuZHfBy1XMg77gMkzIYXDB8J5PVs5HU2to2FVHIOHzHzUQNeKat
        P3/TziD7pBmo0gmXXgk3fBXfJNsN3Z5SHUdnjrbbX4HfycfRDJ1HPy1OuoWmV/uKoBg
        z2kxQ8AMFP8Y5kjtggJkWBUuZfGCKEGxe85DBpce92MWg0hwHqmq/NgQq5AemhnW3gl
        dGsOpeNK8BQXhzN5/6UnqpiVmXiYG+uWPqVm0myqSJB6A3iazh70yE8UG2EpI3/vwa2
        s6adc16GYTQwEidxIeGiQtSJUiPC8bJhch4/KEaangJVV/0D2V32jjGv0O9qIFckNi7
        W78clUwIcg==
Date:   Tue, 5 Jan 2021 18:12:06 +0100 (CET)
From:   stratus@tuta.io
To:     Git <git@vger.kernel.org>
Message-ID: <MQIXBhC--3-2@tuta.io>
Subject: Re: git tag truncates tag list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, sorry, they are there, it is only the sort order placing the newest ones further up in the list. Using page down to go down the long list of numerous screenfuls, the missing ones were not shown on the final screen so I didn't see them, and it ended at 5.9-rc8 instead of going to 5.10 and 5.11 as I had expected. I thought perhaps there was some limit on the number of tags shown, but couldn't find any reference to a limit searching online, and less itself can display long man pages without problem.

git --no-pager tag
shows the same thing
echo $LESS
echo $GIT_PAGER
git config core.pager
git config pager.tag

All return nothing.

echo $PAGER
less
Changing PAGER to more uses more for git tag instead, but gives the same result. So this was indeed using less as the pager.

Thank you for the helpful answers, I've only used git with smaller repos before and hadn't encountered that effect previously.
