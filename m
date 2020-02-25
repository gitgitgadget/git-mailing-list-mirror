Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC1C35DF8
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A972072D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 07:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBYHKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:10:54 -0500
Received: from dd26228.kasserver.com ([85.13.145.71]:57070 "EHLO
        dd26228.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBYHKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 02:10:54 -0500
Received: from [192.168.43.161] (ip-109-41-195-164.web.vodafone.de [109.41.195.164])
        by dd26228.kasserver.com (Postfix) with ESMTPSA id 50D05EE;
        Tue, 25 Feb 2020 08:10:51 +0100 (CET)
Subject: Re: Bug: 'git ls-files' doesn't work on submodule in post-commit hook
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <ede4b653-35bf-d163-c27d-d23602dbd726@green-sparklet.de>
 <20200225011320.GL6462@camp.crustytoothpaste.net>
From:   Stefan <git.kernel.org_20@green-sparklet.de>
Message-ID: <539bac71-a4af-f96c-ae08-e8fa659c5dd1@green-sparklet.de>
Date:   Tue, 25 Feb 2020 08:10:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200225011320.GL6462@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

I checked it by replacing the printf line in my example with this one:
printf '#!/bin/bash\necho GIT_DIR is: $GIT_DIR\ncd git-submodulerepo\necho Git says my files are:\ngit ls-files\necho ---------------\necho Filesystem says my files are:\nls -w1\necho ---------------\n' > .git/hooks/post-commit

In both hooks, GIT_DIR is empty, so this shouldn't be the problem.
Thanks anyways.

On 2020-02-25 02:13, brian m. carlson wrote:
> Can you check to see if the GIT_DIR environment variable is set in your
> hook?  In some cases, Git sets various GIT_* environment variables when
> calling a hook or command, and if you want another repository, you'd
> need to unset those values.
> 
