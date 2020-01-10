Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C73C32771
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 02:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CF92072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 02:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgAJCLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:11:07 -0500
Received: from pug.qqx.org ([50.116.43.67]:47896 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbgAJCLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 21:11:07 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 21:11:07 EST
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 588CA1E009; Thu,  9 Jan 2020 21:05:29 -0500 (EST)
Date:   Thu, 9 Jan 2020 21:05:29 -0500
From:   Aaron Schrab <aaron@schrab.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 05/15] bugreport: add uname info
Message-ID: <20200110020529.GB1216@pug.qqx.org>
Mail-Followup-To: Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-6-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191213004312.169753-6-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 16:43 -0800 12 Dec 2019, Emily Shaffer <emilyshaffer@google.com> wrote:
>The contents of uname() can give us some insight into what sort of
>system the user is running on, and help us replicate their setup if need
>be. The domainname field is not guaranteed to be available, so don't
>collect it.

The manpage on Linux says that it's a GNU extension; on Mac OS it isn't 
mentioned. So it would be more accurate to say that it's known not to be 
available on many systems rather than just not being guaranteed.

Besides that I think in some cases it may be considered sensitive 
information, so another reason to not include it. Perhaps even worthy of 
being mentioned as the primary reason.

>+			    uname_info.nodename,

I think in some cases this could also be considered as sensitive 
information, and is unlikely to help in diagnosing problems.  So I'd 
move to exclude this as well.
